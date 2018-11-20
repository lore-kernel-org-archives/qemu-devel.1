Received: from eggs.gnu.org ([2001:4830:134:3::10]:40689)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <spopovyc@redhat.com>) id 1gPBEm-0002L6-Sv
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 13:59:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <spopovyc@redhat.com>) id 1gPBEh-00053N-Pv
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 13:59:04 -0500
References: <1542632978-65604-1-git-send-email-spopovyc@redhat.com>
	<20181119142719.3d702892@bahia.lan>
	<3411737e-824a-0653-024b-f46fe5695790@redhat.com>
	<20181119175908.5d3e1d4a@bahia.lan>
From: Serhii Popovych <spopovyc@redhat.com>
Message-ID: <576a1203-eb43-8c87-6865-51ffc2c6451b@redhat.com>
Date: Tue, 20 Nov 2018 20:58:45 +0200
MIME-Version: 1.0
In-Reply-To: <20181119175908.5d3e1d4a@bahia.lan>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="459z02zfEYnoBH63hpsBhkd7ZtX6PbeNk"
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
To: Greg Kurz <groug@kaod.org>, Laurent Vivier <lvivier@redhat.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, david@gibson.dropbear.id.au

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--459z02zfEYnoBH63hpsBhkd7ZtX6PbeNk
From: Serhii Popovych <spopovyc@redhat.com>
To: Greg Kurz <groug@kaod.org>, Laurent Vivier <lvivier@redhat.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, david@gibson.dropbear.id.au
Message-ID: <576a1203-eb43-8c87-6865-51ffc2c6451b@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH for 3.1] spapr: Fix ibm,
 max-associativity-domains property number of nodes
References: <1542632978-65604-1-git-send-email-spopovyc@redhat.com>
 <20181119142719.3d702892@bahia.lan>
 <3411737e-824a-0653-024b-f46fe5695790@redhat.com>
 <20181119175908.5d3e1d4a@bahia.lan>
In-Reply-To: <20181119175908.5d3e1d4a@bahia.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Greg Kurz wrote:
> On Mon, 19 Nov 2018 14:48:34 +0100
> Laurent Vivier <lvivier@redhat.com> wrote:
>=20
>> On 19/11/2018 14:27, Greg Kurz wrote:
>>> On Mon, 19 Nov 2018 08:09:38 -0500
>>> Serhii Popovych <spopovyc@redhat.com> wrote:
>>>  =20
>>>> Laurent Vivier reported off by one with maximum number of NUMA nodes=

>>>> provided by qemu-kvm being less by one than required according to
>>>> description of "ibm,max-associativity-domains" property in LoPAPR.
>>>>
>>>> It appears that I incorrectly treated LoPAPR description of this
>>>> property assuming it provides last valid domain (NUMA node here)
>>>> instead of maximum number of domains.
>>>>
>>>>   ### Before hot-add
>>>>
>>>>   (qemu) info numa
>>>>   3 nodes
>>>>   node 0 cpus: 0
>>>>   node 0 size: 0 MB
>>>>   node 0 plugged: 0 MB
>>>>   node 1 cpus:
>>>>   node 1 size: 1024 MB
>>>>   node 1 plugged: 0 MB
>>>>   node 2 cpus:
>>>>   node 2 size: 0 MB
>>>>   node 2 plugged: 0 MB
>>>>
>>>>   $ numactl -H
>>>>   available: 2 nodes (0-1)
>>>>   node 0 cpus: 0
>>>>   node 0 size: 0 MB
>>>>   node 0 free: 0 MB
>>>>   node 1 cpus:
>>>>   node 1 size: 999 MB
>>>>   node 1 free: 658 MB
>>>>   node distances:
>>>>   node   0   1
>>>>     0:  10  40
>>>>     1:  40  10
>>>>
>>>>   ### Hot-add
>>>>
>>>>   (qemu) object_add memory-backend-ram,id=3Dmem0,size=3D1G
>>>>   (qemu) device_add pc-dimm,id=3Ddimm1,memdev=3Dmem0,node=3D2
>>>>   (qemu) [   87.704898] pseries-hotplug-mem: Attempting to hot-add 4=
 ...
