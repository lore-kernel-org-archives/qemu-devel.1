Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D660DC10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 10:57:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7301921D7E
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 10:57:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="a+eW5D9+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7301921D7E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57480 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBcZi-0006Ft-EV
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 06:57:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38410)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liran.alon@oracle.com>) id 1jBcW5-0002OC-SI
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 06:53:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liran.alon@oracle.com>) id 1jBcW3-0004Kq-EW
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 06:53:40 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:36094)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <liran.alon@oracle.com>)
 id 1jBcW1-0004FO-Rk
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 06:53:38 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02AArYFd138574;
 Tue, 10 Mar 2020 10:53:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=nTOuR9lZxZbecAxlt1igUX+tzao1VWdt9f3UI4Rko4Y=;
 b=a+eW5D9+hqkLDb3rrBGboCdtMidLT+UKfsEAPLulD4HlBVXeqQywfMWfG9pp+dj4sc39
 QO5e/NOrO+fTin5jrK+wirQHicfij0LViVj4mYv5sHXRifngFqAwrTCjnlYyE67DVPhg
 BN55Dkpx7OsLmMIOSMFLWfR9gVfvujzlPqU8sEk8Rzp0qf1fqOr+a0WOFLXTVXoKHAmk
 DHIq/kuieqXyZShW09N376maj89Lp/EkGTD0F3vp0jWIUZgcmoqeDzGAY16bhOstAZAs
 1D0RmIukaHo5zYgw8qT0GQ+60tzgXqpzfzMGTNA18pOVEhl0C2Q6O82IZK/s6waAvswM Rw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2120.oracle.com with ESMTP id 2yp7hm16cq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Mar 2020 10:53:34 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02AAm7I1012626;
 Tue, 10 Mar 2020 10:53:33 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by aserp3030.oracle.com with ESMTP id 2yp8pqxqr3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Mar 2020 10:53:33 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02AArWc5009675;
 Tue, 10 Mar 2020 10:53:32 GMT
Received: from [192.168.14.112] (/79.181.212.171)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 10 Mar 2020 03:53:32 -0700
Subject: Re: [PATCH 12/14] i386/cpu: Store LAPIC bus frequency in CPU structure
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20200309235411.76587-1-liran.alon@oracle.com>
 <20200309235411.76587-13-liran.alon@oracle.com>
 <20200310052900-mutt-send-email-mst@kernel.org>
From: Liran Alon <liran.alon@oracle.com>
Message-ID: <7d511194-6af1-efe6-1170-623144bdcc20@oracle.com>
Date: Tue, 10 Mar 2020 12:53:28 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200310052900-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9555
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 malwarescore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 mlxscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003100072
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9555
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 spamscore=0
 priorityscore=1501 clxscore=1015 mlxscore=0 impostorscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003100073
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


On 10/03/2020 11:29, Michael S. Tsirkin wrote:
> On Tue, Mar 10, 2020 at 01:54:09AM +0200, Liran Alon wrote:
>> No functional change.
>> This information will be used by following patches.
>>
>> Reviewed-by: Nikita Leshenko <nikita.leshchenko@oracle.com>
>> Signed-off-by: Liran Alon <liran.alon@oracle.com>
>> ---
>>   linux-headers/asm-x86/kvm.h | 4 ++++
>>   target/i386/cpu.h           | 1 +
>>   target/i386/kvm.c           | 6 +++---
>>   3 files changed, 8 insertions(+), 3 deletions(-)
>>
>> diff --git a/linux-headers/asm-x86/kvm.h b/linux-headers/asm-x86/kvm.h
>> index 503d3f42da16..99eeaaf2f0b4 100644
>> --- a/linux-headers/asm-x86/kvm.h
>> +++ b/linux-headers/asm-x86/kvm.h
>> @@ -446,4 +446,8 @@ struct kvm_pmu_event_filter {
>>   #define KVM_PMU_EVENT_ALLOW 0
>>   #define KVM_PMU_EVENT_DENY 1
>>   
>> +/* From arch/x86/kvm/lapic.h */
>> +#define KVM_APIC_BUS_CYCLE_NS       1
>> +#define KVM_APIC_BUS_FREQUENCY      (1000000000ULL / KVM_APIC_BUS_CYCLE_NS)
>> +
>>   #endif /* _ASM_X86_KVM_H */
>
> This header is auto-generated from UAPI - you can't add
> your own stuff here.
Oh I didn't notice that. OK, I will move definitions to somewhere else.
Is it fine by you if I will just put them then in target/i386/kvm.c 
directly?
Or do you prefer I will put them in target/i386/kvm_i386.h

-Liran



