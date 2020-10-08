Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 229ACC433E7
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 07:55:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8330D206F4
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 07:55:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="axzR3s0b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8330D206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59980 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQQm2-0003jU-AD
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 03:55:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35588)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kQQkO-00037W-HF
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 03:53:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44863)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kQQkM-0001Da-Rv
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 03:53:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602143634;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EeM2tLJZZ0I2/r5lqO36RjPkuKxF/JUEoiCYcpWWhqk=;
 b=axzR3s0bt1GjesNnZFvQu9WSrxZ9LMzSFkzCIkjyJNV4MpZh8Cq4GgK1r77799AdaaDB0d
 1YWN2v9xufTM/BJfs5r5aDPq6UczKRES8EELhcIn+3+9m6xP24Hh8Nt18VjcYQ1j9QeFjA
 6no4NB5H+xxGaY6hwRolQc4ArdyAgFc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-585-uyGr5a48PAOHRObVJZSjAg-1; Thu, 08 Oct 2020 03:53:50 -0400
X-MC-Unique: uyGr5a48PAOHRObVJZSjAg-1
Received: by mail-wm1-f72.google.com with SMTP id p17so2831697wmi.7
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2020 00:53:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=EeM2tLJZZ0I2/r5lqO36RjPkuKxF/JUEoiCYcpWWhqk=;
 b=hU040+pVqfYdLWMU38DNJnf91Pdeo8+yvL0mjnBJC8iTLERSJy9uMMcxoDl5ggAjyx
 ak8GF/cHOmDStGYUF3MUcJAeCknawc4kDunXX1NN8vzY7cHYU4IcnjjHS3mJnA3I6tNg
 YDyKhea2aw7Ap3DH/2/mLn/ovIWW9c8OB3iCmXMvP5Z59JraKTg+BE7IiVjau4y1uSqT
 CISaIwRhlyiBJUTfSeny1Pn4pqm9QtY60goSZsXYhGgejBzhaodYvIybdzKeT3lD2mr3
 Oh3TzIW6hKKC4NCLLExO6pzz+UpOJz1kxazj7Iu9novXw729mOHkH87iBY7jQgRwSteY
 4Iew==
X-Gm-Message-State: AOAM532MjlQGZRX8/LZpp07ISYwXcrvGSEA/6caNVnYNKtoJHQtcPOrO
 ihvZQFvBLGfAhEAd8vRRwgkac/o5+gis3MrIo6zzTenTNpjX62UUm3+ve90qWMzkxUSDsvZ3SS/
 ApqTwXIEvefS4l5A=
X-Received: by 2002:a1c:18e:: with SMTP id 136mr7256354wmb.22.1602143629380;
 Thu, 08 Oct 2020 00:53:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxlqMrh6Oifv8gtpC0X15zKaWdZW+8KKdLiQ7jPmO272mmr1uqaYmTj1jdafiVks0BedvgiZQ==
X-Received: by 2002:a1c:18e:: with SMTP id 136mr7256338wmb.22.1602143629140;
 Thu, 08 Oct 2020 00:53:49 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:bb8c:429c:6de1:f4ec?
 ([2001:b07:6468:f312:bb8c:429c:6de1:f4ec])
 by smtp.gmail.com with ESMTPSA id t124sm5954769wmg.31.2020.10.08.00.53.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Oct 2020 00:53:48 -0700 (PDT)
Subject: Re: [PATCH] target/i386: Support up to 32768 CPUs without IRQ
 remapping
To: David Woodhouse <dwmw2@infradead.org>, qemu-devel <qemu-devel@nongnu.org>
References: <78097f9218300e63e751e077a0a5ca029b56ba46.camel@infradead.org>
 <6f8704bf-f832-9fcc-5d98-d8e8b562fe2f@redhat.com>
 <698c8ab6783a3113d90d8435d07a2dce6a2e2ec9.camel@infradead.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7b9c8ca4-e89e-e140-d591-76dcb2cad485@redhat.com>
Date: Thu, 8 Oct 2020 09:53:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <698c8ab6783a3113d90d8435d07a2dce6a2e2ec9.camel@infradead.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/08 02:56:27
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.742,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Cc: x86 <x86@kernel.org>, kvm <kvm@vger.kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 08/10/20 09:29, David Woodhouse wrote:
> On Thu, 2020-10-08 at 08:56 +0200, Paolo Bonzini wrote:
>> On 05/10/20 16:18, David Woodhouse wrote:
>>> +        if (kvm_irqchip_is_split()) {
>>> +            ret |= 1U << KVM_FEATURE_MSI_EXT_DEST_ID;
>>> +        }
>>
>> IIUC this is because in-kernel IOAPIC still doesn't work; and when it
>> does, KVM will advertise the feature itself so no other QEMU changes
>> will be needed.
> 
> More the MSI handling than the IOAPIC. I haven't actually worked out
> *what* handles cycles to addresses in the 0xFEExxxxx range for the in-
> kernel irqchip and turns them into interrupts (after putting them
> through interrupt remapping, if/when the kernel learns to do that).

That's easy: it's QEMU. :)  See kvm_apic_mem_write in hw/i386/kvm/apic.c
(note that this memory region is never used when the CPU accesses
0xFEExxxxx, only when QEMU does.

Conversion from the IOAPIC and MSI formats to struct kvm_lapic_irq is
completely separate in KVM, it is respectively in ioapic_service and
kvm_set_msi_irq.  Both of them prepare a struct kvm_lapic_irq, but
they're two different paths.

> Ideally the IOAPIC would just swizzle the bits in its RTE to create an
> MSI message and pass it on to the same code to be (translated and)
> delivered.
> 
> You'll note my qemu patch didn't touch IOAPIC code at all, because
> qemu's IOAPIC really does just that.

Indeed the nice thing about irqchip=split is that the handling of device
interrupts is entirely confined within QEMU, no matter if they're IOAPIC
or MSI.  And because we had to implement interrupt remapping, the IOAPIC
is effectively using MSIs to deliver its interrupts.

There's still the hack to communicate IOAPIC routes to KVM and have it
set the EOI exit bitmap correctly, though.  The code is in
kvm_scan_ioapic_routes and it uses kvm_set_msi_irq (with irqchip=split
everything is also an MSI within the kernel).  I think you're not
handling that correctly for CPUs >255, so after all we _do_ need some
kernel support.

Paolo

>> I queued this, though of course it has to wait for the corresponding
>> kernel patches to be accepted (or separated into doc and non-KVM
>> parts; we'll see).
> 
> Thanks.
> 


