Received: from eggs.gnu.org ([2001:4830:134:3::10]:46593)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dSeWn-0004fT-3p
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 03:15:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dSeWm-0007hA-5j
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 03:15:13 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:33153)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dSeWl-0007gm-Vr
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 03:15:12 -0400
Received: by mail-wm0-x244.google.com with SMTP id j85so30447822wmj.0
	for <qemu-devel@nongnu.org>; Wed, 05 Jul 2017 00:15:11 -0700 (PDT)
Received: from 640k.lan (94-39-191-51.adsl-ull.clienti.tiscali.it.
	[94.39.191.51]) by smtp.gmail.com with ESMTPSA id
	y35sm22202793wrc.51.2017.07.05.00.15.09 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 05 Jul 2017 00:15:10 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed,  5 Jul 2017 09:14:21 +0200
Message-Id: <1499238885-26161-19-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1499238885-26161-1-git-send-email-pbonzini@redhat.com>
References: <1499238885-26161-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 18/42] checkpatch: should not use signal except
 for SIG_DFL or SIG_IGN
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

Reviewed-by: Daniel P. Berrange <berrange@redhat.com>
Reviewed-by: Richard W.M. Jones <rjones@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/checkpatch.pl | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 45027b9..73efc92 100755
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
1.8.3.1
