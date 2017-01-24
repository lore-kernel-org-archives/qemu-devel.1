Received: from eggs.gnu.org ([2001:4830:134:3::10]:55336)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cW68D-0001Hq-MW
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 13:47:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cW68D-0006pD-1P
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 13:47:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38925)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cW68C-0006oj-SU
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 13:47:48 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 068B8A3815
	for <qemu-devel@nongnu.org>; Tue, 24 Jan 2017 18:47:49 +0000 (UTC)
Received: from dgilbert-t530.redhat.com (ovpn-116-204.ams2.redhat.com
	[10.36.116.204])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id v0OIlhUr020536
	for <qemu-devel@nongnu.org>; Tue, 24 Jan 2017 13:47:48 -0500
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Tue, 24 Jan 2017 18:47:32 +0000
Message-Id: <20170124184742.1639-6-dgilbert@redhat.com>
In-Reply-To: <20170124184742.1639-1-dgilbert@redhat.com>
References: <20170124184742.1639-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PULL 05/15] migration: add error_report
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Jianjun Duan <duanj@linux.vnet.ibm.com>

Added error_report where version_ids do not match in vmstate_load_state.

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Signed-off-by: Jianjun Duan <duanj@linux.vnet.ibm.com>
Message-Id: <1484852453-12728-5-git-send-email-duanj@linux.vnet.ibm.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
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
