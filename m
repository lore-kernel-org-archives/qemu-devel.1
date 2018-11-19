Received: from eggs.gnu.org ([2001:4830:134:3::10]:51740)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <spopovyc@redhat.com>) id 1gOmFz-000842-Jn
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 11:18:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <spopovyc@redhat.com>) id 1gOmFu-0007KU-HZ
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 11:18:39 -0500
References: <1542632978-65604-1-git-send-email-spopovyc@redhat.com>
	<20181119142719.3d702892@bahia.lan>
	<6ff0a235-0136-63b6-dd6a-cd78f656ca0e@redhat.com>
From: Serhii Popovych <spopovyc@redhat.com>
Message-ID: <13c0668b-6a38-6fad-c80d-4465fda88cb9@redhat.com>
Date: Mon, 19 Nov 2018 18:18:04 +0200
MIME-Version: 1.0
In-Reply-To: <6ff0a235-0136-63b6-dd6a-cd78f656ca0e@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="ZlvIlAJ6GBo5bMhDtEZspMhYgdgBe7zMO"
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
To: Laurent Vivier <lvivier@redhat.com>, Greg Kurz <groug@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, david@gibson.dropbear.id.au

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ZlvIlAJ6GBo5bMhDtEZspMhYgdgBe7zMO
From: Serhii Popovych <spopovyc@redhat.com>
To: Laurent Vivier <lvivier@redhat.com>, Greg Kurz <groug@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, david@gibson.dropbear.id.au
Message-ID: <13c0668b-6a38-6fad-c80d-4465fda88cb9@redhat.com>
Subject: Re: [Qemu-ppc] [PATCH for 3.1] spapr: Fix ibm,
 max-associativity-domains property number of nodes
References: <1542632978-65604-1-git-send-email-spopovyc@redhat.com>
 <20181119142719.3d702892@bahia.lan>
 <6ff0a235-0136-63b6-dd6a-cd78f656ca0e@redhat.com>
