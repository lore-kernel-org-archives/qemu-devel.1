Received: from eggs.gnu.org ([209.51.188.92]:40711)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1h3Osy-00084V-Bk
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 13:38:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1h3Ond-0004y4-Vn
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 13:33:18 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:53206)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1h3Ond-0004xF-MS
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 13:33:17 -0400
Received: by mail-wm1-x343.google.com with SMTP id f65so13134wma.2
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 10:33:17 -0700 (PDT)
MIME-Version: 1.0
References: <CAKSw8c6QTBSG6YDr1nLATrQYqybw+eUxEgVyEAQg+z7NqLqoxA@mail.gmail.com>
	<CAJ+F1CLA3q_2Bz+k7MjWC28Z8TuBSX5MSHR6Gd4Vbu+BkGcQaQ@mail.gmail.com>
	<CAKSw8c4y94bOJNO5vMQvCKMgjOhO4m-9ht89BHCbaMVhwU7tgw@mail.gmail.com>
In-Reply-To: <CAKSw8c4y94bOJNO5vMQvCKMgjOhO4m-9ht89BHCbaMVhwU7tgw@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 11 Mar 2019 18:33:04 +0100
Message-ID: <CAJ+F1CLzSD3RV4pC2iNqZWJkDpGtNfN7_aOu2pJPH9663bzZWA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] egl: EGL_MESA_image_dma_buf_export not supported /
 Failed to initialize EGL render node for SPICE GL
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: manish jaggi <mjaggi.dev@gmail.com>
Cc: QEMU <qemu-devel@nongnu.org>, mjaggi@marvell.com, Jayachandran Chandrasekharan Nair <jnair@marvell.com>

Hi

On Fri, Mar 8, 2019 at 7:45 AM manish jaggi <mjaggi.dev@gmail.com> wrote:
>
> On Thu, Mar 7, 2019 at 9:55 PM Marc-Andr=C3=A9 Lureau
> <marcandre.lureau@gmail.com> wrote:
> >
> > Hi
> >
> > On Thu, Mar 7, 2019 at 3:00 PM manish jaggi <mjaggi.dev@gmail.com> wrot=
e:
> > >
> > > Hi List,
> > > I am trying to run qemu with spice gl=3Don with the below command lin=
e
> > > and getting errors.
> > >
> > > qemu-system-x86_64 -cdrom ubuntu-18.04.2-desktop-amd64.iso -hda
> > > u1.qcow2 -enable-kvm -m 1G -cpu host -smp 8 -machine vmport=3Doff -bo=
ot
> > > order=3Ddc -device virtio-vga,virgl=3Don -spice
> > > gl=3Don,unix,addr=3D/home/mjaggi/spice.sock,password=3D1,disable-tick=
eting
> > > -soundhw hda -device virtio-serial -chardev
> > > spicevmc,id=3Dvdagent,debug=3D0,name=3Dvdagent -device
> > > virtserialport,chardev=3Dvdagent,name=3Dcom.redhat.spice.0
> > >
> > > qemu-system-x86_64: egl: EGL_MESA_image_dma_buf_export not supported
> > > qemu-system-x86_64: Failed to initialize EGL render node for SPICE GL
> >
> > It's a limitation of your graphics driver, it doesn't support the
> > required extensions.
> >
> > Which GPU and driver do you have?
> >
> AMD RX560, using mainline 5.0 kernel.
> is  EGL_MESA_image_dma_buf_export  must for spice gl=3Don?

Yes, you may try with spice gl=3Doff and with -display egl-headless.
That should give accelerated host rendering, but with spice 2d
drawings copy.

>
> > thanks
> >
> > >
> > > Qemu configuration
> > > ./configure --enable-sdl --with-sdlabi=3D2.0 --enable-opengl
> > > --enable-virglrenderer --enable-system --enable-modules
> > > --target-list=3Dx86_64-softmmu --enable-kvm  --disable-werror
> > >
> > > ...
> > > OpenGL support    yes
> > > OpenGL dmabufs    yes
> > >
> > > As per configure script
> > >
> > > #include <epoxy/egl.h>
> > > #ifndef EGL_MESA_image_dma_buf_export
> > > # error mesa/epoxy lacks support for dmabufs (mesa 10.6+)
> > > #endif
> > > int main(void) { return 0; }
> > > EOF
> > >   if compile_prog "" "" ; then
> > >     opengl_dmabuf=3Dyes
> > >   fi
> > > fi
> > >
> > > So if OpenGL dmabufs   is yes, should I be getting
> > > EGL_MESA_image_dma_buf_export not supported error ?
> > > What I could be missing here
> > > Need help/guidance.
> > >
> > > -Thanks
> > > Manish
> > >
> >
> >
> > --
> > Marc-Andr=C3=A9 Lureau



--=20
Marc-Andr=C3=A9 Lureau
