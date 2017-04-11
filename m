Received: from eggs.gnu.org ([2001:4830:134:3::10]:45153)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameeh@daynix.com>) id 1cxvHL-0000G8-GE
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 08:52:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameeh@daynix.com>) id 1cxvHI-0005rl-FH
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 08:52:15 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:34292)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sameeh@daynix.com>) id 1cxvHI-0005rJ-6z
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 08:52:12 -0400
Received: by mail-wr0-x241.google.com with SMTP id u18so25040431wrc.1
	for <qemu-devel@nongnu.org>; Tue, 11 Apr 2017 05:52:11 -0700 (PDT)
From: Sameeh Jubran <sameeh@daynix.com>
Date: Tue, 11 Apr 2017 15:52:05 +0300
Message-Id: <20170411125205.23121-1-sameeh@daynix.com>
Subject: [Qemu-devel] [PATCH] qga-win: Enable 'can-offline' field in
 'guest-get-vcpus' reply
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: Yan Vugenfirer <yan@daynix.com>

The QGA schema states:

@can-offline: Whether offlining the VCPU is possible. This member
               is always filled in by the guest agent when the structure
               is returned, and always ignored on input (hence it can be
               omitted then).

Currently 'can-offline' is missing entirely from the reply. This causes
errors in libvirt which is expecting the reply to be compliant with the
schema docs.

BZ#1438735: https://bugzilla.redhat.com/show_bug.cgi?id=1438735

Signed-off-by: Sameeh Jubran <sameeh@daynix.com>
---
 qga/commands-win32.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index 19d72b2..f0d72a0 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -1344,7 +1344,7 @@ GuestLogicalProcessorList *qmp_guest_get_vcpus(Error **errp)
                     vcpu = g_malloc0(sizeof *vcpu);
                     vcpu->logical_id = current++;
                     vcpu->online = true;
-                    vcpu->has_can_offline = false;
+                    vcpu->has_can_offline = true;
 
                     entry = g_malloc0(sizeof *entry);
                     entry->value = vcpu;
-- 
2.9.3
