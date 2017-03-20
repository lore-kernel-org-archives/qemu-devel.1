Received: from eggs.gnu.org ([2001:4830:134:3::10]:59963)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cpw7R-0000AZ-6q
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 08:09:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cpw7Q-0005hl-Ah
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 08:09:01 -0400
Received: from mail-wr0-x235.google.com ([2a00:1450:400c:c0c::235]:33793)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cpw7Q-0005hP-47
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 08:09:00 -0400
Received: by mail-wr0-x235.google.com with SMTP id l37so90921732wrc.1
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 05:09:00 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1490009093-28083-1-git-send-email-kraxel@redhat.com>
References: <1490009093-28083-1-git-send-email-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Mar 2017 12:08:38 +0000
Message-ID: <CAFEAcA_qMwj7s2xNyW4zWBwVjQpeQYmxd33hT2SRY_T+7Zsa9A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
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
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 20 March 2017 at 11:24, Gerd Hoffmann <kraxel@redhat.com> wrote:
> Use "unsigned int" instead of GLenum and GLuint, so we don't depend on
> these types from opengl headers.  Drop all CONFIG_OPENGL #ifdefs from
> console.h
>
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

This isn't sufficient to fix the compile failure on OpenBSD,
because there are still files which #include <epoxy/gl.h> but
which aren't being compiled with OPENGL_CFLAGS:

 hw/lm32/milkymist.c (via milkymist-hw.h)
 ui/sdl2-gl.c
 ui/egl-context.c (via ui/egl-context.h and ui/egl-helpers.h)
 ui/gtk.c (via ui/gtk.h and ui/egl-helpers.h)

just to take the first few I found via grep. (The OpenBSD
build fails on egl-context.o.)

Rather than trying to figure out exactly which .c files need
to have the OPENGL_CFLAGS applied to them, I think it would
be better if we just put them into the standard QEMU_CFLAGS
that we use for building all objects, the same way we do
for other library CFLAGS requirements. Or is there a reason
we can't do that with OpenGL?

thanks
-- PMM
