Received: from eggs.gnu.org ([2001:4830:134:3::10]:34240)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dKNK7-0002Ue-Jr
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 07:15:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dKNK2-0000RD-7V
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 07:15:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56954)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1dKNK1-0000Qu-QO
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 07:15:50 -0400
Date: Mon, 12 Jun 2017 13:15:43 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170612111543.GC5232@noname.redhat.com>
References: <20170608182113.nmxnvus26vplg5du@postretch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170608182113.nmxnvus26vplg5du@postretch>
Subject: Re: [Qemu-devel] [Proposal] I/O throttling through new -object
 interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>, qemu-devel <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Alberto Garcia <berto@igalia.com>

Am 08.06.2017 um 20:21 hat Manos Pitsidianakis geschrieben:
> In continuation of the discussion at [0], here follows a proposal
> for a new ThrottleGroup object defined through QOM.
> 
> Throttle groups are currently defined when instantiating a drive in
> the command line,, eg.  -drive
> file=foo.qcow2,throttling.iops-total=100,throttling.group=bar
> and also on QMP with the 'block_set_io_throttle' command, eg:
> 
>   { "execute": "block_set_io_throttle",
>     "arguments": {
>        "device": "virtio0",
>        "iops": 100,
>        "iops_rd": 0,
>        "iops_wr": 0,
>        "bps": 0,
>        "bps_rd": 0,
>        "bps_wr": 0
>     }
>   }
> 
> As part of my GSoC project, IO throttling is moved to a block filter
> driver, which means multiple filter nodes sharing ThrottleGroup
> instances, and also, chaining filter nodes. The old interface will
> be retained as much as possible. By defining ThrottleGroups with QOM
> the following interface can be used:
>    -drive file=foo.qcow2,throttling.group=bar \
>    -object throttle-group,iops-total=100,id=bar
> which will be equivalent to the current command above.

Looks okay. This is a "mixed" configuration, where modern -object
throtte-group is used, but still legacy -drive. We'll keep supporting
this at least for compatibility, but possibly also as a convenience
feature. Whether we consider it just a legacy feature or a convenience
feature for manual users determines whether new functionality needs to
be supported with it.

libvirt is expected to go all the way and use -blockdev driver=throttle
explicitly together with -object.

> The 'block_set_io_throttle' command can be extended with a "group"
> argument, that when defined instead of "device", will find and edit
> the object in question. Users can hotplug ThrottleGroups with
> object-add in QMP/HMP, then attach drives to a throttle group (ie
> adding a filter node in the drive path that points to that throttle
> group) with an 'attach-throttle' and detach with 'detach-throttle',
> each taking the drive and throttle group name as arguments.

Let's not do more automagic graph manipulations than are strictly needed
to maintain compatibility with the existing interfaces. We will have to
automatically insert or remove new nodes if 'block_set_io_throttle' is
used, but let's not extend it. It only makes things complicated.

If people are using new features, they will be using new interfaces and
we can make them use more natural syntax. For example, we can expect
that they create throttle nodes manually (management tools always, human
users at least for more complicated cases). What we may want is to
update the settings of a throttle node at runtime (though inserting a
new filter and then removing the old one could do the trick as well).

If we want to change the settings of a throttle node, then I think the
appropriate low-level interface is bdrv_reopen(). We need to figure out
whether we can expose a full bdrv_reopen() on QMP or whether we need
more specific commands. I'd prefer finally doing the "real thing" rather
than adding more and more special-case commands to update nodes.

> An alternative (but uglier) approach would be to use
> 'block_set_io_throttle' for this as well. Something that's also
> sound is a 'block_set_throttle_groups' that takes a list of groups
> and a drive as arguments. I think the last could be best if the
> relevant function does not become complex.
> All this means that existing configuration will not be redefined
> everytime the object is referenced unless each limit is specified
> explicitly, like it was mentioned in the previous discussion.
> 
> Regarding 'query-block'. This case is complicated by the fact that
> it would be possible for a drive to have many nodes, thus the values
> printed by 'query-block' might be inaccurate if they only report one
> of the node configurations.  The current approach is to report only
> the first filter node in the BDS tree. A user with advanced
> throttling configurations might have no need for this command.

