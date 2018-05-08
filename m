Received: from eggs.gnu.org ([2001:4830:134:3::10]:39286)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fG3T5-00016S-2d
	for qemu-devel@nongnu.org; Tue, 08 May 2018 10:19:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fG3T0-0002Iz-S0
	for qemu-devel@nongnu.org; Tue, 08 May 2018 10:19:51 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55370 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fG3T0-0002Il-Mz
	for qemu-devel@nongnu.org; Tue, 08 May 2018 10:19:46 -0400
Date: Tue, 8 May 2018 15:19:42 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180508141941.GN2500@work-vm>
References: <1525530936-21835-1-git-send-email-lidongchen@tencent.com>
	<1525530936-21835-4-git-send-email-lidongchen@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <1525530936-21835-4-git-send-email-lidongchen@tencent.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 3/6] migration: remove unnecessary
 variables len in QIOChannelRDMA
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Lidong Chen <jemmy858585@gmail.com>
Cc: quintela@redhat.com, berrange@redhat.com, qemu-devel@nongnu.org, galsha@mellanox.com, aviadye@mellanox.com, adido@mellanox.com, Lidong Chen <lidongchen@tencent.com>

* Lidong Chen (jemmy858585@gmail.com) wrote:
> Because qio_channel_rdma_writev and qio_channel_rdma_readv maybe invoke=
d
> by different threads concurrently, this patch removes unnecessary varia=
bles
> len in QIOChannelRDMA and use local variable instead.
>=20
> Signed-off-by: Lidong Chen <lidongchen@tencent.com>
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Reviewed-by: Daniel P. Berrang=E9berrange@redhat.com>

Note there's a ' <' missing somehow; minor fix up during commit
hopefully.

Dave

> ---
>  migration/rdma.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
>=20
> diff --git a/migration/rdma.c b/migration/rdma.c
> index c745427..f5c1d02 100644
> --- a/migration/rdma.c
> +++ b/migration/rdma.c
> @@ -404,7 +404,6 @@ struct QIOChannelRDMA {
>      QIOChannel parent;
>      RDMAContext *rdma;
>      QEMUFile *file;
> -    size_t len;
>      bool blocking; /* XXX we don't actually honour this yet */
>  };
> =20
> @@ -2640,6 +2639,7 @@ static ssize_t qio_channel_rdma_writev(QIOChannel=
 *ioc,
>      int ret;
>      ssize_t done =3D 0;
>      size_t i;
> +    size_t len =3D 0;
> =20
>      CHECK_ERROR_STATE();
> =20
> @@ -2659,10 +2659,10 @@ static ssize_t qio_channel_rdma_writev(QIOChann=
el *ioc,
>          while (remaining) {
>              RDMAControlHeader head;
> =20
> -            rioc->len =3D MIN(remaining, RDMA_SEND_INCREMENT);
> -            remaining -=3D rioc->len;
> +            len =3D MIN(remaining, RDMA_SEND_INCREMENT);
> +            remaining -=3D len;
> =20
> -            head.len =3D rioc->len;
> +            head.len =3D len;
>              head.type =3D RDMA_CONTROL_QEMU_FILE;
> =20
>              ret =3D qemu_rdma_exchange_send(rdma, &head, data, NULL, N=
ULL, NULL);
> @@ -2672,8 +2672,8 @@ static ssize_t qio_channel_rdma_writev(QIOChannel=
 *ioc,
>                  return ret;
>              }
> =20
> -            data +=3D rioc->len;
> -            done +=3D rioc->len;
> +            data +=3D len;
> +            done +=3D len;
>          }
>      }
> =20
> @@ -2768,8 +2768,7 @@ static ssize_t qio_channel_rdma_readv(QIOChannel =
*ioc,
>              }
>          }
>      }
> -    rioc->len =3D done;
> -    return rioc->len;
> +    return done;
>  }
> =20
>  /*
> --=20
> 1.8.3.1
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
