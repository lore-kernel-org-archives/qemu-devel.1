Received: from eggs.gnu.org ([209.51.188.92]:45549)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liran.alon@oracle.com>) id 1hBEiL-0005LM-Mw
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 04:24:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liran.alon@oracle.com>) id 1hBEiE-0007M3-Gp
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 04:24:10 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:36378)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liran.alon@oracle.com>)
	id 1hBEi9-00076Q-Mb
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 04:24:02 -0400
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.1 \(3445.4.7\))
From: Liran Alon <liran.alon@oracle.com>
In-Reply-To: <20190402080215.10747-1-vkuznets@redhat.com>
Date: Tue, 2 Apr 2019 11:23:51 +0300
Content-Transfer-Encoding: quoted-printable
Message-Id: <7B2302D0-7277-4C14-9FEA-DDAE70EF005E@oracle.com>
References: <20190402080215.10747-1-vkuznets@redhat.com>
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
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>



> On 2 Apr 2019, at 11:02, Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>=20
> It was found that Hyper-V 2016 on KVM in some configurations (q35 =
machine +
> piix4-usb-uhci) hangs on boot. Root-cause was that one of Hyper-V
> level-triggered interrupt handler performs EOI before fixing the cause =
of
> the interrupt. This results in IOAPIC keep re-raising the =
level-triggered
> interrupt after EOI because irq-line remains asserted.
>=20
> Gory details: =
https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__www.spinics.net_lis=
ts_kvm_msg184484.html&d=3DDwIDAg&c=3DRoP1YumCXCgaWHvlZYR8PZh8Bv7qIrMUB65ea=
pI_JnE&r=3DJk6Q8nNzkQ6LJ6g42qARkg6ryIDGQr-yKXPNGZbpTx0&m=3DGChegdKds--tabG=
xr5GuYEYOixhXJSy1NdM1z1HllzY&s=3D1eaLCEy8KZxs9hcxJGI2MMfmsL0jIRhem8QAeeBge=
hM&e=3D
> (the whole thread).
>=20
> Turns out we were dealing with similar issues before; in-kernel IOAPIC
> implementation has commit 184564efae4d ("kvm: ioapic: conditionally =
delay
> irq delivery duringeoi broadcast") which describes a very similar =
issue.
>=20
> Steal the idea from the above mentioned commit for IOAPIC =
implementation in
> QEMU. SUCCESSIVE_IRQ_MAX_COUNT, delay and the comment are borrowed as =
well.
>=20
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>

I have only small minor refactoring comments inline.
Reviewed-by: Liran Alon <liran.alon@oracle.com>

-Liran

> ---
> Changes since v1:
> - timer_mod() -> timer_mod_anticipate() [Paolo Bonzini]
> - Massaged changelog [Liran Alon]
> - Make implementation look like in-kernel one [Liran Alon]
> ---
> hw/intc/ioapic.c                  | 57 ++++++++++++++++++++++++++++---
> hw/intc/trace-events              |  1 +
> include/hw/i386/ioapic_internal.h |  3 ++
> 3 files changed, 56 insertions(+), 5 deletions(-)
>=20
> diff --git a/hw/intc/ioapic.c b/hw/intc/ioapic.c
> index 9d75f84d3b..9fb8dd3450 100644
> --- a/hw/intc/ioapic.c
> +++ b/hw/intc/ioapic.c
> @@ -139,6 +139,15 @@ static void ioapic_service(IOAPICCommonState *s)
>     }
> }
>=20
> +#define SUCCESSIVE_IRQ_MAX_COUNT 10000
> +
> +static void ioapic_timer(void *opaque)

I suggest rename method to something such as =
=E2=80=9Cdelayed_ioapic_service_timer_handler()=E2=80=9D.

