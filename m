Received: from eggs.gnu.org ([2001:4830:134:3::10]:47514)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dLrAS-0003Yd-4S
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 09:20:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dLrAO-0005n3-Vu
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 09:20:04 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:35938)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dLrAO-0005mq-M6
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 09:20:00 -0400
Received: by mail-wr0-x243.google.com with SMTP id 77so6572829wrb.3
	for <qemu-devel@nongnu.org>; Fri, 16 Jun 2017 06:20:00 -0700 (PDT)
Date: Fri, 16 Jun 2017 14:19:56 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170616131956.GA6770@stefanha-x1.localdomain>
References: <20170609151615.2589-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RnlQjJ0d97Da+TV1"
Content-Disposition: inline
In-Reply-To: <20170609151615.2589-1-stefanha@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] hw/i386: fix nvdimm check error path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Haozhong Zhang <haozhong.zhang@intel.com>, Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, stefanha@redhat.com


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 09, 2017 at 04:16:15PM +0100, Stefan Hajnoczi wrote:
> Commit e987c37aee1752177906847630d32477da57e705 ("hw/i386: check if
> nvdimm is enabled before plugging") introduced a check to reject nvdimm
> hotplug if -machine pc,nvdimm=3Don was not given.
>=20
> This check executes after pc_dimm_memory_plug() has already completed
> and does not reverse the effect of this function in the case of failure.
>=20
> Perform the check before calling pc_dimm_memory_plug().  This fixes the
> following abort:
>=20
>   $ qemu -M accel=3Dkvm -m 1G,slots=3D4,maxmem=3D8G \
>          -object memory-backend-file,id=3Dmem1,share=3Don,mem-path=3Dnvdi=
mm.dat,size=3D1G
>   (qemu) device_add nvdimm,memdev=3Dmem1
>   nvdimm is not enabled: missing 'nvdimm' in '-M'
>   (qemu) device_add nvdimm,memdev=3Dmem1
>   Core dumped
>=20
> The backtrace is:
>=20
>   #0  0x00007fffdb5b191f in raise () at /lib64/libc.so.6
>   #1  0x00007fffdb5b351a in abort () at /lib64/libc.so.6
>   #2  0x00007fffdb5a9da7 in __assert_fail_base () at /lib64/libc.so.6
>   #3  0x00007fffdb5a9e52 in  () at /lib64/libc.so.6
>   #4  0x000055555577a5fa in qemu_ram_set_idstr (new_block=3D0x555556747a0=
0, name=3D<optimized out>, dev=3Ddev@entry=3D0x555556705590) at qemu/exec.c=
:1709
>   #5  0x0000555555a0fe86 in vmstate_register_ram (mr=3Dmr@entry=3D0x55555=
673a0e0, dev=3Ddev@entry=3D0x555556705590) at migration/savevm.c:2293
>   #6  0x0000555555965088 in pc_dimm_memory_plug (dev=3Ddev@entry=3D0x5555=
56705590, hpms=3Dhpms@entry=3D0x5555566bb0e0, mr=3Dmr@entry=3D0x55555670563=
0, align=3D<optimized out>, errp=3Derrp@entry=3D0x7fffffffc660)
>       at hw/mem/pc-dimm.c:110
>   #7  0x000055555581d89b in pc_dimm_plug (errp=3D0x7fffffffc6c0, dev=3D0x=
555556705590, hotplug_dev=3D<optimized out>) at qemu/hw/i386/pc.c:1713
>   #8  0x000055555581d89b in pc_machine_device_plug_cb (hotplug_dev=3D<opt=
imized out>, dev=3D0x555556705590, errp=3D0x7fffffffc6c0) at qemu/hw/i386/p=
c.c:2004
>   #9  0x0000555555914da6 in device_set_realized (obj=3D<optimized out>, v=
alue=3D<optimized out>, errp=3D0x7fffffffc7e8) at hw/core/qdev.c:926
>=20
> Cc: Haozhong Zhang <haozhong.zhang@intel.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  hw/i386/pc.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)

Michael: Do you want to take this through your tree?

>=20
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 5b8c6fb..db41cca 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -1692,6 +1692,7 @@ static void pc_dimm_plug(HotplugHandler *hotplug_de=
v,
>      PCDIMMDeviceClass *ddc =3D PC_DIMM_GET_CLASS(dimm);
>      MemoryRegion *mr =3D ddc->get_memory_region(dimm);
>      uint64_t align =3D TARGET_PAGE_SIZE;
> +    bool is_nvdimm =3D object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM);
> =20
>      if (memory_region_get_alignment(mr) && pcmc->enforce_aligned_dimm) {
>          align =3D memory_region_get_alignment(mr);
> @@ -1703,17 +1704,18 @@ static void pc_dimm_plug(HotplugHandler *hotplug_=
dev,
>          goto out;
>      }
> =20
> +    if (is_nvdimm && !pcms->acpi_nvdimm_state.is_enabled) {
> +        error_setg(&local_err,
> +                   "nvdimm is not enabled: missing 'nvdimm' in '-M'");
> +        goto out;
> +    }
> +
>      pc_dimm_memory_plug(dev, &pcms->hotplug_memory, mr, align, &local_er=
r);
>      if (local_err) {
>          goto out;
>      }
> =20
> -    if (object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM)) {
> -        if (!pcms->acpi_nvdimm_state.is_enabled) {
> -            error_setg(&local_err,
> -                       "nvdimm is not enabled: missing 'nvdimm' in '-M'"=
);
> -            goto out;
> -        }
> +    if (is_nvdimm) {
>          nvdimm_plug(&pcms->acpi_nvdimm_state);
>      }
> =20
> --=20
> 2.9.4
>=20
>=20

--RnlQjJ0d97Da+TV1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZQ9r8AAoJEJykq7OBq3PItxEH/00lKfaRCppOpHVG5qYwAnWv
y8cBWTgqU10XGa74s6OhXcEinrVIXszwjdgQBEbeaI9hS+zmH1XsZH4nkEka+7BB
bOnYvsUUD63pRgxWSFd0sgkmNPnsEhF1vlebTa2ZAKn3UjACLYdDT0bQbkAi2zOh
lVLaksRygyW+0e51g2wLohAf9cy6ujbBrwhcs6MoA2WHKxqe7Cmqx+1fQ9WDnlyg
Hev2KvBmS3oXNWx32FtJvearCsD9Ywxof72ikg7SL5x3V7hC12q5cZY2XHcvyEpm
C1VgxphQ2eh47ETemQHPi2yd5FXv/HmRniibN+Gbw4BsX3TUye/krAqMIFlV+Z0=
=va+c
-----END PGP SIGNATURE-----

--RnlQjJ0d97Da+TV1--
