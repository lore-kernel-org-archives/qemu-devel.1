Received: from eggs.gnu.org ([2001:4830:134:3::10]:53075)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cjmtb-0008DO-Qw
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 08:05:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cjmtW-0004FZ-SA
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 08:05:19 -0500
References: <1488545463-19776-1-git-send-email-clg@kaod.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <82fccacc-4e94-6293-7839-30b96131d719@redhat.com>
Date: Fri, 3 Mar 2017 14:05:11 +0100
MIME-Version: 1.0
In-Reply-To: <1488545463-19776-1-git-send-email-clg@kaod.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] ppc/xics: register reset handlers for the
 ICP and ICS objects
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On 03.03.2017 13:51, C=C3=A9dric Le Goater wrote:
> The recent changes on the XICS layer removed the XICSState object to
> let the sPAPR machine handle the ICP and ICS directly. The reset of
> these objects was previously handled by XICSState, which was a SysBus
> device, and to keep the same behavior, the ICP and ICS were assigned
> to SysbBus.
>=20
> But that broke the 'info qtree' command in the monitor. 'qtree'
> performs a loop on the children of a bus to print their properties and
> SysBus devices are expected to be found under SysBus, which is not the
> case anymore.
>=20
> The fix for this problem is to register reset handlers for the ICP and
> ICS objects and stop using SysBus for such devices.
>=20
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---
>  hw/intc/xics.c     | 10 ++++++----
>  hw/intc/xics_kvm.c | 15 ++++++++++-----
>  hw/ppc/spapr.c     |  2 --
>  3 files changed, 16 insertions(+), 11 deletions(-)
>=20
> diff --git a/hw/intc/xics.c b/hw/intc/xics.c
> index ffc0747c7fa2..e740989a1162 100644
> --- a/hw/intc/xics.c
> +++ b/hw/intc/xics.c
> @@ -333,7 +333,7 @@ static const VMStateDescription vmstate_icp_server =
=3D {
>      },
>  };
> =20
> -static void icp_reset(DeviceState *dev)
> +static void icp_reset(void *dev)
>  {
>      ICPState *icp =3D ICP(dev);
> =20
> @@ -359,6 +359,8 @@ static void icp_realize(DeviceState *dev, Error **e=
rrp)
>      }
> =20
>      icp->xics =3D XICS_FABRIC(obj);
> +
> +    qemu_register_reset(icp_reset, dev);
>  }
> =20
> =20
> @@ -366,7 +368,6 @@ static void icp_class_init(ObjectClass *klass, void=
 *data)
