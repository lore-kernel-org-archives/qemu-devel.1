Received: from eggs.gnu.org ([2001:4830:134:3::10]:52374)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <spopovyc@redhat.com>) id 1f87II-0006jm-Qu
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 12:47:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <spopovyc@redhat.com>) id 1f87IH-0003LZ-QM
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 12:47:54 -0400
References: <1523472120-56496-1-git-send-email-spopovyc@redhat.com>
	<1523472120-56496-2-git-send-email-spopovyc@redhat.com>
	<20180413075739.GC14855@in.ibm.com>
From: Serhii Popovych <spopovyc@redhat.com>
Message-ID: <e651fb40-2e44-73ed-6082-d9e497073e69@redhat.com>
Date: Mon, 16 Apr 2018 19:47:29 +0300
MIME-Version: 1.0
In-Reply-To: <20180413075739.GC14855@in.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="tpgAzdtJCarQP0YV43NbBWijl8O14qNcu"
Subject: Re: [Qemu-devel] [PATCH for 2.13 v3 1/2] spapr: Add ibm,
 max-associativity-domains property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: bharata@linux.vnet.ibm.com
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, david@gibson.dropbear.id.au

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--tpgAzdtJCarQP0YV43NbBWijl8O14qNcu
From: Serhii Popovych <spopovyc@redhat.com>
To: bharata@linux.vnet.ibm.com
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, david@gibson.dropbear.id.au
Message-ID: <e651fb40-2e44-73ed-6082-d9e497073e69@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for 2.13 v3 1/2] spapr: Add ibm,
 max-associativity-domains property
References: <1523472120-56496-1-git-send-email-spopovyc@redhat.com>
 <1523472120-56496-2-git-send-email-spopovyc@redhat.com>
 <20180413075739.GC14855@in.ibm.com>
