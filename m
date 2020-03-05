Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E4C7C3F2CD
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 14:11:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E272820709
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 14:11:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E272820709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49814 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9rE3-0000oa-48
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 09:11:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59500)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frankja@linux.ibm.com>) id 1j9rDC-0000MH-Ff
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 09:10:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frankja@linux.ibm.com>) id 1j9rDA-0007D0-TI
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 09:10:54 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39720
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <frankja@linux.ibm.com>)
 id 1j9rDA-0007Cf-Ny
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 09:10:52 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 025EAdqN165059
 for <qemu-devel@nongnu.org>; Thu, 5 Mar 2020 09:10:52 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2yhsv569dd-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2020 09:10:51 -0500
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <frankja@linux.ibm.com>;
 Thu, 5 Mar 2020 14:10:22 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
 by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 5 Mar 2020 14:10:18 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 025EAHBg45940882
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 5 Mar 2020 14:10:17 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CA1C252051;
 Thu,  5 Mar 2020 14:10:17 +0000 (GMT)
Received: from dyn-9-152-224-184.boeblingen.de.ibm.com (unknown
 [9.152.224.184])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 953065204E;
 Thu,  5 Mar 2020 14:10:17 +0000 (GMT)
Subject: Re: [PATCH v6 03/18] s390x: protvirt: Support unpack facility
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20200304114231.23493-1-frankja@linux.ibm.com>
 <20200304114231.23493-4-frankja@linux.ibm.com>
 <2a93ff2e-4955-67c4-e7af-766a49fc8b32@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; prefer-encrypt=mutual; keydata=
 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
Date: Thu, 5 Mar 2020 15:10:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <2a93ff2e-4955-67c4-e7af-766a49fc8b32@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="lQS5zONEYGh3j8melRoum74511R1QPb1l"
X-TM-AS-GCONF: 00
x-cbid: 20030514-0020-0000-0000-000003B0C88D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20030514-0021-0000-0000-000022090446
Message-Id: <8fcf6bcf-137c-b488-64b3-4c0bce48b909@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-03-05_04:2020-03-05,
 2020-03-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxscore=0
 clxscore=1015 mlxlogscore=999 impostorscore=0 malwarescore=0 adultscore=0
 phishscore=0 suspectscore=11 spamscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003050092
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: borntraeger@de.ibm.com, qemu-s390x@nongnu.org, cohuck@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lQS5zONEYGh3j8melRoum74511R1QPb1l
Content-Type: multipart/mixed; boundary="msq13iUDB7SIBJuBaEZbcSHA403DRaiKv"

--msq13iUDB7SIBJuBaEZbcSHA403DRaiKv
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 3/5/20 2:51 PM, David Hildenbrand wrote:
> On 04.03.20 12:42, Janosch Frank wrote:
>> When a guest has saved a ipib of type 5 and calls diagnose308 with
>=20
> s/a/an/
>=20
>> subcode 10, we have to setup the protected processing environment via
>> Ultravisor calls. The calls are done by KVM and are exposed via an
>> API.
>>
>> The following steps are necessary:
>> 1. Enable protected mode for the VM (register it and its cpus with the=
 Ultravisor)
