Received: from eggs.gnu.org ([2001:4830:134:3::10]:59331)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dSK6x-0003fH-T2
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 05:27:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dSK6t-0003G1-Ur
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 05:27:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41990)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dSK6t-0003FT-O9
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 05:27:07 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 67306C04B94A
	for <qemu-devel@nongnu.org>; Tue,  4 Jul 2017 09:27:06 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue,  4 Jul 2017 11:27:04 +0200
Message-Id: <20170704092704.8754-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH] checkpatch: should not use signal except for
 SIG_DFL or SIG_IGN
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Using signal to establish a signal handler is not portable; on
SysV systems, the signal handler would be reset to SIG_DFL after
delivery, while BSD preserves the signal handler.  Daniel Berrange
reported that (to complicate matters further) the signal system call
has SysV behavior, but glibc signal() actually calls the sigaction
system call to provide BSD behavior.

However, using signal() to set a signal's disposition to SIG_DFL
or SIG_IGN is portable and is a relatively common occurrence in
QEMU source code, so allow that.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/checkpatch.pl | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 45027b9281..73efc927a9 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2473,6 +2473,10 @@ sub process {
 		if ($line =~ /\b(strto[^kd].*?)\s*\(/) {
 			ERROR("consider using qemu_$1 in preference to $1\n" . $herecurr);
 		}
+# recommend sigaction over signal for portability, when establishing a handler
+		if ($line =~ /\bsignal\s*\(/ && !($line =~ /SIG_(?:IGN|DFL)/)) {
+			ERROR("use sigaction to establish signal handlers; signal is not portable\n" . $herecurr);
+		}
 # check for module_init(), use category-specific init macros explicitly please
 		if ($line =~ /^module_init\s*\(/) {
 			ERROR("please use block_init(), type_init() etc. instead of module_init()\n" . $herecurr);
-- 
2.13.0
