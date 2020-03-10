Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05E3FC10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 15:42:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC08820675
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 15:42:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC08820675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=de.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBh1a-0003xF-Rl
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 11:42:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42032)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <borntraeger@de.ibm.com>) id 1jBh0v-0003SK-Mw
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 11:41:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <borntraeger@de.ibm.com>) id 1jBh0t-0005hQ-R1
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 11:41:49 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:4544)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
 id 1jBh0t-0005bz-IU
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 11:41:47 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 02AFRKgV016659
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2020 11:41:42 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ym85231kj-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2020 11:41:41 -0400
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
 Tue, 10 Mar 2020 15:41:39 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
 by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 10 Mar 2020 15:41:35 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
 [9.149.105.59])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 02AFfYKB42533010
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Mar 2020 15:41:34 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A55C6A4053;
 Tue, 10 Mar 2020 15:41:34 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6315DA404D;
 Tue, 10 Mar 2020 15:41:34 +0000 (GMT)
Received: from oc7455500831.ibm.com (unknown [9.152.224.141])
 by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Tue, 10 Mar 2020 15:41:34 +0000 (GMT)
Subject: Re: [PATCH v8 02/15] s390x: protvirt: Support unpack facility
To: Janosch Frank <frankja@linux.ibm.com>, qemu-devel@nongnu.org
References: <20200310134008.130038-1-frankja@linux.ibm.com>
 <20200310134008.130038-3-frankja@linux.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Autocrypt: addr=borntraeger@de.ibm.com; prefer-encrypt=mutual; keydata=
 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
 nS4h0HDFPrrp1C2EMVYIQrMokWvlFZbCpsdYbBI=
