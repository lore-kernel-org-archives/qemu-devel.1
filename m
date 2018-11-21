Received: from eggs.gnu.org ([2001:4830:134:3::10]:44629)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gPT1Z-0001RS-Km
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 08:58:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gPT1W-0005oy-U8
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 08:58:37 -0500
Received: from 8.mo3.mail-out.ovh.net ([87.98.172.249]:34363)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1gPT1W-0005Tq-N1
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 08:58:34 -0500
Received: from player737.ha.ovh.net (unknown [10.109.160.217])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id 2B1DA1E9481
	for <qemu-devel@nongnu.org>; Wed, 21 Nov 2018 14:58:27 +0100 (CET)
Date: Wed, 21 Nov 2018 14:58:18 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20181121145818.5dbe5fbb@bahia.lan>
In-Reply-To: <576a1203-eb43-8c87-6865-51ffc2c6451b@redhat.com>
References: <1542632978-65604-1-git-send-email-spopovyc@redhat.com>
	<20181119142719.3d702892@bahia.lan>
	<3411737e-824a-0653-024b-f46fe5695790@redhat.com>
	<20181119175908.5d3e1d4a@bahia.lan>
	<576a1203-eb43-8c87-6865-51ffc2c6451b@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	boundary="Sig_/hrxru3.AesxmHuWv21RGbti";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH for 3.1] spapr: Fix ibm,
 max-associativity-domains property number of nodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Serhii Popovych <spopovyc@redhat.com>
Cc: Laurent Vivier <lvivier@redhat.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, david@gibson.dropbear.id.au

--Sig_/hrxru3.AesxmHuWv21RGbti
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 20 Nov 2018 20:58:45 +0200
Serhii Popovych <spopovyc@redhat.com> wrote:

> Greg Kurz wrote:
> > On Mon, 19 Nov 2018 14:48:34 +0100
> > Laurent Vivier <lvivier@redhat.com> wrote:
> >  =20
> >> On 19/11/2018 14:27, Greg Kurz wrote: =20
> >>> On Mon, 19 Nov 2018 08:09:38 -0500
> >>> Serhii Popovych <spopovyc@redhat.com> wrote:
> >>>    =20
> >>>> Laurent Vivier reported off by one with maximum number of NUMA nodes
> >>>> provided by qemu-kvm being less by one than required according to
> >>>> description of "ibm,max-associativity-domains" property in LoPAPR.
> >>>>
> >>>> It appears that I incorrectly treated LoPAPR description of this
> >>>> property assuming it provides last valid domain (NUMA node here)
> >>>> instead of maximum number of domains.
> >>>>
> >>>>   ### Before hot-add
> >>>>
> >>>>   (qemu) info numa
> >>>>   3 nodes
> >>>>   node 0 cpus: 0
> >>>>   node 0 size: 0 MB
> >>>>   node 0 plugged: 0 MB
> >>>>   node 1 cpus:
> >>>>   node 1 size: 1024 MB
> >>>>   node 1 plugged: 0 MB
> >>>>   node 2 cpus:
> >>>>   node 2 size: 0 MB
> >>>>   node 2 plugged: 0 MB
> >>>>
> >>>>   $ numactl -H
> >>>>   available: 2 nodes (0-1)
> >>>>   node 0 cpus: 0
> >>>>   node 0 size: 0 MB
> >>>>   node 0 free: 0 MB
> >>>>   node 1 cpus:
> >>>>   node 1 size: 999 MB
> >>>>   node 1 free: 658 MB
> >>>>   node distances:
> >>>>   node   0   1
> >>>>     0:  10  40
> >>>>     1:  40  10
> >>>>
> >>>>   ### Hot-add
> >>>>
> >>>>   (qemu) object_add memory-backend-ram,id=3Dmem0,size=3D1G
> >>>>   (qemu) device_add pc-dimm,id=3Ddimm1,memdev=3Dmem0,node=3D2
> >>>>   (qemu) [   87.704898] pseries-hotplug-mem: Attempting to hot-add 4=
 ...
