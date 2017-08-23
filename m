Received: from eggs.gnu.org ([2001:4830:134:3::10]:40364)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dkZqP-0001lu-PG
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 13:53:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dkZqM-0007Kx-CJ
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 13:53:33 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:35698)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dkZqM-0007KD-90
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 13:53:30 -0400
Received: by mail-qk0-x244.google.com with SMTP id l68so224625qke.2
	for <qemu-devel@nongnu.org>; Wed, 23 Aug 2017 10:53:30 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170823162004.27337-1-marcandre.lureau@redhat.com>
	<20170823162004.27337-8-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <49bf5d02-5e35-126a-1746-bb9427857879@amsat.org>
Date: Wed, 23 Aug 2017 14:53:25 -0300
MIME-Version: 1.0
In-Reply-To: <20170823162004.27337-8-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 07/27] vhost-user-scsi: use glib allocation
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
> Use g_new/g_free instead of plain malloc. This simplify a bit memory
> handling since glib will abort if it cannot allocate.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   contrib/vhost-user-scsi/vhost-user-scsi.c | 35 ++++++++-----------------------
>   1 file changed, 9 insertions(+), 26 deletions(-)
> 
> diff --git a/contrib/vhost-user-scsi/vhost-user-scsi.c b/contrib/vhost-user-scsi/vhost-user-scsi.c
> index 8d6ff18cc4..f3fc8c23c6 100644
> --- a/contrib/vhost-user-scsi/vhost-user-scsi.c
> +++ b/contrib/vhost-user-scsi/vhost-user-scsi.c
> @@ -312,12 +312,7 @@ static struct scsi_task *scsi_task_new(int cdb_len, uint8_t *cdb, int dir,
>       assert(cdb_len > 0);
>       assert(cdb);
>   
> -    task = calloc(1, sizeof(struct scsi_task));
> -    if (!task) {
> -        PERR("Error allocating task: %s", strerror(errno));
> -        return NULL;
> -    }
> -
> +    task = g_new0(struct scsi_task, 1);
>       memcpy(task->cdb, cdb, cdb_len);
>       task->cdb_size = cdb_len;
>       task->xfer_dir = dir;
> @@ -393,10 +388,6 @@ static int handle_cmd_sync(struct iscsi_context *ctx,
>       }
>   
>       task = scsi_task_new(cdb_len, req->cdb, dir, len);
> -    if (!task) {
> -        PERR("Unable to create iscsi task");
> -        return -1;
> -    }
>   
>       if (dir == SCSI_XFER_TO_DEV) {
>           task->iovector_out.iov = (struct scsi_iovec *)out;
> @@ -410,7 +401,7 @@ static int handle_cmd_sync(struct iscsi_context *ctx,
>            cdb_len, dir, task);
>       if (!iscsi_scsi_command_sync(ctx, 0, task, NULL)) {
>           PERR("Error serving SCSI command");
> -        free(task);
> +        g_free(task);
>           return -1;
>       }
>   
> @@ -425,7 +416,7 @@ static int handle_cmd_sync(struct iscsi_context *ctx,
>           memcpy(rsp->sense, &task->datain.data[2], rsp->sense_len);
>       }
>   
> -    free(task);
> +    g_free(task);
>   
>       PDBG("Filled in rsp: status=%hhX, resid=%u, response=%hhX, sense_len=%u",
>            rsp->status, rsp->resid, rsp->response, rsp->sense_len);
> @@ -692,7 +683,7 @@ static vhost_scsi_dev_t *vdev_scsi_find_by_vu(VuDev *vu_dev)
>       return NULL;
>   }
>   
> -static void vdev_scsi_deinit(vhost_scsi_dev_t *vdev_scsi)
> +static void vdev_scsi_free(vhost_scsi_dev_t *vdev_scsi)
>   {
>       if (!vdev_scsi) {
>           return;
> @@ -716,20 +707,16 @@ static void vdev_scsi_deinit(vhost_scsi_dev_t *vdev_scsi)
>           g_main_loop_unref(vdev_scsi->loop);
>           vdev_scsi->loop = NULL;
>       }
> +    g_free(vdev_scsi);

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

>   }
>   
>   static vhost_scsi_dev_t *vdev_scsi_new(int server_sock)
>   {
> -    vhost_scsi_dev_t *vdev_scsi = NULL;
> +    vhost_scsi_dev_t *vdev_scsi;
>   
>       assert(server_sock >= 0);
>   
> -    vdev_scsi = calloc(1, sizeof(vhost_scsi_dev_t));
> -    if (!vdev_scsi) {
> -        PERR("calloc: %s", strerror(errno));
> -        return NULL;
> -    }
> -
> +    vdev_scsi = g_new0(vhost_scsi_dev_t, 1);
>       vdev_scsi->server_sock = server_sock;
>       vdev_scsi->loop = g_main_loop_new(NULL, FALSE);
>       if (!vdev_scsi->loop) {
> @@ -746,8 +733,7 @@ static vhost_scsi_dev_t *vdev_scsi_new(int server_sock)
>       return vdev_scsi;
>   
>   err:
> -    vdev_scsi_deinit(vdev_scsi);
> -    free(vdev_scsi);
> +    vdev_scsi_free(vdev_scsi);
>   
>       return NULL;
>   }
> @@ -854,10 +840,7 @@ int main(int argc, char **argv)
>       }
>   
>   out:
> -    if (vdev_scsi) {
> -        vdev_scsi_deinit(vdev_scsi);
> -        free(vdev_scsi);
> -    }
> +    vdev_scsi_free(vdev_scsi);
>       g_free(unix_fn);
>       g_free(iscsi_uri);
>   
> 
