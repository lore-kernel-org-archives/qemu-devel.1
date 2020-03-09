Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5862FC10F27
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 15:46:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BA8C20578
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 15:46:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BA8C20578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45490 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBKbS-0003iP-7m
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 11:46:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40092)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frankja@linux.ibm.com>) id 1jBKYK-0007Oy-SX
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 11:42:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frankja@linux.ibm.com>) id 1jBKYI-0000p9-2M
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 11:42:48 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54588
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <frankja@linux.ibm.com>)
 id 1jBKYG-0000oJ-Ve
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 11:42:45 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 029FRUOa131081
 for <qemu-devel@nongnu.org>; Mon, 9 Mar 2020 11:42:43 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2ynmxfhnng-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2020 11:42:43 -0400
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <frankja@linux.ibm.com>;
 Mon, 9 Mar 2020 15:42:41 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
 by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 9 Mar 2020 15:42:38 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com
 [9.149.105.60])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 029FgcbR35258522
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 9 Mar 2020 15:42:38 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D17FB42045;
 Mon,  9 Mar 2020 15:42:37 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8DE3D42047;
 Mon,  9 Mar 2020 15:42:37 +0000 (GMT)
Received: from dyn-9-152-224-87.boeblingen.de.ibm.com (unknown [9.152.224.87])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Mon,  9 Mar 2020 15:42:37 +0000 (GMT)
Subject: Re: [PATCH v7 02/15] s390x: protvirt: Support unpack facility
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20200309112206.20261-1-frankja@linux.ibm.com>
 <20200309112206.20261-3-frankja@linux.ibm.com>
 <b608f7d8-81ac-1e5b-011d-bd576f77aade@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; prefer-encrypt=mutual; keydata=
 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
Date: Mon, 9 Mar 2020 16:42:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <b608f7d8-81ac-1e5b-011d-bd576f77aade@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="nDDmQMHUyI6kEnzdAkE4oaclA4P47oRhm"
X-TM-AS-GCONF: 00
x-cbid: 20030915-0008-0000-0000-0000035AD206
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20030915-0009-0000-0000-00004A7C127B
Message-Id: <ce634e32-a38f-056d-9cf9-76455fdab5d1@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-03-09_06:2020-03-09,
 2020-03-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0
 priorityscore=1501 clxscore=1015 phishscore=0 impostorscore=0 adultscore=0
 mlxscore=0 mlxlogscore=999 lowpriorityscore=0 spamscore=0 suspectscore=11
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003090105
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
--nDDmQMHUyI6kEnzdAkE4oaclA4P47oRhm
Content-Type: multipart/mixed; boundary="JCtwMVBCebEkJbKBEB3JFQsNkPjeTC1ST"

--JCtwMVBCebEkJbKBEB3JFQsNkPjeTC1ST
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 3/9/20 2:37 PM, David Hildenbrand wrote:
> On 09.03.20 12:21, Janosch Frank wrote:
>> The unpack facility provides the means to setup a protected guest. A
>> protected guest can not be introspected by the hypervisor or any
>> user/administrator of the machine it is running on.
>>
>> Protected guests are encrypted at rest and need a special boot
>> mechanism via diag308 subcode 8 and 10.
>>
>> Code 8 sets the PV specific IPLB which is retained seperately from
>> those set via code 5.
>>
>> Code 10 is used to unpack the VM into protected memory, verify its
>> integrity and start it.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com> [Changes=

>> to machine]
>=20
> As you signed this patch off, Maybe this should rather be a Co-develope=
d-by:
>=20

Ack

