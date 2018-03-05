Received: from eggs.gnu.org ([2001:4830:134:3::10]:57950)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1esnIp-0003Fy-Jb
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 05:25:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1esnIk-0008Ci-Vv
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 05:25:07 -0500
Received: from mail-oi0-x232.google.com ([2607:f8b0:4003:c06::232]:41687)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1esnIk-0008CK-Pt
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 05:25:02 -0500
Received: by mail-oi0-x232.google.com with SMTP id g5so11625919oiy.8
	for <qemu-devel@nongnu.org>; Mon, 05 Mar 2018 02:25:02 -0800 (PST)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 5 Mar 2018 10:24:41 +0000
Message-ID: <CAFEAcA8Wz4q=+HDpSG_pFHB7xKMez6hCPFodoOxoTgr1FOy5nA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] QEMU fails to configure on non-x86 hosts with recent
 SDL2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>

On non-x86 hosts with SDL2 2.0.8, configure fails:


config-host.mak is out-of-date, running configure

ERROR: configure test passed without -Werror but failed with -Werror.
       This is probably a bug in the configure script. The failing command
       will be at the bottom of config.log.
       You can run configure with --disable-werror to bypass this check.

The relevant configure test is the SDL one:
#include <SDL.h>
#undef main /* We don't want SDL to override our main() */
int main( void ) { return SDL_Init (SDL_INIT_VIDEO); }

and it fails because on non-x86 platforms one of the SDL headers
triggers a -Wundef warning:

cc -Wundef -o zz9.o -I /usr/include/SDL2 -c qemu-conf.c
In file included from /usr/include/SDL2/SDL.h:38:0,
                 from qemu-conf.c:1:
/usr/include/SDL2/SDL_cpuinfo.h:63:5: warning: "HAVE_IMMINTRIN_H" is
not defined, evaluates to 0 [-Wundef]
 #if HAVE_IMMINTRIN_H && !defined(SDL_DISABLE_IMMINTRIN_H)
     ^~~~~~~~~~~~~~~~

I've reported the bug to debian:
https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=892087
(who will probably forward it upstream), but since this version
of SDL is already released, I guess we need to work around it it
QEMU...

Any suggestions for how to do a workaround?

thanks
-- PMM
