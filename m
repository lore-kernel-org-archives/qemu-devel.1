Received: from eggs.gnu.org ([2001:4830:134:3::10]:45192)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1d39W3-0003EK-QE
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 19:05:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1d39W0-0004RM-M2
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 19:05:03 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39150)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1d39W0-0004Qy-Du
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 19:05:00 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v3PN42Hk009419
	for <qemu-devel@nongnu.org>; Tue, 25 Apr 2017 19:04:59 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2a2ebwjvjp-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 25 Apr 2017 19:04:58 -0400
Received: from localhost
	by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Tue, 25 Apr 2017 19:04:57 -0400
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Tue, 25 Apr 2017 18:04:35 -0500
In-Reply-To: <1493161481-29595-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1493161481-29595-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1493161481-29595-3-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PULL 2/8] qga-win: Enable 'can-offline' field in
 'guest-get-vcpus' reply
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Sameeh Jubran <sameeh@daynix.com>, qemu-stable@nongnu.org

From: Sameeh Jubran <sameeh@daynix.com>

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
Reviewed-by: Eric Blake <eblake@redhat.com>
Cc: qemu-stable@nongnu.org
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 qga/commands-win32.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index 04026ee..9fec1fb 100644
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
2.7.4
