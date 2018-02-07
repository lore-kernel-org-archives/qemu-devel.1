Received: from eggs.gnu.org ([2001:4830:134:3::10]:40939)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ejJwg-0003cu-VJ
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 02:15:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ejJwf-0003x1-No
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 02:15:06 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <7f7c46fe-c6e1-a597-c6d1-5212abc12212@virtuozzo.com>
	<d338d282-f264-3d39-2240-0cd5dbf0294e@redhat.com>
	<4e97de9a-bcdd-5e5d-275f-e6cac9473f0d@virtuozzo.com>
	<79e5851b-f35e-23ea-4842-cc3b1d1e30ee@virtuozzo.com>
	<1e2fd96e-5d07-3c52-33df-cf31490eb6ca@redhat.com>
	<eccba06f-3a5f-7926-7fb5-ce56f01e94c7@virtuozzo.com>
	<1298bc3d-c2bd-6fd5-5d3d-dabcae434874@redhat.com>
	<2e145d8b-855f-9060-1b81-feb515067293@virtuozzo.com>
	<20180126150511.GG2610@work-vm>
	<ac366ae3-d7e0-db65-d5ee-d276a42320da@virtuozzo.com>
	<20180206183836.GF2462@work-vm>
Date: Wed, 07 Feb 2018 08:14:52 +0100
In-Reply-To: <20180206183836.GF2462@work-vm> (David Alan Gilbert's message of
	"Tue, 6 Feb 2018 18:38:37 +0000")
Message-ID: <87tvut5l03.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 3/6] qapi: add nbd-server-remove
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, kwolf@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com, Nikolay Shirokovskiy <nshirokovskiy@virtuozzo.com>, den@openvz.org, pbonzini@redhat.com

"Dr. David Alan Gilbert" <dgilbert@redhat.com> writes:

> * Vladimir Sementsov-Ogievskiy (vsementsov@virtuozzo.com) wrote:
>> 26.01.2018 18:05, Dr. David Alan Gilbert wrote:
>> > * Vladimir Sementsov-Ogievskiy (vsementsov@virtuozzo.com) wrote:
[...]
>> > > most of commands, ported to hmp are done in same style: they just call
>> > > corresponding qmp command.

HMP commands *should* call the QMP command to do the actual work.  That
way, we *know* all the functionality is available in QMP, and HMP is
consistent with it.

Sometimes, calling helpers shared with QMP is more convenient, and
that's okay, but then you have to think about QMP completeness and
HMP/QMP consistency.

The only exception are HMP commands that don't make sense in QMP, such
as @cpu.

>> > > Isn't it better to provide common interface for calling qmp commands through
>> > > HMP monitor, to never
>> > > create hmp versions of new commands? they will be available automatically.
>> > It would be nice to do that, but they're not that consistent in how they
>> > convert parameters and options, but I occasionally wonder if we could
>> > automate more of it.
>> 
>> 
>> What about allowing some new syntax in hmp, directly mapped to qmp?
>> 
>> something like
>> 
>> >>> blockdev-add id disk driver qcow2 cache {writeback true direct true} aio
>> native discard unmap file {driver file filename /tmp/somedisk}
>> 
>> ?
>
> Hmm, I don't particularly find that easy to read either; however the
> actual block device specification for HMP should be the same as what we
> pass on the command line, so we only have to worry about any extra
> things that are part of blockdev_add.
> (I'm sure we can find a way of making the one we pass on the commandline
> more readable as well, there's so much duplication).

Good points.

QMP syntax is different for a good reason: it serves machines rather
than humans.

Both HMP and command line serve the same humans, yet the syntax they
wrap around common functionality is different.  Sad waste of developer
time, sad waste of user brain power.  The former could perhaps be
reduced with better tooling, say having QAPI generate the details.

If you have QAPI generate HMP and command line from the exact same
definitions as QMP, you get what Vladimir wants: different interfaces to
the exact same functionality, without additional coding.

Note that the needs of humans and machines differ in more ways than just
syntax.  For instance, humans appreciate convenience features to save
typing.  In a machine interface, they'd add unnecessary and
inappropriate complexity.  Adding convenience is a good reason for
actually designing the HMP interface, rather than copying the QMP one
blindly.
