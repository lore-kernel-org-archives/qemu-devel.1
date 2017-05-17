Received: from eggs.gnu.org ([2001:4830:134:3::10]:50062)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dB2y4-000134-6C
	for qemu-devel@nongnu.org; Wed, 17 May 2017 13:42:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dB2y1-00085S-1o
	for qemu-devel@nongnu.org; Wed, 17 May 2017 13:42:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46928)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dB2y0-00085M-Oc
	for qemu-devel@nongnu.org; Wed, 17 May 2017 13:42:32 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4C63D448D70
	for <qemu-devel@nongnu.org>; Wed, 17 May 2017 17:42:31 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170509173559.31598-1-marcandre.lureau@redhat.com>
	<20170509173559.31598-14-marcandre.lureau@redhat.com>
Date: Wed, 17 May 2017 19:42:25 +0200
In-Reply-To: <20170509173559.31598-14-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Tue, 9 May 2017
	20:35:55 +0300")
Message-ID: <87inkzxtvi.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 13/17] qdev: use appropriate getter/setters
 type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Based on underlying property type, use the appropriate getters/setters.

How did you find the ones that need changing?

> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  hw/i386/acpi-build.c      | 12 ++++++------
>  hw/pci-host/gpex.c        |  2 +-
>  hw/pci-host/q35.c         |  2 +-
>  hw/pci-host/xilinx-pcie.c |  2 +-
>  target/i386/cpu.c         |  2 +-
>  5 files changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 767da5d78e..1707fae9bf 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -149,21 +149,21 @@ static void acpi_get_pm_info(AcpiPmInfo *pm)
>      /* Fill in optional s3/s4 related properties */
>      o =3D object_property_get_qobject(obj, ACPI_PM_PROP_S3_DISABLED, NUL=
L);
>      if (o) {
> -        pm->s3_disabled =3D qnum_get_int(qobject_to_qnum(o), &error_abor=
t);
> +        pm->s3_disabled =3D qnum_get_uint(qobject_to_qnum(o), &error_abo=
rt);
>      } else {
>          pm->s3_disabled =3D false;
>      }
>      qobject_decref(o);
>      o =3D object_property_get_qobject(obj, ACPI_PM_PROP_S4_DISABLED, NUL=
L);
>      if (o) {
> -        pm->s4_disabled =3D qnum_get_int(qobject_to_qnum(o), &error_abor=
t);
> +        pm->s4_disabled =3D qnum_get_uint(qobject_to_qnum(o), &error_abo=
rt);
>      } else {
>          pm->s4_disabled =3D false;
>      }
>      qobject_decref(o);
>      o =3D object_property_get_qobject(obj, ACPI_PM_PROP_S4_VAL, NULL);
>      if (o) {
> -        pm->s4_val =3D qnum_get_int(qobject_to_qnum(o), &error_abort);
> +        pm->s4_val =3D qnum_get_uint(qobject_to_qnum(o), &error_abort);
>      } else {
>          pm->s4_val =3D false;
>      }

The getter and setter of properties ACPI_PM_PROP_S3_DISABLED,
ACPI_PM_PROP_S4_DISABLED and ACPI_PM_PROP_S4_VAL use visit_type_uint8().

object_property_get_qobject() uses this getter below the hood with a
QObject output visitor, to get the value into a QObject.  Since the
getter uses visit_type_uint8(), the QObject is a QNum with QNUM_U64.

The appropriate way to extract the QNum's value is qnum_get_uint().

Okay.

