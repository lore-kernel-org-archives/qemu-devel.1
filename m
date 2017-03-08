Received: from eggs.gnu.org ([2001:4830:134:3::10]:45568)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1clTX3-0003S4-Qg
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 23:49:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1clTX0-0003Df-Jx
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 23:49:01 -0500
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:34622)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1clTX0-0003DQ-6c
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 23:48:58 -0500
Received: by mail-pg0-x242.google.com with SMTP id b5so2181704pgg.1
	for <qemu-devel@nongnu.org>; Tue, 07 Mar 2017 20:48:56 -0800 (PST)
References: <20161222011312.12778-1-aik@ozlabs.ru>
	<20170103022644.GL12761@umbus.fritz.box>
	<77140e33-0917-80a1-b2f4-5eaefda45a29@ozlabs.ru>
	<20170109025349.GF12515@umbus.fritz.box>
	<a0251003-e14c-9a74-33e6-ec30bb868559@ozlabs.ru>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <99e97980-b1cf-ba79-00a7-9ac3ddfec2b1@ozlabs.ru>
Date: Wed, 8 Mar 2017 15:48:49 +1100
MIME-Version: 1.0
In-Reply-To: <a0251003-e14c-9a74-33e6-ec30bb868559@ozlabs.ru>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="MaO3lL27rhQrTq6lvtptcIGWNsMosHLbW"
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
--MaO3lL27rhQrTq6lvtptcIGWNsMosHLbW
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Message-ID: <99e97980-b1cf-ba79-00a7-9ac3ddfec2b1@ozlabs.ru>
Subject: Re: [PATCH qemu] target-ppc: kvm: make use of KVM_CREATE_SPAPR_TCE_64
References: <20161222011312.12778-1-aik@ozlabs.ru>
 <20170103022644.GL12761@umbus.fritz.box>
 <77140e33-0917-80a1-b2f4-5eaefda45a29@ozlabs.ru>
 <20170109025349.GF12515@umbus.fritz.box>
 <a0251003-e14c-9a74-33e6-ec30bb868559@ozlabs.ru>
In-Reply-To: <a0251003-e14c-9a74-33e6-ec30bb868559@ozlabs.ru>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: quoted-printable

Ping? It is not urgent, just wanted to make sure that it is not forgotten=

and I do not need to do anything to update it. Thanks.


On 02/03/17 13:40, Alexey Kardashevskiy wrote:
> On 09/01/17 13:53, David Gibson wrote:
>> On Mon, Jan 09, 2017 at 01:38:26PM +1100, Alexey Kardashevskiy wrote:
>>> On 03/01/17 13:26, David Gibson wrote:
>>>> On Thu, Dec 22, 2016 at 12:13:12PM +1100, Alexey Kardashevskiy wrote=
:
>>>>> KVM_CAP_SPAPR_TCE capability allows creating TCE tables in KVM whic=
h
>>>>> allows having in-kernel acceleration for H_PUT_TCE_xxx hypercalls.
>>>>> However it only supports 32bit DMA windows at zero bus offset.
>>>>>
>>>>> There is a new KVM_CAP_SPAPR_TCE_64 capability which supports 64bit=

