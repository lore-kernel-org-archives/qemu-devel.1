Received: from eggs.gnu.org ([2001:4830:134:3::10]:39546)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <duanj@linux.vnet.ibm.com>) id 1cUHxY-0001q5-Qi
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 14:01:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <duanj@linux.vnet.ibm.com>) id 1cUHxU-0007zr-Va
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 14:01:20 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33089
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <duanj@linux.vnet.ibm.com>)
	id 1cUHxU-0007zO-Ph
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 14:01:16 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v0JIwsHU135516
	for <qemu-devel@nongnu.org>; Thu, 19 Jan 2017 14:01:16 -0500
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2830n06w8t-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 19 Jan 2017 14:01:15 -0500
Received: from localhost
	by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <duanj@linux.vnet.ibm.com>;
	Thu, 19 Jan 2017 14:01:15 -0500
From: Jianjun Duan <duanj@linux.vnet.ibm.com>
Date: Thu, 19 Jan 2017 11:00:53 -0800
In-Reply-To: <1484852453-12728-1-git-send-email-duanj@linux.vnet.ibm.com>
References: <1484852453-12728-1-git-send-email-duanj@linux.vnet.ibm.com>
Message-Id: <1484852453-12728-5-git-send-email-duanj@linux.vnet.ibm.com>
Subject: [Qemu-devel] [QEMU PATCH v17 4/4] migration: add error_report
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, duanj@linux.vnet.ibm.com, dmitry@daynix.com, peter.maydell@linaro.org, kraxel@redhat.com, mst@redhat.com, david@gibson.dropbear.id.au, pbonzini@redhat.com, veroniabahaa@gmail.com, quintela@redhat.com, amit.shah@redhat.com, mreitz@redhat.com, kwolf@redhat.com, rth@twiddle.net, aurelien@aurel32.net, leon.alrae@imgtec.com, blauwirbel@gmail.com, mark.cave-ayland@ilande.co.uk, mdroth@linux.vnet.ibm.com, dgilbert@redhat.com

Added error_report where version_ids do not match in vmstate_load_state.

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Signed-off-by: Jianjun Duan <duanj@linux.vnet.ibm.com>
---
 migration/vmstate.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/migration/vmstate.c b/migration/vmstate.c
index 2f9d4ba..8ddd230 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -85,6 +85,9 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
 
     trace_vmstate_load_state(vmsd->name, version_id);
     if (version_id > vmsd->version_id) {
+        error_report("%s: incoming version_id %d is too new "
+                     "for local version_id %d",
+                     vmsd->name, version_id, vmsd->version_id);
         trace_vmstate_load_state_end(vmsd->name, "too new", -EINVAL);
         return -EINVAL;
     }
@@ -95,6 +98,9 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
             trace_vmstate_load_state_end(vmsd->name, "old path", ret);
             return ret;
         }
+        error_report("%s: incoming version_id %d is too old "
+                     "for local minimum version_id  %d",
+                     vmsd->name, version_id, vmsd->minimum_version_id);
         trace_vmstate_load_state_end(vmsd->name, "too old", -EINVAL);
         return -EINVAL;
     }
-- 
1.9.1
