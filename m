Received: from eggs.gnu.org ([2001:4830:134:3::10]:42505)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1f7LrE-00073y-W1
	for qemu-devel@nongnu.org; Sat, 14 Apr 2018 10:08:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1f7LrC-0005jj-Lw
	for qemu-devel@nongnu.org; Sat, 14 Apr 2018 10:08:48 -0400
Received: from mail-wr0-x231.google.com ([2a00:1450:400c:c0c::231]:38536)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1f7LrC-0005iy-CV
	for qemu-devel@nongnu.org; Sat, 14 Apr 2018 10:08:46 -0400
Received: by mail-wr0-x231.google.com with SMTP id h3so2101732wrh.5
	for <qemu-devel@nongnu.org>; Sat, 14 Apr 2018 07:08:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1523245158-16443-2-git-send-email-suhang16@mails.ucas.ac.cn>
References: <1523245158-16443-1-git-send-email-suhang16@mails.ucas.ac.cn>
	<1523245158-16443-2-git-send-email-suhang16@mails.ucas.ac.cn>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Sat, 14 Apr 2018 22:08:43 +0800
Message-ID: <CAJSP0QVJbCz=n-huxj3grUtcMAgOYzcExEZHh8rJEoaxnz_jgA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v4 1/2] Implement .hex file loader
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Su Hang <suhang16@mails.ucas.ac.cn>
Cc: qemu-devel <qemu-devel@nongnu.org>, Jim Mussared <jim@groklearning.com>, Joel Stanley <joel@jms.id.au>

On Mon, Apr 9, 2018 at 11:39 AM, Su Hang <suhang16@mails.ucas.ac.cn> wrote:
> This patch adds Intel Hexadecimal Object File format support to
> the loader.  The file format specification is available here:
> http://www.piclist.com/techref/fileext/hex/intel.htm
>
> The file format is mainly intended for embedded systems
> and microcontrollers, such as Arduino, ARM, STM32, etc.
>
> Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Su Hang <suhang16@mails.ucas.ac.cn>
> ---
>  hw/arm/boot.c       |   9 +-
>  hw/core/loader.c    | 280 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  include/hw/loader.h |  17 ++++
>  3 files changed, 305 insertions(+), 1 deletion(-)

Parsers must be robust against invalid inputs so that a corrupt input
file cannot crash QEMU.  Please validate all addresses/offsets/lengths
so that this cannot happen.  For example, the byte_count is currently
not validated and can overflow HexLine.data[].

parse_hex_blob() must handle input files that touch large ranges of
memory.  At the moment it assumes bin_buf will be large enough for the
memory regions described by the input file.  Since Intel HEX files
support 32-bit addressing, that means processing a file in this way
could require 4 GB of RAM!  Three solutions:
1. Reject files that have large gaps in their address ranges.
2. Return a list of data blobs, each with its own start address.
3. Set up the ROM structs directly within parse_hex_blob() instead of
returning a linear buffer.

