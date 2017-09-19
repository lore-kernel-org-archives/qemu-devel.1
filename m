Received: from eggs.gnu.org ([2001:4830:134:3::10]:36185)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1duJm3-0002LX-U0
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 10:45:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1duJlx-00089w-Rh
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 10:45:19 -0400
Received: from mail-wr0-f171.google.com ([209.85.128.171]:45984)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1duJlx-00088e-Im
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 10:45:13 -0400
Received: by mail-wr0-f171.google.com with SMTP id m18so213835wrm.2
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 07:45:12 -0700 (PDT)
References: <20170823162004.27337-1-marcandre.lureau@redhat.com>
	<20170823162004.27337-23-marcandre.lureau@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <758244bf-1708-4106-e5dc-9b1d6084f29d@redhat.com>
Date: Tue, 19 Sep 2017 16:45:09 +0200
MIME-Version: 1.0
In-Reply-To: <20170823162004.27337-23-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 22/27] vhost-user-scsi: simplify source
 handling
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
> Using a hashtable.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  contrib/vhost-user-scsi/vhost-user-scsi.c | 45 +++++++++----------------------
>  1 file changed, 12 insertions(+), 33 deletions(-)
> 
> diff --git a/contrib/vhost-user-scsi/vhost-user-scsi.c b/contrib/vhost-user-scsi/vhost-user-scsi.c
> index 102d910e8f..516a9d3966 100644
> --- a/contrib/vhost-user-scsi/vhost-user-scsi.c
> +++ b/contrib/vhost-user-scsi/vhost-user-scsi.c
> @@ -65,7 +65,7 @@ typedef struct VusDev {
>      VuDev vu_dev;
>      int server_sock;
>      GMainLoop *loop;
> -    GTree *fdmap;   /* fd -> gsource context id */
> +    GHashTable *fdmap;   /* fd -> gsource */
>      VusIscsiLun lun;
>  } VusDev;
>  
> @@ -83,11 +83,6 @@ typedef struct vus_gsrc {
>      GPollFD gfd;
>  } vus_gsrc_t;
>  
> -static gint vus_fdmap_compare(gconstpointer a, gconstpointer b)
> -{
> -    return (b > a) - (b < a);
> -}
> -
>  static gboolean vus_gsrc_prepare(GSource *src, gint *timeout)
>  {
>      assert(timeout);
> @@ -128,8 +123,8 @@ static GSourceFuncs vus_gsrc_funcs = {
>      NULL
>  };
>  
> -static void vus_gsrc_new(VusDev *vdev_scsi, int fd, GIOCondition cond,
> -                         vu_watch_cb vu_cb, gpointer data)
> +static GSource *vus_gsrc_new(VusDev *vdev_scsi, int fd, GIOCondition cond,
> +                             vu_watch_cb vu_cb, gpointer data)
>  {
>      GSource *vus_gsrc;
>      vus_gsrc_t *vus_src;
> @@ -142,7 +137,6 @@ static void vus_gsrc_new(VusDev *vdev_scsi, int fd, GIOCondition cond,
>      vus_gsrc = g_source_new(&vus_gsrc_funcs, sizeof(vus_gsrc_t));
>      g_source_set_callback(vus_gsrc, (GSourceFunc) vu_cb, data, NULL);
>      vus_src = (vus_gsrc_t *)vus_gsrc;
> -
>      vus_src->vdev_scsi = vdev_scsi;
>      vus_src->gfd.fd = fd;
>      vus_src->gfd.events = cond;
> @@ -152,8 +146,7 @@ static void vus_gsrc_new(VusDev *vdev_scsi, int fd, GIOCondition cond,
>      assert(id);
>      g_source_unref(vus_gsrc);
>  
> -    g_tree_insert(vdev_scsi->fdmap, (gpointer)(uintptr_t)fd,
> -                                    (gpointer)(uintptr_t)id);
> +    return vus_gsrc;
>  }
>  
>  /** libiscsi integration **/
> @@ -346,43 +339,27 @@ static void vus_panic_cb(VuDev *vu_dev, const char *buf)
>  static void vus_add_watch_cb(VuDev *vu_dev, int fd, int vu_evt, vu_watch_cb cb,
>                               void *pvt)
>  {
> +    GSource *src;
>      VusDev *vdev_scsi;
> -    guint id;
>  
>      assert(vu_dev);
>      assert(fd >= 0);
>      assert(cb);
>  
>      vdev_scsi = container_of(vu_dev, VusDev, vu_dev);
> -    id = (guint)(uintptr_t)g_tree_lookup(vdev_scsi->fdmap,
> -                                         (gpointer)(uintptr_t)fd);
> -    if (id) {
> -        GSource *vus_src = g_main_context_find_source_by_id(NULL, id);
> -        assert(vus_src);
> -        g_source_destroy(vus_src);
> -        (void)g_tree_remove(vdev_scsi->fdmap, (gpointer)(uintptr_t)fd);
> -    }
> -
> -    vus_gsrc_new(vdev_scsi, fd, vu_evt, cb, pvt);
> +    src = vus_gsrc_new(vdev_scsi, fd, vu_evt, cb, pvt);
> +    g_hash_table_replace(vdev_scsi->fdmap, GINT_TO_POINTER(fd), src);
>  }
>  
>  static void vus_del_watch_cb(VuDev *vu_dev, int fd)
>  {
>      VusDev *vdev_scsi;
> -    guint id;
>  
>      assert(vu_dev);
>      assert(fd >= 0);
>  
>      vdev_scsi = container_of(vu_dev, VusDev, vu_dev);
> -    id = (guint)(uintptr_t)g_tree_lookup(vdev_scsi->fdmap,
> -                                         (gpointer)(uintptr_t)fd);
> -    if (id) {
> -        GSource *vus_src = g_main_context_find_source_by_id(NULL, id);
> -        assert(vus_src);
> -        g_source_destroy(vus_src);
> -        (void)g_tree_remove(vdev_scsi->fdmap, (gpointer)(uintptr_t)fd);
> -    }
> +    g_hash_table_remove(vdev_scsi->fdmap, GINT_TO_POINTER(fd));
>  }
>  
>  static void vus_proc_req(VuDev *vu_dev, int idx)
> @@ -539,7 +516,7 @@ static void vdev_scsi_free(VusDev *vdev_scsi)
>          close(vdev_scsi->server_sock);
>      }
>      g_main_loop_unref(vdev_scsi->loop);
> -    g_tree_destroy(vdev_scsi->fdmap);
> +    g_hash_table_unref(vdev_scsi->fdmap);
>      g_free(vdev_scsi);
>  }
>  
> @@ -552,7 +529,9 @@ static VusDev *vdev_scsi_new(int server_sock)
>      vdev_scsi = g_new0(VusDev, 1);
>      vdev_scsi->server_sock = server_sock;
>      vdev_scsi->loop = g_main_loop_new(NULL, FALSE);
> -    vdev_scsi->fdmap = g_tree_new(vus_fdmap_compare);
> +    vdev_scsi->fdmap =
> +        g_hash_table_new_full(NULL, NULL, NULL,
> +                              (GDestroyNotify) g_source_destroy);
>  
>      return vdev_scsi;
>  }
> 

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
