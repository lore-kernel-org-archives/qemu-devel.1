Received: from eggs.gnu.org ([2001:4830:134:3::10]:46941)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dsl60-0002Ql-M1
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 03:31:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dsl5y-0000Th-Kx
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 03:31:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39186)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dsl5y-0000T3-CE
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 03:31:26 -0400
Message-ID: <1505460680.18776.1.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 15 Sep 2017 09:31:20 +0200
In-Reply-To: <f6c9e7ec8ad585ce7c8f401aae2ec1fddf157fd7.1505403478.git.alifm@linux.vnet.ibm.com>
References: <cover.1505403478.git.alifm@linux.vnet.ibm.com>
	<f6c9e7ec8ad585ce7c8f401aae2ec1fddf157fd7.1505403478.git.alifm@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/2] virtio-gpu: Handle endian conversion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Farhan Ali <alifm@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, thuth@redhat.com, cohuck@redhat.com

  Hi,

> +static void
> +virtio_gpu_ctrl_hdr_bswap_cpu(struct virtio_gpu_ctrl_hdr *hdr)
> +{
> +=C2=A0=C2=A0=C2=A0=C2=A0hdr->type =3D=C2=A0=C2=A0le32_to_cpu(hdr->type=
);
> +=C2=A0=C2=A0=C2=A0=C2=A0hdr->flags =3D le32_to_cpu(hdr->flags);
> +=C2=A0=C2=A0=C2=A0=C2=A0hdr->fence_id =3D le64_to_cpu(hdr->fence_id);
> +=C2=A0=C2=A0=C2=A0=C2=A0hdr->ctx_id =3D le32_to_cpu(hdr->ctx_id);
> +=C2=A0=C2=A0=C2=A0=C2=A0hdr->padding =3D le32_to_cpu(hdr->padding);
> +}
> +
> +static void
> +virtio_gpu_ctrl_hdr_bswap_le(struct virtio_gpu_ctrl_hdr *hdr)
> +{
> +=C2=A0=C2=A0=C2=A0=C2=A0hdr->type =3D=C2=A0=C2=A0cpu_to_le32(hdr->type=
);
> +=C2=A0=C2=A0=C2=A0=C2=A0hdr->flags =3D cpu_to_le32(hdr->flags);
> +=C2=A0=C2=A0=C2=A0=C2=A0hdr->fence_id =3D cpu_to_le64(hdr->fence_id);
> +=C2=A0=C2=A0=C2=A0=C2=A0hdr->ctx_id =3D cpu_to_le32(hdr->ctx_id);
> +=C2=A0=C2=A0=C2=A0=C2=A0hdr->padding =3D cpu_to_le32(hdr->padding);
> +}

These two functions do exactly the same thing because cpu_to_le32 and
le32_to_cpu are the same operation.  The two variants only exist to
make the code more readable.  So this isn't needed twice.  I'd suggest
to just call the functions "*_bswap" and drop any _le or _cpu postfix.=20
Note that there are also variants for in-place swapping.

Have a look at the comments in include/qemu/bswap.h

> +
> +static void virtio_gpu_bswap_cpu_32(void *ptr,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0size=
_t size)
> +{

#ifdef HOST_WORDS_BIGENDIAN

> +=C2=A0=C2=A0=C2=A0=C2=A0size_t i;
> +=C2=A0=C2=A0=C2=A0=C2=A0struct virtio_gpu_ctrl_hdr *hdr =3D (struct vi=
rtio_gpu_ctrl_hdr *)
> ptr;
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0virtio_gpu_ctrl_hdr_bswap_cpu(hdr);
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0i =3D sizeof(struct virtio_gpu_ctrl_hdr);
> +=C2=A0=C2=A0=C2=A0=C2=A0while (i < size) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0*(uint32_t *)(ptr + i)=
 =3D le32_to_cpu(*(uint32_t *)(ptr +
> i));
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0i =3D i + sizeof(uint3=
2_t);
> +=C2=A0=C2=A0=C2=A0=C2=A0}

#endif

I suspect the compiler isn't clever enough to figure the whole function
is a nop on little endian hosts.

cheers,
  Gerd