> diff --git a/hw/arm/boot.c b/hw/arm/boot.c
> index 9319b12fcd2a..07ce54e5936d 100644
> --- a/hw/arm/boot.c
> +++ b/hw/arm/boot.c
> @@ -1060,8 +1060,15 @@ static void arm_load_kernel_notify(Notifier *notifier, void *data)
>          kernel_size = load_aarch64_image(info->kernel_filename,
>                                           info->loader_start, &entry, as);
>          is_linux = 1;
> +    } else if (kernel_size < 0 && strstr(info->kernel_filename, ".hex")) {

Most UNIX-style programs, including QEMU, do not check the file
extension to determine its format.  Instead they look at the contents
of the file to see if it can be parsed.

Please do not check for ".hex".  Try to load it as a hex file and fall
back to the next file type if parsing fails.

> +        /* 32-bit ARM .hex file */
> +        entry = info->loader_start + KERNEL_LOAD_ADDR;
> +        kernel_size = load_targphys_hex_as(info->kernel_filename, entry,
> +                                           info->ram_size - KERNEL_LOAD_ADDR,
> +                                           as);
> +        is_linux = 1;

Why is this needed?  Linux images are not loaded from hex files and
the extra information provided by is_linux = 1 won't be used/tested.

>      } else if (kernel_size < 0) {
> -        /* 32-bit ARM */
> +        /* 32-bit ARM binary file */
>          entry = info->loader_start + KERNEL_LOAD_ADDR;
>          kernel_size = load_image_targphys_as(info->kernel_filename, entry,
>                                               info->ram_size - KERNEL_LOAD_ADDR,
> diff --git a/hw/core/loader.c b/hw/core/loader.c
> index 06bdbca53709..41d714520be4 100644
> --- a/hw/core/loader.c
> +++ b/hw/core/loader.c
> @@ -1286,3 +1286,283 @@ void hmp_info_roms(Monitor *mon, const QDict *qdict)
>          }
>      }
>  }
> +
> +typedef enum HexRecord HexRecord;
> +enum HexRecord {
> +    DATA_RECORD = 0,
> +    EOF_RECORD,
> +    EXT_SEG_ADDR_RECORD,
> +    START_SEG_ADDR_RECORD,
> +    EXT_LINEAR_ADDR_RECORD,
> +    START_LINEAR_ADDR_RECORD,
> +};
> +
> +typedef union HexLine HexLine;
> +union HexLine {
> +    uint8_t buf[0x25];

Why is the length 0x25?  According to the file format specification
the data[] part can be 255 bytes long.

> +    struct __attribute__((packed)) {

This use of packed is not portable since the address field is not
aligned to 16 bits.  Some CPU architectures do not support unaligned
memory accesses and the program would terminate with an exception.

Have you considered using fscanf() instead?  It removes the need for
HexLine, hex_buf, and the character parsing loop:

  if (fscanf(fp, ":%02hhx%04hx%02hhx", &byte_count, &address,
&record_type) != 3) {
      ...
      goto fail;
  }

  our_checksum = byte_count  + ((address >> 8) & 0xff) + (address &
0xff) + record_type;

  for (i = 0; i < byte_count; i++) {
      if (fscanf(fp, "%02hhx", &data[i]) != 1) {
          ...
          goto fail;
      }

      our_checksum += data[i];
  }

  if (fscanf(fp, "%02hhx\n", &checksum) != 1) {
      ...
      goto fail;
  }

  if (our_checksum + checksum != 0) {
      ...
      goto fail;
  }

  ...process record...

> +        uint8_t byte_count;
> +        uint16_t address;
> +        uint8_t record_type;
> +        uint8_t data[0x25 - 0x5];
> +        uint8_t checksum;
> +    };
> +};
> +
> +static uint8_t ctoh(char c)
> +{
> +    return (c & 0x10) ? /*0-9*/ c & 0xf : /*A-F, a-f*/ (c & 0xf) + 9;
> +}

Not needed if you switch to fscanf(), but otherwise please use glib's
g_ascii_xdigit_value():
https://developer.gnome.org/glib/stable/glib-String-Utility-Functions.html#g-ascii-xdigit-value

