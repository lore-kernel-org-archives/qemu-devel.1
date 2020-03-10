Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34C42C10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 15:50:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6D6020866
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 15:50:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6D6020866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBh8w-0000TO-6D
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 11:50:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52763)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frankja@linux.ibm.com>) id 1jBh8H-0008O7-G2
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 11:49:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frankja@linux.ibm.com>) id 1jBh8G-0000sq-0C
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 11:49:25 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55842)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <frankja@linux.ibm.com>)
 id 1jBh8F-0000mX-L5
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 11:49:23 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 02AFkiHE110533
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2020 11:49:22 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ym85239b9-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2020 11:49:19 -0400
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <frankja@linux.ibm.com>;
 Tue, 10 Mar 2020 15:49:13 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
 by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 10 Mar 2020 15:49:09 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 02AFn8EW51314758
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Mar 2020 15:49:08 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B1E3C52051;
 Tue, 10 Mar 2020 15:49:08 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.23.214])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 60C5E5204F;
 Tue, 10 Mar 2020 15:49:08 +0000 (GMT)
Subject: Re: [PATCH v8 02/15] s390x: protvirt: Support unpack facility
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20200310134008.130038-1-frankja@linux.ibm.com>
 <20200310134008.130038-3-frankja@linux.ibm.com>
 <6e8508a7-4f8a-fca7-4ca7-4d598b0ccb84@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; prefer-encrypt=mutual; keydata=
 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
Date: Tue, 10 Mar 2020 16:49:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <6e8508a7-4f8a-fca7-4ca7-4d598b0ccb84@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="JKig9r0of6biwk7rHKuixOQ5qufMIAiZj"
X-TM-AS-GCONF: 00
x-cbid: 20031015-0028-0000-0000-000003E2C4A5
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20031015-0029-0000-0000-000024A80625
Message-Id: <f80eddaa-37e2-f152-82a6-3aa66a8d5691@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-03-10_10:2020-03-10,
 2020-03-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003100101
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
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
--JKig9r0of6biwk7rHKuixOQ5qufMIAiZj
Content-Type: multipart/mixed; boundary="ii2r7qVCVvgodXSNWKupuXN08TB2vNlFu"

--ii2r7qVCVvgodXSNWKupuXN08TB2vNlFu
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 3/10/20 4:26 PM, David Hildenbrand wrote:
> On 10.03.20 14:39, Janosch Frank wrote:
>> The unpack facility provides the means to setup a protected guest. A
>> protected guest can not be introspected by the hypervisor or any
>=20
> "cannot"
>=20
>> user/administrator of the machine it is running on.
>>
>> Protected guests are encrypted at rest and need a special boot
>> mechanism via diag308 subcode 8 and 10.
>>
>> Code 8 sets the PV specific IPLB which is retained seperately from
>=20
> "separately"

Time to find out why my flyspel hooks are failing...

