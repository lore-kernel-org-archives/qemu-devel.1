Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21C61C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 23:04:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D463A20774
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 23:04:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NUHaEQ4R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D463A20774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43016 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6MGS-0000sS-4y
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 19:04:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44580)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gromero@linux.vnet.ibm.com>)
 id 1k6MFj-0000M4-B6; Thu, 13 Aug 2020 19:03:19 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:23448
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gromero@linux.vnet.ibm.com>)
 id 1k6MFg-0006ty-VK; Thu, 13 Aug 2020 19:03:19 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 07DN2x7Q011584; Thu, 13 Aug 2020 19:03:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=/1sBkrNwgaoTTInoJ3KKTUJiZk23gLMZGKOhCYtOyv8=;
 b=NUHaEQ4RVuuqEpiT2Wzu9kjA8loZayicxu7V2P/yg19wp1FPXeKp+lMyTrmekdgy+Yh5
 6AxWJs6YLrU0jF72kJ+osIJ6ctKO77CutlpwrNlasEdfdMmIixBrZmYfjIJVJHl1HjO8
 Ht+ci08ie9SWi3a/deuYiOYGYLE3ozqQnO/EI3U1wTeBF1V8GRvNmZ/UKdIMrOqu7cfu
 FltiMU9wLkydheoAXxRFiKDYt2hfZoRVXcYvbb0nf0+PdsdAGEfqsyXJ41YMn1iHL8Vx
 qW40ok9jZTR+crRjNQmxa7nXfhS8NhOJWfhdRbRmVcRTFTLjBQMfGkRaNG0pqy1Y+IcU TA== 
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com
 [169.55.85.253])
 by mx0b-001b2d01.pphosted.com with ESMTP id 32w6vcn2bg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 13 Aug 2020 19:03:07 -0400
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
 by ppma01wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07DMiaVU010202;
 Thu, 13 Aug 2020 23:01:56 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26]) by ppma01wdc.us.ibm.com with ESMTP id 32skp9nqxa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 13 Aug 2020 23:01:56 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com
 [9.57.199.109])
 by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 07DN1t5q40894782
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 13 Aug 2020 23:01:55 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AA54F112065;
 Thu, 13 Aug 2020 23:01:55 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 05703112064;
 Thu, 13 Aug 2020 23:01:54 +0000 (GMT)
Received: from oc6336877782.ibm.com (unknown [9.85.187.161])
 by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
 Thu, 13 Aug 2020 23:01:54 +0000 (GMT)
Subject: Re: [PATCH] spapr/xive: Use xive_source_esb_len()
To: Greg Kurz <groug@kaod.org>
References: <159733969034.320580.6571451425779179477.stgit@bahia.lan>
 <b5cfd02b-abf7-8d03-7ae2-1f483bf7b0bc@linux.vnet.ibm.com>
 <20200814000024.3b78d907@bahia.lan>
From: Gustavo Romero <gromero@linux.vnet.ibm.com>
Message-ID: <a7a0246e-37f4-c55f-803f-ef1642067988@linux.vnet.ibm.com>
Date: Thu, 13 Aug 2020 20:01:54 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200814000024.3b78d907@bahia.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-08-13_17:2020-08-13,
 2020-08-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 lowpriorityscore=0
 clxscore=1015 impostorscore=0 mlxscore=0 priorityscore=1501 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008130159
Received-SPF: none client-ip=148.163.158.5;
 envelope-from=gromero@linux.vnet.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/13 19:03:15
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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

On 8/13/20 7:00 PM, Greg Kurz wrote:
> On Thu, 13 Aug 2020 17:38:59 -0300
> Gustavo Romero <gromero@linux.vnet.ibm.com> wrote:
> 
>> Hi Greg,
>>
> 
> Hi Gustavo,
> 
>> On 8/13/20 2:28 PM, Greg Kurz wrote:
>>> static inline size_t xive_source_esb_len(XiveSource *xsrc)
>>> {
>>>       return (1ull << xsrc->esb_shift) * xsrc->nr_irqs;
>>> }
>>>
>>> Signed-off-by: Greg Kurz <groug@kaod.org>
>>> ---
>>> Follow-up on "ppc/xive: Rework setup of XiveSource::esb_mmio"
>>> http://patchwork.ozlabs.org/project/qemu-devel/patch/159679992680.876294.7520540158586170894.stgit@bahia.lan/
>>> ---
>>>    hw/intc/spapr_xive.c     |    2 +-
>>>    hw/intc/spapr_xive_kvm.c |    2 +-
>>>    2 files changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
>>> index 3c84f64dc464..4bd0d606ba17 100644
>>> --- a/hw/intc/spapr_xive.c
>>> +++ b/hw/intc/spapr_xive.c
>>> @@ -336,7 +336,7 @@ static void spapr_xive_realize(DeviceState *dev, Error **errp)
>>>        sysbus_init_mmio(SYS_BUS_DEVICE(xive), &end_xsrc->esb_mmio);
>>>    
>>>        /* Set the mapping address of the END ESB pages after the source ESBs */
>>> -    xive->end_base = xive->vc_base + (1ull << xsrc->esb_shift) * xsrc->nr_irqs;
>>> +    xive->end_base = xive->vc_base + xive_source_esb_len(xsrc);
>>>    
>>>        /*
>>>         * Allocate the routing tables
>>> diff --git a/hw/intc/spapr_xive_kvm.c b/hw/intc/spapr_xive_kvm.c
>>> index 82a6f99f022d..3263b982239a 100644
>>> --- a/hw/intc/spapr_xive_kvm.c
>>> +++ b/hw/intc/spapr_xive_kvm.c
>>> @@ -831,7 +831,7 @@ void kvmppc_xive_disconnect(SpaprInterruptController *intc)
>>>    
>>>        /* Clear the KVM mapping */
>>>        xsrc = &xive->source;
>>> -    esb_len = (1ull << xsrc->esb_shift) * xsrc->nr_irqs;
>>> +    esb_len = xive_source_esb_len(xsrc);
>>
>> hrm I'd like to not add another level of indirection here.
>> In this specific case I think it's more clear to read just
>>
>> 1ull << xsrc->esb_shift) * xsrc->nr_irqs
>>
>> and get the idea of one IRQ per ESB page (or pair of pages,
>> for trigger and management), than one having to look at
>> what is inside "a box" called xive_source_esb_len().
>>
>> Wrapping it under another function doesn't help more when
>> reading the code, XIVE is already tricky enough :)
>>
> 
> Heh, XIVE is tricky enough that only a few people will dare
> to touch this code and they'd better already know about the
> one IRQ per ESB page thingy ;-)

Yea, maybe someday we get a cool documentation on it.

Luckily I came after Benh and Cédric and took some good info from
OPAL and QEMU code. I found out recently that XIVE support was
merged into FreeBSD and with that it also came some good comments
about xive...


> More seriously, this is a matter of taste, but since you're likely
> to be involved in XIVE a bit more than me, I'm perfectly fine with
> keeping this open-coded.

Thanks, Greg.

Hope there is still some time to enjoy the summer over there :)


Cheers,
Gustavo

