Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6DF9C4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 18:09:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1857F2086A
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 18:09:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="E2/UseZX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1857F2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48948 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLs9a-0002bb-4S
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 14:09:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44848)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1kLs8O-0001rJ-8S
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 14:07:52 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:40252)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1kLs8G-0003tT-Gp
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 14:07:51 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
 by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08PI3cw4116344;
 Fri, 25 Sep 2020 18:07:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=W/cFEI0EgkdWGwBGHNF1R0zWUmRBp4cacEkR+5uZCn4=;
 b=E2/UseZXVRAj9e5RCnJ/Vk3drckwkiskIDqx61d74HWQ65POby+Qk08va9PI1kTl5Sa8
 waZFVQqg6qoDLinSeSVas2d4YLuakYzSed+RZWVU9TXdSe7o6HIQ1aRJPYFRlTWGm/os
 lXJPLTZjUSu9lpOQcbNbKP1SazKlzGYxpUS4rHWwZ6f8cDJOqSY7o38+yPo4PGXskrWH
 wy1GE2Vwd9qygwIT0yafcJG39b9Gr5uEhOR1MatJZGQg71dlgSpPx8EK3S479NaI0MvG
 4vK6qBLZxlzryPJMbjiircGDu1+irKlM/BDB1JM2noGaSX5CFlJJ7ujmc7S8ru5O3N7s IQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by aserp2130.oracle.com with ESMTP id 33qcpuc0ha-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 25 Sep 2020 18:07:40 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08PI6YkY052894;
 Fri, 25 Sep 2020 18:07:39 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by userp3020.oracle.com with ESMTP id 33nury487e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 25 Sep 2020 18:07:39 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 08PI7bx2018317;
 Fri, 25 Sep 2020 18:07:37 GMT
Received: from [10.39.220.177] (/10.39.220.177)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Fri, 25 Sep 2020 11:07:37 -0700
Subject: Re: [PATCH V1 10/32] kvmclock: restore paused KVM clock
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
References: <1596122076-341293-1-git-send-email-steven.sistare@oracle.com>
 <1596122076-341293-11-git-send-email-steven.sistare@oracle.com>
 <20200911175018.GP3310@work-vm>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
Message-ID: <f9b72218-ca6f-66a5-761d-b4778df016e4@oracle.com>
Date: Fri, 25 Sep 2020 14:07:33 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200911175018.GP3310@work-vm>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9755
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 malwarescore=0
 phishscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009250127
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9755
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxlogscore=999
 adultscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0 priorityscore=1501
 phishscore=0 spamscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009250127
Received-SPF: pass client-ip=141.146.126.79;
 envelope-from=steven.sistare@oracle.com; helo=aserp2130.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 14:07:43
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.238, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/11/2020 1:50 PM, Dr. David Alan Gilbert wrote:
> * Steve Sistare (steven.sistare@oracle.com) wrote:
>> If the VM is paused when the KVM clock is serialized to a file, record
>> that the clock is valid, so the value will be reused rather than
>> overwritten after cprload with a new call to KVM_GET_CLOCK here:
>>
>> kvmclock_vm_state_change()
>>     if (running)
>>         ...
>>     else
>>         if (s->clock_valid)
>>             return;         <-- instead, return here
>>
>>         kvm_update_clock()
>>            kvm_vm_ioctl(kvm_state, KVM_GET_CLOCK, &data)  <-- overwritten
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>>  hw/i386/kvm/clock.c | 6 +++++-
>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/i386/kvm/clock.c b/hw/i386/kvm/clock.c
>> index 6428335..161991a 100644
>> --- a/hw/i386/kvm/clock.c
>> +++ b/hw/i386/kvm/clock.c
>> @@ -285,18 +285,22 @@ static int kvmclock_pre_save(void *opaque)
>>      if (!s->runstate_paused) {
>>          kvm_update_clock(s);
>>      }
>> +    if (!runstate_is_running()) {
>> +        s->clock_valid = true;
>> +    }
>>  
>>      return 0;
>>  }
>>  
>>  static const VMStateDescription kvmclock_vmsd = {
>>      .name = "kvmclock",
>> -    .version_id = 1,
>> +    .version_id = 2,
>>      .minimum_version_id = 1,
>>      .pre_load = kvmclock_pre_load,
>>      .pre_save = kvmclock_pre_save,
>>      .fields = (VMStateField[]) {
>>          VMSTATE_UINT64(clock, KVMClockState),
>> +        VMSTATE_BOOL_V(clock_valid, KVMClockState, 2),
>>          VMSTATE_END_OF_LIST()
> 
> We always try and avoid bumping version_id unless we're
> desperate because it breaks backwards migration.
> 
> Didn't you already know from the stored migration state
> (in the globalstate) if the loaded VM was running?
> 
> It's also not clear to me why you're avoiding reloading the state;
> have you preserved that some other way?

This patch was needed only for an early version of cprload which had some gratuitous
vmstate transitions.  I will happily drop this patch.

- Steve

>>      },
>>      .subsections = (const VMStateDescription * []) {
>> -- 
>> 1.8.3.1
>>

