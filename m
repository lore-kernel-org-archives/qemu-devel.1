Received: from eggs.gnu.org ([2001:4830:134:3::10]:51413)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dS4Jl-0000JM-UC
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 12:35:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dS4Jk-0007ca-1J
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 12:35:21 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:36327)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dS4Jj-0007cJ-Qj
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 12:35:19 -0400
Received: by mail-wr0-x243.google.com with SMTP id 77so45152867wrb.3
	for <qemu-devel@nongnu.org>; Mon, 03 Jul 2017 09:35:19 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  3 Jul 2017 18:34:36 +0200
Message-Id: <1499099693-22903-6-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1499099693-22903-1-git-send-email-pbonzini@redhat.com>
References: <1499099693-22903-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 05/22] vl: add tcg_enabled() for tcg related
 code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: rth@twiddle.net, thuth@redhat.com, anthony.xu@intel.com, berrange@redhat.com, a.rigo@virtualopensystems.com, yang.zhong@intel.com

From: Yang Zhong <yang.zhong@intel.com>

Need to disable the tcg related code in the vl.c if the
disable-tcg option is added into ./configure command.

Signed-off-by: Yang Zhong <yang.zhong@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 vl.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/vl.c b/vl.c
index 611ddfe..1ca6e8f 100644
--- a/vl.c
+++ b/vl.c
@@ -3933,6 +3933,10 @@ int main(int argc, char **argv, char **envp)
                 configure_rtc(opts);
                 break;
             case QEMU_OPTION_tb_size:
+                if (!tcg_enabled()) {
+                    error_report("TCG is disabled");
+                    exit(1);
+                }
                 if (qemu_strtoul(optarg, NULL, 0, &tcg_tb_size) < 0) {
                     error_report("Invalid argument to -tb-size");
                     exit(1);
@@ -4481,7 +4485,9 @@ int main(int argc, char **argv, char **envp)
         qemu_opts_del(icount_opts);
     }
 
-    qemu_tcg_configure(accel_opts, &error_fatal);
+    if (tcg_enabled()) {
+        qemu_tcg_configure(accel_opts, &error_fatal);
+    }
 
     if (default_net) {
         QemuOptsList *net = qemu_find_opts("net");
-- 
1.8.3.1
