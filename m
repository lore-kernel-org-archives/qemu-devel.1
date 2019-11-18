Return-Path: <SRS0=QE2o=ZK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48C15C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 11:10:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DD152071C
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 11:10:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DD152071C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60734 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWevO-0001cz-4u
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 06:10:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47651)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ganeshgr@linux.ibm.com>) id 1iWeuW-0000X4-Dk
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 06:09:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ganeshgr@linux.ibm.com>) id 1iWeuQ-0003mD-G0
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 06:09:36 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:11652)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ganeshgr@linux.ibm.com>)
 id 1iWeuP-0003lH-OE
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 06:09:30 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xAIB8Oc3025883
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2019 06:09:27 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2waeh88djx-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2019 06:09:26 -0500
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <ganeshgr@linux.ibm.com>;
 Mon, 18 Nov 2019 11:09:24 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
 by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 18 Nov 2019 11:09:20 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id xAIB8f4p15728920
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 18 Nov 2019 11:08:42 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 23C41A4065;
 Mon, 18 Nov 2019 11:09:19 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A85C5A4054;
 Mon, 18 Nov 2019 11:09:17 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.35.97])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Mon, 18 Nov 2019 11:09:17 +0000 (GMT)
Subject: Re: [PATCH v17 4/7] target/ppc: Build rtas error log upon an MCE
From: Ganesh <ganeshgr@linux.ibm.com>
To: David Gibson <david@gibson.dropbear.id.au>
References: <20191024074307.22821-1-ganeshgr@linux.ibm.com>
 <20191024074307.22821-5-ganeshgr@linux.ibm.com>
 <20191104161054.GH3552@umbus.metropole.lan>
 <e095aac0-949e-6f5e-ecac-bcc25802a8c5@linux.ibm.com>
Date: Mon, 18 Nov 2019 16:39:16 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <e095aac0-949e-6f5e-ecac-bcc25802a8c5@linux.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 19111811-0020-0000-0000-000003893A54
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19111811-0021-0000-0000-000021DF5FD7
Message-Id: <4a66ff89-6078-f0ed-9c3a-cd597f9382ee@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-18_02:2019-11-15,2019-11-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015
 phishscore=0 impostorscore=0 bulkscore=0 suspectscore=2 adultscore=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911180100
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by
 mx0a-001b2d01.pphosted.com id xAIB8Oc3025883
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
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
Cc: arawinda.p@gmail.com, aik@ozlabs.ru, qemu-devel@nongnu.org, groug@kaod.org,
 paulus@ozlabs.org, qemu-ppc@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 11/6/19 4:37 PM, Ganesh wrote:
