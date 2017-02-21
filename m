Received: from eggs.gnu.org ([2001:4830:134:3::10]:34839)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cgHKU-0003Qj-7W
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 15:46:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cgHKR-0001fV-Cl
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 15:46:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55134)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cgHKR-0001er-48
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 15:46:31 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 21 Feb 2017 21:46:28 +0100
Message-Id: <1487709988-14322-4-git-send-email-armbru@redhat.com>
In-Reply-To: <1487709988-14322-1-git-send-email-armbru@redhat.com>
References: <1487709988-14322-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v2 3/3] i386/cpu: net: Flatten simple union
 GuestPanicInformationType
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, Anton Nefedov <anton.nefedov@virtuozzo.com>, "Denis V . Lunev" <den@openvz.org>

Simple unions are simpler than flat unions in the schema, but more
complicated in C and on the QMP wire: there's extra indirection in C
and extra nesting on the wire, both pointless.  They're best avoided
in new code.  Fix up recent commit d187e08 accordingly.

Cc: Anton Nefedov <anton.nefedov@virtuozzo.com>
Cc: Denis V. Lunev <den@openvz.org>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi-schema.json  | 14 ++++++++++++--
 target/i386/cpu.c | 17 ++++++-----------
 vl.c              | 12 ++++++------
 3 files changed, 24 insertions(+), 19 deletions(-)

diff --git a/qapi-schema.json b/qapi-schema.json
index 5347781..0eef37c 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -5893,14 +5893,24 @@
   'data': [ 'pause', 'poweroff' ] }
 
 ##
+# @GuestPanicInformationType:
+#
+# Since: 2.9
+##
+{ 'enum': 'GuestPanicInformationType',
+  'data': [ 'hyper-v' ] }
+
+##
 # @GuestPanicInformation:
 #
 # Information about a guest panic
 #
 # Since: 2.9
 ##
-{'union': 'GuestPanicInformation',
- 'data': { 'hyper-v': 'GuestPanicInformationHyperV' } }
+{ 'union': 'GuestPanicInformation',
+  'base': { 'type': 'GuestPanicInformationType' },
+  'discriminator': 'type',
+  'data': { 'hyper-v': 'GuestPanicInformationHyperV' } }
 
 ##
 # @GuestPanicInformationHyperV:
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index fd7add2..c3e6b74 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -3502,19 +3502,14 @@ static GuestPanicInformation *x86_cpu_get_crash_info(CPUState *cs)
     GuestPanicInformation *panic_info = NULL;
 
     if (env->features[FEAT_HYPERV_EDX] & HV_X64_GUEST_CRASH_MSR_AVAILABLE) {
-        GuestPanicInformationHyperV *panic_info_hv =
-            g_malloc0(sizeof(GuestPanicInformationHyperV));
         panic_info = g_malloc0(sizeof(GuestPanicInformation));
-
-        panic_info->type = GUEST_PANIC_INFORMATION_KIND_HYPER_V;
-        panic_info->u.hyper_v.data = panic_info_hv;
-
+        panic_info->type = GUEST_PANIC_INFORMATION_TYPE_HYPER_V;
         assert(HV_X64_MSR_CRASH_PARAMS >= 5);
-        panic_info_hv->arg1 = env->msr_hv_crash_params[0];
-        panic_info_hv->arg2 = env->msr_hv_crash_params[1];
-        panic_info_hv->arg3 = env->msr_hv_crash_params[2];
-        panic_info_hv->arg4 = env->msr_hv_crash_params[3];
-        panic_info_hv->arg5 = env->msr_hv_crash_params[4];
+        panic_info->u.hyper_v.arg1 = env->msr_hv_crash_params[0];
+        panic_info->u.hyper_v.arg2 = env->msr_hv_crash_params[1];
+        panic_info->u.hyper_v.arg3 = env->msr_hv_crash_params[2];
+        panic_info->u.hyper_v.arg4 = env->msr_hv_crash_params[3];
+        panic_info->u.hyper_v.arg5 = env->msr_hv_crash_params[4];
     }
 
     return panic_info;
diff --git a/vl.c b/vl.c
index b5d0a19..e307ae0 100644
--- a/vl.c
+++ b/vl.c
@@ -1697,14 +1697,14 @@ void qemu_system_guest_panicked(GuestPanicInformation *info)
     }
 
     if (info) {
-        if (info->type == GUEST_PANIC_INFORMATION_KIND_HYPER_V) {
+        if (info->type == GUEST_PANIC_INFORMATION_TYPE_HYPER_V) {
             qemu_log_mask(LOG_GUEST_ERROR, "HV crash parameters: (%#"PRIx64
                           " %#"PRIx64" %#"PRIx64" %#"PRIx64" %#"PRIx64")\n",
-                          info->u.hyper_v.data->arg1,
-                          info->u.hyper_v.data->arg2,
-                          info->u.hyper_v.data->arg3,
-                          info->u.hyper_v.data->arg4,
-                          info->u.hyper_v.data->arg5);
+                          info->u.hyper_v.arg1,
+                          info->u.hyper_v.arg2,
+                          info->u.hyper_v.arg3,
+                          info->u.hyper_v.arg4,
+                          info->u.hyper_v.arg5);
         }
         qapi_free_GuestPanicInformation(info);
     }
-- 
2.7.4
