Received: from eggs.gnu.org ([2001:4830:134:3::10]:57871)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dn6HZ-0004Lw-Sa
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 12:56:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dn6HY-0006Cq-Nd
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 12:56:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40364)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dn6HY-0006Bc-FL
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 12:56:00 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Wed, 30 Aug 2017 18:52:49 +0200
Message-Id: <20170830165252.13421-42-cohuck@redhat.com>
In-Reply-To: <20170830165252.13421-1-cohuck@redhat.com>
References: <20170830165252.13421-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 41/44] s390x/s390-stattrib: Mark the storage
 attribute as not user_creatable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, rth@twiddle.net, agraf@suse.de, thuth@redhat.com, borntraeger@de.ibm.com, david@redhat.com, Cornelia Huck <cohuck@redhat.com>

From: Thomas Huth <thuth@redhat.com>

The storage attribute devices are only meant to be instantiated one
time, internally. They can not be used by the user, so mark them with
user_creatable = false.

Suggested-by: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <1503576029-24264-1-git-send-email-thuth@redhat.com>
Reviewed-by: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
Reviewed-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/s390-stattrib-kvm.c | 4 ++++
 hw/s390x/s390-stattrib.c     | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/hw/s390x/s390-stattrib-kvm.c b/hw/s390x/s390-stattrib-kvm.c
index ed95d13c68..41770a7dec 100644
--- a/hw/s390x/s390-stattrib-kvm.c
+++ b/hw/s390x/s390-stattrib-kvm.c
@@ -164,6 +164,7 @@ static int kvm_s390_stattrib_get_active(S390StAttribState *sa)
 static void kvm_s390_stattrib_class_init(ObjectClass *oc, void *data)
 {
     S390StAttribClass *sac = S390_STATTRIB_CLASS(oc);
+    DeviceClass *dc = DEVICE_CLASS(oc);
 
     sac->get_stattr = kvm_s390_stattrib_get_stattr;
     sac->peek_stattr = kvm_s390_stattrib_peek_stattr;
@@ -172,6 +173,9 @@ static void kvm_s390_stattrib_class_init(ObjectClass *oc, void *data)
     sac->get_dirtycount = kvm_s390_stattrib_get_dirtycount;
     sac->synchronize = kvm_s390_stattrib_synchronize;
     sac->get_active = kvm_s390_stattrib_get_active;
+
+    /* Reason: Can only be instantiated one time (internally) */
+    dc->user_creatable = false;
 }
 
 static const TypeInfo kvm_s390_stattrib_info = {
diff --git a/hw/s390x/s390-stattrib.c b/hw/s390x/s390-stattrib.c
index 14a02711a2..2902f54f11 100644
--- a/hw/s390x/s390-stattrib.c
+++ b/hw/s390x/s390-stattrib.c
@@ -306,6 +306,7 @@ static int qemu_s390_get_active(S390StAttribState *sa)
 static void qemu_s390_stattrib_class_init(ObjectClass *oc, void *data)
 {
     S390StAttribClass *sa_cl = S390_STATTRIB_CLASS(oc);
+    DeviceClass *dc = DEVICE_CLASS(oc);
 
     sa_cl->synchronize = qemu_s390_synchronize_stub;
     sa_cl->get_stattr = qemu_s390_get_stattr_stub;
@@ -314,6 +315,9 @@ static void qemu_s390_stattrib_class_init(ObjectClass *oc, void *data)
     sa_cl->set_migrationmode = qemu_s390_set_migrationmode_stub;
     sa_cl->get_dirtycount = qemu_s390_get_dirtycount_stub;
     sa_cl->get_active = qemu_s390_get_active;
+
+    /* Reason: Can only be instantiated one time (internally) */
+    dc->user_creatable = false;
 }
 
 static const TypeInfo qemu_s390_stattrib_info = {
-- 
2.13.5
