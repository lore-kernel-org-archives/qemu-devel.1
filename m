Received: from eggs.gnu.org ([2001:4830:134:3::10]:51784)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dkfZs-0001in-KO
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 20:00:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dkfZn-0002LQ-No
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 20:00:52 -0400
Received: from mail-qk0-x22f.google.com ([2607:f8b0:400d:c09::22f]:37351)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dkfZn-0002LA-Iv
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 20:00:47 -0400
Received: by mail-qk0-x22f.google.com with SMTP id o184so1483200qkc.4
	for <qemu-devel@nongnu.org>; Wed, 23 Aug 2017 17:00:47 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170823162004.27337-1-marcandre.lureau@redhat.com>
	<20170823162004.27337-24-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <a3f66f3b-0426-885b-af3e-5bb3bb1cfe3a@amsat.org>
Date: Wed, 23 Aug 2017 21:00:43 -0300
MIME-Version: 1.0
In-Reply-To: <20170823162004.27337-24-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 23/27] vhost-user-scsi: use glib logging
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

On 08/23/2017 01:20 PM, Marc-André Lureau wrote:
> - PLOG is unused
> - code is compiled out unless debug is enabled
> - logging is too verbose
> - you can pipe to ts to have timestamp if needed, or use structured
>    logging with more recent glib
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>   contrib/vhost-user-scsi/vhost-user-scsi.c | 77 +++++++++----------------------
>   1 file changed, 21 insertions(+), 56 deletions(-)
> 
> diff --git a/contrib/vhost-user-scsi/vhost-user-scsi.c b/contrib/vhost-user-scsi/vhost-user-scsi.c
> index 516a9d3966..e3ec8b9b2c 100644
> --- a/contrib/vhost-user-scsi/vhost-user-scsi.c
> +++ b/contrib/vhost-user-scsi/vhost-user-scsi.c
> @@ -18,42 +18,6 @@
>   
>   #include <glib.h>
>   
> -/* #define VUS_DEBUG 1 */
> -
> -/** Log helpers **/
> -
> -#define PPRE                                                          \
> -    struct timespec ts;                                               \
> -    char   timebuf[64];                                               \
> -    struct tm tm;                                                     \
> -    (void)clock_gettime(CLOCK_REALTIME, &ts);                         \
> -    (void)strftime(timebuf, 64, "%Y%m%d %T", gmtime_r(&ts.tv_sec, &tm))
> -
> -#define PEXT(lvl, msg, ...) do {                                      \
> -    PPRE;                                                             \
> -    fprintf(stderr, "%s.%06ld " lvl ": %s:%s():%d: " msg "\n",        \
> -            timebuf, ts.tv_nsec / 1000,                               \
> -            __FILE__, __func__, __LINE__, ## __VA_ARGS__);            \
> -} while (0)
> -
> -#define PNOR(lvl, msg, ...) do {                                      \
> -    PPRE;                                                             \
> -    fprintf(stderr, "%s.%06ld " lvl ": " msg "\n",                    \
> -            timebuf, ts.tv_nsec / 1000, ## __VA_ARGS__);              \
> -} while (0)
> -
> -#ifdef VUS_DEBUG
> -#define PDBG(msg, ...) PEXT("DBG", msg, ## __VA_ARGS__)
> -#define PERR(msg, ...) PEXT("ERR", msg, ## __VA_ARGS__)
> -#define PLOG(msg, ...) PEXT("LOG", msg, ## __VA_ARGS__)
> -#else
> -#define PDBG(msg, ...) { }
> -#define PERR(msg, ...) PNOR("ERR", msg, ## __VA_ARGS__)
> -#define PLOG(msg, ...) PNOR("LOG", msg, ## __VA_ARGS__)
> -#endif
> -
> -/** vhost-user-scsi specific definitions **/
> -
>   #define VUS_ISCSI_INITIATOR "iqn.2016-11.com.nutanix:vhost-user-scsi"
>   
>   typedef struct VusIscsiLun {
> @@ -166,27 +130,28 @@ static int vus_iscsi_add_lun(VusIscsiLun *lun, char *iscsi_uri)
>   
>       iscsi_ctx = iscsi_create_context(VUS_ISCSI_INITIATOR);
>       if (!iscsi_ctx) {
> -        PERR("Unable to create iSCSI context");
> +        g_warning("Unable to create iSCSI context");
>           return -1;
>       }
>   
>       iscsi_url = iscsi_parse_full_url(iscsi_ctx, iscsi_uri);
>       if (!iscsi_url) {
> -        PERR("Unable to parse iSCSI URL: %s", iscsi_get_error(iscsi_ctx));
> +        g_warning("Unable to parse iSCSI URL: %s", iscsi_get_error(iscsi_ctx));
>           goto fail;
>       }
>   
>       iscsi_set_session_type(iscsi_ctx, ISCSI_SESSION_NORMAL);
>       iscsi_set_header_digest(iscsi_ctx, ISCSI_HEADER_DIGEST_NONE_CRC32C);
>       if (iscsi_full_connect_sync(iscsi_ctx, iscsi_url->portal, iscsi_url->lun)) {
> -        PERR("Unable to login to iSCSI portal: %s", iscsi_get_error(iscsi_ctx));
> +        g_warning("Unable to login to iSCSI portal: %s",
> +                  iscsi_get_error(iscsi_ctx));
>           goto fail;
>       }
>   
>       lun->iscsi_ctx = iscsi_ctx;
>       lun->iscsi_lun = iscsi_url->lun;
>   
> -    PDBG("Context %p created for lun 0: %s", iscsi_ctx, iscsi_uri);
> +    g_debug("Context %p created for lun 0: %s", iscsi_ctx, iscsi_uri);
>   
>   out:
>       if (iscsi_url) {
> @@ -228,7 +193,7 @@ static int get_cdb_len(uint8_t *cdb)
>       case 4: return 16;
>       case 5: return 12;
>       }
> -    PERR("Unable to determine cdb len (0x%02hhX)", cdb[0] >> 5);
> +    g_warning("Unable to determine cdb len (0x%02hhX)", cdb[0] >> 5);
>       return -1;
>   }
>   
> @@ -250,7 +215,7 @@ static int handle_cmd_sync(struct iscsi_context *ctx,
>   
>       if (!(!req->lun[1] && req->lun[2] == 0x40 && !req->lun[3])) {
>           /* Ignore anything different than target=0, lun=0 */
> -        PDBG("Ignoring unconnected lun (0x%hhX, 0x%hhX)",
> +        g_debug("Ignoring unconnected lun (0x%hhX, 0x%hhX)",
>                req->lun[1], req->lun[3]);
>           rsp->status = SCSI_STATUS_CHECK_CONDITION;
>           memset(rsp->sense, 0, sizeof(rsp->sense));
> @@ -293,10 +258,10 @@ static int handle_cmd_sync(struct iscsi_context *ctx,
>           task->iovector_in.niov = in_len;
>       }
>   
> -    PDBG("Sending iscsi cmd (cdb_len=%d, dir=%d, task=%p)",
> +    g_debug("Sending iscsi cmd (cdb_len=%d, dir=%d, task=%p)",
>            cdb_len, dir, task);
>       if (!iscsi_scsi_command_sync(ctx, 0, task, NULL)) {
> -        PERR("Error serving SCSI command");
> +        g_warning("Error serving SCSI command");
>           g_free(task);
>           return -1;
>       }
> @@ -314,7 +279,7 @@ static int handle_cmd_sync(struct iscsi_context *ctx,
>   
>       g_free(task);
>   
> -    PDBG("Filled in rsp: status=%hhX, resid=%u, response=%hhX, sense_len=%u",
> +    g_debug("Filled in rsp: status=%hhX, resid=%u, response=%hhX, sense_len=%u",
>            rsp->status, rsp->resid, rsp->response, rsp->sense_len);
>   
>       return 0;
> @@ -330,7 +295,7 @@ static void vus_panic_cb(VuDev *vu_dev, const char *buf)
>   
>       vdev_scsi = container_of(vu_dev, VusDev, vu_dev);
>       if (buf) {
> -        PERR("vu_panic: %s", buf);
> +        g_warning("vu_panic: %s", buf);
>       }
>   
>       g_main_loop_quit(vdev_scsi->loop);
> @@ -371,19 +336,19 @@ static void vus_proc_req(VuDev *vu_dev, int idx)
>   
>       vdev_scsi = container_of(vu_dev, VusDev, vu_dev);
>       if (idx < 0 || idx >= VHOST_MAX_NR_VIRTQUEUE) {
> -        PERR("VQ Index out of range: %d", idx);
> +        g_warning("VQ Index out of range: %d", idx);
>           vus_panic_cb(vu_dev, NULL);
>           return;
>       }
>   
>       vq = vu_get_queue(vu_dev, idx);
>       if (!vq) {
> -        PERR("Error fetching VQ (dev=%p, idx=%d)", vu_dev, idx);
> +        g_warning("Error fetching VQ (dev=%p, idx=%d)", vu_dev, idx);
>           vus_panic_cb(vu_dev, NULL);
>           return;
>       }
>   
> -    PDBG("Got kicked on vq[%d]@%p", idx, vq);
> +    g_debug("Got kicked on vq[%d]@%p", idx, vq);
>   
>       while (1) {
>           VuVirtqElement *elem;
> @@ -392,23 +357,23 @@ static void vus_proc_req(VuDev *vu_dev, int idx)
>   
>           elem = vu_queue_pop(vu_dev, vq, sizeof(VuVirtqElement));
>           if (!elem) {
> -            PDBG("No more elements pending on vq[%d]@%p", idx, vq);
> +            g_debug("No more elements pending on vq[%d]@%p", idx, vq);
>               break;
>           }
> -        PDBG("Popped elem@%p", elem);
> +        g_debug("Popped elem@%p", elem);
>   
>           assert(!(elem->out_num > 1 && elem->in_num > 1));
>           assert(elem->out_num > 0 && elem->in_num > 0);
>   
>           if (elem->out_sg[0].iov_len < sizeof(VirtIOSCSICmdReq)) {
> -            PERR("Invalid virtio-scsi req header");
> +            g_warning("Invalid virtio-scsi req header");
>               vus_panic_cb(vu_dev, NULL);
>               break;
>           }
>           req = (VirtIOSCSICmdReq *)elem->out_sg[0].iov_base;
>   
>           if (elem->in_sg[0].iov_len < sizeof(VirtIOSCSICmdResp)) {
> -            PERR("Invalid virtio-scsi rsp header");
> +            g_warning("Invalid virtio-scsi rsp header");
>               vus_panic_cb(vu_dev, NULL);
>               break;
>           }
> @@ -435,7 +400,7 @@ static void vus_queue_set_started(VuDev *vu_dev, int idx, bool started)
>       assert(vu_dev);
>   
>       if (idx < 0 || idx >= VHOST_MAX_NR_VIRTQUEUE) {
> -        PERR("VQ Index out of range: %d", idx);
> +        g_warning("VQ Index out of range: %d", idx);
>           vus_panic_cb(vu_dev, NULL);
>           return;
>       }
> @@ -443,7 +408,7 @@ static void vus_queue_set_started(VuDev *vu_dev, int idx, bool started)
>       vq = vu_get_queue(vu_dev, idx);
>   
>       if (idx == 0 || idx == 1) {
> -        PDBG("queue %d unimplemented", idx);
> +        g_debug("queue %d unimplemented", idx);
>       } else {
>           vu_set_queue_handler(vu_dev, vq, started ? vus_proc_req : NULL);
>       }
> @@ -461,7 +426,7 @@ static gboolean vus_vhost_cb(GIOChannel *source, GIOCondition condition,
>       assert(vu_dev);
>   
>       if (!vu_dispatch(vu_dev) != 0) {
> -        PERR("Error processing vhost message");
> +        g_warning("Error processing vhost message");
>           vus_panic_cb(vu_dev, NULL);
>           return G_SOURCE_REMOVE;
>       }
> 
