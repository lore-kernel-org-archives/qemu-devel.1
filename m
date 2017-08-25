Received: from eggs.gnu.org ([2001:4830:134:3::10]:47603)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1dlNf4-0008IF-54
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 19:05:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1dlNf3-00008f-5a
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 19:05:10 -0400
Received: from hera.aquilenet.fr ([2a01:474::1]:37144)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1dlNf2-00004t-Ul
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 19:05:09 -0400
Date: Sat, 26 Aug 2017 01:05:04 +0200
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20170825230504.4y4uychn3sqoljoc@var.youpi.perso.aquilenet.fr>
References: <20170825223721.2052-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170825223721.2052-1-samuel.thibault@ens-lyon.org>
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
To: qemu-devel@nongnu.org
Cc: f4bug@amsat.org, ppandit@redhat.com, jan.kiszka@siemens.com, thuth@redhat.com, wjjzhang@tencent.com

Hello,

So Wjjzhang and PJP, can you confirm that this fixes your uses?

Samuel

Samuel Thibault, on sam. 26 ao=C3=BBt 2017 00:37:21 +0200, wrote:
> The if_fastq and if_batchq contain not only packets, but queues of pack=
ets
> for the same socket. When sofree frees a socket, it thus has to clear i=
fq_so
> from all the packets from the queues, not only the first.
>=20
> Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
> Acked-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  slirp/socket.c | 39 +++++++++++++++++++++++----------------
>  1 file changed, 23 insertions(+), 16 deletions(-)
>=20
> diff --git a/slirp/socket.c b/slirp/socket.c
> index ecec0295a9..cb7b5b608d 100644
> --- a/slirp/socket.c
> +++ b/slirp/socket.c
> @@ -59,6 +59,27 @@ socreate(Slirp *slirp)
>    return(so);
>  }
> =20
> +/*
> + * Remove references to so from the given message queue.
> + */
> +static void
> +soqfree(struct socket *so, struct quehead *qh)
> +{
> +    struct mbuf *ifq;
> +
> +    for (ifq =3D (struct mbuf *) qh->qh_link;
> +             (struct quehead *) ifq !=3D qh;
> +             ifq =3D ifq->ifq_next) {
> +        if (ifq->ifq_so =3D=3D so) {
> +            struct mbuf *ifm;
> +            ifq->ifq_so =3D NULL;
> +            for (ifm =3D ifq->ifs_next; ifm !=3D ifq; ifm =3D ifm->ifs=
_next) {
> +                ifm->ifq_so =3D NULL;
> +            }
> +        }
> +    }
> +}
> +
>  /*
>   * remque and free a socket, clobber cache
>   */
> @@ -66,23 +87,9 @@ void
>  sofree(struct socket *so)
>  {
>    Slirp *slirp =3D so->slirp;
> -  struct mbuf *ifm;
> =20
> -  for (ifm =3D (struct mbuf *) slirp->if_fastq.qh_link;
> -       (struct quehead *) ifm !=3D &slirp->if_fastq;
> -       ifm =3D ifm->ifq_next) {
> -    if (ifm->ifq_so =3D=3D so) {
> -      ifm->ifq_so =3D NULL;
> -    }
> -  }
> -
> -  for (ifm =3D (struct mbuf *) slirp->if_batchq.qh_link;
> -       (struct quehead *) ifm !=3D &slirp->if_batchq;
> -       ifm =3D ifm->ifq_next) {
> -    if (ifm->ifq_so =3D=3D so) {
> -      ifm->ifq_so =3D NULL;
> -    }
> -  }
> +  soqfree(so, &slirp->if_fastq);
> +  soqfree(so, &slirp->if_batchq);
> =20
>    if (so->so_emu=3D=3DEMU_RSH && so->extra) {
>  	sofree(so->extra);
> --=20
> 2.14.1
>=20

--=20
Samuel
...
<rv_> et Ctrl alt F2 pour aller sous console
<rv_> mais c koi pour passer d'un bureau a un autre !
<rv_> au fait c koi le raccourci pour passer d'un bureau a un autre 'ques=
tion stupide"
<cycyx> =C3=A7a d=C3=A9pend du window manager et de ta conf
<Firebird> ce qui fonctionne toujours c'est CTRL-ALT-BCKSP
-:- SignOff rv_: #linuxfr (Read error: EOF from client)
-:- rv_ [~rv@217.11.166.169] has joined #linuxfr
<rv_> Firebird: MEURT...
