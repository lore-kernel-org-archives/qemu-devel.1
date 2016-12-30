Received: from eggs.gnu.org ([2001:4830:134:3::10]:43679)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1cMljX-00084g-II
	for qemu-devel@nongnu.org; Thu, 29 Dec 2016 20:11:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1cMljW-00084a-57
	for qemu-devel@nongnu.org; Thu, 29 Dec 2016 20:11:47 -0500
Received: from mail-io0-x242.google.com ([2607:f8b0:4001:c06::242]:36197)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1cMljV-000848-W1
	for qemu-devel@nongnu.org; Thu, 29 Dec 2016 20:11:46 -0500
Received: by mail-io0-x242.google.com with SMTP id m204so14664155ioe.3
	for <qemu-devel@nongnu.org>; Thu, 29 Dec 2016 17:11:45 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <2074312993.7518572.1483019800774.JavaMail.zimbra@redhat.com>
References: <1482999086-59795-1-git-send-email-liq3ea@gmail.com>
	<2074312993.7518572.1483019800774.JavaMail.zimbra@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Fri, 30 Dec 2016 09:11:44 +0800
Message-ID: <CAKXe6SJJMZRdf3SaEKzR+wSTqAc5tcYzuHD6BfN4t2JKre-29A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] virtio-gpu-3d: fix memory leak in resource
 attach backing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <mlureau@redhat.com>
Cc: kraxel@redhat.com, marcandre lureau <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, Li Qiang <liqiang6-s@360.cn>

2016-12-29 21:56 GMT+08:00 Marc-Andr=C3=A9 Lureau <mlureau@redhat.com>:

> Hi
>
> ----- Original Message -----
> > If the virgl_renderer_resource_attach_iov function fails the
> > 'res_iovs' will be leaked. Add check of the return value to
> > free the 'res_iovs' when failing.
> >
> > Signed-off-by: Li Qiang <liq3ea@gmail.com>
>
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> Interestingly, in vrend_renderer_resource_attach_iov(), if the resource
> has already been attached, it returns 0 too, which will also leak. I gues=
s
> the fix is it return an error in this case.
>
>
Right, actually I have write a patch for this here:

https://cgit.freedesktop.org/virglrenderer/commit/?id=3D40b0e7813325b08077b=
6f541b3989edb2d86d837


But the patch just return 0 if the 'iov' exist.


> > ---
> >  hw/display/virtio-gpu-3d.c | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> >
> > diff --git a/hw/display/virtio-gpu-3d.c b/hw/display/virtio-gpu-3d.c
> > index 23f39de..07b3691 100644
> > --- a/hw/display/virtio-gpu-3d.c
> > +++ b/hw/display/virtio-gpu-3d.c
> > @@ -291,8 +291,11 @@ static void virgl_resource_attach_backing(VirtIOGP=
U
> *g,
> >          return;
> >      }
> >
> > -    virgl_renderer_resource_attach_iov(att_rb.resource_id,
> > -                                       res_iovs, att_rb.nr_entries);
> > +    ret =3D virgl_renderer_resource_attach_iov(att_rb.resource_id,
> > +                                             res_iovs,
> att_rb.nr_entries);
> > +
> > +    if (ret !=3D 0)
> > +        virtio_gpu_cleanup_mapping_iov(res_iovs, att_rb.nr_entries);
>
>
> >  }
> >
> >  static void virgl_resource_detach_backing(VirtIOGPU *g,
> > --
> > 1.8.3.1
> >
> >
>
