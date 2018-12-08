Received: from eggs.gnu.org ([2001:4830:134:3::10]:39336)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=8739c4fd6=Alistair.Francis@wdc.com>)
	id 1gVQlk-00083q-Fu
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 19:46:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=8739c4fd6=Alistair.Francis@wdc.com>)
	id 1gVQlg-0000ST-BT
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 19:46:56 -0500
From: Alistair Francis <Alistair.Francis@wdc.com>
Date: Sat, 8 Dec 2018 00:46:48 +0000
Message-ID: <d6c491ecb5c0224c113ddfb2c06552ec89b68227.1544229872.git.alistair.francis@wdc.com>
References: <cover.1544229872.git.alistair.francis@wdc.com>
In-Reply-To: <cover.1544229872.git.alistair.francis@wdc.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [RFC v3 04/24] linux-user: riscv: Fix compile failure
 on riscv32 hosts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>
Cc: Alistair Francis <Alistair.Francis@wdc.com>, "alistair23@gmail.com" <alistair23@gmail.com>, "richard.henderson@linaro.org" <richard.henderson@linaro.org>

When cross compilling for riscv32 hosts using GCC 8.2 this error is seen:
    error: '__NR__llseek' undeclared (first use in this function); did you =
mean '_llseek'?

To avoid the error let's ensure that __NR__llseek is defined.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 linux-user/riscv/target_syscall.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/linux-user/riscv/target_syscall.h b/linux-user/riscv/target_sy=
scall.h
index ee81d8bc88..af73f71839 100644
--- a/linux-user/riscv/target_syscall.h
+++ b/linux-user/riscv/target_syscall.h
@@ -47,6 +47,11 @@ struct target_pt_regs {
 #endif
 #define UNAME_MINIMUM_RELEASE "4.15.0"
=20
+/* This is sometimes needed to compile riscv32 Linux user mode */
+#if !defined(__NR__llseek) && !defined(__NR_lseek)
+#define __NR__llseek __NR3264_lseek
+#endif
+
 #define TARGET_MINSIGSTKSZ 2048
 #define TARGET_MLOCKALL_MCL_CURRENT 1
 #define TARGET_MLOCKALL_MCL_FUTURE  2
--=20
2.19.1