> >>>>   <there is no "Initmem setup node 2 [mem 0xHEX-0xHEX]">
> >>>>   [   87.705128] lpar: Attempting to resize HPT to shift 21
> >>>>   ... <HPT resize messages>
> >>>>
> >>>>   ### After hot-add
> >>>>
> >>>>   (qemu) info numa
> >>>>   3 nodes
> >>>>   node 0 cpus: 0
> >>>>   node 0 size: 0 MB
> >>>>   node 0 plugged: 0 MB
> >>>>   node 1 cpus:
> >>>>   node 1 size: 1024 MB
> >>>>   node 1 plugged: 0 MB
> >>>>   node 2 cpus:
> >>>>   node 2 size: 1024 MB
> >>>>   node 2 plugged: 1024 MB
> >>>>
> >>>>   $ numactl -H
> >>>>   available: 2 nodes (0-1)
> >>>>   ^^^^^^^^^^^^^^^^^^^^^^^^
> >>>>              Still only two nodes (and memory hot-added to node 0 be=
low)
> >>>>   node 0 cpus: 0
> >>>>   node 0 size: 1024 MB
> >>>>   node 0 free: 1021 MB
> >>>>   node 1 cpus:
> >>>>   node 1 size: 999 MB
> >>>>   node 1 free: 658 MB
> >>>>   node distances:
> >>>>   node   0   1
> >>>>     0:  10  40
> >>>>     1:  40  10
> >>>>
> >>>> After fix applied numactl(8) reports 3 nodes available and memory
> >>>> plugged into node 2 as expected.
> >>>>
> >>>> Fixes: da9f80fbad21 ("spapr: Add ibm,max-associativity-domains prope=
rty")
> >>>> Reported-by: Laurent Vivier <lvivier@redhat.com>
> >>>> Signed-off-by: Serhii Popovych <spopovyc@redhat.com>
> >>>> ---
> >>>>  hw/ppc/spapr.c | 2 +-
> >>>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> >>>> index 7afd1a1..843ae6c 100644
> >>>> --- a/hw/ppc/spapr.c
> >>>> +++ b/hw/ppc/spapr.c
> >>>> @@ -1033,7 +1033,7 @@ static void spapr_dt_rtas(sPAPRMachineState *s=
papr, void *fdt)
> >>>>          cpu_to_be32(0),
> >>>>          cpu_to_be32(0),
> >>>>          cpu_to_be32(0),
> >>>> -        cpu_to_be32(nb_numa_nodes ? nb_numa_nodes - 1 : 0),
> >>>> +        cpu_to_be32(nb_numa_nodes ? nb_numa_nodes : 0),   =20
> >>>
> >>> Maybe simply cpu_to_be32(nb_numa_nodes) ?   =20
> >>
> >> Or "cpu_to_be32(nb_numa_nodes ? nb_numa_nodes : 1)" ? =20
>=20
> Linux handles zero correctly, but nb_numa_nodes ?: 1 looks better.
>=20
> I did testing with just cpu_to_be32(nb_numa_nodes) and
> cpu_to_be32(nb_numa_nodes ? nb_numa_nodes : 1) it works with Linux
> correctly in both cases
>=20
> (guest)# numactl -H
> available: 1 nodes (0)
> node 0 cpus: 0
> node 0 size: 487 MB
> node 0 free: 148 MB
> node distances:
> node   0
>   0:  10
>=20
> (qemu) info numa
> 0 nodes
>=20
> >>
> >> In spapr_populate_drconf_memory() we have this logic.
> >> =20
> >=20
> > Hmm... maybe you're right, it seems that the code assumes
> > non-NUMA configs have at one node. Similar assumption is
> > also present in pc_dimm_realize():
> >=20
> >     if (((nb_numa_nodes > 0) && (dimm->node >=3D nb_numa_nodes)) ||
> >         (!nb_numa_nodes && dimm->node))  =20
> According to this nb_numa_nodes can be zero
>=20
> >         error_setg(errp, "'DIMM property " PC_DIMM_NODE_PROP " has valu=
e %"
> >                    PRIu32 "' which exceeds the number of numa nodes: %d=
",
> >                    dimm->node, nb_numa_nodes ? nb_numa_nodes : 1); =20
> and this just handles this case to show proper error message.
>=20

Indeed but it doesn't really explain why we're doing this...

> >         return;
> >     } =20
>=20
> >=20
> > This is a bit confusing...

