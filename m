Received: from eggs.gnu.org ([2001:4830:134:3::10]:53045)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dkfhC-00055Y-BJ
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 20:08:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dkfh7-0005tm-D9
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 20:08:26 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:34721)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dkfh7-0005ti-8e
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 20:08:21 -0400
Received: by mail-qk0-x243.google.com with SMTP id s3so1018430qkd.1
	for <qemu-devel@nongnu.org>; Wed, 23 Aug 2017 17:08:21 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170823162004.27337-1-marcandre.lureau@redhat.com>
	<20170823162004.27337-17-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <ec985a84-0a3b-4985-3eef-0169125f2ff2@amsat.org>
Date: Wed, 23 Aug 2017 21:08:17 -0300
MIME-Version: 1.0
In-Reply-To: <20170823162004.27337-17-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 16/27] vhost-user-scsi: remove VUS_MAX_LUNS
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
> There is no code to support more than 1 yet, no need for that today.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>   contrib/vhost-user-scsi/vhost-user-scsi.c | 8 +++-----
>   1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/contrib/vhost-user-scsi/vhost-user-scsi.c b/contrib/vhost-user-scsi/vhost-user-scsi.c
> index f6f9e7b192..429e3065ea 100644
> --- a/contrib/vhost-user-scsi/vhost-user-scsi.c
> +++ b/contrib/vhost-user-scsi/vhost-user-scsi.c
> @@ -53,8 +53,6 @@
>   
>   /** vhost-user-scsi specific definitions **/
>   
> - /* Only 1 LUN and device supported today */
> -#define VUS_MAX_LUNS 1
>   #define VUS_ISCSI_INITIATOR "iqn.2016-11.com.nutanix:vhost-user-scsi"
>   
>   typedef struct iscsi_lun {
> @@ -67,7 +65,7 @@ typedef struct vhost_scsi_dev {
>       int server_sock;
>       GMainLoop *loop;
>       GTree *fdmap;   /* fd -> gsource context id */
> -    iscsi_lun_t luns[VUS_MAX_LUNS];
> +    iscsi_lun_t lun;
>   } vhost_scsi_dev_t;
>   
>   /** glib event loop integration for libvhost-user and misc callbacks **/
> @@ -533,7 +531,7 @@ static void vus_proc_req(VuDev *vu_dev, int idx)
>           }
>           rsp = (VirtIOSCSICmdResp *)elem->in_sg[0].iov_base;
>   
> -        if (handle_cmd_sync(vdev_scsi->luns[0].iscsi_ctx,
> +        if (handle_cmd_sync(vdev_scsi->lun.iscsi_ctx,
>                               req, &elem->out_sg[1], elem->out_num - 1,
>                               rsp, &elem->in_sg[1], elem->in_num - 1) != 0) {
>               vus_panic_cb(vu_dev, NULL);
> @@ -722,7 +720,7 @@ int main(int argc, char **argv)
>       }
>       vdev_scsi = vdev_scsi_new(sock);
>   
> -    if (iscsi_add_lun(&vdev_scsi->luns[0], iscsi_uri) != 0) {
> +    if (iscsi_add_lun(&vdev_scsi->lun, iscsi_uri) != 0) {
>           goto err;
>       }
>   
> 
