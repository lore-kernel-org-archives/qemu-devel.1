Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76472C10F27
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 14:29:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B73520578
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 14:29:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B73520578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBJPC-0000Sy-GI
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 10:29:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51694)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mihajlov@linux.ibm.com>) id 1jBJOQ-00083N-V8
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 10:28:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mihajlov@linux.ibm.com>) id 1jBJOP-0000hL-L3
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 10:28:30 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52154)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mihajlov@linux.ibm.com>)
 id 1jBJOP-0000gW-Dp
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 10:28:29 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 029EMP5t137829
 for <qemu-devel@nongnu.org>; Mon, 9 Mar 2020 10:28:28 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ym850r3xr-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2020 10:28:28 -0400
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <mihajlov@linux.ibm.com>;
 Mon, 9 Mar 2020 14:28:21 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
 by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 9 Mar 2020 14:28:20 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 029ESI3v28573764
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 9 Mar 2020 14:28:18 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8E03DAE055;
 Mon,  9 Mar 2020 14:28:18 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 382BEAE053;
 Mon,  9 Mar 2020 14:28:18 +0000 (GMT)
Received: from oc6604088431.ibm.com (unknown [9.145.17.152])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Mon,  9 Mar 2020 14:28:18 +0000 (GMT)
Subject: Re: [PATCH v7 02/15] s390x: protvirt: Support unpack facility
To: Janosch Frank <frankja@linux.ibm.com>, qemu-devel@nongnu.org
References: <20200309112206.20261-1-frankja@linux.ibm.com>
 <20200309112206.20261-3-frankja@linux.ibm.com>
From: Viktor Mihajlovski <mihajlov@linux.ibm.com>
Date: Mon, 9 Mar 2020 15:28:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200309112206.20261-3-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20030914-0016-0000-0000-000002EEA4ED
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20030914-0017-0000-0000-0000335204E6
Message-Id: <96a89714-2c3c-908c-9d66-9bbfe1997168@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-03-09_05:2020-03-09,
 2020-03-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 suspectscore=2 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003090099
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
Cc: borntraeger@de.ibm.com, qemu-s390x@nongnu.org, cohuck@redhat.com,
 david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 3/9/20 12:21 PM, Janosch Frank wrote:
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
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com> [Changes
> to machine]
A nit: [Changes...] should go before the s-o-b.
> ---
>   hw/s390x/Makefile.objs              |   1 +
>   hw/s390x/ipl.c                      |  59 ++++++++++++-
>   hw/s390x/ipl.h                      |  72 ++++++++++++++--
>   hw/s390x/pv.c                       | 104 +++++++++++++++++++++++
>   hw/s390x/pv.h                       |  34 ++++++++
>   hw/s390x/s390-virtio-ccw.c          | 127 +++++++++++++++++++++++++++-
>   include/hw/s390x/s390-virtio-ccw.h  |   1 +
>   target/s390x/cpu.c                  |  17 ++++
>   target/s390x/cpu.h                  |   1 +
>   target/s390x/cpu_features_def.inc.h |   1 +
>   target/s390x/diag.c                 |  34 +++++++-
>   11 files changed, 436 insertions(+), 15 deletions(-)
>   create mode 100644 hw/s390x/pv.c
>   create mode 100644 hw/s390x/pv.h
> 
> diff --git a/hw/s390x/Makefile.objs b/hw/s390x/Makefile.objs
> index e02ed80b68..a46a1c7894 100644
> --- a/hw/s390x/Makefile.objs
> +++ b/hw/s390x/Makefile.objs
> @@ -31,6 +31,7 @@ obj-y += tod-qemu.o
>   obj-$(CONFIG_KVM) += tod-kvm.o
>   obj-$(CONFIG_KVM) += s390-skeys-kvm.o
>   obj-$(CONFIG_KVM) += s390-stattrib-kvm.o
> +obj-$(CONFIG_KVM) += pv.o
>   obj-y += s390-ccw.o
>   obj-y += ap-device.o
>   obj-y += ap-bridge.o
> diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
> index 9c1ecd423c..ba3eac30c6 100644
> --- a/hw/s390x/ipl.c
> +++ b/hw/s390x/ipl.c
> @@ -33,6 +33,7 @@
>   #include "qemu/cutils.h"
>   #include "qemu/option.h"
>   #include "exec/exec-all.h"
> +#include "pv.h"
> 
>   #define KERN_IMAGE_START                0x010000UL
>   #define LINUX_MAGIC_ADDR                0x010008UL
> @@ -542,11 +543,30 @@ void s390_ipl_update_diag308(IplParameterBlock *iplb)
>   {
>       S390IPLState *ipl = get_ipl_device();
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
>       ipl->netboot = is_virtio_net_device(iplb);
>   }
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
>   IplParameterBlock *s390_ipl_get_iplb(void)
>   {
>       S390IPLState *ipl = get_ipl_device();
> @@ -561,7 +581,8 @@ void s390_ipl_reset_request(CPUState *cs, enum s390_reset reset_type)
>   {
>       S390IPLState *ipl = get_ipl_device();
> 
> -    if (reset_type == S390_RESET_EXTERNAL || reset_type == S390_RESET_REIPL) {
> +    if (reset_type == S390_RESET_EXTERNAL || reset_type == S390_RESET_REIPL ||
> +        reset_type == S390_RESET_PV) {
>           /* use CPU 0 for full resets */
>           ipl->reset_cpu_index = 0;
>       } else {
> @@ -635,6 +656,38 @@ static void s390_ipl_prepare_qipl(S390CPU *cpu)
>       cpu_physical_memory_unmap(addr, len, 1, len);
>   }
> 
> +int s390_ipl_prepare_pv_header(void)
> +{
> +    S390IPLState *ipl = get_ipl_device();
> +    IPLBlockPV *ipib_pv = &ipl->iplb_pv.pv;
> +    void *hdr = g_malloc(ipib_pv->pv_header_len);
> +    int rc;
> +
> +    cpu_physical_memory_read(ipib_pv->pv_header_addr, hdr,
> +                             ipib_pv->pv_header_len);
> +    rc = s390_pv_set_sec_parms((uint64_t)hdr,
> +                          ipib_pv->pv_header_len);
> +    g_free(hdr);
> +    return rc;
> +}
> +
> +int s390_ipl_pv_unpack(void)
> +{
> +    int i, rc = 0;
> +    S390IPLState *ipl = get_ipl_device();
> +    IPLBlockPV *ipib_pv = &ipl->iplb_pv.pv;
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
>   void s390_ipl_prepare_cpu(S390CPU *cpu)
>   {
>       S390IPLState *ipl = get_ipl_device();
> diff --git a/hw/s390x/ipl.h b/hw/s390x/ipl.h
> index d4813105db..b2ccdd9dae 100644
> --- a/hw/s390x/ipl.h
> +++ b/hw/s390x/ipl.h
> @@ -15,6 +15,24 @@
>   #include "cpu.h"
>   #include "hw/qdev-core.h"
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
> +    uint32_t num_comp;          /* 0x70 */
Another nit: offset should be 0x74
> +    uint64_t pv_header_addr;    /* 0x74 */
> +    uint64_t pv_header_len;     /* 0x7c */
> +    struct IPLBlockPVComp components[];
> +} QEMU_PACKED;
> +typedef struct IPLBlockPV IPLBlockPV;
> +
>   struct IplBlockCcw {
>       uint8_t  reserved0[85];
>       uint8_t  ssid;[...]
-- 
Kind Regards,
    Viktor


