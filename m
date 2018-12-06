Received: from eggs.gnu.org ([2001:4830:134:3::10]:41754)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1gUsKg-0000Ie-64
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 07:00:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1gUsKa-0005Rl-GP
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 07:00:42 -0500
Received: from mail.ispras.ru ([83.149.199.45]:60156)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1gUsKa-0005QY-4Z
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 07:00:36 -0500
From: Mikhail Abakumov <mikhail.abakumov@ispras.ru>
Date: Thu, 06 Dec 2018 15:00:30 +0300
Message-ID: <154409763050.5432.9603759721356480431.stgit@Misha-PC.lan02.inno>
In-Reply-To: <154409751316.5432.3325938832238028060.stgit@Misha-PC.lan02.inno>
References: <154409751316.5432.3325938832238028060.stgit@Misha-PC.lan02.inno>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v3 20/39] windbg: implement
 windbg_process_manipulate_packet
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: sw@weilnetz.de, lprosek@redhat.com, dovgaluk@ispras.ru, rkagan@virtuozzo.com, pbonzini@redhat.com, den@openvz.org

Signed-off-by: Mikhail Abakumov <mikhail.abakumov@ispras.ru>
Signed-off-by: Pavel Dovgalyuk <dovgaluk@ispras.ru>
---
 include/exec/windbgstub-utils.h |    2 ++
 windbgstub-utils.c              |    7 +++++++
 windbgstub.c                    |   27 +++++++++++++++++++++++++++
 3 files changed, 36 insertions(+)

diff --git a/include/exec/windbgstub-utils.h b/include/exec/windbgstub-utils.h
index 794cb387b0..1c577ddd49 100644
--- a/include/exec/windbgstub-utils.h
+++ b/include/exec/windbgstub-utils.h
@@ -67,6 +67,8 @@ typedef struct PacketData {
 const char *kd_api_name(int id);
 const char *kd_pkt_type_name(int id);
 
+void kd_api_unsupported(CPUState *cs, PacketData *pd);
+
 DBGKD_ANY_WAIT_STATE_CHANGE *kd_state_change_exc(CPUState *cs);
 DBGKD_ANY_WAIT_STATE_CHANGE *kd_state_change_ls(CPUState *cs);
 
diff --git a/windbgstub-utils.c b/windbgstub-utils.c
index 6c5a86f667..1455693975 100644
--- a/windbgstub-utils.c
+++ b/windbgstub-utils.c
@@ -200,6 +200,13 @@ InitedAddr windbg_search_vmaddr(CPUState *cs, target_ulong start,
     return ret;
 }
 
+void kd_api_unsupported(CPUState *cs, PacketData *pd)
+{
+    WINDBG_ERROR("Caught unimplemented api %s", kd_api_name(pd->m64.ApiNumber));
+    pd->m64.ReturnStatus = STATUS_UNSUCCESSFUL;
+    pd->extra_size = 0;
+}
+
 const char *kd_api_name(int id)
 {
     return (id >= DbgKdMinimumManipulate && id < DbgKdMaximumManipulate)
diff --git a/windbgstub.c b/windbgstub.c
index 8cbece40da..6ed93b8ce9 100644
--- a/windbgstub.c
+++ b/windbgstub.c
@@ -136,6 +136,33 @@ static void windbg_vm_stop(void)
 
 static void windbg_process_manipulate_packet(WindbgState *state)
 {
+    CPUState *cs;
+    ParsingContext *ctx = &state->ctx;
+    PacketData *data = &ctx->data;
+
+    data->extra_size = ctx->packet.ByteCount - sizeof(DBGKD_MANIPULATE_STATE64);
+    data->m64.ReturnStatus = STATUS_SUCCESS;
+
+    cs = qemu_get_cpu(data->m64.Processor);
+    if (cs == NULL) {
+        cs = qemu_get_cpu(0);
+    }
+
+    switch (data->m64.ApiNumber) {
+    default:
+        kd_api_unsupported(cs, data);
+        break;
+    }
+
+    if (data->m64.ReturnStatus == STATUS_UNSUCCESSFUL) {
+        WINDBG_ERROR("Caught error at %s", kd_api_name(data->m64.ApiNumber));
+    }
+
+    stl_p(&data->m64.ReturnStatus, data->m64.ReturnStatus);
+
+    windbg_send_data_packet(state, data->buf,
+                            data->extra_size + sizeof(DBGKD_MANIPULATE_STATE64),
+                            ctx->packet.PacketType);
 }
 
 static void windbg_process_data_packet(WindbgState *state)