In-Reply-To: <6ff0a235-0136-63b6-dd6a-cd78f656ca0e@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Laurent Vivier wrote:
> On 19/11/2018 14:27, Greg Kurz wrote:
>> On Mon, 19 Nov 2018 08:09:38 -0500
>> Serhii Popovych <spopovyc@redhat.com> wrote:
>>
>>> Laurent Vivier reported off by one with maximum number of NUMA nodes
>>> provided by qemu-kvm being less by one than required according to
>>> description of "ibm,max-associativity-domains" property in LoPAPR.
>>>
>>> It appears that I incorrectly treated LoPAPR description of this
>>> property assuming it provides last valid domain (NUMA node here)
>>> instead of maximum number of domains.
>>>
>>>   ### Before hot-add
>>>
>>>   (qemu) info numa
>>>   3 nodes
>>>   node 0 cpus: 0
>>>   node 0 size: 0 MB
>>>   node 0 plugged: 0 MB
>>>   node 1 cpus:
>>>   node 1 size: 1024 MB
>>>   node 1 plugged: 0 MB
>>>   node 2 cpus:
>>>   node 2 size: 0 MB
>>>   node 2 plugged: 0 MB
>>>
>>>   $ numactl -H
>>>   available: 2 nodes (0-1)
>>>   node 0 cpus: 0
>>>   node 0 size: 0 MB
>>>   node 0 free: 0 MB
>>>   node 1 cpus:
>>>   node 1 size: 999 MB
>>>   node 1 free: 658 MB
>>>   node distances:
>>>   node   0   1
>>>     0:  10  40
>>>     1:  40  10
>>>
>>>   ### Hot-add
>>>
>>>   (qemu) object_add memory-backend-ram,id=3Dmem0,size=3D1G
>>>   (qemu) device_add pc-dimm,id=3Ddimm1,memdev=3Dmem0,node=3D2
>>>   (qemu) [   87.704898] pseries-hotplug-mem: Attempting to hot-add 4 =
=2E..
>>>   <there is no "Initmem setup node 2 [mem 0xHEX-0xHEX]">
>>>   [   87.705128] lpar: Attempting to resize HPT to shift 21
>>>   ... <HPT resize messages>
>>>
>>>   ### After hot-add
>>>
>>>   (qemu) info numa
>>>   3 nodes
>>>   node 0 cpus: 0
>>>   node 0 size: 0 MB
>>>   node 0 plugged: 0 MB
>>>   node 1 cpus:
>>>   node 1 size: 1024 MB
>>>   node 1 plugged: 0 MB
>>>   node 2 cpus:
>>>   node 2 size: 1024 MB
>>>   node 2 plugged: 1024 MB
>>>
>>>   $ numactl -H
>>>   available: 2 nodes (0-1)
>>>   ^^^^^^^^^^^^^^^^^^^^^^^^
>>>              Still only two nodes (and memory hot-added to node 0 bel=
ow)
>>>   node 0 cpus: 0
>>>   node 0 size: 1024 MB
>>>   node 0 free: 1021 MB
>>>   node 1 cpus:
>>>   node 1 size: 999 MB
>>>   node 1 free: 658 MB
>>>   node distances:
>>>   node   0   1
>>>     0:  10  40
>>>     1:  40  10
>>>
>>> After fix applied numactl(8) reports 3 nodes available and memory
>>> plugged into node 2 as expected.
>>>
>>> Fixes: da9f80fbad21 ("spapr: Add ibm,max-associativity-domains proper=
ty")
>>> Reported-by: Laurent Vivier <lvivier@redhat.com>
>>> Signed-off-by: Serhii Popovych <spopovyc@redhat.com>
>>> ---
>>>  hw/ppc/spapr.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>>> index 7afd1a1..843ae6c 100644
>>> --- a/hw/ppc/spapr.c
>>> +++ b/hw/ppc/spapr.c
>>> @@ -1033,7 +1033,7 @@ static void spapr_dt_rtas(sPAPRMachineState *sp=
apr, void *fdt)
>>>          cpu_to_be32(0),
>>>          cpu_to_be32(0),
>>>          cpu_to_be32(0),
>>> -        cpu_to_be32(nb_numa_nodes ? nb_numa_nodes - 1 : 0),
>>> +        cpu_to_be32(nb_numa_nodes ? nb_numa_nodes : 0),
>>
>> Maybe simply cpu_to_be32(nb_numa_nodes) ?
>=20
> I agree the "? : " is not needed.
>=20
> With "cpu_to_be32(nb_numa_nodes)":
>=20

Agree, ?: was relevant only to catch -1 case when running guest w/o NUMA
config. Will send v2. Thanks for quick review.

> Reviewed-by: Laurent Vivier <lvivier@redhat.com>
>=20
> Thanks,
> Laurent
>=20


--=20
Thanks,
Serhii


--ZlvIlAJ6GBo5bMhDtEZspMhYgdgBe7zMO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAEBAgAGBQJb8uJUAAoJEBTawMmQ61bBSyAH/1wqB2kNy3Q6x1VATjkRaDj6
75/oHBpPXmFElIBMopLOWUPF8HtcBhsXlZLjeWN2F7QtFBunvW4ZgK9SqXQw5dHy
3uJrgWAg8vnWhMl7MWS1kQUKY/QieosaDJdkNRGHhVAz2v0jBZD9Dx6R5R67U/0u
fCmxGLyOSY3Px9GavHOOhkdpTmKHI6LzMSLciJ4owY2RVDQjtil9RIL32pQptM7h
wdaJMt8/3kbujByAR7+UinrqsaLIvmXTR3OvPKVEnBO+0UUn1+Dw2/4rBX5vMzNN
mgab8dKQi2Dh8/1gdFruR8f+jcTsEXQ8R8o2J/5WDRZmkoc2nXe+Z3coe4l0ftU=
=TlDF
-----END PGP SIGNATURE-----

--ZlvIlAJ6GBo5bMhDtEZspMhYgdgBe7zMO--