>
> On 11/4/19 9:40 PM, David Gibson wrote:
>> On Thu, Oct 24, 2019 at 01:13:04PM +0530, Ganesh Goudar wrote:
>>> From: Aravinda Prasad <arawinda.p@gmail.com>
>>>
>>> Upon a machine check exception (MCE) in a guest address space,
>>> KVM causes a guest exit to enable QEMU to build and pass the
>>> error to the guest in the PAPR defined rtas error log format.
>>>
>>> This patch builds the rtas error log, copies it to the rtas_addr
>>> and then invokes the guest registered machine check handler. The
>>> handler in the guest takes suitable action(s) depending on the type
>>> and criticality of the error. For example, if an error is
>>> unrecoverable memory corruption in an application inside the
>>> guest, then the guest kernel sends a SIGBUS to the application.
>>> For recoverable errors, the guest performs recovery actions and
>>> logs the error.
>>>
>>> [Assume SLOF has allocated enough room for rtas error log]
>> Is that correct with the SLOF image currently included in qemu?
> Yes
>>
>> Apart from that detail,
>>
>> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Hi David, Please see if this patch series can be merged to 4.2.
>>
>>> Signed-off-by: Ganesh Goudar <ganeshgr@linux.ibm.com>
>>> Signed-off-by: Aravinda Prasad <arawinda.p@gmail.com>
>>
>>
>>> ---
>>> =A0 hw/ppc/spapr_events.c=A0 | 220=20
>>> ++++++++++++++++++++++++++++++++++++++++-
>>> =A0 hw/ppc/spapr_rtas.c=A0=A0=A0 |=A0 26 +++++
>>> =A0 include/hw/ppc/spapr.h |=A0=A0 6 +-
>>> =A0 target/ppc/kvm.c=A0=A0=A0=A0=A0=A0 |=A0=A0 4 +-
>>> =A0 4 files changed, 253 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
>>> index 0ce96b86be..db44e09154 100644
>>> --- a/hw/ppc/spapr_events.c
>>> +++ b/hw/ppc/spapr_events.c
>>> @@ -214,6 +214,104 @@ struct hp_extended_log {
>>> =A0=A0=A0=A0=A0 struct rtas_event_log_v6_hp hp;
>>> =A0 } QEMU_PACKED;
>>> =A0 +struct rtas_event_log_v6_mc {
>>> +#define RTAS_LOG_V6_SECTION_ID_MC=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 0x4D43 /* MC */
>>> +=A0=A0=A0 struct rtas_event_log_v6_section_header hdr;
>>> +=A0=A0=A0 uint32_t fru_id;
>>> +=A0=A0=A0 uint32_t proc_id;
>>> +=A0=A0=A0 uint8_t error_type;
>>> +#define RTAS_LOG_V6_MC_TYPE_UE=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0
>>> +#define RTAS_LOG_V6_MC_TYPE_SLB=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 1
>>> +#define RTAS_LOG_V6_MC_TYPE_ERAT=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 2
>>> +#define RTAS_LOG_V6_MC_TYPE_TLB=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 4
>>> +#define RTAS_LOG_V6_MC_TYPE_D_CACHE=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 5
>>> +#define RTAS_LOG_V6_MC_TYPE_I_CACHE=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 7
>>> +=A0=A0=A0 uint8_t sub_err_type;
>>> +#define RTAS_LOG_V6_MC_UE_INDETERMINATE=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 0
>>> +#define RTAS_LOG_V6_MC_UE_IFETCH=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 1
>>> +#define RTAS_LOG_V6_MC_UE_PAGE_TABLE_WALK_IFETCH=A0=A0=A0=A0=A0=A0=A0=
=A0 2
>>> +#define RTAS_LOG_V6_MC_UE_LOAD_STORE=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 3
>>> +#define RTAS_LOG_V6_MC_UE_PAGE_TABLE_WALK_LOAD_STORE=A0=A0=A0=A0 4
>>> +#define RTAS_LOG_V6_MC_SLB_PARITY=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0
>>> +#define RTAS_LOG_V6_MC_SLB_MULTIHIT=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 1
>>> +#define RTAS_LOG_V6_MC_SLB_INDETERMINATE=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 2
>>> +#define RTAS_LOG_V6_MC_ERAT_PARITY=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 1
>>> +#define RTAS_LOG_V6_MC_ERAT_MULTIHIT=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 2
>>> +#define RTAS_LOG_V6_MC_ERAT_INDETERMINATE=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 3
>>> +#define RTAS_LOG_V6_MC_TLB_PARITY=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 1
>>> +#define RTAS_LOG_V6_MC_TLB_MULTIHIT=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 2
>>> +#define RTAS_LOG_V6_MC_TLB_INDETERMINATE=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 3
>>> +=A0=A0=A0 uint8_t reserved_1[6];
>>> +=A0=A0=A0 uint64_t effective_address;
>>> +=A0=A0=A0 uint64_t logical_address;
>>> +} QEMU_PACKED;
>>> +
>>> +struct mc_extended_log {
>>> +=A0=A0=A0 struct rtas_event_log_v6 v6hdr;
>>> +=A0=A0=A0 struct rtas_event_log_v6_mc mc;
>>> +} QEMU_PACKED;
>>> +
>>> +struct MC_ierror_table {
>>> +=A0=A0=A0 unsigned long srr1_mask;
>>> +=A0=A0=A0 unsigned long srr1_value;
>>> +=A0=A0=A0 bool nip_valid; /* nip is a valid indicator of faulting ad=
dress */
>>> +=A0=A0=A0 uint8_t error_type;
>>> +=A0=A0=A0 uint8_t error_subtype;
>>> +=A0=A0=A0 unsigned int initiator;
>>> +=A0=A0=A0 unsigned int severity;
>>> +};
>>> +
>>> +static const struct MC_ierror_table mc_ierror_table[] =3D {
>>> +{ 0x00000000081c0000, 0x0000000000040000, true,
>>> +=A0 RTAS_LOG_V6_MC_TYPE_UE, RTAS_LOG_V6_MC_UE_IFETCH,
>>> +=A0 RTAS_LOG_INITIATOR_CPU, RTAS_LOG_SEVERITY_ERROR_SYNC, },
>>> +{ 0x00000000081c0000, 0x0000000000080000, true,
>>> +=A0 RTAS_LOG_V6_MC_TYPE_SLB, RTAS_LOG_V6_MC_SLB_PARITY,
>>> +=A0 RTAS_LOG_INITIATOR_CPU, RTAS_LOG_SEVERITY_ERROR_SYNC, },
>>> +{ 0x00000000081c0000, 0x00000000000c0000, true,
>>> +=A0 RTAS_LOG_V6_MC_TYPE_SLB, RTAS_LOG_V6_MC_SLB_MULTIHIT,
>>> +=A0 RTAS_LOG_INITIATOR_CPU, RTAS_LOG_SEVERITY_ERROR_SYNC, },
>>> +{ 0x00000000081c0000, 0x0000000000100000, true,
>>> +=A0 RTAS_LOG_V6_MC_TYPE_ERAT, RTAS_LOG_V6_MC_ERAT_MULTIHIT,
>>> +=A0 RTAS_LOG_INITIATOR_CPU, RTAS_LOG_SEVERITY_ERROR_SYNC, },
>>> +{ 0x00000000081c0000, 0x0000000000140000, true,
>>> +=A0 RTAS_LOG_V6_MC_TYPE_TLB, RTAS_LOG_V6_MC_TLB_MULTIHIT,
>>> +=A0 RTAS_LOG_INITIATOR_CPU, RTAS_LOG_SEVERITY_ERROR_SYNC, },
>>> +{ 0x00000000081c0000, 0x0000000000180000, true,
>>> +=A0 RTAS_LOG_V6_MC_TYPE_UE, RTAS_LOG_V6_MC_UE_PAGE_TABLE_WALK_IFETCH=
,
>>> +=A0 RTAS_LOG_INITIATOR_CPU, RTAS_LOG_SEVERITY_ERROR_SYNC, } };
>>> +
>>> +struct MC_derror_table {
>>> +=A0=A0=A0 unsigned long dsisr_value;
>>> +=A0=A0=A0 bool dar_valid; /* dar is a valid indicator of faulting ad=
dress */
>>> +=A0=A0=A0 uint8_t error_type;
>>> +=A0=A0=A0 uint8_t error_subtype;
>>> +=A0=A0=A0 unsigned int initiator;
>>> +=A0=A0=A0 unsigned int severity;
>>> +};
>>> +
>>> +static const struct MC_derror_table mc_derror_table[] =3D {
>>> +{ 0x00008000, false,
>>> +=A0 RTAS_LOG_V6_MC_TYPE_UE, RTAS_LOG_V6_MC_UE_LOAD_STORE,
>>> +=A0 RTAS_LOG_INITIATOR_CPU, RTAS_LOG_SEVERITY_ERROR_SYNC, },
>>> +{ 0x00004000, true,
>>> +=A0 RTAS_LOG_V6_MC_TYPE_UE,=20
>>> RTAS_LOG_V6_MC_UE_PAGE_TABLE_WALK_LOAD_STORE,
>>> +=A0 RTAS_LOG_INITIATOR_CPU, RTAS_LOG_SEVERITY_ERROR_SYNC, },
>>> +{ 0x00000800, true,
>>> +=A0 RTAS_LOG_V6_MC_TYPE_ERAT, RTAS_LOG_V6_MC_ERAT_MULTIHIT,
>>> +=A0 RTAS_LOG_INITIATOR_CPU, RTAS_LOG_SEVERITY_ERROR_SYNC, },
>>> +{ 0x00000400, true,
>>> +=A0 RTAS_LOG_V6_MC_TYPE_TLB, RTAS_LOG_V6_MC_TLB_MULTIHIT,
>>> +=A0 RTAS_LOG_INITIATOR_CPU, RTAS_LOG_SEVERITY_ERROR_SYNC, },
>>> +{ 0x00000080, true,
>>> +=A0 RTAS_LOG_V6_MC_TYPE_SLB, RTAS_LOG_V6_MC_SLB_MULTIHIT,=A0 /* Befo=
re=20
>>> PARITY */
>>> +=A0 RTAS_LOG_INITIATOR_CPU, RTAS_LOG_SEVERITY_ERROR_SYNC, },
>>> +{ 0x00000100, true,
>>> +=A0 RTAS_LOG_V6_MC_TYPE_SLB, RTAS_LOG_V6_MC_SLB_PARITY,
>>> +=A0 RTAS_LOG_INITIATOR_CPU, RTAS_LOG_SEVERITY_ERROR_SYNC, } };
>>> +
>>> +#define SRR1_MC_LOADSTORE(srr1) ((srr1) & PPC_BIT(42))
>>> +
>>> =A0 typedef enum EventClass {
>>> =A0=A0=A0=A0=A0 EVENT_CLASS_INTERNAL_ERRORS=A0=A0=A0=A0 =3D 0,
>>> =A0=A0=A0=A0=A0 EVENT_CLASS_EPOW=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 =3D 1,
>>> @@ -622,7 +720,125 @@ void=20
>>> spapr_hotplug_req_remove_by_count_indexed(SpaprDrcType drc_type,
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 RTAS_LOG_V6_HP_ACTION_REMOVE,=20
>>> drc_type, &drc_id);
>>> =A0 }
>>> =A0 -void spapr_mce_req_event(PowerPCCPU *cpu)
>>> +static uint32_t spapr_mce_get_elog_type(PowerPCCPU *cpu, bool=20
>>> recovered,
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct mc_extended_log=20
>>> *ext_elog)
>>> +{
>>> +=A0=A0=A0 int i;
>>> +=A0=A0=A0 CPUPPCState *env =3D &cpu->env;
>>> +=A0=A0=A0 uint32_t summary;
>>> +=A0=A0=A0 uint64_t dsisr =3D env->spr[SPR_DSISR];
>>> +
>>> +=A0=A0=A0 summary =3D RTAS_LOG_VERSION_6 | RTAS_LOG_OPTIONAL_PART_PR=
ESENT;
>>> +=A0=A0=A0 if (recovered) {
>>> +=A0=A0=A0=A0=A0=A0=A0 summary |=3D RTAS_LOG_DISPOSITION_FULLY_RECOVE=
RED;
>>> +=A0=A0=A0 } else {
>>> +=A0=A0=A0=A0=A0=A0=A0 summary |=3D RTAS_LOG_DISPOSITION_NOT_RECOVERE=
D;
>>> +=A0=A0=A0 }
>>> +
>>> +=A0=A0=A0 if (SRR1_MC_LOADSTORE(env->spr[SPR_SRR1])) {
>>> +=A0=A0=A0=A0=A0=A0=A0 for (i =3D 0; i < ARRAY_SIZE(mc_derror_table);=
 i++) {
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (!(dsisr & mc_derror_table[i].d=
sisr_value)) {
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 continue;
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
>>> +
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ext_elog->mc.error_type =3D mc_der=
ror_table[i].error_type;
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ext_elog->mc.sub_err_type =3D=20
>>> mc_derror_table[i].error_subtype;
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (mc_derror_table[i].dar_valid) =
{
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ext_elog->mc.effective=
_address =3D=20
>>> cpu_to_be64(env->spr[SPR_DAR]);
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
>>> +
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 summary |=3D mc_derror_table[i].in=
itiator
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 | mc_derror_table[i].severity;
>>> +
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return summary;
>>> +=A0=A0=A0=A0=A0=A0=A0 }
>>> +=A0=A0=A0 } else {
>>> +=A0=A0=A0=A0=A0=A0=A0 for (i =3D 0; i < ARRAY_SIZE(mc_ierror_table);=
 i++) {
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if ((env->spr[SPR_SRR1] & mc_ierro=
r_table[i].srr1_mask) !=3D
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 mc_ierror_=
table[i].srr1_value) {
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 continue;
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
>>> +
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ext_elog->mc.error_type =3D mc_ier=
ror_table[i].error_type;
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ext_elog->mc.sub_err_type =3D=20
>>> mc_ierror_table[i].error_subtype;
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (mc_ierror_table[i].nip_valid) =
{
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ext_elog->mc.effective=
_address =3D=20
>>> cpu_to_be64(env->nip);
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
>>> +
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 summary |=3D mc_ierror_table[i].in=
itiator
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 | mc_ierror_table[i].severity;
>>> +
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return summary;
>>> +=A0=A0=A0=A0=A0=A0=A0 }
>>> +=A0=A0=A0 }
>>> +
>>> +=A0=A0=A0 summary |=3D RTAS_LOG_INITIATOR_CPU;
>>> +=A0=A0=A0 return summary;
>>> +}
>>> +
>>> +static void spapr_mce_dispatch_elog(PowerPCCPU *cpu, bool recovered)
>>> +{
>>> +=A0=A0=A0 SpaprMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machin=
e());
>>> +=A0=A0=A0 CPUState *cs =3D CPU(cpu);
>>> +=A0=A0=A0 uint64_t rtas_addr;
>>> +=A0=A0=A0 CPUPPCState *env =3D &cpu->env;
>>> +=A0=A0=A0 PowerPCCPUClass *pcc =3D POWERPC_CPU_GET_CLASS(cpu);
>>> +=A0=A0=A0 target_ulong msr =3D 0;
>>> +=A0=A0=A0 struct rtas_error_log log;
>>> +=A0=A0=A0 struct mc_extended_log *ext_elog;
>>> +=A0=A0=A0 uint32_t summary;
>>> +
>>> +=A0=A0=A0 /*
>>> +=A0=A0=A0=A0 * Properly set bits in MSR before we invoke the handler.
>>> +=A0=A0=A0=A0 * SRR0/1, DAR and DSISR are properly set by KVM
>>> +=A0=A0=A0=A0 */
>>> +=A0=A0=A0 if (!(*pcc->interrupts_big_endian)(cpu)) {
>>> +=A0=A0=A0=A0=A0=A0=A0 msr |=3D (1ULL << MSR_LE);
>>> +=A0=A0=A0 }
>>> +
>>> +=A0=A0=A0 if (env->msr & (1ULL << MSR_SF)) {
>>> +=A0=A0=A0=A0=A0=A0=A0 msr |=3D (1ULL << MSR_SF);
>>> +=A0=A0=A0 }
>>> +
>>> +=A0=A0=A0 msr |=3D (1ULL << MSR_ME);
>>> +
>>> +=A0=A0=A0 ext_elog =3D g_malloc0(sizeof(*ext_elog));
>>> +=A0=A0=A0 summary =3D spapr_mce_get_elog_type(cpu, recovered, ext_el=
og);
>>> +
>>> +=A0=A0=A0 log.summary =3D cpu_to_be32(summary);
>>> +=A0=A0=A0 log.extended_length =3D cpu_to_be32(sizeof(*ext_elog));
>>> +
>>> +=A0=A0=A0 spapr_init_v6hdr(&ext_elog->v6hdr);
>>> +=A0=A0=A0 ext_elog->mc.hdr.section_id =3D=20
>>> cpu_to_be16(RTAS_LOG_V6_SECTION_ID_MC);
>>> +=A0=A0=A0 ext_elog->mc.hdr.section_length =3D
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 cpu_to_be1=
6(sizeof(struct rtas_event_log_v6_mc));
>>> +=A0=A0=A0 ext_elog->mc.hdr.section_version =3D 1;
>>> +
>>> +=A0=A0=A0 /* get rtas addr from fdt */
>>> +=A0=A0=A0 rtas_addr =3D spapr_get_rtas_addr();
>>> +=A0=A0=A0 if (!rtas_addr) {
>>> +=A0=A0=A0=A0=A0=A0=A0 /* Unable to fetch rtas_addr. Hence reset the =
guest */
>>> +=A0=A0=A0=A0=A0=A0=A0 ppc_cpu_do_system_reset(cs);
>>> +=A0=A0=A0=A0=A0=A0=A0 g_free(ext_elog);
>>> +=A0=A0=A0=A0=A0=A0=A0 return;
>>> +=A0=A0=A0 }
>>> +
>>> +=A0=A0=A0 stq_be_phys(&address_space_memory, rtas_addr +=20
>>> RTAS_ERROR_LOG_OFFSET,
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 env->gpr[3]);
>>> +=A0=A0=A0 cpu_physical_memory_write(rtas_addr + RTAS_ERROR_LOG_OFFSE=
T +
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 sizeof(env->gpr[3]), &log, sizeof(log));
>>> +=A0=A0=A0 cpu_physical_memory_write(rtas_addr + RTAS_ERROR_LOG_OFFSE=
T +
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 sizeof(env->gpr[3]) + sizeof(log),=20
>>> ext_elog,
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 sizeof(*ext_elog));
>>> +
>>> +=A0=A0=A0 env->gpr[3] =3D rtas_addr + RTAS_ERROR_LOG_OFFSET;
>>> +=A0=A0=A0 env->msr =3D msr;
>>> +=A0=A0=A0 env->nip =3D spapr->guest_machine_check_addr;
>>> +
>>> +=A0=A0=A0 g_free(ext_elog);
>>> +}
>>> +
>>> +void spapr_mce_req_event(PowerPCCPU *cpu, bool recovered)
>>> =A0 {
>>> =A0=A0=A0=A0=A0 SpaprMachineState *spapr =3D SPAPR_MACHINE(qdev_get_m=
achine());
>>> =A0=A0=A0=A0=A0 CPUState *cs =3D CPU(cpu);
>>> @@ -656,6 +872,8 @@ void spapr_mce_req_event(PowerPCCPU *cpu)
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 }
>>> =A0=A0=A0=A0=A0 }
>>> =A0=A0=A0=A0=A0 spapr->mc_status =3D cpu->vcpu_id;
>>> +
>>> +=A0=A0=A0 spapr_mce_dispatch_elog(cpu, recovered);
>>> =A0 }
>>> =A0 =A0 static void check_exception(PowerPCCPU *cpu, SpaprMachineStat=
e=20
>>> *spapr,
>>> diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
>>> index 8d8d8cdfcb..2c066a372d 100644
>>> --- a/hw/ppc/spapr_rtas.c
>>> +++ b/hw/ppc/spapr_rtas.c
>>> @@ -477,6 +477,32 @@ void spapr_dt_rtas_tokens(void *fdt, int rtas)
>>> =A0=A0=A0=A0=A0 }
>>> =A0 }
>>> =A0 +hwaddr spapr_get_rtas_addr(void)
>>> +{
>>> +=A0=A0=A0 SpaprMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machin=
e());
>>> +=A0=A0=A0 int rtas_node;
>>> +=A0=A0=A0 const fdt32_t *rtas_data;
>>> +=A0=A0=A0 void *fdt =3D spapr->fdt_blob;
>>> +
>>> +=A0=A0=A0 /* fetch rtas addr from fdt */
>>> +=A0=A0=A0 rtas_node =3D fdt_path_offset(fdt, "/rtas");
>>> +=A0=A0=A0 if (rtas_node < 0) {
>>> +=A0=A0=A0=A0=A0=A0=A0 return 0;
>>> +=A0=A0=A0 }
>>> +
>>> +=A0=A0=A0 rtas_data =3D fdt_getprop(fdt, rtas_node, "linux,rtas-base=
", NULL);
>>> +=A0=A0=A0 if (!rtas_data) {
>>> +=A0=A0=A0=A0=A0=A0=A0 return 0;
>>> +=A0=A0=A0 }
>>> +
>>> +=A0=A0=A0 /*
>>> +=A0=A0=A0=A0 * We assume that the OS called RTAS instantiate-rtas, b=
ut some=20
>>> other
>>> +=A0=A0=A0=A0 * OS might call RTAS instantiate-rtas-64 instead. This =
fine as=20
>>> of now
>>> +=A0=A0=A0=A0 * as SLOF only supports 32-bit variant.
>>> +=A0=A0=A0=A0 */
>>> +=A0=A0=A0 return (hwaddr)fdt32_to_cpu(*rtas_data);
>>> +}
>>> +
>>> =A0 static void core_rtas_register_types(void)
>>> =A0 {
>>> =A0=A0=A0=A0=A0 spapr_rtas_register(RTAS_DISPLAY_CHARACTER, "display-=
character",
>>> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
>>> index 1f5eb8c856..4afa8d4d09 100644
>>> --- a/include/hw/ppc/spapr.h
>>> +++ b/include/hw/ppc/spapr.h
>>> @@ -724,6 +724,9 @@ void spapr_load_rtas(SpaprMachineState *spapr,=20
>>> void *fdt, hwaddr addr);
>>> =A0 =A0 #define RTAS_ERROR_LOG_MAX=A0=A0=A0=A0=A0 2048
>>> =A0 +/* Offset from rtas-base where error log is placed */
>>> +#define RTAS_ERROR_LOG_OFFSET=A0=A0=A0=A0=A0=A0 0x30
>>> +
>>> =A0 #define RTAS_EVENT_SCAN_RATE=A0=A0=A0 1
>>> =A0 =A0 /* This helper should be used to encode interrupt specifiers=20
>>> when the related
>>> @@ -812,7 +815,7 @@ void=20
>>> spapr_clear_pending_events(SpaprMachineState *spapr);
>>> =A0 int spapr_max_server_number(SpaprMachineState *spapr);
>>> =A0 void spapr_store_hpte(PowerPCCPU *cpu, hwaddr ptex,
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 uint64_t pte0, uint64_t pte1);
>>> -void spapr_mce_req_event(PowerPCCPU *cpu);
>>> +void spapr_mce_req_event(PowerPCCPU *cpu, bool recovered);
>>> =A0 =A0 /* DRC callbacks. */
>>> =A0 void spapr_core_release(DeviceState *dev);
>>> @@ -903,4 +906,5 @@ void spapr_check_pagesize(SpaprMachineState=20
>>> *spapr, hwaddr pagesize,
>>> =A0 #define SPAPR_OV5_XIVE_BOTH=A0=A0=A0=A0 0x80 /* Only to advertise=
 on the=20
>>> platform */
>>> =A0 =A0 void spapr_set_all_lpcrs(target_ulong value, target_ulong mas=
k);
>>> +hwaddr spapr_get_rtas_addr(void);
>>> =A0 #endif /* HW_SPAPR_H */
>>> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
>>> index 2d8db6d832..9a902c1064 100644
>>> --- a/target/ppc/kvm.c
>>> +++ b/target/ppc/kvm.c
>>> @@ -2805,9 +2805,11 @@ int kvm_arch_msi_data_to_gsi(uint32_t data)
>>> =A0 =A0 int kvm_handle_nmi(PowerPCCPU *cpu, struct kvm_run *run)
>>> =A0 {
>>> +=A0=A0=A0 bool recovered =3D run->flags & KVM_RUN_PPC_NMI_DISP_FULLY=
_RECOV;
>>> +
>>> =A0=A0=A0=A0=A0 cpu_synchronize_state(CPU(cpu));
>>> =A0 -=A0=A0=A0 spapr_mce_req_event(cpu);
>>> +=A0=A0=A0 spapr_mce_req_event(cpu, recovered);
>>> =A0 =A0=A0=A0=A0=A0 return 0;
>>> =A0 }


