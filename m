Received: from eggs.gnu.org ([2001:4830:134:3::10]:49837)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dG5SW-0000YM-9Y
	for qemu-devel@nongnu.org; Wed, 31 May 2017 11:22:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dG5ST-0001n0-3g
	for qemu-devel@nongnu.org; Wed, 31 May 2017 11:22:52 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:36392)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dG5SS-0001mV-Tc
	for qemu-devel@nongnu.org; Wed, 31 May 2017 11:22:49 -0400
Received: by mail-oi0-x243.google.com with SMTP id w138so2390294oiw.3
	for <qemu-devel@nongnu.org>; Wed, 31 May 2017 08:22:48 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170531150933.10156-1-alex.bennee@linaro.org>
	<20170531150933.10156-2-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <46b87a09-7b7e-8408-9028-49667f6253f1@amsat.org>
Date: Wed, 31 May 2017 12:22:46 -0300
MIME-Version: 1.0
In-Reply-To: <20170531150933.10156-2-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1 1/2] gdbstub: modernise DEBUG_GDB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, pbonzini@redhat.com, doug16k@gmail.com, imbrenda@linux.vnet.ibm.com
Cc: qemu-devel@nongnu.org

On 05/31/2017 12:09 PM, Alex Bennée wrote:
> Convert the a gdb_debug helper which compiles away to nothing when not
> used but still ensures the format strings are checked. There is some
> minor code motion for the incorrect checksum message to report it
> before we attempt to send the reply.
>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  gdbstub.c | 77 +++++++++++++++++++++++++++------------------------------------
>  1 file changed, 33 insertions(+), 44 deletions(-)
>
> diff --git a/gdbstub.c b/gdbstub.c
> index 86eed4f97c..a249846954 100644
> --- a/gdbstub.c
> +++ b/gdbstub.c
> @@ -271,7 +271,20 @@ static int gdb_signal_to_target (int sig)
>          return -1;
>  }
>
> -//#define DEBUG_GDB
> +/* #define DEBUG_GDB */
> +
> +#ifdef DEBUG_GDB
> +# define DEBUG_GDB_GATE 1
> +#else
> +# define DEBUG_GDB_GATE 0
> +#endif
> +
> +#define gdb_debug(fmt, ...) do { \
> +    if (DEBUG_GDB_GATE) { \
> +        fprintf(stderr, "%s: " fmt, __func__, ## __VA_ARGS__); \
> +    } \
> +} while (0)
> +
>
>  typedef struct GDBRegisterState {
>      int base_reg;
> @@ -547,9 +560,7 @@ static int put_packet_binary(GDBState *s, const char *buf, int len)
>  /* return -1 if error, 0 if OK */
>  static int put_packet(GDBState *s, const char *buf)
>  {
> -#ifdef DEBUG_GDB
> -    printf("reply='%s'\n", buf);
> -#endif
> +    gdb_debug("reply='%s'\n", buf);
>
>      return put_packet_binary(s, buf, strlen(buf));
>  }
> @@ -955,9 +966,9 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
>      uint8_t *registers;
>      target_ulong addr, len;
>
> -#ifdef DEBUG_GDB
> -    printf("command='%s'\n", line_buf);
> -#endif
> +
> +    gdb_debug("command='%s'\n", line_buf);
> +
>      p = line_buf;
>      ch = *p++;
>      switch(ch) {
> @@ -1518,17 +1529,14 @@ static void gdb_read_byte(GDBState *s, int ch)
>          /* Waiting for a response to the last packet.  If we see the start
>             of a new command then abandon the previous response.  */
>          if (ch == '-') {
> -#ifdef DEBUG_GDB
> -            printf("Got NACK, retransmitting\n");
> -#endif
> +            gdb_debug("Got NACK, retransmitting\n");
>              put_buffer(s, (uint8_t *)s->last_packet, s->last_packet_len);
> +        } else if (ch == '+') {
> +            gdb_debug("Got ACK\n");
> +        } else {
> +            gdb_debug("Got '%c' when expecting ACK/NACK\n", ch);
>          }
> -#ifdef DEBUG_GDB
> -        else if (ch == '+')
> -            printf("Got ACK\n");
> -        else
> -            printf("Got '%c' when expecting ACK/NACK\n", ch);
> -#endif
> +
>          if (ch == '+' || ch == '$')
>              s->last_packet_len = 0;
>          if (ch != '$')
> @@ -1549,9 +1557,7 @@ static void gdb_read_byte(GDBState *s, int ch)
>                  s->line_sum = 0;
>                  s->state = RS_GETLINE;
>              } else {
> -#ifdef DEBUG_GDB
> -                printf("gdbstub received garbage between packets: 0x%x\n", ch);
> -#endif
> +                gdb_debug("received garbage between packets: 0x%x\n", ch);
>              }
>              break;
>          case RS_GETLINE:
> @@ -1567,9 +1573,7 @@ static void gdb_read_byte(GDBState *s, int ch)
>                  /* end of command, start of checksum*/
>                  s->state = RS_CHKSUM1;
>              } else if (s->line_buf_index >= sizeof(s->line_buf) - 1) {
> -#ifdef DEBUG_GDB
> -                printf("gdbstub command buffer overrun, dropping command\n");
> -#endif
> +                gdb_debug("command buffer overrun, dropping command\n");
>                  s->state = RS_IDLE;
>              } else {
>                  /* unescaped command character */
> @@ -1583,9 +1587,7 @@ static void gdb_read_byte(GDBState *s, int ch)
>                  s->state = RS_CHKSUM1;
>              } else if (s->line_buf_index >= sizeof(s->line_buf) - 1) {
>                  /* command buffer overrun */
> -#ifdef DEBUG_GDB
> -                printf("gdbstub command buffer overrun, dropping command\n");
> -#endif
> +                gdb_debug("command buffer overrun, dropping command\n");
>                  s->state = RS_IDLE;
>              } else {
>                  /* parse escaped character and leave escape state */
> @@ -1597,25 +1599,18 @@ static void gdb_read_byte(GDBState *s, int ch)
>          case RS_GETLINE_RLE:
>              if (ch < ' ') {
>                  /* invalid RLE count encoding */
> -#ifdef DEBUG_GDB
> -                printf("gdbstub got invalid RLE count: 0x%x\n", ch);
> -#endif
> +                gdb_debug("got invalid RLE count: 0x%x\n", ch);
>                  s->state = RS_GETLINE;
>              } else {
>                  /* decode repeat length */
>                  int repeat = (unsigned char)ch - ' ' + 3;
>                  if (s->line_buf_index + repeat >= sizeof(s->line_buf) - 1) {
>                      /* that many repeats would overrun the command buffer */
> -#ifdef DEBUG_GDB
> -                    printf("gdbstub command buffer overrun,"
> -                           " dropping command\n");
> -#endif
> +                    gdb_debug("command buffer overrun, dropping command\n");
>                      s->state = RS_IDLE;
>                  } else if (s->line_buf_index < 1) {
>                      /* got a repeat but we have nothing to repeat */
> -#ifdef DEBUG_GDB
> -                    printf("gdbstub got invalid RLE sequence\n");
> -#endif
> +                    gdb_debug("got invalid RLE sequence\n");
>                      s->state = RS_GETLINE;
>                  } else {
>                      /* repeat the last character */
> @@ -1630,9 +1625,7 @@ static void gdb_read_byte(GDBState *s, int ch)
>          case RS_CHKSUM1:
>              /* get high hex digit of checksum */
>              if (!isxdigit(ch)) {
> -#ifdef DEBUG_GDB
> -                printf("gdbstub got invalid command checksum digit\n");
> -#endif
> +                gdb_debug("got invalid command checksum digit\n");
>                  s->state = RS_GETLINE;
>                  break;
>              }
> @@ -1643,21 +1636,17 @@ static void gdb_read_byte(GDBState *s, int ch)
>          case RS_CHKSUM2:
>              /* get low hex digit of checksum */
>              if (!isxdigit(ch)) {
> -#ifdef DEBUG_GDB
> -                printf("gdbstub got invalid command checksum digit\n");
> -#endif
> +                gdb_debug("got invalid command checksum digit\n");
>                  s->state = RS_GETLINE;
>                  break;
>              }
>              s->line_csum |= fromhex(ch);
>
>              if (s->line_csum != (s->line_sum & 0xff)) {
> +                gdb_debug("got command packet with incorrect checksum\n");
>                  /* send NAK reply */
>                  reply = '-';
>                  put_buffer(s, &reply, 1);
> -#ifdef DEBUG_GDB
> -                printf("gdbstub got command packet with incorrect checksum\n");
> -#endif
>                  s->state = RS_IDLE;
>              } else {
>                  /* send ACK reply */
>
