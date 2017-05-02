Received: from eggs.gnu.org ([2001:4830:134:3::10]:52473)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d5edp-0001Fz-Mq
	for qemu-devel@nongnu.org; Tue, 02 May 2017 16:43:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d5edm-0001Jk-Jm
	for qemu-devel@nongnu.org; Tue, 02 May 2017 16:43:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48476)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1d5edm-0001JM-DL
	for qemu-devel@nongnu.org; Tue, 02 May 2017 16:43:22 -0400
Date: Tue, 2 May 2017 17:43:18 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170502204318.GF3482@thinpad.lan.raisama.net>
References: <20170502203115.22233-1-ehabkost@redhat.com>
	<20170502203115.22233-5-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170502203115.22233-5-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH] fixup! tests: Add [+-]feature and
 feature=on|off test cases
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

On Tue, May 02, 2017 at 05:31:15PM -0300, Eduardo Habkost wrote:
> Introduce a new CPUFeatureSetting QAPI data type, and use it to support
> feature=force on -cpu.
> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

I will include this in v2 to fix the coding style issues.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 tests/test-x86-cpuid-compat.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/tests/test-x86-cpuid-compat.c b/tests/test-x86-cpuid-compat.c
index 9940f4de1c..02f56ad0e8 100644
--- a/tests/test-x86-cpuid-compat.c
+++ b/tests/test-x86-cpuid-compat.c
@@ -103,16 +103,24 @@ typedef struct FeatureTestArgs {
 } FeatureTestArgs;
 
 /* Get the value for a feature word in a X86CPUFeatureWordInfo list */
-static uint32_t get_feature_word(QList *features, uint32_t eax, uint32_t ecx, const char *reg)
+static uint32_t get_feature_word(QList *features, uint32_t eax, uint32_t ecx,
+                                 const char *reg)
 {
     const QListEntry *e;
 
     for (e = qlist_first(features); e; e = qlist_next(e)) {
         QDict *w = qobject_to_qdict(qlist_entry_obj(e));
-        if (eax == qint_get_int(qobject_to_qint(qdict_get(w, "cpuid-input-eax")))
-            && (!qdict_haskey(w, "cpuid-input-ecx")
-                || ecx == qint_get_int(qobject_to_qint(qdict_get(w, "cpuid-input-ecx"))))
-            && !strcmp(qstring_get_str(qobject_to_qstring(qdict_get(w, "cpuid-register"))), reg)) {
+        const char *rreg =
+            qstring_get_str(qobject_to_qstring(qdict_get(w, "cpuid-register")));
+        uint32_t reax =
+            qint_get_int(qobject_to_qint(qdict_get(w, "cpuid-input-eax")));
+        bool has_ecx = qdict_haskey(w, "cpuid-input-ecx");
+        uint32_t recx = 0;
+
+        if (has_ecx) {
+            recx = qint_get_int(qobject_to_qint(qdict_get(w, "cpuid-input-ecx")));
+        }
+        if (eax == reax && (!has_ecx || ecx == recx) && !strcmp(rreg, reg)) {
             return qint_get_int(qobject_to_qint(qdict_get(w, "features")));
         }
     }
-- 
2.11.0.259.g40922b1

-- 
Eduardo