> [...]
>=20
>>  {
>>      S390IPLState *ipl =3D get_ipl_device();
>> @@ -561,7 +581,8 @@ void s390_ipl_reset_request(CPUState *cs, enum s39=
0_reset reset_type)
>>  {
>>      S390IPLState *ipl =3D get_ipl_device();
>> =20
>> -    if (reset_type =3D=3D S390_RESET_EXTERNAL || reset_type =3D=3D S3=
90_RESET_REIPL) {
>> +    if (reset_type =3D=3D S390_RESET_EXTERNAL || reset_type =3D=3D S3=
90_RESET_REIPL ||
>> +        reset_type =3D=3D S390_RESET_PV) {
>>          /* use CPU 0 for full resets */
>>          ipl->reset_cpu_index =3D 0;
>=20
> This looks wrong. In case of an error, you modify the registers of a
> theoretically unrelated CPU.

It does indeed, will fix.

>=20
>=20
>>      } else {
>> @@ -635,6 +656,38 @@ static void s390_ipl_prepare_qipl(S390CPU *cpu)
>>      cpu_physical_memory_unmap(addr, len, 1, len);
>>  }
>> =20
>> +int s390_ipl_prepare_pv_header(void)
>> +{
>> +    S390IPLState *ipl =3D get_ipl_device();
>> +    IPLBlockPV *ipib_pv =3D &ipl->iplb_pv.pv;
>> +    void *hdr =3D g_malloc(ipib_pv->pv_header_len);
>=20
> Should there be an upper limit? The guest can allocate quite some memor=
y
> this way and theoretically crash the VM.

Yes, it's currently two pages max.

>=20
>> +    int rc;
>> +
>> +    cpu_physical_memory_read(ipib_pv->pv_header_addr, hdr,
>> +                             ipib_pv->pv_header_len);
>=20
> Shouldn't we validate if this memory is accessible at all?

Yes, I moved the check into iplb_valid so we don't need to worry about
that here.

>=20
>> +    rc =3D s390_pv_set_sec_parms((uint64_t)hdr,
>> +                          ipib_pv->pv_header_len);
>> +    g_free(hdr);
>> +    return rc;
>> +}
>> +
>> +int s390_ipl_pv_unpack(void)
>> +{
>> +    int i, rc =3D 0;
>=20
> NIT: These declarations last.

Ack

>=20
>> +    S390IPLState *ipl =3D get_ipl_device();
>> +    IPLBlockPV *ipib_pv =3D &ipl->iplb_pv.pv;
>=20
> use s390_ipl_get_iplb_pv() and assert that we don't get NULL?

We already check for NULL in the diag code before the DIAG308_PV_START
reset is set. I've used your other suggestion though.

>=20
>> +
>> +    for (i =3D 0; i < ipib_pv->num_comp; i++) {
>> +        rc =3D s390_pv_unpack(ipib_pv->components[i].addr,
>> +                            TARGET_PAGE_ALIGN(ipib_pv->components[i].=
size),
>> +                            ipib_pv->components[i].tweak_pref);
>> +        if (rc) {
>> +            break;
>> +        }
>> +    }
>> +    return rc;
>> +}
>> +
>>  void s390_ipl_prepare_cpu(S390CPU *cpu)
>>  {
>>      S390IPLState *ipl =3D get_ipl_device();
>> diff --git a/hw/s390x/ipl.h b/hw/s390x/ipl.h
>> index d4813105db..b2ccdd9dae 100644
>> --- a/hw/s390x/ipl.h
>> +++ b/hw/s390x/ipl.h
>> @@ -15,6 +15,24 @@
>>  #include "cpu.h"
>>  #include "hw/qdev-core.h"
>> =20
>> +struct IPLBlockPVComp {
>> +    uint64_t tweak_pref;
>> +    uint64_t addr;
>> +    uint64_t size;
>> +} QEMU_PACKED;
>> +typedef struct IPLBlockPVComp IPLBlockPVComp;
>> +
>> +struct IPLBlockPV {
>> +    uint8_t  reserved18[87];    /* 0x18 */
>> +    uint8_t  version;           /* 0x6f */
>> +    uint32_t reserved70;        /* 0x70 */
>> +    uint32_t num_comp;          /* 0x70 */
>> +    uint64_t pv_header_addr;    /* 0x74 */
>> +    uint64_t pv_header_len;     /* 0x7c */
>> +    struct IPLBlockPVComp components[];
>> +} QEMU_PACKED;
>> +typedef struct IPLBlockPV IPLBlockPV;
>> +
>>  struct IplBlockCcw {
>>      uint8_t  reserved0[85];
>>      uint8_t  ssid;
>> @@ -71,6 +89,7 @@ union IplParameterBlock {
>>          union {
>>              IplBlockCcw ccw;
>>              IplBlockFcp fcp;
>> +            IPLBlockPV pv;
>>              IplBlockQemuScsi scsi;
>>          };
>>      } QEMU_PACKED;
>> @@ -85,8 +104,11 @@ typedef union IplParameterBlock IplParameterBlock;=

>> =20
>>  int s390_ipl_set_loadparm(uint8_t *loadparm);
>>  void s390_ipl_update_diag308(IplParameterBlock *iplb);
>> +int s390_ipl_prepare_pv_header(void);
>> +int s390_ipl_pv_unpack(void);
>>  void s390_ipl_prepare_cpu(S390CPU *cpu);
>>  IplParameterBlock *s390_ipl_get_iplb(void);
>> +IplParameterBlock *s390_ipl_get_iplb_pv(void);
>> =20
>>  enum s390_reset {
>>      /* default is a reset not triggered by a CPU e.g. issued by QMP *=
/
>> @@ -94,6 +116,7 @@ enum s390_reset {
>>      S390_RESET_REIPL,
>>      S390_RESET_MODIFIED_CLEAR,
>>      S390_RESET_LOAD_NORMAL,
>> +    S390_RESET_PV,
>>  };
>>  void s390_ipl_reset_request(CPUState *cs, enum s390_reset reset_type)=
;
>>  void s390_ipl_get_reset_request(CPUState **cs, enum s390_reset *reset=
_type);
>> @@ -133,6 +156,7 @@ struct S390IPLState {
>>      /*< private >*/
>>      DeviceState parent_obj;
>>      IplParameterBlock iplb;
>> +    IplParameterBlock iplb_pv;
>>      QemuIplParameters qipl;
>>      uint64_t start_addr;
>>      uint64_t compat_start_addr;
>> @@ -140,6 +164,7 @@ struct S390IPLState {
>>      uint64_t compat_bios_start_addr;
>>      bool enforce_bios;
>>      bool iplb_valid;
>> +    bool iplb_valid_pv;
>>      bool netboot;
>>      /* reset related properties don't have to be migrated or reset */=

>>      enum s390_reset reset_type;
>> @@ -161,9 +186,11 @@ QEMU_BUILD_BUG_MSG(offsetof(S390IPLState, iplb) &=
 3, "alignment of iplb wrong");
>> =20
>>  #define S390_IPL_TYPE_FCP 0x00
>>  #define S390_IPL_TYPE_CCW 0x02
>> +#define S390_IPL_TYPE_PV 0x05
>>  #define S390_IPL_TYPE_QEMU_SCSI 0xff
>> =20
>>  #define S390_IPLB_HEADER_LEN 8
>> +#define S390_IPLB_MIN_PV_LEN 148
>>  #define S390_IPLB_MIN_CCW_LEN 200
>>  #define S390_IPLB_MIN_FCP_LEN 384
>>  #define S390_IPLB_MIN_QEMU_SCSI_LEN 200
>> @@ -173,16 +200,49 @@ static inline bool iplb_valid_len(IplParameterBl=
ock *iplb)
>>      return be32_to_cpu(iplb->len) <=3D sizeof(IplParameterBlock);
>>  }
>> =20
>> -static inline bool iplb_valid_ccw(IplParameterBlock *iplb)
>> +static inline bool s390_ipl_pv_check_components(IplParameterBlock *ip=
lb)
>=20
> Still don't like the function name :)
>=20
> ipl_valid_pv_components() ?

If it makes you happier

>=20
>>  {
>> -    return be32_to_cpu(iplb->len) >=3D S390_IPLB_MIN_CCW_LEN &&
>> -           iplb->pbt =3D=3D S390_IPL_TYPE_CCW;
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
>> +            return false;
>> +        }
>> +
>> +        /* Tweak prefix is monotonically increasing with each compone=
nt */
>> +        if (i < ipib_pv->num_comp - 1 &&
>> +            ipib_pv->components[i].tweak_pref >=3D
>> +            ipib_pv->components[i + 1].tweak_pref) {
>> +            return false;
>> +        }
>> +    }
>> +    return true;
>>  }
>> =20
>> -static inline bool iplb_valid_fcp(IplParameterBlock *iplb)
>> +static inline bool iplb_valid(IplParameterBlock *iplb)
>>  {
>> -    return be32_to_cpu(iplb->len) >=3D S390_IPLB_MIN_FCP_LEN &&
>> -           iplb->pbt =3D=3D S390_IPL_TYPE_FCP;
>> +    switch (iplb->pbt) {
>> +        case S390_IPL_TYPE_FCP:
>> +            return (be32_to_cpu(iplb->len) >=3D S390_IPLB_MIN_FCP_LEN=
 &&
>> +                    iplb->pbt =3D=3D S390_IPL_TYPE_FCP);
>> +        case S390_IPL_TYPE_CCW:
>> +            return (be32_to_cpu(iplb->len) >=3D S390_IPLB_MIN_CCW_LEN=
 &&
>> +                    iplb->pbt =3D=3D S390_IPL_TYPE_CCW);
>=20
> That's a refactoring you could have split out.

Sure

>=20
>> +        case S390_IPL_TYPE_PV:
>> +            if(be32_to_cpu(iplb->len) < S390_IPLB_MIN_PV_LEN ||
>> +               iplb->pbt !=3D S390_IPL_TYPE_PV) {
>> +                return false;
>> +            }
>> +            return s390_ipl_pv_check_components(iplb);
>> +    default:
>> +        return false;
>> +    }
>>  }
>> =20
>>  #endif
>> diff --git a/hw/s390x/pv.c b/hw/s390x/pv.c
>> new file mode 100644
>> index 0000000000..ba6409246e
>> --- /dev/null
>> +++ b/hw/s390x/pv.c
>> @@ -0,0 +1,104 @@
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
>> +    struct kvm_pv_cmd pv_cmd =3D {
>> +        .cmd =3D cmd,
>> +        .data =3D (uint64_t)data,
>> +    };
>> +
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
>> +    if (rc) {
>> +        exit(1);
>> +    }
>> +}
>> +
>> +int s390_pv_vm_enable(void)
>> +{
>> +    return s390_pv_cmd(KVM_PV_ENABLE, NULL);
>> +}
>> +
>> +void s390_pv_vm_disable(void)
>> +{
>> +     s390_pv_cmd_exit(KVM_PV_DISABLE, NULL);
>> +}
>> +
>> +int s390_pv_set_sec_parms(uint64_t origin, uint64_t length)
>> +{
>> +    struct kvm_s390_pv_sec_parm args =3D {
>> +        .origin =3D origin,
>> +        .length =3D length,
>> +    };
>> +
>> +    return s390_pv_cmd(KVM_PV_VM_SET_SEC_PARMS, &args);
>> +}
>> +
>> +/*
>> + * Called for each component in the SE type IPL parameter block 0.
>> + */
>> +int s390_pv_unpack(uint64_t addr, uint64_t size, uint64_t tweak)
>> +{
>> +    struct kvm_s390_pv_unp args =3D {
>> +        .addr =3D addr,
>> +        .size =3D size,
>> +        .tweak =3D tweak,
>> +    };
>> +
>> +    return s390_pv_cmd(KVM_PV_VM_UNPACK, &args);
>> +}
>> +
>> +void s390_pv_perf_clear_reset(void)
>> +{
>> +    s390_pv_cmd_exit(KVM_PV_VM_PREP_RESET, NULL);
>> +}
>> +
>> +int s390_pv_verify(void)
>> +{
>> +    return s390_pv_cmd(KVM_PV_VM_VERIFY, NULL);
>> +}
>> +
>> +void s390_pv_unshare(void)
>> +{
>> +    s390_pv_cmd_exit(KVM_PV_VM_UNSHARE_ALL, NULL);
>> +}
>> diff --git a/hw/s390x/pv.h b/hw/s390x/pv.h
>> new file mode 100644
>> index 0000000000..e58fbca96a
>> --- /dev/null
>> +++ b/hw/s390x/pv.h
>> @@ -0,0 +1,34 @@
>> +/*
>> + * Protected Virtualization header
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
>> +
>> +#ifndef HW_S390_PV_H
>> +#define HW_S390_PV_H
>> +
>> +#ifdef CONFIG_KVM
>> +int s390_pv_vm_enable(void);
>> +void s390_pv_vm_disable(void);
>> +int s390_pv_set_sec_parms(uint64_t origin, uint64_t length);
>> +int s390_pv_unpack(uint64_t addr, uint64_t size, uint64_t tweak);
>> +void s390_pv_perf_clear_reset(void);
>> +int s390_pv_verify(void);
>> +void s390_pv_unshare(void);
>> +#else
>> +static inline int s390_pv_vm_enable(void) { return 0; }
>> +static inline void s390_pv_vm_disable(void) {}
>> +static inline int s390_pv_set_sec_parms(uint64_t origin, uint64_t len=
gth) { return 0; }
>> +static inline int s390_pv_unpack(uint64_t addr, uint64_t size, uint64=
_t tweak) { return 0; }
>> +static inline void s390_pv_perf_clear_reset(void) {}
>> +static inline int s390_pv_verify(void) { return 0; }
>> +static inline void s390_pv_unshare(void) {}
>> +#endif
>> +
>> +#endif /* HW_S390_PV_H */
>> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
>> index a89cf4c129..f718cfc591 100644
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
>>      s390_sclp_init();
>>      /* init memory + setup max page size. Required for the CPU model =
*/
>>      s390_memory_init(machine->ram);
>> @@ -316,10 +320,90 @@ static inline void s390_do_cpu_ipl(CPUState *cs,=
 run_on_cpu_data arg)
>>      s390_cpu_set_state(S390_CPU_STATE_OPERATING, cpu);
>>  }
>> =20
>> +static void s390_machine_unprotect(S390CcwMachineState *ms)
>> +{
>> +    CPUState *t;
>> +
>> +    if (ms->pv) {
>=20
> This is always the case. The check for ms->pv dropped (and if other
> patches require this, it is to be handled in the caller).

Ack

>=20
>> +        s390_pv_vm_disable();
>> +        CPU_FOREACH(t) {
>> +            S390_CPU(t)->env.pv =3D false;
>> +        }
>> +        ms->pv =3D false;
>> +    }
>> +}
>> +
>> +static int s390_machine_protect(S390CcwMachineState *ms)
>> +{
>> +    CPUState *t;
>> +    int rc;
>> +
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
>> +static void s390_pv_prepare_reset(CPUS390XState *env)
>> +{
>> +    CPUState *cs;
>> +
>> +    if (!env->pv) {
>> +        return;
>> +    }
>> +    CPU_FOREACH(cs) {
>> +        s390_cpu_set_state(S390_CPU_STATE_STOPPED, S390_CPU(cs));
>> +    }
>=20
> This is done by the CPU reset in all cases? Why is that needed? (->comm=
ent)
>=20
>> +    s390_pv_unshare();
>> +    s390_pv_perf_clear_reset();
>> +}
>> +
>>  static void s390_machine_reset(MachineState *machine)
>>  {
>>      enum s390_reset reset_type;
>>      CPUState *cs, *t;
>> +    S390CPU *cpu;
>> +    S390CcwMachineState *ms =3D S390_CCW_MACHINE(machine);
>=20
> Nit: Move this to the very top.


Ack

>=20
>> +    CPUS390XState *env;
>> =20
>>      /* get the reset parameters, reset them once done */
>>      s390_ipl_get_reset_request(&cs, &reset_type);
>> @@ -327,9 +411,16 @@ static void s390_machine_reset(MachineState *mach=
ine)
>>      /* all CPUs are paused and synchronized at this point */
>>      s390_cmma_reset();
>> =20
>> +    cpu =3D S390_CPU(cs);
>> +    env =3D &cpu->env;
>=20
> Can you just pass "cpu" to s390_pv_prepare_reset() and handle it in the=
re?

Wouldn't it make more sense to test the machine state here anyway?

>=20
>> +
>>      switch (reset_type) {
>>      case S390_RESET_EXTERNAL:
>>      case S390_RESET_REIPL:
>> +        if (ms->pv) {
>> +            s390_machine_unprotect(ms);
>> +        }
>> +
>>          qemu_devices_reset();
>>          s390_crypto_reset();
>> =20
>> @@ -337,22 +428,52 @@ static void s390_machine_reset(MachineState *mac=
hine)
>>          run_on_cpu(cs, s390_do_cpu_ipl, RUN_ON_CPU_NULL);
>>          break;
>>      case S390_RESET_MODIFIED_CLEAR:
>> +        /*
>> +         * Susbsystem reset needs to be done before we unshare memory=

>> +         * and loose access to VIRTIO structures in guest memory.
>> +         */
>> +        subsystem_reset();
>> +        s390_crypto_reset();
>> +        s390_pv_prepare_reset(env);
>>          CPU_FOREACH(t) {
>>              run_on_cpu(t, s390_do_cpu_full_reset, RUN_ON_CPU_NULL);
>>          }
>> -        subsystem_reset();
>> -        s390_crypto_reset();
>>          run_on_cpu(cs, s390_do_cpu_load_normal, RUN_ON_CPU_NULL);
>>          break;
>>      case S390_RESET_LOAD_NORMAL:
>> +        /*
>> +         * Susbsystem reset needs to be done before we unshare memory=

>> +         * and loose access to VIRTIO structures in guest memory.
>> +         */
>> +        subsystem_reset();
>> +        s390_pv_prepare_reset(env);
>>          CPU_FOREACH(t) {
>>              if (t =3D=3D cs) {
>>                  continue;
>>              }
>>              run_on_cpu(t, s390_do_cpu_reset, RUN_ON_CPU_NULL);
>>          }
>> -        subsystem_reset();
>>          run_on_cpu(cs, s390_do_cpu_initial_reset, RUN_ON_CPU_NULL);
>> +        run_on_cpu(cs, s390_do_cpu_load_normal, RUN_ON_CPU_NULL);
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
>> +            s390_cpu_set_state(S390_CPU_STATE_OPERATING, cpu);
>> +            return;
>> +        }
>> +
>>          run_on_cpu(cs, s390_do_cpu_load_normal, RUN_ON_CPU_NULL);
>=20
> [...]
>=20
>> =20
>> +#if !defined(CONFIG_USER_ONLY)
>> +static bool machine_is_pv(MachineState *ms)
>> +{
>> +    Object *obj;
>> +
>> +    /* we have to bail out for the "none" machine */
>> +    obj =3D object_dynamic_cast(OBJECT(ms), TYPE_S390_CCW_MACHINE);
>> +     if (!obj) {
>> +        return false;
>> +    }
>> +    return S390_CCW_MACHINE(obj)->pv;
>=20
> Maybe you want to cache the machine, so you can avoid the
> lookup+conversion on every new CPU.

Christian has provided me with a fix to this code, I'll squash it.

>=20
>> +}
>> +#endif
>=20
> [...]
>>  static int diag308_parm_check(CPUS390XState *env, uint64_t r1, uint64=
_t addr,
>>                                uintptr_t ra, bool write)
>>  {
>> +    /* Handled by the Ultravisor */
>> +    if (env->pv) {
>> +        return 0;
>> +    }
>>      if ((r1 & 1) || (addr & ~TARGET_PAGE_MASK)) {
>>          s390_program_interrupt(env, PGM_SPECIFICATION, ra);
>>          return -1;
>> @@ -93,6 +101,11 @@ void handle_diag_308(CPUS390XState *env, uint64_t =
r1, uint64_t r3, uintptr_t ra)
>>          return;
>>      }
>> =20
>> +    if (subcode > 7 && !s390_has_feat(S390_FEAT_UNPACK)) {
>=20
>> =3D DIAG308_PV_SET

?

>=20
>> +        s390_program_interrupt(env, PGM_SPECIFICATION, ra);
>> +        return;
>> +    }
>> +
>=20
>=20



--JCtwMVBCebEkJbKBEB3JFQsNkPjeTC1ST--

--nDDmQMHUyI6kEnzdAkE4oaclA4P47oRhm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl5mY+0ACgkQ41TmuOI4
ufiaThAAyr9aNPhQpQJHYUqKevmtDKULiWeXlXH3LOA88hQFUJQ0Gzs2TXbf9lbu
0m6AzUG1PCcoStQEOXa5jfFM6hf01lfTU/EnGprf741NBziQjto8LQ5i7TNa81aI
kV6dlaNRY3iLobj+dwrsd0XN3MSqCb8s9u5cMHCZCU9heJhR+jOn6L4FJlpknAzG
HTxixnfvRMM/GsFZ4AXLFQlt5pBuMNsX6Yp3F+9BJf+s/p7ZosDimEHWi6B08u1L
awu9ofrbkWWDOLKnrQYmKnCigk5PzLQ2xgNsCoc5Vfm27pAvEawmEoD5NDaVtRcb
qcEoXXPzzVCKGHB/a4PVm9Jk8vqFrhSvZIfXJqJOGNa+Uth+RbgaUghgrC7/Vfxs
R/OSyoZtDG77AYc0uUVJ3DZXsu0WOMz42emCqQ55zaiMjJ82Qy3PGZxx1RM+xjoy
oQ8DuoE2f1Qv9OiUB0/r52S+mXUVOR+bggd5jJ7M8sJ3ae8BN7w8Taj3H+LAGHvI
m9uHFLciVIRvJwcY0EvDPSwh6PPApjZNdgdhGiDREgQSzv57wRwkym9zptqDlCKw
sRXwPWg7PKvsfojluhMATBe9GjQzyU+PGGmkYeqk+4MHVB1gFzDEh2Zwkc660VZU
HyaTjMmYiwbTTVZDhMWukMf071OY83C3KC9HaB08MmjOY1SVKDY=
=SnIV
-----END PGP SIGNATURE-----

--nDDmQMHUyI6kEnzdAkE4oaclA4P47oRhm--


