Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8334AC433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 14:51:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF227206E6
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 14:51:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dPDb748o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF227206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51822 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGkOf-00009Z-O2
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 10:51:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32772)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1kGkNe-00082d-5E; Fri, 11 Sep 2020 10:50:26 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:29290
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1kGkNc-0007f0-AG; Fri, 11 Sep 2020 10:50:25 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 08BEW4SY072102; Fri, 11 Sep 2020 10:50:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=VXgTPCVDYfZjL6guewGad0aGtfcebHKdJP0Jn+BO6fs=;
 b=dPDb748oTG/RKKGWCli38vp/f0s6K/wLq7/aPVcaJCC3Xrbfisu0cSJkAVmz85AG4W+k
 +JZsAUPVKF9U/QywJUG2IeWsHb1sFZvvGUPMb3bZU4Lyt7S8CByYki/V/Gchkg77EIxy
 JSK3AxZjxPTg7zxtyAXlFbJlVtT7CawtSrmyhfke+iWaFeXJTuI+w9iEzIAZhlN5KpsZ
 gYef3emOQ0ZJpfvCbiW+EauQO6v7ZkUBItnka8Qy0osjEpxEbqwQqxHzW78HqENzHWdI
 gc+b+Db8L9PDwxuqZHVzaegPWErjD4PuhpbnNpv5Ss2Hdl/jU9HyHlDyORrCafb8JZWk 8Q== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 33gabr26na-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 11 Sep 2020 10:50:21 -0400
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08BEenuI106327;
 Fri, 11 Sep 2020 10:50:21 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com
 [169.53.41.122])
 by mx0b-001b2d01.pphosted.com with ESMTP id 33gabr26n0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 11 Sep 2020 10:50:21 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
 by ppma04dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08BEmFWL008823;
 Fri, 11 Sep 2020 14:50:20 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26]) by ppma04dal.us.ibm.com with ESMTP id 33c2aa4p9x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 11 Sep 2020 14:50:20 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com
 [9.57.199.106])
 by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 08BEoJPl15205102
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 11 Sep 2020 14:50:19 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8F15A28064;
 Fri, 11 Sep 2020 14:50:19 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4C3D02805E;
 Fri, 11 Sep 2020 14:50:19 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.172.6])
 by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTPS;
 Fri, 11 Sep 2020 14:50:19 +0000 (GMT)
Subject: Re: [PATCH v5 2/8] s390/sclp: rework sclp boundary checks
To: Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>
References: <20200910093655.255774-1-walling@linux.ibm.com>
 <20200910093655.255774-3-walling@linux.ibm.com>
 <4c495858-c7aa-2e12-ef2b-26952019e8ef@redhat.com>
 <20200911122424.582340f4.cohuck@redhat.com>
From: Collin Walling <walling@linux.ibm.com>
Message-ID: <f17e44a5-4ec8-0433-ab36-368e3e7839a7@linux.ibm.com>
Date: Fri, 11 Sep 2020 10:50:19 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200911122424.582340f4.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-09-11_05:2020-09-10,
 2020-09-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 phishscore=0 impostorscore=0 bulkscore=0
 priorityscore=1501 adultscore=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009110114
Received-SPF: pass client-ip=148.163.158.5; envelope-from=walling@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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
Cc: frankja@linux.ibm.com, david@redhat.com, mst@redhat.com,
 qemu-devel@nongnu.org, pasic@linux.ibm.com, borntraeger@de.ibm.com,
 qemu-s390x@nongnu.org, pbonzini@redhat.com, sumanthk@linux.ibm.com,
 mihajlov@linux.ibm.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/11/20 6:24 AM, Cornelia Huck wrote:
> On Thu, 10 Sep 2020 19:45:01 +0200
> Thomas Huth <thuth@redhat.com> wrote:
> 
>> On 10/09/2020 11.36, Collin Walling wrote:
>>> Rework the SCLP boundary check to account for different SCLP commands
>>> (eventually) allowing different boundary sizes.
>>>
>>> Signed-off-by: Collin Walling <walling@linux.ibm.com>
>>> Acked-by: Janosch Frank <frankja@linux.ibm.com>
>>> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
>>> ---
>>>  hw/s390x/sclp.c | 19 ++++++++++++++++++-
>>>  1 file changed, 18 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
>>> index 28b973de8f..69a8724dc7 100644
>>> --- a/hw/s390x/sclp.c
>>> +++ b/hw/s390x/sclp.c
>>> @@ -49,6 +49,18 @@ static inline bool sclp_command_code_valid(uint32_t code)
>>>      return false;
>>>  }
>>>  
>>> +static bool sccb_verify_boundary(uint64_t sccb_addr, uint16_t len)  
>>
>> Maybe it would be good to add a comment in front of the function to say
>> that len must be big endian?
> 
> What about renaming it to sccb_h_len or so? That would make it more
> clear that the parameter is not just some random length.
> 

I think that makes sense.

>>
>>  Thomas
>>
>>> +{
>>> +    uint64_t sccb_max_addr = sccb_addr + be16_to_cpu(len) - 1;
>>> +    uint64_t sccb_boundary = (sccb_addr & PAGE_MASK) + PAGE_SIZE;
>>> +
>>> +    if (sccb_max_addr < sccb_boundary) {
>>> +        return true;
>>> +    }
>>> +
>>> +    return false;
>>> +}
>>> +
>>>  static void prepare_cpu_entries(MachineState *ms, CPUEntry *entry, int *count)
>>>  {
>>>      uint8_t features[SCCB_CPU_FEATURE_LEN] = { 0 };
>>> @@ -229,6 +241,11 @@ int sclp_service_call_protected(CPUS390XState *env, uint64_t sccb,
>>>          goto out_write;
>>>      }
>>>  
>>> +    if (!sccb_verify_boundary(sccb, work_sccb.h.length)) {
> 
> ...name inspired by the 'h' in here.
> 
>>> +        work_sccb.h.response_code = cpu_to_be16(SCLP_RC_SCCB_BOUNDARY_VIOLATION);
>>> +        goto out_write;
>>> +    }
>>> +
>>>      sclp_c->execute(sclp, &work_sccb, code);
>>>  out_write:
>>>      s390_cpu_pv_mem_write(env_archcpu(env), 0, &work_sccb,
>>> @@ -274,7 +291,7 @@ int sclp_service_call(CPUS390XState *env, uint64_t sccb, uint32_t code)
>>>          goto out_write;
>>>      }
>>>  
>>> -    if ((sccb + be16_to_cpu(work_sccb.h.length)) > ((sccb & PAGE_MASK) + PAGE_SIZE)) {
>>> +    if (!sccb_verify_boundary(sccb, work_sccb.h.length)) {
>>>          work_sccb.h.response_code = cpu_to_be16(SCLP_RC_SCCB_BOUNDARY_VIOLATION);
>>>          goto out_write;
>>>      }
>>>   
>>
> 
> 


-- 
Regards,
Collin

Stay safe and stay healthy

