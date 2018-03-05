Received: from eggs.gnu.org ([2001:4830:134:3::10]:50934)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1esdgT-0007qg-Dd
	for qemu-devel@nongnu.org; Sun, 04 Mar 2018 19:08:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1esdgP-00043j-Im
	for qemu-devel@nongnu.org; Sun, 04 Mar 2018 19:08:52 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:39198)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1esdgP-00043K-CZ
	for qemu-devel@nongnu.org; Sun, 04 Mar 2018 19:08:49 -0500
Received: by mail-wm0-x244.google.com with SMTP id i3so12247366wmi.4
	for <qemu-devel@nongnu.org>; Sun, 04 Mar 2018 16:08:49 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1520200587-14681-1-git-send-email-stefanb@linux.vnet.ibm.com>
	<1520200587-14681-3-git-send-email-stefanb@linux.vnet.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <4de8d07a-40db-cc86-59e7-6a081c2e526e@amsat.org>
Date: Sun, 4 Mar 2018 21:08:46 -0300
MIME-Version: 1.0
In-Reply-To: <1520200587-14681-3-git-send-email-stefanb@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 2/5] tpm: convert tpm_passthrough.c to use
 trace-events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, dgilbert@redhat.com

On 03/04/2018 06:56 PM, Stefan Berger wrote:
> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/tpm/tpm_passthrough.c | 13 +++----------
>  hw/tpm/trace-events      |  4 ++++
>  2 files changed, 7 insertions(+), 10 deletions(-)
> 
> diff --git a/hw/tpm/tpm_passthrough.c b/hw/tpm/tpm_passthrough.c
> index a495fe0..2589c4d 100644
> --- a/hw/tpm/tpm_passthrough.c
> +++ b/hw/tpm/tpm_passthrough.c
> @@ -31,14 +31,7 @@
>  #include "hw/hw.h"
>  #include "qapi/clone-visitor.h"
>  #include "tpm_util.h"
> -
> -#define DEBUG_TPM 0
> -
> -#define DPRINTF(fmt, ...) do { \
> -    if (DEBUG_TPM) { \
> -        fprintf(stderr, fmt, ## __VA_ARGS__); \
> -    } \
> -} while (0)
> +#include "trace.h"
>  
>  #define TYPE_TPM_PASSTHROUGH "tpm-passthrough"
>  #define TPM_PASSTHROUGH(obj) \
> @@ -137,7 +130,7 @@ static void tpm_passthrough_handle_request(TPMBackend *tb, TPMBackendCmd *cmd,
>  {
>      TPMPassthruState *tpm_pt = TPM_PASSTHROUGH(tb);
>  
> -    DPRINTF("tpm_passthrough: processing command %p\n", cmd);
> +    trace_tpm_passthrough_handle_request(cmd);
>  
>      tpm_passthrough_unix_tx_bufs(tpm_pt, cmd->in, cmd->in_len,
>                                   cmd->out, cmd->out_len, &cmd->selftest_done,
> @@ -146,7 +139,7 @@ static void tpm_passthrough_handle_request(TPMBackend *tb, TPMBackendCmd *cmd,
>  
>  static void tpm_passthrough_reset(TPMBackend *tb)
>  {
> -    DPRINTF("tpm_passthrough: CALL TO TPM_RESET!\n");
> +    trace_tpm_passthrough_reset();
>  
>      tpm_passthrough_cancel_cmd(tb);
>  }
> diff --git a/hw/tpm/trace-events b/hw/tpm/trace-events
> index 336b06d..8557dd9 100644
> --- a/hw/tpm/trace-events
> +++ b/hw/tpm/trace-events
> @@ -3,3 +3,7 @@
>  # hw/tpm/tpm_crb.c
>  tpm_crb_mmio_read(uint64_t addr, unsigned size, uint32_t val) "CRB read 0x" TARGET_FMT_plx " len:%u val: 0x%" PRIx32
>  tpm_crb_mmio_write(uint64_t addr, unsigned size, uint32_t val) "CRB write 0x" TARGET_FMT_plx " len:%u val: 0x%" PRIx32
> +
> +# hw/tpm/tpm_passthrough.c
> +tpm_passthrough_handle_request(void *cmd) "processing command %p"
> +tpm_passthrough_reset(void) "reset"
> 
