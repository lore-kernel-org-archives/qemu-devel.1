Received: from eggs.gnu.org ([209.51.188.92]:45821)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1giz9K-00015F-Bg
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 05:07:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1giz9J-0001d7-0R
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 05:07:18 -0500
Received: from 14.mo5.mail-out.ovh.net ([188.165.51.82]:52963)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1giz9I-0001br-Of
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 05:07:16 -0500
Received: from player726.ha.ovh.net (unknown [10.109.159.152])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 7320820C167
	for <qemu-devel@nongnu.org>; Mon, 14 Jan 2019 11:07:13 +0100 (CET)
References: <154724039526.525985.3172545257507998890.stgit@bahia.lan>
	<154724064012.525985.14816153453704405652.stgit@bahia.lan>
	<08695a23-c67a-938d-b13e-be04e6fa09c3@kaod.org>
	<20190114110336.1dce0527@bahia.lan>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <72747ef1-d63b-f4a2-e18e-b16ffa7c1698@kaod.org>
Date: Mon, 14 Jan 2019 11:06:39 +0100
MIME-Version: 1.0
In-Reply-To: <20190114110336.1dce0527@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 10/13] spapr_irq: Expose the phandle of
 the interrupt controller
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, Alexey Kardashevskiy <aik@ozlabs.ru>, Michael Roth <mdroth@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Dmitry Fleytman <dmitry.fleytman@gmail.com>, Thomas Huth <thuth@redhat.com>

