Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 259CBC54E8D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 14:48:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1C51206A5
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 14:48:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1C51206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYWDK-00013y-7F
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 10:48:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58550)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1jYWBD-0007lo-Sm; Tue, 12 May 2020 10:46:47 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47428
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1jYWBC-0004ef-OS; Tue, 12 May 2020 10:46:47 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 04CEcYeE105160; Tue, 12 May 2020 10:46:44 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 30wry1nfq4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 May 2020 10:46:44 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 04CEcuZ0107416;
 Tue, 12 May 2020 10:46:44 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com
 [169.63.214.131])
 by mx0a-001b2d01.pphosted.com with ESMTP id 30wry1nfpm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 May 2020 10:46:44 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
 by ppma01dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 04CEjOLH015208;
 Tue, 12 May 2020 14:46:43 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com
 [9.57.198.28]) by ppma01dal.us.ibm.com with ESMTP id 30wm56gj15-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 May 2020 14:46:43 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com
 [9.57.199.111])
 by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 04CEkgdL43254160
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 12 May 2020 14:46:42 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9470BAC05E;
 Tue, 12 May 2020 14:46:42 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5D168AC059;
 Tue, 12 May 2020 14:46:42 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.150.178])
 by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTPS;
 Tue, 12 May 2020 14:46:42 +0000 (GMT)
Subject: Re: [PATCH v1 4/8] s390/sclp: read sccb from mem based on sccb length
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
References: <20200508230823.22956-1-walling@linux.ibm.com>
 <20200508230823.22956-5-walling@linux.ibm.com>
 <4ac10eaf-510b-c84a-e20f-caa4a6f49d36@redhat.com>
From: Collin Walling <walling@linux.ibm.com>
Message-ID: <ce9b8adb-cd62-6730-2f56-61706ac868e0@linux.ibm.com>
Date: Tue, 12 May 2020 10:46:42 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <4ac10eaf-510b-c84a-e20f-caa4a6f49d36@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.676
 definitions=2020-05-12_04:2020-05-11,
 2020-05-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0
 priorityscore=1501 mlxscore=0 clxscore=1015 lowpriorityscore=0 spamscore=0
 suspectscore=0 mlxlogscore=999 malwarescore=0 impostorscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005120110
Received-SPF: pass client-ip=148.163.158.5; envelope-from=walling@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/12 10:46:45
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, KHOP_DYNAMIC=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: frankja@linux.ibm.com, mst@redhat.com, cohuck@redhat.com,
 pasic@linux.ibm.com, borntraeger@de.ibm.com, svens@linux.ibm.com,
 pbonzini@redhat.com, mihajlov@linux.ibm.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/12/20 3:26 AM, David Hildenbrand wrote:
> On 09.05.20 01:08, Collin Walling wrote:
>> The header of the SCCB contains the actual length of the
>> SCCB. Instead of using a static 4K size, let's allow
>> for a variable size determined by the value set in the
>> header. The proper checks are already in place to ensure
>> the SCCB length is sufficent to store a full response,
>> and that the length does not cross any explicitly-set
>> boundaries.
>>
>> Signed-off-by: Collin Walling <walling@linux.ibm.com>
>> ---
>>   hw/s390x/sclp.c | 12 +++++++-----
>>   1 file changed, 7 insertions(+), 5 deletions(-)
>>
>> diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
>> index 470d5da7a2..748d04a0e2 100644
>> --- a/hw/s390x/sclp.c
>> +++ b/hw/s390x/sclp.c
>> @@ -244,15 +244,16 @@ int sclp_service_call_protected(CPUS390XState *env, uint64_t sccb,
>>       SCLPDevice *sclp = get_sclp_device();
>>       SCLPDeviceClass *sclp_c = SCLP_GET_CLASS(sclp);
>>       SCCB work_sccb;
>> -    hwaddr sccb_len = sizeof(SCCB);
>>   
>> -    s390_cpu_pv_mem_read(env_archcpu(env), 0, &work_sccb, sccb_len);
>> +    s390_cpu_pv_mem_read(env_archcpu(env), 0, &work_sccb, sizeof(SCCBHeader));
>>   
>>       if (!sclp_command_code_valid(code)) {
>>           work_sccb.h.response_code = cpu_to_be16(SCLP_RC_INVALID_SCLP_COMMAND);
>>           goto out_write;
>>       }
>>   
>> +    s390_cpu_pv_mem_read(env_archcpu(env), 0, &work_sccb, work_sccb.h.length);
> 
> be16_to_cpu() necessary.
> 
>> +
>>       if (!check_sccb_boundary_valid(sccb, code, &work_sccb)) {
>>           goto out_write;
>>       }
>> @@ -271,8 +272,6 @@ int sclp_service_call(CPUS390XState *env, uint64_t sccb, uint32_t code)
>>       SCLPDeviceClass *sclp_c = SCLP_GET_CLASS(sclp);
>>       SCCB work_sccb;
>>   
>> -    hwaddr sccb_len = sizeof(SCCB);
>> -
>>       /* first some basic checks on program checks */
>>       if (env->psw.mask & PSW_MASK_PSTATE) {
>>           return -PGM_PRIVILEGED;
>> @@ -290,13 +289,16 @@ int sclp_service_call(CPUS390XState *env, uint64_t sccb, uint32_t code)
>>        * from playing dirty tricks by modifying the memory content after
>>        * the host has checked the values
>>        */
>> -    cpu_physical_memory_read(sccb, &work_sccb, sccb_len);
>> +    cpu_physical_memory_read(sccb, &work_sccb, sizeof(SCCBHeader));
>>   
>>       /* Valid sccb sizes */
>>       if (be16_to_cpu(work_sccb.h.length) < sizeof(SCCBHeader)) {
>>           return -PGM_SPECIFICATION;
>>       }
>>   
>> +    /* the header contains the actual length of the sccb */
>> +    cpu_physical_memory_read(sccb, &work_sccb, work_sccb.h.length);
> 
> be16_to_cpu() necessary.
> 
>> +
>>       if (!sclp_command_code_valid(code)) {
>>           work_sccb.h.response_code = cpu_to_be16(SCLP_RC_INVALID_SCLP_COMMAND);
>>           goto out_write;
>>
> 

Thanks. Fixed up.

-- 
--
Regards,
Collin

Stay safe and stay healthy

