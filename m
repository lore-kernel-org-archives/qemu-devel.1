Received: from eggs.gnu.org ([2001:4830:134:3::10]:36198)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1cMqRQ-0001m3-Kg
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 01:13:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1cMqRP-00039W-Me
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 01:13:24 -0500
Received: from mail-io0-x242.google.com ([2607:f8b0:4001:c06::242]:34160)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1cMqRP-000393-GU
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 01:13:23 -0500
Received: by mail-io0-x242.google.com with SMTP id n85so21146777ioi.1
	for <qemu-devel@nongnu.org>; Thu, 29 Dec 2016 22:13:23 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1767808401.7524716.1483023445359.JavaMail.zimbra@redhat.com>
References: <1483003721-65360-1-git-send-email-liq3ea@gmail.com>
	<1767808401.7524716.1483023445359.JavaMail.zimbra@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Fri, 30 Dec 2016 14:13:22 +0800
Message-ID: <CAKXe6SJXJEG7Rs_ZrykQRMd_-uXiEJu+MuM6JSMynjN9yU1WkQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] virtio-gpu: fix memory leak in resource
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

2016-12-29 22:57 GMT+08:00 Marc-Andr=C3=A9 Lureau <mlureau@redhat.com>:

> Hi
>
> ----- Original Message -----
> > In the resource attach backing function, everytime it will
> > allocate 'res->iov' thus can leading a memory leak. This
> > patch avoid this.
> >
> > Signed-off-by: Li Qiang <liq3ea@gmail.com>
> > ---
> >  hw/display/virtio-gpu.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> > index 5f32e1a..045f296 100644
> > --- a/hw/display/virtio-gpu.c
> > +++ b/hw/display/virtio-gpu.c
> > @@ -705,6 +705,11 @@ virtio_gpu_resource_attach_backing(VirtIOGPU *g,
> >          return;
> >      }
> >
> > +    if (res->iov) {
> > +        cmd->error =3D VIRTIO_GPU_RESP_ERR_UNSPEC;
> > +        return;
> > +    }
> > +
>
> I think I would rather return an error in the library for this case.
>
>
IIUC Do you mean virglrenderer library? There is no related to this library=
.

Thanks.


> >      ret =3D virtio_gpu_create_mapping_iov(&ab, cmd, &res->addrs,
> &res->iov);
> >      if (ret !=3D 0) {
> >          cmd->error =3D VIRTIO_GPU_RESP_ERR_UNSPEC;
> > --
> > 1.8.3.1
> >
> >
>
