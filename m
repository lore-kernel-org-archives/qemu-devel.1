Received: from eggs.gnu.org ([2001:4830:134:3::10]:54900)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1duIp7-0006JP-8c
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 09:44:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1duIp4-0002e6-GF
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 09:44:25 -0400
Received: from mail-wr0-f180.google.com ([209.85.128.180]:47525)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1duIp4-0002dX-6y
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 09:44:22 -0400
Received: by mail-wr0-f180.google.com with SMTP id k20so41736wre.4
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 06:44:22 -0700 (PDT)
References: <20170823162004.27337-1-marcandre.lureau@redhat.com>
	<20170823162004.27337-9-marcandre.lureau@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e01cf9f0-4d16-9a5c-04db-b85a166e55b4@redhat.com>
Date: Tue, 19 Sep 2017 15:44:19 +0200
MIME-Version: 1.0
In-Reply-To: <20170823162004.27337-9-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 08/27] vhost-user-scsi: glib calls that
 allocate don't return NULL
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
> They abort instead, so get rid of failure conditions.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  contrib/vhost-user-scsi/vhost-user-scsi.c | 52 +++++--------------------------
>  1 file changed, 7 insertions(+), 45 deletions(-)
> 
> diff --git a/contrib/vhost-user-scsi/vhost-user-scsi.c b/contrib/vhost-user-scsi/vhost-user-scsi.c
> index f3fc8c23c6..5f8ff9d9e5 100644
> --- a/contrib/vhost-user-scsi/vhost-user-scsi.c
> +++ b/contrib/vhost-user-scsi/vhost-user-scsi.c
> @@ -139,8 +139,8 @@ static GSourceFuncs vus_gsrc_funcs = {
>      NULL
>  };
>  
> -static int vus_gsrc_new(vhost_scsi_dev_t *vdev_scsi, int fd, GIOCondition cond,
> -                        vu_watch_cb vu_cb, GSourceFunc gsrc_cb, gpointer data)
> +static void vus_gsrc_new(vhost_scsi_dev_t *vdev_scsi, int fd, GIOCondition cond,
> +                         vu_watch_cb vu_cb, GSourceFunc gsrc_cb, gpointer data)
>  {
>      GSource *vus_gsrc;
>      vus_gsrc_t *vus_src;
> @@ -152,10 +152,6 @@ static int vus_gsrc_new(vhost_scsi_dev_t *vdev_scsi, int fd, GIOCondition cond,
>      assert(!(vu_cb && gsrc_cb));
>  
>      vus_gsrc = g_source_new(&vus_gsrc_funcs, sizeof(vus_gsrc_t));
> -    if (!vus_gsrc) {
> -        PERR("Error creating GSource for new watch");
> -        return -1;
> -    }
>      vus_src = (vus_gsrc_t *)vus_gsrc;
>  
>      vus_src->vdev_scsi = vdev_scsi;
> @@ -171,8 +167,6 @@ static int vus_gsrc_new(vhost_scsi_dev_t *vdev_scsi, int fd, GIOCondition cond,
>  
>      g_tree_insert(vdev_scsi->fdmap, (gpointer)(uintptr_t)fd,
>                                      (gpointer)(uintptr_t)id);
> -
> -    return 0;
>  }
>  
>  /* from libiscsi's scsi-lowlevel.h **
> @@ -440,10 +434,7 @@ static void vus_panic_cb(VuDev *vu_dev, const char *buf)
>          PERR("vu_panic: %s", buf);
>      }
>  
> -    if (vdev_scsi) {
> -        assert(vdev_scsi->loop);
> -        g_main_loop_quit(vdev_scsi->loop);
> -    }
> +    g_main_loop_quit(vdev_scsi->loop);
>  }
>  
>  static void vus_add_watch_cb(VuDev *vu_dev, int fd, int vu_evt, vu_watch_cb cb,
> @@ -471,9 +462,7 @@ static void vus_add_watch_cb(VuDev *vu_dev, int fd, int vu_evt, vu_watch_cb cb,
>          (void)g_tree_remove(vdev_scsi->fdmap, (gpointer)(uintptr_t)fd);
>      }
>  
> -    if (vus_gsrc_new(vdev_scsi, fd, vu_evt, cb, NULL, pvt)) {
> -        vus_panic_cb(vu_dev, NULL);
> -    }
> +    vus_gsrc_new(vdev_scsi, fd, vu_evt, cb, NULL, pvt);
>  }
>  
>  static void vus_del_watch_cb(VuDev *vu_dev, int fd)
> @@ -703,10 +692,7 @@ static void vdev_scsi_free(vhost_scsi_dev_t *vdev_scsi)
>          vdev_scsi->server_sock = -1;
>      }
>  
> -    if (vdev_scsi->loop) {
> -        g_main_loop_unref(vdev_scsi->loop);
> -        vdev_scsi->loop = NULL;
> -    }
> +    g_main_loop_unref(vdev_scsi->loop);
>      g_free(vdev_scsi);
>  }
>  
> @@ -719,23 +705,9 @@ static vhost_scsi_dev_t *vdev_scsi_new(int server_sock)
>      vdev_scsi = g_new0(vhost_scsi_dev_t, 1);
>      vdev_scsi->server_sock = server_sock;
>      vdev_scsi->loop = g_main_loop_new(NULL, FALSE);
> -    if (!vdev_scsi->loop) {
> -        PERR("Error creating glib event loop");
> -        goto err;
> -    }
> -
>      vdev_scsi->fdmap = g_tree_new(vus_fdmap_compare);
> -    if (!vdev_scsi->fdmap) {
> -        PERR("Error creating glib tree for fdmap");
> -        goto err;
> -    }
>  
>      return vdev_scsi;
> -
> -err:
> -    vdev_scsi_free(vdev_scsi);
> -
> -    return NULL;
>  }
>  
>  static int vdev_scsi_add_iscsi_lun(vhost_scsi_dev_t *vdev_scsi,
> @@ -779,21 +751,14 @@ static int vdev_scsi_run(vhost_scsi_dev_t *vdev_scsi)
>              vus_del_watch_cb,
>              &vus_iface);
>  
> -    if (vus_gsrc_new(vdev_scsi, cli_sock, G_IO_IN, NULL, vus_vhost_cb,
> -                     &vdev_scsi->vu_dev)) {
> -        goto fail;
> -    }
> +    vus_gsrc_new(vdev_scsi, cli_sock, G_IO_IN, NULL, vus_vhost_cb,
> +                 &vdev_scsi->vu_dev);
>  
>      g_main_loop_run(vdev_scsi->loop);
>  
> -out:
>      vu_deinit(&vdev_scsi->vu_dev);
>  
>      return ret;
> -
> -fail:
> -    ret = -1;
> -    goto out;
>  }
>  
>  int main(int argc, char **argv)
> @@ -826,9 +791,6 @@ int main(int argc, char **argv)
>          goto err;
>      }
>      vdev_scsi = vdev_scsi_new(sock);
> -    if (!vdev_scsi) {
> -        goto err;
> -    }
>      vhost_scsi_devs[0] = vdev_scsi;
>  
>      if (vdev_scsi_add_iscsi_lun(vdev_scsi, iscsi_uri, 0) != 0) {
> 

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
