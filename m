Received: from eggs.gnu.org ([2001:4830:134:3::10]:46692)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amit.shah@redhat.com>) id 1cPAy0-0007Pg-Be
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 11:32:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amit.shah@redhat.com>) id 1cPAxz-0002u6-Kb
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 11:32:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50432)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amit.shah@redhat.com>)
	id 1cPAxz-0002tr-Ey
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 11:32:39 -0500
From: Amit Shah <amit.shah@redhat.com>
Date: Thu,  5 Jan 2017 22:02:10 +0530
Message-Id: <1483633930-7103-5-git-send-email-amit.shah@redhat.com>
In-Reply-To: <1483633930-7103-1-git-send-email-amit.shah@redhat.com>
References: <1483633930-7103-1-git-send-email-amit.shah@redhat.com>
Subject: [Qemu-devel] [PULL 4/4] migration: add error_report
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu list <qemu-devel@nongnu.org>, duanj@linux.vnet.ibm.com, Amit Shah <amit.shah@redhat.com>

From: Jianjun Duan <duanj@linux.vnet.ibm.com>

Added error_report where version_ids do not match in vmstate_load_state.

Signed-off-by: Jianjun Duan <duanj@linux.vnet.ibm.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Message-id: 1481224870-18247-5-git-send-email-duanj@linux.vnet.ibm.com
Signed-off-by: Amit Shah <amit.shah@redhat.com>
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
2.9.3
