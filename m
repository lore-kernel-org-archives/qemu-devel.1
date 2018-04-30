Received: from eggs.gnu.org ([2001:4830:134:3::10]:48268)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fD9iV-0000b1-81
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 10:23:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fD9iR-0008Im-IX
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 10:23:46 -0400
Received: from mail-wr0-x229.google.com ([2a00:1450:400c:c0c::229]:35995)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1fD9iR-0008IL-5W
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 10:23:43 -0400
Received: by mail-wr0-x229.google.com with SMTP id u18-v6so8218648wrg.3
	for <qemu-devel@nongnu.org>; Mon, 30 Apr 2018 07:23:43 -0700 (PDT)
Date: Mon, 30 Apr 2018 15:23:40 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180430142340.GD10576@stefanha-x1.localdomain>
References: <1524750698-16322-1-git-send-email-suhang16@mails.ucas.ac.cn>
	<1524750698-16322-2-git-send-email-suhang16@mails.ucas.ac.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HWvPVVuAAfuRc6SZ"
Content-Disposition: inline
In-Reply-To: <1524750698-16322-2-git-send-email-suhang16@mails.ucas.ac.cn>
Subject: Re: [Qemu-devel] [PATCH v6 1/2] Implement .hex file loader
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


--HWvPVVuAAfuRc6SZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 26, 2018 at 09:51:37PM +0800, Su Hang wrote:
>      if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64) && kernel_size < 0) {
>          kernel_size =3D load_aarch64_image(info->kernel_filename,
>                                           info->loader_start, &entry, as);
>          is_linux =3D 1;
> -    } else if (kernel_size < 0) {
> -        /* 32-bit ARM */
> +    }
> +    if (kernel_size < 0) {
> +        /* 32-bit ARM binary file */
>          entry =3D info->loader_start + KERNEL_LOAD_ADDR;
> -        kernel_size =3D load_image_targphys_as(info->kernel_filename, en=
try,
> -                                             info->ram_size - KERNEL_LOA=
D_ADDR,
> -                                             as);
> +        kernel_size =3D
> +            load_image_targphys_as(info->kernel_filename, entry,
> +                                   info->ram_size - KERNEL_LOAD_ADDR, as=
);

These changes seem unnecessary.

> +/* return 0 or -1 if error */
> +static size_t parse_record(HexLine *line, uint8_t *our_checksum,

size_t is unsigned, so returning -1 is not ideal.  This function only
needs to return success or failure.  Please use bool instead.

> +typedef struct {
> +    const char *filename;
> +    HexLine line;
> +    uint8_t *bin_buf;
> +    hwaddr *addr;
> +    size_t total_size;

Please use int instead of size_t since this is the return value from
load_image_hex_as().

> +    uint32_t next_address_to_write;
> +    uint32_t current_address;
> +    uint32_t current_rom_index;
> +    uint32_t rom_start_address;
> +    AddressSpace *as;
> +} HexParser;
> +
> +/* return size or -1 if error */
> +static size_t handle_record_type(HexParser *parser)

Please use int instead of size_t (see above for reasons).

> +{
> +    HexLine *line =3D &(parser->line);
> +    switch (line->record_type) {
> +    case DATA_RECORD:
> +        parser->current_address =3D
> +            (parser->next_address_to_write & 0xffff0000) | line->address;
> +        /* verify this is a contiguous block of memory */
> +        if (parser->current_address !=3D parser->next_address_to_write) {
> +            if (parser->current_rom_index !=3D 0) {
> +                rom_add_hex_blob_as(parser->filename, parser->bin_buf,
> +                                    parser->current_rom_index,
> +                                    parser->rom_start_address, parser->a=
s);
> +            }
> +            parser->rom_start_address =3D parser->current_address;
> +            parser->current_rom_index =3D 0;
> +        }
> +
> +        /* copy from line buffer to output bin_buf */
> +        memcpy(parser->bin_buf + parser->current_rom_index, line->data,
> +               line->byte_count);
> +        parser->current_rom_index +=3D line->byte_count;
> +        parser->total_size +=3D line->byte_count;
> +        /* save next address to write */
> +        parser->next_address_to_write =3D
> +            parser->current_address + line->byte_count;
> +        break;
> +
> +    case EOF_RECORD:
> +        if (parser->current_rom_index !=3D 0) {
> +            rom_add_hex_blob_as(parser->filename, parser->bin_buf,
> +                                parser->current_rom_index,
> +                                parser->rom_start_address, parser->as);
> +        }
> +        return parser->total_size;
> +    case EXT_SEG_ADDR_RECORD:
> +    case EXT_LINEAR_ADDR_RECORD:
> +        if (line->byte_count !=3D 2 && line->address !=3D 0) {
> +            return -1;
> +        }
> +
> +        if (parser->current_rom_index !=3D 0) {
> +            rom_add_hex_blob_as(parser->filename, parser->bin_buf,
> +                                parser->current_rom_index,
> +                                parser->rom_start_address, parser->as);
> +        }
> +
> +        /* save next address to write,
> +         * in case of non-contiguous block of memory */
> +        parser->next_address_to_write =3D
> +            line->record_type =3D=3D EXT_SEG_ADDR_RECORD
> +                ? ((line->data[0] << 12) | (line->data[1] << 4))
> +                : ((line->data[0] << 24) | (line->data[1] << 16));
> +        parser->rom_start_address =3D parser->next_address_to_write;
> +        parser->current_rom_index =3D 0;
> +        break;
> +
> +    case START_SEG_ADDR_RECORD:

START_SEG_ADDR_RECORD is x86-specific and not implemented by this patch
(the address is given in CS:IP real-mode addressing format and you would
need to calculate the linear address).  Please return an error if this
record type is encountered.

> +    case START_LINEAR_ADDR_RECORD:

Please check that byte_count =3D=3D 4 and address =3D=3D 0.

> +        *(parser->addr) =3D (line->data[0] << 24) | (line->data[1] << 16=
) |
> +                          (line->data[2] << 8) | (line->data[3]);

Please name the field start_addr so its purpose is clear.

> +        break;
> +
> +    default:
> +        return -1;
> +    }
> +
> +    return parser->total_size;
> +}
> +
> +/* return size or -1 if error */
> +static size_t parse_hex_blob(const char *filename, hwaddr *addr,
> +                             uint8_t *hex_blob, off_t hex_blob_size,
> +                             uint8_t *bin_buf, AddressSpace *as)

Please use int instead of size_t (see above for reasons).

> +{
> +    bool in_process =3D false; /* avoid re-enter and
> +                              * check whether record begin with ':' */
> +    uint8_t *end =3D hex_blob + hex_blob_size;
> +    uint8_t our_checksum =3D 0;
> +    uint32_t record_index =3D 0;
> +    HexParser parser =3D {0};
> +    parser.filename =3D filename;
> +    parser.bin_buf =3D bin_buf;
> +    parser.addr =3D addr;
> +    parser.as =3D as;
> +
> +    for (; hex_blob < end; ++hex_blob) {
> +        switch (*hex_blob) {
> +        case '\r':
> +        case '\n':
> +            if (!in_process) {
> +                break;
> +            }
> +
> +            in_process =3D false;
> +            if ((record_index >> 1) - LEN_EXCEPT_DATA !=3D
> +                    parser.line.byte_count ||

A malicious input file can control the following values:
 * record_index using whitespace (see "case default" below)
 * byte_count in range [0x00, 0xff]
 * our_checksum =3D 0 by choosing the right address field values

The input file can use '\n' before any data bytes are read:

  :<whitespace>ff000100\n

The number of whitespace needs to be calculated so that the byte_count
comparison succeeds:

  if ((520 >> 1) - 5 !=3D 0xff || ...)

Therefore 520 - strlen("ff000100") =3D 512 whitespace characters are
required to bypass this check.

Here is what happens: this if statement returns true and
handle_record_type() can be used to load uninitialized heap memory from
bin_buf into the guest.

This is a memory disclosure bug.  The guest must not be able to access
data from QEMU's heap for security reasons (e.g. it can be used to make
additional exploits easier by revealing memory addresses).  QEMU cannot
trust the input file!

record_index must only be incremented when a hex record byte has been
processed, not for whitespace.  I also suggest rewriting the expression
to avoid unsigned underflow and odd division by 2 (4 >> 1 =3D=3D 2 but 5 >>
1 =3D=3D 2 as well!):

  if (LEN_EXCEPT_DATA + parser.line.byte_count * 2 !=3D record_index ||

> +/* return size or -1 if error */
> +int load_targphys_hex_as(const char *filename, hwaddr *addr, uint64_t ma=
x_sz,

max_sz is unused.

> +                         AddressSpace *as)
> +{
> +    int fd;
> +    off_t hex_blob_size;
> +    uint8_t *hex_blob;
> +    uint8_t *bin_buf;
> +    size_t total_size =3D 0;

Please use int instead of size_t (see above for reasons).

> diff --git a/include/hw/loader.h b/include/hw/loader.h
> index 5ed3fd8ae67a..728198a91ef9 100644
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
> + * @addr: Store the entry point get from .hex file

"addr" is vague, please name this argument "entry".

--HWvPVVuAAfuRc6SZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJa5ybsAAoJEJykq7OBq3PIjzMIAIPLVtSaOqeDZT5RmA0tjiym
s0bl4XfqHK8BTNxRFjHOj77g64DCGQmx/kRH+ST2PgdpbfoIAcRXhS8Sk2w4oVy9
azibif2pS2dp/eD36GA+kIA1MYiuRi/5L+TDM5VmosVGrtgNSeNibmetd2W5WoCC
zYc0h5dn6vhtVaeVrFr8/qyHi1bm0qPbTJPqT6MWh9DA119qyFPaLPWIbyZGxQb/
0Acuv/wAO1GQ+99RoYlb2f3mn8mBN82xZRkKyicLe/Y9eOY96XAU85gSRFdUTrFK
ycle4QG/c+bactrbunyVDwj9SdDeN8z38sp5JIw+CHsZejh/CSU67/KbKTqgdGE=
=ZLHf
-----END PGP SIGNATURE-----

--HWvPVVuAAfuRc6SZ--
