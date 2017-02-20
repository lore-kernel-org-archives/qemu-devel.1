Received: from eggs.gnu.org ([2001:4830:134:3::10]:39384)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cfkjA-0003sE-OD
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 04:57:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cfkj6-0005ch-OB
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 04:57:52 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50757)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1cfkj6-0005cP-EN
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 04:57:48 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1K9raHB012531
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 04:57:47 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28ppce77uu-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 04:57:46 -0500
Received: from localhost
	by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Mon, 20 Feb 2017 09:57:42 -0000
From: Cornelia Huck <cornelia.huck@de.ibm.com>
Date: Mon, 20 Feb 2017 10:57:25 +0100
In-Reply-To: <20170220095734.7890-1-cornelia.huck@de.ibm.com>
References: <20170220095734.7890-1-cornelia.huck@de.ibm.com>
Message-Id: <20170220095734.7890-4-cornelia.huck@de.ibm.com>
Subject: [Qemu-devel] [PATCH 03/12] s390x/flic: fail migration on source
 already
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, agraf@suse.de, jfrei@linux.vnet.ibm.com, Cornelia Huck <cornelia.huck@de.ibm.com>

Current code puts a 'FLIC_FAILED' marker into the migration stream
to indicate something went wrong while saving flic state and fails
load if it encounters that marker. VMState's put routine recently
gained the ability to return error codes (but did not wire it up
yet).

In order to be able to reap the benefits of returning an error and
failing migration on the source already once this gets wired up
in core, return an error in addition to storing 'FLIC_FAILED'.

Suggested-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Reviewed-by: Jens Freimann <jfrei@linux.vnet.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 hw/intc/s390_flic_kvm.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/intc/s390_flic_kvm.c b/hw/intc/s390_flic_kvm.c
index e86a84e49a..cc44bc4e1e 100644
--- a/hw/intc/s390_flic_kvm.c
+++ b/hw/intc/s390_flic_kvm.c
@@ -293,6 +293,7 @@ static int kvm_flic_save(QEMUFile *f, void *opaque, size_t size,
     int len = FLIC_SAVE_INITIAL_SIZE;
     void *buf;
     int count;
+    int r = 0;
 
     flic_disable_wait_pfault((struct KVMS390FLICState *) opaque);
 
@@ -303,7 +304,7 @@ static int kvm_flic_save(QEMUFile *f, void *opaque, size_t size,
          * migration state */
         error_report("flic: couldn't allocate memory");
         qemu_put_be64(f, FLIC_FAILED);
-        return 0;
+        return -ENOMEM;
     }
 
     count = __get_all_irqs(flic, &buf, len);
@@ -314,6 +315,7 @@ static int kvm_flic_save(QEMUFile *f, void *opaque, size_t size,
          * target system to fail when attempting to load irqs from the
          * migration state */
         qemu_put_be64(f, FLIC_FAILED);
+        r = count;
     } else {
         qemu_put_be64(f, count);
         qemu_put_buffer(f, (uint8_t *) buf,
@@ -321,7 +323,7 @@ static int kvm_flic_save(QEMUFile *f, void *opaque, size_t size,
     }
     g_free(buf);
 
-    return 0;
+    return r;
 }
 
 /**
-- 
2.11.0