>  {
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
> =20
> -    dc->reset =3D icp_reset;
>      dc->vmsd =3D &vmstate_icp_server;
>      dc->realize =3D icp_realize;
>  }
> @@ -522,7 +523,7 @@ static void ics_simple_eoi(ICSState *ics, uint32_t =
nr)
>      }
>  }
> =20
> -static void ics_simple_reset(DeviceState *dev)
> +static void ics_simple_reset(void *dev)
>  {
>      ICSState *ics =3D ICS_SIMPLE(dev);
>      int i;
> @@ -611,6 +612,8 @@ static void ics_simple_realize(DeviceState *dev, Er=
ror **errp)
>      }
>      ics->irqs =3D g_malloc0(ics->nr_irqs * sizeof(ICSIRQState));
>      ics->qirqs =3D qemu_allocate_irqs(ics_simple_set_irq, ics, ics->nr=
_irqs);
> +
> +    qemu_register_reset(ics_simple_reset, dev);
>  }
> =20
>  static Property ics_simple_properties[] =3D {
> @@ -626,7 +629,6 @@ static void ics_simple_class_init(ObjectClass *klas=
s, void *data)
>      isc->realize =3D ics_simple_realize;
>      dc->props =3D ics_simple_properties;
>      dc->vmsd =3D &vmstate_ics_simple;
> -    dc->reset =3D ics_simple_reset;
>      isc->reject =3D ics_simple_reject;
>      isc->resend =3D ics_simple_resend;
>      isc->eoi =3D ics_simple_eoi;
> diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
> index 0a3daca3bb5a..42e0e0ef8484 100644
> --- a/hw/intc/xics_kvm.c
> +++ b/hw/intc/xics_kvm.c
> @@ -102,7 +102,7 @@ static int icp_set_kvm_state(ICPState *icp, int ver=
sion_id)
>      return 0;
>  }
> =20
> -static void icp_kvm_reset(DeviceState *dev)
> +static void icp_kvm_reset(void *dev)
>  {
>      ICPState *icp =3D ICP(dev);
> =20
> @@ -146,12 +146,17 @@ static void icp_kvm_cpu_setup(ICPState *icp, Powe=
rPCCPU *cpu)
>      icp->cap_irq_xics_enabled =3D true;
>  }
> =20
> +static void icp_kvm_realize(DeviceState *dev, Error **errp)
> +{
> +    qemu_register_reset(icp_kvm_reset, dev);
> +}
> +
>  static void icp_kvm_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
>      ICPStateClass *icpc =3D ICP_CLASS(klass);
> =20
> -    dc->reset =3D icp_kvm_reset;
> +    dc->realize =3D icp_kvm_realize;
>      icpc->pre_save =3D icp_get_kvm_state;
>      icpc->post_load =3D icp_set_kvm_state;
>      icpc->cpu_setup =3D icp_kvm_cpu_setup;
> @@ -293,7 +298,7 @@ static void ics_kvm_set_irq(void *opaque, int srcno=
, int val)
>      }
>  }
> =20
> -static void ics_kvm_reset(DeviceState *dev)
> +static void ics_kvm_reset(void *dev)
>  {
>      ICSState *ics =3D ICS_SIMPLE(dev);
>      int i;
> @@ -324,15 +329,15 @@ static void ics_kvm_realize(DeviceState *dev, Err=
or **errp)
>      }
>      ics->irqs =3D g_malloc0(ics->nr_irqs * sizeof(ICSIRQState));
>      ics->qirqs =3D qemu_allocate_irqs(ics_kvm_set_irq, ics, ics->nr_ir=
qs);
> +
> +    qemu_register_reset(ics_kvm_reset, dev);
>  }
> =20
>  static void ics_kvm_class_init(ObjectClass *klass, void *data)
>  {
> -    DeviceClass *dc =3D DEVICE_CLASS(klass);
>      ICSStateClass *icsc =3D ICS_BASE_CLASS(klass);
> =20
>      icsc->realize =3D ics_kvm_realize;
> -    dc->reset =3D ics_kvm_reset;
>      icsc->pre_save =3D ics_get_kvm_state;
>      icsc->post_load =3D ics_set_kvm_state;
>  }
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 14192accf486..c3bb99160545 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -106,7 +106,6 @@ static int try_create_xics(sPAPRMachineState *spapr=
, const char *type_ics,
>      int i;
> =20
>      ics =3D ICS_SIMPLE(object_new(type_ics));
> -    qdev_set_parent_bus(DEVICE(ics), sysbus_get_default());
>      object_property_add_child(OBJECT(spapr), "ics", OBJECT(ics), NULL)=
;
>      object_property_set_int(OBJECT(ics), nr_irqs, "nr-irqs", &err);
>      object_property_add_const_link(OBJECT(ics), "xics", OBJECT(xi), NU=
LL);
> @@ -123,7 +122,6 @@ static int try_create_xics(sPAPRMachineState *spapr=
, const char *type_ics,
>          ICPState *icp =3D &spapr->icps[i];
> =20
>          object_initialize(icp, sizeof(*icp), type_icp);
> -        qdev_set_parent_bus(DEVICE(icp), sysbus_get_default());
>          object_property_add_child(OBJECT(spapr), "icp[*]", OBJECT(icp)=
, NULL);
>          object_property_add_const_link(OBJECT(icp), "xics", OBJECT(xi)=
, NULL);
>          object_property_set_bool(OBJECT(icp), true, "realized", &err);

Reviewed-by: Thomas Huth <thuth@redhat.com>
Tested-by: Thomas Huth <thuth@redhat.com>
