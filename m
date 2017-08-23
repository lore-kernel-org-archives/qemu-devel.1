Received: from eggs.gnu.org ([2001:4830:134:3::10]:51519)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dkfYL-0000T0-EN
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 19:59:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dkfYG-0001j5-IA
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 19:59:17 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:38328)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dkfYG-0001in-Cu
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 19:59:12 -0400
Received: by mail-qk0-x244.google.com with SMTP id v135so971970qkb.5
	for <qemu-devel@nongnu.org>; Wed, 23 Aug 2017 16:59:12 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170823162004.27337-1-marcandre.lureau@redhat.com>
	<20170823162004.27337-22-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <0a75cf4a-af2d-be41-e02d-8952d7934158@amsat.org>
Date: Wed, 23 Aug 2017 20:59:07 -0300
MIME-Version: 1.0
In-Reply-To: <20170823162004.27337-22-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 21/27] vhost-user-scsi: drop extra callback
 pointer
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
> Use the one from the source with casting, like any other glib source.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   contrib/vhost-user-scsi/vhost-user-scsi.c | 12 +++---------
>   1 file changed, 3 insertions(+), 9 deletions(-)
> 
> diff --git a/contrib/vhost-user-scsi/vhost-user-scsi.c b/contrib/vhost-user-scsi/vhost-user-scsi.c
> index 795799ec14..102d910e8f 100644
> --- a/contrib/vhost-user-scsi/vhost-user-scsi.c
> +++ b/contrib/vhost-user-scsi/vhost-user-scsi.c
> @@ -81,7 +81,6 @@ typedef struct vus_gsrc {
>       GSource parent;
>       VusDev *vdev_scsi;
>       GPollFD gfd;
> -    vu_watch_cb vu_cb;
>   } vus_gsrc_t;
>   
>   static gint vus_fdmap_compare(gconstpointer a, gconstpointer b)
> @@ -112,18 +111,13 @@ static gboolean vus_gsrc_dispatch(GSource *src, GSourceFunc cb, gpointer data)
>       vus_gsrc_t *vus_src = (vus_gsrc_t *)src;
>   
>       assert(vus_src);
> -    assert(!(vus_src->vu_cb && cb));
>   
>       vdev_scsi = vus_src->vdev_scsi;
>   
>       assert(vdev_scsi);
>   
> -    if (cb) {
> -        return cb(data);
> -    }
> -    if (vus_src->vu_cb) {
> -        vus_src->vu_cb(&vdev_scsi->vu_dev, vus_src->gfd.revents, data);
> -    }
> +    ((vu_watch_cb)cb) (&vdev_scsi->vu_dev, vus_src->gfd.revents, data);

dropping the space between func/args:
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> +
>       return G_SOURCE_CONTINUE;
>   }
>   
> @@ -146,12 +140,12 @@ static void vus_gsrc_new(VusDev *vdev_scsi, int fd, GIOCondition cond,
>       assert(vu_cb);
>   
>       vus_gsrc = g_source_new(&vus_gsrc_funcs, sizeof(vus_gsrc_t));
> +    g_source_set_callback(vus_gsrc, (GSourceFunc) vu_cb, data, NULL);
>       vus_src = (vus_gsrc_t *)vus_gsrc;
>   
>       vus_src->vdev_scsi = vdev_scsi;
>       vus_src->gfd.fd = fd;
>       vus_src->gfd.events = cond;
> -    vus_src->vu_cb = vu_cb;
>   
>       g_source_add_poll(vus_gsrc, &vus_src->gfd);
>       id = g_source_attach(vus_gsrc, NULL);
> 
