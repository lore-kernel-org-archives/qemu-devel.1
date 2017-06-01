Received: from eggs.gnu.org ([2001:4830:134:3::10]:42596)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dGPwk-0007lL-6Z
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 09:15:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dGPwh-0002R5-09
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 09:15:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39307)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dGPwg-0002QZ-Mw
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 09:15:22 -0400
Date: Thu, 1 Jun 2017 14:15:17 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170601131517.GA23154@stefanha-x1.localdomain>
References: <20170530100736.3338-1-roman.penyaev@profitbricks.com>
	<20170531130609.GE16733@stefanha-x1.localdomain>
	<CAJrWOzD-bVte_S7D6BGmDQ_VGqpwu5660oHMz7J2OJK0iPcvAA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GvXjxJ+pjyke8COw"
Content-Disposition: inline
In-Reply-To: <CAJrWOzD-bVte_S7D6BGmDQ_VGqpwu5660oHMz7J2OJK0iPcvAA@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/1] coroutine-lock: do not touch
 coroutine after another one has been entered
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Roman Penyaev <roman.penyaev@profitbricks.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>


--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 31, 2017 at 03:23:25PM +0200, Roman Penyaev wrote:
> On Wed, May 31, 2017 at 3:06 PM, Stefan Hajnoczi <stefanha@gmail.com> wro=
te:
> > On Tue, May 30, 2017 at 12:07:36PM +0200, Roman Pen wrote:
> >> diff --git a/util/qemu-coroutine-lock.c b/util/qemu-coroutine-lock.c
> >> index 6328eed26bc6..d589d8c66d5e 100644
> >> --- a/util/qemu-coroutine-lock.c
> >> +++ b/util/qemu-coroutine-lock.c
> >> @@ -77,10 +77,20 @@ void coroutine_fn qemu_co_queue_wait(CoQueue *queu=
e, CoMutex *mutex)
> >>  void qemu_co_queue_run_restart(Coroutine *co)
> >>  {
> >>      Coroutine *next;
> >> +    QSIMPLEQ_HEAD(, Coroutine) tmp_queue_wakeup =3D
> >> +        QSIMPLEQ_HEAD_INITIALIZER(tmp_queue_wakeup);
> >>
> >>      trace_qemu_co_queue_run_restart(co);
> >> -    while ((next =3D QSIMPLEQ_FIRST(&co->co_queue_wakeup))) {
> >> -        QSIMPLEQ_REMOVE_HEAD(&co->co_queue_wakeup, co_queue_next);
> >> +
> >> +    /* Because "co" has yielded, any coroutine that we wakeup can res=
ume it.
> >> +     * If this happens and "co" terminates, co->co_queue_wakeup becom=
es
> >> +     * invalid memory.  Therefore, use a temporary queue and do not t=
ouch
> >> +     * the "co" coroutine as soon as you enter another one.
> >> +     */
> >> +    QSIMPLEQ_CONCAT(&tmp_queue_wakeup, &co->co_queue_wakeup);
> >> +
> >> +    while ((next =3D QSIMPLEQ_FIRST(&tmp_queue_wakeup))) {
> >> +        QSIMPLEQ_REMOVE_HEAD(&tmp_queue_wakeup, co_queue_next);
> >>          qemu_coroutine_enter(next);
> >>      }
> >>  }
> >
> > What happens if co remains alive and qemu_coroutine_enter(next) causes
> > additional coroutines to add themselves to co->co_queue_wakeup?
>=20
> Yeah, I thought about it.  But according to my understanding the only
> path where you add something to the tail of a queue is:
>=20
> void aio_co_enter(AioContext *ctx, struct Coroutine *co)
> {
> ...
>    if (qemu_in_coroutine()) {
>         Coroutine *self =3D qemu_coroutine_self();
>         assert(self !=3D co);
>         QSIMPLEQ_INSERT_TAIL(&self->co_queue_wakeup, co,
> co_queue_next); <<<< HERE
>=20
> So you should be in *that* coroutine to chain other coroutines.
> That means that caller of your 'co' will be responsible to complete
> what it has in the list.  Something like that:
>=20
>=20
> co1 YIELDED,
> foreach co in co1.queue{co2}
>    enter(co) -------------->  co2 does something and
>                               eventually enter(co1):  -----> co1 does
> something and
>                                                              add co4
> to the queue
>                                                              terminates
>                                                       <-----
>                               co2 iterates over the queue of co1 and
>                                foreach co in co1.queue{co4}
>=20
>=20
> Sorry, the explanation is totally crap, but the key is:
> caller is responsible for cleaning the queue no matter what
> happens.  Sounds sane?

Yes, that makes sense.  A comment in the code would be helpful.

Stefan

--GvXjxJ+pjyke8COw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZMBNlAAoJEJykq7OBq3PIL9oIAKuPR8klXSvMSwP/+H2wspR0
1DSiO6DNBVgGMllQz9oa74NjkZERapo5uJA/qHjZZc0z8amlXgDU6Q5Y/yqOFTu5
64GHQALBxUzQ5tkuXR7kEf+ndBAfWtwcSe+uRWbNS3bTAAaPSZN/DRuyrsyqlibD
opEpH8tAnIdQAUnwv2QaR5lnRECNepoBg2CMgfuhaBhEbdKTIe2JxaN0d1XqXkRf
lMXifDax0cvUNZ8N+SEGLeibmPdfo3BXqTp+8q6zbW5jPr95DgN8wCdpMuwBkF4F
od7Y4YYNeBzyrzqnqbTpux3OMBcSUNgx8+E5ytdVvDsHBobpc+VD6QMSSRXvcHQ=
=m1Fb
-----END PGP SIGNATURE-----

--GvXjxJ+pjyke8COw--
