Received: from eggs.gnu.org ([2001:4830:134:3::10]:48887)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1chC5r-000395-KD
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 04:23:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1chC5m-0004Qv-MF
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 04:23:15 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49291
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1chC5m-0004QS-Gs
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 04:23:10 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1O9JH8O146010
	for <qemu-devel@nongnu.org>; Fri, 24 Feb 2017 04:23:09 -0500
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0b-001b2d01.pphosted.com with ESMTP id 28tb3jg3xx-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 24 Feb 2017 04:23:09 -0500
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Fri, 24 Feb 2017 09:23:07 -0000
From: Cornelia Huck <cornelia.huck@de.ibm.com>
Date: Fri, 24 Feb 2017 10:22:49 +0100
In-Reply-To: <20170224092259.16483-1-cornelia.huck@de.ibm.com>
References: <20170224092259.16483-1-cornelia.huck@de.ibm.com>
Message-Id: <20170224092259.16483-4-cornelia.huck@de.ibm.com>
Subject: [Qemu-devel] [PULL 03/13] s390x/flic: fail migration on source
 already
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: borntraeger@de.ibm.com, agraf@suse.de, jfrei@linux.vnet.ibm.com, qemu-devel@nongnu.org, Cornelia Huck <cornelia.huck@de.ibm.com>

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
