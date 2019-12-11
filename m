Return-Path: <SRS0=Q6KP=2B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABBFDC43603
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 13:56:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E164214D8
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 13:56:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E164214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1if2TD-0003yb-WB
	for qemu-devel@archiver.kernel.org; Wed, 11 Dec 2019 08:56:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54238)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ganeshgr@linux.ibm.com>) id 1if2Nq-0005Ph-53
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 08:50:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ganeshgr@linux.ibm.com>) id 1if2No-0008IX-FQ
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 08:50:30 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:21822
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ganeshgr@linux.ibm.com>)
 id 1if2No-0008HA-9L
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 08:50:28 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xBBDnwPS126276
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2019 08:50:26 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2wsqc2brrk-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2019 08:50:25 -0500
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <ganeshgr@linux.ibm.com>;
 Wed, 11 Dec 2019 13:50:23 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
 by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 11 Dec 2019 13:50:20 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com
 [9.149.105.60])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xBBDoJxW54329584
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 11 Dec 2019 13:50:19 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 151A442049;
 Wed, 11 Dec 2019 13:50:19 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1B39242047;
 Wed, 11 Dec 2019 13:50:17 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.86.247])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed, 11 Dec 2019 13:50:16 +0000 (GMT)
Subject: Re: [PATCH v17 5/7] ppc: spapr: Handle "ibm,nmi-register" and
 "ibm,nmi-interlock" RTAS calls
From: Ganesh <ganeshgr@linux.ibm.com>
To: David Gibson <david@gibson.dropbear.id.au>
References: <20191024074307.22821-1-ganeshgr@linux.ibm.com>
 <20191024074307.22821-6-ganeshgr@linux.ibm.com>
 <20191119023932.GL5582@umbus.fritz.box>
 <edc7a454-98dc-aac1-88cc-a5596ee34860@linux.ibm.com>
Date: Wed, 11 Dec 2019 19:20:16 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <edc7a454-98dc-aac1-88cc-a5596ee34860@linux.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 19121113-0028-0000-0000-000003C78D9D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19121113-0029-0000-0000-0000248AC2F6
Message-Id: <a56b63ce-de9b-d422-bc9e-62f2627a8b92@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-11_03:2019-12-11,2019-12-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0
 malwarescore=0 suspectscore=0 clxscore=1015 mlxscore=0 phishscore=0
 priorityscore=1501 mlxlogscore=999 spamscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912110117
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by
 mx0b-001b2d01.pphosted.com id xBBDnwPS126276
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
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
Cc: arawinda.p@gmail.com, aik@ozlabs.ru, qemu-devel@nongnu.org, groug@kaod.org,
 paulus@ozlabs.org, qemu-ppc@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 12/5/19 10:25 AM, Ganesh wrote:
