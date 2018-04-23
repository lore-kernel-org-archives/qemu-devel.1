Received: from eggs.gnu.org ([2001:4830:134:3::10]:47689)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fAb7K-0004ts-5y
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 09:02:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fAb7F-0004O4-6y
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 09:02:50 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:33946)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1fAb7E-0004Na-Rg
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 09:02:45 -0400
Received: by mail-wr0-x242.google.com with SMTP id p18-v6so21865354wrm.1
	for <qemu-devel@nongnu.org>; Mon, 23 Apr 2018 06:02:44 -0700 (PDT)
Date: Mon, 23 Apr 2018 14:02:41 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180423130241.GB4892@stefanha-x1.localdomain>
References: <1524206732-7729-1-git-send-email-suhang16@mails.ucas.ac.cn>
	<1524206732-7729-2-git-send-email-suhang16@mails.ucas.ac.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LyciRD1jyfeSSjG0"
Content-Disposition: inline
In-Reply-To: <1524206732-7729-2-git-send-email-suhang16@mails.ucas.ac.cn>
Subject: Re: [Qemu-devel] [PATCH v5 1/2] Implement .hex file loader
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Su Hang <suhang16@mails.ucas.ac.cn>
Cc: jim@groklearning.com, joel@jms.id.au, qemu-devel@nongnu.org


