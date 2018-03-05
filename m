Received: from eggs.gnu.org ([2001:4830:134:3::10]:51047)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1esdgf-00080v-Oa
	for qemu-devel@nongnu.org; Sun, 04 Mar 2018 19:09:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1esdgc-0004Co-Hp
	for qemu-devel@nongnu.org; Sun, 04 Mar 2018 19:09:05 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:33936)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1esdgc-0004Bq-8F
	for qemu-devel@nongnu.org; Sun, 04 Mar 2018 19:09:02 -0500
Received: by mail-wm0-x242.google.com with SMTP id a20so10806317wmd.1
	for <qemu-devel@nongnu.org>; Sun, 04 Mar 2018 16:09:02 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1520200587-14681-1-git-send-email-stefanb@linux.vnet.ibm.com>
	<1520200587-14681-4-git-send-email-stefanb@linux.vnet.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <a542bdfe-27a4-6676-25a2-0b6ebf03e169@amsat.org>
Date: Sun, 4 Mar 2018 21:08:59 -0300
MIME-Version: 1.0
In-Reply-To: <1520200587-14681-4-git-send-email-stefanb@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 3/5] tpm: convert tpm_util.c to use
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
>  hw/tpm/tpm_util.c   | 29 ++++++++++++-----------------
>  hw/tpm/trace-events |  7 +++++++
>  2 files changed, 19 insertions(+), 17 deletions(-)
> 
> diff --git a/hw/tpm/tpm_util.c b/hw/tpm/tpm_util.c
> index 2de52a0..ee41757 100644
> --- a/hw/tpm/tpm_util.c
> +++ b/hw/tpm/tpm_util.c
> @@ -28,14 +28,7 @@
>  #include "exec/memory.h"
>  #include "sysemu/tpm_backend.h"
>  #include "hw/qdev.h"
> -
> -#define DEBUG_TPM 0
> -
> -#define DPRINTF(fmt, ...) do { \
> -    if (DEBUG_TPM) { \
> -        fprintf(stderr, "tpm-util:"fmt"\n", ## __VA_ARGS__); \
> -    } \
> -} while (0)
> +#include "trace.h"
>  
>  /* tpm backend property */
>  
> @@ -279,10 +272,11 @@ int tpm_util_get_buffer_size(int tpm_fd, TPMVersion tpm_version,
>  
>          if (be32_to_cpu(tpm_resp.hdr.len) != sizeof(tpm_resp) ||
>              be32_to_cpu(tpm_resp.len) != sizeof(uint32_t)) {
> -            DPRINTF("tpm_resp->hdr.len = %u, expected = %zu\n",
> -                    be32_to_cpu(tpm_resp.hdr.len), sizeof(tpm_resp));
> -            DPRINTF("tpm_resp->len = %u, expected = %zu\n",
> -                    be32_to_cpu(tpm_resp.len), sizeof(uint32_t));
> +            trace_tpm_util_get_buffer_size_hdr_len(
> +                be32_to_cpu(tpm_resp.hdr.len),
> +                sizeof(tpm_resp));
> +            trace_tpm_util_get_buffer_size_len(be32_to_cpu(tpm_resp.len),
> +                                               sizeof(uint32_t));
>              error_report("tpm_util: Got unexpected response to "
>                           "TPM_GetCapability; errcode: 0x%x",
>                           be32_to_cpu(tpm_resp.hdr.errcode));
> @@ -327,10 +321,11 @@ int tpm_util_get_buffer_size(int tpm_fd, TPMVersion tpm_version,
>  
>          if (be32_to_cpu(tpm2_resp.hdr.len) != sizeof(tpm2_resp) ||
>              be32_to_cpu(tpm2_resp.count) != 2) {
> -            DPRINTF("tpm2_resp->hdr.len = %u, expected = %zu\n",
> -                    be32_to_cpu(tpm2_resp.hdr.len), sizeof(tpm2_resp));
> -            DPRINTF("tpm2_resp->len = %u, expected = %u\n",
> -                    be32_to_cpu(tpm2_resp.count), 2);
> +            trace_tpm_util_get_buffer_size_hdr_len2(
> +                be32_to_cpu(tpm2_resp.hdr.len),
> +                sizeof(tpm2_resp));
> +            trace_tpm_util_get_buffer_size_len2(
> +                be32_to_cpu(tpm2_resp.count), 2);
>              error_report("tpm_util: Got unexpected response to "
>                           "TPM2_GetCapability; errcode: 0x%x",
>                           be32_to_cpu(tpm2_resp.hdr.errcode));
> @@ -344,7 +339,7 @@ int tpm_util_get_buffer_size(int tpm_fd, TPMVersion tpm_version,
>          return -EFAULT;
>      }
>  
> -    DPRINTF("buffersize of device: %zu\n", *buffersize);
> +    trace_tpm_util_get_buffer_size(*buffersize);
>  
>      return 0;
>  }
> diff --git a/hw/tpm/trace-events b/hw/tpm/trace-events
> index 8557dd9..66b2b91 100644
> --- a/hw/tpm/trace-events
> +++ b/hw/tpm/trace-events
> @@ -7,3 +7,10 @@ tpm_crb_mmio_write(uint64_t addr, unsigned size, uint32_t val) "CRB write 0x" TA
>  # hw/tpm/tpm_passthrough.c
>  tpm_passthrough_handle_request(void *cmd) "processing command %p"
>  tpm_passthrough_reset(void) "reset"
> +
> +# hw/tpm/tpm_util.c
> +tpm_util_get_buffer_size_hdr_len(uint32_t len, size_t expected) "tpm_resp->hdr.len = %u, expected = %zu"
> +tpm_util_get_buffer_size_len(uint32_t len, size_t expected) "tpm_resp->len = %u, expected = %zu"
> +tpm_util_get_buffer_size_hdr_len2(uint32_t len, size_t expected) "tpm2_resp->hdr.len = %u, expected = %zu"
> +tpm_util_get_buffer_size_len2(uint32_t len, size_t expected) "tpm2_resp->len = %u, expected = %zu"
> +tpm_util_get_buffer_size(size_t len) "buffersize of device: %zu"
> 
