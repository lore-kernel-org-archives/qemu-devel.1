Received: from eggs.gnu.org ([2001:4830:134:3::10]:51714)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fpGNe-0005Wj-UY
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 13:11:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fpGNb-0006aw-KW
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 13:11:46 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:39995)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1fpGNb-0006aX-Cu
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 13:11:43 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Mon, 13 Aug 2018 13:11:31 -0400
Message-Id: <20180813171132.21939-3-cota@braap.org>
In-Reply-To: <20180813171132.21939-1-cota@braap.org>
References: <20180813171132.21939-1-cota@braap.org>
Subject: [Qemu-devel] [PATCH 2/3] monitor: show sync profiling info with
 'info sync'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Stefan Weil <sw@weilnetz.de>, Markus Armbruster <armbru@redhat.com>, Peter Xu <peterx@redhat.com>

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 monitor.c            |  7 +++++++
 hmp-commands-info.hx | 16 ++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/monitor.c b/monitor.c
index 77861e96af..66d8d85b97 100644
--- a/monitor.c
+++ b/monitor.c
@@ -1454,6 +1454,13 @@ static void hmp_info_opcount(Monitor *mon, const QDict *qdict)
 }
 #endif
 
+static void hmp_info_sync(Monitor *mon, const QDict *qdict)
+{
+    int64_t max = qdict_get_try_int(qdict, "max", 10);
+
+    qsp_report((FILE *)mon, monitor_fprintf, max);
+}
+
 static void hmp_info_history(Monitor *mon, const QDict *qdict)
 {
     int i;
diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
index 70639f656a..56a3249bad 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -297,6 +297,22 @@ STEXI
 @item info opcount
 @findex info opcount
 Show dynamic compiler opcode counters
+ETEXI
+
+    {
+        .name       = "sync",
+        .args_type  = "max:i?",
+        .params     = "[max]",
+        .help       = "show sync profiling info for "
+	              "up to max entries (default: 10). "
+		      "Entries are sorted by wait time.",
+        .cmd        = hmp_info_sync,
+    },
+
+STEXI
+@item info sync
+@findex sync
+Show sync profiling info.
 ETEXI
 
     {
-- 
2.17.1
