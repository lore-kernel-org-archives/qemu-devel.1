Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E3A8C43603
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 16:26:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37643206DB
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 16:26:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UYw8bjgI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37643206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41040 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icXTe-0005WB-QU
	for qemu-devel@archiver.kernel.org; Wed, 04 Dec 2019 11:26:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34369)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1icXRX-00043w-Kq
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 11:24:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1icXRW-0002mO-DY
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 11:23:59 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20066
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1icXRW-0002kz-8z
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 11:23:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575476637;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zi3siVzuD0gF9Jfvrp7PZuuqYsCl8OlTBWpf/P1Jdb4=;
 b=UYw8bjgIZPTh6+2SoujA0wIqaBH818i0oKQ+6I2wi6ypenmluUI3cEia529fBolEbwDjXP
 zNg9t+QXjDKYUBSpEAvaUAfGMz4gtdS0/5hBDLdG2xzg7GA0dGUVHfcj0OF/I+qiXOx5A0
 jbYy0q0yfqYYvX3k/K0oYGst4v7NQmU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-380-KqvZcqPyPJ2XeGZk3uSfVQ-1; Wed, 04 Dec 2019 11:23:54 -0500
Received: by mail-wr1-f69.google.com with SMTP id h30so91263wrh.5
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2019 08:23:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=zi3siVzuD0gF9Jfvrp7PZuuqYsCl8OlTBWpf/P1Jdb4=;
 b=cfCzxz72cBWEfpgU74m86NPUYUzU+rlDtHDImrGP5hpyT3Oq7p0SA/ZdBKCJZTgPzS
 vNq9Li6URbenwfEx9zyUqkg//JCL4sY31brUMXiwa1diKathh1N3Dx1TTwUlmRep/xXu
 4CAeHT/uVurQQ7MJdeVMtQUMBtbR6//lbyFUvoeMTli+vqPpXmdcWlvtInvBce9qDBpC
 S88gJBN7rybLv7q50p4n+MXKVv6+Dm9XQwa5stNJioVK0As3TwSfA/oT/6+R5Rt/pBap
 MC4DXu+J3teW7/P3cf8kxnFcrpXUkRV0jDT6OeUFODpYujReDeMn5azZoXl4fU1evjhj
 1PPw==
X-Gm-Message-State: APjAAAUI0KBB3XbamO+j7DLncPR7aONFcEYiJc4YLBlJH32dYcBQoECM
 H9UhUUsbKJhww/UpIPdiETS9ED7Th6+nXGUjJEeYw5tCq54HN35kvkjCBW13L/J+NYirg4y8m42
 kAJ7vRE5lFSpYZUs=
X-Received: by 2002:a05:600c:230d:: with SMTP id
 13mr327286wmo.13.1575476633260; 
 Wed, 04 Dec 2019 08:23:53 -0800 (PST)
X-Google-Smtp-Source: APXvYqzoFwrdUicKLCGUQqrBsC2FVxrG+lTaEvzg61cWLPm1vNon91CH0Ovxt4OsLfpSLXlAn2oIJA==
X-Received: by 2002:a05:600c:230d:: with SMTP id
 13mr327269wmo.13.1575476633007; 
 Wed, 04 Dec 2019 08:23:53 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:8dc6:5dd5:2c0a:6a9a?
 ([2001:b07:6468:f312:8dc6:5dd5:2c0a:6a9a])
 by smtp.gmail.com with ESMTPSA id h124sm7729871wme.30.2019.12.04.08.23.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Dec 2019 08:23:52 -0800 (PST)
Subject: Re: [PATCH] target/i386: relax assert when old host kernels don't
 include msrs
To: Eduardo Habkost <ehabkost@redhat.com>
References: <1575449430-23366-1-git-send-email-catherine.hecx@gmail.com>
 <2ac1a83c-6958-1b49-295f-92149749fa7c@redhat.com>
 <CAEn6zmFex9WJ9jr5-0br7YzQZ=jA5bQn314OM+U=Q6ZGPiCRAg@mail.gmail.com>
 <714a0a86-4301-e756-654f-7765d4eb73db@redhat.com>
 <CAEn6zmHnTLZxa6Qv=8oDUPYpRD=rvGxJOLjd8Qb15k9-3U+CKw@mail.gmail.com>
 <3a1c97b2-789f-dd21-59ba-f780cf3bad92@redhat.com>
 <20191204154730.GB498046@habkost.net>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4bec2f12-63d7-928e-2e3e-137c68b2a435@redhat.com>
Date: Wed, 4 Dec 2019 17:23:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191204154730.GB498046@habkost.net>
Content-Language: en-US
X-MC-Unique: KqvZcqPyPJ2XeGZk3uSfVQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: kvm@vger.kernel.org, Marcelo Tosatti <mtosatti@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Catherine Ho <catherine.hecx@gmail.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 04/12/19 16:47, Eduardo Habkost wrote:
> On Wed, Dec 04, 2019 at 04:34:45PM +0100, Paolo Bonzini wrote:
>> On 04/12/19 16:07, Catherine Ho wrote:
>>>> Ok, so the problem is that some MSR didn't exist in that version.  Which
>>> I thought in my platform, the only MSR didn't exist is MSR_IA32_VMX_BASIC
>>> (0x480). If I remove this kvm_msr_entry_add(), everything is ok, the guest can
>>> be boot up successfully.
>>>
>>
>> MSR_IA32_VMX_BASIC was added in kvm-4.10.  Maybe the issue is the
>> _value_ that is being written to the VM is not valid?  Can you check
>> what's happening in vmx_restore_vmx_basic?
> 
> I believe env->features[FEAT_VMX_BASIC] will be initialized to 0
> if the host kernel doesn't have KVM_CAP_GET_MSR_FEATURES.

But the host must have MSR features if the MSRs are added:

        if (kvm_feature_msrs && cpu_has_vmx(env)) {
            kvm_msr_entry_add_vmx(cpu, env->features);
        }

Looks like feature MSRs were backported to 4.14, but
1389309c811b0c954bf3b591b761d79b1700283d and the previous commit weren't.

Paolo


