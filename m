Received: from eggs.gnu.org ([2001:4830:134:3::10]:54554)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fxWFL-00080h-4D
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 07:45:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fxWFH-00037w-SX
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 07:45:18 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38546 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fxWFH-00035F-Lw
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 07:45:15 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 698148576C
	for <qemu-devel@nongnu.org>; Wed,  5 Sep 2018 11:45:14 +0000 (UTC)
Date: Wed, 5 Sep 2018 12:45:07 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180905114506.GB2625@work-vm>
References: <20180903043149.4076-1-peterx@redhat.com>
	<20180903043149.4076-5-peterx@redhat.com>
	<87a7oz9g1y.fsf@dusky.pond.sub.org> <20180903101606.GB14774@xz-x1>
	<87k1o2671t.fsf@dusky.pond.sub.org>
	<55829207-b0f7-0869-6ec7-90bc2fb67e3a@redhat.com>
	<20180903144116.GH14377@redhat.com>
	<87y3chydeo.fsf@dusky.pond.sub.org>
	<20180904082301.GB22349@redhat.com>
	<87k1o1v61u.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <87k1o1v61u.fsf@dusky.pond.sub.org>
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
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org

* Markus Armbruster (armbru@redhat.com) wrote:
> Daniel P. Berrang=E9 <berrange@redhat.com> writes:
>=20
> > On Tue, Sep 04, 2018 at 08:39:27AM +0200, Markus Armbruster wrote:
> >> Daniel P. Berrang=E9 <berrange@redhat.com> writes:
> >>=20
> >> > On Mon, Sep 03, 2018 at 09:30:52AM -0500, Eric Blake wrote:
> >> >> On 09/03/2018 08:31 AM, Markus Armbruster wrote:

> >> >> I guess when we are designing what libvirt should do, and decidin=
g WHEN it
> >> >> should send OOB commands, we have the luxury of designing libvirt=
 to enforce
> >> >> how many in-flight in-band commands it will ever have pending at =
once
> >> >> (whether the current 'at most 1', or even if we make it more para=
llel to 'at
> >> >> most 7'), so that we can still be ensured that the OOB command wi=
ll be
> >> >> processed without being stuck in the queue of suspended in-band c=
ommands.
> >> >> If we never send more than one in-band at a time, then it's not a=
 concern
> >> >> how deep the qemu queue is; but if we do want libvirt to start pa=
rallel
> >> >> in-band commands, then you are right that having a way to learn t=
he qemu
> >> >> queue depth is programmatically more precise than just guessing t=
he maximum
> >> >> depth.  But it's also hard to argue we need that complexity if we=
 don't have
> >> >> an immediate use envisioned for it.
> >>=20
> >> True.
> >>=20
> >> Options for the initial interface:
> >>=20
> >> (1) Provide means for the client to determine the queue length limit
> >>     (introspection or configuration).  Clients that need the monitor=
y to
> >>     remain available for out-of-band commands can keep limit - 1 in-=
band
> >>     commands in flight.
> >>=20
> >> (2) Make the queue length limit part of the documented interface.
> >>     Clients that need the monitory to remain available for out-of-ba=
nd
> >>     commands can keep limit - 1 in-band commands in flight.  We can
> >>     increase the limit later, but not decrease it.  We can also swit=
ch
> >>     to (1) as needed.
> >>=20
> >> (3) Treat the queue length limit as implementation detail (but tacit=
ly
> >>     assume its at least 2, since less makes no sense[*]).  Clients t=
hat
> >>     need the monitory to remain available for out-of-band commands
> >>     cannot safely keep more than one in-band command in flight.  We =
can
> >>     switch to (2) or (1) as needed.
> >>=20
> >> Opinions?
> >
> > If you did (3), effectively apps will be behaving as if you had done
> > (2) with a documented queue limit of 2, so why not just do (2) right
> > away.
>=20
> Yup, that's what I thought, too.
>=20
> I append a proposed replacement for the patch to qmp-spec.txt.  It
> assumes the current queue size 8.  That value is of course open to
> debate.

Could you return that size in the response to qmp_capabilities
at the start of the connection?

>=20
> diff --git a/docs/interop/qmp-spec.txt b/docs/interop/qmp-spec.txt
> index 67e44a8120..1fc6a507e2 100644
> --- a/docs/interop/qmp-spec.txt
> +++ b/docs/interop/qmp-spec.txt
> @@ -130,9 +130,11 @@ to pass "id" with out-of-band commands.  Passing i=
t with all commands
>  is recommended for clients that accept capability "oob".
> =20
>  If the client sends in-band commands faster than the server can
> -execute them, the server will stop reading the requests from the QMP
> -channel until the request queue length is reduced to an acceptable
> -range.
> +execute them, the server's queue will fill up, and the server will
> +stop reading commands from the QMP channel until the queue has space
> +again.  Clients that need the server to remain responsive to
> +out-of-band commands should avoid filling up the queue by limiting the
> +number of in-band commands in flight to seven.

If I understand what you're saying then this is a shared limit; i.e.
if you've got two QMP connections then you have to be aware of how many
the other connection is queuing, which is tricky.

Dave

>  Only a few commands support out-of-band execution.  The ones that do
>  have "allow-oob": true in output of query-qmp-schema.
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
