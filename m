Received: from eggs.gnu.org ([2001:4830:134:3::10]:52041)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dVf4p-0002H5-Mw
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 10:26:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dVf4l-0004Uw-MD
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 10:26:47 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:32961)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dVf4l-0004US-Fi
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 10:26:43 -0400
Received: by mail-wr0-f195.google.com with SMTP id n18so1463783wrb.0
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 07:26:43 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 13 Jul 2017 16:24:33 +0200
Message-Id: <1499955874-10954-41-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1499955874-10954-1-git-send-email-pbonzini@redhat.com>
References: <1499955874-10954-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 40/41] vl: fix breakage of -tb-size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Emilio G. Cota" <cota@braap.org>

From: "Emilio G. Cota" <cota@braap.org>

Commit e7b161d573 ("vl: add tcg_enabled() for tcg related code") adds
a check to exit the program when !tcg_enabled() while parsing the -tb-size
flag.

It turns out that when the -tb-size flag is evaluated, tcg_enabled() can
only return 0, since it is set (or not) much later by configure_accelerator().

Fix it by unconditionally exiting if the flag is passed to a QEMU binary
built with !CONFIG_TCG.

Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 vl.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/vl.c b/vl.c
index f7560de..85cdbbf 100644
--- a/vl.c
+++ b/vl.c
@@ -3933,10 +3933,10 @@ int main(int argc, char **argv, char **envp)
                 configure_rtc(opts);
                 break;
             case QEMU_OPTION_tb_size:
-                if (!tcg_enabled()) {
-                    error_report("TCG is disabled");
-                    exit(1);
-                }
+#ifndef CONFIG_TCG
+                error_report("TCG is disabled");
+                exit(1);
+#endif
                 if (qemu_strtoul(optarg, NULL, 0, &tcg_tb_size) < 0) {
                     error_report("Invalid argument to -tb-size");
                     exit(1);
-- 
1.8.3.1
