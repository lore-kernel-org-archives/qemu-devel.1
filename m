Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51590C4727E
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 07:39:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B90232075F
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 07:39:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="glws4Js1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B90232075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNtBq-0002VJ-RB
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 03:39:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52900)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kNtBH-0001zA-Bg
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 03:39:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:58450)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kNtBF-0004vw-7b
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 03:39:11 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601537948;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QIWTzCXKkMg/CKhfRHWpTjVDVAjxRLdwdegBES+XJQ8=;
 b=glws4Js18WlmGR57CBw2VZ/R8QVtbeAJ7jujXOwDrFsSYT0aBa44Q/5JFguueYVk9EjE2y
 y4/mAAHmFVQP8JiGoGQPJ7IfZpxNG2bsF95/XBHPRFP7VhXmikKUIIRHXA8o6+qPw38Z8u
 BZoid/PATxJ107CwndtCTUKGa0gBe+U=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-398-ub5UcIY0O3ekRIIcO8CWSg-1; Thu, 01 Oct 2020 03:39:03 -0400
X-MC-Unique: ub5UcIY0O3ekRIIcO8CWSg-1
Received: by mail-wm1-f69.google.com with SMTP id d197so344714wmd.4
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2020 00:39:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=QIWTzCXKkMg/CKhfRHWpTjVDVAjxRLdwdegBES+XJQ8=;
 b=FQ8zOwDjheQi2qFAG3f0io6j7jiH01ux1TlNvt1Mp28O0KjKbMDh4perv3qsiIaOVT
 OIR1duJm6p3qoDV8YRMsWNOVcartZbR5bpb2EUsswbNICrQJ/NDgvaJVimVhK56hqBRc
 La7S96jBA7M/RwQC4p1uOA8qsieB8os/1N6/Uq+K5727lEnVGsKr52/Vze+JhSRV5WCC
 YOrPjQuiC7EzyKW8HvB6vzXNHf3ItZBwZHDiLpSgUsGMbbnFmRlb3E774KsY174nnt1J
 m+QM1Fk4b3spz0dvGJMYA+5wSSyaR+7qfH9BSbez1kbY6XYpaLvZjjlJvSsRIOtuBTFN
 yIxg==
X-Gm-Message-State: AOAM531qbPxr0mB5ynjfcOmRQNWN3071kgMqbov8wIaf6aCi/6oEMJHC
 q2naHTH8CRx6qIfDnjY5vLC9l9EBPueIQ0jTgItq+EtsbNpv+Osl0Mxz8A/bB2iqxx8E12lxHAP
 3seRq9jFM/4RhWQY=
X-Received: by 2002:a05:600c:2283:: with SMTP id
 3mr6713973wmf.37.1601537942454; 
 Thu, 01 Oct 2020 00:39:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx9/L8Rc7SLTmXPgg+Bvp6N6o14YdHqxMvbxbXGnz8qDU/20+hvoQI5Zr9xZVHhilSC+tgmYg==
X-Received: by 2002:a05:600c:2283:: with SMTP id
 3mr6713941wmf.37.1601537942116; 
 Thu, 01 Oct 2020 00:39:02 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:aecc:db56:dd3f:503b?
 ([2001:b07:6468:f312:aecc:db56:dd3f:503b])
 by smtp.gmail.com with ESMTPSA id n66sm7270051wmb.35.2020.10.01.00.39.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Oct 2020 00:39:01 -0700 (PDT)
Subject: Re: [PATCH v3 17/19] hw/arm: Automatically select the 'virt' machine
 on KVM
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20200316160634.3386-1-philmd@redhat.com>
 <20200316160634.3386-18-philmd@redhat.com>
 <CAFEAcA-Rt__Du0TqqVFov4mNoBvC9hTt7t7e-3G45Eck4z94tQ@mail.gmail.com>
 <CAFEAcA-u53dVdv8EJdeeOWxw+SfPJueTq7M6g0vBF5XM2Go4zw@mail.gmail.com>
 <c7d07e18-57dd-7b55-f3dc-283c9d13e4b5@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8253ddd7-3149-17d9-1174-6474c4bde605@redhat.com>
Date: Thu, 1 Oct 2020 09:38:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <c7d07e18-57dd-7b55-f3dc-283c9d13e4b5@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 02:15:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.469,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 kvm-devel <kvm@vger.kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 29/09/20 22:36, Philippe Mathieu-Daudé wrote:
> Yes, the problem if I don't restrict to KVM, when
> using the Xen accelerator odd things occur
> (using configure --enable-xen --disable-tcg --disable-kvm):
> 
> Compiling C object libqemu-i386-softmmu.fa.p/hw_cpu_a15mpcore.c.o
> hw/cpu/a15mpcore.c:28:10: fatal error: kvm_arm.h: No such file or directory
> 
> See
> https://wiki.xenproject.org/wiki/Xen_ARM_with_Virtualization_Extensions#Use_of_qemu-system-i386_on_ARM

I don't understand.  Is Xen adding CONFIG_ARM_VIRT=y to
default-configs/i386-softmmu.mak??

(By the way, there are duplicate Kconfig symbols between target/arm and
hw/cpu, they could/should be removed from target/arm).

Paolo


