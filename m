Received: from eggs.gnu.org ([2001:4830:134:3::10]:36745)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cr1BL-0008Mj-W6
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 07:45:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cr1BI-0002T4-2p
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 07:45:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46234)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cr1BH-0002Si-QP
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 07:45:28 -0400
References: <20170322121344.5484-1-pbonzini@redhat.com>
	<2a3ec22c-7f31-4c73-9e02-f026ba9e7369@typeapp.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4ec46a23-e179-22ff-4bdf-f049adf981eb@redhat.com>
Date: Thu, 23 Mar 2017 12:45:24 +0100
MIME-Version: 1.0
In-Reply-To: <2a3ec22c-7f31-4c73-9e02-f026ba9e7369@typeapp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] Revert "apic: save apic_delivered flag"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com



On 23/03/2017 08:34, Pavel Dovgalyuk wrote:
> This value is used by mc146818rtc.
> Therefore it affects the vitrual machine state.

It is used indeed, but it should not be used across virtual machine
migration or savevm.  The value doesn't matter as soon as
apic_get_irq_delivered is called, because there will be an
apic_reset_irq_delivered call before the next access; and when migrating
or saving a virtual machine, you cannot be between the calls to
apic_reset_irq_delivered and apic_get_irq_delivered.

It would be interesting to try something like this:

diff --git a/hw/intc/apic_common.c b/hw/intc/apic_common.c
index 7a6e771..10a114d 100644
--- a/hw/intc/apic_common.c
+++ b/hw/intc/apic_common.c
@@ -32,6 +32,7 @@
 #include "hw/sysbus.h"

 static int apic_irq_delivered;
+static bool apic_irq_delivered_valid;
 bool apic_report_tpr_access;

 void cpu_set_apic_base(DeviceState *dev, uint64_t val)
@@ -136,13 +137,18 @@ void apic_reset_irq_delivered(void)
     volatile int a_i_d =3D apic_irq_delivered;
     trace_apic_reset_irq_delivered(a_i_d);

+    assert(!apic_irq_delivered_valid);
     apic_irq_delivered =3D 0;
+    apic_irq_delivered_valid =3D true;
 }

 int apic_get_irq_delivered(void)
 {
     trace_apic_get_irq_delivered(apic_irq_delivered);

+    assert(apic_irq_delivered_valid);
+    apic_irq_delivered_valid =3D false;
+
     return apic_irq_delivered;
 }


Paolo

> I've encountered the cases when replay was broken without migrating of
> this variable.
> =D0=9E=D1=82=D0=BF=D1=80=D0=B0=D0=B2=D0=BB=D0=B5=D0=BD=D0=BE =D1=81 =D0=
=BF=D0=BE=D0=BC=D0=BE=D1=89=D1=8C=D1=8E BlueMail <http://www.bluemail.me/=
r?b=3D9226>
> =D0=9D=D0=B0 22 =D0=9C=D0=B0=D1=80 2017 =D0=B3., =D0=B2 15:13, Paolo Bo=
nzini <pbonzini@redhat.com
> <mailto:pbonzini@redhat.com>> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BB=
:
>=20
>     This reverts commit 07bfa354772f2de67008dc66c201b627acff0106.
>     The global variable is only read as part of a
>=20
>                 apic_reset_irq_delivered();
>                 qemu_irq_raise(s->irq);
>                 if (!apic_get_irq_delivered()) {
>=20
>     sequence, so the value never matters at migration time.
>=20
>     Reported-by: Dr. David Alan Gilbert <dglibert@redhat.com>
>     Cc: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
>     Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>     ---
>      hw/intc/apic_common.c           | 33
>     -------------------------------------------------------------------=
-----
>=20
>      include/hw/i386/apic_internal.h |  2 --
>      2 files changed, 35 deletions(-)
>=20
>     diff --git a/hw/intc/apic_common.c b/hw/intc/apic_common.c
>     index 7a6e771..c3829e3 100644
>     --- a/hw/intc/apic_common.c
>     +++ b/hw/intc/apic_common.c
>     @@ -387,25 +387,6 @@ static bool apic_common_sipi_needed(void *opaq=
ue)
>          return s->wait_for_sipi !=3D 0;
>      }
>     =20
>     -static bool apic_irq_delivered_needed(void *opaque)
>     -{
>     -    APICCommonState *s =3D APIC_COMMON(opaque);
>     -    return s->cpu =3D=3D X86_CPU(first_cpu) && apic_irq_delivered =
!=3D 0;
>     -}
>     -
>     -static void apic_irq_delivered_pre_save(void *opaque)
>     -{
>     -    APICCommonState *s =3D APIC_COMMON(opaque);
>     -    s->apic_irq_delivered =3D apic_irq_delivered;
>     -}
>     -
>     -static int apic_irq_delivered_post_load(void *opaque, int version_=
id)
>     -{
>     -    APICCommonState *s =3D APIC_COMMON(opaque);
>     -    apic_irq_delivered =3D s->apic_irq_delivered;
>     -    return 0;
>     -}
>     -
>      static const VMStateDescription vmstate_apic_common_sipi =3D {
>          .name =3D "apic_sipi",
>          .version_id =3D 1,
>     @@ -418,19 +399,6 @@ static const VMStateDescription vmstate_apic_c=
ommon_sipi =3D {
>          }
>      };
>     =20
>     -static const VMStateDescription vmstate_apic_irq_delivered =3D {
>     -    .name =3D "apic_irq_delivered",
>     -    .version_id =3D 1,
>     -    .minimum_version_id =3D 1,
>     -    .needed =3D apic_irq_delivered_needed,
>     -    .pre_save =3D apic_irq_delivered_pre_save,
>     -    .post_load =3D apic_irq_delivered_post_load,
>     -    .fields =3D (VMStateField[]) {
>     -        VMSTATE_INT32(apic_irq_delivered, APICCommonState),
>     -        VMSTATE_END_OF_LIST()
>     -    }
>     -};
>     -
>      static const VMStateDescription vmstate_apic_common =3D {
>          .name =3D "apic",
>          .version_id =3D 3,
>     @@ -465,7 +433,6 @@ static const VMStateDescription vmstate_apic_co=
mmon =3D {
>          },
>          .subsections =3D (const VMStateDescription*[]) {
>              &vmstate_apic_common_sipi,
>     -        &vmstate_apic_irq_delivered,
>              NULL
>          }
>      };
>     diff --git a/include/hw/i386/apic_internal.h b/include/hw/i386/apic=
_internal.h
>     index 20ad28c..1209eb4 100644
>     --- a/include/hw/i386/apic_internal.h
>     +++ b/include/hw/i386/apic_internal.h
>     @@ -189,8 +189,6 @@ struct APICCommonState {
>          DeviceState *vapic;
>          hwaddr vapic_paddr; /* note: persistence via kvmvapic */
>          bool legacy_instance_id;
>     -
>     -    int apic_irq_delivered; /* for saving static variable */
>      };
>     =20
>      typedef struct VAPICState {
>=20
