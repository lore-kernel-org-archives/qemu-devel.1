Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18976C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 17:59:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EE2B20639
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 17:59:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Whsp/3Y9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EE2B20639
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34476 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaN4Z-0006pK-Ff
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 12:59:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40504)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1kaN3F-0005om-Og
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 12:58:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37098)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1kaN3B-0003rF-TS
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 12:58:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604512703;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wVz5GsJ1sllaoRHffQLdaGqfihET3aY01lnZ56RP9w8=;
 b=Whsp/3Y9aI1ITlTtFnufvrrGgQ3k1HObAKpnON3FEHmfmp85conrGp+ngE+pXriGlF2bCL
 1QIXwG5/shcc0CJ2Wo7fGYpPCtilWbGuy38OmsCRgmG+Efw7N+Fw/FS/Ui6TGBtzNlH02Q
 Jm1Bg74esEy0majBK+KXuxe+mmt52Yw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-521-gIvY-FNbPzOLSmvUD_vmVA-1; Wed, 04 Nov 2020 12:58:20 -0500
X-MC-Unique: gIvY-FNbPzOLSmvUD_vmVA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A2B7B10E2183
 for <qemu-devel@nongnu.org>; Wed,  4 Nov 2020 17:58:19 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-112-163.ams2.redhat.com
 [10.36.112.163])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A38A75B4CC;
 Wed,  4 Nov 2020 17:58:09 +0000 (UTC)
Subject: Re: [PATCH RFC] memory: pause all vCPUs for the duration of memory
 transactions
To: Vitaly Kuznetsov <vkuznets@redhat.com>, Peter Xu <peterx@redhat.com>
References: <20201026084916.3103221-1-vkuznets@redhat.com>
 <20201102195729.GA20600@xz-x1> <87v9emy4g2.fsf@vitty.brq.redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <2e6e47d4-2a77-b8fb-723c-f38ec944057c@redhat.com>
Date: Wed, 4 Nov 2020 18:58:08 +0100
MIME-Version: 1.0
In-Reply-To: <87v9emy4g2.fsf@vitty.brq.redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=lersek@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=lersek@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 00:03:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/03/20 14:07, Vitaly Kuznetsov wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
>> Vitaly,
>>
>> On Mon, Oct 26, 2020 at 09:49:16AM +0100, Vitaly Kuznetsov wrote:
>>> Currently, KVM doesn't provide an API to make atomic updates to memmap when
>>> the change touches more than one memory slot, e.g. in case we'd like to
>>> punch a hole in an existing slot.
>>>
>>> Reports are that multi-CPU Q35 VMs booted with OVMF sometimes print something
>>> like
>>>
>>> !!!! X64 Exception Type - 0E(#PF - Page-Fault)  CPU Apic ID - 00000003 !!!!
>>> ExceptionData - 0000000000000010  I:1 R:0 U:0 W:0 P:0 PK:0 SS:0 SGX:0
>>> RIP  - 000000007E35FAB6, CS  - 0000000000000038, RFLAGS - 0000000000010006
>>> RAX  - 0000000000000000, RCX - 000000007E3598F2, RDX - 00000000078BFBFF
>>> ...
>>>
>>> The problem seems to be that TSEG manipulations on one vCPU are not atomic
>>> from other vCPUs views. In particular, here's the strace:
>>>
>>> Initial creation of the 'problematic' slot:
>>>
>>> 10085 ioctl(13, KVM_SET_USER_MEMORY_REGION, {slot=6, flags=0, guest_phys_addr=0x100000,
>>>    memory_size=2146435072, userspace_addr=0x7fb89bf00000}) = 0
>>>
>>> ... and then the update (caused by e.g. mch_update_smram()) later:
>>>
>>> 10090 ioctl(13, KVM_SET_USER_MEMORY_REGION, {slot=6, flags=0, guest_phys_addr=0x100000,
>>>    memory_size=0, userspace_addr=0x7fb89bf00000}) = 0
>>> 10090 ioctl(13, KVM_SET_USER_MEMORY_REGION, {slot=6, flags=0, guest_phys_addr=0x100000,
>>>    memory_size=2129657856, userspace_addr=0x7fb89bf00000}) = 0
>>>
>>> In case KVM has to handle any event on a different vCPU in between these
>>> two calls the #PF will get triggered.
>>
>> A pure question: Why a #PF?  Is it injected into the guest?
>>
> 
> Yes, we see a #PF injected in the guest during OVMF boot.
> 
>> My understanding (which could be wrong) is that all thing should start with a
>> vcpu page fault onto the removed range, then when kvm finds that the memory
>> accessed is not within a valid memslot (since we're adding it back but not
>> yet), it'll become an user exit back to QEMU assuming it's an MMIO access.  Or
>> am I wrong somewhere?
> 
> In case it is a normal access from the guest, yes, but AFAIR here
> guest's CR3 is pointing to non existent memory and when KVM detects that
> it injects #PF by itself without a loop through userspace.
> 

Indeed that's how I seem to remember it too; the guest page tables
cannot be walked (by the processor implicitly, or by KVM explicitly -- I
can't tell which one of those applies).

Thanks
Laszlo