>>>>> window size, variable page size and bus offset.
>>>>>
>>>>> This makes use of the new capability. The kernel headers are alread=
y
>>>>> updated as the kernel support went in to v4.6.
>>>>>
>>>>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>>>>> ---
>>>>>  target-ppc/kvm_ppc.h | 12 +++++++-----
>>>>>  hw/ppc/spapr_iommu.c |  8 +++++---
>>>>>  target-ppc/kvm.c     | 48 +++++++++++++++++++++++++++++++++++++---=
--------
>>>>>  3 files changed, 49 insertions(+), 19 deletions(-)
>>>>>
>>>>> diff --git a/target-ppc/kvm_ppc.h b/target-ppc/kvm_ppc.h
>>>>> index bd1d78bfbe..14320c2378 100644
>>>>> --- a/target-ppc/kvm_ppc.h
>>>>> +++ b/target-ppc/kvm_ppc.h
>>>>> @@ -36,8 +36,9 @@ int kvmppc_booke_watchdog_enable(PowerPCCPU *cpu)=
;
>>>>>  #ifndef CONFIG_USER_ONLY
>>>>>  off_t kvmppc_alloc_rma(void **rma);
>>>>>  bool kvmppc_spapr_use_multitce(void);
>>>>> -void *kvmppc_create_spapr_tce(uint32_t liobn, uint32_t window_size=
, int *pfd,
>>>>> -                              bool need_vfio);
>>>>> +void *kvmppc_create_spapr_tce(uint32_t liobn, uint32_t page_shift,=

>>>>> +                              uint64_t bus_offset, uint32_t nb_tab=
le,
>>>>> +                              int *pfd, bool need_vfio);
>>>>>  int kvmppc_remove_spapr_tce(void *table, int pfd, uint32_t window_=
size);
>>>>>  int kvmppc_reset_htab(int shift_hint);
>>>>>  uint64_t kvmppc_rma_size(uint64_t current_size, unsigned int hash_=
shift);
>>>>> @@ -168,9 +169,10 @@ static inline bool kvmppc_spapr_use_multitce(v=
oid)
>>>>>      return false;
>>>>>  }
>>>>> =20
>>>>> -static inline void *kvmppc_create_spapr_tce(uint32_t liobn,
>>>>> -                                            uint32_t window_size, =
int *fd,
>>>>> -                                            bool need_vfio)
>>>>> +static inline void *kvmppc_create_spapr_tce(uint32_t liobn, uint32=
_t page_shift,
>>>>> +                                            uint64_t bus_offset,
>>>>> +                                            uint32_t nb_table,
>>>>> +                                            int *pfd, bool need_vf=
io)
>>>>>  {
>>>>>      return NULL;
>>>>>  }
>>>>> diff --git a/hw/ppc/spapr_iommu.c b/hw/ppc/spapr_iommu.c
>>>>> index ae30bbe30f..29c80bb3c8 100644
>>>>> --- a/hw/ppc/spapr_iommu.c
>>>>> +++ b/hw/ppc/spapr_iommu.c
>>>>> @@ -79,15 +79,16 @@ static IOMMUAccessFlags spapr_tce_iommu_access_=
flags(uint64_t tce)
>>>>> =20
>>>>>  static uint64_t *spapr_tce_alloc_table(uint32_t liobn,
>>>>>                                         uint32_t page_shift,
>>>>> +                                       uint64_t bus_offset,
>>>>>                                         uint32_t nb_table,
>>>>>                                         int *fd,
>>>>>                                         bool need_vfio)
>>>>>  {
>>>>>      uint64_t *table =3D NULL;
>>>>> -    uint64_t window_size =3D (uint64_t)nb_table << page_shift;
>>>>> =20
>>>>> -    if (kvm_enabled() && !(window_size >> 32)) {
>>>>> -        table =3D kvmppc_create_spapr_tce(liobn, window_size, fd, =
need_vfio);
>>>>> +    if (kvm_enabled()) {
>>>>
>>>> This is broken.  Previously, if we had a >4GiB window, we'd fall bac=
k
>>>> to managing it in userspace, which would work, albeit slowly.  Now, =
if
>>>> you have an older kernel which doesn't support KVM_CAP_SPAPR_TCE_64 =
it
>>>> will attempt to allocate it in the kernel, and fail completely.
>>>
>>>
>>> No, kvmppc_create_spapr_tce() would return NULL and right after that =
there
>>> is a "if (!table)" (it can be seen at the end of this chunk) to handl=
e the
>>> failure.
>>
>> Oh, yes, sorry.  For some reason I thought there was a return in that
>> if block.
>=20
>=20
>=20
> This was the only comment which turned out to be not a bug, what now? :=
)
>=20
>=20
>>
>>>>
>>>>> +        table =3D kvmppc_create_spapr_tce(liobn, page_shift, bus_o=
ffset, nb_table,
>>>>> +                                        fd, need_vfio);
>>>>>      }
>>>>> =20
>>>>>      if (!table) {
>>>>> @@ -342,6 +343,7 @@ void spapr_tce_table_enable(sPAPRTCETable *tcet=
,
>>>>>      tcet->nb_table =3D nb_table;
>>>>>      tcet->table =3D spapr_tce_alloc_table(tcet->liobn,
>>>>>                                          tcet->page_shift,
>>>>> +                                        tcet->bus_offset,
>>>>>                                          tcet->nb_table,
>>>>>                                          &tcet->fd,
>>>>>                                          tcet->need_vfio);
>>>>> diff --git a/target-ppc/kvm.c b/target-ppc/kvm.c
>>>>> index 9c4834c4fc..6e91a4d8bb 100644
>>>>> --- a/target-ppc/kvm.c
>>>>> +++ b/target-ppc/kvm.c
>>>>> @@ -71,6 +71,7 @@ static int cap_booke_sregs;
>>>>>  static int cap_ppc_smt;
>>>>>  static int cap_ppc_rma;
>>>>>  static int cap_spapr_tce;
>>>>> +static int cap_spapr_tce_64;
>>>>>  static int cap_spapr_multitce;
>>>>>  static int cap_spapr_vfio;
>>>>>  static int cap_hior;
>>>>> @@ -123,6 +124,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s=
)
>>>>>      cap_ppc_smt =3D kvm_check_extension(s, KVM_CAP_PPC_SMT);
>>>>>      cap_ppc_rma =3D kvm_check_extension(s, KVM_CAP_PPC_RMA);
>>>>>      cap_spapr_tce =3D kvm_check_extension(s, KVM_CAP_SPAPR_TCE);
>>>>> +    cap_spapr_tce_64 =3D kvm_check_extension(s, KVM_CAP_SPAPR_TCE_=
64);
>>>>>      cap_spapr_multitce =3D kvm_check_extension(s, KVM_CAP_SPAPR_MU=
LTITCE);
>>>>>      cap_spapr_vfio =3D false;
>>>>>      cap_one_reg =3D kvm_check_extension(s, KVM_CAP_ONE_REG);
>>>>> @@ -2201,13 +2203,10 @@ bool kvmppc_spapr_use_multitce(void)
>>>>>      return cap_spapr_multitce;
>>>>>  }
>>>>> =20
>>>>> -void *kvmppc_create_spapr_tce(uint32_t liobn, uint32_t window_size=
, int *pfd,
>>>>> -                              bool need_vfio)
>>>>> +void *kvmppc_create_spapr_tce(uint32_t liobn, uint32_t page_shift,=

>>>>> +                              uint64_t bus_offset, uint32_t nb_tab=
le,
>>>>> +                              int *pfd, bool need_vfio)
>>>>>  {
>>>>> -    struct kvm_create_spapr_tce args =3D {
>>>>> -        .liobn =3D liobn,
>>>>> -        .window_size =3D window_size,
>>>>> -    };
>>>>>      long len;
>>>>>      int fd;
>>>>>      void *table;
>>>>> @@ -2220,14 +2219,41 @@ void *kvmppc_create_spapr_tce(uint32_t liob=
n, uint32_t window_size, int *pfd,
>>>>>          return NULL;
>>>>>      }
>>>>> =20
>>>>> -    fd =3D kvm_vm_ioctl(kvm_state, KVM_CREATE_SPAPR_TCE, &args);
>>>>> -    if (fd < 0) {
>>>>> -        fprintf(stderr, "KVM: Failed to create TCE table for liobn=
 0x%x\n",
>>>>> -                liobn);
>>>>> +    if (cap_spapr_tce_64) {
>>>>> +        struct kvm_create_spapr_tce_64 args =3D {
>>>>> +            .liobn =3D liobn,
>>>>> +            .page_shift =3D page_shift,
>>>>> +            .offset =3D bus_offset >> page_shift,
>>>>> +            .size =3D nb_table,
>>>>> +            .flags =3D 0
>>>>> +        };
>>>>> +        fd =3D kvm_vm_ioctl(kvm_state, KVM_CREATE_SPAPR_TCE_64, &a=
rgs);
>>>>> +        if (fd < 0) {
>>>>> +            fprintf(stderr,
>>>>> +                    "KVM: Failed to create TCE64 table for liobn 0=
x%x\n",
>>>>> +                    liobn);
>>>>> +            return NULL;
>>>>> +        }
>>>>> +    } else if (cap_spapr_tce) {
>>>>> +        uint64_t window_size =3D (uint64_t) nb_table << page_shift=
;
>>>>> +        struct kvm_create_spapr_tce args =3D {
>>>>> +            .liobn =3D liobn,
>>>>> +            .window_size =3D window_size,
>>>>> +        };
>>>>> +        if ((window_size !=3D args.window_size) || bus_offset) {
>>>>> +            return NULL;
>>>>> +        }
>>>>> +        fd =3D kvm_vm_ioctl(kvm_state, KVM_CREATE_SPAPR_TCE, &args=
);
>>>>> +        if (fd < 0) {
>>>>> +            fprintf(stderr, "KVM: Failed to create TCE table for l=
iobn 0x%x\n",
>>>>> +                    liobn);
>>>>> +            return NULL;
>>>>> +        }
>>>>> +    } else {
>>>>>          return NULL;
>>>>>      }
>>>>> =20
>>>>> -    len =3D (window_size / SPAPR_TCE_PAGE_SIZE) * sizeof(uint64_t)=
;
>>>>> +    len =3D nb_table * sizeof(uint64_t);
>>>>>      /* FIXME: round this up to page size */
>>>>> =20
>>>>>      table =3D mmap(NULL, len, PROT_READ|PROT_WRITE, MAP_SHARED, fd=
, 0);
>>>>
>>>
>>>
>>
>>
>>
>>
>=20
>=20


--=20
Alexey


--MaO3lL27rhQrTq6lvtptcIGWNsMosHLbW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIrBAEBCAAVBQJYv40yDhxhaWtAb3psYWJzLnJ1AAoJEIYTPdgrwSC5sZ4P/iGu
2m74QxaQKVGHe67uwQzDO7dEm0tdJRnUZ/vTN+np7oc0CgpQcn/5YxM12QIdxmLH
92EYV9LZt9DalAm9ylWIa808ji2Xp5hEz+G1fhpC4YM320SR4QiYvk1zuPonr+vQ
iIaGXqDNy/wH82SOwF6+jGUT4ACjJjzgaISQp8VMNCVKjcl2xAgYCQIEJC6rnmVp
fN+Rwc+wW3o/ynkjVv1w5cKqk154NO5H06AMVFsscilRujbw1Pw4DfsK46huIkI4
H7waPI3mq7cBGaJ1lXTH4zkv7qksIXjvcmajE+jtnnjp7TJpgisxRiKGAcGOYVPk
1ojySekp3l3L3lm8fp4T/ocJZVo3+Goy1cDG2GQT7HoByzumxg1C/X+fM/qkMEnv
QLfKKNVciepmKMQsCptIjie5h1LEgzKwulEQCxLCYul/FoxKOMOPvC47v0GPjVis
u7SpI9UF+NTtVUC/nROo67F0HIhCtFpbVIot88FkW9mi+jHcZTZEKR0R9Q9yHUtf
/g6vILhvEQEjHov9u+uX34X7UKC+IjqdlH2v5PuqXVhUkriYDMXZa6dRx9QgNPPx
2YE7AhbSBmkgHS3s+XSlwdWT4Lu38s4o2eHBGOFTXtseCMqWm7Lh9QJlenGX/zlN
DvZUmW0NiA0OhXKBI220AcEqTH5MUa6EOOUOYwtO
=xIfa
-----END PGP SIGNATURE-----

--MaO3lL27rhQrTq6lvtptcIGWNsMosHLbW--
