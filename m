Received: from eggs.gnu.org ([209.51.188.92]:41744)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gjlV8-0002Rk-0e
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 08:45:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gjlV6-0002oL-Pl
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 08:45:01 -0500
References: <1547194672-24169-1-git-send-email-thuth@redhat.com>
	<1547194672-24169-3-git-send-email-thuth@redhat.com>
	<7d949380-e8e5-c5bd-1fd4-e87f3106e7f2@kaod.org>
	<186ccbfa-0797-25bb-453c-74c9ace0e4d5@redhat.com>
	<20190116142336.54a542a2@bahia.lan>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <56bbae76-7975-3aa2-3fee-922fa4d24454@redhat.com>
Date: Wed, 16 Jan 2019 14:44:55 +0100
MIME-Version: 1.0
In-Reply-To: <20190116142336.54a542a2@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 2/3] ppc: Fix duplicated typedefs to be
 able to compile with Clang in gnu99 mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, qemu-devel@nongnu.org, "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, pbonzini@redhat.com, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

On 2019-01-16 14:23, Greg Kurz wrote:
> On Wed, 16 Jan 2019 12:47:36 +0100
> Thomas Huth <thuth@redhat.com> wrote:
>=20
>> On 2019-01-16 12:43, C=C3=A9dric Le Goater wrote:
>>> On 1/11/19 9:17 AM, Thomas Huth wrote: =20
>>>> When compiling the ppc code with clang and -std=3Dgnu99, there are a
>>>> couple of warnings/errors like this one:
>>>>
>>>>   CC      ppc64-softmmu/hw/intc/xics.o
>>>> In file included from hw/intc/xics.c:35:
>>>> include/hw/ppc/xics.h:43:25: error: redefinition of typedef 'ICPStat=
e' is a C11 feature
>>>>       [-Werror,-Wtypedef-redefinition]
>>>> typedef struct ICPState ICPState;
>>>>                         ^
>>>> target/ppc/cpu.h:1181:25: note: previous definition is here
>>>> typedef struct ICPState ICPState;
>>>>                         ^
>>>> Work around the problems by including the proper headers instead. =20
>>>
>>> Thomas,
>>>
>>>
>>> After a closer look, I think we should use 'void *' under PowerPCCPU=20
>>> as it was the case before I introduced the second interrupt presenter=
. =20
>>
>> If you don't like the #includes, why not simply do anonymous struct
>> forward declarations here? I think that would be better than "void *".
>>
>=20
> That's questionable. These two fields are only used by the machine code=
 and
> the interrupt controller code.
>=20
> $ git grep -E '(icp|tctx)' target/ppc/
> target/ppc/cpu.h:    ICPState *icp;
> target/ppc/cpu.h:    XiveTCTX *tctx;
>=20
> $ git grep -E 'cpu\->(icp|tctx)'=20
> hw/intc/spapr_xive_kvm.c:        kvmppc_xive_cpu_set_state(cpu->tctx, &=
local_err);
> hw/intc/spapr_xive_kvm.c:        kvmppc_xive_cpu_connect(cpu->tctx, &lo=
cal_err);
> hw/intc/xics_kvm.c:        icp_kvm_connect(cpu->icp, &local_err);
> hw/intc/xics_kvm.c:        icp_set_kvm_state(cpu->icp, 1);
> hw/intc/xics_spapr.c:    icp_set_cppr(cpu->icp, cppr);
> hw/intc/xics_spapr.c:    uint32_t xirr =3D icp_accept(cpu->icp);
> hw/intc/xics_spapr.c:    uint32_t xirr =3D icp_accept(cpu->icp);
> hw/intc/xics_spapr.c:    icp_eoi(cpu->icp, xirr);
> hw/intc/xics_spapr.c:    uint32_t xirr =3D icp_ipoll(cpu->icp, &mfrr);
> hw/intc/xive.c:    XiveTCTX *tctx =3D cpu->tctx;
> hw/intc/xive.c:    XiveTCTX *tctx =3D cpu->tctx;
> hw/intc/xive.c:        XiveTCTX *tctx =3D cpu->tctx;
> hw/ppc/pnv.c:    cpu->icp =3D ICP(obj);
> hw/ppc/pnv.c:    return cpu ? cpu->icp : NULL;
> hw/ppc/pnv.c:        icp_pic_print_info(cpu->icp, mon);
> hw/ppc/pnv_core.c:    object_unparent(OBJECT(cpu->icp));
> hw/ppc/spapr.c:    return cpu ? cpu->icp : NULL;
> hw/ppc/spapr_cpu_core.c:    if (cpu->icp) {
> hw/ppc/spapr_cpu_core.c:        object_unparent(OBJECT(cpu->icp));
> hw/ppc/spapr_cpu_core.c:    if (cpu->tctx) {
> hw/ppc/spapr_cpu_core.c:        object_unparent(OBJECT(cpu->tctx));
> hw/ppc/spapr_irq.c:        icp_pic_print_info(cpu->icp, mon);
> hw/ppc/spapr_irq.c:    cpu->icp =3D ICP(obj);
> hw/ppc/spapr_irq.c:            icp_resend(cpu->icp);
> hw/ppc/spapr_irq.c:        xive_tctx_pic_print_info(cpu->tctx, mon);
> hw/ppc/spapr_irq.c:    cpu->tctx =3D XIVE_TCTX(obj);
> hw/ppc/spapr_irq.c:    spapr_xive_set_tctx_os_cam(cpu->tctx);
> hw/ppc/spapr_irq.c:        spapr_xive_set_tctx_os_cam(cpu->tctx);
> hw/ppc/spapr_irq.c:        spapr_xive_set_tctx_os_cam(cpu->tctx);
>=20
> It thus looks wrong to expose their type in target/ppc/cpu.h. I guess
> they should be hidden behind an opaque data pointer (maybe the existing
> void *machine_data ?)

While that's maybe cleaner at a quick glance first, you still have to
deal with the fact that it's used by two different machines (pseries and
pnv) ... not sure whether that easily distinguishable in xive.c for examp=
le?

 Thomas
