Received: from eggs.gnu.org ([2001:4830:134:3::10]:50876)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1esdgF-0007ka-Iv
	for qemu-devel@nongnu.org; Sun, 04 Mar 2018 19:08:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1esdgC-0003vt-Bd
	for qemu-devel@nongnu.org; Sun, 04 Mar 2018 19:08:39 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:50592)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1esdgC-0003vO-48
	for qemu-devel@nongnu.org; Sun, 04 Mar 2018 19:08:36 -0500
Received: by mail-wm0-x242.google.com with SMTP id w128so12639725wmw.0
	for <qemu-devel@nongnu.org>; Sun, 04 Mar 2018 16:08:35 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1520200587-14681-1-git-send-email-stefanb@linux.vnet.ibm.com>
	<1520200587-14681-2-git-send-email-stefanb@linux.vnet.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <3d403de3-5c4a-4d10-64a5-2ed2f3254a93@amsat.org>
Date: Sun, 4 Mar 2018 21:08:32 -0300
MIME-Version: 1.0
In-Reply-To: <1520200587-14681-2-git-send-email-stefanb@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 1/5] tpm: convert tpm_crb.c to use
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
>  Makefile.objs       |  1 +
>  hw/tpm/tpm_crb.c    | 17 +++++------------
>  hw/tpm/trace-events |  5 +++++
>  3 files changed, 11 insertions(+), 12 deletions(-)
>  create mode 100644 hw/tpm/trace-events
> 
> diff --git a/Makefile.objs b/Makefile.objs
> index 5dc1348..72c3d8c 100644
> --- a/Makefile.objs
> +++ b/Makefile.objs
> @@ -162,6 +162,7 @@ trace-events-subdirs += hw/alpha
>  trace-events-subdirs += hw/hppa
>  trace-events-subdirs += hw/xen
>  trace-events-subdirs += hw/ide
> +trace-events-subdirs += hw/tpm
>  trace-events-subdirs += ui
>  trace-events-subdirs += audio
>  trace-events-subdirs += net
> diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
> index b5b8256..d8917cb 100644
> --- a/hw/tpm/tpm_crb.c
> +++ b/hw/tpm/tpm_crb.c
> @@ -29,6 +29,7 @@
>  #include "sysemu/reset.h"
>  #include "tpm_int.h"
>  #include "tpm_util.h"
> +#include "trace.h"
>  
>  typedef struct CRBState {
>      DeviceState parent_obj;
> @@ -44,14 +45,6 @@ typedef struct CRBState {
>  
>  #define CRB(obj) OBJECT_CHECK(CRBState, (obj), TYPE_TPM_CRB)
>  
> -#define DEBUG_CRB 0
> -
> -#define DPRINTF(fmt, ...) do {                  \
> -        if (DEBUG_CRB) {                        \
> -            printf(fmt, ## __VA_ARGS__);        \
> -        }                                       \
> -    } while (0)
> -
>  #define CRB_INTF_TYPE_CRB_ACTIVE 0b1
>  #define CRB_INTF_VERSION_CRB 0b1
>  #define CRB_INTF_CAP_LOCALITY_0_ONLY 0b0
> @@ -91,8 +84,8 @@ static uint64_t tpm_crb_mmio_read(void *opaque, hwaddr addr,
>      unsigned offset = addr & 3;
>      uint32_t val = *(uint32_t *)regs >> (8 * offset);
>  
> -    DPRINTF("CRB read 0x" TARGET_FMT_plx " len:%u val: 0x%" PRIx32 "\n",
> -            addr, size, val);
> +    trace_tpm_crb_mmio_read(addr, size, val);
> +
>      return val;
>  }
>  
> @@ -100,8 +93,8 @@ static void tpm_crb_mmio_write(void *opaque, hwaddr addr,
>                                 uint64_t val, unsigned size)
>  {
>      CRBState *s = CRB(opaque);
> -    DPRINTF("CRB write 0x" TARGET_FMT_plx " len:%u val: 0x%" PRIx64 "\n",
> -            addr, size, val);
> +
> +    trace_tpm_crb_mmio_write(addr, size, val);
>  
>      switch (addr) {
>      case A_CRB_CTRL_REQ:
> diff --git a/hw/tpm/trace-events b/hw/tpm/trace-events
> new file mode 100644
> index 0000000..336b06d
> --- /dev/null
> +++ b/hw/tpm/trace-events
> @@ -0,0 +1,5 @@
> +# See docs/devel/tracing.txt for syntax documentation.
> +
> +# hw/tpm/tpm_crb.c
> +tpm_crb_mmio_read(uint64_t addr, unsigned size, uint32_t val) "CRB read 0x" TARGET_FMT_plx " len:%u val: 0x%" PRIx32
> +tpm_crb_mmio_write(uint64_t addr, unsigned size, uint32_t val) "CRB write 0x" TARGET_FMT_plx " len:%u val: 0x%" PRIx32
> 
