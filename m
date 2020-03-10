Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5207C10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 16:04:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A48521D56
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 16:04:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A48521D56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBhMS-0000ec-Je
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 12:04:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40932)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frankja@linux.ibm.com>) id 1jBhJx-0004lW-8m
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 12:01:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frankja@linux.ibm.com>) id 1jBhJv-00005D-1p
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 12:01:29 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:9386
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <frankja@linux.ibm.com>)
 id 1jBhJt-0008Pe-8p
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 12:01:25 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 02AFnwbE087844
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2020 12:01:22 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2ynr9djffa-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2020 12:01:22 -0400
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <frankja@linux.ibm.com>;
 Tue, 10 Mar 2020 16:01:20 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
 by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 10 Mar 2020 16:01:16 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 02AG1FR157933824
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Mar 2020 16:01:15 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 92D0952054;
 Tue, 10 Mar 2020 16:01:15 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.23.214])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 390D952059;
 Tue, 10 Mar 2020 16:01:15 +0000 (GMT)
Subject: Re: [PATCH v8 02/15] s390x: protvirt: Support unpack facility
To: Christian Borntraeger <borntraeger@de.ibm.com>, qemu-devel@nongnu.org
References: <20200310134008.130038-1-frankja@linux.ibm.com>
 <20200310134008.130038-3-frankja@linux.ibm.com>
 <8f8bedb3-5585-845d-d32e-bfe4ec6c01f7@de.ibm.com>
From: Janosch Frank <frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; prefer-encrypt=mutual; keydata=
 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
Date: Tue, 10 Mar 2020 17:01:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <8f8bedb3-5585-845d-d32e-bfe4ec6c01f7@de.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="P2XUOidzBDleAivCCOTvHhJlPi2Zi0dKQ"
X-TM-AS-GCONF: 00
x-cbid: 20031016-0020-0000-0000-000003B26102
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20031016-0021-0000-0000-0000220AAD99
Message-Id: <0c15f682-dcb5-6d3b-d57f-0c3558a7fac3@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-03-10_10:2020-03-10,
 2020-03-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 spamscore=0
 suspectscore=2 malwarescore=0 adultscore=0 mlxscore=0 bulkscore=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003100101
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
Cc: qemu-s390x@nongnu.org, cohuck@redhat.com, david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--P2XUOidzBDleAivCCOTvHhJlPi2Zi0dKQ
Content-Type: multipart/mixed; boundary="fWh3z4hwrNo6d1mJU6norWEAZlrZbWZ85"

