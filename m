Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E84EBC10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 15:27:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3ABA20724
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 15:27:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PH6bR2ur"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3ABA20724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32818 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCmDa-0002os-UZ
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 11:27:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55569)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liran.alon@oracle.com>) id 1jCmCx-0002Hq-Tt
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 11:26:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liran.alon@oracle.com>) id 1jCmCw-0000tb-R8
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 11:26:43 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:49564)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <liran.alon@oracle.com>)
 id 1jCmCw-0000oE-HZ
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 11:26:42 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02DF9VEp161024;
 Fri, 13 Mar 2020 15:26:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=GGmIIhC6iMKv8343nBeVYmehY38mwjFZVR+tm7vY6TE=;
 b=PH6bR2urXpkTgo/Dwd7INERq3R0ludeO/my0gxj43HuLahr5Xm5+FYaaVZ9kvxjOh5Wu
 9l4tofReuqbQ8u0VNDjpT/GWhgm3Hz6b4fF3iR3ToUMO3+X1g4WkDW34UMTqSpUihxWM
 4sR6qKmnM3wFLkajpDY7xG1HK3z6ML8MW18NORLR6vHbaZA7FbVjT3MWxM/JGMiEMowv
 OjuVfVmRUC4JqR169w7jIb4DxN6uU0HZHRNTrc7u/VmE6MH0Li9v6t70Q7XSn+xQ9Vkc
 CTV8DPwvneqJ7BEOfM5/sMFKpjvc71eWc8mfeA8czR7l/CwTKEqtmrKbqz9LtwOQRWbn 6g== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2120.oracle.com with ESMTP id 2yqtavmddh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 Mar 2020 15:26:39 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02DFJSr0108241;
 Fri, 13 Mar 2020 15:26:38 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by aserp3020.oracle.com with ESMTP id 2yqtaw5rbt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 Mar 2020 15:26:38 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 02DFQbiG010486;
 Fri, 13 Mar 2020 15:26:37 GMT
Received: from Lirans-MacBook-Pro.local (/10.74.124.83)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Fri, 13 Mar 2020 08:26:36 -0700
Subject: Re: [PATCH v3 11/16] hw/i386/vmport: Add support for CMD_GETTIMEFULL
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20200312165431.82118-1-liran.alon@oracle.com>
 <20200312165431.82118-12-liran.alon@oracle.com>
 <20200312200518-mutt-send-email-mst@kernel.org>
From: Liran Alon <liran.alon@oracle.com>
Message-ID: <d385a669-036a-40f7-88f0-7fa9d83fe6a1@oracle.com>
Date: Fri, 13 Mar 2020 17:26:32 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200312200518-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9558
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 bulkscore=0 phishscore=0
 suspectscore=0 mlxscore=0 spamscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003130080
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9558
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 suspectscore=0
 phishscore=0 priorityscore=1501 clxscore=1015 mlxscore=0 adultscore=0
 spamscore=0 bulkscore=0 mlxlogscore=999 lowpriorityscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003130080
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 156.151.31.85
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
Cc: ehabkost@redhat.com, qemu-devel@nongnu.org,
 Nikita Leshenko <nikita.leshchenko@oracle.com>, pbonzini@redhat.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 13/03/2020 2:06, Michael S. Tsirkin wrote:
> On Thu, Mar 12, 2020 at 06:54:26PM +0200, Liran Alon wrote:
>> Similar to CMD_GETTIME but lacks the 136-year overflow issue,
>> by returning full 64-bit of host uSeconds.
>>
>> Reviewed-by: Nikita Leshenko <nikita.leshchenko@oracle.com>
>> Signed-off-by: Liran Alon <liran.alon@oracle.com>
>> ---
>>   hw/i386/vmport.c         | 17 +++++++++++++++++
>>   include/hw/i386/vmport.h |  1 +
>>   2 files changed, 18 insertions(+)
>>
>> diff --git a/hw/i386/vmport.c b/hw/i386/vmport.c
>> index c5b659c59343..7e57eda4b526 100644
>> --- a/hw/i386/vmport.c
>> +++ b/hw/i386/vmport.c
>> @@ -183,6 +183,22 @@ static uint32_t vmport_cmd_time(void *opaque, uint32_t addr)
>>       return (uint32_t)tv.tv_sec;
>>   }
>>   
>> +static uint32_t vmport_cmd_time_full(void *opaque, uint32_t addr)
>> +{
>> +    X86CPU *cpu = X86_CPU(current_cpu);
>> +    qemu_timeval tv;
>> +
>> +    if (qemu_gettimeofday(&tv) < 0) {
>> +        return UINT32_MAX;
>> +    }
>> +
>> +    cpu->env.regs[R_ESI] = (uint32_t)((uint64_t)tv.tv_sec >> 32);
>> +    cpu->env.regs[R_EDX] = (uint32_t)tv.tv_sec;
>> +    cpu->env.regs[R_EBX] = (uint32_t)tv.tv_usec;
>> +    cpu->env.regs[R_ECX] = port_state->max_time_lag_us;
>> +    return VMPORT_MAGIC;
>> +}
>> +
>>   /* vmmouse helpers */
>>   void vmmouse_get_data(uint32_t *data)
>>   {
> And with usec precision, same comments apply in an even stronger way.

Please tell me if you still have specific question or comment on this 
after ready my reply to the previous patch.
i.e. Something I should handle regarding this patch on v4.

Thanks,
-Liran



