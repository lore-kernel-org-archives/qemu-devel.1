Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25F0CC33C99
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 11:43:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA4AC2070E
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 11:43:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA4AC2070E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47094 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ionGK-0005Xb-Sl
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 06:43:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41299)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ganeshgr@linux.ibm.com>) id 1ion44-0007Bd-Vs
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 06:30:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ganeshgr@linux.ibm.com>) id 1ion43-00020f-RC
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 06:30:24 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:21628)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ganeshgr@linux.ibm.com>)
 id 1ion43-00020K-Ju
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 06:30:23 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 007BRNpD022475
 for <qemu-devel@nongnu.org>; Tue, 7 Jan 2020 06:30:22 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2xb925byhp-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 06:30:22 -0500
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <ganeshgr@linux.ibm.com>;
 Tue, 7 Jan 2020 11:30:19 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
 by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 7 Jan 2020 11:30:15 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
 [9.149.105.59])
 by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 007BTRfX45023534
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 7 Jan 2020 11:29:27 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 89CACA404D;
 Tue,  7 Jan 2020 11:30:14 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2641AA4055;
 Tue,  7 Jan 2020 11:30:13 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.35.97])
 by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Tue,  7 Jan 2020 11:30:12 +0000 (GMT)
Subject: Re: [PATCH v18 1/7] Wrapper function to wait on condition for the
 main loop mutex
To: Greg Kurz <groug@kaod.org>
References: <20200102075111.25308-1-ganeshgr@linux.ibm.com>
 <20200102075111.25308-2-ganeshgr@linux.ibm.com>
 <20200105161708.6d4711b1@bahia.lan>
From: Ganesh <ganeshgr@linux.ibm.com>
Date: Tue, 7 Jan 2020 17:00:12 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20200105161708.6d4711b1@bahia.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 20010711-0028-0000-0000-000003CEE356
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20010711-0029-0000-0000-00002492F2CC
Message-Id: <b69d4346-4705-8e84-4b1f-2cad0f7fede3@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2020-01-07_03:2020-01-06,2020-01-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0
 malwarescore=0 bulkscore=0 adultscore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001070094
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
Cc: Aravinda Prasad <arawinda.p@gmail.com>, aik@ozlabs.ru,
 qemu-devel@nongnu.org, paulus@ozlabs.org, qemu-ppc@nongnu.org,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 1/5/20 8:47 PM, Greg Kurz wrote:
> On Thu,  2 Jan 2020 13:21:05 +0530
> Ganesh Goudar <ganeshgr@linux.ibm.com> wrote:
>
>> From: Aravinda Prasad <arawinda.p@gmail.com>
>>
>> Introduce a wrapper function to wait on condition for
>> the main loop mutex. This function atomically releases
>> the main loop mutex and causes the calling thread to
>> block on the condition. This wrapper is required because
>> qemu_global_mutex is a static variable.
>>
>> Signed-off-by: Aravinda Prasad <arawinda.p@gmail.com>
>> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
>> Reviewed-by: Greg Kurz <groug@kaod.org>
>> ---
> This should have your Signed-off-by: tag as well.
Sure, thanks
>
>>   cpus.c                   | 5 +++++
>>   include/qemu/main-loop.h | 8 ++++++++
>>   2 files changed, 13 insertions(+)
>>
>> diff --git a/cpus.c b/cpus.c
>> index b472378b70..79388d2b0f 100644
>> --- a/cpus.c
>> +++ b/cpus.c
>> @@ -1835,6 +1835,11 @@ void qemu_mutex_unlock_iothread(void)
>>       qemu_mutex_unlock(&qemu_global_mutex);
>>   }
>>   
>> +void qemu_cond_wait_iothread(QemuCond *cond)
>> +{
>> +    qemu_cond_wait(cond, &qemu_global_mutex);
>> +}
>> +
>>   static bool all_vcpus_paused(void)
>>   {
>>       CPUState *cpu;
>> diff --git a/include/qemu/main-loop.h b/include/qemu/main-loop.h
>> index f6ba78ea73..a6d20b0719 100644
>> --- a/include/qemu/main-loop.h
>> +++ b/include/qemu/main-loop.h
>> @@ -295,6 +295,14 @@ void qemu_mutex_lock_iothread_impl(const char *file, int line);
>>    */
>>   void qemu_mutex_unlock_iothread(void);
>>   
>> +/*
>> + * qemu_cond_wait_iothread: Wait on condition for the main loop mutex
>> + *
>> + * This function atomically releases the main loop mutex and causes
>> + * the calling thread to block on the condition.
>> + */
>> +void qemu_cond_wait_iothread(QemuCond *cond);
>> +
>>   /* internal interfaces */
>>   
>>   void qemu_fd_register(int fd);


