Received: from eggs.gnu.org ([2001:4830:134:3::10]:47345)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkrcmar@redhat.com>) id 1eHZTf-0007OX-1q
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 13:10:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkrcmar@redhat.com>) id 1eHZTe-0005sY-2K
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 13:10:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49826)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkrcmar@redhat.com>) id 1eHZTd-0005ru-LH
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 13:10:25 -0500
From: =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Date: Wed, 22 Nov 2017 19:09:08 +0100
Message-Id: <20171122180908.31389-1-rkrcmar@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] kvm: apic: save and restore x2APIC LDR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

QEMU saves only 8 bits of APIC LDR, which means that it does not support
x2APIC.  The correct way of fixing this would be to save and restore the
full 32 bit register, but because x2APIC LDR is a function of x2APIC ID,
we can also compute it and keep the migration format untouched.

KVM always expected the LDR format to follow the xAPIC/x2APIC standard,
but pre 4.1 KVMs used non-standard x2APIC ID in case the OS changed
xAPIC ID before switching to x2APIC, which means that QEMU has to use
the kvm_x2apic_api feature to derive the x2APIC ID.

This bug has also been addressed on the KVM side with patch 5849d75a5c9b
("KVM: lapic: Fixup LDR on load in x2apic").

Reported-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reported-by: Yiqian Wei <yiwei@redhat.com>
Signed-off-by: Radim Kr=C4=8Dm=C3=A1=C5=99 <rkrcmar@redhat.com>
---
 I haven't tested that it actually fixes the bug,
 https://bugzilla.redhat.com/show_bug.cgi?id=3D1502591.
=20
 hw/i386/kvm/apic.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/hw/i386/kvm/apic.c b/hw/i386/kvm/apic.c
index 1df6d26816f9..89df165a04bf 100644
--- a/hw/i386/kvm/apic.c
+++ b/hw/i386/kvm/apic.c
@@ -30,6 +30,13 @@ static inline uint32_t kvm_apic_get_reg(struct kvm_lap=
ic_state *kapic,
     return *((uint32_t *)(kapic->regs + (reg_id << 4)));
 }
=20
+static inline uint32_t kvm_apic_calc_x2apic_ldr(APICCommonState *s)
+{
+    uint32_t id =3D kvm_has_x2apic_api() ? s->initial_apic_id : s->id;
+
+    return ((id >> 4) << 16) | (1 << (id & 0xf));
+}
+
 static void kvm_put_apic_state(APICCommonState *s, struct kvm_lapic_stat=
e *kapic)
 {
     int i;
@@ -41,7 +48,11 @@ static void kvm_put_apic_state(APICCommonState *s, str=
uct kvm_lapic_state *kapic
         kvm_apic_set_reg(kapic, 0x2, s->id << 24);
     }
     kvm_apic_set_reg(kapic, 0x8, s->tpr);
-    kvm_apic_set_reg(kapic, 0xd, s->log_dest << 24);
+    if (s->apicbase & MSR_IA32_APICBASE_EXTD) {
+        kvm_apic_set_reg(kapic, 0xd, kvm_apic_calc_x2apic_ldr(s));
+    } else {
+        kvm_apic_set_reg(kapic, 0xd, s->log_dest << 24);
+    }
     kvm_apic_set_reg(kapic, 0xe, s->dest_mode << 28 | 0x0fffffff);
     kvm_apic_set_reg(kapic, 0xf, s->spurious_vec);
     for (i =3D 0; i < 8; i++) {
@@ -71,7 +82,11 @@ void kvm_get_apic_state(DeviceState *dev, struct kvm_l=
apic_state *kapic)
     }
     s->tpr =3D kvm_apic_get_reg(kapic, 0x8);
     s->arb_id =3D kvm_apic_get_reg(kapic, 0x9);
-    s->log_dest =3D kvm_apic_get_reg(kapic, 0xd) >> 24;
+    if (s->apicbase & MSR_IA32_APICBASE_EXTD) {
+        assert(kvm_apic_get_reg(kapic, 0xd) =3D=3D kvm_apic_calc_x2apic_=
ldr(s));
+    } else {
+        s->log_dest =3D kvm_apic_get_reg(kapic, 0xd) >> 24;
+    }
     s->dest_mode =3D kvm_apic_get_reg(kapic, 0xe) >> 28;
     s->spurious_vec =3D kvm_apic_get_reg(kapic, 0xf);
     for (i =3D 0; i < 8; i++) {
--=20
2.14.2