>
> On 11/19/19 8:09 AM, David Gibson wrote:
>> On Thu, Oct 24, 2019 at 01:13:05PM +0530, Ganesh Goudar wrote:
>>> From: Aravinda Prasad <arawinda.p@gmail.com>
>>>
>>> This patch adds support in QEMU to handle "ibm,nmi-register"
>>> and "ibm,nmi-interlock" RTAS calls.
>>>
>>> The machine check notification address is saved when the
>>> OS issues "ibm,nmi-register" RTAS call.
>>>
>>> This patch also handles the case when multiple processors
>>> experience machine check at or about the same time by
>>> handling "ibm,nmi-interlock" call. In such cases, as per
>>> PAPR, subsequent processors serialize waiting for the first
>>> processor to issue the "ibm,nmi-interlock" call. The second
>>> processor that also received a machine check error waits
>>> till the first processor is done reading the error log.
>>> The first processor issues "ibm,nmi-interlock" call
>>> when the error log is consumed.
>>>
>>> [Move fwnmi registeration to .apply hook]
>> s/registeration/registration/
> Thanks
>>
>>> Signed-off-by: Ganesh Goudar <ganeshgr@linux.ibm.com>
>>> Signed-off-by: Aravinda Prasad <arawinda.p@gmail.com>
>>> ---
>>> =A0 hw/ppc/spapr_caps.c=A0=A0=A0 |=A0 9 +++++--
>>> =A0 hw/ppc/spapr_rtas.c=A0=A0=A0 | 57=20
>>> ++++++++++++++++++++++++++++++++++++++++++
>>> =A0 include/hw/ppc/spapr.h |=A0 5 +++-
>>> =A0 3 files changed, 68 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
>>> index 976d709210..1675ebd45e 100644
>>> --- a/hw/ppc/spapr_caps.c
>>> +++ b/hw/ppc/spapr_caps.c
>>> @@ -509,9 +509,14 @@ static void=20
>>> cap_fwnmi_mce_apply(SpaprMachineState *spapr, uint8_t val,
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * of software injected faults like dup=
licate SLBs).
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 */
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 warn_report("Firmware Assisted Non-Maskab=
le Interrupts not=20
>>> supported in TCG");
>> This logic still isn't quite right.=A0 To start with the warn_report()
>> above possible wants to be more weakly worded.=A0 With TCG, FWNMI won'=
t
>> generally *do* anything, and there are some edge cases where the
>> behaviour is arguably incorrect.=A0 However there's no reason we can't
>> make the RTAS calls work basically as expected and in almost all cases
>> things will behave correctly - at least according to the case where no
>> fwnmi events are delivered...
> ok
>>
>>> -=A0=A0=A0 } else if (kvm_enabled() && (kvmppc_set_fwnmi() !=3D 0)) {
>>> -=A0=A0=A0=A0=A0=A0=A0 error_setg(errp,
>>> +=A0=A0=A0 } else if (kvm_enabled()) {
>>> +=A0=A0=A0=A0=A0=A0=A0 if (!kvmppc_set_fwnmi()) {
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* Register ibm,nmi-register and i=
bm,nmi-interlock RTAS=20
>>> calls */
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 spapr_fwnmi_register();
>> ..but here you only register the RTAS calls in the KVM case, which
>> breaks that.=A0 If there really is a strong reason to do this, then th=
e
>> warn_report() above should be error_setg() and fail the apply.

Also I found a side effect of moving this fwnmi registration to apply=20
hook, I see the following assert

when I reboot the guest. may be I must have a member to indicate if the=20
registration is already done.

Requesting system reboot
[=A0 186.368745] sd 0:0:0:0: [sda] Synchronizing SCSI cache
[=A0 186.370222] reboot: Restarting system
#######MACHINE RESET######
#####SPAPR_FWNMI_REGISTER######
qemu-system-ppc64: /home/jupit/qemu/hw/ppc/spapr_rtas.c:510:=20
spapr_rtas_register: Assertion `!name || !rtas_table[token].name' failed.
Aborted

>>
>>> +=A0=A0=A0=A0=A0=A0=A0 } else {
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 error_setg(errp,
>>> =A0 "Firmware Assisted Non-Maskable Interrupts not supported by KVM,=20
>>> try cap-fwnmi-mce=3Doff");
>>> +=A0=A0=A0=A0=A0=A0=A0 }
>>> =A0=A0=A0=A0=A0 }
>>> =A0 }
>>> =A0 diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
>>> index 2c066a372d..0328b1f341 100644
>>> --- a/hw/ppc/spapr_rtas.c
>>> +++ b/hw/ppc/spapr_rtas.c
>>> @@ -400,6 +400,55 @@ static void rtas_get_power_level(PowerPCCPU=20
>>> *cpu, SpaprMachineState *spapr,
>>> =A0=A0=A0=A0=A0 rtas_st(rets, 1, 100);
>>> =A0 }
>>> =A0 +static void rtas_ibm_nmi_register(PowerPCCPU *cpu,
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 SpaprMachineState *spapr,
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 uint32_t token, uint32_t nargs,
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 target_ulong args,
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 uint32_t nret, target_ulong rets)
>>> +{
>>> +=A0=A0=A0 hwaddr rtas_addr =3D spapr_get_rtas_addr();
>>> +
>>> +=A0=A0=A0 if (!rtas_addr) {
>>> +=A0=A0=A0=A0=A0=A0=A0 rtas_st(rets, 0, RTAS_OUT_NOT_SUPPORTED);
>>> +=A0=A0=A0=A0=A0=A0=A0 return;
>>> +=A0=A0=A0 }
>>> +
>>> +=A0=A0=A0 if (spapr_get_cap(spapr, SPAPR_CAP_FWNMI_MCE) =3D=3D SPAPR=
_CAP_OFF) {
>>> +=A0=A0=A0=A0=A0=A0=A0 rtas_st(rets, 0, RTAS_OUT_NOT_SUPPORTED);
>> Actually, since you explicitly test for the cap being enabled here,
>> there's no reason not to *always* register this RTAS call.=A0 Also thi=
s
>> test for the feature flag should go first, before delving into the
>> device tree for the RTAS address.
> Sure, will do
>>
>>> +=A0=A0=A0=A0=A0=A0=A0 return;
>>> +=A0=A0=A0 }
>>> +
>>> +=A0=A0=A0 spapr->guest_machine_check_addr =3D rtas_ld(args, 1);
>>> +=A0=A0=A0 rtas_st(rets, 0, RTAS_OUT_SUCCESS);
>>> +}
>>> +
>>> +static void rtas_ibm_nmi_interlock(PowerPCCPU *cpu,
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 SpaprMachineState *spapr,
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 uint32_t token, uint32_t nargs,
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 target_ulong args,
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 uint32_t nret, target_ulong rets)
>>> +{
>>> +=A0=A0=A0 if (spapr->guest_machine_check_addr =3D=3D -1) {
>>> +=A0=A0=A0=A0=A0=A0=A0 /* NMI register not called */
>>> +=A0=A0=A0=A0=A0=A0=A0 rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
>>> +=A0=A0=A0=A0=A0=A0=A0 return;
>>> +=A0=A0=A0 }
>>> +
>>> +=A0=A0=A0 if (spapr->mc_status !=3D cpu->vcpu_id) {
>>> +=A0=A0=A0=A0=A0=A0=A0 /* The vCPU that hit the NMI should invoke=20
>>> "ibm,nmi-interlock" */
>>> +=A0=A0=A0=A0=A0=A0=A0 rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
>>> +=A0=A0=A0=A0=A0=A0=A0 return;
>>> +=A0=A0=A0 }
>>> +
>>> +=A0=A0=A0 /*
>>> +=A0=A0=A0=A0 * vCPU issuing "ibm,nmi-interlock" is done with NMI han=
dling,
>>> +=A0=A0=A0=A0 * hence unset mc_status.
>>> +=A0=A0=A0=A0 */
>>> +=A0=A0=A0 spapr->mc_status =3D -1;
>>> +=A0=A0=A0 qemu_cond_signal(&spapr->mc_delivery_cond);
>>> +=A0=A0=A0 rtas_st(rets, 0, RTAS_OUT_SUCCESS);
>>> +}
>>> +
>>> =A0 static struct rtas_call {
>>> =A0=A0=A0=A0=A0 const char *name;
>>> =A0=A0=A0=A0=A0 spapr_rtas_fn fn;
>>> @@ -503,6 +552,14 @@ hwaddr spapr_get_rtas_addr(void)
>>> =A0=A0=A0=A0=A0 return (hwaddr)fdt32_to_cpu(*rtas_data);
>>> =A0 }
>>> =A0 +void spapr_fwnmi_register(void)
>>> +{
>>> +=A0=A0=A0 spapr_rtas_register(RTAS_IBM_NMI_REGISTER, "ibm,nmi-regist=
er",
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 rtas_ibm_nmi_register);
>>> +=A0=A0=A0 spapr_rtas_register(RTAS_IBM_NMI_INTERLOCK, "ibm,nmi-inter=
lock",
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 rtas_ibm_nmi_interlock);
>>> +}
>>> +
>>> =A0 static void core_rtas_register_types(void)
>>> =A0 {
>>> =A0=A0=A0=A0=A0 spapr_rtas_register(RTAS_DISPLAY_CHARACTER, "display-=
character",
>>> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
>>> index 4afa8d4d09..86f0fc8fdd 100644
>>> --- a/include/hw/ppc/spapr.h
>>> +++ b/include/hw/ppc/spapr.h
>>> @@ -653,8 +653,10 @@ target_ulong spapr_hypercall(PowerPCCPU *cpu,=20
>>> target_ulong opcode,
>>> =A0 #define RTAS_IBM_REMOVE_PE_DMA_WINDOW (RTAS_TOKEN_BASE + 0x28)
>>> =A0 #define RTAS_IBM_RESET_PE_DMA_WINDOW (RTAS_TOKEN_BASE + 0x29)
>>> =A0 #define RTAS_IBM_SUSPEND_ME (RTAS_TOKEN_BASE + 0x2A)
>>> +#define RTAS_IBM_NMI_REGISTER (RTAS_TOKEN_BASE + 0x2B)
>>> +#define RTAS_IBM_NMI_INTERLOCK (RTAS_TOKEN_BASE + 0x2C)
>>> =A0 -#define RTAS_TOKEN_MAX (RTAS_TOKEN_BASE + 0x2B)
>>> +#define RTAS_TOKEN_MAX (RTAS_TOKEN_BASE + 0x2D)
>>> =A0 =A0 /* RTAS ibm,get-system-parameter token values */
>>> =A0 #define RTAS_SYSPARM_SPLPAR_CHARACTERISTICS=A0=A0=A0=A0=A0 20
>>> @@ -907,4 +909,5 @@ void spapr_check_pagesize(SpaprMachineState=20
>>> *spapr, hwaddr pagesize,
>>> =A0 =A0 void spapr_set_all_lpcrs(target_ulong value, target_ulong mas=
k);
>>> =A0 hwaddr spapr_get_rtas_addr(void);
>>> +void spapr_fwnmi_register(void);
>>> =A0 #endif /* HW_SPAPR_H */


