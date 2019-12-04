Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DEE1C43603
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 12:31:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C1BD20833
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 12:31:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IlkFLlMT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C1BD20833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icToY-0001Ia-RQ
	for qemu-devel@archiver.kernel.org; Wed, 04 Dec 2019 07:31:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59139)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1icSka-0000MA-AI
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 06:23:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1icSkQ-0007vw-Eu
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 06:23:11 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34961
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1icSkP-0007Ju-9N
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 06:23:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575458582;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QZnLrosPfN9d8D/YgQSkPEoCOg9aABTUH81VkBYisN8=;
 b=IlkFLlMTetkCb9hCC+7bE8BdQqYHb1nKcpnn+crZN28nmPrnaLHwKehYXCcVmQwnybfjAO
 zZZAwnLA8efrz3BaLOY38UHaKgZtWlW3RMMjPndZZNrH3516uu0/UUOPb8tAr6wssertMo
 k6kCJ/4cwxSRcDE02Fpsy9p6cvT4C6I=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-23-FohcCbGwNcS2onboXHOBAg-1; Wed, 04 Dec 2019 06:22:58 -0500
Received: by mail-wm1-f69.google.com with SMTP id i17so50758wmd.1
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2019 03:22:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=QZnLrosPfN9d8D/YgQSkPEoCOg9aABTUH81VkBYisN8=;
 b=g72jFZ2o0OIUN6b977nXj5HiCI4EeUUabEAg0QbZnC6ccJNn300KM5MnJX0D629YgD
 ZWeecDVawekoFUwCXMnR3056cnXJP8CFzEAbA5LowosZqMdHvmNDfd7Ml7C0u1hsGpf0
 AR9lIbUWhXV3t1d9PZFV9sPrboE85yPMynIsQAyIC7XtJsP/++7dFvy7KSFZ6y5rxjAp
 Ki4cp0FA6wQ7sX4fYYjmgWAsi9zD+YsXkCz0NsIet41aZ9bJnqywxapoY4k9rDxwPPdw
 v6W4gMCMqP9HAJnANzoNB7Vc12SlxpZmMdOaJVMG0QQ069GC3T5cbNbhvRMtd9TNxCeO
 rY1g==
X-Gm-Message-State: APjAAAUWgTwZyhHvBEKul/+dbHZ6FgF+Cxtel5uinL8F9fOAW+237VuK
 AvcbKe7BI+htaFxBd2qS4EthIuk9NqT0lmh/RmrvQ1W+BQt//Fv6ffi/GAZEbByjNCc933FjuZF
 cWkjoZl3UqFy+x3U=
X-Received: by 2002:a7b:c95a:: with SMTP id i26mr9940540wml.67.1575458577687; 
 Wed, 04 Dec 2019 03:22:57 -0800 (PST)
X-Google-Smtp-Source: APXvYqx7Jo9io1wZIZy+j2roCX4NAjKvWVYd89R4kHLpvIwvZkqe8KChoscrIhJVbZvjSZ/EQ8wO+w==
X-Received: by 2002:a7b:c95a:: with SMTP id i26mr9940521wml.67.1575458577443; 
 Wed, 04 Dec 2019 03:22:57 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:8dc6:5dd5:2c0a:6a9a?
 ([2001:b07:6468:f312:8dc6:5dd5:2c0a:6a9a])
 by smtp.gmail.com with ESMTPSA id e6sm6978993wru.44.2019.12.04.03.22.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Dec 2019 03:22:56 -0800 (PST)
Subject: Re: [PATCH] target/i386: relax assert when old host kernels don't
 include msrs
To: Catherine Ho <catherine.hecx@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org
References: <1575449430-23366-1-git-send-email-catherine.hecx@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2ac1a83c-6958-1b49-295f-92149749fa7c@redhat.com>
Date: Wed, 4 Dec 2019 12:22:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <1575449430-23366-1-git-send-email-catherine.hecx@gmail.com>
Content-Language: en-US
X-MC-Unique: FohcCbGwNcS2onboXHOBAg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 04/12/19 09:50, Catherine Ho wrote:
> Commit 20a78b02d315 ("target/i386: add VMX features") unconditionally
> add vmx msr entry although older host kernels don't include them.
> 
> But old host kernel + newest qemu will cause a qemu crash as follows:
> qemu-system-x86_64: error: failed to set MSR 0x480 to 0x0
> target/i386/kvm.c:2932: kvm_put_msrs: Assertion `ret ==
> cpu->kvm_msr_buf->nmsrs' failed.
> 
> This fixes it by relaxing the condition.

This is intentional.  The VMX MSR entries should not have been added.
What combination of host kernel/QEMU are you using, and what QEMU
command line?

Paolo