>=20
>> those set via code 5.
>>
>> Code 10 is used to unpack the VM into protected memory, verify its
>> integrity and start it.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> Co-developed-by: Christian Borntraeger <borntraeger@de.ibm.com> [Chang=
es
>> to machine]
>=20
> [...]
>=20
>> +static inline bool ipl_valid_pv_components(IplParameterBlock *iplb)
>> +{
>> +    IPLBlockPV *ipib_pv =3D &iplb->pv;
>> +    int i;
>> +
>> +    if (ipib_pv->num_comp =3D=3D 0) {
>> +        return false;
>> +    }
>> +
>> +    for (i =3D 0; i < ipib_pv->num_comp; i++) {
>> +        /* Addr must be 4k aligned */
>> +        if (ipib_pv->components[i].addr & ~TARGET_PAGE_MASK) {
>=20
> I usually find
>=20
> QEMU_IS_ALIGNED(ipib_pv->components[i].addr, TARGET_PAGE_MASK)
>=20
> nicer
>=20
> [...]

huh, didn't know it existed.
I'll have a try with it.

>=20
>> diff --git a/hw/s390x/pv.c b/hw/s390x/pv.c
>> new file mode 100644
>> index 0000000000..1ba8bc7242
>> --- /dev/null
>> +++ b/hw/s390x/pv.c
>> @@ -0,0 +1,104 @@
>> +/*
>> + * Protected Virtualization functions
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
>> +};
>> +
>> +static int s390_pv_cmd(uint32_t cmd, void *data)
>> +{
>> +    int rc;
>=20
> reverse x... :)

ack
Just FYI, I like christmas trees the right side up

>=20
>> +    struct kvm_pv_cmd pv_cmd =3D {
>> +        .cmd =3D cmd,
>> +        .data =3D (uint64_t)data,
>> +    };
>> +
>=20
> and then maybe
>=20
> int rc =3D  ...

Ack

>=20
>> +    rc =3D kvm_vm_ioctl(kvm_state, KVM_S390_PV_COMMAND, &pv_cmd);
>> +    if (rc) {
>> +        error_report("KVM PV command %d (%s) failed: header rc %x rrc=
 %x "
>> +                     "IOCTL rc: %d", cmd, cmd_names[cmd], pv_cmd.rc, =
pv_cmd.rrc,
>> +                     rc);
>> +    }
>> +    return rc;
>> +}
>> +
>> +static void s390_pv_cmd_exit(uint32_t cmd, void *data)
>> +{
>> +    int rc;
>> +
>> +    rc =3D s390_pv_cmd(cmd, data);
>=20
> int rc =3D ...

Ack

>=20
>> +    if (rc) {
>> +        exit(1);
>> +    }
>> +}
>> +
>=20
> [...]
>=20
>> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
>> index 895498cca6..455ad31718 100644
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
>> @@ -316,10 +318,80 @@ static inline void s390_do_cpu_ipl(CPUState *cs,=
 run_on_cpu_data arg)
>>      s390_cpu_set_state(S390_CPU_STATE_OPERATING, cpu);
>>  }
>> =20
>> +static void s390_machine_unprotect(S390CcwMachineState *ms)
>> +{
>> +
>=20
> superfluous empty line
>=20
>> +    s390_pv_vm_disable();
>> +    ms->pv =3D false;
>> +}
>> +
>=20
> [...]

Ack

>=20
>> diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
>> index 3dd396e870..bcb9e47767 100644
>> --- a/target/s390x/cpu.c
>> +++ b/target/s390x/cpu.c
>> @@ -37,6 +37,8 @@
>>  #include "sysemu/hw_accel.h"
>>  #include "hw/qdev-properties.h"
>>  #ifndef CONFIG_USER_ONLY
>> +#include "hw/s390x/s390-virtio-ccw.h"
>> +#include "hw/s390x/pv.h"
>=20
> Do you need that include here? I don't think so.
>=20
>>  #include "hw/boards.h"
>>  #include "sysemu/arch_init.h"
>>  #include "sysemu/sysemu.h"
>> @@ -174,6 +176,27 @@ static void s390_cpu_disas_set_info(CPUState *cpu=
, disassemble_info *info)
>>      info->print_insn =3D print_insn_s390;
>>  }
>> =20
>> +#if !defined(CONFIG_USER_ONLY)
>> +bool s390_is_pv(void)
>> +{
>> +    static S390CcwMachineState *ccw;
>> +    Object *obj;
>> +
>> +    if (ccw) {
>> +        return ccw->pv;
>> +    }
>> +
>> +    /* we have to bail out for the "none" machine */
>> +    obj =3D object_dynamic_cast(qdev_get_machine(),
>> +                              TYPE_S390_CCW_MACHINE);
>> +    if (!obj) {
>> +        return false;
>> +    }
>> +    ccw =3D S390_CCW_MACHINE(obj);
>> +    return ccw->pv;
>> +}
>> +#endif
>> +
>=20
> Nit: I *think* this would be better placed in hw/s390x/pv.h

I'll think about it

>=20
>>  static void s390_cpu_realizefn(DeviceState *dev, Error **errp)
>>  {
>>      CPUState *cs =3D CPU(dev);
>> diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
>> index 1d17709d6e..8fa25d9ed5 100644
>> --- a/target/s390x/cpu.h
>> +++ b/target/s390x/cpu.h
>> @@ -762,6 +762,7 @@ static inline void s390_do_cpu_load_normal(CPUStat=
e *cs, run_on_cpu_data arg)
>> =20
>> =20
>>  /* cpu.c */
>> +bool s390_is_pv(void);
>=20
> Wonder if this will compile with CONFIG_USER_ONLY (maybe we need a
> "return false" dummy). I assume you test-compiled that with all variant=
s
> (CONFIG_TCG, CONFIG_USER_ONLY, ...)

Oh, right...

>=20
>=20
> .. we're almost there ... :)
>=20



--ii2r7qVCVvgodXSNWKupuXN08TB2vNlFu--

--JKig9r0of6biwk7rHKuixOQ5qufMIAiZj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl5ntvMACgkQ41TmuOI4
ufiyfQ/+PjKbJLZgdcA4mW+0WgY1/XbIvXsR9Z+LTGOXtWaL0NW5PXTUNj6nPmxL
aAGv0c4GsQDeLMvvUJXowefzDfkwyVf/Mo6ZtgOzPo5jGv7/xiiurYiXbC9nanQl
vL0YumcAx3d++22P6H68NUwvhiMcGhgVzO3jd511w+f2/oPjhPtB6OSWtk/XvuEx
SjJKBA8877cEj16/V6bN350RK35bFuXpS4HD+FDT6qKTIF6SK/CnsKwpqg6kLuo8
oL2/FH8uA5lHqIVNcXqQgrg7IFL2tR2sSkX66E61vM9HG/SU7YXjNSfy+UaDu0RP
SO6SdlDB7jRdmAWfBpyjuLw3hYaxJ/FTBktTIzGAyyRx/4KfArsOV3rilUkqoiyU
vz8rQZ6AdOL4HzZw/OzAnpv2dW+i3zwngEoaRpj88KZKfYe+6wnHuwKn1mgWE6CT
clrIMm+MoSjJZ2/9HicXsMRtkp7gL3OwykZhIMNgeOkAFppsfj6dgckvrdrfWIhz
uTXEII46LMSdGN91RZftm2JofSSVpPfc572oLbsuO4201c4SAYRosXNo/gdspdSE
I4gAWVZqMIUaMPMZoFGvBCi5BQvybANvDFrNGu9GUrRf3b/ulfbISHGpt31+XTXy
PfYTnNzNDpH7glaAtRrrFGyMJ2Ed9I3U4PnThbQb//AeWJZUa4g=
=kkAT
-----END PGP SIGNATURE-----

--JKig9r0of6biwk7rHKuixOQ5qufMIAiZj--


