Received: from eggs.gnu.org ([2001:4830:134:3::10]:40466)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1daRQm-0005Gj-0C
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 14:53:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1daRQk-0006fI-W0
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 14:53:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56722)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1daRQk-0006eb-Pc
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 14:53:10 -0400
Date: Wed, 26 Jul 2017 15:53:05 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170726185305.GG5167@localhost.localdomain>
References: <1501049917-4701-1-git-send-email-wang.yi59@zte.com.cn>
	<1501049917-4701-3-git-send-email-wang.yi59@zte.com.cn>
	<20170726173638.GG20793@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170726173638.GG20793@localhost.localdomain>
Subject: [Qemu-devel] [PATCH] cpu: cpu_by_arch_id() helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yi Wang <wang.yi59@zte.com.cn>
Cc: liu.yunh@zte.com.cn, armbru@redhat.com, qemu-devel@nongnu.org, dgilbert@redhat.com, imammedo@redhat.com, pbonzini@redhat.com, Liu.Jianjun3@zte.com.cn, rth@twiddle.net

The helper can be used for CPU object lookup using the CPU's
arch-specific ID (the one returned by CPUClass::get_arch_id()).

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
[Yi Wang: Added documentation comments]
Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
Signed-off-by: Yun Liu <liu.yunh@zte.com.cn>
[ehabkost: extracted cpu_by_arch_id() to a separate patch]
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
On Wed, Jul 26, 2017 at 02:36:38PM -0300, Eduardo Habkost wrote:
> I suggest sending cpu_by_arch_id() in a separate patch, to let
> maintainers cherry-pick and revert individual patches more
> easily.  But there's no need to send v3 just because of that, I
> can split it while committing.

This is the patch I am queueing for 2.11 on my x86-next branch.

---
 include/qom/cpu.h | 10 ++++++++++
 qom/cpu.c         | 11 ++++++++---
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/include/qom/cpu.h b/include/qom/cpu.h
index 25eefea..b7ac949 100644
--- a/include/qom/cpu.h
+++ b/include/qom/cpu.h
@@ -755,6 +755,16 @@ CPUState *qemu_get_cpu(int index);
 bool cpu_exists(int64_t id);
 
 /**
+ * cpu_by_arch_id:
+ * @id: Guest-exposed CPU ID of the CPU to obtain.
+ *
+ * Get a CPU with matching @id.
+ *
+ * Returns: The CPU or %NULL if there is no matching CPU.
+ */
+CPUState *cpu_by_arch_id(int64_t id);
+
+/**
  * cpu_throttle_set:
  * @new_throttle_pct: Percent of sleep time. Valid range is 1 to 99.
  *
diff --git a/qom/cpu.c b/qom/cpu.c
index 4f38db0..e6210d5 100644
--- a/qom/cpu.c
+++ b/qom/cpu.c
@@ -34,7 +34,7 @@
 
 CPUInterruptHandler cpu_interrupt_handler;
 
-bool cpu_exists(int64_t id)
+CPUState *cpu_by_arch_id(int64_t id)
 {
     CPUState *cpu;
 
@@ -42,10 +42,15 @@ bool cpu_exists(int64_t id)
         CPUClass *cc = CPU_GET_CLASS(cpu);
 
         if (cc->get_arch_id(cpu) == id) {
-            return true;
+            return cpu;
         }
     }
-    return false;
+    return NULL;
+}
+
+bool cpu_exists(int64_t id)
+{
+    return !!cpu_by_arch_id(id);
 }
 
 CPUState *cpu_generic_init(const char *typename, const char *cpu_model)
-- 
2.9.4