--fWh3z4hwrNo6d1mJU6norWEAZlrZbWZ85
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 3/10/20 4:41 PM, Christian Borntraeger wrote:
>=20
>=20
> On 10.03.20 14:39, Janosch Frank wrote:
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
>> Co-developed-by: Christian Borntraeger <borntraeger@de.ibm.com> [Chang=
es
>> to machine]
>> ---
>>  hw/s390x/Makefile.objs              |   1 +
>>  hw/s390x/ipl.c                      |  56 ++++++++++++-
>>  hw/s390x/ipl.h                      |  79 +++++++++++++++++++
>>  hw/s390x/pv.c                       | 104 ++++++++++++++++++++++++
>>  hw/s390x/pv.h                       |  33 ++++++++
>>  hw/s390x/s390-virtio-ccw.c          | 118 +++++++++++++++++++++++++++=
-
>>  include/hw/s390x/s390-virtio-ccw.h  |   1 +
>>  target/s390x/cpu.c                  |  23 ++++++
>>  target/s390x/cpu.h                  |   1 +
>>  target/s390x/cpu_features_def.inc.h |   1 +
>>  target/s390x/diag.c                 |  30 ++++++-
>>  11 files changed, 441 insertions(+), 6 deletions(-)
>>  create mode 100644 hw/s390x/pv.c
>>  create mode 100644 hw/s390x/pv.h
>>
>> diff --git a/hw/s390x/Makefile.objs b/hw/s390x/Makefile.objs
>> index e02ed80b68..a46a1c7894 100644
>> --- a/hw/s390x/Makefile.objs
>> +++ b/hw/s390x/Makefile.objs
>> @@ -31,6 +31,7 @@ obj-y +=3D tod-qemu.o
>>  obj-$(CONFIG_KVM) +=3D tod-kvm.o
>>  obj-$(CONFIG_KVM) +=3D s390-skeys-kvm.o
>>  obj-$(CONFIG_KVM) +=3D s390-stattrib-kvm.o
>> +obj-$(CONFIG_KVM) +=3D pv.o
>>  obj-y +=3D s390-ccw.o
>>  obj-y +=3D ap-device.o
>>  obj-y +=3D ap-bridge.o
>> diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
>> index b81942e1e6..b88b8ff346 100644
>> --- a/hw/s390x/ipl.c
>> +++ b/hw/s390x/ipl.c
>> @@ -33,6 +33,7 @@
>>  #include "qemu/cutils.h"
>>  #include "qemu/option.h"
>>  #include "exec/exec-all.h"
>> +#include "pv.h"
>> =20
>>  #define KERN_IMAGE_START                0x010000UL
>>  #define LINUX_MAGIC_ADDR                0x010008UL
>> @@ -566,12 +567,31 @@ void s390_ipl_update_diag308(IplParameterBlock *=
iplb)
>>  {
>>      S390IPLState *ipl =3D get_ipl_device();
>> =20
>> -    ipl->iplb =3D *iplb;
>> -    ipl->iplb_valid =3D true;
>> +    /*
>> +     * The IPLB set and retrieved by subcodes 8/9 is completely
>> +     * separate from the one managed via subcodes 5/6.
>> +     */
>> +    if (iplb->pbt =3D=3D S390_IPL_TYPE_PV) {
>> +        ipl->iplb_pv =3D *iplb;
>> +        ipl->iplb_valid_pv =3D true;
>> +    } else {
>> +        ipl->iplb =3D *iplb;
>> +        ipl->iplb_valid =3D true;
>> +    }
>>      ipl->netboot =3D is_virtio_net_device(iplb);
>>      update_machine_ipl_properties(iplb);
>>  }
>> =20
>> +IplParameterBlock *s390_ipl_get_iplb_pv(void)
>> +{
>> +    S390IPLState *ipl =3D get_ipl_device();
>> +
>> +    if (!ipl->iplb_valid_pv) {
>> +        return NULL;
>> +    }
>> +    return &ipl->iplb_pv;
>> +}
>> +
>>  IplParameterBlock *s390_ipl_get_iplb(void)
>>  {
>>      S390IPLState *ipl =3D get_ipl_device();
>> @@ -660,6 +680,38 @@ static void s390_ipl_prepare_qipl(S390CPU *cpu)
>>      cpu_physical_memory_unmap(addr, len, 1, len);
>>  }
>> =20
>> +int s390_ipl_prepare_pv_header(void)
>> +{
>> +    IplParameterBlock *ipib =3D s390_ipl_get_iplb_pv();
>> +    IPLBlockPV *ipib_pv =3D &ipib->pv;
>> +    void *hdr =3D g_malloc(ipib_pv->pv_header_len);
>> +    int rc;
>> +
>> +    cpu_physical_memory_read(ipib_pv->pv_header_addr, hdr,
>> +                             ipib_pv->pv_header_len);
>> +    rc =3D s390_pv_set_sec_parms((uint64_t)hdr,
>> +                               ipib_pv->pv_header_len);
>> +    g_free(hdr);
>> +    return rc;
>> +}
>> +
>> +int s390_ipl_pv_unpack(void)
>> +{
>> +    IplParameterBlock *ipib =3D s390_ipl_get_iplb_pv();
>> +    IPLBlockPV *ipib_pv =3D &ipib->pv;
>> +    int i, rc =3D 0;
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
>> index 3e44abe1c6..919f9e6913 100644
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
>> +    uint32_t num_comp;          /* 0x74 */
>> +    uint64_t pv_header_addr;    /* 0x78 */
>> +    uint64_t pv_header_len;     /* 0x80 */
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
>> @@ -173,6 +200,50 @@ static inline bool iplb_valid_len(IplParameterBlo=
ck *iplb)
>>      return be32_to_cpu(iplb->len) <=3D sizeof(IplParameterBlock);
>>  }
>> =20
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
>> +}
>> +
>> +static inline bool ipl_valid_pv_header(IplParameterBlock *iplb)
>> +{
>> +        IPLBlockPV *ipib_pv =3D &iplb->pv;
>> +
>> +        if (ipib_pv->pv_header_len > 2 * TARGET_PAGE_SIZE) {
>> +            return false;
>> +        }
>> +
>> +        if (!address_space_access_valid(&address_space_memory,
>> +                                        ipib_pv->pv_header_addr,
>> +                                        ipib_pv->pv_header_len,
>> +                                        false,
>> +                                        MEMTXATTRS_UNSPECIFIED)) {
>> +            return false;
>> +        }
>> +
>> +        return true;
>> +}
>> +
>>  static inline bool iplb_valid(IplParameterBlock *iplb)
>>  {
>>      switch (iplb->pbt) {
>> @@ -180,6 +251,14 @@ static inline bool iplb_valid(IplParameterBlock *=
iplb)
>>          return be32_to_cpu(iplb->len) >=3D S390_IPLB_MIN_FCP_LEN;
>>      case S390_IPL_TYPE_CCW:
>>          return be32_to_cpu(iplb->len) >=3D S390_IPLB_MIN_CCW_LEN;
>> +    case S390_IPL_TYPE_PV:
>> +        if (be32_to_cpu(iplb->len) < S390_IPLB_MIN_PV_LEN) {
>> +            return false;
>> +        }
>> +        if (!ipl_valid_pv_header(iplb)) {
>> +            return false;
>> +        }
>> +        return ipl_valid_pv_components(iplb);
>>      default:
>>          return false;
>>      }
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
>=20
> This is really error-prone (even though this will not change)
> What about something like this? (and no is an acceptable answer)

I'd be ok with that as long as I can add a comment to the macro
explaining what we're doing. And if I can add a newline between rc and
the if in the macro.

>=20
> diff --git a/hw/s390x/pv.c b/hw/s390x/pv.c
> index 1ba8bc7242..fa592513e4 100644
> --- a/hw/s390x/pv.c
> +++ b/hw/s390x/pv.c
> @@ -17,17 +17,7 @@
>  #include "sysemu/kvm.h"
>  #include "pv.h"
> =20
> -const char *cmd_names[] =3D {
> -    "VM_ENABLE",
> -    "VM_DISABLE",
> -    "VM_SET_SEC_PARAMS",
> -    "VM_UNPACK",
> -    "VM_VERIFY",
> -    "VM_PREP_RESET",
> -    "VM_UNSHARE_ALL",
> -};
> -
> -static int s390_pv_cmd(uint32_t cmd, void *data)
> +static int __s390_pv_cmd(uint32_t cmd, const char *cmdname, void *data=
)
>  {
>      int rc;
>      struct kvm_pv_cmd pv_cmd =3D {
> @@ -38,20 +28,21 @@ static int s390_pv_cmd(uint32_t cmd, void *data)
>      rc =3D kvm_vm_ioctl(kvm_state, KVM_S390_PV_COMMAND, &pv_cmd);
>      if (rc) {
>          error_report("KVM PV command %d (%s) failed: header rc %x rrc =
%x "
> -                     "IOCTL rc: %d", cmd, cmd_names[cmd], pv_cmd.rc, p=
v_cmd.rrc,
> +                     "IOCTL rc: %d", cmd, cmdname, pv_cmd.rc, pv_cmd.r=
rc,
>                       rc);
>      }
>      return rc;
>  }
> =20
> -static void s390_pv_cmd_exit(uint32_t cmd, void *data)
> -{
> -    int rc;
> +#define s390_pv_cmd(cmd, data) __s390_pv_cmd(cmd, #cmd, data);
> =20
> -    rc =3D s390_pv_cmd(cmd, data);
> -    if (rc) {
> -        exit(1);
> -    }
> +#define s390_pv_cmd_exit(cmd, data)    \
> +{                                      \
> +    int rc;                            \
> +    rc =3D __s390_pv_cmd(cmd, #cmd, data);\
> +    if (rc) {                          \
> +        exit(1);                       \
> +    }                                  \
>  }
> =20
>  int s390_pv_vm_enable(void)
>=20
>=20
>=20
>=20
>=20
>=20
>=20
>=20



--fWh3z4hwrNo6d1mJU6norWEAZlrZbWZ85--

--P2XUOidzBDleAivCCOTvHhJlPi2Zi0dKQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl5nucoACgkQ41TmuOI4
ufib6w//Zs8/PLIvxsfgI1nk+gYDJttnM1FKRsU5b+bgGNbWV51RB28RU4cM3jD9
vopG+cXvk8PP6LPjp9fmQEXynPdDhaflCnpPDUiLfWOWKUM0O8qPGrveIIu44ovC
R7sc1dkbVjjdS1tTh7OXK5HmK1FmxMFsfcPosWLNIfeYwShyZFE+Owshzii/H9K8
ceGNpMr8uanKyUaSqGxfIxUrVx8XMUbdbVn2qsDZglkQ5lBamw7JxmjXCFy3Gq5i
DVVLFRGRZTh+CZZ38uo8RecnlMA2V9o7VTPPjmZ728gDI5o7wUDQdl+zvL3fY7rX
4Bnt0wz7LdJ5AjfVfbDIJBRb3nr123aXh2M4CZ2wfMZHzh0fS4WEqkexApQ35taK
2J17J44fkRieCCS+l1uXAdJ02ipdn4sECwGKWuRW8GQXh8W/EUX4T0THltTlTKg5
t9UbSLtA3P+v0IjA9dfehqo6XTkfhYfQo/FrycruV+j98z+xHPjKNfgnqOk1v3hE
QwplEkkU0X7mLbfefKTntVz/ASYrTR7WHaC9rLBMUc5tiHutQ85rHSUiS2ld7U9M
jyOYailO+FHnaU/TGbqPfqGsjdSmR+cXgOuL6W92gtpARwQKnhKKBz+UKDKMIU6O
q1JGvXjP0yz6B9OdcC6AkXi/xFEx6K9oWSRTygl2K6h7bfuWJJE=
=m7JO
-----END PGP SIGNATURE-----

--P2XUOidzBDleAivCCOTvHhJlPi2Zi0dKQ--


