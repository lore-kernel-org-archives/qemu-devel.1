Received: from eggs.gnu.org ([2001:4830:134:3::10]:53182)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dzIsZ-0006tD-2J
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 04:48:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dzIsV-0006R8-Uy
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 04:48:39 -0400
Received: from mail-it0-x242.google.com ([2607:f8b0:4001:c0b::242]:56113)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1dzIsV-0006Pj-Kw
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 04:48:35 -0400
Received: by mail-it0-x242.google.com with SMTP id 4so10496509itv.4
	for <qemu-devel@nongnu.org>; Tue, 03 Oct 2017 01:48:34 -0700 (PDT)
References: <20171003051701.17721-1-aik@ozlabs.ru>
	<20171003064025.GK3260@umbus.fritz.box>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <5c423fec-f247-015e-1c7a-5eefec584fc0@ozlabs.ru>
Date: Tue, 3 Oct 2017 19:48:27 +1100
MIME-Version: 1.0
In-Reply-To: <20171003064025.GK3260@umbus.fritz.box>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="O5mvFexv8P2OUsl4RXRthOfc4j8knOkl6"
Subject: Re: [Qemu-devel] [RFC PATCH qemu v2] ppc/spapr: Receive and store
 device tree blob from SLOF
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Aravinda Prasad <aravinda@linux.vnet.ibm.com>, Balbir Singh <bsingharora@gmail.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--O5mvFexv8P2OUsl4RXRthOfc4j8knOkl6
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Aravinda Prasad <aravinda@linux.vnet.ibm.com>,
 Balbir Singh <bsingharora@gmail.com>
Message-ID: <5c423fec-f247-015e-1c7a-5eefec584fc0@ozlabs.ru>
Subject: Re: [RFC PATCH qemu v2] ppc/spapr: Receive and store device tree blob
 from SLOF
References: <20171003051701.17721-1-aik@ozlabs.ru>
 <20171003064025.GK3260@umbus.fritz.box>