I maintain my stance that I express off-list, which is that query-block
should _only_ display limits that belong to the throttle node that was
internally created for satisfying a 'block_set_io_throttle' request on a
BlockBackend.

If the user created a throttle node themselves, they already know about
it and can inspect the throttle node directly.

> I'm not certain about this, since this could be handled internally
> by an application, but it might be useful to have queries to list
> all the throttle groups that affect a drive, and to list all the
> drives in a throttle group. Maybe defining the drives as a
> ThrottleGroup QOM property will take care of the latter and also
> attaching/detaching drives to a group through the property
> getter/setter. Thoughts?

I'm not sure if you aren't taking a somewhat simplified view here. Let's
look at a still relatively simple setup where we have a local qcow2 file
with a backing file that is accessed over the network.

    virtio-blk
        |
        |
        v
   BlockBackend
        |
        |
        v     (bs->backing)
      qcow2  ---------------->  raw
        |                        |
        |(bs->file)              |(bs->file)
        v                        v
    file-posix                  http

You have four arrows below BlockBackend, and a filter node (or multiple)
could be inserted on each of them, resulting in different behaviour. All
of them arguably affect the drive (virtio-blk), but does a list where
all of them are treated the same really make sense?

I can make things a bit more interesting still by adding an NBD server
just for fun. Let's expose the raw backing file there, we always wanted
to have a HTTP-to-NBD bridge.

    virtio-blk               NBD server
        |                        |
        |                        |
        v                        v
   BlockBackend             BlockBackend
        |                        |
        |                        |
        v     (bs->backing)      |
      qcow2  ---------------->  raw
        |                        |
        |(bs->file)              |(bs->file)
        v                        v
    file-posix                  http

Now a throttle node between raw and http isn't clearly related to just
virtio-blk any more, it throttles requests that come from two sources.
Would you still include it in the list?

What if we additionally insert a throttle node below the NBD server's
BlockBackend? It will indirectly affect virtio-blk by giving it a higher
share of the bandwith because the NBD server uses less of it. Is this a
node that your list considers as affecting virtio-blk?


We could probably think of more complicated setups, but I think we
should really leave such decisions to the user. If they inserted the
throttle nodes, they can as well inspect them one by one. The only case
where the user can't do this is if they don't know that the nodes exist,
i.e. when they are using legacy interfaces.


While we're talking about the graph, did you consider changes to the
graph yet that are done by other operations? For example, if you have a
simple setup with throttling today, this looks like:

    BlockBackend (+ throttling) --> raw --> file-posix

If you take a snapshot, you get a new qcow2 node inserted that has the
old top-level node as its backing file:

    BlockBackend (+ throttling) --> qcow2 --> file-posix
                                      |
                                      +--> raw --> file-posix

However, if the throttling is done by a filter node, if we're not
careful, we'll end up with the following (which is not a transparent
implementation of the old semantics):

    BlockBackend --> qcow2 --> file-posix
                       |
                       +--> throttle --> raw --> file-posix

The throttle node affects only the backing file now, but not the new
top-level node. With manually created filter nodes we may need to
provide a way so that the QMP command tells where in the tree the
snapshot is actually taken. With automatically created ones, we need to
make sure that they always stay on top.

Similar problems arise when block jobs manipulate the graph. For
example, think of a commit block job, which will remove the topmost node
from the backing file chain. We don't want it to remove the throttling
filter together with the qcow2 node. (Or do we? It might be something
that needs to be configurable.)

We also have several QMP that currently default to working on the
topmost image of the chain. Some of them may actually want to work on
the topmost node that isn't an automatically inserted filter.


I hope this helps you understand why I keep saying that automatic
insertion/removal of filter nodes is tricky and we should do it as
little as we possibly can.

Kevin