In-Reply-To: <20180413075739.GC14855@in.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Bharata B Rao wrote:
> On Wed, Apr 11, 2018 at 02:41:59PM -0400, Serhii Popovych wrote:
>> Now recent kernels (i.e. since linux-stable commit a346137e9142
>> ("powerpc/numa: Use ibm,max-associativity-domains to discover possible=
 nodes")
>> support this property to mark initially memory-less NUMA nodes as "pos=
sible"
>> to allow further memory hot-add to them.
>>
>> Advertise this property for pSeries machines to let guest kernels dete=
ct
>> maximum supported node configuration and benefit from kernel side chan=
ge
>> when hot-add memory to specific, possibly empty before, NUMA node.
>>
>> Signed-off-by: Serhii Popovych <spopovyc@redhat.com>
>> ---
>>  hw/ppc/spapr.c | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>>
>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>> index a81570e..c05bbad 100644
>> --- a/hw/ppc/spapr.c
>> +++ b/hw/ppc/spapr.c
>> @@ -910,6 +910,13 @@ static void spapr_dt_rtas(sPAPRMachineState *spap=
r, void *fdt)
>>          0, cpu_to_be32(SPAPR_MEMORY_BLOCK_SIZE),
>>          cpu_to_be32(max_cpus / smp_threads),
>>      };
>> +    uint32_t maxdomains[] =3D {
>> +        cpu_to_be32(4),
>> +        cpu_to_be32(0),
>> +        cpu_to_be32(0),
>> +        cpu_to_be32(0),
>> +        cpu_to_be32(nb_numa_nodes - 1),
>> +    };
>>
>>      _FDT(rtas =3D fdt_add_subnode(fdt, 0, "rtas"));
>>
>> @@ -946,6 +953,9 @@ static void spapr_dt_rtas(sPAPRMachineState *spapr=
, void *fdt)
>>      _FDT(fdt_setprop(fdt, rtas, "ibm,associativity-reference-points",=

>>                       refpoints, sizeof(refpoints)));
>>
>> +    _FDT(fdt_setprop(fdt, rtas, "ibm,max-associativity-domains",
>> +                     maxdomains, sizeof(maxdomains)));
>> +
>>      _FDT(fdt_setprop_cell(fdt, rtas, "rtas-error-log-max",
>>                            RTAS_ERROR_LOG_MAX));
>>      _FDT(fdt_setprop_cell(fdt, rtas, "rtas-event-scan-rate",
>> --=20
>> 1.8.3.1
>=20
> This commit causes hash guest with latest guest kernel to hang at early=
 boot.

I use v4.16 tag from stable and can't reproduce on P8 machine reported
issue.

Could you please share more details about your setup, kernel commit id
you spot problem?

>=20
> Quiescing Open Firmware ...
> Booting Linux via __start() @ 0x0000000002000000 ...
> [    0.000000] hash-mmu: Page sizes from device-tree:
> [    0.000000] hash-mmu: base_shift=3D12: shift=3D12, sllp=3D0x0000, av=
pnm=3D0x00000000, tlbiel=3D1, penc=3D0
> [    0.000000] hash-mmu: base_shift=3D16: shift=3D16, sllp=3D0x0110, av=
pnm=3D0x00000000, tlbiel=3D1, penc=3D1
> [    0.000000] Using 1TB segments
> [    0.000000] hash-mmu: Initializing hash mmu with SLB
> [    0.000000] Linux version 4.16.0-rc7+ (root@localhost.localdomain) (=
gcc version 7.1.1 20170622 (Red Hat 7.1.1-3) (GCC)) #60 SMP Wed Apr 11 10=
:36:22 IST 2018
> [    0.000000] Found initrd at 0xc000000003c00000:0xc000000004f9a34c
> [    0.000000] Using pSeries machine description
> [    0.000000] bootconsole [udbg0] enabled
> [    0.000000] Partition configured for 32 cpus.
> [    0.000000] CPU maps initialized for 1 thread per core
> [    0.000000] -----------------------------------------------------
> [    0.000000] ppc64_pft_size    =3D 0x1a
> [    0.000000] phys_mem_size     =3D 0x200000000
> [    0.000000] dcache_bsize      =3D 0x80
> [    0.000000] icache_bsize      =3D 0x80
> [    0.000000] cpu_features      =3D 0x077c7a6c18500249
> [    0.000000]   possible        =3D 0xffffffff18500649
> [    0.000000]   always          =3D 0x0000000018100040
> [    0.000000] cpu_user_features =3D 0xdc0065c2 0xae000000
> [    0.000000] mmu_features      =3D 0x78006001
> [    0.000000] firmware_features =3D 0x00000001415a445f
> [    0.000000] htab_hash_mask    =3D 0x7ffff
> [    0.000000] -----------------------------------------------------
>=20
> No progess after this.
>=20
>=20


--=20
Thanks,
Serhii


--tpgAzdtJCarQP0YV43NbBWijl8O14qNcu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAEBAgAGBQJa1NOnAAoJEBTawMmQ61bBbFIIAMcQybzX53NMM4esshHlOjlh
iRDIkou651OAjGGnHTJ5rtbWEPb3P42jm22F7ocsd5TVSUoimnSioOIUnhbuwLvd
W36verb7Pe81ghZcsOZaiKF7rLfI0fLDMXahoEucuJc8qxXPOvsY/NB6OPFsqQzT
vannlnWUYJF/myq8kIGjHule7WhNZsK4+12W4zgJf6T7M77MCex6DgZkgBWWPUhK
7PvYD1rsq18mJZnVu2rzZ7uO/R2LM0JAfcxPtzdKWBc27BL3xqj+9xflDnQhItbB
8eFqbAHrR22jVs7MmQf2ut24e238HO+clpW0QPXg6ZhEEVJNvkrXdUppRiEvHjQ=
=RykH
-----END PGP SIGNATURE-----

--tpgAzdtJCarQP0YV43NbBWijl8O14qNcu--
