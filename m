Received: from eggs.gnu.org ([2001:4830:134:3::10]:39926)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1cQPr2-0003K2-U3
	for qemu-devel@nongnu.org; Sun, 08 Jan 2017 21:38:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1cQPqz-0002zX-R7
	for qemu-devel@nongnu.org; Sun, 08 Jan 2017 21:38:36 -0500
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:34758)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1cQPqz-0002zD-Hm
	for qemu-devel@nongnu.org; Sun, 08 Jan 2017 21:38:33 -0500
Received: by mail-pf0-x244.google.com with SMTP id y143so2370224pfb.1
	for <qemu-devel@nongnu.org>; Sun, 08 Jan 2017 18:38:32 -0800 (PST)
References: <20161222011312.12778-1-aik@ozlabs.ru>
	<20170103022644.GL12761@umbus.fritz.box>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <77140e33-0917-80a1-b2f4-5eaefda45a29@ozlabs.ru>
Date: Mon, 9 Jan 2017 13:38:26 +1100
MIME-Version: 1.0
In-Reply-To: <20170103022644.GL12761@umbus.fritz.box>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="DqTHbxwtX2RoAC8WFHJBXA53CiODGhIqa"
Subject: Re: [Qemu-devel] [PATCH qemu] target-ppc: kvm: make use of
 KVM_CREATE_SPAPR_TCE_64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--DqTHbxwtX2RoAC8WFHJBXA53CiODGhIqa
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Message-ID: <77140e33-0917-80a1-b2f4-5eaefda45a29@ozlabs.ru>
Subject: Re: [PATCH qemu] target-ppc: kvm: make use of KVM_CREATE_SPAPR_TCE_64
References: <20161222011312.12778-1-aik@ozlabs.ru>
 <20170103022644.GL12761@umbus.fritz.box>
In-Reply-To: <20170103022644.GL12761@umbus.fritz.box>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: quoted-printable

On 03/01/17 13:26, David Gibson wrote:
> On Thu, Dec 22, 2016 at 12:13:12PM +1100, Alexey Kardashevskiy wrote:
>> KVM_CAP_SPAPR_TCE capability allows creating TCE tables in KVM which
>> allows having in-kernel acceleration for H_PUT_TCE_xxx hypercalls.
>> However it only supports 32bit DMA windows at zero bus offset.
>>
>> There is a new KVM_CAP_SPAPR_TCE_64 capability which supports 64bit
>> window size, variable page size and bus offset.
>>
>> This makes use of the new capability. The kernel headers are already
>> updated as the kernel support went in to v4.6.
>>
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>> ---
>>  target-ppc/kvm_ppc.h | 12 +++++++-----
>>  hw/ppc/spapr_iommu.c |  8 +++++---
>>  target-ppc/kvm.c     | 48 +++++++++++++++++++++++++++++++++++++------=
-----
>>  3 files changed, 49 insertions(+), 19 deletions(-)
>>
>> diff --git a/target-ppc/kvm_ppc.h b/target-ppc/kvm_ppc.h
>> index bd1d78bfbe..14320c2378 100644
>> --- a/target-ppc/kvm_ppc.h
>> +++ b/target-ppc/kvm_ppc.h
>> @@ -36,8 +36,9 @@ int kvmppc_booke_watchdog_enable(PowerPCCPU *cpu);
>>  #ifndef CONFIG_USER_ONLY
>>  off_t kvmppc_alloc_rma(void **rma);
>>  bool kvmppc_spapr_use_multitce(void);
>> -void *kvmppc_create_spapr_tce(uint32_t liobn, uint32_t window_size, i=
nt *pfd,
>> -                              bool need_vfio);
>> +void *kvmppc_create_spapr_tce(uint32_t liobn, uint32_t page_shift,
>> +                              uint64_t bus_offset, uint32_t nb_table,=

>> +                              int *pfd, bool need_vfio);
>>  int kvmppc_remove_spapr_tce(void *table, int pfd, uint32_t window_siz=
e);
>>  int kvmppc_reset_htab(int shift_hint);
>>  uint64_t kvmppc_rma_size(uint64_t current_size, unsigned int hash_shi=
ft);
>> @@ -168,9 +169,10 @@ static inline bool kvmppc_spapr_use_multitce(void=
)
>>      return false;
>>  }
>> =20
>> -static inline void *kvmppc_create_spapr_tce(uint32_t liobn,
>> -                                            uint32_t window_size, int=
 *fd,
>> -                                            bool need_vfio)
>> +static inline void *kvmppc_create_spapr_tce(uint32_t liobn, uint32_t =
page_shift,
>> +                                            uint64_t bus_offset,
>> +                                            uint32_t nb_table,
>> +                                            int *pfd, bool need_vfio)=

