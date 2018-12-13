Received: from eggs.gnu.org ([2001:4830:134:3::10]:46574)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gXQEn-000846-UX
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 07:37:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gXQEm-0003GA-R6
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 07:37:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:13485)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gXQEm-0003BD-Hu
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 07:37:08 -0500
Date: Thu, 13 Dec 2018 12:37:03 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181213123703.GH5171@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20181213122511.13853-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181213122511.13853-1-kraxel@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] usb-mtp: use O_NOFOLLOW and O_CLOEXEC.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Bandan Das <bsd@redhat.com>, public@hansmi.ch, Prasad J Pandit <ppandit@redhat.com>

On Thu, Dec 13, 2018 at 01:25:11PM +0100, Gerd Hoffmann wrote:
> Open files and directories with O_NOFOLLOW to avoid symlinks attacks.
> While being at it also add O_CLOEXEC.
> 
> usb-mtp only handles regular files and directories and ignores
> everything else, so users should not see a difference.
> 
> Because qemu ignores symlinks carrying out an successfull symlink attack
> requires swapping an existing file or directory below rootdir for a
> symlink and winning the race against the inotify notification to qemu.
> 
> Note that the impact of this bug is rather low when qemu is managed by
> libvirt due to qemu running sandboxed, so there isn't much you can gain
> access to that way.

It is almost non-existant because libvirt doesn't support the MTP device
at all yet, so no guest will have it unless the user tried CLI
arg passthrough in libvirt :-)

> 
> Fixes: CVE-2018-pjp-please-get-one
> Cc: Prasad J Pandit <ppandit@redhat.com>
> Cc: Bandan Das <bsd@redhat.com>
> Reported-by: Michael Hanselmann <public@hansmi.ch>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  hw/usb/dev-mtp.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
> index 100b7171f4..36c43b8c20 100644
> --- a/hw/usb/dev-mtp.c
> +++ b/hw/usb/dev-mtp.c
> @@ -653,13 +653,18 @@ static void usb_mtp_object_readdir(MTPState *s, MTPObject *o)
>  {
>      struct dirent *entry;
>      DIR *dir;
> +    int fd;
>  
>      if (o->have_children) {
>          return;
>      }
>      o->have_children = true;
>  
> -    dir = opendir(o->path);
> +    fd = open(o->path, O_DIRECTORY | O_CLOEXEC | O_NOFOLLOW);
> +    if (fd < 0) {
> +        return;
> +    }
> +    dir = fdopendir(fd);
>      if (!dir) {
>          return;
>      }
> @@ -1007,7 +1012,7 @@ static MTPData *usb_mtp_get_object(MTPState *s, MTPControl *c,
>  
>      trace_usb_mtp_op_get_object(s->dev.addr, o->handle, o->path);
>  
> -    d->fd = open(o->path, O_RDONLY);
> +    d->fd = open(o->path, O_RDONLY | O_CLOEXEC | O_NOFOLLOW);
>      if (d->fd == -1) {
>          usb_mtp_data_free(d);
>          return NULL;
> @@ -1031,7 +1036,7 @@ static MTPData *usb_mtp_get_partial_object(MTPState *s, MTPControl *c,
>                                          c->argv[1], c->argv[2]);
>  
>      d = usb_mtp_data_alloc(c);
> -    d->fd = open(o->path, O_RDONLY);
> +    d->fd = open(o->path, O_RDONLY | O_CLOEXEC | O_NOFOLLOW);
>      if (d->fd == -1) {
>          usb_mtp_data_free(d);
>          return NULL;
> @@ -1658,7 +1663,7 @@ static void usb_mtp_write_data(MTPState *s)
>                                   0, 0, 0, 0);
>              goto done;
>          }
> -        d->fd = open(path, O_CREAT | O_WRONLY, mask);
> +        d->fd = open(path, O_CREAT | O_WRONLY | O_CLOEXEC | O_NOFOLLOW, mask);
>          if (d->fd == -1) {
>              usb_mtp_queue_result(s, RES_STORE_FULL, d->trans,
>                                   0, 0, 0, 0);
> -- 
> 2.9.3
> 
> 

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
