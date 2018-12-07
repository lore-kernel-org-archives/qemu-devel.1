Received: from eggs.gnu.org ([2001:4830:134:3::10]:58811)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gVICw-0005FZ-6A
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 10:38:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gVICs-0002z3-T0
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 10:38:26 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38083)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gVICm-0001e1-4N
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 10:38:18 -0500
Received: by mail-wm1-f65.google.com with SMTP id m22so4978300wml.3
	for <qemu-devel@nongnu.org>; Fri, 07 Dec 2018 07:38:07 -0800 (PST)
References: <20181207131732.21073-1-lvivier@redhat.com>
	<20181207131732.21073-2-lvivier@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <4ba28b6f-37d4-f070-1e7d-e57ec22e49ad@redhat.com>
Date: Fri, 7 Dec 2018 16:38:05 +0100
MIME-Version: 1.0
In-Reply-To: <20181207131732.21073-2-lvivier@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 2/2] scsi-generic: Convert from DPRINTF()
 macro to trace events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
Cc: Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

On 12/7/18 2:17 PM, Laurent Vivier wrote:
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> ---
>  hw/scsi/scsi-generic.c | 56 ++++++++++++++++++++----------------------
>  hw/scsi/trace-events   | 11 +++++++++
>  2 files changed, 37 insertions(+), 30 deletions(-)
> 
> diff --git a/hw/scsi/scsi-generic.c b/hw/scsi/scsi-generic.c
> index 7237b4162e..842f8e0893 100644
> --- a/hw/scsi/scsi-generic.c
> +++ b/hw/scsi/scsi-generic.c
> @@ -18,21 +18,10 @@
>  #include "hw/scsi/scsi.h"
>  #include "hw/scsi/emulation.h"
>  #include "sysemu/block-backend.h"
> +#include "trace.h"
>  
>  #ifdef __linux__
>  
> -//#define DEBUG_SCSI
> -
> -#ifdef DEBUG_SCSI
> -#define DPRINTF(fmt, ...) \
> -do { printf("scsi-generic: " fmt , ## __VA_ARGS__); } while (0)
> -#else
> -#define DPRINTF(fmt, ...) do {} while(0)
> -#endif
> -
> -#define BADF(fmt, ...) \
> -do { fprintf(stderr, "scsi-generic: " fmt , ## __VA_ARGS__); } while (0)
> -
>  #include <scsi/sg.h>
>  #include "scsi/constants.h"
>  
> @@ -98,8 +87,7 @@ static void scsi_command_complete_noio(SCSIGenericReq *r, int ret)
>          }
>      }
>  
> -    DPRINTF("Command complete 0x%p tag=0x%x status=%d\n",
> -            r, r->req.tag, status);
> +    trace_scsi_generic_command_complete_noio(r, r->req.tag, status);
>  
>      scsi_req_complete(&r->req, status);
>  done:
> @@ -259,7 +247,7 @@ static void scsi_read_complete(void * opaque, int ret)
>      }
>  
>      len = r->io_header.dxfer_len - r->io_header.resid;
> -    DPRINTF("Data ready tag=0x%x len=%d\n", r->req.tag, len);
> +    trace_scsi_generic_read_complete(r->req.tag, len);
>  
>      r->len = -1;
>  
> @@ -335,7 +323,7 @@ static void scsi_read_data(SCSIRequest *req)
>      SCSIDevice *s = r->req.dev;
>      int ret;
>  
> -    DPRINTF("scsi_read_data tag=0x%x\n", req->tag);
> +    trace_scsi_generic_read_data(req->tag);
>  
>      /* The request is used as the AIO opaque value, so add a ref.  */
>      scsi_req_ref(&r->req);
> @@ -356,7 +344,7 @@ static void scsi_write_complete(void * opaque, int ret)
>      SCSIGenericReq *r = (SCSIGenericReq *)opaque;
>      SCSIDevice *s = r->req.dev;
>  
> -    DPRINTF("scsi_write_complete() ret = %d\n", ret);
> +    trace_scsi_generic_write_complete(ret);
>  
>      assert(r->req.aiocb != NULL);
>      r->req.aiocb = NULL;
> @@ -371,7 +359,7 @@ static void scsi_write_complete(void * opaque, int ret)
>      if (r->req.cmd.buf[0] == MODE_SELECT && r->req.cmd.buf[4] == 12 &&
>          s->type == TYPE_TAPE) {
>          s->blocksize = (r->buf[9] << 16) | (r->buf[10] << 8) | r->buf[11];
> -        DPRINTF("block size %d\n", s->blocksize);
> +        trace_scsi_generic_write_complete_blocksize(s->blocksize);
>      }
>  
>      scsi_command_complete_noio(r, ret);
> @@ -388,7 +376,7 @@ static void scsi_write_data(SCSIRequest *req)
>      SCSIDevice *s = r->req.dev;
>      int ret;
>  
> -    DPRINTF("scsi_write_data tag=0x%x\n", req->tag);
> +    trace_scsi_generic_write_data(req->tag);
>      if (r->len == 0) {
>          r->len = r->buflen;
>          scsi_req_data(&r->req, r->len);
> @@ -411,6 +399,21 @@ static uint8_t *scsi_get_buf(SCSIRequest *req)
>      return r->buf;
>  }
>  
> +static void scsi_generic_command_dump(uint8_t *cmd, int len)
> +{
> +    int i;
> +    char *line_buffer, *p;
> +
> +    line_buffer = g_malloc(len * 5 + 1);
> +
> +    for (i = 0, p = line_buffer; i < len; i++) {
> +        p += sprintf(p, " 0x%02x", cmd[i]);
> +    }
> +    trace_scsi_generic_send_command(line_buffer);
> +
> +    g_free(line_buffer);
> +}
> +
>  /* Execute a scsi command.  Returns the length of the data expected by the
>     command.  This will be Positive for data transfers from the device
>     (eg. disk reads), negative for transfers to the device (eg. disk writes),
> @@ -422,16 +425,9 @@ static int32_t scsi_send_command(SCSIRequest *req, uint8_t *cmd)
>      SCSIDevice *s = r->req.dev;
>      int ret;
>  
> -#ifdef DEBUG_SCSI
> -    DPRINTF("Command: data=0x%02x", cmd[0]);
> -    {
> -        int i;
> -        for (i = 1; i < r->req.cmd.len; i++) {
> -            printf(" 0x%02x", cmd[i]);
> -        }
> -        printf("\n");
> +    if (trace_event_get_state_backends(TRACE_SCSI_GENERIC_SEND_COMMAND)) {
> +        scsi_generic_command_dump(cmd, r->req.cmd.len);
>      }
> -#endif
>  
>      if (r->req.cmd.xfer == 0) {
>          g_free(r->buf);
> @@ -693,7 +689,7 @@ static void scsi_generic_realize(SCSIDevice *s, Error **errp)
>  
>      /* define device state */
>      s->type = scsiid.scsi_type;
> -    DPRINTF("device type %d\n", s->type);
> +    trace_scsi_generic_realize_type(s->type);
>  
>      switch (s->type) {
>      case TYPE_TAPE:
> @@ -716,7 +712,7 @@ static void scsi_generic_realize(SCSIDevice *s, Error **errp)
>          break;
>      }
>  
> -    DPRINTF("block size %d\n", s->blocksize);
> +    trace_scsi_generic_realize_blocksize(s->blocksize);
>  
>      /* Only used by scsi-block, but initialize it nevertheless to be clean.  */
>      s->default_scsi_version = -1;
> diff --git a/hw/scsi/trace-events b/hw/scsi/trace-events
> index e9625f790c..3c2fd7f52f 100644
> --- a/hw/scsi/trace-events
> +++ b/hw/scsi/trace-events
> @@ -320,3 +320,14 @@ scsi_disk_emulate_command_UNKNOWN(int cmd, const char *name) "Unknown SCSI comma
>  scsi_disk_dma_command_READ(uint64_t lba, uint32_t len) "Read (sector %" PRId64 ", count %u)"
>  scsi_disk_dma_command_WRITE(const char *cmd, uint64_t lba, int len) "Write %s(sector %" PRId64 ", count %u)"
>  scsi_disk_new_request(uint32_t lun, uint32_t tag, const char *line) "Command: lun=%d tag=0x%x data=%s"
> +
> +# hw/scsi/scsi-generic.c
> +scsi_generic_command_complete_noio(void *req, uint32_t tag, int statuc) "Command complete %p tag=0x%x status=%d"
> +scsi_generic_read_complete(uint32_t tag, int len) "Data ready tag=0x%x len=%d"
> +scsi_generic_read_data(uint32_t tag) "scsi_read_data tag=0x%x"
> +scsi_generic_write_complete(int ret) "scsi_write_complete() ret = %d"
> +scsi_generic_write_complete_blocksize(int blocksize) "block size %d"
> +scsi_generic_write_data(uint32_t tag) "scsi_write_data tag=0x%x"
> +scsi_generic_send_command(const char *line) "Command: data=%s"
> +scsi_generic_realize_type(int type) "device type %d"
> +scsi_generic_realize_blocksize(int blocksize) "block size %d"
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
