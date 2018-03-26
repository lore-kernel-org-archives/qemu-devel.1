Received: from eggs.gnu.org ([2001:4830:134:3::10]:57115)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1f0SIx-0006V5-CL
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 09:36:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1f0SIs-0006ru-Nk
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 09:36:55 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:36589)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1f0SIs-0006rX-Ft
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 09:36:50 -0400
Received: by mail-wr0-x242.google.com with SMTP id d10so18956564wrf.3
	for <qemu-devel@nongnu.org>; Mon, 26 Mar 2018 06:36:50 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 26 Mar 2018 15:36:29 +0200
Message-Id: <1522071403-52486-3-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1522071403-52486-1-git-send-email-pbonzini@redhat.com>
References: <1522071403-52486-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 02/16] WHPX fix WHvGetCapability out
 WrittenSizeInBytes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Justin Terry (VM)" <juterry@microsoft.com>

From: "Justin Terry (VM)" <juterry@microsoft.com>

This fixes a breaking change to WHvGetCapability to include the 'out'
WrittenSizeInBytes introduced in Windows Insider SDK 17110.

This specifies on return the safe length to read into the WHV_CAPABILITY
structure passed to the call.

Signed-off-by: Justin Terry (VM) <juterry@microsoft.com>
Message-Id: <1521039163-138-2-git-send-email-juterry@microsoft.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure              | 4 +++-
 target/i386/whpx-all.c | 3 ++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/configure b/configure
index 8376cb1..4d0e92c 100755
--- a/configure
+++ b/configure
@@ -2496,7 +2496,9 @@ if test "$whpx" != "no" ; then
 #include <WinHvEmulation.h>
 int main(void) {
     WHV_CAPABILITY whpx_cap;
-    WHvGetCapability(WHvCapabilityCodeFeatures, &whpx_cap, sizeof(whpx_cap));
+    UINT32 writtenSize;
+    WHvGetCapability(WHvCapabilityCodeFeatures, &whpx_cap, sizeof(whpx_cap),
+                     &writtenSize);
     return 0;
 }
 EOF
diff --git a/target/i386/whpx-all.c b/target/i386/whpx-all.c
index 940bbe5..2080d58 100644
--- a/target/i386/whpx-all.c
+++ b/target/i386/whpx-all.c
@@ -1254,6 +1254,7 @@ static int whpx_accel_init(MachineState *ms)
     int ret;
     HRESULT hr;
     WHV_CAPABILITY whpx_cap;
+    UINT32 whpx_cap_size;
     WHV_PARTITION_PROPERTY prop;
 
     whpx = &whpx_global;
@@ -1262,7 +1263,7 @@ static int whpx_accel_init(MachineState *ms)
     whpx->mem_quota = ms->ram_size;
 
     hr = WHvGetCapability(WHvCapabilityCodeHypervisorPresent, &whpx_cap,
-                          sizeof(whpx_cap));
+                          sizeof(whpx_cap), &whpx_cap_size);
     if (FAILED(hr) || !whpx_cap.HypervisorPresent) {
         error_report("WHPX: No accelerator found, hr=%08lx", hr);
         ret = -ENOSPC;
-- 
1.8.3.1
