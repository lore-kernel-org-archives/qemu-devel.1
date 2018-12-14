Received: from eggs.gnu.org ([2001:4830:134:3::10]:38440)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gXofq-0000Cr-E3
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 09:42:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gXofo-0004V2-E8
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 09:42:42 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:54597)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gXofm-0004Sa-9V
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 09:42:40 -0500
Received: by mail-wm1-x344.google.com with SMTP id a62so5914281wmh.4
	for <qemu-devel@nongnu.org>; Fri, 14 Dec 2018 06:42:38 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id m6sm3263204wrv.24.2018.12.14.06.42.36
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 14 Dec 2018 06:42:36 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 14 Dec 2018 14:42:09 +0000
Message-Id: <20181214144214.1260-18-peter.maydell@linaro.org>
In-Reply-To: <20181214144214.1260-1-peter.maydell@linaro.org>
References: <20181214144214.1260-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 17/22] target/arm: Free name string in
 ARMCPRegInfo hashtable entries
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

When we add a new entry to the ARMCPRegInfo hash table in
add_cpreg_to_hashtable(), we allocate memory for tehe
ARMCPRegInfo struct itself, and we also g_strdup() the
name string. So the hashtable's value destructor function
must free the name string as well as the struct.

Spotted by clang's leak sanitizer. The leak here is a
small one-off leak at startup, because we don't support
CPU hotplug, and so the only time when we destroy
hash table entries is for the case where ARM_CP_OVERRIDE
means we register a wildcard entry and then override it later.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20181204132952.2601-2-peter.maydell@linaro.org
---
 target/arm/cpu.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 60411f6bfe0..b84a6c0e678 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -642,6 +642,20 @@ uint64_t arm_cpu_mp_affinity(int idx, uint8_t clustersz)
     return (Aff1 << ARM_AFF1_SHIFT) | Aff0;
 }
 
+static void cpreg_hashtable_data_destroy(gpointer data)
+{
+    /*
+     * Destroy function for cpu->cp_regs hashtable data entries.
+     * We must free the name string because it was g_strdup()ed in
+     * add_cpreg_to_hashtable(). It's OK to cast away the 'const'
+     * from r->name because we know we definitely allocated it.
+     */
+    ARMCPRegInfo *r = data;
+
+    g_free((void *)r->name);
+    g_free(r);
+}
+
 static void arm_cpu_initfn(Object *obj)
 {
     CPUState *cs = CPU(obj);
@@ -649,7 +663,7 @@ static void arm_cpu_initfn(Object *obj)
 
     cs->env_ptr = &cpu->env;
     cpu->cp_regs = g_hash_table_new_full(g_int_hash, g_int_equal,
-                                         g_free, g_free);
+                                         g_free, cpreg_hashtable_data_destroy);
 
     QLIST_INIT(&cpu->pre_el_change_hooks);
     QLIST_INIT(&cpu->el_change_hooks);
-- 
2.19.2
