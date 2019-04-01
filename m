Received: from eggs.gnu.org ([209.51.188.92]:42930)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB478-0003ii-II
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:05:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB476-0004ym-Ad
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:05:06 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59922
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1hB476-0004pz-4S
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:05:04 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x31L4i17163580
	for <qemu-devel@nongnu.org>; Mon, 1 Apr 2019 17:04:53 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2rksx78v4w-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 01 Apr 2019 17:04:48 -0400
Received: from localhost
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 1 Apr 2019 22:03:03 +0100
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon,  1 Apr 2019 15:59:54 -0500
In-Reply-To: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
References: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20190401210011.16009-81-mdroth@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 80/97] linux-user: make pwrite64/pread64(fd,
 NULL, 0, offset) return 0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Laurent Vivier <laurent@vivier.eu>

From: Peter Maydell <peter.maydell@linaro.org>

Linux returns success if pwrite64() or pread64() are called with a
zero length NULL buffer, but QEMU was returning -TARGET_EFAULT.

This is the same bug that we fixed in commit 58cfa6c2e6eb51b23cc9
for the write syscall, and long before that in 38d840e6790c29f59
for the read syscall.

Fixes: https://bugs.launchpad.net/qemu/+bug/1810433

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-Id: <20190108184900.9654-1-peter.maydell@linaro.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
(cherry picked from commit 2bd3f8998e1e7dcd9afc29fab252fb9936f9e956)
*drop functional dep. on 2852aafd9d
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 linux-user/syscall.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 1477509cf2..0859739e9d 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -10910,8 +10910,15 @@ abi_long do_syscall(void *cpu_env, int num, abi_=
long arg1,
             arg4 =3D arg5;
             arg5 =3D arg6;
         }
-        if (!(p =3D lock_user(VERIFY_WRITE, arg2, arg3, 0)))
-            goto efault;
+        if (arg2 =3D=3D 0 && arg3 =3D=3D 0) {
+            /* Special-case NULL buffer and zero length, which should su=
cceed */
+            p =3D 0;
+        } else {
+            p =3D lock_user(VERIFY_WRITE, arg2, arg3, 0);
+            if (!p) {
+                goto efault;
+            }
+        }
         ret =3D get_errno(pread64(arg1, p, arg3, target_offset64(arg4, a=
rg5)));
         unlock_user(p, arg2, ret);
         break;
@@ -10920,8 +10927,15 @@ abi_long do_syscall(void *cpu_env, int num, abi_=
long arg1,
             arg4 =3D arg5;
             arg5 =3D arg6;
         }
-        if (!(p =3D lock_user(VERIFY_READ, arg2, arg3, 1)))
-            goto efault;
+        if (arg2 =3D=3D 0 && arg3 =3D=3D 0) {
+            /* Special-case NULL buffer and zero length, which should su=
cceed */
+            p =3D 0;
+        } else {
+            p =3D lock_user(VERIFY_READ, arg2, arg3, 1);
+            if (!p) {
+                goto efault;
+            }
+        }
         ret =3D get_errno(pwrite64(arg1, p, arg3, target_offset64(arg4, =
arg5)));
         unlock_user(p, arg2, 0);
         break;
--=20
2.17.1
