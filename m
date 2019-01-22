Received: from eggs.gnu.org ([209.51.188.92]:46544)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gm1o9-00004v-E5
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 14:34:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gm1ba-0005dE-U0
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 14:21:03 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:44811)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gm1ba-0005Mr-9r
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 14:21:02 -0500
Received: by mail-ot1-x341.google.com with SMTP id f18so24672636otl.11
	for <qemu-devel@nongnu.org>; Tue, 22 Jan 2019 11:20:46 -0800 (PST)
MIME-Version: 1.0
References: <20190122190503.13627-1-philmd@redhat.com>
In-Reply-To: <20190122190503.13627-1-philmd@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 22 Jan 2019 19:20:35 +0000
Message-ID: <CAFEAcA-iZHdf6DqrNyUS7yEQmV=VNzWgF7HbHrLaZ5C8EL_0dA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "Daniel P . Berrange" <berrange@redhat.com>, Brad Smith <brad@comstyle.com>, Gerd Hoffmann <kraxel@redhat.com>, Fam Zheng <fam@euphon.net>

On Tue, 22 Jan 2019 at 19:05, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
>
> Currently if we try to build QEMU on OpenBSD with SDL disabled, we get:
>
>   $ ./configure --cc=3Dx86_64-unknown-openbsd6.1-gcc-4.9.4 --python=3Dpyt=
hon2.7 --disable-sdl
>
>   ERROR: sdl not found or disabled, can not use sdl audio driver
>
> Since SDL is not a requirement for OpenBSD, let it be optional (we remove
> it from $audio_drv_list but it stays available in $audio_possible_drivers=
).
> If no audio backends are available, QEMU falls back to the null driver.

> --- a/configure
> +++ b/configure
> @@ -828,7 +828,7 @@ NetBSD)
>  OpenBSD)
>    bsd=3D"yes"
>    make=3D"${MAKE-gmake}"
> -  audio_drv_list=3D"sdl"
> +  audio_drv_list=3D""
>    audio_possible_drivers=3D"sdl"
>    HOST_VARIANT_DIR=3D"openbsd"
>    supported_os=3D"yes"

This will mean that configure will by default not enable
a real audio backend, even if we do have sdl.

Looking at the logic, "audio_possible_drivers" is only
used for printing the help message. The thing that drives
which audio drivers to test with is "audio_drv_list",
and the expectation is that you put things on that only
if it's possible to build with them. (For instance
we only add 'dsound' for mingw if the dsound.h header is
present, and so on.)

So we need to do one of:
 (1) only put "sdl" into audio_drv_list if SDL is
     available (this probably doesn't work as we haven't
     probed for SDL at the point where we initialize it)
 (2) have the sdl probe delete "sdl" from audio_drv_list
     if the probe fails
 (3) some more complicated restructuring :-)
     (eg rather than having audio_drv_list be set to an
     initial list based on the host OS, just have a full
     list of drivers, insist that each has a proper probe
     routine, and use whichever ones we can successfully
     probe)

thanks
-- PMM
