Received: from eggs.gnu.org ([2001:4830:134:3::10]:43104)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1e4KqS-0005G4-Ff
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 01:55:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1e4KqP-00022K-8Q
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 01:55:16 -0400
Received: from mail-it0-x242.google.com ([2607:f8b0:4001:c0b::242]:51273)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1e4KqO-00020H-UC
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 01:55:13 -0400
Received: by mail-it0-x242.google.com with SMTP id o135so1020823itb.0
	for <qemu-devel@nongnu.org>; Mon, 16 Oct 2017 22:55:10 -0700 (PDT)
References: <20171016052004.31397-1-aik@ozlabs.ru>
	<20171016093641.GH2776@umbus.fritz.box>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <e419ca8a-6e0b-70eb-14da-03a843fa8b92@ozlabs.ru>
Date: Tue, 17 Oct 2017 16:55:03 +1100
MIME-Version: 1.0
In-Reply-To: <20171016093641.GH2776@umbus.fritz.box>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Dtik2GsNcSQUTTckBqb6Q42KNLbSKJtcC"
Subject: Re: [Qemu-devel] [PATCH qemu v3] RFC: ppc/spapr: Receive and store
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
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Balbir Singh <bsingharora@gmail.com>, Greg Kurz <groug@kaod.org>, slof@lists.ozlabs.org, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, Thomas Huth <thuth@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Dtik2GsNcSQUTTckBqb6Q42KNLbSKJtcC
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Balbir Singh <bsingharora@gmail.com>, Greg Kurz <groug@kaod.org>,
 slof@lists.ozlabs.org, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>,
 Thomas Huth <thuth@redhat.com>
Message-ID: <e419ca8a-6e0b-70eb-14da-03a843fa8b92@ozlabs.ru>
Subject: Re: [PATCH qemu v3] RFC: ppc/spapr: Receive and store device tree
 blob from SLOF
References: <20171016052004.31397-1-aik@ozlabs.ru>
 <20171016093641.GH2776@umbus.fritz.box>
In-Reply-To: <20171016093641.GH2776@umbus.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 16/10/17 20:36, David Gibson wrote:
> On Mon, Oct 16, 2017 at 04:20:04PM +1100, Alexey Kardashevskiy wrote:
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
>> This implements a basic FDT header validity check of the new blob;
>> the new blob size should not increase more than twice since the reset.=

