Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75444C2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 06:24:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C30C922247
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 06:24:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C30C922247
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33900 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWvvK-000471-UK
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 02:24:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52796)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liangpeng10@huawei.com>)
 id 1kWvu0-0002rQ-8I
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 02:22:44 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:2482)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liangpeng10@huawei.com>)
 id 1kWvtv-0007mY-KC
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 02:22:43 -0400
Received: from DGGEMM405-HUB.china.huawei.com (unknown [172.30.72.57])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4CKPrb3L0HzVhBY;
 Mon, 26 Oct 2020 14:22:23 +0800 (CST)
Received: from dggema765-chm.china.huawei.com (10.1.198.207) by
 DGGEMM405-HUB.china.huawei.com (10.3.20.213) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Mon, 26 Oct 2020 14:22:18 +0800
Received: from [10.174.185.187] (10.174.185.187) by
 dggema765-chm.china.huawei.com (10.1.198.207) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Mon, 26 Oct 2020 14:22:18 +0800
Subject: Re: [PATCH] ACPI: Avoid infinite recursion when dump-vmstate
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Igor Mammedov
 <imammedo@redhat.com>
References: <20201019093156.2993284-1-liangpeng10@huawei.com>
 <20201023180933.2fe23875@redhat.com> <20201023185441.GP3038@work-vm>
From: Peng Liang <liangpeng10@huawei.com>
Message-ID: <be52cdde-33de-d519-6509-5f0900ce4c36@huawei.com>
Date: Mon, 26 Oct 2020 14:22:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <20201023185441.GP3038@work-vm>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.185.187]
X-ClientProxiedBy: dggeme715-chm.china.huawei.com (10.1.199.111) To
 dggema765-chm.china.huawei.com (10.1.198.207)
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.187;
 envelope-from=liangpeng10@huawei.com; helo=szxga01-in.huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 02:22:20
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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
Cc: mst@redhat.com, qemu-devel@nongnu.org, xiexiangyou@huawei.com,
 zhang.zhanghailiang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/24/2020 2:54 AM, Dr. David Alan Gilbert wrote:
> * Igor Mammedov (imammedo@redhat.com) wrote:
>> On Mon, 19 Oct 2020 17:31:56 +0800
>> Peng Liang <liangpeng10@huawei.com> wrote:
>>
>>> There is a field with vmstate_ghes_state as vmsd in vmstate_ghes_state,
>>> which will lead to infinite recursion in dump_vmstate_vmsd.
>>>
>>> Fixes: a08a64627b ("ACPI: Record the Generic Error Status Block address")
>>> Reported-by: Euler Robot <euler.robot@huawei.com>
>>> Signed-off-by: Peng Liang <liangpeng10@huawei.com>
>>> ---
>>>  hw/acpi/generic_event_device.c | 3 +--
>>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>>
>>> diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
>>> index 6df400e1ee16..4b6867300a55 100644
>>> --- a/hw/acpi/generic_event_device.c
>>> +++ b/hw/acpi/generic_event_device.c
>>> @@ -334,8 +334,7 @@ static const VMStateDescription vmstate_ghes_state = {
>>>      .minimum_version_id = 1,
>>>      .needed = ghes_needed,
>>>      .fields      = (VMStateField[]) {
>>> -        VMSTATE_STRUCT(ghes_state, AcpiGedState, 1,
>>> -                       vmstate_ghes_state, AcpiGhesState),
>>> +        VMSTATE_UINT64(ghes_state.ghes_addr_le, AcpiGedState),
>>
>> not sure its' ok handle it this way,
>>
>> see how it is done with another structure:
>>
>> static const VMStateDescription vmstate_ged_state = {                            
>>     .name = "acpi-ged-state",                                                    
>>     .version_id = 1,                                                             
>>     .minimum_version_id = 1,                                                     
>>     .fields      = (VMStateField[]) {                                            
>>         VMSTATE_UINT32(sel, GEDState),                                           
>>         VMSTATE_END_OF_LIST()                                                    
>>     }                                                                            
>> }; 
>>
>> ...
>>
>> VMSTATE_STRUCT(ged_state, AcpiGedState, 1, vmstate_ged_state, GEDState),
>>
>> i.e. it looks like we are missing structure definition for AcpiGhesState
>>
>> CCing David,
>>  to help with migration magic in case I'm wrong or missed something
> 
> Yeh that's confusing :-)
> 
> Given a:
> 
>   VMSTATE_STRUCT(a, B, 1, vmstate_c, C)
> 
> We're saying there's a field 'a' in type B, and field 'a'
> should be of type C and be serialised using vmstate_c.
> 
> That also means that in any vmstate_c, we're expecting it
> to be passed a type C generally.
> 
> Having said that; you don't need a struct - you can get away
> with that VMSTATE_UINT64, there's two problems:
> 
>   a) That assumes that your ghes always stays that simple.
>   b) If you wanted to store a Ghes from a number of different
> parent structures then you're stuck because your vmstate_ghes_state
> is bound to being a strict field of AcpiGedState.
> 
> So yes, it's neatest to do it using a VMSD for AcpiGhesState
> 
> And congratulations on finding a loop; I don't think we've ever had one
> before :-)
> 
> Dave
> 
>>>          VMSTATE_END_OF_LIST()
>>>      }
>>>  };
>>

Do you mean that we need another VMStateDescription to describe
AcpiGhesState instead of using VMSTATE_UINT64 directly?  Maybe like this:

diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
index 6df400e1ee16..5454be67d5f0 100644
--- a/hw/acpi/generic_event_device.c
+++ b/hw/acpi/generic_event_device.c
@@ -322,6 +322,16 @@ static const VMStateDescription vmstate_ged_state = {
     }
 };

+static const VMStateDescription vmstate_ghes = {
+    .name = "acpi-ghes",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields     = (VMStateField[]) {
+        VMSTATE_UINT64(ghes_addr_le, AcpiGhesState),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
 static bool ghes_needed(void *opaque)
 {
     AcpiGedState *s = opaque;
@@ -335,7 +345,7 @@ static const VMStateDescription vmstate_ghes_state = {
     .needed = ghes_needed,
     .fields      = (VMStateField[]) {
         VMSTATE_STRUCT(ghes_state, AcpiGedState, 1,
-                       vmstate_ghes_state, AcpiGhesState),
+                       vmstate_ghes, AcpiGhesState),
         VMSTATE_END_OF_LIST()
     }
 };

-- 
Thanks,
Peng

