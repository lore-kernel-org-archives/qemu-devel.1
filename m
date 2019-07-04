Return-Path: <SRS0=blGQ=VB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59A62C0651F
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 15:30:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 307E62184B
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 15:30:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 307E62184B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hj3gV-0002ft-Ab
	for qemu-devel@archiver.kernel.org; Thu, 04 Jul 2019 11:30:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38913)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hj3fV-0001vV-TB
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 11:29:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hj3fU-0000ab-OI
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 11:29:05 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42254)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hj3fU-0000a4-ID
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 11:29:04 -0400
Received: by mail-wr1-f65.google.com with SMTP id a10so5956857wrp.9
 for <qemu-devel@nongnu.org>; Thu, 04 Jul 2019 08:29:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=uTber9tnQqfaXZRYxYBLuoOHIoCFmIICAtxbv0BddWo=;
 b=lKYSkA+poNmIl3HGo9CuAGrvrDhuEgV7HxvesK8sHLr+qaEUuYaFPZ8DEP4Hak0MPA
 PDJJhVKsKofDBqRyozhq423ryoi0OkwXkSwmwbUuRbG2Zvxv74nNIUZjPxY53vEwrbJl
 dXbR8JDqMVa+mvzrND4Pb9g5TblfoDvfJQz4lhy9Ayk4Y2XeIUHcFn47ngHfZ96dyB5n
 9uKY275IcNCvsOmJf0mmrBlC69tR4bIOZkaJO/DLE+soujAJ1uTaT9JDvCpruxByihpn
 ksIBO3cInoX4U6zrrUjj1WITFo/1Gt+c/O38JZkT2GuI0B9oYz5IHJK9jdgwP0W1qz2v
 xcIA==
X-Gm-Message-State: APjAAAUwlYH5nWKhv09LA5l1l7QIfRqc+/pEtDfTS8n1u+xQUCXpAej4
 VfsyCc55xWBpvvdz0DEMDsSALQ==
X-Google-Smtp-Source: APXvYqw7wS0O7kIcDJO3t+HWyknb2q6xvP7eHD0RP4+CDaSX6mc7pSid9kytNhWqXR1Upc348yXh2A==
X-Received: by 2002:a5d:5448:: with SMTP id w8mr34173359wrv.180.1562254143384; 
 Thu, 04 Jul 2019 08:29:03 -0700 (PDT)
Received: from [10.201.49.68] (nat-pool-mxp-u.redhat.com. [149.6.153.187])
 by smtp.gmail.com with ESMTPSA id e20sm10190235wrc.9.2019.07.04.08.29.02
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Thu, 04 Jul 2019 08:29:02 -0700 (PDT)
To: Liran Alon <liran.alon@oracle.com>
References: <20190624230514.53326-1-liran.alon@oracle.com>
 <6499083f-c159-1c3e-0339-87aa5b13c2c0@redhat.com>
 <432511A2-C6B4-4B03-87A5-176D886C0BF2@oracle.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c5e7fd4d-3554-4df9-1e92-49e4ec02d653@redhat.com>
Date: Thu, 4 Jul 2019 17:29:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <432511A2-C6B4-4B03-87A5-176D886C0BF2@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] [PATCH] target/i386: kvm: Fix when nested state is
 needed for migration
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
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Karl Heubaum <karl.heubaum@oracle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 04/07/19 16:31, Liran Alon wrote:
> 
> 
>> On 2 Jul 2019, at 19:39, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>
>> On 25/06/19 01:05, Liran Alon wrote:
>>> When vCPU is in VMX operation and enters SMM mode,
>>> it temporarily exits VMX operation but KVM maintained nested-state
>>> still stores the VMXON region physical address, i.e. even when the
>>> vCPU is in SMM mode then (nested_state->hdr.vmx.vmxon_pa != -1ull).
>>>
>>> Therefore, there is no need to explicitly check for
>>> KVM_STATE_NESTED_SMM_VMXON to determine if it is necessary
>>> to save nested-state as part of migration stream.
>>>
>>> In addition, destination must enable eVMCS if it is enabled on
>>> source as specified by the KVM_STATE_NESTED_EVMCS flag, even if
>>> the VMXON region is not set. Thus, change the code to require saving
>>> nested-state as part of migration stream in case it is set.
>>>
>>> Reviewed-by: Karl Heubaum <karl.heubaum@oracle.com>
>>> Signed-off-by: Liran Alon <liran.alon@oracle.com>
>>> ---
>>> target/i386/machine.c | 2 +-
>>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/target/i386/machine.c b/target/i386/machine.c
>>> index 851b249d1a39..e7d72faf9e24 100644
>>> --- a/target/i386/machine.c
>>> +++ b/target/i386/machine.c
>>> @@ -999,7 +999,7 @@ static bool vmx_nested_state_needed(void *opaque)
>>>
>>>     return ((nested_state->format == KVM_STATE_NESTED_FORMAT_VMX) &&
>>>             ((nested_state->hdr.vmx.vmxon_pa != -1ull) ||
>>> -             (nested_state->hdr.vmx.smm.flags & KVM_STATE_NESTED_SMM_VMXON)));
>>> +             (nested_state->flags & KVM_STATE_NESTED_EVMCS)));
>>> }
>>>
>>> static const VMStateDescription vmstate_vmx_nested_state = {
>>>
>>
>> Queued, thanks.
>>
>> Paolo
> 
> Actually Paolo after I have created KVM patch
> ("KVM: nVMX: Change KVM_STATE_NESTED_EVMCS to signal vmcs12 is copied from eVMCS”)
> I think I realised that KVM_STATE_NESTED_EVMCS is actually not a requirement for nested-state to be sent.
> I suggest to replace this commit with another one that just change vmx_nested_state_needed() to return true
> In case format is FORMAT_VMX and vmxon_pa != -1ull and that’s it.
> 
> As anyway, QEMU provisioned on destination side is going to enable the relevant eVMCS capability.
> I’m going to send another series that refines QEMU nested-migration a bit more so I will do it along the way.
> But I think this patch should be un-queued. Sorry for realizing this later but at least it’s before it was merged to master :)

Replaced with

diff --git a/target/i386/machine.c b/target/i386/machine.c
index 851b249d1a..704ba6de46 100644
--- a/target/i386/machine.c
+++ b/target/i386/machine.c
@@ -997,9 +997,8 @@ static bool vmx_nested_state_needed(void *opaque)
 {
     struct kvm_nested_state *nested_state = opaque;
 
-    return ((nested_state->format == KVM_STATE_NESTED_FORMAT_VMX) &&
-            ((nested_state->hdr.vmx.vmxon_pa != -1ull) ||
-             (nested_state->hdr.vmx.smm.flags & KVM_STATE_NESTED_SMM_VMXON)));
+    return (nested_state->format == KVM_STATE_NESTED_FORMAT_VMX &&
+            nested_state->hdr.vmx.vmxon_pa != -1ull);
 }
 
 static const VMStateDescription vmstate_vmx_nested_state = {

and dropped the last paragraph of the commit message.

Paolo


