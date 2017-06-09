Received: from eggs.gnu.org ([2001:4830:134:3::10]:36764)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dJKCC-0006SR-Pz
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 09:43:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dJKC7-0001xJ-Tf
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 09:43:24 -0400
Received: from fanzine.igalia.com ([91.117.99.155]:52547)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <berto@igalia.com>) id 1dJKC7-0001Ug-Hd
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 09:43:19 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20170608182113.nmxnvus26vplg5du@postretch>
References: <20170608182113.nmxnvus26vplg5du@postretch>
Date: Fri, 09 Jun 2017 15:42:41 +0200
Message-ID: <w51k24ll1ke.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
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
To: Manos Pitsidianakis <el13635@mail.ntua.gr>, qemu-devel <qemu-devel@nongnu.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>

Hey Manos, thanks for your proposal and for the good work :)

On Thu 08 Jun 2017 08:21:13 PM CEST, Manos Pitsidianakis wrote:

> As part of my GSoC project, IO throttling is moved to a block filter 
> driver, which means multiple filter nodes sharing ThrottleGroup 
> instances, and also, chaining filter nodes. The old interface will be 
> retained as much as possible. By defining ThrottleGroups with QOM the 
> following interface can be used:
>     -drive file=foo.qcow2,throttling.group=bar \
>     -object throttle-group,iops-total=100,id=bar

It should be --object, and I guess the name would be throttling-group?
But otherwise the interface looks good to me.

> 'block_set_io_throttle' command can be extended with a "group"
> argument, that when defined instead of "device", will find and edit
> the object in question.

Note that block_set_io_throttle() already has a 'group' argument. Its
current semantics are:

   - bps or iops != 0   -> set the I/O limits of a throttling group. The
                           selected device is moved to that group if it
                           wasn't there yet.

   - bps and iops == 0  -> remove a device from a throttling group
                           without touching that group's I/O limits.

where 'device' is mandatory and 'group' defaults to the value of
'device' if unset.

If I get it right, what you propose is that 'device' is optional and in
that case 'group' is mandatory and the command updates the throttling
group parameters.

Note that you can do that already if you select a device that is already
in the group. These new semantics would allow modifying a group that is
not being used by any block device.

I'm not a big fan of overloading block_set_io_throttle() even more, but
this proposal does actually sound fine.

> Users can hotplug ThrottleGroups with object-add in QMP/HMP, then
> attach drives to a throttle group (ie adding a filter node in the
> drive path that points to that throttle group) with an
> 'attach-throttle' and detach with 'detach-throttle', each taking the
> drive and throttle group name as arguments. An alternative (but
> uglier) approach would be to use 'block_set_io_throttle' for this as
> well.

Yeah I agree that the block_set_io_throttle() approach would be uglier.

> Something that's also sound is a 'block_set_throttle_groups' that
> takes a list of groups and a drive as arguments.

Would that simply be a foreach(g, groups) { attach(device, g); } ?

> Regarding 'query-block'. This case is complicated by the fact that it
> would be possible for a drive to have many nodes, thus the values
> printed by 'query-block' might be inaccurate if they only report one
> of the node configurations.  The current approach is to report only
> the first filter node in the BDS tree. A user with advanced throttling
> configurations might have no need for this command.

I guess the user can use 'query-block' and walk the backing chain
looking for throttling filter nodes?

Berto
