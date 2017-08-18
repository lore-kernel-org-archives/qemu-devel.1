Received: from eggs.gnu.org ([2001:4830:134:3::10]:49417)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1difhe-0002L8-Al
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 07:44:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1difhd-0007M7-DL
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 07:44:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48794)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1difhd-0007Ll-6n
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 07:44:37 -0400
From: David Hildenbrand <david@redhat.com>
Date: Fri, 18 Aug 2017 13:43:48 +0200
Message-Id: <20170818114353.13455-14-david@redhat.com>
In-Reply-To: <20170818114353.13455-1-david@redhat.com>
References: <20170818114353.13455-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 for-2.11 13/18] target/s390x: move
 get_per_in_range() to misc_helper.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: rth@twiddle.net, Aurelien Jarno <aurelien@aurel32.net>, thuth@redhat.com, cohuck@redhat.com, david@redhat.com, borntraeger@de.ibm.com, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

Only used in that file.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/cpu.h         | 11 -----------
 target/s390x/misc_helper.c | 11 +++++++++++
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 9cdce6c..55aab52 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -438,17 +438,6 @@ static inline uint8_t get_per_atmid(CPUS390XState *e=
nv)
            ((env->psw.mask & PSW_ASC_ACCREG)?    (1 << 2) : 0);
 }
=20
-/* Check if an address is within the PER starting address and the PER
-   ending address.  The address range might loop.  */
-static inline bool get_per_in_range(CPUS390XState *env, uint64_t addr)
-{
-    if (env->cregs[10] <=3D env->cregs[11]) {
-        return env->cregs[10] <=3D addr && addr <=3D env->cregs[11];
-    } else {
-        return env->cregs[10] <=3D addr || addr <=3D env->cregs[11];
-    }
-}
-
 S390CPU *cpu_s390x_init(const char *cpu_model);
 S390CPU *s390x_new_cpu(const char *cpu_model, int64_t id, Error **errp);
 S390CPU *cpu_s390x_create(const char *cpu_model, Error **errp);
diff --git a/target/s390x/misc_helper.c b/target/s390x/misc_helper.c
index d23ffcd..ab0c53d 100644
--- a/target/s390x/misc_helper.c
+++ b/target/s390x/misc_helper.c
@@ -451,6 +451,17 @@ void HELPER(per_check_exception)(CPUS390XState *env)
     }
 }
=20
+/* Check if an address is within the PER starting address and the PER
+   ending address.  The address range might loop.  */
+static inline bool get_per_in_range(CPUS390XState *env, uint64_t addr)
+{
+    if (env->cregs[10] <=3D env->cregs[11]) {
+        return env->cregs[10] <=3D addr && addr <=3D env->cregs[11];
+    } else {
+        return env->cregs[10] <=3D addr || addr <=3D env->cregs[11];
+    }
+}
+
 void HELPER(per_branch)(CPUS390XState *env, uint64_t from, uint64_t to)
 {
     if ((env->cregs[9] & PER_CR9_EVENT_BRANCH)) {
--=20
2.9.4
