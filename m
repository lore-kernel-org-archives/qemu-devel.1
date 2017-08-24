Received: from eggs.gnu.org ([2001:4830:134:3::10]:52716)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dkffu-0004OV-Ot
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 20:07:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dkffp-0005ac-QH
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 20:07:06 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:35703)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dkffp-0005aU-La
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 20:07:01 -0400
Received: by mail-qk0-x241.google.com with SMTP id l68so1008373qke.2
	for <qemu-devel@nongnu.org>; Wed, 23 Aug 2017 17:07:01 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170823162004.27337-1-marcandre.lureau@redhat.com>
	<20170823162004.27337-28-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <79efc21d-4933-b13e-7e5e-d7f711ab236e@amsat.org>
Date: Wed, 23 Aug 2017 21:06:57 -0300
MIME-Version: 1.0
In-Reply-To: <20170823162004.27337-28-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 27/27] vhost-user-scsi: remove server_sock
 from VusDev
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

Hi Marc-André,

On 08/23/2017 01:20 PM, Marc-André Lureau wrote:
> It is unneeded in the VusDev device structure, and also simplify a bit
> the code.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   contrib/vhost-user-scsi/vhost-user-scsi.c | 52 ++++++++++++++-----------------
>   1 file changed, 23 insertions(+), 29 deletions(-)
> 
> diff --git a/contrib/vhost-user-scsi/vhost-user-scsi.c b/contrib/vhost-user-scsi/vhost-user-scsi.c
> index cfd62b46ce..3166331856 100644
> --- a/contrib/vhost-user-scsi/vhost-user-scsi.c
> +++ b/contrib/vhost-user-scsi/vhost-user-scsi.c
> @@ -28,7 +28,6 @@ typedef struct VusIscsiLun {
>   typedef struct VusDev {
>       VugDev parent;
>   
> -    int server_sock;
>       VusIscsiLun lun;
>   } VusDev;
>   
> @@ -371,48 +370,30 @@ fail:
>   
>   static void vdev_scsi_free(VusDev *vdev_scsi)

let's kill vdev_scsi_free(),

>   {
> -    if (vdev_scsi->server_sock >= 0) {
> -        close(vdev_scsi->server_sock);
> -    }
>       g_free(vdev_scsi);
>   }
>   
> -static VusDev *vdev_scsi_new(int server_sock)
> +static VusDev *vdev_scsi_new(void)
>   {
> -    VusDev *vdev_scsi;
> -
> -    assert(server_sock >= 0);
> -
> -    vdev_scsi = g_new0(VusDev, 1);
> -    vdev_scsi->server_sock = server_sock;
> -
> -    return vdev_scsi;
> +    return g_new0(VusDev, 1);

also kill vdev_scsi_new() ...

>   }
>   
> -static int vdev_scsi_run(VusDev *vdev_scsi)
> +static int vdev_scsi_run(VusDev *vdev_scsi, int sock)
>   {
>       GMainLoop *loop;
>       GIOChannel *chan;
> -    int cli_sock;
>       int ret = 0;
>   
>       assert(vdev_scsi);
> -    assert(vdev_scsi->server_sock >= 0);
> -
> -    cli_sock = accept(vdev_scsi->server_sock, NULL, NULL);
> -    if (cli_sock < 0) {
> -        perror("accept");
> -        return -1;
> -    }
>   
>       loop = g_main_loop_new(NULL, FALSE);
>       vug_init(&vdev_scsi->parent,
> -             cli_sock,
> +             sock,
>                loop,
>                vus_panic_cb,
>                &vus_iface);
>   
> -    chan = g_io_channel_unix_new(cli_sock);
> +    chan = g_io_channel_unix_new(sock);
>       g_io_add_watch(chan, G_IO_IN, vus_vhost_cb, vdev_scsi);
>       g_main_loop_run(loop);
>       g_io_channel_unref(chan);
> @@ -428,7 +409,7 @@ int main(int argc, char **argv)
>       VusDev *vdev_scsi = NULL;
>       char *unix_fn = NULL;
>       char *iscsi_uri = NULL;
> -    int sock, opt, err = EXIT_SUCCESS;
> +    int lsock = -1, csock = -1, opt, err = EXIT_SUCCESS;
>   
>       while ((opt = getopt(argc, argv, "u:i:")) != -1) {
>           switch (opt) {
> @@ -448,17 +429,24 @@ int main(int argc, char **argv)
>           goto help;
>       }
>   
> -    sock = unix_sock_new(unix_fn);
> -    if (sock < 0) {
> +    lsock = unix_sock_new(unix_fn);
> +    if (lsock < 0) {
> +        goto err;
> +    }
> +
> +    csock = accept(lsock, NULL, NULL);
> +    if (csock < 0) {
> +        perror("accept");
>           goto err;
>       }
> -    vdev_scsi = vdev_scsi_new(sock);
> +
> +    vdev_scsi = vdev_scsi_new();

... and use g_new0() directly:

        vdev_scsi = g_new0(VusDev, 1);

>   
>       if (vus_iscsi_add_lun(&vdev_scsi->lun, iscsi_uri) != 0) {
>           goto err;
>       }
>   
> -    if (vdev_scsi_run(vdev_scsi) != 0) {
> +    if (vdev_scsi_run(vdev_scsi, csock) != 0) {
>           goto err;
>       }
>   
> @@ -467,6 +455,12 @@ out:
>           vdev_scsi_free(vdev_scsi);

and g_free() here:

             g_free(vdev_scsi);

If you agree:
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

>           unlink(unix_fn);
>       }
> +    if (csock >= 0) {
> +        close(csock);
> +    }
> +    if (lsock >= 0) {
> +        close(lsock);
> +    }
>       g_free(unix_fn);
>       g_free(iscsi_uri);
>   
> 
