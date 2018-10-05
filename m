Received: from eggs.gnu.org ([2001:4830:134:3::10]:56901)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1g8SMA-0006aV-BI
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 11:49:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1g8SM8-0006CU-IZ
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 11:49:34 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:34015)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1g8SM8-00060C-2n
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 11:49:32 -0400
Received: by mail-wr1-x432.google.com with SMTP id z4-v6so14054148wrb.1
	for <qemu-devel@nongnu.org>; Fri, 05 Oct 2018 08:49:14 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri,  5 Oct 2018 16:48:51 +0100
Message-Id: <20181005154910.3099-3-alex.bennee@linaro.org>
In-Reply-To: <20181005154910.3099-1-alex.bennee@linaro.org>
References: <20181005154910.3099-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 02/21] util/log: add
 qemu_dfilter_append_range()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Pavel.Dovgaluk@ispras.ru, vilanova@ac.upc.edu, cota@braap.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

This allows us to add to the dfilter range as we go.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/qemu/log.h | 1 +
 util/log.c         | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/include/qemu/log.h b/include/qemu/log.h
index 8ed932ec24..f915b5bd91 100644
--- a/include/qemu/log.h
+++ b/include/qemu/log.h
@@ -117,6 +117,7 @@ void qemu_log_needs_buffers(void);
 void qemu_set_log_filename(const char *filename, Error **errp);
 void qemu_set_dfilter_ranges(const char *ranges, Error **errp);
 void qemu_reset_dfilter_ranges(void);
+void qemu_append_dfilter_range(Range r, Error **errp);
 bool qemu_log_in_addr_range(uint64_t addr);
 int qemu_str_to_log_mask(const char *str);
 
diff --git a/util/log.c b/util/log.c
index c6c197cbb3..cc79a146d1 100644
--- a/util/log.c
+++ b/util/log.c
@@ -233,6 +233,12 @@ out:
     g_strfreev(ranges);
 }
 
+void qemu_append_dfilter_range(Range r, Error **errp)
+{
+    maybe_allocate_dfilter(1);
+    g_array_append_val(debug_regions, r);
+}
+
 /* fflush() the log file */
 void qemu_log_flush(void)
 {
-- 
2.17.1
