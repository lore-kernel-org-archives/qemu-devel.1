Received: from eggs.gnu.org ([2001:4830:134:3::10]:52280)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cijMy-0003eD-84
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 10:07:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cijMx-0002n7-EQ
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 10:07:16 -0500
Received: from mail-wm0-x231.google.com ([2a00:1450:400c:c09::231]:35555)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cijMx-0002mt-8S
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 10:07:15 -0500
Received: by mail-wm0-x231.google.com with SMTP id v186so87825517wmd.0
	for <qemu-devel@nongnu.org>; Tue, 28 Feb 2017 07:07:15 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 28 Feb 2017 15:07:09 +0000
Message-Id: <20170228150709.27453-4-alex.bennee@linaro.org>
In-Reply-To: <20170228150709.27453-1-alex.bennee@linaro.org>
References: <20170228150709.27453-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v1 3/3] cpus.c: add additional error_report
 when !TARGET_SUPPORT_MTTCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: rth@twiddle.net
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, mttcg@listserver.greensocs.com, fred.konrad@greensocs.com, a.rigo@virtualopensystems.com, cota@braap.org, bobby.prani@gmail.com, nikunj@linux.vnet.ibm.com, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>

While we may fail the memory ordering check later that can be
confusing. So in cases where TARGET_SUPPORT_MTTCG has yet to be
defined we should say so specifically.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 cpus.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/cpus.c b/cpus.c
index e9aab9f70f..2459f564ea 100644
--- a/cpus.c
+++ b/cpus.c
@@ -206,6 +206,10 @@ void qemu_tcg_configure(QemuOpts *opts, Error **errp)
             } else if (use_icount) {
                 error_setg(errp, "No MTTCG when icount is enabled");
             } else {
+#ifndef TARGET_SUPPORT_MTTCG
+                error_report("Guest not yet converted to MTTCG - "
+                             "you may get unexpected results");
+#endif
                 if (!check_tcg_memory_orders_compatible()) {
                     error_report("Guest expects a stronger memory ordering "
                                  "than the host provides");
-- 
2.11.0
