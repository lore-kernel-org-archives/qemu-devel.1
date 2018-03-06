Received: from eggs.gnu.org ([2001:4830:134:3::10]:47656)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1et8UD-0006wW-3A
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 04:02:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1et8UC-0005Uk-5p
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 04:02:17 -0500
Date: Tue, 6 Mar 2018 10:02:14 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180306100214.32c99c12@redhat.com>
In-Reply-To: <20180305112732.26471-27-f4bug@amsat.org>
References: <20180305112732.26471-1-f4bug@amsat.org>
	<20180305112732.26471-27-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 26/30] hw/smbios: use the BYTE-based
 definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>
Cc: qemu-trivial@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org

On Mon,  5 Mar 2018 08:27:28 -0300
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
>  hw/smbios/smbios.c | 14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)
>=20
> diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
> index 27a07e96f4..fa02f9ce3f 100644
> --- a/hw/smbios/smbios.c
> +++ b/hw/smbios/smbios.c
> @@ -625,10 +625,6 @@ static void smbios_build_type_11_table(void)
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
> @@ -640,7 +636,7 @@ static void smbios_build_type_16_table(unsigned dimm_=
cnt)
>      t->location =3D 0x01; /* Other */
>      t->use =3D 0x03; /* System memory */
>      t->error_correction =3D 0x06; /* Multi-bit ECC (for Microsoft, per S=
eaBIOS) */
> -    size_kb =3D QEMU_ALIGN_UP(ram_size, ONE_KB) / ONE_KB;
> +    size_kb =3D QEMU_ALIGN_UP(ram_size, K_BYTE) / K_BYTE;
>      if (size_kb < MAX_T16_STD_SZ) {
>          t->maximum_capacity =3D cpu_to_le32(size_kb);
>          t->extended_maximum_capacity =3D cpu_to_le64(0);
> @@ -668,7 +664,7 @@ static void smbios_build_type_17_table(unsigned insta=
nce, uint64_t size)
>      t->memory_error_information_handle =3D cpu_to_le16(0xFFFE); /* Not p=
rovided */
>      t->total_width =3D cpu_to_le16(0xFFFF); /* Unknown */
>      t->data_width =3D cpu_to_le16(0xFFFF); /* Unknown */
> -    size_mb =3D QEMU_ALIGN_UP(size, ONE_MB) / ONE_MB;
> +    size_mb =3D QEMU_ALIGN_UP(size, M_BYTE) / M_BYTE;
>      if (size_mb < MAX_T17_STD_SZ) {
>          t->size =3D cpu_to_le16(size_mb);
>          t->extended_size =3D cpu_to_le32(0);
> @@ -707,8 +703,8 @@ static void smbios_build_type_19_table(unsigned insta=
nce,
> =20
>      end =3D start + size - 1;
>      assert(end > start);
> -    start_kb =3D start / ONE_KB;
> -    end_kb =3D end / ONE_KB;
> +    start_kb =3D start / K_BYTE;
> +    end_kb =3D end / K_BYTE;
>      if (start_kb < UINT32_MAX && end_kb < UINT32_MAX) {
>          t->starting_address =3D cpu_to_le32(start_kb);
>          t->ending_address =3D cpu_to_le32(end_kb);
> @@ -869,7 +865,7 @@ void smbios_get_tables(const struct smbios_phys_mem_a=
rea *mem_array,
> =20
>          smbios_build_type_11_table();
> =20
> -#define MAX_DIMM_SZ (16ll * ONE_GB)
> +#define MAX_DIMM_SZ (16 * G_BYTE)
>  #define GET_DIMM_SZ ((i < dimm_cnt - 1) ? MAX_DIMM_SZ \
>                                          : ((ram_size - 1) % MAX_DIMM_SZ)=
 + 1)
> =20