On 1/14/19 11:03 AM, Greg Kurz wrote:
> On Mon, 14 Jan 2019 09:11:47 +0100
> C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>=20
>> On 1/11/19 10:04 PM, Greg Kurz wrote:
>>> This will be used by PHB hotplug in order to create the "interrupt-ma=
p"
>>> property of the PHB node.
>>>
>>> Signed-off-by: Greg Kurz <groug@kaod.org>
>>> ---
>>>  hw/intc/spapr_xive.c        |   34 ++++++++++++++++++++++++++++++++-=
-
>>>  hw/intc/xics_spapr.c        |   28 +++++++++++++++++++++++++++-
>>>  hw/ppc/spapr_irq.c          |   13 ++++++++++++-
>>>  include/hw/ppc/spapr_irq.h  |    1 +
>>>  include/hw/ppc/spapr_xive.h |    2 ++
>>>  include/hw/ppc/xics_spapr.h |    2 ++
>>>  6 files changed, 76 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
>>> index d391177ab81f..ffae680024d7 100644
>>> --- a/hw/intc/spapr_xive.c
>>> +++ b/hw/intc/spapr_xive.c
>>> @@ -1414,6 +1414,12 @@ void spapr_xive_hcall_init(sPAPRMachineState *=
spapr)
>>>      spapr_register_hypercall(H_INT_RESET, h_int_reset);
>>>  }
>>> =20
>>> +static gchar *xive_nodename(sPAPRXive *xive)
>>> +{
>>> +    return g_strdup_printf("interrupt-controller@%" PRIx64,
>>> +                           xive->tm_base + XIVE_TM_USER_PAGE * (1 <<=
 TM_SHIFT));
>>> +}
>>> +
>>>  void spapr_dt_xive(sPAPRMachineState *spapr, uint32_t nr_servers, vo=
id *fdt,
>>>                     uint32_t phandle)
>>>  {
>>> @@ -1450,8 +1456,7 @@ void spapr_dt_xive(sPAPRMachineState *spapr, ui=
nt32_t nr_servers, void *fdt,
>>>                             XIVE_TM_OS_PAGE * (1ull << TM_SHIFT));
>>>      timas[3] =3D cpu_to_be64(1ull << TM_SHIFT);
>>> =20
>>> -    nodename =3D g_strdup_printf("interrupt-controller@%" PRIx64,
>>> -                           xive->tm_base + XIVE_TM_USER_PAGE * (1 <<=
 TM_SHIFT));
>>> +    nodename =3D xive_nodename(xive);
>>>      _FDT(node =3D fdt_add_subnode(fdt, 0, nodename));
>>>      g_free(nodename);
>>> =20
>>> @@ -1479,3 +1484,28 @@ void spapr_dt_xive(sPAPRMachineState *spapr, u=
int32_t nr_servers, void *fdt,
>>>      _FDT(fdt_setprop(fdt, 0, "ibm,plat-res-int-priorities",
>>>                       plat_res_int_priorities, sizeof(plat_res_int_pr=
iorities)));
>>>  }
>>> +
>>> +uint32_t spapr_get_phandle_xive(sPAPRMachineState *spapr, void *fdt,
>>> +                                Error **errp)
>>> +{
>>> +    gchar *nodename =3D xive_nodename(spapr->xive);
>>> +    int phandle =3D -1, offset;
>>> +
>>> +    offset =3D fdt_subnode_offset(fdt, 0, nodename);
>>> +    if (offset < 0) {
>>> +        error_setg(errp, "Can't find node \"%s\": %s", nodename,
>>> +                   fdt_strerror(offset));
>>> +        goto out;
>>> +    }
>>> +
>>> +    phandle =3D fdt_get_phandle(spapr->fdt_blob, offset);
>>> +    if (phandle < 0) {
>>> +        error_setg(errp, "Can't get phandle of node \"%s\": %s",
>>> +                   nodename, fdt_strerror(phandle));
>>> +        goto out;
>>> +    }
>>> +
>>> +out:
>>> +    g_free(nodename);
>>> +    return phandle;
>>> +}
>>> diff --git a/hw/intc/xics_spapr.c b/hw/intc/xics_spapr.c
>>> index de6cc15b6474..7763b81d90dd 100644
>>> --- a/hw/intc/xics_spapr.c
>>> +++ b/hw/intc/xics_spapr.c
>>> @@ -35,6 +35,7 @@
>>>  #include "hw/ppc/xics_spapr.h"
>>>  #include "hw/ppc/fdt.h"
>>>  #include "qapi/visitor.h"
>>> +#include "qapi/error.h"
>>> =20
>>>  /*
>>>   * Guest interfaces
>>> @@ -245,6 +246,8 @@ void xics_spapr_init(sPAPRMachineState *spapr)
>>>      spapr_register_hypercall(H_IPOLL, h_ipoll);
>>>  }
>>> =20
>>> +#define NODENAME "interrupt-controller"
>>> +
>>>  void spapr_dt_xics(sPAPRMachineState *spapr, uint32_t nr_servers, vo=
id *fdt,
>>>                     uint32_t phandle)
>>>  {
>>> @@ -253,7 +256,7 @@ void spapr_dt_xics(sPAPRMachineState *spapr, uint=
32_t nr_servers, void *fdt,
>>>      };
>>>      int node;
>>> =20
>>> -    _FDT(node =3D fdt_add_subnode(fdt, 0, "interrupt-controller"));
>>> +    _FDT(node =3D fdt_add_subnode(fdt, 0, NODENAME));
>>> =20
>>>      _FDT(fdt_setprop_string(fdt, node, "device_type",
>>>                              "PowerPC-External-Interrupt-Presentation=
"));
>>> @@ -266,3 +269,26 @@ void spapr_dt_xics(sPAPRMachineState *spapr, uin=
t32_t nr_servers, void *fdt,
>>>      _FDT(fdt_setprop_cell(fdt, node, "linux,phandle", phandle));
>>>      _FDT(fdt_setprop_cell(fdt, node, "phandle", phandle));
>>>  }
>>> +
>>> +uint32_t spapr_get_phandle_xics(sPAPRMachineState *spapr, void *fdt,
>>> +                                Error **errp)
>>> +{ =20
>>
>> This routine is redundant with the spapr_get_phandle_xive() I think.=20
>>
>=20
> Yes both routines do the same, except for the node name being a runtime
> thing with XIVE and build time with XICS.
>=20
>> I would remove the (*get_phandle)() method and move the code under a h=
igh=20
>> level spapr_irq_get_phandle() routine which would call a method of the=
=20
>> sPAPR IRQ backend :=20
>>
>> 	char* (*get_nodename)(sPAPRMachineState *spapr);
>>
>=20
> Yeah I had this in v1 but I didn't like to do g_strdup() of a fixed
> string in the XICS case.=20

you could introduce a static string and initialize it once. There is no
reason for it to change.

C.=20

> Anyway, I could possibly revert to doing that
> but I guess the setting of the "phandle" property should be moved to
> spapr_irq.c as well.
>=20
>> The get_nodename_xics and get_nodename_xive methods could be located=20
>> under the spapr_irq.c file or introduce helpers that could be used
>> directly as sPAPR IRQ methods.=20
>>
>> Thanks,
>>
>> C.=20
>>
>>> +    int phandle =3D -1, offset;
>>> +
>>> +    offset =3D fdt_subnode_offset(fdt, 0, NODENAME);
>>> +    if (offset < 0) {
>>> +        error_setg(errp, "Can't find node \"%s\": %s", NODENAME,
>>> +                   fdt_strerror(offset));
>>> +        goto out;
>>> +    }
>>> +
>>> +    phandle =3D fdt_get_phandle(spapr->fdt_blob, offset);
>>> +    if (phandle < 0) {
>>> +        error_setg(errp, "Can't get phandle of node \"%s\": %s",
>>> +                   NODENAME, fdt_strerror(phandle));
>>> +        goto out;
>>> +    }
>>> +
>>> +out:
>>> +    return phandle;
>>> +}
>>> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
>>> index 1da7a32348fc..ba0df9ae2e1b 100644
>>> --- a/hw/ppc/spapr_irq.c
>>> +++ b/hw/ppc/spapr_irq.c
>>> @@ -255,6 +255,7 @@ sPAPRIrq spapr_irq_xics =3D {
>>>      .post_load   =3D spapr_irq_post_load_xics,
>>>      .reset       =3D spapr_irq_reset_xics,
>>>      .set_irq     =3D spapr_irq_set_irq_xics,
>>> +    .get_phandle =3D spapr_get_phandle_xics,
>>>  };
>>> =20
>>>  /*
>>> @@ -411,6 +412,7 @@ sPAPRIrq spapr_irq_xive =3D {
>>>      .post_load   =3D spapr_irq_post_load_xive,
>>>      .reset       =3D spapr_irq_reset_xive,
>>>      .set_irq     =3D spapr_irq_set_irq_xive,
>>> +    .get_phandle =3D spapr_get_phandle_xive,
>>>  };
>>> =20
>>>  /*
>>> @@ -569,6 +571,13 @@ static void spapr_irq_set_irq_dual(void *opaque,=
 int srcno, int val)
>>>      spapr_irq_current(spapr)->set_irq(spapr, srcno, val);
>>>  }
>>> =20
>>> +static uint32_t spapr_irq_get_phandle_dual(sPAPRMachineState *spapr,=
 void *fdt,
>>> +                                           Error **errp)
>>> +{
>>> +    return spapr_irq_current(spapr)->get_phandle(spapr, fdt, errp);
>>> +}
>>> +
>>> +
>>>  /*
>>>   * Define values in sync with the XIVE and XICS backend
>>>   */
>>> @@ -589,7 +598,8 @@ sPAPRIrq spapr_irq_dual =3D {
>>>      .cpu_intc_create =3D spapr_irq_cpu_intc_create_dual,
>>>      .post_load   =3D spapr_irq_post_load_dual,
>>>      .reset       =3D spapr_irq_reset_dual,
>>> -    .set_irq     =3D spapr_irq_set_irq_dual
>>> +    .set_irq     =3D spapr_irq_set_irq_dual,
>>> +    .get_phandle =3D spapr_irq_get_phandle_dual,
>>>  };
>>> =20
>>>  /*
>>> @@ -706,4 +716,5 @@ sPAPRIrq spapr_irq_xics_legacy =3D {
>>>      .cpu_intc_create =3D spapr_irq_cpu_intc_create_xics,
>>>      .post_load   =3D spapr_irq_post_load_xics,
>>>      .set_irq     =3D spapr_irq_set_irq_xics,
>>> +    .get_phandle =3D spapr_get_phandle_xics,
>>>  };
>>> diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
>>> index 14b02c3aca33..990743a23582 100644
>>> --- a/include/hw/ppc/spapr_irq.h
>>> +++ b/include/hw/ppc/spapr_irq.h
>>> @@ -47,6 +47,7 @@ typedef struct sPAPRIrq {
>>>      int (*post_load)(sPAPRMachineState *spapr, int version_id);
>>>      void (*reset)(sPAPRMachineState *spapr, Error **errp);
>>>      void (*set_irq)(void *opaque, int srcno, int val);
>>> +    uint32_t (*get_phandle)(sPAPRMachineState *spapr, void *fdt, Err=
or **errp);
>>>  } sPAPRIrq;
>>> =20
>>>  extern sPAPRIrq spapr_irq_xics;
>>> diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.=
h
>>> index 7fdc25057420..53a34f14b258 100644
>>> --- a/include/hw/ppc/spapr_xive.h
>>> +++ b/include/hw/ppc/spapr_xive.h
>>> @@ -49,4 +49,6 @@ void spapr_dt_xive(sPAPRMachineState *spapr, uint32=
_t nr_servers, void *fdt,
>>>  void spapr_xive_set_tctx_os_cam(XiveTCTX *tctx);
>>>  void spapr_xive_mmio_set_enabled(sPAPRXive *xive, bool enable);
>>> =20
>>> +uint32_t spapr_get_phandle_xive(sPAPRMachineState *spapr, void *fdt,
>>> +                                Error **errp);
>>>  #endif /* PPC_SPAPR_XIVE_H */
>>> diff --git a/include/hw/ppc/xics_spapr.h b/include/hw/ppc/xics_spapr.=
h
>>> index b1ab27d022cf..8899c5346375 100644
>>> --- a/include/hw/ppc/xics_spapr.h
>>> +++ b/include/hw/ppc/xics_spapr.h
>>> @@ -31,6 +31,8 @@
>>> =20
>>>  void spapr_dt_xics(sPAPRMachineState *spapr, uint32_t nr_servers, vo=
id *fdt,
>>>                     uint32_t phandle);
>>> +uint32_t spapr_get_phandle_xics(sPAPRMachineState *spapr, void *fdt,
>>> +                                Error **errp);
>>>  int xics_kvm_init(sPAPRMachineState *spapr, Error **errp);
>>>  void xics_spapr_init(sPAPRMachineState *spapr);
>>> =20
>>>  =20
>>
>=20
