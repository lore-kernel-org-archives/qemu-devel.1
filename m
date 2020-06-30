Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8E4FC433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 16:29:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B85A6206BE
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 16:29:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YUJzyWzJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B85A6206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53764 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqJ8G-0002E2-1N
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 12:29:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56214)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jqJ7B-0001YY-TK
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 12:28:09 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:45391
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jqJ7A-0004v7-7a
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 12:28:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593534485;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=psY5Gw6P3gxLmjn6Pa37vxijEOJixm5kHfImi48Meag=;
 b=YUJzyWzJUe/sTHlCUEQNLky0vojrh5RQlCA0X8LXia4wo+pv7DrH7oHRWyGlBqX3ycqJqy
 YZSGndkMxtsPkuRltYvI7o61sDayrX5sZVXKADxxIrfb6B2ZdJMWGqmJkOxFoQuywSZWpJ
 KbhDyxOLGA/lVLumWGlSEk6MyVXzSzc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-62-sTKuHia1M924c6w7K8zn7w-1; Tue, 30 Jun 2020 12:28:04 -0400
X-MC-Unique: sTKuHia1M924c6w7K8zn7w-1
Received: by mail-wr1-f71.google.com with SMTP id 59so12399181wrp.4
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2020 09:28:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=psY5Gw6P3gxLmjn6Pa37vxijEOJixm5kHfImi48Meag=;
 b=Cd6Zx1Zy9zPic2FIcmtRVsuFlN34sPFXoGsgdzr7coS9o8nDdFmhbnQVZqDFvizx1u
 Pu7l1puIHYUvmMx5t7KD/DtHDFIdrU/T1Yn7vWbkrEQX2Kg0OApFTZEwZawrVktuN1d4
 wUGjyAAqyTTZE/pk6WPWpAcpud7AVINPWPBl8xG0N67aD7fcmnRrYai1ng94vhmibgAI
 feQA5AJrP956OtLX8Gn2dLExuFQdiqJS1YwkOF/9GZjnqC176iTZVQ9GeMV5KCIV1eoV
 25E6/KkJObSF7pM+9ymCgokqI96/Zb3GErZCgTJs4IaNSkEDOd0muCrY/4j9X/+QfL5c
 CdWA==
X-Gm-Message-State: AOAM532WTV4hI5sMXUMMzDZNgR0tMAK25itBMOhL9eTcAh21qMJL7pee
 Kyqfal/WHHomUmGJjynhCYkyOfMrktHiC/vkAUiqjCzcTke6ACzNK/F9zShcO7vnDolz0x7Aiec
 ws2nL5WUt5K3pOT0=
X-Received: by 2002:adf:e88b:: with SMTP id d11mr13238459wrm.378.1593534482826; 
 Tue, 30 Jun 2020 09:28:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzlexghfrvfgWb6XgW1p139N35g8qU0VqP7s/vdm+IaRnIXv17A5KLV3UjNHJIb3Nnw35orAQ==
X-Received: by 2002:adf:e88b:: with SMTP id d11mr13238447wrm.378.1593534482615; 
 Tue, 30 Jun 2020 09:28:02 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:acad:d1d4:42b8:23e4?
 ([2001:b07:6468:f312:acad:d1d4:42b8:23e4])
 by smtp.gmail.com with ESMTPSA id d18sm4539050wrj.8.2020.06.30.09.28.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jun 2020 09:28:02 -0700 (PDT)
Subject: Re: [PATCH] KVM: x86: believe what KVM says about WAITPKG
To: Maxim Levitsky <mlevitsk@redhat.com>, qemu-devel@nongnu.org
References: <20200630151150.536580-1-pbonzini@redhat.com>
 <a945de64247435c6066a76dc79f32df1e6cbd0f6.camel@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <cf58c020-8009-1c52-2151-84d0d046348e@redhat.com>
Date: Tue, 30 Jun 2020 18:28:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <a945de64247435c6066a76dc79f32df1e6cbd0f6.camel@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 01:11:03
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 30/06/20 18:07, Maxim Levitsky wrote:
> I think we need to keep some form of this hack, since the kernel doesn't report CPUID_7_0_ECX_WAITPKG via
> KVM_GET_SUPPORTED_CPUID, so for this to work, we need to fix the kernel to report it. 
> But to support older kernels that don't report this bit, we might still need this.
> What do you think?
> 
> Note that kvm_arch_get_supported_cpuid also has a override for what KVM reports about CPUID_EXT_MONITOR
> via KVM_GET_SUPPORTED_CPUID when cpu_pm=on and also does this without checking any conditions,
> and it works because MWAIT is very old feature, and I guess it was the inspiration for the above override
> that we are trying to remove.
> 
> Kernel sadly masks both MWAIT and WAITPKG in KVM_GET_SUPPORTED_CPUID currently
> (it is in kvm_set_cpu_caps)

Right.  We need to use host_cpuid instead of kvm_arch_get_supported_cpuid.

Paolo


