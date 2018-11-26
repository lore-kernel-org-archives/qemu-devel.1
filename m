Received: from eggs.gnu.org ([2001:4830:134:3::10]:48810)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1gRIoh-0007qa-12
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 10:28:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1gRIoc-0004ex-14
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 10:28:55 -0500
Received: from mail-eopbgr80137.outbound.protection.outlook.com
	([40.107.8.137]:6126
	helo=EUR04-VI1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1gRIob-0004YN-Er
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 10:28:49 -0500
From: Roman Kagan <rkagan@virtuozzo.com>
Date: Mon, 26 Nov 2018 15:28:44 +0000
Message-ID: <20181126152836.25379-1-rkagan@virtuozzo.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH] hw/hyperv: fix NULL dereference with pure-kvm
 SynIC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Igor Mammedov <imammedo@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

When started in compat configuration of SynIC, e.g.

qemu-system-x86_64 -machine pc-i440fx-2.10,accel=3Dkvm \
 -cpu host,-vmx,hv-relaxed,hv_spinlocks=3D0x1fff,hv-vpindex,hv-synic

or explicitly

qemu-system-x86_64 -enable-kvm -cpu host,hv-synic,x-hv-synic-kvm-only=3Don

QEMU crashes in hyperv_synic_reset() trying to access the non-present
qobject for SynIC.

Add the missing check for NULL.

Reported-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Reported-by: Igor Mammedov <imammedo@redhat.com>
Fixes: 9b4cf107b09d18ac30f46fd1c4de8585ccba030c
Fixes: 4a93722f9c279184e95b1e1ad775c01deec05065
Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
---
 hw/hyperv/hyperv.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/hyperv/hyperv.c b/hw/hyperv/hyperv.c
index a28e7249d8..8758635227 100644
--- a/hw/hyperv/hyperv.c
+++ b/hw/hyperv/hyperv.c
@@ -136,7 +136,11 @@ void hyperv_synic_add(CPUState *cs)
=20
 void hyperv_synic_reset(CPUState *cs)
 {
-    device_reset(DEVICE(get_synic(cs)));
+    SynICState *synic =3D get_synic(cs);
+
+    if (synic) {
+        device_reset(DEVICE(synic));
+    }
 }
=20
 static const TypeInfo synic_type_info =3D {
--=20
2.19.1
