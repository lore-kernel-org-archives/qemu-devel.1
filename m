Received: from eggs.gnu.org ([2001:4830:134:3::10]:52039)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gX6MO-0000f5-Es
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 10:23:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gX6MI-0008V7-Qu
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 10:23:38 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:46520)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gX6MG-0008Qh-Us
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 10:23:33 -0500
Received: by mail-wr1-x42a.google.com with SMTP id l9so18047166wrt.13
	for <qemu-devel@nongnu.org>; Wed, 12 Dec 2018 07:23:30 -0800 (PST)
Received: from 640k.lan ([93.56.166.5]) by smtp.gmail.com with ESMTPSA id
	u10sm15878859wrr.33.2018.12.12.07.23.27 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 12 Dec 2018 07:23:28 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 12 Dec 2018 16:22:30 +0100
Message-Id: <1544628195-37728-10-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1544628195-37728-1-git-send-email-pbonzini@redhat.com>
References: <1544628195-37728-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 09/54] memory: avoid unnecessary
 coalesced_io_del operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Store whether the FlatRange has had any coalesced I/O ranges applied,
and if not avoid calling coalesced_io_del.  This is useful in preparation
for the next patch, which will call coalesced_io_del when rendering
memory regions.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 memory.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/memory.c b/memory.c
index 119b6e4..072769a 100644
--- a/memory.c
+++ b/memory.c
@@ -217,6 +217,7 @@ struct FlatRange {
     bool romd_mode;
     bool readonly;
     bool nonvolatile;
+    bool has_coalesced_range;
 };
 
 #define FOR_EACH_FLAT_RANGE(var, view)          \
@@ -650,6 +651,7 @@ static void render_memory_region(FlatView *view,
     fr.romd_mode = mr->romd_mode;
     fr.readonly = readonly;
     fr.nonvolatile = nonvolatile;
+    fr.has_coalesced_range = false;
 
     /* Render the region itself into any gaps left by the current view. */
     for (i = 0; i < view->nr && int128_nz(remain); ++i) {
@@ -852,6 +854,10 @@ static void address_space_update_ioeventfds(AddressSpace *as)
 
 static void flat_range_coalesced_io_del(FlatRange *fr, AddressSpace *as)
 {
+    if (!fr->has_coalesced_range) {
+        return;
+    }
+
     MEMORY_LISTENER_UPDATE_REGION(fr, as, Reverse, coalesced_io_del,
                                   int128_get64(fr->addr.start),
                                   int128_get64(fr->addr.size));
@@ -863,6 +869,11 @@ static void flat_range_coalesced_io_add(FlatRange *fr, AddressSpace *as)
     CoalescedMemoryRange *cmr;
     AddrRange tmp;
 
+    if (QTAILQ_EMPTY(&mr->coalesced)) {
+        return;
+    }
+
+    fr->has_coalesced_range = true;
     QTAILQ_FOREACH(cmr, &mr->coalesced, link) {
         tmp = addrrange_shift(cmr->addr,
                               int128_sub(fr->addr.start,
-- 
1.8.3.1
