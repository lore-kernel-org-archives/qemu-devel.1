Received: from eggs.gnu.org ([2001:4830:134:3::10]:59490)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1g9XW3-0000tE-OO
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 11:32:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1g9XVz-0006yz-MA
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 11:32:15 -0400
From: David Hildenbrand <david@redhat.com>
Date: Mon,  8 Oct 2018 17:32:04 +0200
Message-Id: <20181008153204.18845-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] s390x/tcg: always enable AFP for linux-user
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, David Hildenbrand <david@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

linux-user should always enable AFP, otherwise our emulated binary
might crash once it tries to make use of additional floating-point
registers or instructions.

Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Fixes: db0504154e ("s390x/tcg: check for AFP-register, BFP and DFP data e=
xceptions")
Reported-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/cpu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 8ed4823d6e..18ba7f85a5 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -145,6 +145,11 @@ static void s390_cpu_full_reset(CPUState *s)
     env->cregs[0] =3D CR0_RESET;
     env->cregs[14] =3D CR14_RESET;
=20
+#if defined(CONFIG_USER_ONLY)
+    /* user mode should always be allowed to use the full FPU */
+    env->cregs[0] |=3D CR0_AFP;
+#endif
+
     /* architectured initial value for Breaking-Event-Address register *=
/
     env->gbea =3D 1;
=20
--=20
2.17.1
