Received: from eggs.gnu.org ([2001:4830:134:3::10]:40817)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1ecCVb-0003cZ-Vs
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 10:53:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1ecCVb-00034d-4e
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 10:53:44 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:32893)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1ecCVa-00033z-VE
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 10:53:43 -0500
Received: by mail-wm0-x242.google.com with SMTP id x4so3339618wmc.0
	for <qemu-devel@nongnu.org>; Thu, 18 Jan 2018 07:53:42 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1516290116-4366-1-git-send-email-xieyongji@baidu.com>
References: <1516290116-4366-1-git-send-email-xieyongji@baidu.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 18 Jan 2018 16:53:41 +0100
Message-ID: <CAJ+F1CLBR7sgVYPBjgmaa4yU9HkCzgCwm-3fiYj53bFwxLKPfQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] libvhost-user: Fix resource leak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yongji Xie <elohimes@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, QEMU <qemu-devel@nongnu.org>, Maxime Coquelin <maxime.coquelin@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>

Hi

On Thu, Jan 18, 2018 at 4:41 PM, Yongji Xie <elohimes@gmail.com> wrote:
> Free the mmaped memory when we need to mmap new memory
> space on vu_set_mem_table_exec() and vu_set_log_base_exec() to
> avoid memory leak.
>
> Also close the corresponding fd after mmap() on
> vu_set_log_base_exec() to avoid fd leak.
>
> Signed-off-by: Yongji Xie <xieyongji@baidu.com>
> ---
>  contrib/libvhost-user/libvhost-user.c |   14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-use=
r/libvhost-user.c
> index f409bd3..cadced7 100644
> --- a/contrib/libvhost-user/libvhost-user.c
> +++ b/contrib/libvhost-user/libvhost-user.c
> @@ -405,6 +405,15 @@ vu_set_mem_table_exec(VuDev *dev, VhostUserMsg *vmsg=
)
>  {
>      int i;
>      VhostUserMemory *memory =3D &vmsg->payload.memory;
> +
> +    for (i =3D 0; i < dev->nregions; i++) {
> +        VuDevRegion *r =3D &dev->regions[i];
> +        void *m =3D (void *) (uintptr_t) r->mmap_addr;
> +
> +        if (m) {
> +            munmap(m, r->size + r->mmap_offset);
> +        }
> +    }
>      dev->nregions =3D memory->nregions;
>
>      DPRINT("Nregions: %d\n", memory->nregions);
> @@ -470,9 +479,14 @@ vu_set_log_base_exec(VuDev *dev, VhostUserMsg *vmsg)
>
>      rc =3D mmap(0, log_mmap_size, PROT_READ | PROT_WRITE, MAP_SHARED, fd=
,
>                log_mmap_offset);
> +    close(fd);

or call vmsg_close_fds() ?

>      if (rc =3D=3D MAP_FAILED) {
>          perror("log mmap error");
>      }
> +
> +    if (dev->log_table) {
> +        munmap(dev->log_table, dev->log_size);
> +    }
>      dev->log_table =3D rc;
>      dev->log_size =3D log_mmap_size;
>
> --
> 1.7.9.5
>
>


Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


--=20
Marc-Andr=C3=A9 Lureau