> +{
> +    IOAPICCommonState *s =3D opaque;
> +
> +    ioapic_service(s);
> +}
> +
> static void ioapic_set_irq(void *opaque, int vector, int level)
> {
>     IOAPICCommonState *s =3D opaque;
> @@ -222,13 +231,40 @@ void ioapic_eoi_broadcast(int vector)
>         }
>         for (n =3D 0; n < IOAPIC_NUM_PINS; n++) {
>             entry =3D s->ioredtbl[n];
> -            if ((entry & IOAPIC_LVT_REMOTE_IRR)
> -                && (entry & IOAPIC_VECTOR_MASK) =3D=3D vector) {
> -                trace_ioapic_clear_remote_irr(n, vector);
> -                s->ioredtbl[n] =3D entry & ~IOAPIC_LVT_REMOTE_IRR;
> -                if (!(entry & IOAPIC_LVT_MASKED) && (s->irr & (1 << =
n))) {
> +
> +            if (((entry & IOAPIC_VECTOR_MASK) !=3D vector) ||
> +                !(entry & IOAPIC_LVT_REMOTE_IRR)) {
> +                continue;
> +            }
> +
> +            trace_ioapic_clear_remote_irr(n, vector);
> +            s->ioredtbl[n] =3D entry & ~IOAPIC_LVT_REMOTE_IRR;

remote-irr is only set for level-triggered interrupt.
Thus, I think in the =E2=80=9Cif=E2=80=9D above you should =
=E2=80=9Ccontinue;=E2=80=9D in case trigger-mode !=3D =
IOAPIC_TRIGGER_LEVEL.
i.e. Replace condition "!(entry & IOAPIC_LVT_REMOTE_IRR)=E2=80=9D with =
=E2=80=9Ctrigger-mode !=3D IOAPIC_TRIGGER_LEVEL=E2=80=9D.
Then you can also remove the =E2=80=9Cif=E2=80=9D below.

> +
> +            if (((entry >> IOAPIC_LVT_TRIGGER_MODE_SHIFT) & 1) !=3D
> +                IOAPIC_TRIGGER_LEVEL) {
> +                continue;
> +            }
> +
> +            if (!(entry & IOAPIC_LVT_MASKED) && (s->irr & (1 << n))) =
{
> +                ++s->irq_eoi[vector];
> +                if (s->irq_eoi[vector] >=3D SUCCESSIVE_IRQ_MAX_COUNT) =
{

This can just be =E2=80=9C=3D=3D=E2=80=9C as you should never reach =
beyond SUCCESSIVE_IRQ_MAX_COUNT.
But you can remain with =E2=80=9C>=3D=E2=80=9C if you want to be on the =
safe side?

> +                    /*
> +                     * Real hardware does not deliver the interrupt =
immediately
> +                     * during eoi broadcast, and this lets a buggy =
guest make
> +                     * slow progress even if it does not correctly =
handle a
> +                     * level-triggered interrupt. Emulate this =
behavior if we
> +                     * detect an interrupt storm.
> +                     */
> +                    s->irq_eoi[vector] =3D 0;
> +                    timer_mod_anticipate(s->timer,
> +                                         =
qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
> +                                         NANOSECONDS_PER_SECOND / =
100);
> +                    trace_ioapic_eoi_delayed_reassert(vector);
> +                } else {
>                     ioapic_service(s);
>                 }
> +            } else {
> +                s->irq_eoi[vector] =3D 0;
>             }
>         }
>     }
> @@ -401,6 +437,8 @@ static void ioapic_realize(DeviceState *dev, Error =
**errp)
>     memory_region_init_io(&s->io_memory, OBJECT(s), &ioapic_io_ops, s,
>                           "ioapic", 0x1000);
>=20
> +    s->timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL, ioapic_timer, s);
> +
>     qdev_init_gpio_in(dev, ioapic_set_irq, IOAPIC_NUM_PINS);
>=20
>     ioapics[ioapic_no] =3D s;
> @@ -408,6 +446,14 @@ static void ioapic_realize(DeviceState *dev, =
Error **errp)
>     qemu_add_machine_init_done_notifier(&s->machine_done);
> }
>=20
> +static void ioapic_unrealize(DeviceState *dev, Error **errp)
> +{
> +    IOAPICCommonState *s =3D IOAPIC_COMMON(dev);
> +
> +    timer_del(s->timer);
> +    timer_free(s->timer);
> +}
> +
> static Property ioapic_properties[] =3D {
>     DEFINE_PROP_UINT8("version", IOAPICCommonState, version, =
IOAPIC_VER_DEF),
>     DEFINE_PROP_END_OF_LIST(),
> @@ -419,6 +465,7 @@ static void ioapic_class_init(ObjectClass *klass, =
void *data)
>     DeviceClass *dc =3D DEVICE_CLASS(klass);
>=20
>     k->realize =3D ioapic_realize;
> +    k->unrealize =3D ioapic_unrealize;
>     /*
>      * If APIC is in kernel, we need to update the kernel cache after
>      * migration, otherwise first 24 gsi routes will be invalid.
> diff --git a/hw/intc/trace-events b/hw/intc/trace-events
> index a28bdce925..90c9d07c1a 100644
> --- a/hw/intc/trace-events
> +++ b/hw/intc/trace-events
> @@ -25,6 +25,7 @@ apic_mem_writel(uint64_t addr, uint32_t val) =
"0x%"PRIx64" =3D 0x%08x"
> ioapic_set_remote_irr(int n) "set remote irr for pin %d"
> ioapic_clear_remote_irr(int n, int vector) "clear remote irr for pin =
%d vector %d"
> ioapic_eoi_broadcast(int vector) "EOI broadcast for vector %d"
> +ioapic_eoi_delayed_reassert(int vector) "delayed reassert on EOI =
broadcast for vector %d"
> ioapic_mem_read(uint8_t addr, uint8_t regsel, uint8_t size, uint32_t =
val) "ioapic mem read addr 0x%"PRIx8" regsel: 0x%"PRIx8" size 0x%"PRIx8" =
retval 0x%"PRIx32
> ioapic_mem_write(uint8_t addr, uint8_t regsel, uint8_t size, uint32_t =
val) "ioapic mem write addr 0x%"PRIx8" regsel: 0x%"PRIx8" size =
0x%"PRIx8" val 0x%"PRIx32
> ioapic_set_irq(int vector, int level) "vector: %d level: %d"
> diff --git a/include/hw/i386/ioapic_internal.h =
b/include/hw/i386/ioapic_internal.h
> index 9848f391bb..70f9fc750a 100644
> --- a/include/hw/i386/ioapic_internal.h
> +++ b/include/hw/i386/ioapic_internal.h
> @@ -96,6 +96,7 @@ typedef struct IOAPICCommonClass {
>     SysBusDeviceClass parent_class;
>=20
>     DeviceRealize realize;
> +    DeviceUnrealize unrealize;
>     void (*pre_save)(IOAPICCommonState *s);
>     void (*post_load)(IOAPICCommonState *s);
> } IOAPICCommonClass;
> @@ -111,6 +112,8 @@ struct IOAPICCommonState {
>     uint8_t version;
>     uint64_t irq_count[IOAPIC_NUM_PINS];
>     int irq_level[IOAPIC_NUM_PINS];
> +    int irq_eoi[IOAPIC_NUM_PINS];
> +    QEMUTimer *timer;

I suggest rename =E2=80=9Ctimer=E2=80=9D to something more indicative as =
one can confuse it with a generic IOAPIC timer.
Something such as =E2=80=9Cdelayed_ioapic_service_timer=E2=80=9D.

> };
>=20
> void ioapic_reset_common(DeviceState *dev);
> --=20
> 2.20.1
>=20
