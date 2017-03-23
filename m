Received: from eggs.gnu.org ([2001:4830:134:3::10]:46336)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pavel.dovgaluk@ispras.ru>) id 1cqxG7-0007A7-GV
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 03:34:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pavel.dovgaluk@ispras.ru>) id 1cqxG4-0001Iv-Bo
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 03:34:11 -0400
Received: from mail.ispras.ru ([83.149.199.45]:42572)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pavel.dovgaluk@ispras.ru>) id 1cqxG3-0001IS-Vw
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 03:34:08 -0400
In-Reply-To: <20170322121344.5484-1-pbonzini@redhat.com>
References: <20170322121344.5484-1-pbonzini@redhat.com>
MIME-Version: 1.0
From: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
Date: Thu, 23 Mar 2017 10:34:04 +0300
Message-ID: <2a3ec22c-7f31-4c73-9e02-f026ba9e7369@typeapp.com>
Content-Type: text/plain;
 charset=UTF-8
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
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com

This value is used by mc146818rtc=2E
Therefore it affects the vitrual machi=
ne state=2E
I've encountered the cases when replay was broken without migra=
ting of this variable=2E

=E2=81=A3=D0=9E=D1=82=D0=BF=D1=80=D0=B0=D0=B2=D0=
=BB=D0=B5=D0=BD=D0=BE =D1=81 =D0=BF=D0=BE=D0=BC=D0=BE=D1=89=D1=8C=D1=8E Blu=
eMail =E2=80=8B

=D0=9D=D0=B0 22 =D0=9C=D0=B0=D1=80 2017 =D0=B3=2E, 15:13, =
=D0=B2 15:13, Paolo Bonzini <pbonzini@redhat=2Ecom> =D0=BD=D0=B0=D0=BF=D0=
=B8=D1=81=D0=B0=D0=BB:>This reverts commit 07bfa354772f2de67008dc66c201b627=
acff0106=2E
>The global variable is only read as part of a
>
>            a=
pic_reset_irq_delivered();
>            qemu_irq_raise(s->irq);
>          =
  if (!apic_get_irq_delivered()) {
>
>sequence, so the value never matters =
at migration time=2E
>
>Reported-by: Dr=2E David Alan Gilbert <dglibert@red=
hat=2Ecom>
>Cc: Pavel Dovgalyuk <pavel=2Edovgaluk@ispras=2Eru>
>Signed-off-=
by: Paolo Bonzini <pbonzini@redhat=2Ecom>
>---
> hw/intc/apic_common=2Ec   =
        | 33 ---------------------------------
> include/hw/i386/apic_inter=
nal=2Eh |  2 --
> 2 files changed, 35 deletions(-)
>
>diff --git a/hw/intc/=
apic_common=2Ec b/hw/intc/apic_common=2Ec
>index 7a6e771=2E=2Ec3829e3 10064=
4
>--- a/hw/intc/apic_common=2Ec
>+++ b/hw/intc/apic_common=2Ec
>@@ -387,25=
 +387,6 @@ static bool apic_common_sipi_needed(void *opaque)
>     return s=
->wait_for_sipi !=3D 0;
> }
> 
>-static bool apic_irq_delivered_needed(void=
 *opaque)
>-{
>-    APICCommonState *s =3D APIC_COMMON(opaque);
>-    retur=
n s->cpu =3D=3D X86_CPU(first_cpu) && apic_irq_delivered !=3D 0;
>-}
>-
>-s=
tatic void apic_irq_delivered_pre_save(void *opaque)
>-{
>-    APICCommonSt=
ate *s =3D APIC_COMMON(opaque);
>-    s->apic_irq_delivered =3D apic_irq_de=
livered;
>-}
>-
>-static int apic_irq_delivered_post_load(void *opaque, int=
 version_id)
>-{
>-    APICCommonState *s =3D APIC_COMMON(opaque);
>-    ap=
ic_irq_delivered =3D s->apic_irq_delivered;
>-    return 0;
>-}
>-
> static=
 const VMStateDescription vmstate_apic_common_sipi =3D {
>     =2Ename =3D =
"apic_sipi",
>     =2Eversion_id =3D 1,
>@@ -418,19 +399,6 @@ static const =
VMStateDescription
>vmstate_apic_common_sipi =3D {
>     }
> };
> 
>-static=
 const VMStateDescription vmstate_apic_irq_delivered =3D {
>-    =2Ename =
=3D "apic_irq_delivered",
>-    =2Eversion_id =3D 1,
>-    =2Eminimum_versi=
on_id =3D 1,
>-    =2Eneeded =3D apic_irq_delivered_needed,
>-    =2Epre_sa=
ve =3D apic_irq_delivered_pre_save,
>-    =2Epost_load =3D apic_irq_deliver=
ed_post_load,
>-    =2Efields =3D (VMStateField[]) {
>-        VMSTATE_INT3=
2(apic_irq_delivered, APICCommonState),
>-        VMSTATE_END_OF_LIST()
>- =
   }
>-};
>-
> static const VMStateDescription vmstate_apic_common =3D {
> =
    =2Ename =3D "apic",
>     =2Eversion_id =3D 3,
>@@ -465,7 +433,6 @@ sta=
tic const VMStateDescription vmstate_apic_common
>=3D {
>     },
>     =2Es=
ubsections =3D (const VMStateDescription*[]) {
>         &vmstate_apic_comm=
on_sipi,
>-        &vmstate_apic_irq_delivered,
>         NULL
>     }
> };=

>diff --git a/include/hw/i386/apic_internal=2Eh
>b/include/hw/i386/apic_in=
ternal=2Eh
>index 20ad28c=2E=2E1209eb4 100644
>--- a/include/hw/i386/apic_i=
nternal=2Eh
>+++ b/include/hw/i386/apic_internal=2Eh
>@@ -189,8 +189,6 @@ s=
truct APICCommonState {
>     DeviceState *vapic;
>     hwaddr vapic_paddr;=
 /* note: persistence via kvmvapic */
>     bool legacy_instance_id;
>-
>- =
   int apic_irq_delivered; /* for saving static variable */
> };
> 
> typed=
ef struct VAPICState {
>-- 
>2=2E9=2E3
