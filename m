Received: from eggs.gnu.org ([2001:4830:134:3::10]:53391)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dmxm4-0001wE-7c
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 03:50:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dmxm1-00027j-5i
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 03:50:56 -0400
References: <20170825223721.2052-1-samuel.thibault@ens-lyon.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <42fd21ab-d7ca-da12-4f15-73660f543781@redhat.com>
Date: Wed, 30 Aug 2017 09:50:45 +0200
MIME-Version: 1.0
In-Reply-To: <20170825223721.2052-1-samuel.thibault@ens-lyon.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
To: Samuel Thibault <samuel.thibault@ens-lyon.org>, qemu-devel@nongnu.org
Cc: jan.kiszka@siemens.com, f4bug@amsat.org, ppandit@redhat.com, wjjzhang@tencent.com, qemu-stable@nongnu.org

 Hi Samuel,

On 26.08.2017 00:37, Samuel Thibault wrote:
> The if_fastq and if_batchq contain not only packets, but queues of pack=
ets
> for the same socket. When sofree frees a socket, it thus has to clear i=
fq_so
> from all the packets from the queues, not only the first.

I think you should CC: this to qemu-stable if it's fixing a problem that
can be used by the guest to crash QEMU... ?

 Thomas

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
>=20