> +
> +static uint8_t validate_checksum(HexLine *record)
> +{
> +    uint8_t result = 0, i = 0;
> +
> +    for (; i < (record->byte_count + 5); ++i) {

This is an infinite loop when byte_count > 250 since the right-hand
side of the comparison is an int (due to the 5 int literal) but the
left-hand side is a uint8_t.

> +        result += record->buf[i];
> +    }
> +
> +    return result == 0;
> +}
> +
> +/* return pointer of bin_blob or NULL if error */
> +static uint8_t *parse_hex_blob(char *filename, size_t *p_size)
> +{
> +    int fd;
> +    off_t hex_blob_size;
> +    uint8_t *p_data = NULL;
> +    uint8_t *hex_blob;
> +    uint8_t *hex_blob_ori;         /* used to free temporary memory */
> +    uint8_t *bin_buf;
> +    uint8_t *end;
> +    uint8_t idx = 0;
> +    uint8_t in_process = 0;        /* avoid re-enter */
> +    uint8_t low_nibble = 0;        /* process two hex char into 8-bits */
> +    uint8_t ext_linear_record = 0; /* record non-constitutes block */

Please use bool for flags.  QEMU coding style uses the bool type
instead of integer types when there are boolean values.

> +    uint32_t next_address_to_write = 0;
> +    uint32_t current_address = 0;
> +    uint32_t last_address = 0;
> +    HexLine line = {0};
> +
> +    fd = open(filename, O_RDONLY);
> +    if (fd < 0) {
> +        return NULL;
> +    }
> +    hex_blob_size = lseek(fd, 0, SEEK_END);
> +    if (hex_blob_size < 0) {
> +        close(fd);
> +        return NULL;
> +    }
> +    hex_blob = g_malloc(hex_blob_size);
> +    hex_blob_ori = hex_blob;
> +    bin_buf = g_malloc(hex_blob_size * 2);

Why is the size hex_blob_size * 2?

> +    lseek(fd, 0, SEEK_SET);
> +    if (read(fd, hex_blob, hex_blob_size) != hex_blob_size) {
> +        close(fd);
> +        goto hex_parser_exit;
> +    }
> +    close(fd);
> +
> +    memset(line.buf, 0, sizeof(HexLine));

This was already zero-initialized above:

  HexLine line = {0};

> +    end = (uint8_t *)hex_blob + hex_blob_size;
> +
> +    for (; hex_blob != end; ++hex_blob) {
> +        switch ((uint8_t)(*hex_blob)) {

hex_block is already uint8_t.  Why is there a cast?

> +        case '\r':
> +        case '\n':
> +            if (!in_process) {
> +                break;
> +            }
> +
> +            in_process = 0;
> +            if (validate_checksum(&line) == 0) {

There is a small (1/256) chance that checksum validation succeeds when
a truncated line is read.  Please validate the byte count field to
make sure we've read the correct number of bytes.

> +                p_data = NULL;

p_data is already NULL.

> +                goto hex_parser_exit;
> +            }
> +
> +            line.address = bswap16(line.address);

This assumes the host CPU is little-endian.  Please use be16_to_cpu()
instead so it works on big-endian host CPUs too.

> +            switch (line.record_type) {
> +            case DATA_RECORD:
> +                current_address =
> +                    (next_address_to_write & 0xffff0000) | line.address;
> +                /* verify this is a continous block of memory */

s/continous/contiguous/

> +                if (current_address != next_address_to_write ||
> +                    ext_linear_record) {
> +                    if (!ext_linear_record) {
> +                        /* Store next address to write */
> +                        last_address = next_address_to_write;
> +                        next_address_to_write = current_address;
> +                    }
> +                    ext_linear_record = 0;
> +                    memset(bin_buf + last_address, 0x0,
> +                           current_address - last_address);
> +                }
> +
> +                /* copy from line buffer to output bin_buf */
> +                memcpy((uint8_t *)bin_buf + current_address,
> +                       (uint8_t *)line.data, line.byte_count);

bin_buf and line.data are already uint8_t, there is no need to cast.

> +                /* Save next address to write */
> +                last_address = current_address;
> +                next_address_to_write = current_address + line.byte_count;
> +                break;
> +
> +            case EOF_RECORD:
> +                /* nothing to do */
> +                break;
> +            case EXT_SEG_ADDR_RECORD:

Please check that the byte count is 2 for this record type.

> +                /* save next address to write,
> +                 * in case of non-continous block of memory */
> +                ext_linear_record = 1;
> +                last_address = next_address_to_write;
> +                next_address_to_write =
> +                    ((line.data[0] << 12) | (line.data[1] << 4));
> +                break;
> +            case START_SEG_ADDR_RECORD:
> +                /* TODO */

The function should return an error if an unsupported record is encountered.

> +                break;
> +
> +            case EXT_LINEAR_ADDR_RECORD:

Please check that the byte count is 2 for this record type.

> +                /* save next address to write,
> +                 * in case of non-continous block of memory */
> +                ext_linear_record = 1;
> +                last_address = next_address_to_write;
> +                next_address_to_write =
> +                    ((line.data[0] << 24) | (line.data[1] << 16));
> +                break;
> +            case START_LINEAR_ADDR_RECORD:
> +                /* TODO */

The function should return an error if an unsupported record is encountered.

> +                break;
> +
> +            default:
> +                p_data = NULL;

p_data is already NULL.
