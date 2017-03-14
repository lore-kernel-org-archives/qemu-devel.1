Received: from eggs.gnu.org ([2001:4830:134:3::10]:36858)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cnp9p-0003dL-LZ
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 12:18:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cnp9k-0006iH-3Z
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 12:18:45 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:36138)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cnp9j-0006hR-SS
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 12:18:39 -0400
Received: by mail-wm0-x243.google.com with SMTP id v190so583484wme.3
	for <qemu-devel@nongnu.org>; Tue, 14 Mar 2017 09:18:39 -0700 (PDT)
Received: from 640k.lan (94-39-132-181.adsl-ull.clienti.tiscali.it.
	[94.39.132.181])
	by smtp.gmail.com with ESMTPSA id k195sm408197wmd.7.2017.03.14.09.18.37
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 14 Mar 2017 09:18:38 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 14 Mar 2017 17:18:17 +0100
Message-Id: <1489508300-48184-16-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1489508300-48184-1-git-send-email-pbonzini@redhat.com>
References: <1489508300-48184-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 15/18] main-loop: remove now unnecessary
 optimization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

This optimization is not necessary anymore, because the vCPU now drops
the I/O thread lock even with TCG.  Drop it to simplify the code and
avoid the "I/O thread spun for 1000 iterations" warning.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 vl.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/vl.c b/vl.c
index 1a95500..0b4ed52 100644
--- a/vl.c
+++ b/vl.c
@@ -1888,17 +1888,14 @@ static bool main_loop_should_exit(void)
 
 static void main_loop(void)
 {
-    bool nonblocking;
-    int last_io = 0;
 #ifdef CONFIG_PROFILER
     int64_t ti;
 #endif
     do {
-        nonblocking = tcg_enabled() && last_io > 0;
 #ifdef CONFIG_PROFILER
         ti = profile_getclock();
 #endif
-        last_io = main_loop_wait(nonblocking);
+        main_loop_wait(false);
 #ifdef CONFIG_PROFILER
         dev_time += profile_getclock() - ti;
 #endif
-- 
1.8.3.1
