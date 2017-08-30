Received: from eggs.gnu.org ([2001:4830:134:3::10]:57724)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dn6HF-0003uD-AZ
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 12:55:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dn6HE-0005yr-6O
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 12:55:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52090)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dn6HD-0005xg-Va
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 12:55:40 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Wed, 30 Aug 2017 18:52:43 +0200
Message-Id: <20170830165252.13421-36-cohuck@redhat.com>
In-Reply-To: <20170830165252.13421-1-cohuck@redhat.com>
References: <20170830165252.13421-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 35/44] target/s390x: move get_per_in_range() to
 misc_helper.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, rth@twiddle.net, agraf@suse.de, thuth@redhat.com, borntraeger@de.ibm.com, david@redhat.com, Cornelia Huck <cohuck@redhat.com>

From: David Hildenbrand <david@redhat.com>

Only used in that file.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20170818114353.13455-14-david@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/cpu.h         | 11 -----------
 target/s390x/misc_helper.c | 11 +++++++++++
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 9cdce6c6bd..55aab52f84 100644
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
index 34d730ba73..d5497cbcba 100644
--- a/target/s390x/misc_helper.c
+++ b/target/s390x/misc_helper.c
@@ -455,6 +455,17 @@ void HELPER(per_check_exception)(CPUS390XState *env)
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
2.13.5
