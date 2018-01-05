Received: from eggs.gnu.org ([2001:4830:134:3::10]:50296)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eXPOk-0006am-PL
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 05:38:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eXPOg-0005Pt-Pn
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 05:38:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40066)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eXPOg-0005PJ-HZ
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 05:38:46 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 78E79743
	for <qemu-devel@nongnu.org>; Fri,  5 Jan 2018 10:38:45 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri,  5 Jan 2018 11:38:43 +0100
Message-Id: <20180105103843.30526-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [qemu-web PATCH] refine spectre blog post
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, quintela@redhat.com

People were confused about the level of protection provided by host kernel
updates (which do not exist yet, but I digress).  They were also asking
whether it will be possible to live migrate from old to new QEMU and get
the fixes.  Clarify both aspects.

Suggested-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Suggested-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 _posts/2018-01-04-spectre.md | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/_posts/2018-01-04-spectre.md b/_posts/2018-01-04-spectre.md
index 1be86d0..5bbc7ed 100644
--- a/_posts/2018-01-04-spectre.md
+++ b/_posts/2018-01-04-spectre.md
@@ -2,6 +2,7 @@
 layout: post
 title:  "QEMU and the Spectre and Meltdown attacks"
 date:   2018-01-04 18:00:00 +0000
+last_modified_at: 2018-01-05 10:30:00 +0000
 author: Paolo Bonzini and Eduardo Habkost
 categories: [meltdown, spectre, security, x86]
 ---
@@ -21,17 +22,19 @@ especially on [CVE-2017-5715](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE
 Fixing or mitigating _Spectre_ in general, and CVE-2017-5715 in particular,
 requires cooperation between the processor and the operating system kernel or
 hypervisor; the processor can be updated through microcode or millicode
-patches to provide the required functionality.  CVE-2017-5715 allows guests
-to read potentially sensitive data from hypervisor memory; however, __patching
-the host kernel is sufficient to block this attack__.
-
-On the other hand, in order to protect the guest kernel from a malicious
-userspace, updates are also needed to the guest kernel and, depending on
-the processor architecture, to QEMU.  Just like on bare-metal, the guest
-kernel will use the new functionality provided by the microcode or millicode
-updates.  When running under a hypervisor, processor emulation is mostly out of
-QEMU's scope, so QEMU's role in the fix is small, but nevertheless important.
-In the case of KVM:
+patches to provide the required functionality.
+
+Among the three vulnerabilities, CVE-2017-5715 is notable because
+it allows guests to read potentially sensitive data from hypervisor
+memory.  Patching the host kernel is sufficient to block attacks from
+guests to the host.  On the other hand, in order to protect the guest
+kernel from a malicious userspace, updates are also needed to the guest
+kernel and, depending on the processor architecture, to QEMU.
+
+Just like on bare-metal, the guest kernel will use the new functionality
+provided by the microcode or millicode updates.  When running under a
+hypervisor, processor emulation is mostly out of QEMU's scope, so QEMU's
+role in the fix is small, but nevertheless important.  In the case of KVM:
 
 * QEMU configures the hypervisor to emulate a specific processor model.
 For x86, QEMU has to be aware of new CPUID bits introduced by the microcode
@@ -49,6 +52,10 @@ host from malicious guests__.  Nevertheless, updates will be posted to the
 qemu-devel mailing list in the next few days, and a 2.11.1 patch release
 will be released with the fix.
 
+Once updates are provided, __live migration will not be enough to protect
+guest kernel from guest userspace__.  Because the virtual CPU has to be
+changed to one with the new CPUID bits, the guest will have to be restarted.
+
 As of today, the QEMU project is not aware of whether similar changes will
 be required for non-x86 processors.  If so, they will also posted to the
 mailing list and backported to recent stable releases.
@@ -58,3 +65,6 @@ Blog](https://security.googleblog.com/2018/01/todays-cpu-vulnerability-what-you-
 and [Google Project
 Zero](https://googleprojectzero.blogspot.it/2018/01/reading-privileged-memory-with-side.html)
 posts on the topic, as well as the [Spectre and Meltdown FAQ](https://meltdownattack.com/#faq).
+
+__5 Jan 2018__: clarified the level of protection provided by the host kernel
+update; added a note on live migration.
-- 
2.14.3