--LyciRD1jyfeSSjG0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 20, 2018 at 02:45:31PM +0800, Su Hang wrote:
> diff --git a/hw/arm/boot.c b/hw/arm/boot.c
> index 26184bcd7c26..898a7af114ea 100644
> --- a/hw/arm/boot.c
> +++ b/hw/arm/boot.c
> @@ -1070,12 +1070,20 @@ static void arm_load_kernel_notify(Notifier *noti=
fier, void *data)
>          kernel_size =3D load_aarch64_image(info->kernel_filename,
>                                           info->loader_start, &entry, as);
>          is_linux =3D 1;
> -    } else if (kernel_size < 0) {
> -        /* 32-bit ARM */
> +    }
> +    if (kernel_size < 0) {

Please try the Intel HEX loader right after load_uimage_as().  In theory
it should be usable on aarch64 too, so the Intel HEX loader needs to be
called earlier.

> +        /* 32-bit ARM .hex file */
> +        entry =3D info->loader_start + KERNEL_LOAD_ADDR;

KERNEL_LOAD_ADDR is for Linux, can you explain why you used it for this
non-Linux image format?

> +        kernel_size =3D
> +            load_targphys_hex_as(info->kernel_filename, entry,
> +                                 info->ram_size - KERNEL_LOAD_ADDR, as);

The Intel HEX file may provide the entrypoint address, so the argument
should be &entry.

> +/* return size or -1 if error */
> +static size_t handle_record_type(const char *filename, HexLine *line,
> +                                 uint8_t *bin_buf, const hwaddr addr,
> +                                 size_t *total_size, uint8_t *ext_linear=
_record,
> +                                 uint32_t *next_address_to_write,
> +                                 uint32_t *current_address,
> +                                 uint32_t *current_rom_index,
> +                                 uint32_t *rom_start_address, AddressSpa=
ce *as)

There are a lot of arguments.  A struct makes the code easier to read
and prevents bugs if arguments are accidentally swapped (e.g.
next_address_to_write and current_address have the same type so the
compiler cannot warn if they are swapped):

  typedef struct {
      HexLine line;
      uint8_t *bin_buf;
      ...
  } HexParser;

static size_t handle_record_type(HexParser *parser);

> +{
> +    switch (line->record_type) {
> +    case DATA_RECORD:
> +        *current_address =3D
> +            (*next_address_to_write & 0xffff0000) | line->address;
> +        /* verify this is a contiguous block of memory */
> +        if (*current_address !=3D *next_address_to_write ||
> +            *ext_linear_record =3D=3D 1) {
> +            if (*ext_linear_record !=3D 1) {
> +                return -1;
> +            }
> +            *ext_linear_record =3D 0;
> +            *rom_start_address =3D *current_address;
> +        }

What is the purpose of ext_linear_record?

Given this input file:

:10000000C0070000D1060000D1000000B1060000CA
<--- address 0010 is skipped
:100020000000000000000000000000005107000078
<--- address 0030 is skipped
:10004000EF000000F9000000030100000D010000B6
:00000001FF

ext_linear_record is 0 when the final data record is handled, so
handle_record_type() returns -1.  I don't understand why the parser
should reject this input file.

I think a rom blob should be added if data records are discontiguous.

> +
> +        /* copy from line buffer to output bin_buf */
> +        memcpy(bin_buf + *current_rom_index, line->data, line->byte_coun=
t);
> +        *current_rom_index +=3D line->byte_count;
> +        *total_size +=3D line->byte_count;
> +        /* Save next address to write */
> +        *next_address_to_write =3D *current_address + line->byte_count;
> +        break;
> +
> +    case EOF_RECORD:
> +        if (*current_rom_index !=3D 0) {
> +            rom_add_blob(filename, bin_buf, *current_rom_index,
> +                         *current_rom_index, addr + *rom_start_address, =
NULL,
> +                         NULL, NULL, as, true);
> +        }
> +        return *total_size;
> +    case EXT_SEG_ADDR_RECORD:
> +    case EXT_LINEAR_ADDR_RECORD:
> +        if (line->byte_count !=3D 2) {
> +            return -1;
> +        }
> +
> +        if (*current_rom_index !=3D 0) {
> +            rom_add_blob(filename, bin_buf, *current_rom_index,
> +                         *current_rom_index, addr + *rom_start_address, =
NULL,
> +                         NULL, NULL, as, true);
> +            memset(bin_buf, 0, *current_rom_index);

This is unnecessary since bin_buf is overwritten from index 0
(*current_rom_index =3D 0 below) before it is read again.

> +            memset(line, 0, sizeof(HexLine));

This is unnecessary since in_process =3D 0 and the next ':' input
character will clear line.

> +        }
> +
> +        *current_rom_index =3D 0;
> +        *ext_linear_record =3D 1;
> +
> +        /* save next address to write,
> +         * in case of non-contiguous block of memory */
> +        *next_address_to_write =3D
> +            line->record_type =3D=3D EXT_SEG_ADDR_RECORD

This is broken because of the memset(line, 0, sizeof(HexLine)) above.

> +                ? ((line->data[0] << 12) | (line->data[1] << 4))
> +                : ((line->data[0] << 24) | (line->data[1] << 16));
> +        break;
> +
> +    case START_SEG_ADDR_RECORD:
> +        /* nothing to do */
> +        break;
> +
> +    case START_LINEAR_ADDR_RECORD:
> +        /* nothing to do */
> +        break;

These record types specify the entry point (the starting address).
Please store the entry point into arm_boot_info->entry so that
do_cpu_reset() starts the CPU at the right address.

> +/* return size or -1 if error */
> +static size_t __parse_hex_blob(const char *filename, const hwaddr addr,

QEMU does not use double underscore function names because they are
reserved by the C standard (see 2.4 in ./HACKING and 7.1.3 in the C
standard).  Please rename this function.

> +                               uint8_t *hex_blob, off_t hex_blob_size,
> +                               uint8_t *bin_buf, AddressSpace *as)
> +{
> +    uint8_t ext_linear_record =3D 1; /* record non-constitutes block */

s/constitutes/contiguous/ ?

> +    uint8_t in_process =3D 0;        /* avoid re-enter and
> +                                    * check whether record begin with ':=
' */

As mentioned in previous review comments, please use bool for boolean
flags and not integer types.

> +/* return size or -1 if error */
> +int load_targphys_hex_as(const char *filename, hwaddr addr, uint64_t max=
_sz,
> +                         AddressSpace *as)
> +{
> +    int size;
> +
> +    size =3D get_image_size(filename);
> +    if (size < 0 || size > max_sz) {

Why check the size of the file?  I'm not sure why the size of the file
matters here.

> +        return -1;
> +    }
> +
> +    return parse_hex_blob(filename, addr, as);
> +}
> diff --git a/include/hw/loader.h b/include/hw/loader.h
> index 5ed3fd8ae67a..2b0cdfe56e70 100644
> --- a/include/hw/loader.h
> +++ b/include/hw/loader.h
> @@ -28,6 +28,20 @@ ssize_t load_image_size(const char *filename, void *ad=
dr, size_t size);
>  int load_image_targphys_as(const char *filename,
>                             hwaddr addr, uint64_t max_sz, AddressSpace *a=
s);
> =20
> +/**load_image_targphys_hex_as:
> + * @filename: Path to the .hex file
> + * @addr: Address to load the .hex file to

Do you have a use in mind for this argument?  It seems like most callers
would pass 0 and treat the Intel HEX file addresses as absolute
addresses.

If there is no real need for this then please drop it.

--LyciRD1jyfeSSjG0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJa3dlxAAoJEJykq7OBq3PIMV8H/jmXq3Sxbl65sVFzZ40ZUIkv
v0yEhuqeFXPwPJx61Daj4JC6y+WeBpyEnVjgzSD3fy0Ow6SVDr0letDkriPVm1iS
hNo7XeMlchc9QmUDyhAf7weR+i6rGRxqMTynI+kI1fsy3KLvCUIfZFuwAu5n2z7e
FH7IcUpttYBv7uKjtwQ0ek02vAPg6pzepinKYjMtsfTcfiPRDvE5Dg4R4K3N9ptl
mCAav+dC5eVtZO+HbnFkM06dhttqjHo7emwavqUeXGPSIyUt4v3+SWroaNDW82bH
vG3rPfSgenyi8KXwkX5uzLLv9RZRhTt3dP/bahCUlZR/P4A98btWe/h+c9Qocaw=
=lwfS
-----END PGP SIGNATURE-----

--LyciRD1jyfeSSjG0--
