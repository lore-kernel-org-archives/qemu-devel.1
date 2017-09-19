Received: from eggs.gnu.org ([2001:4830:134:3::10]:55456)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1duIpi-0006q0-1S
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 09:45:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1duIpf-00032r-A9
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 09:45:02 -0400
Received: from mail-wr0-f179.google.com ([209.85.128.179]:56215)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1duIpf-00031P-1k
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 09:44:59 -0400
Received: by mail-wr0-f179.google.com with SMTP id l39so24634wrl.12
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 06:44:58 -0700 (PDT)
References: <20170823162004.27337-1-marcandre.lureau@redhat.com>
	<20170823162004.27337-11-marcandre.lureau@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <98eb7b7d-08a4-9cc8-d9fc-2849d4718932@redhat.com>
Date: Tue, 19 Sep 2017 15:44:55 +0200
MIME-Version: 1.0
In-Reply-To: <20170823162004.27337-11-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 10/27] vhost-user-scsi: remove
 vdev_scsi_find_by_vu()
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
> The *dev pointer belongs to the vhost_scsi_dev_t parent.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  contrib/vhost-user-scsi/vhost-user-scsi.c | 47 +++----------------------------
>  1 file changed, 4 insertions(+), 43 deletions(-)
> 
> diff --git a/contrib/vhost-user-scsi/vhost-user-scsi.c b/contrib/vhost-user-scsi/vhost-user-scsi.c
> index d0456a5e7c..bb10848cd2 100644
> --- a/contrib/vhost-user-scsi/vhost-user-scsi.c
> +++ b/contrib/vhost-user-scsi/vhost-user-scsi.c
> @@ -55,8 +55,6 @@
>  
>   /* Only 1 LUN and device supported today */
>  #define VUS_MAX_LUNS 1
> -#define VUS_MAX_DEVS 1
> -
>  #define VUS_ISCSI_INITIATOR "iqn.2016-11.com.nutanix:vhost-user-scsi"
>  
>  typedef struct iscsi_lun {
> @@ -72,8 +70,6 @@ typedef struct vhost_scsi_dev {
>      iscsi_lun_t luns[VUS_MAX_LUNS];
>  } vhost_scsi_dev_t;
>  
> -static vhost_scsi_dev_t *vhost_scsi_devs[VUS_MAX_DEVS];
> -
>  /** glib event loop integration for libvhost-user and misc callbacks **/
>  
>  QEMU_BUILD_BUG_ON((int)G_IO_IN != (int)VU_WATCH_IN);
> @@ -420,16 +416,13 @@ static int handle_cmd_sync(struct iscsi_context *ctx,
>  
>  /** libvhost-user callbacks **/
>  
> -static vhost_scsi_dev_t *vdev_scsi_find_by_vu(VuDev *vu_dev);
> -
>  static void vus_panic_cb(VuDev *vu_dev, const char *buf)
>  {
>      vhost_scsi_dev_t *vdev_scsi;
>  
>      assert(vu_dev);
>  
> -    vdev_scsi = vdev_scsi_find_by_vu(vu_dev);
> -
> +    vdev_scsi = container_of(vu_dev, vhost_scsi_dev_t, vu_dev);
>      if (buf) {
>          PERR("vu_panic: %s", buf);
>      }
> @@ -447,12 +440,7 @@ static void vus_add_watch_cb(VuDev *vu_dev, int fd, int vu_evt, vu_watch_cb cb,
>      assert(fd >= 0);
>      assert(cb);
>  
> -    vdev_scsi = vdev_scsi_find_by_vu(vu_dev);
> -    if (!vdev_scsi) {
> -        vus_panic_cb(vu_dev, NULL);
> -        return;
> -    }
> -
> +    vdev_scsi = container_of(vu_dev, vhost_scsi_dev_t, vu_dev);
>      id = (guint)(uintptr_t)g_tree_lookup(vdev_scsi->fdmap,
>                                           (gpointer)(uintptr_t)fd);
>      if (id) {
> @@ -473,12 +461,7 @@ static void vus_del_watch_cb(VuDev *vu_dev, int fd)
>      assert(vu_dev);
>      assert(fd >= 0);
>  
> -    vdev_scsi = vdev_scsi_find_by_vu(vu_dev);
> -    if (!vdev_scsi) {
> -        vus_panic_cb(vu_dev, NULL);
> -        return;
> -    }
> -
> +    vdev_scsi = container_of(vu_dev, vhost_scsi_dev_t, vu_dev);
>      id = (guint)(uintptr_t)g_tree_lookup(vdev_scsi->fdmap,
>                                           (gpointer)(uintptr_t)fd);
>      if (id) {
> @@ -506,12 +489,7 @@ static void vus_proc_req(VuDev *vu_dev, int idx)
>  
>      assert(vu_dev);
>  
> -    vdev_scsi = vdev_scsi_find_by_vu(vu_dev);
> -    if (!vdev_scsi) {
> -        vus_panic_cb(vu_dev, NULL);
> -        return;
> -    }
> -
> +    vdev_scsi = container_of(vu_dev, vhost_scsi_dev_t, vu_dev);
>      if (idx < 0 || idx >= VHOST_MAX_NR_VIRTQUEUE) {
>          PERR("VQ Index out of range: %d", idx);
>          vus_panic_cb(vu_dev, NULL);
> @@ -656,22 +634,6 @@ fail:
>  
>  /** vhost-user-scsi **/
>  
> -static vhost_scsi_dev_t *vdev_scsi_find_by_vu(VuDev *vu_dev)
> -{
> -    int i;
> -
> -    assert(vu_dev);
> -
> -    for (i = 0; i < VUS_MAX_DEVS; i++) {
> -        if (&vhost_scsi_devs[i]->vu_dev == vu_dev) {
> -            return vhost_scsi_devs[i];
> -        }
> -    }
> -
> -    PERR("Unknown VuDev %p", vu_dev);
> -    return NULL;
> -}
> -
>  static void vdev_scsi_free(vhost_scsi_dev_t *vdev_scsi)
>  {
>      if (!vdev_scsi) {
> @@ -792,7 +754,6 @@ int main(int argc, char **argv)
>          goto err;
>      }
>      vdev_scsi = vdev_scsi_new(sock);
> -    vhost_scsi_devs[0] = vdev_scsi;
>  
>      if (vdev_scsi_add_iscsi_lun(vdev_scsi, iscsi_uri, 0) != 0) {
>          goto err;
> 

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
