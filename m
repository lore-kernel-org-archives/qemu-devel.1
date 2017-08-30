Received: from eggs.gnu.org ([2001:4830:134:3::10]:53822)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1dmxns-0002bl-TX
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 03:52:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1dmxnr-0002kf-OT
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 03:52:48 -0400
Received: from hera.aquilenet.fr ([2a01:474::1]:50117)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1dmxnr-0002kO-Ca
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 03:52:47 -0400
Date: Wed, 30 Aug 2017 09:52:43 +0200
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20170830075243.xo6cmihon7ikzdlr@var.youpi.perso.aquilenet.fr>
References: <20170825223721.2052-1-samuel.thibault@ens-lyon.org>
	<42fd21ab-d7ca-da12-4f15-73660f543781@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <42fd21ab-d7ca-da12-4f15-73660f543781@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] slirp: fix clearing ifq_so from pending
 packets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, jan.kiszka@siemens.com, f4bug@amsat.org, ppandit@redhat.com, wjjzhang@tencent.com, qemu-stable@nongnu.org

Thomas Huth, on mer. 30 ao=C3=BBt 2017 09:50:45 +0200, wrote:
> On 26.08.2017 00:37, Samuel Thibault wrote:
> > The if_fastq and if_batchq contain not only packets, but queues of pa=
ckets
> > for the same socket. When sofree frees a socket, it thus has to clear=
 ifq_so
> > from all the packets from the queues, not only the first.
>=20
> I think you should CC: this to qemu-stable if it's fixing a problem tha=
t
> can be used by the guest to crash QEMU... ?

Indeed. I thought it should first go to master.

Samuel

>  Thomas
>=20
> > Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
> > Acked-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> > ---
> >  slirp/socket.c | 39 +++++++++++++++++++++++----------------
> >  1 file changed, 23 insertions(+), 16 deletions(-)
> >=20
> > diff --git a/slirp/socket.c b/slirp/socket.c
> > index ecec0295a9..cb7b5b608d 100644
> > --- a/slirp/socket.c
> > +++ b/slirp/socket.c
> > @@ -59,6 +59,27 @@ socreate(Slirp *slirp)
> >    return(so);
> >  }
> > =20
> > +/*
> > + * Remove references to so from the given message queue.
> > + */
> > +static void
> > +soqfree(struct socket *so, struct quehead *qh)
> > +{
> > +    struct mbuf *ifq;
> > +
> > +    for (ifq =3D (struct mbuf *) qh->qh_link;
> > +             (struct quehead *) ifq !=3D qh;
> > +             ifq =3D ifq->ifq_next) {
> > +        if (ifq->ifq_so =3D=3D so) {
> > +            struct mbuf *ifm;
> > +            ifq->ifq_so =3D NULL;
> > +            for (ifm =3D ifq->ifs_next; ifm !=3D ifq; ifm =3D ifm->i=
fs_next) {
> > +                ifm->ifq_so =3D NULL;
> > +            }
> > +        }
> > +    }
> > +}
> > +
> >  /*
> >   * remque and free a socket, clobber cache
> >   */
> > @@ -66,23 +87,9 @@ void
> >  sofree(struct socket *so)
> >  {
> >    Slirp *slirp =3D so->slirp;
> > -  struct mbuf *ifm;
> > =20
> > -  for (ifm =3D (struct mbuf *) slirp->if_fastq.qh_link;
> > -       (struct quehead *) ifm !=3D &slirp->if_fastq;
> > -       ifm =3D ifm->ifq_next) {
> > -    if (ifm->ifq_so =3D=3D so) {
> > -      ifm->ifq_so =3D NULL;
> > -    }
> > -  }
> > -
> > -  for (ifm =3D (struct mbuf *) slirp->if_batchq.qh_link;
> > -       (struct quehead *) ifm !=3D &slirp->if_batchq;
> > -       ifm =3D ifm->ifq_next) {
> > -    if (ifm->ifq_so =3D=3D so) {
> > -      ifm->ifq_so =3D NULL;
> > -    }
> > -  }
> > +  soqfree(so, &slirp->if_fastq);
> > +  soqfree(so, &slirp->if_batchq);
> > =20
> >    if (so->so_emu=3D=3DEMU_RSH && so->extra) {
> >  	sofree(so->extra);
> >=20
>=20

--=20
Samuel
 CN > J'ai enseign=C3=A9 l'algorythmique.
 GLG> C'est quoi l'algorythmique ? Une contrebasse programm=C3=A9e en Alg=
ol ?
 -+- in : Guide du Neuneu d'Usenet - Neuneu fait ses gammes. -+-
