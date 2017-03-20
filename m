Received: from eggs.gnu.org ([2001:4830:134:3::10]:36106)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cpxtW-00081p-7I
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 10:02:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cpxtT-00053K-61
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 10:02:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59710)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cpxtS-000529-W0
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 10:02:43 -0400
Message-ID: <1490018556.1513.13.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 20 Mar 2017 15:02:36 +0100
In-Reply-To: <CAFEAcA_qMwj7s2xNyW4zWBwVjQpeQYmxd33hT2SRY_T+7Zsa9A@mail.gmail.com>
References: <1490009093-28083-1-git-send-email-kraxel@redhat.com>
	<CAFEAcA_qMwj7s2xNyW4zWBwVjQpeQYmxd33hT2SRY_T+7Zsa9A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v3] console: drop epoxy/gl.h include
 dependency
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

  Hi,

> This isn't sufficient to fix the compile failure on OpenBSD,
> because there are still files which #include <epoxy/gl.h> but
> which aren't being compiled with OPENGL_CFLAGS:
>=20
>  hw/lm32/milkymist.c (via milkymist-hw.h)
>  ui/sdl2-gl.c
>  ui/egl-context.c (via ui/egl-context.h and ui/egl-helpers.h)
>  ui/gtk.c (via ui/gtk.h and ui/egl-helpers.h)
>=20
> just to take the first few I found via grep. (The OpenBSD
> build fails on egl-context.o.)
>=20
> Rather than trying to figure out exactly which .c files need
> to have the OPENGL_CFLAGS applied to them, I think it would
> be better if we just put them into the standard QEMU_CFLAGS
> that we use for building all objects, the same way we do
> for other library CFLAGS requirements. Or is there a reason
> we can't do that with OpenGL?

I don't want do this for OPENGL_LIBS, so if we modularize UIs some day
only the ui modules with opengl support depend on opengl libs, and I
somehow dislike the asymmetry between OPENGL_LIBS and QEMU_CFLAGS.  But
other than that there are no reasons I'm aware of why this shouldn't
work.  Patch follows in a moment.

cheers,
  Gerd
