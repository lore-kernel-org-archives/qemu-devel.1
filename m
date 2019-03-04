Received: from eggs.gnu.org ([209.51.188.92]:55242)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h0wjE-0000aJ-4i
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 18:10:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h0wjD-00088h-2T
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 18:10:36 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38228)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1h0wjC-00086v-QK
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 18:10:35 -0500
Received: by mail-wm1-f68.google.com with SMTP id a188so752564wmf.3
	for <qemu-devel@nongnu.org>; Mon, 04 Mar 2019 15:10:34 -0800 (PST)
References: <20190304180920.21534-1-svens@stackframe.org>
	<20190304180920.21534-4-svens@stackframe.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <ead4b6ba-2c5c-6411-5a4f-8eca32dcfd90@redhat.com>
Date: Tue, 5 Mar 2019 00:10:31 +0100
MIME-Version: 1.0
In-Reply-To: <20190304180920.21534-4-svens@stackframe.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 4/5] lsi: use SCSI phase names instead of
 numbers in trace
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sven Schnelle <svens@stackframe.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Fam Zheng <fam@euphon.net>, "open list:All patches CC here" <qemu-devel@nongnu.org>

Hi Sven,

On 3/4/19 7:09 PM, Sven Schnelle wrote:
> Signed-off-by: Sven Schnelle <svens@stackframe.org>
> ---
>  hw/scsi/lsi53c895a.c | 24 ++++++++++++++++++------
>  hw/scsi/trace-events |  4 ++--
>  2 files changed, 20 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
> index d1eb2cf074..f635d56e0f 100644
> --- a/hw/scsi/lsi53c895a.c
> +++ b/hw/scsi/lsi53c895a.c
> @@ -184,6 +184,17 @@ static const char *names[] = {
>  /* Flag set if this is a tagged command.  */
>  #define LSI_TAG_VALID     (1 << 16)
>  
> +static const char *scsi_phases[] = {
> +    "DOUT",
> +    "DIN",
> +    "CMD",
> +    "STATUS",
> +    "RSVIN",
> +    "RSVOUT",
> +    "MSGOUT",
> +    "MSGIN"
> +};

Some developper might use your code but forget to use value &
PHASE_MASK, trying on small values, then another user uses bigger values
and this array will return unexpected result.

static const char *scsi_phase_name(int phase)
{
  static const char *scsi_phases[8] = {
    [PHASE_DO] = "DOUT",
    [PHASE_DI] = "DIN",
    [PHASE_CMD] = "CMD",
    [PHASE_ST] = "STATUS",
    [PHASE_MO] = "MSGOUT",
    [PHASE_MI] = "MSGIN",
  };
  phase &= PHASE_MASK;
  return scsi_phases[phase] ? scsi_phases[phase] : "RESERVED";
}

You can also keep your RSVIN/RSVOUT:

static const char *scsi_phase_name(int phase)
{
  static const char *scsi_phases[8] = {
    "DOUT",
    "DIN",
    "CMD",
    "STATUS",
    "RSVIN",
    "RSVOUT",
    "MSGOUT",
    "MSGIN"
  };
  return scsi_phases[phase & PHASE_MASK];
}

In both cases, calls are easier to read:

            trace_lsi_execute_script_blockmove_badphase(
                    scsi_phase_name(s->sstat1),
                    scsi_phase_name(insn >> 24));

> +
>  typedef struct lsi_request {
>      SCSIRequest *req;
>      uint32_t tag;
> @@ -1201,8 +1212,9 @@ again:
>              s->ia = s->dsp - 12;
>          }
>          if ((s->sstat1 & PHASE_MASK) != ((insn >> 24) & 7)) {
> -            trace_lsi_execute_script_blockmove_badphase(s->sstat1 & PHASE_MASK,
> -                                                        (insn >> 24) & 7);
> +            trace_lsi_execute_script_blockmove_badphase(
> +                    scsi_phases[s->sstat1 & PHASE_MASK],
> +                    scsi_phases[(insn >> 24) & 7]);
>              lsi_script_scsi_interrupt(s, LSI_SIST0_MA, 0);
>              break;
>          }
> @@ -1234,8 +1246,8 @@ again:
>              lsi_do_msgin(s);
>              break;
>          default:
> -            qemu_log_mask(LOG_UNIMP, "lsi_scsi: Unimplemented phase %d\n",
> -                          s->sstat1 & PHASE_MASK);
> +            qemu_log_mask(LOG_UNIMP, "lsi_scsi: Unimplemented phase %s\n",
> +                          scsi_phases[s->sstat1 & PHASE_MASK]);
>          }
>          s->dfifo = s->dbc & 0xff;
>          s->ctest5 = (s->ctest5 & 0xfc) | ((s->dbc >> 8) & 3);
> @@ -1462,9 +1474,9 @@ again:
>              }
>              if (cond == jmp && (insn & (1 << 17))) {
>                  trace_lsi_execute_script_tc_compp(
> -                        (s->sstat1 & PHASE_MASK),
> +                        scsi_phases[(s->sstat1 & PHASE_MASK)],

No need for parenthesis here,

>                          jmp ? '=' : '!',
> -                        ((insn >> 24) & 7));
> +                        scsi_phases[((insn >> 24) & 7)]);