> @@ -499,7 +499,7 @@ static void build_append_pci_bus_devices(Aml *parent_=
scope, PCIBus *bus,
>=20=20
>      bsel =3D object_property_get_qobject(OBJECT(bus), ACPI_PCIHP_PROP_BS=
EL, NULL);
>      if (bsel) {
> -        int64_t bsel_val =3D qnum_get_int(qobject_to_qnum(bsel), &error_=
abort);
> +        uint64_t bsel_val =3D qnum_get_uint(qobject_to_qnum(bsel), &erro=
r_abort);
>=20=20
>          aml_append(parent_scope, aml_name_decl("BSEL", aml_int(bsel_val)=
));
>          notify_method =3D aml_method("DVNT", 2, AML_NOTSERIALIZED);

Similar argument, only slightly more tricky, as the getter dereferences
a pointer.

> @@ -609,7 +609,7 @@ static void build_append_pci_bus_devices(Aml *parent_=
scope, PCIBus *bus,
>=20=20
>      /* If bus supports hotplug select it and notify about local events */
>      if (bsel) {
> -        int64_t bsel_val =3D qnum_get_int(qobject_to_qnum(bsel), &error_=
abort);
> +        uint64_t bsel_val =3D qnum_get_uint(qobject_to_qnum(bsel), &erro=
r_abort);
>          aml_append(method, aml_store(aml_int(bsel_val), aml_name("BNUM")=
));
>          aml_append(method,
>              aml_call2("DVNT", aml_name("PCIU"), aml_int(1) /* Device Che=
ck */)

Likewise (@bsel is the same as above).

> @@ -2590,7 +2590,7 @@ static bool acpi_get_mcfg(AcpiMcfgInfo *mcfg)
>=20=20
>      o =3D object_property_get_qobject(pci_host, PCIE_HOST_MCFG_SIZE, NUL=
L);
>      assert(o);
> -    mcfg->mcfg_size =3D qnum_get_int(qobject_to_qnum(o), &error_abort);
> +    mcfg->mcfg_size =3D qnum_get_uint(qobject_to_qnum(o), &error_abort);
>      qobject_decref(o);
>      return true;
>  }

Similar argument.

I suspect the hunk I challenged in PATCH 09 actually belongs here.

> diff --git a/hw/pci-host/gpex.c b/hw/pci-host/gpex.c
> index 66055ee5cc..8d3a64008c 100644
> --- a/hw/pci-host/gpex.c
> +++ b/hw/pci-host/gpex.c
> @@ -94,7 +94,7 @@ static void gpex_host_initfn(Object *obj)
>=20=20
>      object_initialize(root, sizeof(*root), TYPE_GPEX_ROOT_DEVICE);
>      object_property_add_child(obj, "gpex_root", OBJECT(root), NULL);
> -    qdev_prop_set_uint32(DEVICE(root), "addr", PCI_DEVFN(0, 0));
> +    qdev_prop_set_int32(DEVICE(root), "addr", PCI_DEVFN(0, 0));
>      qdev_prop_set_bit(DEVICE(root), "multifunction", false);
>  }
>=20=20

"addr" is a property of TYPE_PCI_DEVICE, defined with
DEFINE_PROP_PCI_DEVFN().  It's int32_t, even though only 8 bits are
used.  Okay.

> diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
> index 5438be8253..3cbe8cfcea 100644
> --- a/hw/pci-host/q35.c
> +++ b/hw/pci-host/q35.c
> @@ -173,7 +173,7 @@ static void q35_host_initfn(Object *obj)
>=20=20
>      object_initialize(&s->mch, sizeof(s->mch), TYPE_MCH_PCI_DEVICE);
>      object_property_add_child(OBJECT(s), "mch", OBJECT(&s->mch), NULL);
> -    qdev_prop_set_uint32(DEVICE(&s->mch), "addr", PCI_DEVFN(0, 0));
> +    qdev_prop_set_int32(DEVICE(&s->mch), "addr", PCI_DEVFN(0, 0));
>      qdev_prop_set_bit(DEVICE(&s->mch), "multifunction", false);
>=20=20
>      object_property_add(obj, PCI_HOST_PROP_PCI_HOLE_START, "uint32",

Likewise.

> diff --git a/hw/pci-host/xilinx-pcie.c b/hw/pci-host/xilinx-pcie.c
> index 8b71e2d950..461ed41151 100644
> --- a/hw/pci-host/xilinx-pcie.c
> +++ b/hw/pci-host/xilinx-pcie.c
> @@ -150,7 +150,7 @@ static void xilinx_pcie_host_init(Object *obj)
>=20=20
>      object_initialize(root, sizeof(*root), TYPE_XILINX_PCIE_ROOT);
>      object_property_add_child(obj, "root", OBJECT(root), NULL);
> -    qdev_prop_set_uint32(DEVICE(root), "addr", PCI_DEVFN(0, 0));
> +    qdev_prop_set_int32(DEVICE(root), "addr", PCI_DEVFN(0, 0));
>      qdev_prop_set_bit(DEVICE(root), "multifunction", false);
>  }
>=20=20

Likewise.

> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 1e8a5b55c0..5bb8131bb8 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -3191,7 +3191,7 @@ static void x86_cpu_apic_create(X86CPU *cpu, Error =
**errp)
>                                OBJECT(cpu->apic_state), &error_abort);
>      object_unref(OBJECT(cpu->apic_state));
>=20=20
> -    qdev_prop_set_uint32(cpu->apic_state, "id", cpu->apic_id);
> +    qdev_prop_set_int32(cpu->apic_state, "id", cpu->apic_id);
>      /* TODO: convert to link<> */
>      apic =3D APIC_COMMON(cpu->apic_state);
>      apic->cpu =3D cpu;

This one's a bit of a mess.

The getter and setter of TYPE_APIC_COMMON property "id" are
apic_common_get_id() and apic_common_set_id().

apic_common_get_id() reads either APICCommonState member uint32_t
initial_apic_id or uint8_t id into an int64_t local variable.  It then
passes this variable to visit_type_int().

apic_common_set_id() uses visit_type_int() to read the value into a
local variable, which it then assigns both to initial_apic_id and id.

While the state backing the property is two unsigned members, 8 and 32
bits wide, the actual visitor is 64 bits signed.

cpu->apic_id is uint32_t.

qdev_prop_set_uint32() isn't really wrong, because any uint32_t value is
also a valid int64_t value.

qdev_prop_set_int32() is implicitly converts cpu->apic_id from uint32_t
to int32_t.  Perhaps that's even okay, but I don't care, I want this
mess cleaned up :)

Two possible ways to clean up:

1. Use qdev_prop_set_int().  Then the members get converted to
int64_t and back.  Looks safe to me.

2. Change getter and setter to use visit_type_uint32().  Then
everything's uint32_t, except for @id.

I prefer 2.

This getter and setter business drives me nuts.  Them mixing up
signedness and width doesn't help.
