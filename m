Received: from eggs.gnu.org ([2001:4830:134:3::10]:42335)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cHKBm-0002Ty-NW
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:46:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cHKBj-0001D5-JB
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:46:26 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40851
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cHKBj-0001CQ-Bu
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:46:23 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uBF0hauN083968
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 19:46:22 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0b-001b2d01.pphosted.com with ESMTP id 27bdkv8xyn-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 19:46:22 -0500
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 14 Dec 2016 17:46:21 -0700
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Wed, 14 Dec 2016 18:44:15 -0600
In-Reply-To: <1481762701-4587-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1481762701-4587-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1481762701-4587-22-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 21/67] s390x/css: handle cssid 255 correctly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Cornelia Huck <cornelia.huck@de.ibm.com>

From: Cornelia Huck <cornelia.huck@de.ibm.com>

The cssid 255 is reserved but still valid from an architectural
point of view. However, feeding a bogus schid of 0xffffffff into
the virtio hypercall will lead to a crash:

Stack trace of thread 138363:
        #0  0x00000000100d168c css_find_subch (qemu-system-s390x)
        #1  0x00000000100d3290 virtio_ccw_hcall_notify
        #2  0x00000000100cbf60 s390_virtio_hypercall
        #3  0x000000001010ff7a handle_hypercall
        #4  0x0000000010079ed4 kvm_cpu_exec (qemu-system-s390x)
        #5  0x00000000100609b4 qemu_kvm_cpu_thread_fn
        #6  0x000003ff8b887bb4 start_thread (libpthread.so.0)
        #7  0x000003ff8b78df0a thread_start (libc.so.6)

This is because the css array was only allocated for 0..254
instead of 0..255.

Let's fix this by bumping MAX_CSSID to 255 and fencing off the
reserved cssid of 255 during css image allocation.

Reported-by: Christian Borntraeger <borntraeger@de.ibm.com>
Tested-by: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: qemu-stable@nongnu.org
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
(cherry picked from commit 882b3b97697affb36ca3d174f42f846232008979)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/s390x/css.c         | 8 +++-----
 include/hw/s390x/css.h | 2 +-
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index bb8e4be..b0e81ef 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -141,7 +141,8 @@ out_err:
 int css_create_css_image(uint8_t cssid, bool default_image)
 {
     trace_css_new_image(cssid, default_image ? "(default)" : "");
-    if (cssid > MAX_CSSID) {
+    /* 255 is reserved */
+    if (cssid == 255) {
         return -EINVAL;
     }
     if (channel_subsys.css[cssid]) {
@@ -1267,7 +1268,7 @@ bool css_schid_final(int m, uint8_t cssid, uint8_t ssid, uint16_t schid)
     uint8_t real_cssid;
 
     real_cssid = (!m && (cssid == 0)) ? channel_subsys.default_cssid : cssid;
-    if (real_cssid > MAX_CSSID || ssid > MAX_SSID ||
+    if (ssid > MAX_SSID ||
         !channel_subsys.css[real_cssid] ||
         !channel_subsys.css[real_cssid]->sch_set[ssid]) {
         return true;
@@ -1282,9 +1283,6 @@ static int css_add_virtual_chpid(uint8_t cssid, uint8_t chpid, uint8_t type)
     CssImage *css;
 
     trace_css_chpid_add(cssid, chpid, type);
-    if (cssid > MAX_CSSID) {
-        return -EINVAL;
-    }
     css = channel_subsys.css[cssid];
     if (!css) {
         return -EINVAL;
diff --git a/include/hw/s390x/css.h b/include/hw/s390x/css.h
index 1da63e3..c96c862 100644
--- a/include/hw/s390x/css.h
+++ b/include/hw/s390x/css.h
@@ -20,7 +20,7 @@
 #define MAX_DEVNO 65535
 #define MAX_SCHID 65535
 #define MAX_SSID 3
-#define MAX_CSSID 254 /* 255 is reserved */
+#define MAX_CSSID 255
 #define MAX_CHPID 255
 
 #define MAX_CIWS 62
-- 
1.9.1
