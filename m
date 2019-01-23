Received: from eggs.gnu.org ([209.51.188.92]:46247)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gmF3w-00026n-9d
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 04:43:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gmEv9-00036i-L8
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 04:34:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35612)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gmEv9-00034r-0d
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 04:34:07 -0500
Date: Wed, 23 Jan 2019 09:33:54 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190123093354.GB27270@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190122190503.13627-1-philmd@redhat.com>
	<CAFEAcA-iZHdf6DqrNyUS7yEQmV=VNzWgF7HbHrLaZ5C8EL_0dA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA-iZHdf6DqrNyUS7yEQmV=VNzWgF7HbHrLaZ5C8EL_0dA@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] configure: Let SDL support be optional on
 OpenBSD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Brad Smith <brad@comstyle.com>, Gerd Hoffmann <kraxel@redhat.com>, Fam Zheng <fam@euphon.net>

On Tue, Jan 22, 2019 at 07:20:35PM +0000, Peter Maydell wrote:
> On Tue, 22 Jan 2019 at 19:05, Philippe Mathieu-Daud=C3=A9 <philmd@redha=
t.com> wrote:
> >
> > Currently if we try to build QEMU on OpenBSD with SDL disabled, we ge=
t:
> >
> >   $ ./configure --cc=3Dx86_64-unknown-openbsd6.1-gcc-4.9.4 --python=3D=
python2.7 --disable-sdl
> >
> >   ERROR: sdl not found or disabled, can not use sdl audio driver
> >
> > Since SDL is not a requirement for OpenBSD, let it be optional (we re=
move
> > it from $audio_drv_list but it stays available in $audio_possible_dri=
vers).
> > If no audio backends are available, QEMU falls back to the null drive=
r.
>=20
> > --- a/configure
> > +++ b/configure
> > @@ -828,7 +828,7 @@ NetBSD)
> >  OpenBSD)
> >    bsd=3D"yes"
> >    make=3D"${MAKE-gmake}"
> > -  audio_drv_list=3D"sdl"
> > +  audio_drv_list=3D""
> >    audio_possible_drivers=3D"sdl"
> >    HOST_VARIANT_DIR=3D"openbsd"
> >    supported_os=3D"yes"
>=20
> This will mean that configure will by default not enable
> a real audio backend, even if we do have sdl.
>=20
> Looking at the logic, "audio_possible_drivers" is only
> used for printing the help message. The thing that drives
> which audio drivers to test with is "audio_drv_list",
> and the expectation is that you put things on that only
> if it's possible to build with them. (For instance
> we only add 'dsound' for mingw if the dsound.h header is
> present, and so on.)
>=20
> So we need to do one of:
>  (1) only put "sdl" into audio_drv_list if SDL is
>      available (this probably doesn't work as we haven't
>      probed for SDL at the point where we initialize it)
>  (2) have the sdl probe delete "sdl" from audio_drv_list
>      if the probe fails

This one sounds reasonable to me.

>  (3) some more complicated restructuring :-)
>      (eg rather than having audio_drv_list be set to an
>      initial list based on the host OS, just have a full
>      list of drivers, insist that each has a proper probe
>      routine, and use whichever ones we can successfully
>      probe)


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