>>  {
>>      return NULL;
>>  }
>> diff --git a/hw/ppc/spapr_iommu.c b/hw/ppc/spapr_iommu.c
>> index ae30bbe30f..29c80bb3c8 100644
>> --- a/hw/ppc/spapr_iommu.c
>> +++ b/hw/ppc/spapr_iommu.c
>> @@ -79,15 +79,16 @@ static IOMMUAccessFlags spapr_tce_iommu_access_fla=
gs(uint64_t tce)
>> =20
>>  static uint64_t *spapr_tce_alloc_table(uint32_t liobn,
>>                                         uint32_t page_shift,
>> +                                       uint64_t bus_offset,
>>                                         uint32_t nb_table,
>>                                         int *fd,
>>                                         bool need_vfio)
>>  {
>>      uint64_t *table =3D NULL;
>> -    uint64_t window_size =3D (uint64_t)nb_table << page_shift;
>> =20
>> -    if (kvm_enabled() && !(window_size >> 32)) {
>> -        table =3D kvmppc_create_spapr_tce(liobn, window_size, fd, nee=
d_vfio);
>> +    if (kvm_enabled()) {
>=20
> This is broken.  Previously, if we had a >4GiB window, we'd fall back
> to managing it in userspace, which would work, albeit slowly.  Now, if
> you have an older kernel which doesn't support KVM_CAP_SPAPR_TCE_64 it
> will attempt to allocate it in the kernel, and fail completely.


No, kvmppc_create_spapr_tce() would return NULL and right after that ther=
e
is a "if (!table)" (it can be seen at the end of this chunk) to handle th=
e
failure.


>=20
>> +        table =3D kvmppc_create_spapr_tce(liobn, page_shift, bus_offs=
et, nb_table,
>> +                                        fd, need_vfio);
>>      }
>> =20
>>      if (!table) {
>> @@ -342,6 +343,7 @@ void spapr_tce_table_enable(sPAPRTCETable *tcet,
>>      tcet->nb_table =3D nb_table;
>>      tcet->table =3D spapr_tce_alloc_table(tcet->liobn,
>>                                          tcet->page_shift,
>> +                                        tcet->bus_offset,
>>                                          tcet->nb_table,
>>                                          &tcet->fd,
>>                                          tcet->need_vfio);
>> diff --git a/target-ppc/kvm.c b/target-ppc/kvm.c
>> index 9c4834c4fc..6e91a4d8bb 100644
>> --- a/target-ppc/kvm.c
>> +++ b/target-ppc/kvm.c
>> @@ -71,6 +71,7 @@ static int cap_booke_sregs;
>>  static int cap_ppc_smt;
>>  static int cap_ppc_rma;
>>  static int cap_spapr_tce;
>> +static int cap_spapr_tce_64;
>>  static int cap_spapr_multitce;
>>  static int cap_spapr_vfio;
>>  static int cap_hior;
>> @@ -123,6 +124,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>>      cap_ppc_smt =3D kvm_check_extension(s, KVM_CAP_PPC_SMT);
>>      cap_ppc_rma =3D kvm_check_extension(s, KVM_CAP_PPC_RMA);
>>      cap_spapr_tce =3D kvm_check_extension(s, KVM_CAP_SPAPR_TCE);
>> +    cap_spapr_tce_64 =3D kvm_check_extension(s, KVM_CAP_SPAPR_TCE_64)=
;
>>      cap_spapr_multitce =3D kvm_check_extension(s, KVM_CAP_SPAPR_MULTI=
TCE);
>>      cap_spapr_vfio =3D false;
>>      cap_one_reg =3D kvm_check_extension(s, KVM_CAP_ONE_REG);
>> @@ -2201,13 +2203,10 @@ bool kvmppc_spapr_use_multitce(void)
>>      return cap_spapr_multitce;
>>  }
>> =20
>> -void *kvmppc_create_spapr_tce(uint32_t liobn, uint32_t window_size, i=
nt *pfd,
>> -                              bool need_vfio)
>> +void *kvmppc_create_spapr_tce(uint32_t liobn, uint32_t page_shift,
>> +                              uint64_t bus_offset, uint32_t nb_table,=

>> +                              int *pfd, bool need_vfio)
>>  {
>> -    struct kvm_create_spapr_tce args =3D {
>> -        .liobn =3D liobn,
>> -        .window_size =3D window_size,
>> -    };
>>      long len;
>>      int fd;
>>      void *table;
>> @@ -2220,14 +2219,41 @@ void *kvmppc_create_spapr_tce(uint32_t liobn, =
uint32_t window_size, int *pfd,
>>          return NULL;
>>      }
>> =20
>> -    fd =3D kvm_vm_ioctl(kvm_state, KVM_CREATE_SPAPR_TCE, &args);
>> -    if (fd < 0) {
>> -        fprintf(stderr, "KVM: Failed to create TCE table for liobn 0x=
%x\n",
>> -                liobn);
>> +    if (cap_spapr_tce_64) {
>> +        struct kvm_create_spapr_tce_64 args =3D {
>> +            .liobn =3D liobn,
>> +            .page_shift =3D page_shift,
>> +            .offset =3D bus_offset >> page_shift,
>> +            .size =3D nb_table,
>> +            .flags =3D 0
>> +        };
>> +        fd =3D kvm_vm_ioctl(kvm_state, KVM_CREATE_SPAPR_TCE_64, &args=
);
>> +        if (fd < 0) {
>> +            fprintf(stderr,
>> +                    "KVM: Failed to create TCE64 table for liobn 0x%x=
\n",
>> +                    liobn);
>> +            return NULL;
>> +        }
>> +    } else if (cap_spapr_tce) {
>> +        uint64_t window_size =3D (uint64_t) nb_table << page_shift;
>> +        struct kvm_create_spapr_tce args =3D {
>> +            .liobn =3D liobn,
>> +            .window_size =3D window_size,
>> +        };
>> +        if ((window_size !=3D args.window_size) || bus_offset) {
>> +            return NULL;
>> +        }
>> +        fd =3D kvm_vm_ioctl(kvm_state, KVM_CREATE_SPAPR_TCE, &args);
>> +        if (fd < 0) {
>> +            fprintf(stderr, "KVM: Failed to create TCE table for liob=
n 0x%x\n",
>> +                    liobn);
>> +            return NULL;
>> +        }
>> +    } else {
>>          return NULL;
>>      }
>> =20
>> -    len =3D (window_size / SPAPR_TCE_PAGE_SIZE) * sizeof(uint64_t);
>> +    len =3D nb_table * sizeof(uint64_t);
>>      /* FIXME: round this up to page size */
>> =20
>>      table =3D mmap(NULL, len, PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0=
);
>=20


--=20
Alexey


--DqTHbxwtX2RoAC8WFHJBXA53CiODGhIqa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIrBAEBCAAVBQJYcveiDhxhaWtAb3psYWJzLnJ1AAoJEIYTPdgrwSC5S+MP/2ZJ
dzaz/acsXLUTi1NwjYfwy0OlrZ8VSrQS5RfwvLtIZo7PZDx6lJsFQIrBwYaH9RRk
RH54KY7TQVN84debCfFUD/aiohZ/O6DYTkbL/tQIpfzXopsik49LxE2Oef/i8MIn
wVqklgrkocU15ZsmU7uQvVeS0Yhszg5oR4YIqRX1Y9Cgr2yShzxjIRXIIx0Mtvky
641TtS/bGb8OQiTx/bTwr+kO9HKG9+77Cxe1Om+K08EK2RyZmiDWSR4DRicAJ/Y3
jD9iSB7JoFf1AJ6Ho3uunXAd+H3d+fERKEKpYcxveI61+r2PNIb03qboFFF436oS
bUx8rDk7Kqn7O1HJ2a1kXdSvgjptBu0RgUTmu5fcqkJfHrEeb92fFv01QZ1djw8K
Hl6UUBbPiI5C2QBYT0HY6k4nuS8HQsZFiqvFD8SnSb7eH2Ls3Hd4q0PLDK7kmSY7
LEE7GC22NAvVamL1AUUEG4zYLKdSrM0GrNZkUteVGhhX9lL/B5GnWfdPWhqTGoD2
cGQ6nGRJXQcvHcKVuOCQZOix1/7JRs8Ec2kKjl3kqeeVgkvCUomKlE8+M3gi/wO5
IStB64wPkntbJGh4y4MHdWw21UaIR+HI/vvdDlE9qG6JpXt1/JFDtkizKMSxH2ir
q5rLDkgGhqVvzyYZTv6h5vFiNGug8VERbXfwNuUK
=88aq
-----END PGP SIGNATURE-----

--DqTHbxwtX2RoAC8WFHJBXA53CiODGhIqa--
