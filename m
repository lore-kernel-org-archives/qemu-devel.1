Received: from eggs.gnu.org ([2001:4830:134:3::10]:39024)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fYB2W-0004qE-Kd
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 10:03:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fYB2S-0002rw-Lm
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 10:03:20 -0400
Date: Wed, 27 Jun 2018 16:03:14 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180627160314.022e3f81@redhat.com>
In-Reply-To: <20180625124238.25339-11-f4bug@amsat.org>
References: <20180625124238.25339-1-f4bug@amsat.org>
	<20180625124238.25339-11-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 10/46] hw/smbios: Use the IEC binary
 prefix definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>
Cc: Thomas Huth <thuth@redhat.com>, Stefan Weil <sw@weilnetz.de>, qemu-trivial@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org

On Mon, 25 Jun 2018 09:42:02 -0300
Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrote:

> It eases code review, unit is explicit.
>=20
> Patch generated using:
>=20
>   $ git grep -E '(1024|2048|4096|8192|(<<|>>).?(10|20|30))' hw/ include/h=
w/
>=20
> and modified manually.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>


Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/smbios/smbios.c | 15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)
>=20
> diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
> index 27a07e96f4..a27e54b2fa 100644
> --- a/hw/smbios/smbios.c
> +++ b/hw/smbios/smbios.c
> @@ -16,6 +16,7 @@
>   */
> =20
>  #include "qemu/osdep.h"
> +#include "qemu/units.h"
>  #include "qapi/error.h"
>  #include "qemu/config-file.h"
>  #include "qemu/error-report.h"
> @@ -625,10 +626,6 @@ static void smbios_build_type_11_table(void)
>      SMBIOS_BUILD_TABLE_POST;
>  }
> =20
> -#define ONE_KB ((ram_addr_t)1 << 10)
> -#define ONE_MB ((ram_addr_t)1 << 20)
> -#define ONE_GB ((ram_addr_t)1 << 30)
> -
>  #define MAX_T16_STD_SZ 0x80000000 /* 2T in Kilobytes */
> =20
>  static void smbios_build_type_16_table(unsigned dimm_cnt)
> @@ -640,7 +637,7 @@ static void smbios_build_type_16_table(unsigned dimm_=
cnt)
>      t->location =3D 0x01; /* Other */
>      t->use =3D 0x03; /* System memory */
>      t->error_correction =3D 0x06; /* Multi-bit ECC (for Microsoft, per S=
eaBIOS) */
> -    size_kb =3D QEMU_ALIGN_UP(ram_size, ONE_KB) / ONE_KB;
> +    size_kb =3D QEMU_ALIGN_UP(ram_size, KiB) / KiB;
>      if (size_kb < MAX_T16_STD_SZ) {
>          t->maximum_capacity =3D cpu_to_le32(size_kb);
>          t->extended_maximum_capacity =3D cpu_to_le64(0);
> @@ -668,7 +665,7 @@ static void smbios_build_type_17_table(unsigned insta=
nce, uint64_t size)
>      t->memory_error_information_handle =3D cpu_to_le16(0xFFFE); /* Not p=
rovided */
>      t->total_width =3D cpu_to_le16(0xFFFF); /* Unknown */
>      t->data_width =3D cpu_to_le16(0xFFFF); /* Unknown */
> -    size_mb =3D QEMU_ALIGN_UP(size, ONE_MB) / ONE_MB;
> +    size_mb =3D QEMU_ALIGN_UP(size, MiB) / MiB;
>      if (size_mb < MAX_T17_STD_SZ) {
>          t->size =3D cpu_to_le16(size_mb);
>          t->extended_size =3D cpu_to_le32(0);
> @@ -707,8 +704,8 @@ static void smbios_build_type_19_table(unsigned insta=
nce,
> =20
>      end =3D start + size - 1;
>      assert(end > start);
> -    start_kb =3D start / ONE_KB;
> -    end_kb =3D end / ONE_KB;
> +    start_kb =3D start / KiB;
> +    end_kb =3D end / KiB;
>      if (start_kb < UINT32_MAX && end_kb < UINT32_MAX) {
>          t->starting_address =3D cpu_to_le32(start_kb);
>          t->ending_address =3D cpu_to_le32(end_kb);
> @@ -869,7 +866,7 @@ void smbios_get_tables(const struct smbios_phys_mem_a=
rea *mem_array,
> =20
>          smbios_build_type_11_table();
> =20
> -#define MAX_DIMM_SZ (16ll * ONE_GB)
> +#define MAX_DIMM_SZ (16 * GiB)
>  #define GET_DIMM_SZ ((i < dimm_cnt - 1) ? MAX_DIMM_SZ \
>                                          : ((ram_size - 1) % MAX_DIMM_SZ)=
 + 1)
> =20
