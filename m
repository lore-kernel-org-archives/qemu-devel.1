Received: from eggs.gnu.org ([2001:4830:134:3::10]:60919)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1e1xK2-0000RB-5s
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 12:23:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1e1xJy-0006x1-Uw
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 12:23:58 -0400
Received: from mail-wm0-f41.google.com ([74.125.82.41]:45868)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1e1xJy-0006wp-Kf
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 12:23:54 -0400
Received: by mail-wm0-f41.google.com with SMTP id q124so6769028wmb.0
	for <qemu-devel@nongnu.org>; Tue, 10 Oct 2017 09:23:54 -0700 (PDT)
References: <20170919165226.23022-1-marcandre.lureau@redhat.com>
	<20170919165226.23022-27-marcandre.lureau@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <be4131f0-90a3-05d8-1f1d-7dd6b3922085@redhat.com>
Date: Tue, 10 Oct 2017 18:23:51 +0200
MIME-Version: 1.0
In-Reply-To: <20170919165226.23022-27-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 26/27] vhost-user-scsi: use
 libvhost-user glib helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: felipe@nutanix.com, changpeng.liu@intel.com, f4bug@amsat.org

On 19/09/2017 18:52, Marc-André Lureau wrote:
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  contrib/vhost-user-scsi/vhost-user-scsi.c | 162 +++---------------------------
>  1 file changed, 16 insertions(+), 146 deletions(-)
> 
> diff --git a/contrib/vhost-user-scsi/vhost-user-scsi.c b/contrib/vhost-user-scsi/vhost-user-scsi.c
> index ff817d6643..615e2a76bb 100644
> --- a/contrib/vhost-user-scsi/vhost-user-scsi.c
> +++ b/contrib/vhost-user-scsi/vhost-user-scsi.c
> @@ -11,7 +11,7 @@
>   */
>  
>  #include "qemu/osdep.h"
> -#include "contrib/libvhost-user/libvhost-user.h"
> +#include "contrib/libvhost-user/libvhost-user-glib.h"
>  #include "standard-headers/linux/virtio_scsi.h"
>  #include "iscsi/iscsi.h"
>  #include "iscsi/scsi-lowlevel.h"
> @@ -26,95 +26,13 @@ typedef struct VusIscsiLun {
>  } VusIscsiLun;
>  
>  typedef struct VusDev {
> -    VuDev vu_dev;
> +    VugDev parent;
> +
>      int server_sock;
> -    GMainLoop *loop;
> -    GHashTable *fdmap;   /* fd -> gsource */
>      VusIscsiLun lun;
> +    GMainLoop *loop;
>  } VusDev;
>  
> -/** glib event loop integration for libvhost-user and misc callbacks **/
> -
> -QEMU_BUILD_BUG_ON((int)G_IO_IN != (int)VU_WATCH_IN);
> -QEMU_BUILD_BUG_ON((int)G_IO_OUT != (int)VU_WATCH_OUT);
> -QEMU_BUILD_BUG_ON((int)G_IO_PRI != (int)VU_WATCH_PRI);
> -QEMU_BUILD_BUG_ON((int)G_IO_ERR != (int)VU_WATCH_ERR);
> -QEMU_BUILD_BUG_ON((int)G_IO_HUP != (int)VU_WATCH_HUP);
> -
> -typedef struct vus_gsrc {
> -    GSource parent;
> -    VusDev *vdev_scsi;
> -    GPollFD gfd;
> -} vus_gsrc_t;
> -
> -static gboolean vus_gsrc_prepare(GSource *src, gint *timeout)
> -{
> -    assert(timeout);
> -
> -    *timeout = -1;
> -    return FALSE;
> -}
> -
> -static gboolean vus_gsrc_check(GSource *src)
> -{
> -    vus_gsrc_t *vus_src = (vus_gsrc_t *)src;
> -
> -    assert(vus_src);
> -
> -    return vus_src->gfd.revents & vus_src->gfd.events;
> -}
> -
> -static gboolean vus_gsrc_dispatch(GSource *src, GSourceFunc cb, gpointer data)
> -{
> -    VusDev *vdev_scsi;
> -    vus_gsrc_t *vus_src = (vus_gsrc_t *)src;
> -
> -    assert(vus_src);
> -
> -    vdev_scsi = vus_src->vdev_scsi;
> -
> -    assert(vdev_scsi);
> -
> -    ((vu_watch_cb)cb)(&vdev_scsi->vu_dev, vus_src->gfd.revents, data);
> -
> -    return G_SOURCE_CONTINUE;
> -}
> -
> -static GSourceFuncs vus_gsrc_funcs = {
> -    vus_gsrc_prepare,
> -    vus_gsrc_check,
> -    vus_gsrc_dispatch,
> -    NULL
> -};
> -
> -static GSource *vus_gsrc_new(VusDev *vdev_scsi, int fd, GIOCondition cond,
> -                             vu_watch_cb vu_cb, GSourceFunc gsrc_cb, gpointer data)
> -{
> -    GSource *vus_gsrc;
> -    vus_gsrc_t *vus_src;
> -    guint id;
> -
> -    assert(vdev_scsi);
> -    assert(fd >= 0);
> -    assert(vu_cb || gsrc_cb);
> -    assert(!(vu_cb && gsrc_cb));
> -
> -    vus_gsrc = g_source_new(&vus_gsrc_funcs, sizeof(vus_gsrc_t));
> -    g_source_set_callback(vus_gsrc, (GSourceFunc) vu_cb, data, NULL);
> -    vus_src = (vus_gsrc_t *)vus_gsrc;
> -    vus_src->vdev_scsi = vdev_scsi;
> -    vus_src->gfd.fd = fd;
> -    vus_src->gfd.events = cond;
> -
> -    g_source_add_poll(vus_gsrc, &vus_src->gfd);
> -    g_source_set_callback(vus_gsrc, gsrc_cb, data, NULL);
> -    id = g_source_attach(vus_gsrc, NULL);
> -    assert(id);
> -    g_source_unref(vus_gsrc);
> -
> -    return vus_gsrc;
> -}
> -
>  /** libiscsi integration **/
>  
>  typedef struct virtio_scsi_cmd_req VirtIOSCSICmdReq;
> @@ -291,11 +209,13 @@ static int handle_cmd_sync(struct iscsi_context *ctx,
>  
>  static void vus_panic_cb(VuDev *vu_dev, const char *buf)
>  {
> +    VugDev *gdev;
>      VusDev *vdev_scsi;
>  
>      assert(vu_dev);
>  
> -    vdev_scsi = container_of(vu_dev, VusDev, vu_dev);
> +    gdev = container_of(vu_dev, VugDev, parent);
> +    vdev_scsi = container_of(gdev, VusDev, parent);
>      if (buf) {
>          g_warning("vu_panic: %s", buf);
>      }
> @@ -303,40 +223,16 @@ static void vus_panic_cb(VuDev *vu_dev, const char *buf)
>      g_main_loop_quit(vdev_scsi->loop);
>  }
>  
> -static void vus_add_watch_cb(VuDev *vu_dev, int fd, int vu_evt, vu_watch_cb cb,
> -                             void *pvt)
> -{
> -    GSource *src;
> -    VusDev *vdev_scsi;
> -
> -    assert(vu_dev);
> -    assert(fd >= 0);
> -    assert(cb);
> -
> -    vdev_scsi = container_of(vu_dev, VusDev, vu_dev);
> -    src = vus_gsrc_new(vdev_scsi, fd, vu_evt, cb, NULL, pvt);
> -    g_hash_table_replace(vdev_scsi->fdmap, GINT_TO_POINTER(fd), src);
> -}
> -
> -static void vus_del_watch_cb(VuDev *vu_dev, int fd)
> -{
> -    VusDev *vdev_scsi;
> -
> -    assert(vu_dev);
> -    assert(fd >= 0);
> -
> -    vdev_scsi = container_of(vu_dev, VusDev, vu_dev);
> -    g_hash_table_remove(vdev_scsi->fdmap, GINT_TO_POINTER(fd));
> -}
> -
>  static void vus_proc_req(VuDev *vu_dev, int idx)
>  {
> +    VugDev *gdev;
>      VusDev *vdev_scsi;
>      VuVirtq *vq;
>  
>      assert(vu_dev);
>  
> -    vdev_scsi = container_of(vu_dev, VusDev, vu_dev);
> +    gdev = container_of(vu_dev, VugDev, parent);
> +    vdev_scsi = container_of(gdev, VusDev, parent);
>      if (idx < 0 || idx >= VHOST_MAX_NR_VIRTQUEUE) {
>          g_warning("VQ Index out of range: %d", idx);
>          vus_panic_cb(vu_dev, NULL);
> @@ -420,21 +316,6 @@ static const VuDevIface vus_iface = {
>      .queue_set_started = vus_queue_set_started,
>  };
>  
> -static gboolean vus_vhost_cb(gpointer data)
> -{
> -    VuDev *vu_dev = (VuDev *)data;
> -
> -    assert(vu_dev);
> -
> -    if (!vu_dispatch(vu_dev) != 0) {
> -        g_warning("Error processing vhost message");
> -        vus_panic_cb(vu_dev, NULL);
> -        return G_SOURCE_REMOVE;
> -    }
> -
> -    return G_SOURCE_CONTINUE;
> -}
> -
>  /** misc helpers **/
>  
>  static int unix_sock_new(char *unix_fn)
> @@ -482,7 +363,6 @@ static void vdev_scsi_free(VusDev *vdev_scsi)
>          close(vdev_scsi->server_sock);
>      }
>      g_main_loop_unref(vdev_scsi->loop);
> -    g_hash_table_unref(vdev_scsi->fdmap);
>      g_free(vdev_scsi);
>  }
>  
> @@ -493,9 +373,6 @@ static VusDev *vdev_scsi_new(int server_sock)
>      vdev_scsi = g_new0(VusDev, 1);
>      vdev_scsi->server_sock = server_sock;
>      vdev_scsi->loop = g_main_loop_new(NULL, FALSE);
> -    vdev_scsi->fdmap =
> -        g_hash_table_new_full(NULL, NULL, NULL,
> -                              (GDestroyNotify) g_source_destroy);
>  
>      return vdev_scsi;
>  }
> @@ -503,11 +380,9 @@ static VusDev *vdev_scsi_new(int server_sock)
>  static int vdev_scsi_run(VusDev *vdev_scsi)
>  {
>      int cli_sock;
> -    int ret = 0;
>  
>      assert(vdev_scsi);
>      assert(vdev_scsi->server_sock >= 0);
> -    assert(vdev_scsi->loop);
>  
>      cli_sock = accept(vdev_scsi->server_sock, NULL, NULL);
>      if (cli_sock < 0) {
> @@ -515,21 +390,16 @@ static int vdev_scsi_run(VusDev *vdev_scsi)
>          return -1;
>      }
>  
> -    vu_init(&vdev_scsi->vu_dev,
> -            cli_sock,
> -            vus_panic_cb,
> -            vus_add_watch_cb,
> -            vus_del_watch_cb,
> -            &vus_iface);
> -
> -    vus_gsrc_new(vdev_scsi, cli_sock, G_IO_IN, NULL, vus_vhost_cb,
> -                 &vdev_scsi->vu_dev);
> +    vug_init(&vdev_scsi->parent,
> +             cli_sock,
> +             vus_panic_cb,
> +             &vus_iface);
>  
>      g_main_loop_run(vdev_scsi->loop);
>  
> -    vu_deinit(&vdev_scsi->vu_dev);
> +    vug_deinit(&vdev_scsi->parent);
>  
> -    return ret;
> +    return 0;
>  }
>  
>  int main(int argc, char **argv)
> 

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
