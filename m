Received: from eggs.gnu.org ([209.51.188.92]:36438)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gm1Tp-0000ax-Dr
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 14:13:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gm1Tm-00045G-UJ
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 14:13:01 -0500
Received: from 2.mo5.mail-out.ovh.net ([178.33.109.111]:40768)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gm1Tm-0003e0-JZ
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 14:12:58 -0500
Received: from player770.ha.ovh.net (unknown [10.109.143.183])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id BAAB920E47A
	for <qemu-devel@nongnu.org>; Tue, 22 Jan 2019 15:27:05 +0100 (CET)
References: <154774526588.1208625.11295698301887807297.stgit@bahia.lan>
	<154774536496.1208625.12823909967079119637.stgit@bahia.lan>
	<f132cca0-c163-6791-75e0-25783578263a@kaod.org>
	<20190122142748.6d9a6691@bahia.lan>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <6b9cb7a1-ff6a-6a8a-dde4-c72008b7f032@kaod.org>
Date: Tue, 22 Jan 2019 15:26:45 +0100
MIME-Version: 1.0
In-Reply-To: <20190122142748.6d9a6691@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 15/19] spapr_xive: Cache device tree
 nodename in sPAPRXive
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

On 1/22/19 2:27 PM, Greg Kurz wrote:
> On Fri, 18 Jan 2019 14:38:31 +0100
> C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>=20
>> On 1/17/19 6:16 PM, Greg Kurz wrote:
>>> PHB hotplug will need to know the name of the XIVE controller node. S=
ince
>>> it is an invariant for the machine lifetime, compute it at realize an=
d
>>> store it under the sPAPRXive structure. =20
>> Could you please gather all these changes [15-17] in one patch. It wou=
ld=20
>> be easier to track.=20
>>
>=20
> I'll do that in v4.
>=20
>>> Signed-off-by: Greg Kurz <groug@kaod.org>
>>> ---
>>>  hw/intc/spapr_xive.c        |    9 ++++-----
>>>  include/hw/ppc/spapr_xive.h |    3 +++
>>>  2 files changed, 7 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
>>> index e542ae59d7fd..9732c3d89c77 100644
>>> --- a/hw/intc/spapr_xive.c
>>> +++ b/hw/intc/spapr_xive.c
>>> @@ -316,6 +316,9 @@ static void spapr_xive_realize(DeviceState *dev, =
Error **errp)
>>>      /* Map all regions */
>>>      spapr_xive_map_mmio(xive);
>>> =20
>>> +    xive->nodename =3D g_strdup_printf("interrupt-controller@%" PRIx=
64,
>>> +                           xive->tm_base + XIVE_TM_USER_PAGE * (1 <<=
 TM_SHIFT)); =20
>>
>> I would use a helper routine instead.
>> =20
>=20
> Ok, I see your suggestion to put the name in a static. Well, it would w=
ork
> as long as we only have one interrupt controller around. It is the case=
 now
> but could this change in the future ? If not then I'm perfectly fine wi=
th
> your suggestions, otherwise I guess the nodename should be under sPAPRX=
ive.

Well, I am not sure it's worth extending SPAPRXive for a name that can=20
be computed. Using a static is probably not a better solution.=20

Maybe return the node offset instead. See pnv_chip_isa_offset() in pnv.c=20
for a similar issue.

Thanks,

C.=20

>=20
>>>      qemu_register_reset(spapr_xive_reset, dev);
>>>  }
>>> =20
>>> @@ -1436,7 +1439,6 @@ int spapr_dt_xive(sPAPRMachineState *spapr, uin=
t32_t nr_servers, void *fdt)
>>>          cpu_to_be32(7),    /* start */
>>>          cpu_to_be32(0xf8), /* count */
>>>      };
>>> -    gchar *nodename;
>>> =20
>>>      /*
>>>       * The "ibm,plat-res-int-priorities" property defines the priori=
ty
>>> @@ -1453,10 +1455,7 @@ int spapr_dt_xive(sPAPRMachineState *spapr, ui=
nt32_t nr_servers, void *fdt)
>>>                             XIVE_TM_OS_PAGE * (1ull << TM_SHIFT));
>>>      timas[3] =3D cpu_to_be64(1ull << TM_SHIFT);
>>> =20
>>> -    nodename =3D g_strdup_printf("interrupt-controller@%" PRIx64,
>>> -                           xive->tm_base + XIVE_TM_USER_PAGE * (1 <<=
 TM_SHIFT));
>>> -    _FDT(node =3D fdt_add_subnode(fdt, 0, nodename));
>>> -    g_free(nodename);
>>> +    _FDT(node =3D fdt_add_subnode(fdt, 0, xive->nodename)); =20
>>
>> and use the helper routine here.
>>
>>>      _FDT(fdt_setprop_string(fdt, node, "device_type", "power-ivpe"))=
;
>>>      _FDT(fdt_setprop(fdt, node, "reg", timas, sizeof(timas)));
>>> diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.=
h
>>> index 29dafead9ba0..deea34b03ee5 100644
>>> --- a/include/hw/ppc/spapr_xive.h
>>> +++ b/include/hw/ppc/spapr_xive.h
>>> @@ -26,6 +26,9 @@ typedef struct sPAPRXive {
>>>      XiveENDSource end_source;
>>>      hwaddr        end_base;
>>> =20
>>> +    /* DT */
>>> +    gchar *nodename; =20
>>
>> I don't think this is needed. See other patches for why.
>>
>> Thanks,
>>
>> C.
>> =20
>>>
>>>      /* Routing table */
>>>      XiveEAS       *eat;
>>>      uint32_t      nr_irqs;
>>>  =20
>>
>=20
