Received: from eggs.gnu.org ([2001:4830:134:3::10]:36746)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fx4zw-0005Wn-UX
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 02:39:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fx4zt-0006vQ-Q8
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 02:39:36 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57762 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fx4zt-0006uz-Ir
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 02:39:33 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BECC940241C5
	for <qemu-devel@nongnu.org>; Tue,  4 Sep 2018 06:39:32 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180903043149.4076-1-peterx@redhat.com>
	<20180903043149.4076-5-peterx@redhat.com>
	<87a7oz9g1y.fsf@dusky.pond.sub.org> <20180903101606.GB14774@xz-x1>
	<87k1o2671t.fsf@dusky.pond.sub.org>
	<55829207-b0f7-0869-6ec7-90bc2fb67e3a@redhat.com>
	<20180903144116.GH14377@redhat.com>
Date: Tue, 04 Sep 2018 08:39:27 +0200
In-Reply-To: <20180903144116.GH14377@redhat.com> ("Daniel P. =?utf-8?Q?Ber?=
	=?utf-8?Q?rang=C3=A9=22's?=
	message of "Mon, 3 Sep 2018 15:41:16 +0100")
Message-ID: <87y3chydeo.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v7 4/7] qapi: remove COMMAND_DROPPED event
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Mon, Sep 03, 2018 at 09:30:52AM -0500, Eric Blake wrote:
>> On 09/03/2018 08:31 AM, Markus Armbruster wrote:
>>=20
>> > Example:
>> >=20
>> >      client sends in-band command #1
>> >      QEMU reads and queues
>> >      QEMU dequeues in-band command #1
>> >      in-band command #1 starts executing, but it's slooow
>> >      client sends in-band command #2
>> >      QEMU reads and queues
>> >      ...
>> >      client sends in-band command #8
>> >      QEMU reads, queues and suspends the monitor
>> >      client sends out-of-band command
>> > --> time passes...
>> >      in-band command #1 completes, QEMU sends reply
>> >      QEMU dequeues in-band command #2, resumes the monitor
>> >      in-band command #2 starts executing
>> >      QEMU reads and executes out-of-band command
>> >      out-of-band command completes, QEMU sends reply
>> >      in-band command #2 completes, QEMU sends reply
>> >      ... same for remaining in-band commands ...
>> >=20
>> > The out-of-band command gets stuck behind the in-band commands.
>> >=20
>> > The client can avoid this by managing the flow of in-band commands: ha=
ve
>> > no more than 7 in flight, so the monitor never gets suspended.
>> >=20
>> > This is a potentially useful thing to do for clients, isn't it?
>> >=20
>> > Eric, Daniel, is it something libvirt would do?
>>=20
>> Right now, libvirt serializes commands - it never sends a QMP command un=
til
>> the previous command's response has been processed. But that may not help
>> much, since libvirt does not send OOB commands.
>
> Note that is not merely due to the QMP monitor restriction either.
>
> Libvirt serializes all its public APIs that can change state of a running
> domain.  It usually aims to allow read-only APIs to be run in parallel wi=
th
> APIs that change state.

Makes sense.  State changes are complex enough without concurrency.
Even permitting just concurrent queries can add non-trivial complexity.

However, pipelineing !=3D concurrency.  "Serializing" as I understand it
implies no concurrency, it doesn't imply no pipelining.

Mind, I'm not telling you to pipeline, I'm just trying to understand the
constraints.

> The exception to the rule right now are some of the migration APIs which
> we allow to be invoked to manage the migration process.=20

Can you give an example?

>> I guess when we are designing what libvirt should do, and deciding WHEN =
it
>> should send OOB commands, we have the luxury of designing libvirt to enf=
orce
>> how many in-flight in-band commands it will ever have pending at once
>> (whether the current 'at most 1', or even if we make it more parallel to=
 'at
>> most 7'), so that we can still be ensured that the OOB command will be
>> processed without being stuck in the queue of suspended in-band commands.
>> If we never send more than one in-band at a time, then it's not a concern
>> how deep the qemu queue is; but if we do want libvirt to start parallel
>> in-band commands, then you are right that having a way to learn the qemu
>> queue depth is programmatically more precise than just guessing the maxi=
mum
>> depth.  But it's also hard to argue we need that complexity if we don't =
have
>> an immediate use envisioned for it.

True.

Options for the initial interface:

(1) Provide means for the client to determine the queue length limit
    (introspection or configuration).  Clients that need the monitory to
    remain available for out-of-band commands can keep limit - 1 in-band
    commands in flight.

(2) Make the queue length limit part of the documented interface.
    Clients that need the monitory to remain available for out-of-band
    commands can keep limit - 1 in-band commands in flight.  We can
    increase the limit later, but not decrease it.  We can also switch
    to (1) as needed.

(3) Treat the queue length limit as implementation detail (but tacitly
    assume its at least 2, since less makes no sense[*]).  Clients that
    need the monitory to remain available for out-of-band commands
    cannot safely keep more than one in-band command in flight.  We can
    switch to (2) or (1) as needed.

Opinions?

> In terms of what libvirt would want to parallelize, I think it is reasona=
ble
> to consider any of the query-XXXX commands desirable. Other stuff is like=
ly
> to remain serialized from libvirt's side.

QEMU doesn't care whether it queues in-band query commands or other
in-band commands.


[*] With a queue length of 1, the monitor suspends on receipt of an
in-band command, and resumes after it completes.  This renders
out-of-band commands useless: there is no way an out-of-band command can
overtake an in-band command.
