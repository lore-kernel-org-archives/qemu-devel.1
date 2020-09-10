Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7304C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 17:57:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E4C920C09
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 17:57:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sokU7kz1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E4C920C09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51944 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGQpR-0007sd-Ic
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 13:57:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49524)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1kGQoX-00071t-CL; Thu, 10 Sep 2020 13:56:53 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:15968
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1kGQoV-0006xE-84; Thu, 10 Sep 2020 13:56:52 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 08AHpRtL125353; Thu, 10 Sep 2020 13:56:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=aI2f/gxKVn+KImzNBWHZPxf91hEofhOfR6hYdeo4R/0=;
 b=sokU7kz1WF2QjGux2iyrtns3hienUyQoXfZ5LRjpcI2ZL4aXl8LJEHXSG3mrIta54GVF
 k9LUZytr/EptZ8y6QdUTmvwRgXMOCAoK/M+iV1ZtJFKDHxqS9xchH+YR2xLpEGeAKMvA
 udDhFzF/sEP97VlYbA4V1MgyFfOzg4G+uCiceEDETpyHPPu+FGjHPftEJi398bBqXOBo
 wDDmnm25qvVZVQh02tmwFR0Q71v4jV4lBQP/kgGRaTWkX5U+aTrlfvCsGnHojTtrxBBJ
 QbqyZRojAACT00RNor8NkMFATPkNs/hfFgVdVN3OdORo2PhH9PYikv5IzpzbAA+1BDIb bA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 33frwq83dw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Sep 2020 13:56:49 -0400
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08AHsVXs136361;
 Thu, 10 Sep 2020 13:56:48 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.11])
 by mx0b-001b2d01.pphosted.com with ESMTP id 33frwq83dg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Sep 2020 13:56:48 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
 by ppma03dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08AHqMTO024534;
 Thu, 10 Sep 2020 17:56:48 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com
 [9.57.198.27]) by ppma03dal.us.ibm.com with ESMTP id 33c2a9ky2m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Sep 2020 17:56:48 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com
 [9.57.199.106])
 by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 08AHulXj34013622
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 10 Sep 2020 17:56:47 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4672C28064;
 Thu, 10 Sep 2020 17:56:47 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EF7D628058;
 Thu, 10 Sep 2020 17:56:46 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.172.6])
 by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTPS;
 Thu, 10 Sep 2020 17:56:46 +0000 (GMT)
Subject: Re: [PATCH v5 3/8] s390/sclp: read sccb from mem based on provided
 length
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
References: <20200910093655.255774-1-walling@linux.ibm.com>
 <20200910093655.255774-4-walling@linux.ibm.com>
 <02dabe89-8df2-90d4-c7f1-5ef951942639@redhat.com>
From: Collin Walling <walling@linux.ibm.com>
Message-ID: <811e906a-689e-a53c-706e-5d6217ef3cb2@linux.ibm.com>
Date: Thu, 10 Sep 2020 13:56:46 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <02dabe89-8df2-90d4-c7f1-5ef951942639@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-09-10_05:2020-09-10,
 2020-09-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=2 bulkscore=0
 priorityscore=1501 mlxscore=0 impostorscore=0 adultscore=0 malwarescore=0
 clxscore=1015 phishscore=0 mlxlogscore=893 lowpriorityscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009100158
