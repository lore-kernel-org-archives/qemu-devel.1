Received: from eggs.gnu.org ([2001:4830:134:3::10]:52511)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dNhlq-0006Gd-5T
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 11:42:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dNhlp-0002s4-CT
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 11:42:18 -0400
Received: from mail-wr0-x22b.google.com ([2a00:1450:400c:c0c::22b]:34180)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dNhlp-0002rl-69
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 11:42:17 -0400
Received: by mail-wr0-x22b.google.com with SMTP id 77so140153625wrb.1
	for <qemu-devel@nongnu.org>; Wed, 21 Jun 2017 08:42:17 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Wed, 21 Jun 2017 16:42:41 +0100
Message-Id: <20170621154244.28309-8-alex.bennee@linaro.org>
In-Reply-To: <20170621154244.28309-1-alex.bennee@linaro.org>
References: <20170621154244.28309-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RISU PATCH v6 07/10] risu: handle trace through
 stdin/stdout
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Trace files can get quite large so it would be useful to be able to
just capture the trace stream with stdin/stdout for processing in a
pipe line. The sort of case where this is useful is for building
static binaries where zlib support is missing for whatever reason.

It can also be used in testing pipelines.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v6
  - use STDIN/OUT_FILENO instead of fileno(foo)
  - strcmp instead of strncmp
---
 risu.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/risu.c b/risu.c
index 93c274b..476475c 100644
--- a/risu.c
+++ b/risu.c
@@ -312,7 +312,11 @@ int main(int argc, char **argv)
 
     if (ismaster) {
         if (trace) {
-            master_fd = open(trace_fn, O_WRONLY|O_CREAT, S_IRWXU);
+            if (strcmp(trace_fn, "-")==0) {
+                master_fd = STDOUT_FILENO;
+            } else {
+                master_fd = open(trace_fn, O_WRONLY|O_CREAT, S_IRWXU);
+            }
         } else {
             fprintf(stderr, "master port %d\n", port);
             master_fd = master_connect(port);
@@ -320,7 +324,11 @@ int main(int argc, char **argv)
         return master();
     } else {
         if (trace) {
-            apprentice_fd = open(trace_fn, O_RDONLY);
+            if (strcmp(trace_fn, "-")==0) {
+                apprentice_fd = STDIN_FILENO;
+            } else {
+                apprentice_fd = open(trace_fn, O_RDONLY);
+            }
         } else {
             fprintf(stderr, "apprentice host %s port %d\n", hostname, port);
             apprentice_fd = apprentice_connect(hostname, port);
-- 
2.13.0