In-Reply-To: <20171003064025.GK3260@umbus.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/10/17 17:40, David Gibson wrote:
> On Tue, Oct 03, 2017 at 04:17:01PM +1100, Alexey Kardashevskiy wrote:
>> SLOF receives a device tree and updates it with various properties
>> before switching to the guest kernel and QEMU is not aware of any chan=
ges
>> made by SLOF. Since there is no real RTAS and QEMU implements it,
>> it makes sense to pass the SLOF device tree to QEMU so the latter coul=
d
>> implement RTAS related tasks better.
>>
>> Specifially, now QEMU can find out the actual XICS phandle (for PHB
>> hotplug) and the RTAS linux,rtas-entry/base properties (for firmware
>> assisted NMI - FWNMI).
>>
>> This stores the initial DT blob in the sPAPR machine and replaces it
>> in the KVMPPC_H_UPDATE_DT (new private hypercall) handler.
>>
>> This implements a very basic validity check of the new blob - magic an=
d
>> size are checked; the new blob size should not increase more than twic=
e.
>>
>> This requires SLOF update: "fdt: Pass the resulting device tree to QEM=
U".
>>
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>> ---
>>
>> I could store just a size of the QEMU's blob, or a tree, not sure
>> which one makes more sense here.
>>
>> This allows up to 2 times blob increase. Not 1.5 just to avoid
>> float/double, just looks a bit ugly imho.
>> ---
>>  include/hw/ppc/spapr.h |  4 +++-
>>  hw/ppc/spapr.c         |  4 +++-
>>  hw/ppc/spapr_hcall.c   | 33 +++++++++++++++++++++++++++++++++
>>  hw/ppc/trace-events    |  2 ++
>>  4 files changed, 41 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
>> index a805b817a5..09f3a54dc2 100644
>> --- a/include/hw/ppc/spapr.h
>> +++ b/include/hw/ppc/spapr.h
>> @@ -92,6 +92,7 @@ struct sPAPRMachineState {
>>      int vrma_adjust;
>>      ssize_t rtas_size;
>>      void *rtas_blob;
>> +    void *fdt_blob;
>>      long kernel_size;
>>      bool kernel_le;
>>      uint32_t initrd_base;
>> @@ -400,7 +401,8 @@ struct sPAPRMachineState {
>>  #define KVMPPC_H_LOGICAL_MEMOP  (KVMPPC_HCALL_BASE + 0x1)
>>  /* Client Architecture support */
>>  #define KVMPPC_H_CAS            (KVMPPC_HCALL_BASE + 0x2)
>> -#define KVMPPC_HCALL_MAX        KVMPPC_H_CAS
>> +#define KVMPPC_H_UPDATE_DT      (KVMPPC_HCALL_BASE + 0x3)
>> +#define KVMPPC_HCALL_MAX        KVMPPC_H_UPDATE_DT
>> =20
>>  typedef struct sPAPRDeviceTreeUpdateHeader {
>>      uint32_t version_id;
>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>> index 17ea77618c..b471f7e1ff 100644
>> --- a/hw/ppc/spapr.c
>> +++ b/hw/ppc/spapr.c
>> @@ -1453,7 +1453,9 @@ static void ppc_spapr_reset(void)
>>      /* Load the fdt */
>>      qemu_fdt_dumpdtb(fdt, fdt_totalsize(fdt));
>>      cpu_physical_memory_write(fdt_addr, fdt, fdt_totalsize(fdt));
>> -    g_free(fdt);
>> +    g_free(spapr->fdt_blob);
>> +    spapr->fdt_blob =3D fdt;
>> +    spapr->fdt_size =3D fdt_totalsize(fdt);
>> =20
>>      /* Set up the entry state */
>>      first_ppc_cpu =3D POWERPC_CPU(first_cpu);
>> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
>> index 57bb411394..a11831d3b2 100644
>> --- a/hw/ppc/spapr_hcall.c
>> +++ b/hw/ppc/spapr_hcall.c
>> @@ -1635,6 +1635,37 @@ static target_ulong h_client_architecture_suppo=
rt(PowerPCCPU *cpu,
>>      return H_SUCCESS;
>>  }
>> =20
>> +static target_ulong h_update_dt(PowerPCCPU *cpu, sPAPRMachineState *s=
papr,
>> +                                target_ulong opcode, target_ulong *ar=
gs)
>> +{
>> +    target_ulong dt =3D ppc64_phys_to_real(args[0]);
>> +    struct fdt_header hdr =3D { 0 };
>> +    unsigned cb, magic, old_cb =3D fdt_totalsize(spapr->fdt_blob);
>> +
>> +    cpu_physical_memory_read(dt, &hdr, sizeof(hdr));
>> +    cb =3D fdt32_to_cpu(hdr.totalsize);
>> +    magic =3D fdt32_to_cpu(hdr.magic);
>> +    if (magic !=3D FDT_MAGIC || cb / old_cb > 2) {
>=20
> Uh.. no.  This prevents the guest from gobbling arbitrary amounts of
> qemu RAM _in one go_, but it can still call h_update_dt arbitrarily
> often, doubling the amount of memory consumed each time.
>=20
> You need to compare the updated DT size with the _original_ DT size,
> not just the last DT size.


Ah, right. Does it still make sense to store the original DT in the machi=
ne?

>=20
>> +        trace_spapr_update_dt_failed(old_cb, cb, magic);
>> +        return H_PARAMETER;
>> +    }
>=20
> Still needs more sanity checks here.  At least check version and that
> each of the sub-blocks fits correctly within totalsize.
>=20
> Maybe I should add an fdt_fsck() function to libfdt, hmm...


ookay, I just assumed libfdt checks for subblock sizes.





--=20
Alexey


--O5mvFexv8P2OUsl4RXRthOfc4j8knOkl6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIrBAEBCAAVBQJZ007bDhxhaWtAb3psYWJzLnJ1AAoJEIYTPdgrwSC5GIEQAIhP
0zMy9wWzeZ8HWGWEmdSnpsMSalv6P7f0UxWmVb0qoHBYfOpZuK6yJQ8Hvz/kLLm0
UCspbvMI9HWNvcu3WwtTRwvOvEitx/AAlrJtLOAYo/W524uR8hfCRBTjXmFzYol4
ib65jC/65HnuH/xw4HNvnYOCgzVT028ZzKouaOUb7rzr6/nxt9j3Teq07lerzS1w
HjrtdrVlbKdSOhwSRFEOnZG0f1uM1NA0sOTwKX+H5CfxFCb/mDZnXEqXMlUdy1+B
6jEuTQUKmhCIguu5a/J9zMom8k6e9IZgAMoIctF8C19V6XxPsJvLFKI2Az0iisGe
FJhD26OeW6f9IjTlUg0Ox0Goi8hra6C9Tfaw5U1JfSKtAisCxd5yCyp+/vXh/+xq
EKvrkUvaYoEhyaep/KwhGx1tAk5A9YPHm3LQlHrMTqszqUA/APcQgrqr1sJHz1OE
hLyViAAShN6YkuqBWE5b3w/PzRFLfAUDPpD2XRqR5DYtmapSyqoN/4RT8SFspYxs
GKLbYgqHnux0F4cWV83/5g49T5Vr6zkgGczNmzYSQbfFehXCUcvCpGT4aUiv+ooM
ov68HIWBCzA+KHav369TaaT3rPyjkSFqZ+xQFeGhipBkIWF8QpSAd+QTwfZUKXXW
0fFOW8V1YEMSobYWRZwk9DoxIFqipkrcfdf/PzU1
=lZsl
-----END PGP SIGNATURE-----

--O5mvFexv8P2OUsl4RXRthOfc4j8knOkl6--
