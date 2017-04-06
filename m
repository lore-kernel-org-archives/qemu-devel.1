Received: from eggs.gnu.org ([2001:4830:134:3::10]:56522)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cw4QX-0001bz-32
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 06:14:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cw4QS-0001hd-5T
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 06:14:05 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:33612)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cw4QR-0001hD-UK
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 06:14:00 -0400
Received: by mail-wr0-x242.google.com with SMTP id g19so9927221wrb.0
	for <qemu-devel@nongnu.org>; Thu, 06 Apr 2017 03:13:59 -0700 (PDT)
Date: Thu, 6 Apr 2017 11:13:56 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170406101356.GC21261@stefanha-x1.localdomain>
References: <20170331084147.32716-1-haozhong.zhang@intel.com>
	<20170331084147.32716-5-haozhong.zhang@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5QAgd0e35j3NYeGe"
Content-Disposition: inline
In-Reply-To: <20170331084147.32716-5-haozhong.zhang@intel.com>
Subject: Re: [Qemu-devel] [RFC PATCH 4/4] nvdimm acpi: build flush hint
 address structure if required
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Haozhong Zhang <haozhong.zhang@intel.com>
Cc: qemu-devel@nongnu.org, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, dan.j.williams@intel.com, Richard Henderson <rth@twiddle.net>


--5QAgd0e35j3NYeGe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 31, 2017 at 04:41:47PM +0800, Haozhong Zhang wrote:
>=20
> Add an boolean option 'flush-hint' to device 'nvdimm'. If it's on, a
> flush hint address structure will be constructed for each nvdimm
> device.

Users should not need to set the flush hint option.  NVDIMM
configurations that persist data properly without Flush Hint Addresses
shouldn't use them (for best performance).  Configurations that rely on
flush hints *must* use them to guarantee data integrity.

I don't remember if there's a way to detect the configuration from host
userspace, but we should focus on setting this correctly without
requiring users to know which setting is necessary.

> Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
> ---
>  hw/acpi/nvdimm.c        | 106 ++++++++++++++++++++++++++++++++++++++++++=
+++---
>  hw/i386/pc.c            |   5 ++-
>  hw/mem/nvdimm.c         |  26 ++++++++++++
>  include/hw/mem/nvdimm.h |   2 +-
>  4 files changed, 132 insertions(+), 7 deletions(-)
>=20
> diff --git a/hw/acpi/nvdimm.c b/hw/acpi/nvdimm.c
> index ea2ac3e..a7ff0b2 100644
> --- a/hw/acpi/nvdimm.c
> +++ b/hw/acpi/nvdimm.c
> @@ -32,6 +32,8 @@
>  #include "hw/acpi/bios-linker-loader.h"
>  #include "hw/nvram/fw_cfg.h"
>  #include "hw/mem/nvdimm.h"
> +#include "exec/address-spaces.h"
> +#include "qapi/error.h"
> =20
>  static int nvdimm_device_list(Object *obj, void *opaque)
>  {
> @@ -168,6 +170,22 @@ struct NvdimmNfitControlRegion {
>  typedef struct NvdimmNfitControlRegion NvdimmNfitControlRegion;
> =20
>  /*
> + * NVDIMM Flush Hint Address Structure
> + *
> + * It enables the data durability mechanism via ACPI.
> + */
> +struct NvdimmNfitFlushHintAddress {
> +    uint16_t type;
> +    uint16_t length;
> +    uint32_t nfit_handle;
> +    uint16_t nr_flush_hint_addr;
> +    uint8_t  reserved[6];
> +#define NR_FLUSH_HINT_ADDR 1
> +    uint64_t flush_hint_addr[NR_FLUSH_HINT_ADDR];

How should the number of flush hints be set?  This patch hardcodes it to
1 but the Linux nvdimm drivers tries to balance between flush hint
addresses to improve performance (to prevent cache line bouncing?).

> +} QEMU_PACKED;
> +typedef struct NvdimmNfitFlushHintAddress NvdimmNfitFlushHintAddress;
> +
> +/*
>   * Module serial number is a unique number for each device. We use the
>   * slot id of NVDIMM device to generate this number so that each device
>   * associates with a different number.
> @@ -343,10 +361,79 @@ static void nvdimm_build_structure_dcr(GArray *stru=
ctures, DeviceState *dev)
>                                           (DSM) in DSM Spec Rev1.*/);
>  }
> =20
> -static GArray *nvdimm_build_device_structure(void)
> +static uint64_t nvdimm_flush_hint_read(void *opaque, hwaddr addr, unsign=
ed size)
> +{
> +    return 0;
> +}
> +
> +static void nvdimm_flush_hint_write(void *opaque, hwaddr addr,
> +                                    uint64_t data, unsigned size)
> +{
> +    nvdimm_debug("Write Flush Hint: offset 0x%"HWADDR_PRIx", data 0x%"PR=
Ix64"\n",
> +                 addr, data);
> +    nvdimm_flush((NVDIMMDevice *)opaque);

C automatically casts void * to any other pointer type.  The cast is
unnecessary.

--5QAgd0e35j3NYeGe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJY5hTkAAoJEJykq7OBq3PIwegH/2xpoADgjs35xM1c/39uKo1i
RO4lKQgrEX/+252etx0dpNwJlqnu7LqPpN9WEFMqJTpVtTDNpNZeV4EZ9PNqra86
eXrc8AKmWsjTY7ziOBUMkE/VlnGGWa9KG7fA2k3mcugI3/ygA/odoL7i1czmuOIn
Rze7/K/OEQOU4ZglvnMZQJgCuP7NEk0KyYvroNyGjRpE1zOWIzhT9RE8qUl3SNzc
2Q0Zpm8Ba34qttBB5JKuzjbyE1ULb/wL4WJGRJm3YG2MS1itgIHjS8dS+p9iqT50
KmzvzCZFH5Li/YQBUN3sAfi+RmZXWQ0jBiktALObcnnkQj5n0tlE1bG3gTUT8d4=
=GSJe
-----END PGP SIGNATURE-----

--5QAgd0e35j3NYeGe--