Date: Tue, 10 Mar 2020 16:41:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200310134008.130038-3-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20031015-0016-0000-0000-000002EF0F73
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20031015-0017-0000-0000-00003352742B
Message-Id: <8f8bedb3-5585-845d-d32e-bfe4ec6c01f7@de.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-03-10_10:2020-03-10,
 2020-03-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 suspectscore=2 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003100100
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
Cc: qemu-s390x@nongnu.org, cohuck@redhat.com, david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 10.03.20 14:39, Janosch Frank wrote:
> The unpack facility provides the means to setup a protected guest. A
> protected guest can not be introspected by the hypervisor or any
> user/administrator of the machine it is running on.
> 
> Protected guests are encrypted at rest and need a special boot
> mechanism via diag308 subcode 8 and 10.
> 
> Code 8 sets the PV specific IPLB which is retained seperately from
> those set via code 5.
> 
> Code 10 is used to unpack the VM into protected memory, verify its
> integrity and start it.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> Co-developed-by: Christian Borntraeger <borntraeger@de.ibm.com> [Changes
> to machine]
> ---
>  hw/s390x/Makefile.objs              |   1 +
>  hw/s390x/ipl.c                      |  56 ++++++++++++-
>  hw/s390x/ipl.h                      |  79 +++++++++++++++++++
>  hw/s390x/pv.c                       | 104 ++++++++++++++++++++++++
>  hw/s390x/pv.h                       |  33 ++++++++
>  hw/s390x/s390-virtio-ccw.c          | 118 +++++++++++++++++++++++++++-
>  include/hw/s390x/s390-virtio-ccw.h  |   1 +
>  target/s390x/cpu.c                  |  23 ++++++
>  target/s390x/cpu.h                  |   1 +
>  target/s390x/cpu_features_def.inc.h |   1 +
>  target/s390x/diag.c                 |  30 ++++++-
>  11 files changed, 441 insertions(+), 6 deletions(-)
>  create mode 100644 hw/s390x/pv.c
>  create mode 100644 hw/s390x/pv.h
> 
> diff --git a/hw/s390x/Makefile.objs b/hw/s390x/Makefile.objs
> index e02ed80b68..a46a1c7894 100644
> --- a/hw/s390x/Makefile.objs
> +++ b/hw/s390x/Makefile.objs
> @@ -31,6 +31,7 @@ obj-y += tod-qemu.o
>  obj-$(CONFIG_KVM) += tod-kvm.o
>  obj-$(CONFIG_KVM) += s390-skeys-kvm.o
>  obj-$(CONFIG_KVM) += s390-stattrib-kvm.o
> +obj-$(CONFIG_KVM) += pv.o
>  obj-y += s390-ccw.o
>  obj-y += ap-device.o
>  obj-y += ap-bridge.o
> diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
> index b81942e1e6..b88b8ff346 100644
> --- a/hw/s390x/ipl.c
> +++ b/hw/s390x/ipl.c
> @@ -33,6 +33,7 @@
>  #include "qemu/cutils.h"
>  #include "qemu/option.h"
>  #include "exec/exec-all.h"
> +#include "pv.h"
>  
>  #define KERN_IMAGE_START                0x010000UL
>  #define LINUX_MAGIC_ADDR                0x010008UL
> @@ -566,12 +567,31 @@ void s390_ipl_update_diag308(IplParameterBlock *iplb)
>  {
>      S390IPLState *ipl = get_ipl_device();
>  
> -    ipl->iplb = *iplb;
> -    ipl->iplb_valid = true;
> +    /*
> +     * The IPLB set and retrieved by subcodes 8/9 is completely
> +     * separate from the one managed via subcodes 5/6.
> +     */
> +    if (iplb->pbt == S390_IPL_TYPE_PV) {
> +        ipl->iplb_pv = *iplb;
> +        ipl->iplb_valid_pv = true;
> +    } else {
> +        ipl->iplb = *iplb;
> +        ipl->iplb_valid = true;
> +    }
>      ipl->netboot = is_virtio_net_device(iplb);
>      update_machine_ipl_properties(iplb);
>  }
>  
> +IplParameterBlock *s390_ipl_get_iplb_pv(void)
> +{
> +    S390IPLState *ipl = get_ipl_device();
> +
> +    if (!ipl->iplb_valid_pv) {
> +        return NULL;
> +    }
> +    return &ipl->iplb_pv;
> +}
> +
>  IplParameterBlock *s390_ipl_get_iplb(void)
>  {
>      S390IPLState *ipl = get_ipl_device();
> @@ -660,6 +680,38 @@ static void s390_ipl_prepare_qipl(S390CPU *cpu)
>      cpu_physical_memory_unmap(addr, len, 1, len);
>  }
>  
> +int s390_ipl_prepare_pv_header(void)
> +{
> +    IplParameterBlock *ipib = s390_ipl_get_iplb_pv();
> +    IPLBlockPV *ipib_pv = &ipib->pv;
> +    void *hdr = g_malloc(ipib_pv->pv_header_len);
> +    int rc;
> +
> +    cpu_physical_memory_read(ipib_pv->pv_header_addr, hdr,
> +                             ipib_pv->pv_header_len);
> +    rc = s390_pv_set_sec_parms((uint64_t)hdr,
> +                               ipib_pv->pv_header_len);
> +    g_free(hdr);
> +    return rc;
> +}
> +
> +int s390_ipl_pv_unpack(void)
> +{
> +    IplParameterBlock *ipib = s390_ipl_get_iplb_pv();
> +    IPLBlockPV *ipib_pv = &ipib->pv;
> +    int i, rc = 0;
> +
> +    for (i = 0; i < ipib_pv->num_comp; i++) {
> +        rc = s390_pv_unpack(ipib_pv->components[i].addr,
> +                            TARGET_PAGE_ALIGN(ipib_pv->components[i].size),
> +                            ipib_pv->components[i].tweak_pref);
> +        if (rc) {
> +            break;
> +        }
> +    }
> +    return rc;
> +}
> +
>  void s390_ipl_prepare_cpu(S390CPU *cpu)
>  {
>      S390IPLState *ipl = get_ipl_device();
> diff --git a/hw/s390x/ipl.h b/hw/s390x/ipl.h
> index 3e44abe1c6..919f9e6913 100644
> --- a/hw/s390x/ipl.h
> +++ b/hw/s390x/ipl.h
> @@ -15,6 +15,24 @@
>  #include "cpu.h"
>  #include "hw/qdev-core.h"
>  
> +struct IPLBlockPVComp {
> +    uint64_t tweak_pref;
> +    uint64_t addr;
> +    uint64_t size;
> +} QEMU_PACKED;
> +typedef struct IPLBlockPVComp IPLBlockPVComp;
> +
> +struct IPLBlockPV {
> +    uint8_t  reserved18[87];    /* 0x18 */
> +    uint8_t  version;           /* 0x6f */
> +    uint32_t reserved70;        /* 0x70 */
> +    uint32_t num_comp;          /* 0x74 */
> +    uint64_t pv_header_addr;    /* 0x78 */
> +    uint64_t pv_header_len;     /* 0x80 */
> +    struct IPLBlockPVComp components[];
> +} QEMU_PACKED;
> +typedef struct IPLBlockPV IPLBlockPV;
> +
>  struct IplBlockCcw {
>      uint8_t  reserved0[85];
>      uint8_t  ssid;
> @@ -71,6 +89,7 @@ union IplParameterBlock {
>          union {
>              IplBlockCcw ccw;
>              IplBlockFcp fcp;
> +            IPLBlockPV pv;
>              IplBlockQemuScsi scsi;
>          };
>      } QEMU_PACKED;
> @@ -85,8 +104,11 @@ typedef union IplParameterBlock IplParameterBlock;
>  
>  int s390_ipl_set_loadparm(uint8_t *loadparm);
>  void s390_ipl_update_diag308(IplParameterBlock *iplb);
> +int s390_ipl_prepare_pv_header(void);
> +int s390_ipl_pv_unpack(void);
>  void s390_ipl_prepare_cpu(S390CPU *cpu);
>  IplParameterBlock *s390_ipl_get_iplb(void);
> +IplParameterBlock *s390_ipl_get_iplb_pv(void);
>  
>  enum s390_reset {
>      /* default is a reset not triggered by a CPU e.g. issued by QMP */
> @@ -94,6 +116,7 @@ enum s390_reset {
>      S390_RESET_REIPL,
>      S390_RESET_MODIFIED_CLEAR,
>      S390_RESET_LOAD_NORMAL,
> +    S390_RESET_PV,
>  };
>  void s390_ipl_reset_request(CPUState *cs, enum s390_reset reset_type);
>  void s390_ipl_get_reset_request(CPUState **cs, enum s390_reset *reset_type);
> @@ -133,6 +156,7 @@ struct S390IPLState {
>      /*< private >*/
>      DeviceState parent_obj;
>      IplParameterBlock iplb;
> +    IplParameterBlock iplb_pv;
>      QemuIplParameters qipl;
>      uint64_t start_addr;
>      uint64_t compat_start_addr;
> @@ -140,6 +164,7 @@ struct S390IPLState {
>      uint64_t compat_bios_start_addr;
>      bool enforce_bios;
>      bool iplb_valid;
> +    bool iplb_valid_pv;
>      bool netboot;
>      /* reset related properties don't have to be migrated or reset */
>      enum s390_reset reset_type;
> @@ -161,9 +186,11 @@ QEMU_BUILD_BUG_MSG(offsetof(S390IPLState, iplb) & 3, "alignment of iplb wrong");
>  
>  #define S390_IPL_TYPE_FCP 0x00
>  #define S390_IPL_TYPE_CCW 0x02
> +#define S390_IPL_TYPE_PV 0x05
>  #define S390_IPL_TYPE_QEMU_SCSI 0xff
>  
>  #define S390_IPLB_HEADER_LEN 8
> +#define S390_IPLB_MIN_PV_LEN 148
>  #define S390_IPLB_MIN_CCW_LEN 200
>  #define S390_IPLB_MIN_FCP_LEN 384
>  #define S390_IPLB_MIN_QEMU_SCSI_LEN 200
> @@ -173,6 +200,50 @@ static inline bool iplb_valid_len(IplParameterBlock *iplb)
>      return be32_to_cpu(iplb->len) <= sizeof(IplParameterBlock);
>  }
>  
> +static inline bool ipl_valid_pv_components(IplParameterBlock *iplb)
> +{
> +    IPLBlockPV *ipib_pv = &iplb->pv;
> +    int i;
> +
> +    if (ipib_pv->num_comp == 0) {
> +        return false;
> +    }
> +
> +    for (i = 0; i < ipib_pv->num_comp; i++) {
> +        /* Addr must be 4k aligned */
> +        if (ipib_pv->components[i].addr & ~TARGET_PAGE_MASK) {
> +            return false;
> +        }
> +
> +        /* Tweak prefix is monotonically increasing with each component */
> +        if (i < ipib_pv->num_comp - 1 &&
> +            ipib_pv->components[i].tweak_pref >=
> +            ipib_pv->components[i + 1].tweak_pref) {
> +            return false;
> +        }
> +    }
> +    return true;
> +}
> +
> +static inline bool ipl_valid_pv_header(IplParameterBlock *iplb)
> +{
> +        IPLBlockPV *ipib_pv = &iplb->pv;
> +
> +        if (ipib_pv->pv_header_len > 2 * TARGET_PAGE_SIZE) {
> +            return false;
> +        }
> +
> +        if (!address_space_access_valid(&address_space_memory,
> +                                        ipib_pv->pv_header_addr,
> +                                        ipib_pv->pv_header_len,
> +                                        false,
> +                                        MEMTXATTRS_UNSPECIFIED)) {
> +            return false;
> +        }
> +
> +        return true;
> +}
> +
>  static inline bool iplb_valid(IplParameterBlock *iplb)
>  {
>      switch (iplb->pbt) {
> @@ -180,6 +251,14 @@ static inline bool iplb_valid(IplParameterBlock *iplb)
>          return be32_to_cpu(iplb->len) >= S390_IPLB_MIN_FCP_LEN;
>      case S390_IPL_TYPE_CCW:
>          return be32_to_cpu(iplb->len) >= S390_IPLB_MIN_CCW_LEN;
> +    case S390_IPL_TYPE_PV:
> +        if (be32_to_cpu(iplb->len) < S390_IPLB_MIN_PV_LEN) {
> +            return false;
> +        }
> +        if (!ipl_valid_pv_header(iplb)) {
> +            return false;
> +        }
> +        return ipl_valid_pv_components(iplb);
>      default:
>          return false;
>      }
> diff --git a/hw/s390x/pv.c b/hw/s390x/pv.c
> new file mode 100644
> index 0000000000..1ba8bc7242
> --- /dev/null
> +++ b/hw/s390x/pv.c
> @@ -0,0 +1,104 @@
> +/*
> + * Protected Virtualization functions
> + *
> + * Copyright IBM Corp. 2020
> + * Author(s):
> + *  Janosch Frank <frankja@linux.ibm.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or (at
> + * your option) any later version. See the COPYING file in the top-level
> + * directory.
> + */
> +#include "qemu/osdep.h"
> +
> +#include <linux/kvm.h>
> +
> +#include "qemu/error-report.h"
> +#include "sysemu/kvm.h"
> +#include "pv.h"
> +
> +const char *cmd_names[] = {
> +    "VM_ENABLE",
> +    "VM_DISABLE",
> +    "VM_SET_SEC_PARAMS",
> +    "VM_UNPACK",
> +    "VM_VERIFY",
> +    "VM_PREP_RESET",
> +    "VM_UNSHARE_ALL",
> +};

This is really error-prone (even though this will not change)
What about something like this? (and no is an acceptable answer)

diff --git a/hw/s390x/pv.c b/hw/s390x/pv.c
index 1ba8bc7242..fa592513e4 100644
--- a/hw/s390x/pv.c
+++ b/hw/s390x/pv.c
@@ -17,17 +17,7 @@
 #include "sysemu/kvm.h"
 #include "pv.h"
 
-const char *cmd_names[] = {
-    "VM_ENABLE",
-    "VM_DISABLE",
-    "VM_SET_SEC_PARAMS",
-    "VM_UNPACK",
-    "VM_VERIFY",
-    "VM_PREP_RESET",
-    "VM_UNSHARE_ALL",
-};
-
-static int s390_pv_cmd(uint32_t cmd, void *data)
+static int __s390_pv_cmd(uint32_t cmd, const char *cmdname, void *data)
 {
     int rc;
     struct kvm_pv_cmd pv_cmd = {
@@ -38,20 +28,21 @@ static int s390_pv_cmd(uint32_t cmd, void *data)
     rc = kvm_vm_ioctl(kvm_state, KVM_S390_PV_COMMAND, &pv_cmd);
     if (rc) {
         error_report("KVM PV command %d (%s) failed: header rc %x rrc %x "
-                     "IOCTL rc: %d", cmd, cmd_names[cmd], pv_cmd.rc, pv_cmd.rrc,
+                     "IOCTL rc: %d", cmd, cmdname, pv_cmd.rc, pv_cmd.rrc,
                      rc);
     }
     return rc;
 }
 
-static void s390_pv_cmd_exit(uint32_t cmd, void *data)
-{
-    int rc;
+#define s390_pv_cmd(cmd, data) __s390_pv_cmd(cmd, #cmd, data);
 
-    rc = s390_pv_cmd(cmd, data);
-    if (rc) {
-        exit(1);
-    }
+#define s390_pv_cmd_exit(cmd, data)    \
+{                                      \
+    int rc;                            \
+    rc = __s390_pv_cmd(cmd, #cmd, data);\
+    if (rc) {                          \
+        exit(1);                       \
+    }                                  \
 }
 
 int s390_pv_vm_enable(void)








