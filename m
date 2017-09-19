Received: from eggs.gnu.org ([2001:4830:134:3::10]:56121)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1duIqV-0007eV-NR
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 09:45:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1duIqT-0003dP-1N
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 09:45:51 -0400
Received: from mail-wm0-f43.google.com ([74.125.82.43]:44183)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1duIqS-0003cW-PF
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 09:45:48 -0400
Received: by mail-wm0-f43.google.com with SMTP id 189so84543wmh.1
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 06:45:48 -0700 (PDT)
References: <20170823162004.27337-1-marcandre.lureau@redhat.com>
	<20170823162004.27337-12-marcandre.lureau@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <54e07978-1105-570f-fedf-79418711099f@redhat.com>
Date: Tue, 19 Sep 2017 15:45:45 +0200
MIME-Version: 1.0
In-Reply-To: <20170823162004.27337-12-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 11/27] vhost-user-scsi: simplify unix path
 cleanup
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
> Always remove the unix path when leaving the program (instead of when
> freeing scsi_dev). Note that unix_sock_new() also unlink() exisiting
> path before creating the socket.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  contrib/vhost-user-scsi/vhost-user-scsi.c | 22 +++++-----------------
>  1 file changed, 5 insertions(+), 17 deletions(-)
> 
> diff --git a/contrib/vhost-user-scsi/vhost-user-scsi.c b/contrib/vhost-user-scsi/vhost-user-scsi.c
> index bb10848cd2..624efc24ca 100644
> --- a/contrib/vhost-user-scsi/vhost-user-scsi.c
> +++ b/contrib/vhost-user-scsi/vhost-user-scsi.c
> @@ -636,24 +636,9 @@ fail:
>  
>  static void vdev_scsi_free(vhost_scsi_dev_t *vdev_scsi)
>  {
> -    if (!vdev_scsi) {
> -        return;
> -    }
> -
>      if (vdev_scsi->server_sock >= 0) {
> -        struct sockaddr_storage ss;
> -        socklen_t sslen = sizeof(ss);
> -
> -        if (getsockname(vdev_scsi->server_sock, (struct sockaddr *)&ss,
> -                        &sslen) == 0) {
> -            struct sockaddr_un *su = (struct sockaddr_un *)&ss;
> -            (void)unlink(su->sun_path);
> -        }
> -
> -        (void)close(vdev_scsi->server_sock);
> -        vdev_scsi->server_sock = -1;
> +        close(vdev_scsi->server_sock);
>      }
> -
>      g_main_loop_unref(vdev_scsi->loop);
>      g_tree_destroy(vdev_scsi->fdmap);
>      g_free(vdev_scsi);
> @@ -764,7 +749,10 @@ int main(int argc, char **argv)
>      }
>  
>  out:
> -    vdev_scsi_free(vdev_scsi);
> +    if (vdev_scsi) {
> +        vdev_scsi_free(vdev_scsi);
> +        unlink(unix_fn);
> +    }
>      g_free(unix_fn);
>      g_free(iscsi_uri);
>  
> 

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
