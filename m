Received: from eggs.gnu.org ([2001:4830:134:3::10]:39708)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dDN12-0008Ac-Jk
	for qemu-devel@nongnu.org; Tue, 23 May 2017 23:31:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dDN0y-0005WI-LC
	for qemu-devel@nongnu.org; Tue, 23 May 2017 23:31:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57416)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1dDN0y-0005Vl-Ey
	for qemu-devel@nongnu.org; Tue, 23 May 2017 23:31:12 -0400
References: <20170524025718.2287-1-maozy.fnst@cn.fujitsu.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <657927de-43e1-e622-208b-3008f22b4d8f@redhat.com>
Date: Wed, 24 May 2017 11:31:06 +0800
MIME-Version: 1.0
In-Reply-To: <20170524025718.2287-1-maozy.fnst@cn.fujitsu.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] net/rocker: Cleanup the useless return
 value check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>, qemu-devel@nongnu.org
Cc: jiri@resnulli.us, armbru@redhat.com



On 2017=E5=B9=B405=E6=9C=8824=E6=97=A5 10:57, Mao Zhongyi wrote:
> None of pci_dma_read()'s callers check the return value except
> rocker. There is no need to check it because it always return
> 0. So the check work is useless. Remove it entirely.
>
> Suggested-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
> ---
>   hw/net/rocker/rocker.c      | 9 +++------
>   hw/net/rocker/rocker_desc.c | 4 +---
>   2 files changed, 4 insertions(+), 9 deletions(-)
>
> diff --git a/hw/net/rocker/rocker.c b/hw/net/rocker/rocker.c
> index 6e70fdd..4f0f6d7 100644
> --- a/hw/net/rocker/rocker.c
> +++ b/hw/net/rocker/rocker.c
> @@ -244,11 +244,9 @@ static int tx_consume(Rocker *r, DescInfo *info)
>               goto err_no_mem;
>           }
>  =20
> -        if (pci_dma_read(dev, frag_addr, iov[iovcnt].iov_base,
> -                     iov[iovcnt].iov_len)) {
> -            err =3D -ROCKER_ENXIO;
> -            goto err_bad_io;
> -        }
> +        pci_dma_read(dev, frag_addr, iov[iovcnt].iov_base,
> +                     iov[iovcnt].iov_len);
> +
>           iovcnt++;
>       }
>  =20
> @@ -261,7 +259,6 @@ static int tx_consume(Rocker *r, DescInfo *info)
>       err =3D fp_port_eg(r->fp_port[port], iov, iovcnt);
>  =20
>   err_too_many_frags:
> -err_bad_io:
>   err_no_mem:
>   err_bad_attr:
>       for (i =3D 0; i < ROCKER_TX_FRAGS_MAX; i++) {
> diff --git a/hw/net/rocker/rocker_desc.c b/hw/net/rocker/rocker_desc.c
> index ac02797..6184c40 100644
> --- a/hw/net/rocker/rocker_desc.c
> +++ b/hw/net/rocker/rocker_desc.c
> @@ -69,9 +69,7 @@ char *desc_get_buf(DescInfo *info, bool read_only)
>           return NULL;
>       }
>  =20
> -    if (pci_dma_read(dev, le64_to_cpu(info->desc.buf_addr), info->buf,=
 size)) {
> -        return NULL;
> -    }
> +    pci_dma_read(dev, le64_to_cpu(info->desc.buf_addr), info->buf, siz=
e);
>  =20
>       return info->buf;
>   }

Applied, thanks.