Ditto.

>                  cond = (s->sstat1 & PHASE_MASK) == ((insn >> 24) & 7);
>              }
>              if (cond == jmp && (insn & (1 << 18))) {
> diff --git a/hw/scsi/trace-events b/hw/scsi/trace-events
> index 29aaa752d1..34feb6f42d 100644
> --- a/hw/scsi/trace-events
> +++ b/hw/scsi/trace-events
> @@ -268,7 +268,7 @@ lsi_memcpy(uint32_t dest, uint32_t src, int count) "memcpy dest 0x%"PRIx32" src
>  lsi_wait_reselect(void) "Wait Reselect"
>  lsi_execute_script(uint32_t dsp, uint32_t insn, uint32_t addr) "SCRIPTS dsp=0x%"PRIx32" opcode 0x%"PRIx32" arg 0x%"PRIx32
>  lsi_execute_script_blockmove_delayed(void) "Delayed select timeout"
> -lsi_execute_script_blockmove_badphase(uint8_t phase, uint8_t expected) "Wrong phase got %d expected %d"
> +lsi_execute_script_blockmove_badphase(const char *phase, const char *expected) "Wrong phase got %s expected %s"
>  lsi_execute_script_io_alreadyreselected(void) "Already reselected, jumping to alternative address"
>  lsi_execute_script_io_selected(uint8_t id, const char *atn) "Selected target %d%s"
>  lsi_execute_script_io_disconnect(void) "Wait Disconnect"
> @@ -278,7 +278,7 @@ lsi_execute_script_io_opcode(const char *opcode, int reg, const char *opname, ui
>  lsi_execute_script_tc_nop(void) "NOP"
>  lsi_execute_script_tc_delayedselect_timeout(void) "Delayed select timeout"
>  lsi_execute_script_tc_compc(int result) "Compare carry %d"
> -lsi_execute_script_tc_compp(uint8_t phase, int op, uint8_t insn_phase) "Compare phase %d %c= %d"
> +lsi_execute_script_tc_compp(const char *phase, int op, const char *insn_phase) "Compare phase %s %c= %s"

Since you change this line, can you fix 'int op' -> 'char op'?
Or as a previous cleanup patch... There are other '%c' misused.

>  lsi_execute_script_tc_compd(uint32_t sfbr, uint8_t mask, int op, int result) "Compare data 0x%"PRIx32" & 0x%x %c= 0x%x"
>  lsi_execute_script_tc_jump(uint32_t addr) "Jump to 0x%"PRIx32
>  lsi_execute_script_tc_call(uint32_t addr) "Call 0x%"PRIx32
> 

Regards,

Phil.
