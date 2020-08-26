Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC10BC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 13:33:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7704F208E4
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 13:33:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D3+TSbVR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7704F208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37102 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAvYl-0006my-RN
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 09:33:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56944)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1kAvXm-0005yl-02
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 09:32:50 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:56912
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1kAvXj-0006C6-QV
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 09:32:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598448766;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k6Mc9PONxRy8tB2GPycEaQlPFxsl5KECYGNOKcOUGG0=;
 b=D3+TSbVRI2getIvzptOk/bvSeO1pBAqYf9E/otFvHnWUwiKSeyjn8VfKqHjfrYVFnqcFXT
 II7m+b/q/ZiC4vZledurMEqY2leQqCfHNUz4F+xpNFWx5rbwXTUcAFsD4vJT+OWrk83TPD
 0Pg9ta9x4+CnvXSJJfRu2ZBim/bJJZw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-188-lRo6TVLtMW6H9oabdLnz1Q-1; Wed, 26 Aug 2020 09:32:44 -0400
X-MC-Unique: lRo6TVLtMW6H9oabdLnz1Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9093A81CAF9;
 Wed, 26 Aug 2020 13:32:43 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-114-182.ams2.redhat.com
 [10.36.114.182])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 509C27A410;
 Wed, 26 Aug 2020 13:32:42 +0000 (UTC)
Subject: Re: [PATCH v2 6/7] x68: acpi: trigger SMI before sending hotplug
 Notify event to OSPM
From: Laszlo Ersek <lersek@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
References: <20200818122208.1243901-1-imammedo@redhat.com>
 <20200818122208.1243901-7-imammedo@redhat.com>
 <382e54cc-1ac0-61e5-bf5d-0653480222a0@redhat.com>
 <cfd4dd52-4827-2288-4b4e-b396d48494f0@redhat.com>
 <1f563a82-4439-6346-e92e-d734e93418a1@redhat.com>
