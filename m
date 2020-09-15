Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C922C43461
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 14:28:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AE4B23CD1
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 14:28:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tB+x0eXT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AE4B23CD1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIBwv-0002Ho-55
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 10:28:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57044)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1kIBvl-0001V6-8Z; Tue, 15 Sep 2020 10:27:37 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:64514)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1kIBvh-0001ia-H1; Tue, 15 Sep 2020 10:27:36 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 08FEAdUO023467; Tue, 15 Sep 2020 10:27:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=zY6d35Gi/VG4gzgnpgX6nRbsNSc8iEM35JzEXoTuUeo=;
 b=tB+x0eXT024yJlO6qE1fiM8/5pMDIu/0dAR9eV8bWmvaMYUyyn+Of5gmVugCnTJvW+Y0
 /ImK2B8S+FJN6wbzE8M4HZNov/mWGwExhz+Swj8dbsbqrB7YHoB8cDES5fcBHcahE/cP
 62qxEyBSXgH8O24JPn9i16HRJzmgPddoF4bAy2UOXaF/nOkDa3SEYr0+Lfe9EYgWJVHH
 IZsWONnSMSztpl2J5Z5mBtooASGxcj8jwM89NCAa2pus6QCWCIx51c4CrUTrr5KTd5II
 ulvtYFMuzhFZ0vbVQ5VOVp21i3qbgIUpM35/TrmKJ054I2ManQgLXKNeeRUjL2fmMREZ og== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 33jy110y30-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Sep 2020 10:27:30 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08FEAgSw023822;
 Tue, 15 Sep 2020 10:27:29 -0400
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com
 [169.63.121.186])
 by mx0a-001b2d01.pphosted.com with ESMTP id 33jy110y28-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Sep 2020 10:27:29 -0400
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
 by ppma03wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08FERSDB022633;
 Tue, 15 Sep 2020 14:27:28 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com
 [9.57.198.23]) by ppma03wdc.us.ibm.com with ESMTP id 33gny8qyvh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Sep 2020 14:27:28 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com
 [9.57.199.107])
 by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 08FERSaP50856262
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 15 Sep 2020 14:27:28 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EAC50124053;
 Tue, 15 Sep 2020 14:27:27 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AE7BC124060;
 Tue, 15 Sep 2020 14:27:27 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.140.9])
 by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTPS;
 Tue, 15 Sep 2020 14:27:27 +0000 (GMT)
Subject: Re: [PATCH v5 3/8] s390/sclp: read sccb from mem based on provided
 length
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
References: <20200910093655.255774-1-walling@linux.ibm.com>
 <20200910093655.255774-4-walling@linux.ibm.com>
 <02dabe89-8df2-90d4-c7f1-5ef951942639@redhat.com>
 <811e906a-689e-a53c-706e-5d6217ef3cb2@linux.ibm.com>
 <2b7a8807-279f-1256-e89b-0f53ae6d5623@linux.ibm.com>
 <d7989721-f9cb-6f77-6d52-08ce69c6dda5@redhat.com>
From: Collin Walling <walling@linux.ibm.com>
Message-ID: <41de4933-0d80-05a4-4b93-9558e4ed70aa@linux.ibm.com>
Date: Tue, 15 Sep 2020 10:27:27 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <d7989721-f9cb-6f77-6d52-08ce69c6dda5@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-09-15_08:2020-09-15,
 2020-09-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 malwarescore=0 suspectscore=2 mlxlogscore=999 mlxscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009150114
Received-SPF: pass client-ip=148.163.156.1; envelope-from=walling@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/15 09:39:26
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.001,
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
Cc: frankja@linux.ibm.com, mst@redhat.com, cohuck@redhat.com, david@redhat.com,
 pasic@linux.ibm.com, borntraeger@de.ibm.com, pbonzini@redhat.com,
 sumanthk@linux.ibm.com, mihajlov@linux.ibm.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/12/20 2:28 AM, Thomas Huth wrote:
> On 11/09/2020 20.16, Collin Walling wrote:
>> On 9/10/20 1:56 PM, Collin Walling wrote:
>>> On 9/10/20 1:50 PM, Thomas Huth wrote:
>>>> On 10/09/2020 11.36, Collin Walling wrote:
>>>>> The header contained within the SCCB passed to the SCLP service call
>>>>> contains the actual length of the SCCB. Instead of allocating a static
>>>>> 4K size for the work sccb, let's allow for a variable size determined
>>>>> by the value in the header. The proper checks are already in place to
>>>>> ensure the SCCB length is sufficent to store a full response and that
>>>>> the length does not cross any explicitly-set boundaries.
>>>>>
>>>>> Signed-off-by: Collin Walling <walling@linux.ibm.com>
>>>>> ---
>>>>>  hw/s390x/event-facility.c |  2 +-
>>>>>  hw/s390x/sclp.c           | 58 ++++++++++++++++++++++-----------------
>>>>>  include/hw/s390x/sclp.h   |  2 +-
>>>>>  3 files changed, 35 insertions(+), 27 deletions(-)
>>>>>
>>>>> diff --git a/hw/s390x/event-facility.c b/hw/s390x/event-facility.c
>>>>> index 645b4080c5..ed92ce510d 100644
>>>>> --- a/hw/s390x/event-facility.c
>>>>> +++ b/hw/s390x/event-facility.c
>>>>> @@ -213,7 +213,7 @@ static uint16_t handle_sccb_read_events(SCLPEventFacility *ef, SCCB *sccb,
>>>>>  
>>>>>      event_buf = &red->ebh;
>>>>>      event_buf->length = 0;
>>>>> -    slen = sizeof(sccb->data);
>>>>> +    slen = sccb_data_len(sccb);
>>>>>  
>>>>>      rc = SCLP_RC_NO_EVENT_BUFFERS_STORED;
>>>>>  
>>>>> diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
>>>>> index 69a8724dc7..cb8e2e8ec3 100644
>>>>> --- a/hw/s390x/sclp.c
>>>>> +++ b/hw/s390x/sclp.c
>>>>> @@ -231,25 +231,30 @@ int sclp_service_call_protected(CPUS390XState *env, uint64_t sccb,
>>>>>  {
>>>>>      SCLPDevice *sclp = get_sclp_device();
>>>>>      SCLPDeviceClass *sclp_c = SCLP_GET_CLASS(sclp);
>>>>> -    SCCB work_sccb;
>>>>> -    hwaddr sccb_len = sizeof(SCCB);
>>>>> +    SCCBHeader header;
>>>>> +    SCCB *work_sccb;
>>>>
>>>> I'd maybe use "g_autofree SCCB *work_sccb = NULL" so you don't have to
>>>> worry about doing the g_free() later.
>>>
>>> Can do.
>>>
>>>>
>>>>> -    s390_cpu_pv_mem_read(env_archcpu(env), 0, &work_sccb, sccb_len);
>>>>> +    s390_cpu_pv_mem_read(env_archcpu(env), 0, &header, sizeof(SCCBHeader));
>>>>> +
>>>>> +    work_sccb = g_malloc0(header.length);
>>>>
>>>> Please use be16_to_cpu(header.length) here as well.
>>>
>>> Good catch, thanks!
>>>
>>
>> Shouldn't the mallocs use cpu_to_be16 instead since the header length
>> was read in from a cpu?
> 
> Now you confuse me ... s390x is big endian, so to get a usable value, we
> have to convert big-endian to the host byte order, not the other way
> round, don't we?
> 
>  Thomas
> 
> 

Err, yes you're right.

-- 
Regards,
Collin

Stay safe and stay healthy

