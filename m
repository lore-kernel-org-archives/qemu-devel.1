Received: from eggs.gnu.org ([2001:4830:134:3::10]:48481)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dmz8Y-000678-N3
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 05:18:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dmz8T-0007k2-K6
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 05:18:14 -0400
Date: Wed, 30 Aug 2017 10:17:57 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170830091757.GD24565@stefanha-x1.localdomain>
References: <20170829204934.9039-1-jsnow@redhat.com>
	<20170829204934.9039-9-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170829204934.9039-9-jsnow@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2 8/9] AHCI: pretty-print FIS
 to buffer instead of stderr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, f4bug@amsat.org

On Tue, Aug 29, 2017 at 04:49:33PM -0400, John Snow wrote:
> The current FIS printing routines dump the FIS to screen. adjust this
> such that it dumps to buffer instead, then use this ability to have
> FIS dump mechanisms via trace-events instead of compiled defines.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  hw/ide/ahci.c       | 54 +++++++++++++++++++++++++++++++++++++++++++----------
>  hw/ide/trace-events |  4 ++++
>  2 files changed, 48 insertions(+), 10 deletions(-)
> 
> diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
> index a0a4dd6..2e75f9b 100644
> --- a/hw/ide/ahci.c
> +++ b/hw/ide/ahci.c
> @@ -644,20 +644,45 @@ static void ahci_reset_port(AHCIState *s, int port)
>      ahci_init_d2h(d);
>  }
>  
> -static void debug_print_fis(uint8_t *fis, int cmd_len)
> +/* Buffer pretty output based on a raw FIS structure. */
> +static void ahci_pretty_buffer_fis(uint8_t *fis, int cmd_len, char **out)

Simplified function using GString:

  static char *ahci_pretty_buffer_fis(const uint8_t *fis, int cmd_len)
  {
      GString *s = g_string_new("FIS:");
      int i;

      for (i = 0; i < cmd_len; i++) {
          if (i % 16 == 0) {
              g_string_append_printf(s, "\n0x%02x:", i);
	  }

          g_string_append_printf(s, " %02x", fis[i]);
      }

      g_string_append_c('\n');
      return g_string_free(s, FALSE);
  }

It's less efficient due to extra mallocs but a lot easier to read.

>  {
> -#if DEBUG_AHCI
> +    size_t bufsize;
> +    char *pbuf;
> +    char *pptr;
> +    size_t lines = DIV_ROUND_UP(cmd_len, 16);
> +    const char *preamble = "FIS:";
>      int i;
>  
> -    fprintf(stderr, "fis:");
> +    /* Total amount of memory to store FISes in HBA memory */
> +    g_assert_cmpint(cmd_len, <=, 0x100);
> +    g_assert(out);
> +
> +    /* Printed like:
> +     * FIS:\n
> +     * 0x00: 00 11 22 33 44 55 66 77 88 99 aa bb cc dd ee \n
> +     * 0x10: ff \n
> +     * \0
> +     *
> +     * Four bytes for the preamble, seven for each line prefix (including a
> +     * newline to start a new line), three bytes for each source byte,
> +     * a trailing newline and a terminal null byte.
> +     */
> +
> +    bufsize = strlen(preamble) + ((6 + 1) * lines) + (3 * cmd_len) + 1 + 1;
> +    pbuf = g_malloc(bufsize);
> +    pptr = pbuf;
> +    pptr += sprintf(pptr, "%s", preamble);
>      for (i = 0; i < cmd_len; i++) {
>          if ((i & 0xf) == 0) {
> -            fprintf(stderr, "\n%02x:",i);
> +            pptr += sprintf(pptr, "\n0x%02x: ", i);
>          }
> -        fprintf(stderr, "%02x ",fis[i]);
> +        pptr += sprintf(pptr, "%02x ", fis[i]);
>      }
> -    fprintf(stderr, "\n");
> -#endif
> +    pptr += sprintf(pptr, "\n");
> +    pptr += 1; /* \0 */
> +    g_assert(pbuf + bufsize == pptr);
> +    *out = pbuf;
>  }
>  
>  static bool ahci_map_fis_address(AHCIDevice *ad)
> @@ -1201,7 +1226,12 @@ static void handle_reg_h2d_fis(AHCIState *s, int port,
>       * table to ide_state->io_buffer */
>      if (opts & AHCI_CMD_ATAPI) {
>          memcpy(ide_state->io_buffer, &cmd_fis[AHCI_COMMAND_TABLE_ACMD], 0x10);
> -        debug_print_fis(ide_state->io_buffer, 0x10);
> +        if (TRACE_HANDLE_REG_H2D_FIS_DUMP_ENABLED) {

This should probably be:

  if (trace_event_get_state_backends(TRACE_HANDLE_REG_H2D_FIS_DUMP)) {

The difference is that TRACE_HANDLE_REG_H2D_FIS_DUMP_ENABLED is set at
compile time while trace_event_get_state_backends() checks if the event
is enabled at run-time.

Therefore TRACE_HANDLE_REG_H2D_FIS_DUMP_ENABLED causes the trace event
to fire even when the user hasn't enabled the trace event yet.  That
would be a waste of CPU.

> +            char *pretty_fis;
> +            ahci_pretty_buffer_fis(ide_state->io_buffer, 0x10, &pretty_fis);
> +            trace_handle_reg_h2d_fis_dump(s, port, pretty_fis);
> +            g_free(pretty_fis);
> +        }
>          s->dev[port].done_atapi_packet = false;
>          /* XXX send PIO setup FIS */
>      }
> @@ -1256,8 +1286,12 @@ static int handle_cmd(AHCIState *s, int port, uint8_t slot)
>          trace_handle_cmd_badmap(s, port, cmd_len);
>          goto out;
>      }
> -    debug_print_fis(cmd_fis, 0x80);
> -
> +    if (TRACE_HANDLE_CMD_FIS_DUMP_ENABLED) {

Same here.

> +        char *pretty_fis;
> +        ahci_pretty_buffer_fis(cmd_fis, 0x80, &pretty_fis);
> +        trace_handle_cmd_fis_dump(s, port, pretty_fis);
> +        g_free(pretty_fis);
> +    }
>      switch (cmd_fis[0]) {
>          case SATA_FIS_TYPE_REGISTER_H2D:
>              handle_reg_h2d_fis(s, port, slot, cmd_fis);
> diff --git a/hw/ide/trace-events b/hw/ide/trace-events
> index e15fd77..77ed3c1 100644
> --- a/hw/ide/trace-events
> +++ b/hw/ide/trace-events
> @@ -105,3 +105,7 @@ ahci_cmd_done(void *s, int port) "ahci(%p)[%d]: cmd done"
>  ahci_reset(void *s) "ahci(%p): HBA reset"
>  allwinner_ahci_mem_read(void *s, void *a, uint64_t addr, uint64_t val, unsigned size) "ahci(%p): read a=%p addr=0x%"HWADDR_PRIx" val=0x%"PRIx64", size=%d"
>  allwinner_ahci_mem_write(void *s, void *a, uint64_t addr, uint64_t val, unsigned size) "ahci(%p): write a=%p addr=0x%"HWADDR_PRIx" val=0x%"PRIx64", size=%d"
> +
> +# Warning: Verbose
> +handle_reg_h2d_fis_dump(void *s, int port, char *fis) "ahci(%p)[%d]: %s"

const char *fis

> +handle_cmd_fis_dump(void *s, int port, char *fis) "ahci(%p)[%d]: %s"

const char *fis
