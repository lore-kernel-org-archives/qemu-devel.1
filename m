Received: from eggs.gnu.org ([2001:4830:134:3::10]:57691)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dYH9O-0000pB-MX
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 15:30:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dYH9K-00055a-MJ
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 15:30:18 -0400
Received: from chuckie.co.uk ([82.165.15.123]:59953
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1dYH9K-0004oj-E4
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 15:30:14 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
References: <768886e5-c27a-a6d9-b5f1-b6712c76b7a0@ilande.co.uk>
Message-ID: <7ca287e3-c496-b58f-7df6-e0e82ea56ff0@ilande.co.uk>
Date: Thu, 20 Jul 2017 20:29:50 +0100
MIME-Version: 1.0
In-Reply-To: <768886e5-c27a-a6d9-b5f1-b6712c76b7a0@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] Build failure on git master
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Peter Maydell <peter.maydell@linaro.org>

On 19/07/17 18:09, Mark Cave-Ayland wrote:

> Hi all,
> 
> I see the following build failure here on git master with gcc 4.7.2:
> 
> cc -I/home/build/src/qemu/git/qemu/block -Iblock
> -I/home/build/src/qemu/git/qemu/tcg
> -I/home/build/src/qemu/git/qemu/tcg/i386
> -I/home/build/src/qemu/git/qemu/linux-headers
> -I/home/build/src/qemu/git/qemu/linux-headers -I.
> -I/home/build/src/qemu/git/qemu
> -I/home/build/src/qemu/git/qemu/accel/tcg
> -I/home/build/src/qemu/git/qemu/include -I/usr/include/pixman-1
> -I/home/build/src/qemu/git/qemu/dtc/libfdt -Werror -pthread
> -I/usr/include/glib-2.0 -I/usr/lib/x86_64-linux-gnu/glib-2.0/include
> -m64 -mcx16 -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE
> -Wstrict-prototypes -Wredundant-decls -Wall -Wundef -Wwrite-strings
> -Wmissing-prototypes -fno-strict-aliasing -fno-common -fwrapv
> -Wendif-labels -Wno-missing-include-dirs -Wempty-body -Wnested-externs
> -Wformat-security -Wformat-y2k -Winit-self -Wignored-qualifiers
> -Wold-style-declaration -Wold-style-definition -Wtype-limits
> -fstack-protector-all -I/usr/include/p11-kit-1
> -I/usr/include/libpng12   -I/home/build/src/qemu/git/qemu/tests -MMD -MP
> -MT block/vpc.o -MF block/vpc.d -O2 -U_FORTIFY_SOURCE
> -D_FORTIFY_SOURCE=2 -g   -c -o block/vpc.o block/vpc.c
> block/vpc.c: In function ‘vpc_co_pwritev’:
> block/vpc.c:652:9: error: ‘ret’ may be used uninitialized in this
> function [-Werror=maybe-uninitialized]
> cc1: all warnings being treated as errors
> make: *** [block/vpc.o] Error 1
> 
> At a quick glance it looks as if this is being caused by commit cfc87e00
> "block/vpc.c: Handle write failures in get_image_offset()".

The fix is seemingly quite simple:

diff --git a/block/vpc.c b/block/vpc.c
index 10e6519..574879b 100644
--- a/block/vpc.c
+++ b/block/vpc.c
@@ -649,7 +649,7 @@ vpc_co_pwritev(BlockDriverState *bs, uint64_t
offset, uint64_t bytes,
     int64_t image_offset;
     int64_t n_bytes;
     int64_t bytes_done = 0;
-    int ret;
+    int ret = 0;
     VHDFooter *footer =  (VHDFooter *) s->footer_buf;
     QEMUIOVector local_qiov;


ATB,

Mark.
