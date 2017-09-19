Received: from eggs.gnu.org ([2001:4830:134:3::10]:33854)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1duIyk-0005UO-4f
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 09:54:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1duIyg-0001CP-2f
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 09:54:22 -0400
Received: from mail-wm0-f51.google.com ([74.125.82.51]:50639)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1duIyf-0001Bz-Sf
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 09:54:18 -0400
Received: by mail-wm0-f51.google.com with SMTP id v142so75292wmv.5
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 06:54:17 -0700 (PDT)
References: <20170823162004.27337-1-marcandre.lureau@redhat.com>
	<20170823162004.27337-14-marcandre.lureau@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0e752708-6bad-6fc1-0b3f-4f50a2dd00e0@redhat.com>
Date: Tue, 19 Sep 2017 15:54:14 +0200
MIME-Version: 1.0
In-Reply-To: <20170823162004.27337-14-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 13/27] vhost-user-scsi: use glib watch
 directly
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

On 23/08/2017 18:19, Marc-André Lureau wrote:
> The following patches is going to remove the custom VUS source.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  contrib/vhost-user-scsi/vhost-user-scsi.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/contrib/vhost-user-scsi/vhost-user-scsi.c b/contrib/vhost-user-scsi/vhost-user-scsi.c
> index 596c1effa1..b40009e234 100644
> --- a/contrib/vhost-user-scsi/vhost-user-scsi.c
> +++ b/contrib/vhost-user-scsi/vhost-user-scsi.c
> @@ -136,7 +136,7 @@ static GSourceFuncs vus_gsrc_funcs = {
>  };
>  
>  static void vus_gsrc_new(vhost_scsi_dev_t *vdev_scsi, int fd, GIOCondition cond,
> -                         vu_watch_cb vu_cb, GSourceFunc gsrc_cb, gpointer data)
> +                         vu_watch_cb vu_cb, gpointer data)
>  {
>      GSource *vus_gsrc;
>      vus_gsrc_t *vus_src;
> @@ -144,8 +144,7 @@ static void vus_gsrc_new(vhost_scsi_dev_t *vdev_scsi, int fd, GIOCondition cond,
>  
>      assert(vdev_scsi);
>      assert(fd >= 0);
> -    assert(vu_cb || gsrc_cb);
> -    assert(!(vu_cb && gsrc_cb));
> +    assert(vu_cb);
>  
>      vus_gsrc = g_source_new(&vus_gsrc_funcs, sizeof(vus_gsrc_t));
>      vus_src = (vus_gsrc_t *)vus_gsrc;
> @@ -156,7 +155,6 @@ static void vus_gsrc_new(vhost_scsi_dev_t *vdev_scsi, int fd, GIOCondition cond,
>      vus_src->vu_cb = vu_cb;
>  
>      g_source_add_poll(vus_gsrc, &vus_src->gfd);
> -    g_source_set_callback(vus_gsrc, gsrc_cb, data, NULL);
>      id = g_source_attach(vus_gsrc, NULL);
>      assert(id);
>      g_source_unref(vus_gsrc);
> @@ -450,7 +448,7 @@ static void vus_add_watch_cb(VuDev *vu_dev, int fd, int vu_evt, vu_watch_cb cb,
>          (void)g_tree_remove(vdev_scsi->fdmap, (gpointer)(uintptr_t)fd);
>      }
>  
> -    vus_gsrc_new(vdev_scsi, fd, vu_evt, cb, NULL, pvt);
> +    vus_gsrc_new(vdev_scsi, fd, vu_evt, cb, pvt);
>  }
>  
>  static void vus_del_watch_cb(VuDev *vu_dev, int fd)
> @@ -578,7 +576,8 @@ static const VuDevIface vus_iface = {
>      .queue_set_started = vus_queue_set_started,
>  };
>  
> -static gboolean vus_vhost_cb(gpointer data)
> +static gboolean vus_vhost_cb(GIOChannel *source, GIOCondition condition,
> +                             gpointer data)
>  {
>      VuDev *vu_dev = (VuDev *)data;
>  
> @@ -679,6 +678,7 @@ static int vdev_scsi_add_iscsi_lun(vhost_scsi_dev_t *vdev_scsi,
>  
>  static int vdev_scsi_run(vhost_scsi_dev_t *vdev_scsi)
>  {
> +    GIOChannel *chan;
>      int cli_sock;
>      int ret = 0;
>  
> @@ -699,10 +699,10 @@ static int vdev_scsi_run(vhost_scsi_dev_t *vdev_scsi)
>              vus_del_watch_cb,
>              &vus_iface);
>  
> -    vus_gsrc_new(vdev_scsi, cli_sock, G_IO_IN, NULL, vus_vhost_cb,
> -                 &vdev_scsi->vu_dev);
> -
> +    chan = g_io_channel_unix_new(cli_sock);
> +    g_io_add_watch(chan, G_IO_IN, vus_vhost_cb, &vdev_scsi->vu_dev);
>      g_main_loop_run(vdev_scsi->loop);
> +    g_io_channel_unref(chan);
>  
>      vu_deinit(&vdev_scsi->vu_dev);
>  
> 

It's a bit weird to use GIOChannel here but still operate on the raw
socket elsewhere.  Maybe keep on open-coding the watch (using
g_source_new+g_source_add_poll) but remove the "vu_watch_cb vu_cb,
GSourceFunc gsrc_cb" ugliness in vus_gsrc_new, and only support the
vu_watch_cb style?  That would be exactly what GIOChannel does with GIOFunc.

Paolo
