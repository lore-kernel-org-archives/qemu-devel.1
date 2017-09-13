Received: from eggs.gnu.org ([2001:4830:134:3::10]:58961)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ds2o7-0001J4-Dh
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 04:14:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ds2o2-0005LQ-Dh
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 04:14:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52160)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1ds2o2-0005K9-7D
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 04:13:58 -0400
Message-ID: <1505290435.22749.3.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 13 Sep 2017 10:13:55 +0200
In-Reply-To: <0a156f413f67b1bf55c5516d8263a15db3ec42c3.1505225353.git.alifm@linux.vnet.ibm.com>
References: <cover.1505225353.git.alifm@linux.vnet.ibm.com>
	<0a156f413f67b1bf55c5516d8263a15db3ec42c3.1505225353.git.alifm@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 1/2] virtio_gpu: Handle endian conversion
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

> @@ -287,6 +287,12 @@ static void
> virtio_gpu_resource_create_2d(VirtIOGPU *g,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct virtio_gpu_resource_create_2d c2d;
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0VIRTIO_GPU_FILL_CMD(c2d);
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0c2d.resource_id =3D le32_to_cpu(c2d.resource_i=
d);
> +=C2=A0=C2=A0=C2=A0=C2=A0c2d.format =3D le32_to_cpu(c2d.format);
> +=C2=A0=C2=A0=C2=A0=C2=A0c2d.width =3D le32_to_cpu(c2d.width);
> +=C2=A0=C2=A0=C2=A0=C2=A0c2d.height =3D le32_to_cpu(c2d.height);
> +

Please move this to a helper function, maybe by updating the
VIRTIO_GPU_FILL_CMD macro.

The header fields should be byteswapped too.  As most structs have
32bit fields only (with the exception of hdr.fence_id) you should be
able to create a generic byteswap function which only needs the struct
size as argument and handles all structs without addresses/offsets
(which are 64bit fields).

The conversion looks incomplete, at least virtio_gpu_ctrl_response will
need adaptions too.  It probably works by luck because the guest driver
uses fences only in virgl (3d) mode.

cheers,
  Gerd