Received-SPF: pass client-ip=148.163.158.5; envelope-from=walling@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 13:56:49
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
X-Spam_score_int: -62
X-Spam_score: -6.3
X-Spam_bar: ------
X-Spam_report: (-6.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.576,
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

On 9/10/20 1:50 PM, Thomas Huth wrote:
> On 10/09/2020 11.36, Collin Walling wrote:
>> The header contained within the SCCB passed to the SCLP service call
>> contains the actual length of the SCCB. Instead of allocating a static
>> 4K size for the work sccb, let's allow for a variable size determined
>> by the value in the header. The proper checks are already in place to
>> ensure the SCCB length is sufficent to store a full response and that
>> the length does not cross any explicitly-set boundaries.
>>
>> Signed-off-by: Collin Walling <walling@linux.ibm.com>
>> ---
>>  hw/s390x/event-facility.c |  2 +-
>>  hw/s390x/sclp.c           | 58 ++++++++++++++++++++++-----------------
>>  include/hw/s390x/sclp.h   |  2 +-
>>  3 files changed, 35 insertions(+), 27 deletions(-)
>>
>> diff --git a/hw/s390x/event-facility.c b/hw/s390x/event-facility.c
>> index 645b4080c5..ed92ce510d 100644
>> --- a/hw/s390x/event-facility.c
>> +++ b/hw/s390x/event-facility.c
>> @@ -213,7 +213,7 @@ static uint16_t handle_sccb_read_events(SCLPEventFacility *ef, SCCB *sccb,
>>  
>>      event_buf = &red->ebh;
>>      event_buf->length = 0;
>> -    slen = sizeof(sccb->data);
>> +    slen = sccb_data_len(sccb);
>>  
>>      rc = SCLP_RC_NO_EVENT_BUFFERS_STORED;
>>  
>> diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
>> index 69a8724dc7..cb8e2e8ec3 100644
>> --- a/hw/s390x/sclp.c
>> +++ b/hw/s390x/sclp.c
>> @@ -231,25 +231,30 @@ int sclp_service_call_protected(CPUS390XState *env, uint64_t sccb,
>>  {
>>      SCLPDevice *sclp = get_sclp_device();
>>      SCLPDeviceClass *sclp_c = SCLP_GET_CLASS(sclp);
>> -    SCCB work_sccb;
>> -    hwaddr sccb_len = sizeof(SCCB);
>> +    SCCBHeader header;
>> +    SCCB *work_sccb;
> 
> I'd maybe use "g_autofree SCCB *work_sccb = NULL" so you don't have to
> worry about doing the g_free() later.

Can do.

> 
>> -    s390_cpu_pv_mem_read(env_archcpu(env), 0, &work_sccb, sccb_len);
>> +    s390_cpu_pv_mem_read(env_archcpu(env), 0, &header, sizeof(SCCBHeader));
>> +
>> +    work_sccb = g_malloc0(header.length);
> 
> Please use be16_to_cpu(header.length) here as well.

Good catch, thanks!

> 
>> +    s390_cpu_pv_mem_read(env_archcpu(env), 0, work_sccb,
>> +                         be16_to_cpu(header.length));
>>  
>>      if (!sclp_command_code_valid(code)) {
>> -        work_sccb.h.response_code = cpu_to_be16(SCLP_RC_INVALID_SCLP_COMMAND);
>> +        work_sccb->h.response_code = cpu_to_be16(SCLP_RC_INVALID_SCLP_COMMAND);
>>          goto out_write;
>>      }
>>  
>> -    if (!sccb_verify_boundary(sccb, work_sccb.h.length)) {
>> -        work_sccb.h.response_code = cpu_to_be16(SCLP_RC_SCCB_BOUNDARY_VIOLATION);
>> +    if (!sccb_verify_boundary(sccb, work_sccb->h.length)) {
>> +        work_sccb->h.response_code = cpu_to_be16(SCLP_RC_SCCB_BOUNDARY_VIOLATION);
>>          goto out_write;
>>      }
>>  
>> -    sclp_c->execute(sclp, &work_sccb, code);
>> +    sclp_c->execute(sclp, work_sccb, code);
>>  out_write:
>> -    s390_cpu_pv_mem_write(env_archcpu(env), 0, &work_sccb,
>> -                          be16_to_cpu(work_sccb.h.length));
>> +    s390_cpu_pv_mem_write(env_archcpu(env), 0, work_sccb,
>> +                          be16_to_cpu(work_sccb->h.length));
>> +    g_free(work_sccb);
>>      sclp_c->service_interrupt(sclp, SCLP_PV_DUMMY_ADDR);
>>      return 0;
>>  }
>> @@ -258,9 +263,8 @@ int sclp_service_call(CPUS390XState *env, uint64_t sccb, uint32_t code)
>>  {
>>      SCLPDevice *sclp = get_sclp_device();
>>      SCLPDeviceClass *sclp_c = SCLP_GET_CLASS(sclp);
>> -    SCCB work_sccb;
>> -
>> -    hwaddr sccb_len = sizeof(SCCB);
>> +    SCCBHeader header;
>> +    SCCB *work_sccb;
> 
> Maybe g_autofree again?
> 
>>      /* first some basic checks on program checks */
>>      if (env->psw.mask & PSW_MASK_PSTATE) {
>> @@ -274,33 +278,37 @@ int sclp_service_call(CPUS390XState *env, uint64_t sccb, uint32_t code)
>>          return -PGM_SPECIFICATION;
>>      }
>>  
>> +    /* the header contains the actual length of the sccb */
>> +    cpu_physical_memory_read(sccb, &header, sizeof(SCCBHeader));
>> +
>> +    /* Valid sccb sizes */
>> +    if (be16_to_cpu(header.length) < sizeof(SCCBHeader)) {
>> +        return -PGM_SPECIFICATION;
>> +    }
>> +
>>      /*
>>       * we want to work on a private copy of the sccb, to prevent guests
>>       * from playing dirty tricks by modifying the memory content after
>>       * the host has checked the values
>>       */
>> -    cpu_physical_memory_read(sccb, &work_sccb, sccb_len);
>> -
>> -    /* Valid sccb sizes */
>> -    if (be16_to_cpu(work_sccb.h.length) < sizeof(SCCBHeader)) {
>> -        return -PGM_SPECIFICATION;
>> -    }
>> +    work_sccb = g_malloc0(header.length);
> 
> Needs be16_to_cpu again.
> 
>> +    cpu_physical_memory_read(sccb, work_sccb, be16_to_cpu(header.length));
>>  
>>      if (!sclp_command_code_valid(code)) {
>> -        work_sccb.h.response_code = cpu_to_be16(SCLP_RC_INVALID_SCLP_COMMAND);
>> +        work_sccb->h.response_code = cpu_to_be16(SCLP_RC_INVALID_SCLP_COMMAND);
>>          goto out_write;
>>      }
>>  
>> -    if (!sccb_verify_boundary(sccb, work_sccb.h.length)) {
>> -        work_sccb.h.response_code = cpu_to_be16(SCLP_RC_SCCB_BOUNDARY_VIOLATION);
>> +    if (!sccb_verify_boundary(sccb, work_sccb->h.length)) {
>> +        work_sccb->h.response_code = cpu_to_be16(SCLP_RC_SCCB_BOUNDARY_VIOLATION);
>>          goto out_write;
>>      }
>>  
>> -    sclp_c->execute(sclp, &work_sccb, code);
>> +    sclp_c->execute(sclp, work_sccb, code);
>>  out_write:
>> -    cpu_physical_memory_write(sccb, &work_sccb,
>> -                              be16_to_cpu(work_sccb.h.length));
>> -
>> +    cpu_physical_memory_write(sccb, work_sccb,
>> +                              be16_to_cpu(work_sccb->h.length));
>> +    g_free(work_sccb);
>>      sclp_c->service_interrupt(sclp, sccb);
>>  
>>      return 0;
> 
>  Thomas
> 
> 

Thanks, Thomas!

-- 
Regards,
Collin

Stay safe and stay healthy

