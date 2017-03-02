Received: from eggs.gnu.org ([2001:4830:134:3::10]:59618)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cjWnG-0007xD-O1
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 14:53:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cjWnF-0002T2-F9
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 14:53:42 -0500
Received: from mail-wm0-x235.google.com ([2a00:1450:400c:c09::235]:37536)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cjWnF-0002Sh-8O
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 14:53:41 -0500
Received: by mail-wm0-x235.google.com with SMTP id n11so132165wma.0
	for <qemu-devel@nongnu.org>; Thu, 02 Mar 2017 11:53:41 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu,  2 Mar 2017 19:53:29 +0000
Message-Id: <20170302195337.31558-4-alex.bennee@linaro.org>
In-Reply-To: <20170302195337.31558-1-alex.bennee@linaro.org>
References: <20170302195337.31558-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 03/11] cpus.c: add additional error_report
 when !TARGET_SUPPORT_MTTCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, rth@twiddle.net, pbonzini@redhat.com
Cc: qemu-devel@nongnu.org, mttcg@listserver.greensocs.com, fred.konrad@greensocs.com, a.rigo@virtualopensystems.com, cota@braap.org, bobby.prani@gmail.com, nikunj@linux.vnet.ibm.com, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>

While we may fail the memory ordering check later that can be
confusing. So in cases where TARGET_SUPPORT_MTTCG has yet to be
defined we should say so specifically.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <rth@twiddle.net>
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
