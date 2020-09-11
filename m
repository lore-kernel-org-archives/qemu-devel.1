Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 669D1C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 18:17:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7419208E4
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 18:17:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MnZh28Sy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7419208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35536 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGnbv-0005GN-Gc
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 14:17:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55818)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1kGnb8-0004PL-5Y; Fri, 11 Sep 2020 14:16:34 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:30928)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1kGnb6-0007Gn-3U; Fri, 11 Sep 2020 14:16:33 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 08BI2NG6143185; Fri, 11 Sep 2020 14:16:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=subject : from : to : cc
 : references : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=LwvA878EJyMxvECZnj5gGhCCLzZI2w2UpLcVKBb5uQY=;
 b=MnZh28Syve+152MnnaGqJNF1BCNXM29dcWizN9LPhKUJfJv4IBr/JghBot072v1Jp5ha
 UBDeErPiyfyh5AcZ957fcArzXVBo4FnbMlgDNYrIYEI6L+P8Ao5l3tBDdGJwmzhZGP+L
 YJeC1uUCsKs/hVa0w5iZiivgPwvSns5d4zgDf+7wH1RDiXZLzno7lRUOCsAxB6/TWlkK
 3R0M7cseJfDRZWW2qjczQpovE3a1JiIqQqs6+Dp9MSDgUsIgtqpv0MC9X2wm4HiNBfun
 tWwT4F58kfvAh8klXK0DUregSGkSzSvE2YBt2BAY5EWBapr3CM+BM63gHjbn0YkNKMgT RQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 33ge380g9d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 11 Sep 2020 14:16:30 -0400
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08BI2eEf143847;
 Fri, 11 Sep 2020 14:16:30 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com
 [169.63.214.131])
 by mx0a-001b2d01.pphosted.com with ESMTP id 33ge380g94-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 11 Sep 2020 14:16:29 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
 by ppma01dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08BIBxJI023790;
 Fri, 11 Sep 2020 18:16:29 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26]) by ppma01dal.us.ibm.com with ESMTP id 33d46ngx63-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 11 Sep 2020 18:16:29 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com
 [9.57.199.106])
 by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 08BIGSrB15008316
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 11 Sep 2020 18:16:28 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4AD7B2805A;
 Fri, 11 Sep 2020 18:16:28 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E9AC62805C;
 Fri, 11 Sep 2020 18:16:27 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.172.6])
 by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTPS;
 Fri, 11 Sep 2020 18:16:27 +0000 (GMT)
Subject: Re: [PATCH v5 3/8] s390/sclp: read sccb from mem based on provided
 length
From: Collin Walling <walling@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
References: <20200910093655.255774-1-walling@linux.ibm.com>
 <20200910093655.255774-4-walling@linux.ibm.com>
 <02dabe89-8df2-90d4-c7f1-5ef951942639@redhat.com>
 <811e906a-689e-a53c-706e-5d6217ef3cb2@linux.ibm.com>
Message-ID: <2b7a8807-279f-1256-e89b-0f53ae6d5623@linux.ibm.com>
Date: Fri, 11 Sep 2020 14:16:27 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <811e906a-689e-a53c-706e-5d6217ef3cb2@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-09-11_08:2020-09-10,
 2020-09-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0
 mlxscore=0 mlxlogscore=999 priorityscore=1501 malwarescore=0 phishscore=0
 spamscore=0 suspectscore=2 clxscore=1015 bulkscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009110142
Received-SPF: pass client-ip=148.163.158.5; envelope-from=walling@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/11 09:50:13
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.469,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: frankja@linux.ibm.com, david@redhat.com, cohuck@redhat.com,
 pasic@linux.ibm.com, borntraeger@de.ibm.com, mst@redhat.com,
 pbonzini@redhat.com, sumanthk@linux.ibm.com, mihajlov@linux.ibm.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/10/20 1:56 PM, Collin Walling wrote:
> On 9/10/20 1:50 PM, Thomas Huth wrote:
>> On 10/09/2020 11.36, Collin Walling wrote:
>>> The header contained within the SCCB passed to the SCLP service call
>>> contains the actual length of the SCCB. Instead of allocating a static
>>> 4K size for the work sccb, let's allow for a variable size determined
>>> by the value in the header. The proper checks are already in place to
>>> ensure the SCCB length is sufficent to store a full response and that
>>> the length does not cross any explicitly-set boundaries.
>>>
>>> Signed-off-by: Collin Walling <walling@linux.ibm.com>
>>> ---
>>>  hw/s390x/event-facility.c |  2 +-
>>>  hw/s390x/sclp.c           | 58 ++++++++++++++++++++++-----------------
>>>  include/hw/s390x/sclp.h   |  2 +-
>>>  3 files changed, 35 insertions(+), 27 deletions(-)
>>>
>>> diff --git a/hw/s390x/event-facility.c b/hw/s390x/event-facility.c
>>> index 645b4080c5..ed92ce510d 100644
>>> --- a/hw/s390x/event-facility.c
>>> +++ b/hw/s390x/event-facility.c
>>> @@ -213,7 +213,7 @@ static uint16_t handle_sccb_read_events(SCLPEventFacility *ef, SCCB *sccb,
>>>  
>>>      event_buf = &red->ebh;
>>>      event_buf->length = 0;
>>> -    slen = sizeof(sccb->data);
>>> +    slen = sccb_data_len(sccb);
>>>  
>>>      rc = SCLP_RC_NO_EVENT_BUFFERS_STORED;
>>>  
>>> diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
>>> index 69a8724dc7..cb8e2e8ec3 100644
>>> --- a/hw/s390x/sclp.c
>>> +++ b/hw/s390x/sclp.c
>>> @@ -231,25 +231,30 @@ int sclp_service_call_protected(CPUS390XState *env, uint64_t sccb,
>>>  {
>>>      SCLPDevice *sclp = get_sclp_device();
>>>      SCLPDeviceClass *sclp_c = SCLP_GET_CLASS(sclp);
>>> -    SCCB work_sccb;
>>> -    hwaddr sccb_len = sizeof(SCCB);
>>> +    SCCBHeader header;
>>> +    SCCB *work_sccb;
>>
>> I'd maybe use "g_autofree SCCB *work_sccb = NULL" so you don't have to
>> worry about doing the g_free() later.
> 
> Can do.
> 
>>
>>> -    s390_cpu_pv_mem_read(env_archcpu(env), 0, &work_sccb, sccb_len);
>>> +    s390_cpu_pv_mem_read(env_archcpu(env), 0, &header, sizeof(SCCBHeader));
>>> +
>>> +    work_sccb = g_malloc0(header.length);
>>
>> Please use be16_to_cpu(header.length) here as well.
> 
> Good catch, thanks!
> 

Shouldn't the mallocs use cpu_to_be16 instead since the header length
was read in from a cpu?

[...]

-- 
Regards,
Collin

Stay safe and stay healthy