>> 2. Forward the secure header to the Ultravisor (has all information on=

>> how to decrypt the image and VM information)
>> 3. Protect image pages from the host and decrypt them
>> 4. Verify the image integrity
>>
>> Only after step 4 a protected VM is allowed to run.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com> [Changes=

>> to machine]
>> ---
>>  hw/s390x/Makefile.objs              |   1 +
>>  hw/s390x/ipl.c                      |  33 +++++++++
>>  hw/s390x/ipl.h                      |   2 +
>>  hw/s390x/pv.c                       | 106 +++++++++++++++++++++++++++=
+
>>  hw/s390x/pv.h                       |  34 +++++++++
>>  hw/s390x/s390-virtio-ccw.c          |  91 ++++++++++++++++++++++++
>>  include/hw/s390x/s390-virtio-ccw.h  |   1 +
>>  target/s390x/cpu.c                  |   4 ++
>>  target/s390x/cpu.h                  |   1 +
>>  target/s390x/cpu_features_def.inc.h |   1 +
>>  10 files changed, 274 insertions(+)
>>  create mode 100644 hw/s390x/pv.c
>>  create mode 100644 hw/s390x/pv.h
>=20
> [...]
>=20
>> =20
>>  #define KERN_IMAGE_START                0x010000UL
>>  #define LINUX_MAGIC_ADDR                0x010008UL
>> @@ -676,6 +677,38 @@ static void s390_ipl_prepare_qipl(S390CPU *cpu)
>>      cpu_physical_memory_unmap(addr, len, 1, len);
>>  }
>> =20
>> +int s390_ipl_prepare_pv_header(void)
>> +{
>> +    S390IPLState *ipl =3D get_ipl_device();
>> +    IPLBlockPV *ipib_pv =3D &ipl->iplb_pv.pv;
>> +    void *hdr =3D g_malloc(ipib_pv->pv_header_len);
>> +    int rc;
>> +
>> +    cpu_physical_memory_read(ipib_pv->pv_header_addr, hdr,
>> +                             ipib_pv->pv_header_len);
>> +    rc =3D s390_pv_set_sec_parms((uint64_t)hdr,
>> +                          ipib_pv->pv_header_len);
>> +    g_free(hdr);
>> +    return rc;
>> +}
>> +
>> +int s390_ipl_pv_unpack(void)
>> +{
>> +    int i, rc =3D 0;
>> +    S390IPLState *ipl =3D get_ipl_device();
>> +    IPLBlockPV *ipib_pv =3D &ipl->iplb_pv.pv;
>> +
>> +    for (i =3D 0; i < ipib_pv->num_comp; i++) {
>> +        rc =3D s390_pv_unpack(ipib_pv->components[i].addr,
>> +                            TARGET_PAGE_ALIGN(ipib_pv->components[i].=
size),
>> +                            ipib_pv->components[i].tweak_pref);
>> +        if (rc) {
>> +            break;
>> +        }
>=20
> You can check for " && !rc" in the loop condition

Not sure if that would make it more readable...

>=20
>> +    }
>> +    return rc;
>> +}
>> +
>>  void s390_ipl_prepare_cpu(S390CPU *cpu)
>>  {
>>      S390IPLState *ipl =3D get_ipl_device();
>> diff --git a/hw/s390x/ipl.h b/hw/s390x/ipl.h
>> index 04be63cee1..ad8090a02c 100644
>> --- a/hw/s390x/ipl.h
>> +++ b/hw/s390x/ipl.h
>> @@ -105,6 +105,8 @@ typedef union IplParameterBlock IplParameterBlock;=

>>  int s390_ipl_set_loadparm(uint8_t *loadparm);
>>  int s390_ipl_pv_check_components(IplParameterBlock *iplb);
>>  void s390_ipl_update_diag308(IplParameterBlock *iplb);
>> +int s390_ipl_prepare_pv_header(void);
>> +int s390_ipl_pv_unpack(void);
>>  void s390_ipl_prepare_cpu(S390CPU *cpu);
>>  IplParameterBlock *s390_ipl_get_iplb(void);
>>  IplParameterBlock *s390_ipl_get_iplb_secure(void);
>> diff --git a/hw/s390x/pv.c b/hw/s390x/pv.c
>> new file mode 100644
>> index 0000000000..50b68b6c34
>> --- /dev/null
>> +++ b/hw/s390x/pv.c
>> @@ -0,0 +1,106 @@
>> +/*
>> + * Secure execution functions
>> + *
>> + * Copyright IBM Corp. 2020
>> + * Author(s):
>> + *  Janosch Frank <frankja@linux.ibm.com>
>> + *
>> + * This work is licensed under the terms of the GNU GPL, version 2 or=
 (at
>> + * your option) any later version. See the COPYING file in the top-le=
vel
>> + * directory.
>> + */
>> +#include "qemu/osdep.h"
>> +#include <sys/ioctl.h>
>> +
>> +#include <linux/kvm.h>
>> +
>> +#include "qemu/error-report.h"
>> +#include "sysemu/kvm.h"
>> +#include "pv.h"
>> +
>> +const char *cmd_names[] =3D {
>> +    "VM_ENABLE",
>> +    "VM_DISABLE",
>> +    "VM_SET_SEC_PARAMS",
>> +    "VM_UNPACK",
>> +    "VM_VERIFY",
>> +    "VM_PREP_RESET",
>> +    "VM_UNSHARE_ALL",
>> +    NULL
>=20
> Is the NULL really needed? This will be somewhat error prone when we ad=
d
> new PV commands. Not sure if guarding this by an access function (chack=

> against ARRAY_SIZE() makes sense).
>=20
>> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
>> index a89cf4c129..dd39890f89 100644
>> --- a/hw/s390x/s390-virtio-ccw.c
>> +++ b/hw/s390x/s390-virtio-ccw.c
>> @@ -41,6 +41,8 @@
>>  #include "hw/qdev-properties.h"
>>  #include "hw/s390x/tod.h"
>>  #include "sysemu/sysemu.h"
>> +#include "hw/s390x/pv.h"
>> +#include <linux/kvm.h>
>> =20
>>  S390CPU *s390_cpu_addr2state(uint16_t cpu_addr)
>>  {
>> @@ -238,9 +240,11 @@ static void s390_create_sclpconsole(const char *t=
ype, Chardev *chardev)
>>  static void ccw_init(MachineState *machine)
>>  {
>>      int ret;
>> +    S390CcwMachineState *ms =3D S390_CCW_MACHINE(machine);
>>      VirtualCssBus *css_bus;
>>      DeviceState *dev;
>> =20
>> +    ms->pv =3D false;
>=20
> Should not be necessary, default is false.

ok

>=20
>>      s390_sclp_init();
>>      /* init memory + setup max page size. Required for the CPU model =
*/
>>      s390_memory_init(machine->ram);
>> @@ -316,10 +320,75 @@ static inline void s390_do_cpu_ipl(CPUState *cs,=
 run_on_cpu_data arg)
>>      s390_cpu_set_state(S390_CPU_STATE_OPERATING, cpu);
>>  }
>> =20
>> +static void s390_machine_unprotect(S390CcwMachineState *ms)
>> +{
>> +    CPUState *t;
>> +
>> +    if (!ms->pv)
>> +        return;
>=20
> How can this ever happen? g_assert(ms->pv) ?

Currently not, that's only used in the follow up patches with the ballon
and migration blocker

>=20
> Also, i don't see this function getting called from anywhere else excep=
t
> when s390_machine_protect() fails. That looks wrong. This has to be
> called when going out of PV mode.

Yes, but that's in the diag308 1-4 patch.

>=20
>=20
>> +    s390_pv_vm_disable();
>> +    CPU_FOREACH(t) {
>> +        S390_CPU(t)->env.pv =3D false;
>> +    }
>> +    ms->pv =3D false;
>> +}
>> +
>> +static int s390_machine_protect(S390CcwMachineState *ms)
>> +{
>> +    CPUState *t;
>> +    int rc;
>> +
>=20
> g_assert(!ms->pv) ?

Ok

>=20
>> +    /* Create SE VM */
>> +    rc =3D s390_pv_vm_enable();
>> +    if (rc) {
>> +        return rc;
>> +    }
>> +
>> +    CPU_FOREACH(t) {
>> +        S390_CPU(t)->env.pv =3D true;
>> +    }
>> +    ms->pv =3D true;
>> +
>> +    /* Set SE header and unpack */
>> +    rc =3D s390_ipl_prepare_pv_header();
>> +    if (rc) {
>> +        goto out_err;
>> +    }
>> +
>> +    /* Decrypt image */
>> +    rc =3D s390_ipl_pv_unpack();
>> +    if (rc) {
>> +        goto out_err;
>> +    }
>> +
>> +    /* Verify integrity */
>> +    rc =3D s390_pv_verify();
>> +    if (rc) {
>> +        goto out_err;
>> +    }
>> +    return rc;
>> +
>> +out_err:
>> +    s390_machine_unprotect(ms);
>> +    return rc;
>> +}
>> +
>> +#define DIAG_308_RC_INVAL_FOR_PV    0x0a02
>> +static void s390_machine_inject_pv_error(CPUState *cs)
>> +{
>> +    int r1 =3D (cs->kvm_run->s390_sieic.ipa & 0x00f0) >> 4;
>> +    CPUS390XState *env =3D &S390_CPU(cs)->env;
>> +
>> +    /* Report that we are unable to enter protected mode */
>> +    env->regs[r1 + 1] =3D DIAG_308_RC_INVAL_FOR_PV;
>> +}
>> +
>=20
> [...]
>>      switch (reset_type) {
>>      case S390_RESET_EXTERNAL:
>>      case S390_RESET_REIPL:
>> @@ -353,6 +424,26 @@ static void s390_machine_reset(MachineState *mach=
ine)
>>          }
>>          subsystem_reset();
>>          run_on_cpu(cs, s390_do_cpu_initial_reset, RUN_ON_CPU_NULL);
>> +        run_on_cpu(cs, s390_do_cpu_load_normal, RUN_ON_CPU_NULL);
>=20
> This does look unrelated and wrong?

Indeed, that looks dodgy

>=20
>> +        break;
>> +    case S390_RESET_PV: /* Subcode 10 */
>> +        subsystem_reset();
>> +        s390_crypto_reset();
>> +
>> +        CPU_FOREACH(t) {
>> +            if (t =3D=3D cs) {
>> +                continue;
>> +            }
>> +            run_on_cpu(t, s390_do_cpu_full_reset, RUN_ON_CPU_NULL);
>> +        }
>> +        run_on_cpu(cs, s390_do_cpu_reset, RUN_ON_CPU_NULL);
>> +
>> +        if (s390_machine_protect(ms)) {
>> +            s390_machine_inject_pv_error(cs);
>=20
> Ah, so it's not an actual exception. BUT: All other guest cpus were
> reset, can the guest deal with that?

Well, all other CPUs should be stopped for diag308, no?
Also it's done by the bootloader and not a OS which just stops its cpus
and goes into protected mode.

>=20
> (run_on_cpu(cs, s390_do_cpu_reset, RUN_ON_CPU_NULL) should go after the=

> s390_machine_protect() I assume - the change you had in the other patch=
)

That's not a good idea, I want to reset before we automatically call the
UV routines on a reset.

>=20
>> +            s390_cpu_set_state(S390_CPU_STATE_OPERATING, cpu);
>> +            return;
>> +        }
>> +
>>          run_on_cpu(cs, s390_do_cpu_load_normal, RUN_ON_CPU_NULL);
>>          break;
>>      default:
>=20
>=20



--msq13iUDB7SIBJuBaEZbcSHA403DRaiKv--

--lQS5zONEYGh3j8melRoum74511R1QPb1l
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl5hCEkACgkQ41TmuOI4
ufgY8hAAqLzP4V08wLz5SlYS09tuh1wxDl5zsq3DUds4dVjDuCHz9qIZWwZT6aLE
iuVMpdWtNzZadF4ank+3SVO66xb0iYgdXTxf354AlBzFi/YZOxtFxI2/ISLmvwOn
AFjtiMtgEVeQIdeAT+oPuCEZJ8RLCx0rKH+vNMeB0+GOOh0CkC2F7TJ7VQHIRAFf
LmGRpS4fCndJku+J183p2/aRc0wTbT5RjSnByDSG10sdL3uAv2vPPncxxkdxritZ
5+IAt/WSFaHmN7NhXYBG9X2qP+A5e6oOK6Ahfxtibqis4YBmKE6Uxm2M13QUGORh
S23fLNXI7EQ9Fe1dzEHPrlj3vbw1Ae1tLXisT3xi/1Up5ftxTVErLHpj7iugBNHb
XgnSovaRGay5k4iTI66YtvxXwnYU6ZH6a9T471E1jG1y7RijA7BMX2zGy3QQaJjh
UVk/I0clbupdruc7W1meqEkJmnZlos9Qrr8pZY8LObr8vJO9VhBsoh9c6ME5rmwX
rLgZUxrEF6lNTY/9tZJFVOSaRb4IFcyo1ZartYU64QKFG57RYW7tU05WgdtvlltD
uKhBoZx0ae3nxeSLHqPJiUsi2nBCiIPnH+NxQBZyD736Ep3r7O270KTFtaN+84Qm
i5i59yMEZCe4gPwBgkSzSwKXPu6KMX4jJh/RWJUY+peSZYxD6fw=
=4lWz
-----END PGP SIGNATURE-----

--lQS5zONEYGh3j8melRoum74511R1QPb1l--


