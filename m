Received: from eggs.gnu.org ([2001:4830:134:3::10]:49059)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gAIOM-0005hm-JP
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 13:35:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gAIOH-0004pL-4r
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 13:35:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42792)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1gAIOG-0004np-RL
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 13:35:21 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1AE7030026A4
	for <qemu-devel@nongnu.org>; Wed, 10 Oct 2018 17:35:17 +0000 (UTC)
References: <20181008185013.19371-1-mreitz@redhat.com>
	<20181010101025.kck5epmrqurpbeg6@sirius.home.kraxel.org>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <0d07e9f7-1924-0e0f-94da-25d25b10e748@redhat.com>
Date: Wed, 10 Oct 2018 19:35:06 +0200
MIME-Version: 1.0
In-Reply-To: <20181010101025.kck5epmrqurpbeg6@sirius.home.kraxel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Fhl09IfCjfIzBZMBasuPzBPmAMiegPCMJ"
Subject: Re: [Qemu-devel] [PATCH] sdl2: Support all virtio-gpu formats
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Fhl09IfCjfIzBZMBasuPzBPmAMiegPCMJ
From: Max Reitz <mreitz@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org
Message-ID: <0d07e9f7-1924-0e0f-94da-25d25b10e748@redhat.com>
Subject: Re: [PATCH] sdl2: Support all virtio-gpu formats
References: <20181008185013.19371-1-mreitz@redhat.com>
 <20181010101025.kck5epmrqurpbeg6@sirius.home.kraxel.org>
In-Reply-To: <20181010101025.kck5epmrqurpbeg6@sirius.home.kraxel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10.10.18 12:10, Gerd Hoffmann wrote:
> On Mon, Oct 08, 2018 at 08:50:13PM +0200, Max Reitz wrote:
>> There are some 2D resource formats that can be used through virtio-gpu=
,
>=20
> Ahem, not really.  XRGB is the only one which works in practice, and
> virtio-gpu kms driver will stop advertising anything else soon (patches=

> should land upstream with the next merge window).

OK, if virtio-gpu didn't support anything else, that'd be a fix, too.
But it sounds like you're talking about the Linux driver, I'm not.

This is not about Linux applications being able to abuse the Linux
driver to crash the VM, this is about malicious drivers (not necessarily
Linux drivers).

>> Add these formats in the switch converting pixman to SDL format
>> constants so a guest cannot crash the VM by triggering the
>> g_assert_not_reached() with an unsupported format.
>=20
> Do you have a reproducer for that?

I have attached two RISC-V kernels, one (kernel-rgbx) setting
VIRTIO_GPU_FORMAT_R8G8B8X8_UNORM, the other (kernel-bgra) setting
VIRTIO_GPU_FORMAT_B8G8R8A8_UNORM.  Both crash qemu:

$ $QEMU/build/riscv64-softmmu/qemu-system-riscv64 -kernel kernel-rgbx \
    -serial stdio -M virt -device virtio-gpu-device
[platform-virt] Virt platform detected
[virtio-gpu] Found device @0x10008000
[virtio-gpu] Scanout 0: 0x0:1024x768
**
ERROR:$QEMU/ui/sdl2-2d.c:114:sdl2_2d_switch: code should not be reached
[1]    7151 abort (core dumped)

So this is not about a misbehaving Linux driver but about an own driver.
 Of course, if you can insert kernel code, there's noone stopping you
from hitting that assertion with Linux, too.

> There is sdl2_2d_check_format() which reports the supported formats.
> If we hit sdl2_2d_switch() with a format not whitelisted by
> sdl2_2d_check_format() we have a bug somewhere in qemu ...

I suppose the other solution would be for virtio_gpu_set_scanout() to
check whether the resource's format can actually be used for that
display.  Or in virtio_gpu_resource_create_2d(), I don't know whether
it's possible to use resources in other formats at all.

Max


--Fhl09IfCjfIzBZMBasuPzBPmAMiegPCMJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlu+OEoACgkQ9AfbAGHV
z0D68gf/cNirc503alVM515RwSOkQUNTW4Brbh6aWwoo8tY6zceSqJF1vvOQqNhK
uhMledvXG6aA9cSQyaB2HbDZr7IwW5kzbQ2RsjIxper/Gjx7Bvd4Xf/Mb1LB9Ibm
/nMsR2LtYPg/8jdVz2QwWCD9QEWte7lBBWkWX2NbCR0hutDdJKoPFyEz8m7xu1Cy
nMCrOVfbmyPJFniCKPbAPaBvaaiqvjc4NcS+WHlU+YwMfepm9dgNNc2Bkfq7ppzT
8D5Fc6tjZ362jLk6CaBfzTL+bPyGFcRjxFs9vjrdC1q6Jpp6y7Bp+bmq+25mRAqt
MciLNj3cc48+WInd0lZa9jjE5Q+QrA==
=MjW3
-----END PGP SIGNATURE-----

--Fhl09IfCjfIzBZMBasuPzBPmAMiegPCMJ--
