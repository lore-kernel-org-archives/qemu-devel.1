Received: from eggs.gnu.org ([2001:4830:134:3::10]:60921)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cotju-0007Bt-Hx
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 11:24:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cotjt-0006V1-JB
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 11:24:26 -0400
Received: from mail-wr0-x231.google.com ([2a00:1450:400c:c0c::231]:35922)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cotjt-0006Us-Cd
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 11:24:25 -0400
Received: by mail-wr0-x231.google.com with SMTP id u108so54179847wrb.3
	for <qemu-devel@nongnu.org>; Fri, 17 Mar 2017 08:24:25 -0700 (PDT)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 17 Mar 2017 15:24:03 +0000
Message-ID: <CAFEAcA-hKsoJy6_JJU7UJVTDVJwAvO-AusKUBaMYsRvOOwnhLw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Qemu-devel] ui/console.h does #include <epoxy/gl.h> but it is used
 from files which don't build with OPENGL_CFLAGS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Gerd Hoffmann <kraxel@redhat.com>

Our header include/ui/console.h will #include <epoxy/gl.h>.
Unfortunately that header isn't guaranteed to be on the include
path, because configure puts the CFLAGS that ensure it is (ie
the output of pkg-config --cflags epoxy) into OPENGL_CFLAGS, and
we only build certain object files with it. So a file like vl.c
which includes ui/console.h will fail to build if epoxy is present
but not in a directory which ends up on our include path anyway.

In particular on OpenBSD the header is in /usr/include/X11R6/epoxy/gl.h
and so compilation fails.

We should either just make sure we use the OPENGL_CFLAGS
and OPENGL_LIBS more widely, or be more careful about what
console.h is doing.

thanks
-- PMM