>>
>> This adds a machine property - update_dt_enabled - to allow backward
>> migration.
>>
>> This requires SLOF update: "fdt: Pass the resulting device tree to QEM=
U".
>>
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>> ---
>> Changes:
>> v3:
>> * store reset-time FDT blob size and compare the update size against i=
t;
>> this disallows more than 2x increase between resets
>> * added some FDT header sanity checks
>> * implemented migration
>>
>> ---
>> I could store just a size of the QEMU's blob, or a tree, not sure
>> which one makes more sense here.
>>
>> This allows up to 2 times blob increase. Not 1.5 just to avoid
>> float/double, just looks a bit ugly imho.
>> ---
>>  include/hw/ppc/spapr.h |  7 ++++++-
>>  hw/ppc/spapr.c         | 31 ++++++++++++++++++++++++++++++-
>>  hw/ppc/spapr_hcall.c   | 42 +++++++++++++++++++++++++++++++++++++++++=
+
>>  hw/ppc/trace-events    |  2 ++
>>  4 files changed, 80 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
>> index c1b365f564..a9ccc14823 100644
>> --- a/include/hw/ppc/spapr.h
>> +++ b/include/hw/ppc/spapr.h
>> @@ -60,6 +60,7 @@ struct sPAPRMachineClass {
>>      /*< public >*/
>>      bool dr_lmb_enabled;       /* enable dynamic-reconfig/hotplug of =
LMBs */
>>      bool use_ohci_by_default;  /* use USB-OHCI instead of XHCI */
>> +    bool update_dt_enabled;    /* enable KVMPPC_H_UPDATE_DT */
>>      const char *tcg_default_cpu; /* which (TCG) CPU to simulate by de=
fault */
>>      bool pre_2_10_has_unused_icps;
>>      void (*phb_placement)(sPAPRMachineState *spapr, uint32_t index,
>> @@ -92,6 +93,9 @@ struct sPAPRMachineState {
>>      int vrma_adjust;
>>      ssize_t rtas_size;
>>      void *rtas_blob;
>> +    uint32_t fdt_size;
>> +    uint32_t fdt_initial_size;
>> +    void *fdt_blob;
>>      long kernel_size;
>>      bool kernel_le;
>>      uint32_t initrd_base;
>> @@ -400,7 +404,8 @@ struct sPAPRMachineState {
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
>> index ff87f155d5..cb7bcc851e 100644
>> --- a/hw/ppc/spapr.c
>> +++ b/hw/ppc/spapr.c
>> @@ -1467,7 +1467,10 @@ static void ppc_spapr_reset(void)
>>      /* Load the fdt */
>>      qemu_fdt_dumpdtb(fdt, fdt_totalsize(fdt));
>>      cpu_physical_memory_write(fdt_addr, fdt, fdt_totalsize(fdt));
>> -    g_free(fdt);
>> +    g_free(spapr->fdt_blob);
>> +    spapr->fdt_size =3D fdt_totalsize(fdt);
>> +    spapr->fdt_initial_size =3D spapr->fdt_size;
>> +    spapr->fdt_blob =3D fdt;
>> =20
>>      /* Set up the entry state */
>>      first_ppc_cpu =3D POWERPC_CPU(first_cpu);
>> @@ -1675,6 +1678,27 @@ static const VMStateDescription vmstate_spapr_p=
atb_entry =3D {
>>      },
>>  };
>> =20
>> +static bool spapr_dtb_needed(void *opaque)
>> +{
>> +    sPAPRMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(opaque);
>> +
>> +    return smc->update_dt_enabled;
>> +}
>> +
>> +static const VMStateDescription vmstate_spapr_dtb =3D {
>> +    .name =3D "spapr_dtb",
>> +    .version_id =3D 1,
>> +    .minimum_version_id =3D 1,
>> +    .needed =3D spapr_dtb_needed,
>> +    .fields =3D (VMStateField[]) {
>> +        VMSTATE_UINT32(fdt_initial_size, sPAPRMachineState),
>=20
> I'm not sure you need to migrate initial size.  The destination can
> work this out itself.. > unless we skip the reset when we have an
> incoming migration, I'm not sure.


Nah, ppc_spapr_reset() is called when incoming migration and does not do
anything different than normal reset situation so I'll remove this.


>=20
>> +        VMSTATE_UINT32(fdt_size, sPAPRMachineState),
>> +        VMSTATE_VBUFFER_ALLOC_UINT32(fdt_blob, sPAPRMachineState, 0, =
NULL,
>> +                                     fdt_size),
>> +        VMSTATE_END_OF_LIST()
>> +    },
>> +};
>> +
>>  static const VMStateDescription vmstate_spapr =3D {
>>      .name =3D "spapr",
>>      .version_id =3D 3,
>> @@ -1694,6 +1718,7 @@ static const VMStateDescription vmstate_spapr =3D=
 {
>>          &vmstate_spapr_ov5_cas,
>>          &vmstate_spapr_patb_entry,
>>          &vmstate_spapr_pending_events,
>> +        &vmstate_spapr_dtb,
>>          NULL
>>      }
>>  };
>> @@ -3605,6 +3630,7 @@ static void spapr_machine_class_init(ObjectClass=
 *oc, void *data)
>>      hc->unplug_request =3D spapr_machine_device_unplug_request;
>> =20
>>      smc->dr_lmb_enabled =3D true;
>> +    smc->update_dt_enabled =3D true;
>>      smc->tcg_default_cpu =3D "POWER8";
>>      mc->has_hotpluggable_cpus =3D true;
>>      smc->resize_hpt_default =3D SPAPR_RESIZE_HPT_ENABLED;
>> @@ -3703,7 +3729,10 @@ static void spapr_machine_2_10_instance_options=
(MachineState *machine)
>> =20
>>  static void spapr_machine_2_10_class_options(MachineClass *mc)
>>  {
>> +    sPAPRMachineClass *smc =3D SPAPR_MACHINE_CLASS(mc);
>> +
>>      spapr_machine_2_11_class_options(mc);
>> +    smc->update_dt_enabled =3D false;
>>      SET_MACHINE_COMPAT(mc, SPAPR_COMPAT_2_10);
>>  }
>> =20
>> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
>> index 8d72bb7c1c..be3de41080 100644
>> --- a/hw/ppc/spapr_hcall.c
>> +++ b/hw/ppc/spapr_hcall.c
>> @@ -1656,6 +1656,46 @@ static target_ulong h_client_architecture_suppo=
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
>> +    unsigned cb;
>> +    sPAPRMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(spapr);
>> +
>> +    cpu_physical_memory_read(dt, &hdr, sizeof(hdr));
>> +    cb =3D fdt32_to_cpu(hdr.totalsize);
>> +
>> +    if (fdt_check_header(&hdr) ||
>> +        fdt32_to_cpu(hdr.boot_cpuid_phys) ||
>=20
> A nonzero boot cpuid is potentially valid, we shouldn't fail that.

Already discovered...

>=20
>> +        fdt32_to_cpu(hdr.off_dt_struct) >=3D cb ||
>> +        fdt32_to_cpu(hdr.off_dt_strings) >=3D cb ||
>> +        fdt32_to_cpu(hdr.off_mem_rsvmap) >=3D cb ||
>=20
> Just checking the offset isn't very useful.  You need to check two
> things for each of the blocks:
> 	off + size >=3D off	; this checks there's no overflow
> 	off + size <=3D totalsize	; checks the block fits in the blob
>=20
> With the additional complication that you don't actually have a size
> for the rsvmap - so you have to step through it to verify that.  For a
> v16 blob you don't have one for the structure blob either, but you
> could simply reject v16 blobs.

Ok, v17 it is.


>=20
>> +        fdt32_to_cpu(hdr.totalsize) !=3D fdt32_to_cpu(hdr.size_dt_str=
ings) +
>> +                fdt32_to_cpu(hdr.size_dt_struct) +
>> +                sizeof(struct fdt_reserve_entry) +
>> +                sizeof(hdr)
>=20
> This check is invalid.  It's allowed to have gaps between the blocks
> in the FDT, which could increase the size.  In some cases it's even
> required, to meet the alignment requirements for each block.


Invalid? At the moment what SLOF provides passes this check and it will,
and we only expect these blobs to come from SLOF - no need to protect fro=
m
who knows what.



> ||
>=20
> Yeah.. this is all a bit complicated, I'm really thinking about a
> fdt_fsck() function for libfdt.


Oh. So what now? Do as below or wait for libdtc update?



+    cb =3D fdt32_to_cpu(hdr.totalsize);
+
+#define FDT_CHK(_off, _size, total) ({ \
+        uint32_t off =3D fdt32_to_cpu(_off); \
+        uint32_t size =3D fdt32_to_cpu(_size); \
+        ((off + size >=3D off) && (off + size <=3D (total))); \
+    })
+
+    if (fdt_check_header(&hdr) ||
+        fdt32_to_cpu(hdr.version) < 0x11 ||
+        !FDT_CHK(hdr.off_dt_struct, hdr.size_dt_struct, cb) ||
+        !FDT_CHK(hdr.off_dt_strings, hdr.size_dt_strings, cb) ||
+        cb <=3D fdt32_to_cpu(hdr.off_mem_rsvmap) ||
+        cb < fdt32_to_cpu(hdr.size_dt_strings) +
+                fdt32_to_cpu(hdr.size_dt_struct) +
+                sizeof(struct fdt_reserve_entry) +
+                sizeof(hdr) ||
+        cb / spapr->fdt_initial_size > 2) {
+        trace_spapr_update_dt_failed(spapr->fdt_initial_size, cb,
+            fdt32_to_cpu(hdr.magic));
+        return H_PARAMETER;
+    }






--=20
Alexey


--Dtik2GsNcSQUTTckBqb6Q42KNLbSKJtcC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIrBAEBCAAVBQJZ5Zs3DhxhaWtAb3psYWJzLnJ1AAoJEIYTPdgrwSC5Gb8P/0mH
i0Y+pbE60NvPCRuc63bwsXfdccCfpeporzocYB36aPfmLKQS/bmcsUtlODrhxE8q
kRlcytYQFxpJUDPEZ6Q6poELC5pe4FHkfuh1zgCfnJDvg80NHvN4qlBfxvX08Mcy
FcpHsmCAAfIccJjsrjY4EkxIPV2eNihG0tK4SkfMvCXZHBOELjuYmIzWMXQmdLpL
omkX/QjNHQAJq9C1czoZOeFvcx86LhbuYxYkqLtpAImJLjjcr1hDAhYOgdCfeZ1F
DT6Oijzf9kZiC3gwVbF9NDkYoAIPzb1SeaZJeBC74uHYCDjyzh1ZHwIG3YYV/ADF
QbaW4ryGbz4UNmaHJsdgrui+2VqRvfoiMoh1p4H3cR8BPdVO0gd2tCgXcbkSJZEs
HDJ9bbAkGvab3Upk5fMsVbUG9XVGyhFgjvBCbFH9PIW6XU4IYnhJr0mwfiWYht9z
Ms8TXPxdt7AshYaztNhhN9gvoDCWOTpInqR/cB0wj6cqK2eZesYOhAHEvYIJ1B30
5NqtWEo6c6WBBblpJ+n1XxmAxoD7e3pXxG/OFGUgc2RZLFb24g7Lmtp15StddY7Q
HpIlEQOkhxA+4syVFpb3+qrNWIZvlgLAyWdPqwdVV0cq1uVhHiX59HN2zdj4fJBd
+5W2+Hc3/f0eZntkJxuzhQBsNCOoDzwFMkuC26kr
=A1Ou
-----END PGP SIGNATURE-----

--Dtik2GsNcSQUTTckBqb6Q42KNLbSKJtcC--
