Received: from eggs.gnu.org ([2001:4830:134:3::10]:46635)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eDFJQ-0004P9-10
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 14:50:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eDFJM-00046m-5z
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 14:50:00 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:54411)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1eDFJL-00045o-SK
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 14:49:56 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Fri, 10 Nov 2017 20:49:35 +0100
Message-Id: <20171110194935.17541-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH] linux-user,
 s390x: ignore OS ABI value in ELF header
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <huth@tuxfamily.org>, Laurent Vivier <laurent@vivier.eu>

I have this error:
bash: /sbin/ldconfig: cannot execute binary file: Exec format error

because /sbin/ldconfig is:
ELF 64-bit MSB executable, IBM S/390, version 1 (GNU/Linux),
statically linked, for GNU/Linux 3.2.0,
BuildID[sha1]=90b64604014aafac9c1a0623b1cf447281d1a382, stripped

OS ABI is GNU/linux

"/bin/ls" works well:

ELF 64-bit MSB shared object, IBM S/390, version 1 (SYSV), dynamically linked,
interpreter /lib/ld64.so.1, for GNU/Linux 3.2.0,
BuildID[sha1]=be9b19143d4657678846f6e5277383071fc1059a, stripped

OS ABI is SYSV

To be able to execute ldconfig, this patch modifies s390x binfmt mask
to ignore the OS ABI value (EI_OSABI, byte 7).

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 scripts/qemu-binfmt-conf.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/qemu-binfmt-conf.sh b/scripts/qemu-binfmt-conf.sh
index 8afc3eb5bb..e2e1b7544d 100755
--- a/scripts/qemu-binfmt-conf.sh
+++ b/scripts/qemu-binfmt-conf.sh
@@ -85,7 +85,7 @@ sh4eb_mask='\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff
 sh4eb_family=sh4
 
 s390x_magic='\x7fELF\x02\x02\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x16'
-s390x_mask='\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff'
+s390x_mask='\xff\xff\xff\xff\xff\xff\xff\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff'
 s390x_family=s390x
 
 aarch64_magic='\x7fELF\x02\x01\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\xb7\x00'
-- 
2.13.6
