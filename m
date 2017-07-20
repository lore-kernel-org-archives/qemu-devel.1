Received: from eggs.gnu.org ([2001:4830:134:3::10]:53802)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <otubo@redhat.com>) id 1dYD15-00051u-7x
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 11:05:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <otubo@redhat.com>) id 1dYD10-000063-5C
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 11:05:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54338)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <otubo@redhat.com>) id 1dYD0z-0008Tf-V3
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 11:05:22 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E1E7B25C26
	for <qemu-devel@nongnu.org>; Thu, 20 Jul 2017 14:57:30 +0000 (UTC)
Received: from vader.redhat.com (ovpn-116-109.ams2.redhat.com [10.36.116.109])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 48D4880A46
	for <qemu-devel@nongnu.org>; Thu, 20 Jul 2017 14:57:30 +0000 (UTC)
From: Eduardo Otubo <otubo@redhat.com>
Date: Thu, 20 Jul 2017 16:57:29 +0200
Message-Id: <20170720145729.22141-1-otubo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] configure: add -Wno-format-truncation to
 QEMU_CFLAGS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Compilation breaks on GCC 7.1.1 20170622 (Fedora 26), thus adding
-Wno-format-truncation to QEMU_CFLAGS on configure script is neecssary.

    hw/usb/bus.c: In function =E2=80=98usb_port_location=E2=80=99:
    hw/usb/bus.c:410:66: error: =E2=80=98%d=E2=80=99 directive output may=
 be truncated writing between 1 and 11 bytes into a region of size betwee=
n 0 and 15 [-Werror=3Dformat-truncation=3D]
             snprintf(downstream->path, sizeof(downstream->path), "%s.%d"=
,
                                                                      ^~
    In file included from /usr/include/stdio.h:939:0,
                     from /home/otubo/develop/qemu/otubo/include/qemu/osd=
ep.h:68,
                     from hw/usb/bus.c:1:
    /usr/include/bits/stdio2.h:64:10: note: =E2=80=98__builtin___snprintf=
_chk=E2=80=99 output between 3 and 28 bytes into a destination of size 16
       return __builtin___snprintf_chk (__s, __n, __USE_FORTIFY_LEVEL - 1=
,
              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~
            __bos (__s), __fmt, __va_arg_pack ());
            ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    cc1: all warnings being treated as errors
    make: *** [/home/otubo/develop/qemu/otubo/rules.mak:66: hw/usb/bus.o]=
 Error 1
    make: *** Waiting for unfinished jobs....

Signed-off-by: Eduardo Otubo <otubo@redhat.com>
---
This warning looks pretty much bogus to me. Since building with -Werror i=
s
essential, we should add this flag to configure. If someone thinks this w=
arning
is not a false positive, feel free to drop this patch.
 configure | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configure b/configure
index befebe27e3..5d5507b3a0 100755
--- a/configure
+++ b/configure
@@ -482,6 +482,7 @@ ARFLAGS=3D"${ARFLAGS-rv}"
 # left shift of signed integers is well defined and has the expected
 # 2s-complement style results. (Both clang and gcc agree that it
 # provides these semantics.)
+QEMU_CFLAGS=3D"-Wno-format-truncation $QEMU_CFLALGS"
 QEMU_CFLAGS=3D"-fno-strict-aliasing -fno-common -fwrapv $QEMU_CFLAGS"
 QEMU_CFLAGS=3D"-Wall -Wundef -Wwrite-strings -Wmissing-prototypes $QEMU_=
CFLAGS"
 QEMU_CFLAGS=3D"-Wstrict-prototypes -Wredundant-decls $QEMU_CFLAGS"
--=20
2.13.3
