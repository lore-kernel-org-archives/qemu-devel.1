Received: from eggs.gnu.org ([209.51.188.92]:60913)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hBFe1-00027D-Eg
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 05:23:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hBFNW-0004xJ-OK
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 05:06:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39550)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hBFNW-0004qC-Bt
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 05:06:46 -0400
References: <20190402080215.10747-1-vkuznets@redhat.com>
	<7B2302D0-7277-4C14-9FEA-DDAE70EF005E@oracle.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <461676dd-8a04-3d3e-86c0-76e143fa27b9@redhat.com>
Date: Tue, 2 Apr 2019 11:06:36 +0200
MIME-Version: 1.0
In-Reply-To: <7B2302D0-7277-4C14-9FEA-DDAE70EF005E@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] ioapic: allow buggy guests mishandling
 level-triggered interrupts to make progress
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Liran Alon <liran.alon@oracle.com>, Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>

On 02/04/19 10:23, Liran Alon wrote:
>> +#define SUCCESSIVE_IRQ_MAX_COUNT 10000
>> +
>> +static void ioapic_timer(void *opaque)
> I suggest rename method to something such as =E2=80=9Cdelayed_ioapic_se=
rvice_timer_handler()=E2=80=9D.
>=20

I renamed them to delayed_ioapic_service_{timer,cb} and queued the patch.

>>
>> +            if (((entry & IOAPIC_VECTOR_MASK) !=3D vector) ||
>> +                !(entry & IOAPIC_LVT_REMOTE_IRR)) {
>> +                continue;
>> +            }
>> +
>> +            trace_ioapic_clear_remote_irr(n, vector);
>> +            s->ioredtbl[n] =3D entry & ~IOAPIC_LVT_REMOTE_IRR;
>=20
> remote-irr is only set for level-triggered interrupt.
> Thus, I think in the =E2=80=9Cif=E2=80=9D above you should =E2=80=9Ccon=
tinue;=E2=80=9D in case trigger-mode !=3D IOAPIC_TRIGGER_LEVEL.
> i.e. Replace condition "!(entry & IOAPIC_LVT_REMOTE_IRR)=E2=80=9D with =
=E2=80=9Ctrigger-mode !=3D IOAPIC_TRIGGER_LEVEL=E2=80=9D.
> Then you can also remove the =E2=80=9Cif=E2=80=9D below.

Like this?

@@ -232,19 +232,18 @@ void ioapic_eoi_broadcast(int vector)
         for (n =3D 0; n < IOAPIC_NUM_PINS; n++) {
             entry =3D s->ioredtbl[n];
=20
-            if (((entry & IOAPIC_VECTOR_MASK) !=3D vector) ||
-                !(entry & IOAPIC_LVT_REMOTE_IRR)) {
+            if ((entry & IOAPIC_VECTOR_MASK) !=3D vector ||
+                ((entry >> IOAPIC_LVT_TRIGGER_MODE_SHIFT) & 1) !=3D IOAP=
IC_TRIGGER_LEVEL) {
                 continue;
             }
=20
-            trace_ioapic_clear_remote_irr(n, vector);
-            s->ioredtbl[n] =3D entry & ~IOAPIC_LVT_REMOTE_IRR;
-
-            if (((entry >> IOAPIC_LVT_TRIGGER_MODE_SHIFT) & 1) !=3D
-                IOAPIC_TRIGGER_LEVEL) {
+            if (!(entry & IOAPIC_LVT_REMOTE_IRR)) {
                 continue;
             }
=20
+            trace_ioapic_clear_remote_irr(n, vector);
+            s->ioredtbl[n] =3D entry & ~IOAPIC_LVT_REMOTE_IRR;
+
             if (!(entry & IOAPIC_LVT_MASKED) && (s->irr & (1 << n))) {
                 ++s->irq_eoi[vector];
                 if (s->irq_eoi[vector] >=3D SUCCESSIVE_IRQ_MAX_COUNT) {


Paolo
