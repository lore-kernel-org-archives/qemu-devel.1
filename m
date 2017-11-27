Received: from eggs.gnu.org ([2001:4830:134:3::10]:40452)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eJGDL-0005Rz-1H
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 05:00:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eJGDF-000203-6l
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 05:00:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35800)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1eJGDE-0001zG-U9
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 05:00:29 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20171127041038.22819-1-doug16k@gmail.com>
Date: Mon, 27 Nov 2017 11:00:24 +0100
In-Reply-To: <20171127041038.22819-1-doug16k@gmail.com> (Doug Gale's message
	of "Sun, 26 Nov 2017 23:10:38 -0500")
Message-ID: <87vahwavnr.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] gdbstub: add tracing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Doug Gale <doug16k@gmail.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@gmail.com>

Drive-by question...

Doug Gale <doug16k@gmail.com> writes:

> Signed-off-by: Doug Gale <doug16k@gmail.com>
> ---
>  gdbstub.c    | 100 ++++++++++++++++++++++++++++++++++++++---------------------
>  trace-events |  21 +++++++++++++
>  2 files changed, 86 insertions(+), 35 deletions(-)
>
> diff --git a/gdbstub.c b/gdbstub.c
> index 2a94030d3b..a75f319bd0 100644
> --- a/gdbstub.c
> +++ b/gdbstub.c
> @@ -21,6 +21,7 @@
>  #include "qemu/error-report.h"
>  #include "qemu/cutils.h"
>  #include "cpu.h"
> +#include "trace-root.h"
>  #ifdef CONFIG_USER_ONLY
>  #include "qemu.h"
>  #else
> @@ -287,21 +288,6 @@ static int gdb_signal_to_target (int sig)
>          return -1;
>  }
>  
> -/* #define DEBUG_GDB */
> -
> -#ifdef DEBUG_GDB
> -# define DEBUG_GDB_GATE 1
> -#else
> -# define DEBUG_GDB_GATE 0
> -#endif
> -
> -#define gdb_debug(fmt, ...) do { \
> -    if (DEBUG_GDB_GATE) { \
> -        fprintf(stderr, "%s: " fmt, __func__, ## __VA_ARGS__); \
> -    } \
> -} while (0)
> -
> -
>  typedef struct GDBRegisterState {
>      int base_reg;
>      int num_regs;
> @@ -538,12 +524,47 @@ static void hextomem(uint8_t *mem, const char *buf, int len)
>      }
>  }
>  
> +static void hexdump(const char *buf, int len,
> +                    void (*trace_fn)(size_t ofs, char const *text))
> +{
> +    char line_buffer[3 * 16 + 4 + 16 + 1];
> +
> +    for (size_t i = 0; i < len || (i & 0xF); ++i) {
> +        size_t byte_ofs = i & 15;
> +
> +        if (byte_ofs == 0) {
> +            memset(line_buffer, ' ', 3 * 16 + 4 + 16);
> +            line_buffer[3 * 16 + 4 + 16] = 0;
> +        }
> +
> +        size_t col_group = (i >> 2) & 3;
> +        size_t hex_col = byte_ofs * 3 + col_group;
> +        size_t txt_col = 3 * 16 + 4 + byte_ofs;
> +
> +        if (i < len) {
> +            char value = buf[i];
> +
> +            line_buffer[hex_col + 0] = tohex((value >> 4) & 0xF);
> +            line_buffer[hex_col + 1] = tohex((value >> 0) & 0xF);
> +            line_buffer[txt_col + 0] = (value >= ' ' && value < 127)
> +                    ? value
> +                    : '.';
> +        }
> +
> +        if (byte_ofs == 0xF)
> +            trace_fn(i & -16, line_buffer);
> +    }
> +}

Could existing qemu_hexdump() serve?

> +
>  /* return -1 if error, 0 if OK */
> -static int put_packet_binary(GDBState *s, const char *buf, int len)
> +static int put_packet_binary(GDBState *s, const char *buf, int len, bool dump)
>  {
>      int csum, i;
>      uint8_t *p;
>  
> +    if (TRACE_GDBSTUB_IO_BINARYREPLY_ENABLED && dump)
> +        hexdump(buf, len, trace_gdbstub_io_binaryreply);
> +
>      for(;;) {
>          p = s->last_packet;
>          *(p++) = '$';
[...]
