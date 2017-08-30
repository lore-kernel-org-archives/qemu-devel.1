Received: from eggs.gnu.org ([2001:4830:134:3::10]:57220)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dn6GI-0002cT-38
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 12:54:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dn6GH-0005Vq-7O
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 12:54:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59534)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dn6GH-0005Vd-0w
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 12:54:41 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Wed, 30 Aug 2017 18:52:30 +0200
Message-Id: <20170830165252.13421-23-cohuck@redhat.com>
In-Reply-To: <20170830165252.13421-1-cohuck@redhat.com>
References: <20170830165252.13421-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 22/44] s390x/s390-skeys: Mark the storage key
 devices with user_creatable = false
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

QEMU currently aborts if the user tries to create a skey device:

$ s390x-softmmu/qemu-system-s390x -nographic -device s390-skeys-qemu
qemu-system-s390x: hw/s390x/s390-skeys.c:30: s390_get_skeys_device:
 Assertion `ss' failed.
Aborted (core dumped)

The storage key devices are only meant to be instantiated one time,
internally. They can not be used by the user, so mark them with
user_creatable = false.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <1503569328-22197-1-git-send-email-thuth@redhat.com>
Reviewed-by: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
Reviewed-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/s390-skeys-kvm.c | 4 ++++
 hw/s390x/s390-skeys.c     | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/hw/s390x/s390-skeys-kvm.c b/hw/s390x/s390-skeys-kvm.c
index 131da56bbe..dc54ed8b11 100644
--- a/hw/s390x/s390-skeys-kvm.c
+++ b/hw/s390x/s390-skeys-kvm.c
@@ -54,10 +54,14 @@ static int kvm_s390_skeys_set(S390SKeysState *ss, uint64_t start_gfn,
 static void kvm_s390_skeys_class_init(ObjectClass *oc, void *data)
 {
     S390SKeysClass *skeyclass = S390_SKEYS_CLASS(oc);
+    DeviceClass *dc = DEVICE_CLASS(oc);
 
     skeyclass->skeys_enabled = kvm_s390_skeys_enabled;
     skeyclass->get_skeys = kvm_s390_skeys_get;
     skeyclass->set_skeys = kvm_s390_skeys_set;
+
+    /* Reason: Internal device (only one skeys device for the whole memory) */
+    dc->user_creatable = false;
 }
 
 static const TypeInfo kvm_s390_skeys_info = {
diff --git a/hw/s390x/s390-skeys.c b/hw/s390x/s390-skeys.c
index c0de3b0c35..53ad5d38d4 100644
--- a/hw/s390x/s390-skeys.c
+++ b/hw/s390x/s390-skeys.c
@@ -229,10 +229,14 @@ static int qemu_s390_skeys_get(S390SKeysState *ss, uint64_t start_gfn,
 static void qemu_s390_skeys_class_init(ObjectClass *oc, void *data)
 {
     S390SKeysClass *skeyclass = S390_SKEYS_CLASS(oc);
+    DeviceClass *dc = DEVICE_CLASS(oc);
 
     skeyclass->skeys_enabled = qemu_s390_skeys_enabled;
     skeyclass->get_skeys = qemu_s390_skeys_get;
     skeyclass->set_skeys = qemu_s390_skeys_set;
+
+    /* Reason: Internal device (only one skeys device for the whole memory) */
+    dc->user_creatable = false;
 }
 
 static const TypeInfo qemu_s390_skeys_info = {
-- 
2.13.5
