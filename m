Received: from eggs.gnu.org ([2001:4830:134:3::10]:53481)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <juterry@microsoft.com>) id 1ew7mI-0002fS-L6
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 10:53:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <juterry@microsoft.com>) id 1ew7mE-0001AC-1Z
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 10:53:18 -0400
Received: from mail-co1nam03on0105.outbound.protection.outlook.com
	([104.47.40.105]:27552
	helo=NAM03-CO1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <juterry@microsoft.com>)
	id 1ew7mD-00018f-QE
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 10:53:13 -0400
From: "Justin Terry (VM)" <juterry@microsoft.com>
Date: Wed, 14 Mar 2018 07:52:41 -0700
Message-Id: <1521039163-138-2-git-send-email-juterry@microsoft.com>
In-Reply-To: <1521039163-138-1-git-send-email-juterry@microsoft.com>
References: <1521039163-138-1-git-send-email-juterry@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 1/3] WHPX fix WHvGetCapability out
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
Cc: pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, "Justin Terry (VM)" <juterry@microsoft.com>

This fixes a breaking change to WHvGetCapability to include the 'out'
WrittenSizeInBytes introduced in Windows Insider SDK 17110.

This specifies on return the safe length to read into the WHV_CAPABILITY
structure passed to the call.

Signed-off-by: Justin Terry (VM) <juterry@microsoft.com>
---
 configure              | 4 +++-
 target/i386/whpx-all.c | 3 ++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/configure b/configure
index af72fc852e..1ad153cdfb 100755
--- a/configure
+++ b/configure
@@ -2491,7 +2491,9 @@ if test "$whpx" != "no" ; then
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
index 940bbe590d..2080d58c4c 100644
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
2.13.6
