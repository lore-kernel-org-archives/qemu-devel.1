Received: from eggs.gnu.org ([2001:4830:134:3::10]:48526)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dQ77z-0006mX-Tm
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 03:11:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dQ77y-0007Qg-LJ
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 03:11:07 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170627163145.GC4792@noname.redhat.com>
	<71a641e8-4701-58bf-29c5-090f30d59d91@redhat.com>
Date: Wed, 28 Jun 2017 09:10:54 +0200
In-Reply-To: <71a641e8-4701-58bf-29c5-090f30d59d91@redhat.com> (Eric Blake's
	message of "Tue, 27 Jun 2017 11:46:10 -0500")
Message-ID: <87mv8sd1tt.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [RFC] QMP design: Fixing query-block and friends
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org, stefanha@redhat.com, mreitz@redhat.com

Eric Blake <eblake@redhat.com> writes:

> On 06/27/2017 11:31 AM, Kevin Wolf wrote:
>> Hi,
>> 
>> I haven't really liked query-block for a long time, but now that
>> blockdev-add and -blockdev have settled, it might finally be the time to
>> actually do something about it. In fact, if used together with these
>> modern interfaces, our query commands are simply broken, so we have to
>> fix something.
>
> Agreed.
>
[Analysis of what we have; it's a sad mess...]
>> 
>> However, it appears to me that I dislike so many thing about our current
>> query commands that I'm tempted to say: Throw it all away and start
>> over.
>
> I'm somewhat leaning this direction as well. We have to keep the old
> commands for a while longer (if we don't want to break existing
> clients), but libvirt has definitely felt some of the pain of how many
> commands and parsing are required in tandem to reconstruct which BDS
> node name to use for setting threshold events.
>
>> 
>> If that's what we're going to do, I think I can figure out something
>> nice for block nodes. That shouldn't be too hard. The only question
>> would be whether we want a command to query one node or whether we would
>> keep returning all of them.
>
> The age-old filtering question. It's also plausible to have a single
> command, with an optional argument, and which always returns an array:
> the full array if the argument was omitted, or an array of one matching
> the argument when one was provided.  Adding filtering is an easy patch
> on top once it is proven to make life easier for a client, and I'm okay
> with a first approach that does not filter.

The graph may change.  Querying node by node would have to cope with
changes somehow, which I'd expect to be complex and fragile.  I think we
really need a way to get a complete, consistent graph.  So let's
implement that first.  If we still want server-side filtering once
that's done, we can add some on top.

As usual, I doubt we really need server-side filtering, and I dislike
the interface complexity it brings.

>> I am, however, a bit less confident about BBs. As I said above, I
>> consider them part of the qdev devices.

They weren't meant to be when I created them, but I guess it's what they
evolved to be.

>>                                         As far as I know, there is no
>> high-level infrastructure to query runtime state of devices and qdev
>> properties are supposed to be read-only. Maybe non-qdev QOM properties
>> can be used somehow?

Since qdev properties are implemented as QOM property, there are no
non-qdev QOM properties.

>>                      But QOM isn't really nice to use as you need to
>> query each property individually.

qom-get returns 'any'.  A read-only property with a complex value is
already possible.  But it's awkward when you also want to get or set
parts of the complex value.

Perhaps we could provide a way to get whole containers in addition to
single properties.  Would that do?

>> Another option would be to have a QMP command that takes a qdev ID of a
>> block device and queries its BB. Or maybe it should stay like
>> query-block and return an array of all of them, but include the qdev
>> device name. Actually, maybe query-block can stay as it contains only
>> two fields that are useless in the new world.
>
> Being able to query all the devices (with their BB's, and only a name
> reference to the top-level BDS in use by the BB), separately from being
> able to query all BDS, seems like a reasonable thing.  After all,
> sometimes you care about what the guest sees (what devices have a BB),
> and sometimes you care about what the host is exposing (what BDS are in
> use).

No argument.  But let's not focus narrowly on block devices, or even
devices.  If QOM "isn't really nice" for block devices, it probably
isn't nice for lots of other things.  If we can address that at the QOM
level, we should.

>> I think this has become long enough now, so any opinions? On anything I
>> said above, but preferably also about what a new interface should look
>> like?
>
> Our existing interface is definitely awkward, with lots of redundancy in
> some places and missing information in others, and a new interface does
> seem like we can do better at designing it right up front rather than
> bolting on yet more information to the existing queries (which results
> in that much more noise to churn through to get to the desired information).

Replacing an interface that could be evolved to serve is a mistake.

Not replacing an interface when it has reached its design limits is also
a mistake.

I normally advise against the first mistake.  But in this case, I think
we have to avoid the second.  The interface has evolved into a confusing
mess.  The gap between how the interface presents the block layer and
how it actually works has become too large.  Sufficiently sophisticated
clients have to bridge the gap somehow, and that's painful.
