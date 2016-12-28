Received: from eggs.gnu.org ([2001:4830:134:3::10]:56928)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cov@codeaurora.org>) id 1cMFc3-0005B8-NJ
	for qemu-devel@nongnu.org; Wed, 28 Dec 2016 09:53:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cov@codeaurora.org>) id 1cMFc1-0006pN-4A
	for qemu-devel@nongnu.org; Wed, 28 Dec 2016 09:53:55 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:58910)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cov@codeaurora.org>) id 1cMFc0-0006pH-P2
	for qemu-devel@nongnu.org; Wed, 28 Dec 2016 09:53:53 -0500
From: Christopher Covington <cov@codeaurora.org>
Date: Wed, 28 Dec 2016 09:53:44 -0500
Message-Id: <20161228145344.30819-1-cov@codeaurora.org>
In-Reply-To: <CAJ+F1CJXGAZa5_+4jD0rP_zX28RCCu3xmF27ZHpgvhnZz686ug@mail.gmail.com>
References: <CAJ+F1CJXGAZa5_+4jD0rP_zX28RCCu3xmF27ZHpgvhnZz686ug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2] build: include sys/sysmacros.h for major()
 and minor()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Christopher Covington <cov@codeaurora.org>

The definition of the major() and minor() macros are moving within glibc =
to
<sys/sysmacros.h>. Include this header to avoid the following sorts of
build-stopping messages:

qga/commands-posix.c: In function =E2=80=98dev_major_minor=E2=80=99:
qga/commands-posix.c:656:13: error: In the GNU C Library, "major" is defi=
ned
 by <sys/sysmacros.h>. For historical compatibility, it is
 currently defined by <sys/types.h> as well, but we plan to
 remove this soon. To use "major", include <sys/sysmacros.h>
 directly. If you did not intend to use a system-defined macro
 "major", you should undefine it after including <sys/types.h>. [-Werror]
         *devmajor =3D major(st.st_rdev);
             ^~~~~~~~~~~~~~~~~~~~~~~~~~

qga/commands-posix.c:657:13: error: In the GNU C Library, "minor" is defi=
ned
 by <sys/sysmacros.h>. For historical compatibility, it is
 currently defined by <sys/types.h> as well, but we plan to
 remove this soon. To use "minor", include <sys/sysmacros.h>
 directly. If you did not intend to use a system-defined macro
 "minor", you should undefine it after including <sys/types.h>. [-Werror]
         *devminor =3D minor(st.st_rdev);
             ^~~~~~~~~~~~~~~~~~~~~~~~~~

The additional include allows the build to complete on Fedora 26 (Rawhide=
)
with glibc version 2.24.90.

Signed-off-by: Christopher Covington <cov@codeaurora.org>
---
 include/sysemu/os-posix.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/sysemu/os-posix.h b/include/sysemu/os-posix.h
index b0a6c0695b..772d58f7ed 100644
--- a/include/sysemu/os-posix.h
+++ b/include/sysemu/os-posix.h
@@ -28,6 +28,7 @@
=20
 #include <sys/mman.h>
 #include <sys/socket.h>
+#include <sys/sysmacros.h>
 #include <netinet/in.h>
 #include <netinet/tcp.h>
 #include <arpa/inet.h>
--=20
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc. Qualcomm Technologies, Inc. is a member of the Code Au=
rora
Forum, a Linux Foundation Collaborative Project.
