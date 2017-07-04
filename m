Received: from eggs.gnu.org ([2001:4830:134:3::10]:35645)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dSP7h-0008Dd-Qi
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 10:48:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dSP7g-000167-D1
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 10:48:17 -0400
Received: from mail-wr0-x22c.google.com ([2a00:1450:400c:c0c::22c]:33575)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dSP7g-00015T-6Y
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 10:48:16 -0400
Received: by mail-wr0-x22c.google.com with SMTP id r103so250407626wrb.0
	for <qemu-devel@nongnu.org>; Tue, 04 Jul 2017 07:48:16 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue,  4 Jul 2017 15:48:52 +0100
Message-Id: <20170704144859.17644-5-alex.bennee@linaro.org>
In-Reply-To: <20170704144859.17644-1-alex.bennee@linaro.org>
References: <20170704144859.17644-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RISU PATCH 04/11] README: document record/replay
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 README | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/README b/README
index e0bf5c5..5f16f60 100644
--- a/README
+++ b/README
@@ -107,6 +107,26 @@ mismatch status to its standard output.
 NB that in the register dump the r15 (pc) value will be given
 as an offset from the start of the binary, not an absolute value.
 
+While the master/slave setup works well it is a bit fiddly for running
+regression tests and other sorts of automation. For this reason risu
+supports recording a trace of its execution to a file. For example:
+
+  risu --master FxxV_across_lanes.risu.bin -t FxxV_across_lanes.risu.trace
+
+And then playback with:
+
+  risu FxxV_across_lanes.risu.bin -t FxxV_across_lanes.risu.trace
+
+Ideally it should be built with zlib to compress the trace files which
+would otherwise be huge. If building with zlib proves too tricky you
+can pipe to stdout and an external compression binary using "-t -".
+
+  risu --master FxxV_across_lanes.risu.bin -t - | gzip --best > trace.file
+
+and:
+
+  gunzip -c trace.file | risu -t - FxxV_across_lanes.risu.bin
+
 File format
 -----------
 
@@ -203,10 +223,6 @@ implementation, for example) but only ARM is tested.
  * we don't actually compare FP status flags, simply because
 I'm pretty sure qemu doesn't get them right yet and I'm more
 interested in fixing gross bugs first.
- * there isn't currently any support for a "record and replay
-results" mode. This would allow you to record the correct
-results from the ARM host once and then test a model implementation
-even if you didn't have the corresponding native hardware.
  * You can compile statically to avoid the requirement for the ARM
 chroot for qemu testing but you can no longer use gethostbyname() and need
 to specify your hosts by IP address.
-- 
2.13.0
