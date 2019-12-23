Return-Path: <SRS0=AgAn=2N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C8DDC2D0C0
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Dec 2019 23:28:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 001B5206D3
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Dec 2019 23:28:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 001B5206D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ijX82-0006u2-1A
	for qemu-devel@archiver.kernel.org; Mon, 23 Dec 2019 18:28:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55112)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <farosas@linux.ibm.com>) id 1ijX7N-0006M4-4Q
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 18:28:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <farosas@linux.ibm.com>) id 1ijX7L-000083-V6
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 18:28:05 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:31972
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <farosas@linux.ibm.com>)
 id 1ijX7J-0008VC-HC; Mon, 23 Dec 2019 18:28:01 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xBNNO4DV182078; Mon, 23 Dec 2019 18:27:54 -0500
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com
 [169.63.121.186])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2x21kyjba7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Dec 2019 18:27:54 -0500
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
 by ppma03wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id xBNNPshY016777;
 Mon, 23 Dec 2019 23:27:54 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by ppma03wdc.us.ibm.com with ESMTP id 2x1b1663nr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Dec 2019 23:27:54 +0000
Received: from b03ledav005.gho.boulder.ibm.com
 (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xBNNRrxb62587180
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 23 Dec 2019 23:27:53 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EEB95BE053;
 Mon, 23 Dec 2019 23:27:52 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6760EBE054;
 Mon, 23 Dec 2019 23:27:52 +0000 (GMT)
Received: from localhost (unknown [9.85.137.176])
 by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTPS;
 Mon, 23 Dec 2019 23:27:51 +0000 (GMT)
From: Fabiano Rosas <farosas@linux.ibm.com>
To: David Gibson <david@gibson.dropbear.id.au>,
 "Maxiwell S. Garcia" <maxiwell@linux.ibm.com>
Subject: Re: [PATCH] target/ppc: fix memory dump endianness in QEMU monitor
In-Reply-To: <20191223063043.GH38380@umbus.modem>
References: <20191219163854.8945-1-maxiwell@linux.ibm.com>
 <20191223063043.GH38380@umbus.modem>
Date: Mon, 23 Dec 2019 20:27:49 -0300
Message-ID: <875zi6fwqy.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-23_10:2019-12-23,2019-12-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=899
 impostorscore=0 spamscore=0 mlxscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 lowpriorityscore=0 phishscore=0 suspectscore=1 clxscore=1015
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912230204
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

David Gibson <david@gibson.dropbear.id.au> writes:

> b) AFAICT this is the *only* thing that looks for the LE bit in
> hflags. Given that, and the fact that it would be wrong in most cases,
> we should remove it from hflags entirely along with this change.
>

I see there is:

static void ppc_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
{
    ...
    ctx->le_mode = !!(env->hflags & (1 << MSR_LE));
    ...
}

And we call hreg_recompute_hflags in some places:

- powerpc_excp (target/ppc/excp_helper.c)
  Called from TCG do_interrupt

- ppc_cpu_reset (target/ppc/translate_init.inc.c)
  Called from spapr_machine_reset

- hreg_store_msr (target/ppc/helper_regs.h)
  This is used for migration and for do_rfi, store_msr

- h_cede (hw/ppc/spapr_hcall.c)
  QEMU-side H_CEDE hypercall implementation 


It looks like the hflags MSR_LE is being updated correctly with TCG. But
with KVM we only touch it on system_reset (and possibly h_cede? I don't
know if it is QEMU who handles it).

So I would let hflags be.


... Actually, I don't really know the purpose of hflags. It comes from:

  commit 3f3373166227b13e762e20d2fb51eadfa6a2d653
  Author: Fabrice Bellard <fabrice@bellard.org>
  Date:   Wed Aug 20 23:02:09 2003 +0000
  
      pop ss, mov ss, x and sti disable irqs for the next instruction -
      began dispatch optimization by adding new x86 cpu 'hidden' flags
      
      
      git-svn-id: svn://svn.savannah.nongnu.org/qemu/trunk@372 c046a42c-6fe2-441c-8c8c-71466251a162

Could any one clarify that?

Thanks

>> ---
>>  target/ppc/translate_init.inc.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.inc.c
>> index d33d65dff7..a0b384da9e 100644
>> --- a/target/ppc/translate_init.inc.c
>> +++ b/target/ppc/translate_init.inc.c
>> @@ -10830,7 +10830,7 @@ static void ppc_disas_set_info(CPUState *cs, disassemble_info *info)
>>      PowerPCCPU *cpu = POWERPC_CPU(cs);
>>      CPUPPCState *env = &cpu->env;
>>  
>> -    if ((env->hflags >> MSR_LE) & 1) {
>> +    if (msr_le) {
>>          info->endian = BFD_ENDIAN_LITTLE;
>>      }
>>      info->mach = env->bfd_mach;

