Received: from eggs.gnu.org ([2001:4830:134:3::10]:53125)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1droFv-0001FY-Ef
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 12:41:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1droFs-0000Vp-1T
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 12:41:47 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:37040)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1droFr-0000Vd-SC
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 12:41:43 -0400
Received: by mail-qk0-x242.google.com with SMTP id r66so7337732qke.4
	for <qemu-devel@nongnu.org>; Tue, 12 Sep 2017 09:41:43 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170823162004.27337-1-marcandre.lureau@redhat.com>
	<20170823162004.27337-21-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <f3f17253-4126-4c95-b57d-96ff14199330@amsat.org>
Date: Tue, 12 Sep 2017 13:41:39 -0300
MIME-Version: 1.0
In-Reply-To: <20170823162004.27337-21-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 20/27] vhost-user-scsi: don't copy
 iscsi/scsi-lowlevel.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: changpeng.liu@intel.com, felipe@nutanix.com

On 08/23/2017 01:19 PM, Marc-André Lureau wrote:
> There is no need to include hw/virtio/virtio-scsi.h, then the conflict
> with SCSI_XFER enum goes away.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>   contrib/vhost-user-scsi/vhost-user-scsi.c | 96 +++----------------------------
>   1 file changed, 9 insertions(+), 87 deletions(-)
> 
> diff --git a/contrib/vhost-user-scsi/vhost-user-scsi.c b/contrib/vhost-user-scsi/vhost-user-scsi.c
> index 2ab14f1a83..795799ec14 100644
> --- a/contrib/vhost-user-scsi/vhost-user-scsi.c
> +++ b/contrib/vhost-user-scsi/vhost-user-scsi.c
> @@ -12,8 +12,9 @@
>   
>   #include "qemu/osdep.h"
>   #include "contrib/libvhost-user/libvhost-user.h"
> -#include "hw/virtio/virtio-scsi.h"
> +#include "standard-headers/linux/virtio_scsi.h"
>   #include "iscsi/iscsi.h"
> +#include "iscsi/scsi-lowlevel.h"
>   
>   #include <glib.h>
>   
> @@ -161,90 +162,11 @@ static void vus_gsrc_new(VusDev *vdev_scsi, int fd, GIOCondition cond,
>                                       (gpointer)(uintptr_t)id);
>   }
>   
> -/* from libiscsi's scsi-lowlevel.h **
> - *
> - * nb. We can't directly include scsi-lowlevel.h due to a namespace conflict:
> - *     QEMU's scsi.h also defines "SCSI_XFER_NONE".
> - */
> -
> -#define SCSI_CDB_MAX_SIZE           16
> -
> -struct scsi_iovector {
> -    struct scsi_iovec *iov;
> -    int niov;
> -    int nalloc;
> -    size_t offset;
> -    int consumed;
> -};
> -
> -struct scsi_allocated_memory {
> -    struct scsi_allocated_memory *next;
> -    char buf[0];
> -};
> -
> -struct scsi_data {
> -    int            size;
> -    unsigned char *data;
> -};
> -
> -enum scsi_sense_key {
> -    SCSI_SENSE_NO_SENSE            = 0x00,
> -    SCSI_SENSE_RECOVERED_ERROR     = 0x01,
> -    SCSI_SENSE_NOT_READY           = 0x02,
> -    SCSI_SENSE_MEDIUM_ERROR        = 0x03,
> -    SCSI_SENSE_HARDWARE_ERROR      = 0x04,
> -    SCSI_SENSE_ILLEGAL_REQUEST     = 0x05,
> -    SCSI_SENSE_UNIT_ATTENTION      = 0x06,
> -    SCSI_SENSE_DATA_PROTECTION     = 0x07,
> -    SCSI_SENSE_BLANK_CHECK         = 0x08,
> -    SCSI_SENSE_VENDOR_SPECIFIC     = 0x09,
> -    SCSI_SENSE_COPY_ABORTED        = 0x0a,
> -    SCSI_SENSE_COMMAND_ABORTED     = 0x0b,
> -    SCSI_SENSE_OBSOLETE_ERROR_CODE = 0x0c,
> -    SCSI_SENSE_OVERFLOW_COMMAND    = 0x0d,
> -    SCSI_SENSE_MISCOMPARE          = 0x0e
> -};
> -
> -struct scsi_sense {
> -    unsigned char       error_type;
> -    enum scsi_sense_key key;
> -    int                 ascq;
> -    unsigned            sense_specific:1;
> -    unsigned            ill_param_in_cdb:1;
> -    unsigned            bit_pointer_valid:1;
> -    unsigned char       bit_pointer;
> -    uint16_t            field_pointer;
> -};
> -
> -enum scsi_residual {
> -    SCSI_RESIDUAL_NO_RESIDUAL = 0,
> -    SCSI_RESIDUAL_UNDERFLOW,
> -    SCSI_RESIDUAL_OVERFLOW
> -};
> -
> -struct scsi_task {
> -    int status;
> -    int cdb_size;
> -    int xfer_dir;
> -    int expxferlen;
> -    unsigned char cdb[SCSI_CDB_MAX_SIZE];
> -    enum scsi_residual residual_status;
> -    size_t residual;
> -    struct scsi_sense sense;
> -    struct scsi_data datain;
> -    struct scsi_allocated_memory *mem;
> -    void *ptr;
> -
> -    uint32_t itt;
> -    uint32_t cmdsn;
> -    uint32_t lun;
> -
> -    struct scsi_iovector iovector_in;
> -    struct scsi_iovector iovector_out;
> -};
> -
>   /** libiscsi integration **/
>   
> +typedef struct virtio_scsi_cmd_req VirtIOSCSICmdReq;
> +typedef struct virtio_scsi_cmd_resp VirtIOSCSICmdResp;
> +
>   static int vus_iscsi_add_lun(VusIscsiLun *lun, char *iscsi_uri)
>   {
>       struct iscsi_url *iscsi_url;
> @@ -363,12 +285,12 @@ static int handle_cmd_sync(struct iscsi_context *ctx,
>       if (!out_len && !in_len) {
>           dir = SCSI_XFER_NONE;
>       } else if (out_len) {
> -        dir = SCSI_XFER_TO_DEV;
> +        dir = SCSI_XFER_WRITE;
>           for (i = 0; i < out_len; i++) {
>               len += out[i].iov_len;
>           }
>       } else {
> -        dir = SCSI_XFER_FROM_DEV;
> +        dir = SCSI_XFER_READ;
>           for (i = 0; i < in_len; i++) {
>               len += in[i].iov_len;
>           }
> @@ -376,10 +298,10 @@ static int handle_cmd_sync(struct iscsi_context *ctx,
>   
>       task = scsi_task_new(cdb_len, req->cdb, dir, len);
>   
> -    if (dir == SCSI_XFER_TO_DEV) {
> +    if (dir == SCSI_XFER_WRITE) {
>           task->iovector_out.iov = (struct scsi_iovec *)out;
>           task->iovector_out.niov = out_len;
> -    } else if (dir == SCSI_XFER_FROM_DEV) {
> +    } else if (dir == SCSI_XFER_READ) {
>           task->iovector_in.iov = (struct scsi_iovec *)in;
>           task->iovector_in.niov = in_len;
>       }
> 
