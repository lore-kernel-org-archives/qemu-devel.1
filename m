Received: from eggs.gnu.org ([2001:4830:134:3::10]:41756)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dkZwd-0005z7-Py
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 14:00:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dkZwY-0002NM-TI
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 13:59:59 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:34712)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dkZwY-0002NG-Ni
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 13:59:54 -0400
Received: by mail-qt0-x243.google.com with SMTP id f63so236638qtb.1
	for <qemu-devel@nongnu.org>; Wed, 23 Aug 2017 10:59:54 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170823162004.27337-1-marcandre.lureau@redhat.com>
	<20170823162004.27337-19-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <725056b5-0640-52cf-0841-bec236f6a170@amsat.org>
Date: Wed, 23 Aug 2017 14:59:49 -0300
MIME-Version: 1.0
In-Reply-To: <20170823162004.27337-19-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 18/27] vhost-user-scsi: rename VUS types
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
> - use Vus prefix consistently
> - use CamelCase, since that's glib & libvhost-user style
> - avoid _t postfix, usually for system headers
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>   contrib/vhost-user-scsi/vhost-user-scsi.c | 46 +++++++++++++++----------------
>   1 file changed, 23 insertions(+), 23 deletions(-)
> 
> diff --git a/contrib/vhost-user-scsi/vhost-user-scsi.c b/contrib/vhost-user-scsi/vhost-user-scsi.c
> index 882d887a32..2ceca964f4 100644
> --- a/contrib/vhost-user-scsi/vhost-user-scsi.c
> +++ b/contrib/vhost-user-scsi/vhost-user-scsi.c
> @@ -55,18 +55,18 @@
>   
>   #define VUS_ISCSI_INITIATOR "iqn.2016-11.com.nutanix:vhost-user-scsi"
>   
> -typedef struct iscsi_lun {
> +typedef struct VusIscsiLun {
>       struct iscsi_context *iscsi_ctx;
>       int iscsi_lun;
> -} iscsi_lun_t;
> +} VusIscsiLun;
>   
> -typedef struct vhost_scsi_dev {
> +typedef struct VusDev {
>       VuDev vu_dev;
>       int server_sock;
>       GMainLoop *loop;
>       GTree *fdmap;   /* fd -> gsource context id */
> -    iscsi_lun_t lun;
> -} vhost_scsi_dev_t;
> +    VusIscsiLun lun;
> +} VusDev;
>   
>   /** glib event loop integration for libvhost-user and misc callbacks **/
>   
> @@ -78,7 +78,7 @@ QEMU_BUILD_BUG_ON((int)G_IO_HUP != (int)VU_WATCH_HUP);
>   
>   typedef struct vus_gsrc {
>       GSource parent;
> -    vhost_scsi_dev_t *vdev_scsi;
> +    VusDev *vdev_scsi;
>       GPollFD gfd;
>       vu_watch_cb vu_cb;
>   } vus_gsrc_t;
> @@ -107,7 +107,7 @@ static gboolean vus_gsrc_check(GSource *src)
>   
>   static gboolean vus_gsrc_dispatch(GSource *src, GSourceFunc cb, gpointer data)
>   {
> -    vhost_scsi_dev_t *vdev_scsi;
> +    VusDev *vdev_scsi;
>       vus_gsrc_t *vus_src = (vus_gsrc_t *)src;
>   
>       assert(vus_src);
> @@ -133,7 +133,7 @@ static GSourceFuncs vus_gsrc_funcs = {
>       NULL
>   };
>   
> -static void vus_gsrc_new(vhost_scsi_dev_t *vdev_scsi, int fd, GIOCondition cond,
> +static void vus_gsrc_new(VusDev *vdev_scsi, int fd, GIOCondition cond,
>                            vu_watch_cb vu_cb, gpointer data)
>   {
>       GSource *vus_gsrc;
> @@ -245,7 +245,7 @@ struct scsi_task {
>   
>   /** libiscsi integration **/
>   
> -static int iscsi_add_lun(iscsi_lun_t *lun, char *iscsi_uri)
> +static int iscsi_add_lun(VusIscsiLun *lun, char *iscsi_uri)
>   {
>       struct iscsi_url *iscsi_url;
>       struct iscsi_context *iscsi_ctx;
> @@ -415,11 +415,11 @@ static int handle_cmd_sync(struct iscsi_context *ctx,
>   
>   static void vus_panic_cb(VuDev *vu_dev, const char *buf)
>   {
> -    vhost_scsi_dev_t *vdev_scsi;
> +    VusDev *vdev_scsi;
>   
>       assert(vu_dev);
>   
> -    vdev_scsi = container_of(vu_dev, vhost_scsi_dev_t, vu_dev);
> +    vdev_scsi = container_of(vu_dev, VusDev, vu_dev);
>       if (buf) {
>           PERR("vu_panic: %s", buf);
>       }
> @@ -430,14 +430,14 @@ static void vus_panic_cb(VuDev *vu_dev, const char *buf)
>   static void vus_add_watch_cb(VuDev *vu_dev, int fd, int vu_evt, vu_watch_cb cb,
>                                void *pvt)
>   {
> -    vhost_scsi_dev_t *vdev_scsi;
> +    VusDev *vdev_scsi;
>       guint id;
>   
>       assert(vu_dev);
>       assert(fd >= 0);
>       assert(cb);
>   
> -    vdev_scsi = container_of(vu_dev, vhost_scsi_dev_t, vu_dev);
> +    vdev_scsi = container_of(vu_dev, VusDev, vu_dev);
>       id = (guint)(uintptr_t)g_tree_lookup(vdev_scsi->fdmap,
>                                            (gpointer)(uintptr_t)fd);
>       if (id) {
> @@ -452,13 +452,13 @@ static void vus_add_watch_cb(VuDev *vu_dev, int fd, int vu_evt, vu_watch_cb cb,
>   
>   static void vus_del_watch_cb(VuDev *vu_dev, int fd)
>   {
> -    vhost_scsi_dev_t *vdev_scsi;
> +    VusDev *vdev_scsi;
>       guint id;
>   
>       assert(vu_dev);
>       assert(fd >= 0);
>   
> -    vdev_scsi = container_of(vu_dev, vhost_scsi_dev_t, vu_dev);
> +    vdev_scsi = container_of(vu_dev, VusDev, vu_dev);
>       id = (guint)(uintptr_t)g_tree_lookup(vdev_scsi->fdmap,
>                                            (gpointer)(uintptr_t)fd);
>       if (id) {
> @@ -471,12 +471,12 @@ static void vus_del_watch_cb(VuDev *vu_dev, int fd)
>   
>   static void vus_proc_req(VuDev *vu_dev, int idx)
>   {
> -    vhost_scsi_dev_t *vdev_scsi;
> +    VusDev *vdev_scsi;
>       VuVirtq *vq;
>   
>       assert(vu_dev);
>   
> -    vdev_scsi = container_of(vu_dev, vhost_scsi_dev_t, vu_dev);
> +    vdev_scsi = container_of(vu_dev, VusDev, vu_dev);
>       if (idx < 0 || idx >= VHOST_MAX_NR_VIRTQUEUE) {
>           PERR("VQ Index out of range: %d", idx);
>           vus_panic_cb(vu_dev, NULL);
> @@ -617,7 +617,7 @@ fail:
>   
>   /** vhost-user-scsi **/
>   
> -static void vdev_scsi_free(vhost_scsi_dev_t *vdev_scsi)
> +static void vdev_scsi_free(VusDev *vdev_scsi)
>   {
>       if (vdev_scsi->server_sock >= 0) {
>           close(vdev_scsi->server_sock);
> @@ -627,13 +627,13 @@ static void vdev_scsi_free(vhost_scsi_dev_t *vdev_scsi)
>       g_free(vdev_scsi);
>   }
>   
> -static vhost_scsi_dev_t *vdev_scsi_new(int server_sock)
> +static VusDev *vdev_scsi_new(int server_sock)
>   {
> -    vhost_scsi_dev_t *vdev_scsi;
> +    VusDev *vdev_scsi;
>   
>       assert(server_sock >= 0);
>   
> -    vdev_scsi = g_new0(vhost_scsi_dev_t, 1);
> +    vdev_scsi = g_new0(VusDev, 1);
>       vdev_scsi->server_sock = server_sock;
>       vdev_scsi->loop = g_main_loop_new(NULL, FALSE);
>       vdev_scsi->fdmap = g_tree_new(vus_fdmap_compare);
> @@ -641,7 +641,7 @@ static vhost_scsi_dev_t *vdev_scsi_new(int server_sock)
>       return vdev_scsi;
>   }
>   
> -static int vdev_scsi_run(vhost_scsi_dev_t *vdev_scsi)
> +static int vdev_scsi_run(VusDev *vdev_scsi)
>   {
>       GIOChannel *chan;
>       int cli_sock;
> @@ -676,7 +676,7 @@ static int vdev_scsi_run(vhost_scsi_dev_t *vdev_scsi)
>   
>   int main(int argc, char **argv)
>   {
> -    vhost_scsi_dev_t *vdev_scsi = NULL;
> +    VusDev *vdev_scsi = NULL;
>       char *unix_fn = NULL;
>       char *iscsi_uri = NULL;
>       int sock, opt, err = EXIT_SUCCESS;
> 
