Received: from eggs.gnu.org ([2001:4830:134:3::10]:33630)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fx6cD-0003Z9-UZ
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 04:23:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fx6c9-0004Sk-Uv
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 04:23:13 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58284 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fx6c9-0004SP-OA
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 04:23:09 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4C3474023461
	for <qemu-devel@nongnu.org>; Tue,  4 Sep 2018 08:23:09 +0000 (UTC)
Date: Tue, 4 Sep 2018 09:23:01 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180904082301.GB22349@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180903043149.4076-1-peterx@redhat.com>
	<20180903043149.4076-5-peterx@redhat.com>
	<87a7oz9g1y.fsf@dusky.pond.sub.org> <20180903101606.GB14774@xz-x1>
	<87k1o2671t.fsf@dusky.pond.sub.org>
	<55829207-b0f7-0869-6ec7-90bc2fb67e3a@redhat.com>
	<20180903144116.GH14377@redhat.com>
	<87y3chydeo.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87y3chydeo.fsf@dusky.pond.sub.org>
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
To: Markus Armbruster <armbru@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org

On Tue, Sep 04, 2018 at 08:39:27AM +0200, Markus Armbruster wrote:
> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>=20
> > On Mon, Sep 03, 2018 at 09:30:52AM -0500, Eric Blake wrote:
> >> On 09/03/2018 08:31 AM, Markus Armbruster wrote:
> >>=20
> >> > Example:
> >> >=20
> >> >      client sends in-band command #1
> >> >      QEMU reads and queues
> >> >      QEMU dequeues in-band command #1
> >> >      in-band command #1 starts executing, but it's slooow
> >> >      client sends in-band command #2
> >> >      QEMU reads and queues
> >> >      ...
> >> >      client sends in-band command #8
> >> >      QEMU reads, queues and suspends the monitor
> >> >      client sends out-of-band command
> >> > --> time passes...
> >> >      in-band command #1 completes, QEMU sends reply
> >> >      QEMU dequeues in-band command #2, resumes the monitor
> >> >      in-band command #2 starts executing
> >> >      QEMU reads and executes out-of-band command
> >> >      out-of-band command completes, QEMU sends reply
> >> >      in-band command #2 completes, QEMU sends reply
> >> >      ... same for remaining in-band commands ...
> >> >=20
> >> > The out-of-band command gets stuck behind the in-band commands.
> >> >=20
> >> > The client can avoid this by managing the flow of in-band commands=
: have
> >> > no more than 7 in flight, so the monitor never gets suspended.
> >> >=20
> >> > This is a potentially useful thing to do for clients, isn't it?
> >> >=20
> >> > Eric, Daniel, is it something libvirt would do?
> >>=20
> >> Right now, libvirt serializes commands - it never sends a QMP comman=
d until
> >> the previous command's response has been processed. But that may not=
 help
> >> much, since libvirt does not send OOB commands.
> >
> > Note that is not merely due to the QMP monitor restriction either.
> >
> > Libvirt serializes all its public APIs that can change state of a run=
ning
> > domain.  It usually aims to allow read-only APIs to be run in paralle=
l with
> > APIs that change state.
>=20
> Makes sense.  State changes are complex enough without concurrency.
> Even permitting just concurrent queries can add non-trivial complexity.
>=20
> However, pipelineing !=3D concurrency.  "Serializing" as I understand i=
t
> implies no concurrency, it doesn't imply no pipelining.
>=20
> Mind, I'm not telling you to pipeline, I'm just trying to understand th=
e
> constraints.

I can only think of one place where libvirt would be likely to use
pipelining. We have an API that is used for collecting bulk stats
of many types, across al VMs. We do a couple of QMP queries per-VM,
so we could pipeline those queries. Even then, I'm not sure we would
go to the bother, as the bigger burden for performance is that we
round-robin across every VM. A bigger bang for our buck would be
to parallelize across VMs, but still serialize within VMs, as that
would have less complexity.

> > The exception to the rule right now are some of the migration APIs wh=
ich
> > we allow to be invoked to manage the migration process.=20
>=20
> Can you give an example?

We have a job that triggers the migration and sits in a thread
monitoring its progress.

While this is happening we allow a few other API calls such as
"pause", and of course things like switching to post-copy mode,
changin max downtime, etc. None of this gets in to parallel
or pipelined monitor execution though.

> >> I guess when we are designing what libvirt should do, and deciding W=
HEN it
> >> should send OOB commands, we have the luxury of designing libvirt to=
 enforce
> >> how many in-flight in-band commands it will ever have pending at onc=
e
> >> (whether the current 'at most 1', or even if we make it more paralle=
l to 'at
> >> most 7'), so that we can still be ensured that the OOB command will =
be
> >> processed without being stuck in the queue of suspended in-band comm=
ands.
> >> If we never send more than one in-band at a time, then it's not a co=
ncern
> >> how deep the qemu queue is; but if we do want libvirt to start paral=
lel
> >> in-band commands, then you are right that having a way to learn the =
qemu
> >> queue depth is programmatically more precise than just guessing the =
maximum
> >> depth.  But it's also hard to argue we need that complexity if we do=
n't have
> >> an immediate use envisioned for it.
>=20
> True.
>=20
> Options for the initial interface:
>=20
> (1) Provide means for the client to determine the queue length limit
>     (introspection or configuration).  Clients that need the monitory t=
o
>     remain available for out-of-band commands can keep limit - 1 in-ban=
d
>     commands in flight.
>=20
> (2) Make the queue length limit part of the documented interface.
>     Clients that need the monitory to remain available for out-of-band
>     commands can keep limit - 1 in-band commands in flight.  We can
>     increase the limit later, but not decrease it.  We can also switch
>     to (1) as needed.
>=20
> (3) Treat the queue length limit as implementation detail (but tacitly
>     assume its at least 2, since less makes no sense[*]).  Clients that
>     need the monitory to remain available for out-of-band commands
>     cannot safely keep more than one in-band command in flight.  We can
>     switch to (2) or (1) as needed.
>=20
> Opinions?

If you did (3), effectively apps will be behaving as if you had done
(2) with a documented queue limit of 2, so why not just do (2) right
away.


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
