Received: from eggs.gnu.org ([2001:4830:134:3::10]:49478)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1droCN-0005mR-0P
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 12:38:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1droCI-0006Sh-Tr
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 12:38:07 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:34316)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1droCI-0006SE-PZ
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 12:38:02 -0400
Received: by mail-qt0-x241.google.com with SMTP id q8so7665092qtb.1
	for <qemu-devel@nongnu.org>; Tue, 12 Sep 2017 09:38:02 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170823162004.27337-1-marcandre.lureau@redhat.com>
	<20170823162004.27337-6-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <c9f1c67f-dd9d-1738-d100-6b6e686bfc19@amsat.org>
Date: Tue, 12 Sep 2017 13:37:59 -0300
MIME-Version: 1.0
In-Reply-To: <20170823162004.27337-6-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 05/27] vhost-user-scsi: connect unix socket
 before allocating
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
> This simplify a little bit memory management in the following patches.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   contrib/vhost-user-scsi/vhost-user-scsi.c | 18 +++++++++---------
>   1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/contrib/vhost-user-scsi/vhost-user-scsi.c b/contrib/vhost-user-scsi/vhost-user-scsi.c
> index 1fb57da2da..cddaaf8995 100644
> --- a/contrib/vhost-user-scsi/vhost-user-scsi.c
> +++ b/contrib/vhost-user-scsi/vhost-user-scsi.c
> @@ -715,11 +715,11 @@ static void vdev_scsi_deinit(vhost_scsi_dev_t *vdev_scsi)
>       }
>   }
>   
> -static vhost_scsi_dev_t *vdev_scsi_new(char *unix_fn)
> +static vhost_scsi_dev_t *vdev_scsi_new(int server_sock)
>   {
>       vhost_scsi_dev_t *vdev_scsi = NULL;
>   
> -    assert(unix_fn);
> +    assert(server_sock >= 0);

This assert() can't happen anymore.

Removing it:
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

>   
>       vdev_scsi = calloc(1, sizeof(vhost_scsi_dev_t));
>       if (!vdev_scsi) {
> @@ -727,11 +727,7 @@ static vhost_scsi_dev_t *vdev_scsi_new(char *unix_fn)
>           return NULL;
>       }
>   
> -    vdev_scsi->server_sock = unix_sock_new(unix_fn);
> -    if (vdev_scsi->server_sock < 0) {
> -        goto err;
> -    }
> -
> +    vdev_scsi->server_sock = server_sock;
>       vdev_scsi->loop = g_main_loop_new(NULL, FALSE);
>       if (!vdev_scsi->loop) {
>           PERR("Error creating glib event loop");
> @@ -815,7 +811,7 @@ int main(int argc, char **argv)
>       vhost_scsi_dev_t *vdev_scsi = NULL;
>       char *unix_fn = NULL;
>       char *iscsi_uri = NULL;
> -    int opt, err = EXIT_SUCCESS;
> +    int sock, opt, err = EXIT_SUCCESS;
>   
>       while ((opt = getopt(argc, argv, "u:i:")) != -1) {
>           switch (opt) {
> @@ -835,7 +831,11 @@ int main(int argc, char **argv)
>           goto help;
>       }
>   
> -    vdev_scsi = vdev_scsi_new(unix_fn);
> +    sock = unix_sock_new(unix_fn);
> +    if (sock < 0) {
> +        goto err;
> +    }
> +    vdev_scsi = vdev_scsi_new(sock);
>       if (!vdev_scsi) {
>           goto err;
>       }
> 