... fortunately, these commits shed some light:

commit 7db8a127e373e468d1f61e46e01e50d1aa33e827
Author: Alexey Kardashevskiy <aik@ozlabs.ru>
Date:   Thu Jul 3 13:10:04 2014 +1000

    spapr: Refactor spapr_populate_memory() to allow memoryless nodes
   =20
    Current QEMU does not support memoryless NUMA nodes, however
    actual hardware may have them so it makes sense to have a way
    to emulate them in QEMU. This prepares SPAPR for that.
   =20
    This moves 2 calls of spapr_populate_memory_node() into
    the existing loop over numa nodes so first several nodes may
    have no memory and this still will work.
   =20
    If there is no numa configuration, the code assumes there is just
    a single node at 0 and it has all the guest memory.
   =20
    Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
    Signed-off-by: Alexander Graf <agraf@suse.de>


commit 6663864e950d40c467ae4ab81c4dac64d7a8d9e6
Author: Bharata B Rao <bharata@linux.vnet.ibm.com>
Date:   Mon Aug 3 11:05:40 2015 +0530

    spapr: Populate ibm,associativity-lookup-arrays correctly for non-NUMA

    When NUMA isn't configured explicitly, assume node 0 is present for
    the purpose of creating ibm,associativity-lookup-arrays property
    under ibm,dynamic-reconfiguration-memory DT node. This ensures that
    the associativity index property is correctly updated in ibm,dynamic-me=
mory
    for the LMB that is hotplugged.
   =20
    Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
    Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
    Signed-off-by: David Gibson <david@gibson.dropbear.id.au>


So I guess ?: 1 is consistent with the longstanding assumption in spapr=20
that the machine always has a "node 0", even for non-NUMA setups.

Maybe this logic should be consolidated in some helper for better
clarity.

> >  =20
> >> Thanks,
> >> Laurent =20
> >=20
> >  =20
>=20
>=20


--Sig_/hrxru3.AesxmHuWv21RGbti
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEtIKLr5QxQM7yo0kQcdTV5YIvc9YFAlv1ZHoACgkQcdTV5YIv
c9bm0xAAqSsVO6KLfkIslWu9TPjh90j+aEyI12tiu6ioCVNpQczJtnuPn0NIZi23
jllnW+HbZ2agdDD/hWLKpa1frzzu9sPA5lVV0Z8kwocSCxX59tqOdazmTZrj7EDE
q/wLqwTIuF1bT9Ex5i9iY0EyfPcCBHm3VJAlzXkhg4K8ghLgn6XtqTCwdtx8zdVA
BFEQHtx0WYsxmRK1fxryiCkNuumOpaDc+T+bLVGDidWKm/U0Lp6rPH5Kq7kUm9bT
dl3YOUZsydLzrAt7kzDzK0rdsQbfV+vjPMgTpDrr8iffsX4QGe2vlHBjrW8FRjZ0
59bk+Zk9MJcQR19/JjWGz0JgyFvgVTy7TwW0UiBQ5cXOw7ahf5X0XbaCUAox5/r0
ADzdgO5bBq9z02HkikhceN1iKprWxA8BtLX+KKJ5gz6GSJE3XQrtRchJQqR927jK
Nta0N8HgyQ0qrKUOAmx7B0EMZjyMYViMWrYeFhJHSrxMGUVcu+bKgbMPWH7EhniF
aVT3014TbOAsmRKBP7TJp+dBMyVK5Vw9sduK3JACe5IHAFmgsM0wNSbk1FHj5j7B
URvs6Gfj2AXG8vOlvc+Y0NHV5TOOvbKj+3p63fGME7sGspuGRuNuALzKYqraHeYa
UcbLBPhMYPYNaYuET165ry8f8JBWygVDcHo35cMIMkOldi3SRPs=
=3Hth
-----END PGP SIGNATURE-----

--Sig_/hrxru3.AesxmHuWv21RGbti--
