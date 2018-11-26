Received: from eggs.gnu.org ([2001:4830:134:3::10]:43678)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gRNzA-0002Zi-DK
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 16:00:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gRNz6-00041P-Bb
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 16:00:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39296)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gRNz6-00041F-2M
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 16:00:00 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 26 Nov 2018 18:59:41 -0200
Message-Id: <20181126205941.19021-3-ehabkost@redhat.com>
In-Reply-To: <20181126205941.19021-1-ehabkost@redhat.com>
References: <20181126205941.19021-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 2/2] hw/hyperv: fix NULL dereference with
 pure-kvm SynIC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Roman Kagan <rkagan@virtuozzo.com>, Richard Henderson <rth@twiddle.net>, Marcelo Tosatti <mtosatti@redhat.com>

From: Roman Kagan <rkagan@virtuozzo.com>

When started in compat configuration of SynIC, e.g.

qemu-system-x86_64 -machine pc-i440fx-2.10,accel=3Dkvm \
 -cpu host,-vmx,hv-relaxed,hv_spinlocks=3D0x1fff,hv-vpindex,hv-synic

or explicitly

qemu-system-x86_64 -enable-kvm -cpu host,hv-synic,x-hv-synic-kvm-only=3Do=
n

QEMU crashes in hyperv_synic_reset() trying to access the non-present
qobject for SynIC.

Add the missing check for NULL.

Reported-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Reported-by: Igor Mammedov <imammedo@redhat.com>
Fixes: 9b4cf107b09d18ac30f46fd1c4de8585ccba030c
Fixes: 4a93722f9c279184e95b1e1ad775c01deec05065
Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
Message-Id: <20181126152836.25379-1-rkagan@virtuozzo.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
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
2.18.0.rc1.1.g3f1ff2140