>>>>   <there is no "Initmem setup node 2 [mem 0xHEX-0xHEX]">
>>>>   [   87.705128] lpar: Attempting to resize HPT to shift 21
>>>>   ... <HPT resize messages>
>>>>
>>>>   ### After hot-add
>>>>
>>>>   (qemu) info numa
>>>>   3 nodes
>>>>   node 0 cpus: 0
>>>>   node 0 size: 0 MB
>>>>   node 0 plugged: 0 MB
>>>>   node 1 cpus:
>>>>   node 1 size: 1024 MB
>>>>   node 1 plugged: 0 MB
>>>>   node 2 cpus:
>>>>   node 2 size: 1024 MB
>>>>   node 2 plugged: 1024 MB
>>>>
>>>>   $ numactl -H
>>>>   available: 2 nodes (0-1)
>>>>   ^^^^^^^^^^^^^^^^^^^^^^^^
>>>>              Still only two nodes (and memory hot-added to node 0 be=
low)
>>>>   node 0 cpus: 0
>>>>   node 0 size: 1024 MB
>>>>   node 0 free: 1021 MB
>>>>   node 1 cpus:
>>>>   node 1 size: 999 MB
>>>>   node 1 free: 658 MB
>>>>   node distances:
>>>>   node   0   1
>>>>     0:  10  40
>>>>     1:  40  10
>>>>
>>>> After fix applied numactl(8) reports 3 nodes available and memory
>>>> plugged into node 2 as expected.
>>>>
>>>> Fixes: da9f80fbad21 ("spapr: Add ibm,max-associativity-domains prope=
rty")
>>>> Reported-by: Laurent Vivier <lvivier@redhat.com>
>>>> Signed-off-by: Serhii Popovych <spopovyc@redhat.com>
>>>> ---
>>>>  hw/ppc/spapr.c | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>>>> index 7afd1a1..843ae6c 100644
>>>> --- a/hw/ppc/spapr.c
>>>> +++ b/hw/ppc/spapr.c
>>>> @@ -1033,7 +1033,7 @@ static void spapr_dt_rtas(sPAPRMachineState *s=
papr, void *fdt)
>>>>          cpu_to_be32(0),
>>>>          cpu_to_be32(0),
>>>>          cpu_to_be32(0),
>>>> -        cpu_to_be32(nb_numa_nodes ? nb_numa_nodes - 1 : 0),
>>>> +        cpu_to_be32(nb_numa_nodes ? nb_numa_nodes : 0), =20
>>>
>>> Maybe simply cpu_to_be32(nb_numa_nodes) ? =20
>>
>> Or "cpu_to_be32(nb_numa_nodes ? nb_numa_nodes : 1)" ?

Linux handles zero correctly, but nb_numa_nodes ?: 1 looks better.

I did testing with just cpu_to_be32(nb_numa_nodes) and
cpu_to_be32(nb_numa_nodes ? nb_numa_nodes : 1) it works with Linux
correctly in both cases

(guest)# numactl -H
available: 1 nodes (0)
node 0 cpus: 0
node 0 size: 487 MB
node 0 free: 148 MB
node distances:
node   0
  0:  10

(qemu) info numa
0 nodes

>>
>> In spapr_populate_drconf_memory() we have this logic.
>>
>=20
> Hmm... maybe you're right, it seems that the code assumes
> non-NUMA configs have at one node. Similar assumption is
> also present in pc_dimm_realize():
>=20
>     if (((nb_numa_nodes > 0) && (dimm->node >=3D nb_numa_nodes)) ||
>         (!nb_numa_nodes && dimm->node))=20
According to this nb_numa_nodes can be zero

>         error_setg(errp, "'DIMM property " PC_DIMM_NODE_PROP " has valu=
e %"
>                    PRIu32 "' which exceeds the number of numa nodes: %d=
",
>                    dimm->node, nb_numa_nodes ? nb_numa_nodes : 1);
and this just handles this case to show proper error message.

>         return;
>     }

>=20
> This is a bit confusing...
>=20
>> Thanks,
>> Laurent
>=20
>=20


--=20
Thanks,
Serhii


--459z02zfEYnoBH63hpsBhkd7ZtX6PbeNk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAEBAgAGBQJb9FltAAoJEBTawMmQ61bBHJkH/RMRKibqLxxdIYRFLIUm/+pX
XW5p9VtYjPFGXuU7RnEUET4GYqYpq0kat6guxfF23led3qRVEvbRHnVqFsnOJptt
vfG5ZiakbKkGKX0zsygu/kHac+HqPWD/qPEtdmk3Yb6DlkBqftgo+js4ti3dYVXM
1Kw6Q/EtIwM/UJq2tveAtoB3wkaCPw53D62v9ai4hpokue9huisqUEiB6e8BY/18
HFczqM8OyxlFB9606n36/ck1W191RvxIldZmjVA67G9vjPkGmuNJUPbkF0021rs1
Vsc2OYPq2BnwrHvIiMmgjj8sTuhiFUhoJkG1vGjjWt+rrAnFaqahm3Y2D4vQB4s=
=5i//
-----END PGP SIGNATURE-----

--459z02zfEYnoBH63hpsBhkd7ZtX6PbeNk--