Message-ID: <52601e2a-c0e2-2af0-8424-8271c6eaf7e6@redhat.com>
Date: Wed, 26 Aug 2020 15:32:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Firefox/52.0 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1f563a82-4439-6346-e92e-d734e93418a1@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=lersek@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=lersek@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/26 06:53:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -52
X-Spam_score: -5.3
X-Spam_bar: -----
X-Spam_report: (-5.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.239, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: boris.ostrovsky@oracle.com,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, aaron.young@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 08/26/20 15:32, Laszlo Ersek wrote:
> On 08/26/20 11:24, Laszlo Ersek wrote:
>> Hi Igor,
>>
>> On 08/25/20 19:25, Laszlo Ersek wrote:
>>
>>> So I would suggest fetching the CNEW array element back into "uid"
>>> first, then using "uid" for both the NOTIFY call, and the (currently
>>> missing) restoration of CSEL. Then we can write 1 to CINS.
>>>
>>> Expressed as a patch on top of yours:
>>>
>>>> diff --git a/hw/acpi/cpu.c b/hw/acpi/cpu.c
>>>> index 4864c3b39694..2bea6144fd5e 100644
>>>> --- a/hw/acpi/cpu.c
>>>> +++ b/hw/acpi/cpu.c
>>>> @@ -564,8 +564,11 @@ void build_cpus_aml(Aml *table, MachineState *machine, CPUHotplugFeatures opts,
>>>>              aml_append(method, aml_store(zero, cpu_idx));
>>>>              while_ctx = aml_while(aml_lless(cpu_idx, num_added_cpus));
>>>>              {
>>>> -                aml_append(while_ctx, aml_call2(CPU_NOTIFY_METHOD,
>>>> -                    aml_derefof(aml_index(new_cpus, cpu_idx)), dev_chk));
>>>> +                aml_append(while_ctx,
>>>> +                    aml_store(aml_derefof(aml_index(new_cpus, cpu_idx)), uid));
>>>> +                aml_append(while_ctx,
>>>> +                    aml_call2(CPU_NOTIFY_METHOD, uid, dev_chk));
>>>> +                aml_append(while_ctx, aml_store(uid, cpu_selector));
>>>>                  aml_append(while_ctx, aml_store(one, ins_evt));
>>>>                  aml_append(while_ctx, aml_increment(cpu_idx));
>>>>              }
>>>
>>> This effects the following change, in the decompiled method:
>>>
>>>> @@ -37,15 +37,17 @@
>>>>      If ((Local_NumAddedCpus != Zero))
>>>>      {
>>>>          \_SB.PCI0.SMI0.SMIC = 0x04
>>>>      }
>>>>
>>>>      Local_CpuIdx = Zero
>>>>      While ((Local_CpuIdx < Local_NumAddedCpus))
>>>>      {
>>>> -        CTFY (DerefOf (CNEW [Local_CpuIdx]), One)
>>>> +        Local_Uid = DerefOf (CNEW [Local_CpuIdx])
>>>> +        CTFY (Local_Uid, One)
>>>> +        \_SB.PCI0.PRES.CSEL = Local_Uid
>>>>          \_SB.PCI0.PRES.CINS = One
>>>>          Local_CpuIdx++
>>>>      }
>>>>
>>>>      Release (\_SB.PCI0.PRES.CPLK)
>>>>  }
>>>
>>> With this change, the
>>>
>>>   virsh setvcpus DOMAIN 8 --live
>>>
>>> command works for me. The topology in my test domain has CPU#0 and
>>> CPU#2 cold-plugged, so the command adds 6 VCPUs. Viewed from the
>>> firmware side, the 6 "device_add" commands, issued in close succession
>>> by libvirtd, coalesce into 4 "batches". (And of course the firmware
>>> sees the 4 batches back-to-back.)
>>
>> unfortunately, with more testing, I have run into two more races:
>>
>> (1) When a "device_add" occurs after the ACPI loop collects the CPUS
>>     from the register block, but before the SMI.
>>
>>     Here, the "stray CPU" is processed fine by the firmware. However,
>>     the CTFY loop in ACPI does not know about the CPU, so it doesn't
>>     clear the pending insert event for it. And when the firmware is
>>     entered with an SMI for the *next* time, the firmware sees the same
>>     CPU *again* as pending, and tries to relocate it again. Bad things
>>     happen.
>>
>> (2) When a "device_add" occurs after the SMI, but before the firmware
>>     collects the pending CPUs from the register block.
>>
>>     Here, the firmware collects the "stray CPU". However, the "broadcast
>>     SMI", with which we entered the firmware, did *not* cover the stray
>>     CPU -- the CPU_FOREACH() loop in ich9_apm_ctrl_changed() could not
>>     make the SMI pending for the new CPU, because at that time, the CPU
>>     had not been added yet. As a result, when the firmware sends an
>>     INIT-SIPI-SIPI to the new CPU, expecting it to boot right into SMM,
>>     the new CPU instead boots straight into the post-RSM (normal mode)
>>     "pen", skipping its initial SMI handler. Meaning that the CPU halts
>>     nicely, but its SMBASE is never relocated, and the SMRAM message
>>     exchange with the BSP falls apart.
>>
>> Possible mitigations I can think of:
>>
>> For problem (1):
>>
>>   (1a) Change the firmware so it notices that it has relocated the
>>        "stray" CPU before -- such CPUs should be simply skipped in the
>>        firmware. The next time the CTFY loop runs in ACPI, it will clear
>>        the pending event.
>>
>>   (1b) Alternatively, stop consuming the hotplug register block in the
>>        firmware altogether, and work out general message passing, from
>>        ACPI to firmware. See the outline here:
>>
>>          http://mid.mail-archive.com/cf887d74-f65d-602a-9629-3d25cef93a69@redhat.com
>>
>> For problem (2):
>>
>>   (2a) Change the firmware so that it sends a directed SMI as well to
>>        each CPU, just before sending an INIT-SIPI-SIPI. This should be
>>        idempotent -- if the broadcast SMI *has* covered the the CPU,
>>        then sending a directed SMI should make no difference.
>>
>>   (2b) Alternatively, change the "device_add" command in QEMU so that,
>>        if "CPU hotplug with SMI" has been negotiated, the new CPU is
>>        added with the SMI made pending for it at once. (That is, no
>>        hot-plugged CPU would exist with the directed SMI *not* pending
>>        for it.)
>>
>>   (2c) Alternatively, approach (1b) would fix problem (2) as well -- the
>>        firmware would only relocate such CPUs that ACPI collected before
>>        injecting the SMI. So all those CPUs would have the SMI pending.
>>
>>
>> I can experiment with (1a) and (2a),
> 
> My patches for (1a) and (1b) seem to work -- my workstation has 10

aargh, I meant my patches for (1a) and (2a).

sorry
Laszlo

> PCPUs, and I'm using a guest with 20 possible VCPUs and 2 cold-plugged
> VCPUs on it, for testing. The patches survive the hot-plugging of 18
> VCPUs in one go, or two batches like 9+9. I can see the fixes being
> exercised.
> 
> Unless you strongly disagree (or I find issues in further testing), I
> propose that I post these fixes to edk2-devel (they should still be in
> scope for the upcoming release), and that we stick with your current
> patch series for QEMU (v3 -- upcoming, or maybe already posted).
> 
> Thanks!
> Laszlo
> 


