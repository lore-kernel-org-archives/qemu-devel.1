Received: from eggs.gnu.org ([2001:4830:134:3::10]:46125)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dWpmZ-0001Ag-8L
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 16:04:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dWpmU-0008GR-Dz
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 16:04:47 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:34963)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dWpmU-0008FI-6g
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 16:04:42 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Sun, 16 Jul 2017 16:03:44 -0400
Message-Id: <1500235468-15341-2-git-send-email-cota@braap.org>
In-Reply-To: <1500235468-15341-1-git-send-email-cota@braap.org>
References: <1500235468-15341-1-git-send-email-cota@braap.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 01/45] vl: fix breakage of -tb-size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>

Commit e7b161d573 ("vl: add tcg_enabled() for tcg related code") adds
a check to exit the program when !tcg_enabled() while parsing the -tb-size
flag.

It turns out that when the -tb-size flag is evaluated, tcg_enabled() can
only return 0, since it is set (or not) much later by configure_accelerator().

Fix it by unconditionally exiting if the flag is passed to a QEMU binary
built with !CONFIG_TCG.

Reviewed-by: Richard Henderson <rth@twiddle.net>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 vl.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/vl.c b/vl.c
index d17c863..9ece570 100644
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
2.7.4
