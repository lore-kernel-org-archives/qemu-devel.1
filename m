Received: from eggs.gnu.org ([2001:4830:134:3::10]:59590)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <duanj@linux.vnet.ibm.com>) id 1cEkCN-00075u-R2
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 16:56:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <duanj@linux.vnet.ibm.com>) id 1cEkCI-00011F-Vw
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 16:56:23 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48996)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <duanj@linux.vnet.ibm.com>)
	id 1cEkCI-000111-M1
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 16:56:18 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uB7LtBcU042849
	for <qemu-devel@nongnu.org>; Wed, 7 Dec 2016 16:56:17 -0500
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
	by mx0a-001b2d01.pphosted.com with ESMTP id 276reee0we-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 07 Dec 2016 16:56:17 -0500
Received: from localhost
	by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <duanj@linux.vnet.ibm.com>;
	Wed, 7 Dec 2016 16:56:16 -0500
From: Jianjun Duan <duanj@linux.vnet.ibm.com>
Date: Wed,  7 Dec 2016 13:55:54 -0800
In-Reply-To: <1481147754-8976-1-git-send-email-duanj@linux.vnet.ibm.com>
References: <1481147754-8976-1-git-send-email-duanj@linux.vnet.ibm.com>
Message-Id: <1481147754-8976-5-git-send-email-duanj@linux.vnet.ibm.com>
Subject: [Qemu-devel] [QEMU PATCH v15 4/4] migration: add error_report
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
