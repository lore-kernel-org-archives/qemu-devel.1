Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3891C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 17:38:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFBAF212CC
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 17:38:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TYSMOlzc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFBAF212CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlc1E-0007gD-UF
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 13:38:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60800)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jlc0T-0006ke-57
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 13:37:49 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:31361
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jlc0Q-00067o-UG
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 13:37:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592415466;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2hNrLKFzx+SU91EcmopqxtknC1GSH8vyiR3LApBQTDs=;
 b=TYSMOlzc640Z/VnU8DRHHrMHxIAlb33ikAz3w1CFnc7NKsOX5jlSSYPlDFlLbgoFJvkzMr
 NDeS4LLybBeEgu8GHOfDYLknPRrrARiIaK/6SPkLDwkSG90g8+NPPt0JOsPGqRy6Qi2fXr
 HfHLIxaZGSalKWyzQoVGsU6sZ4Xr9V4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-470-XbT4j0t3Ma2jmnIrw5V3ag-1; Wed, 17 Jun 2020 13:37:44 -0400
X-MC-Unique: XbT4j0t3Ma2jmnIrw5V3ag-1
Received: by mail-wm1-f72.google.com with SMTP id j128so1526061wmj.6
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 10:37:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=2hNrLKFzx+SU91EcmopqxtknC1GSH8vyiR3LApBQTDs=;
 b=jbL6cRO8hVnVi7GhzKTzfBRSmI5uPiEuqMwWMFHEQ1qN94uRjs6uPNfaDvW0oD8YTZ
 +nz3QnZLgfOTZQfWLF9kaM8/yazXUSU33n0KsbF2p0+vkPd8oXleTajtB7lhhC2bb6O6
 E3Baet+1TqNZn/LGFRgfNhGF826bChR7PE43K7Wgm+YXMn/YZa49Mz8lR7vIL9ZdykGU
 Qc3DKWsk2e7dcwClQXO9/fImFPENWwd3M9OMtE1XO3UmedGetAJrmozhqKpvKqWShO0r
 5YpuxGhMma3zGYfpdgvQzxq8FnrzUTyfq9vz0xEdZswczRh2tE8ujwktjngl4e68OtMY
 3P0A==
X-Gm-Message-State: AOAM532MKmE1HvWJrewsHBrFzxB8EpWea0b3AzELp5GmmN6RjrJFudwb
 SGIp1hIudHI1R7H2+53wuThybfA4XWvTIdKIGR+bhhoXsYzBEVCwQOQ5FZ7xuRq9lwu951vwWCq
 Y8DHax7FQwKJeVcI=
X-Received: by 2002:a05:600c:2317:: with SMTP id
 23mr9817905wmo.139.1592415463040; 
 Wed, 17 Jun 2020 10:37:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx3YciH+f5OVe46ah2MB16qI0Gn1EiHqQ45UZ3u1EYqtXDANLy3Fba09QkOgNONjBrTbeFuXw==
X-Received: by 2002:a05:600c:2317:: with SMTP id
 23mr9817888wmo.139.1592415462827; 
 Wed, 17 Jun 2020 10:37:42 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:48a4:82f8:2ffd:ec67?
 ([2001:b07:6468:f312:48a4:82f8:2ffd:ec67])
 by smtp.gmail.com with ESMTPSA id r4sm334822wro.32.2020.06.17.10.37.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jun 2020 10:37:42 -0700 (PDT)
Subject: Re: [PATCH] target/arm/kvm: Check supported feature per accelerator
 (not per vCPU)
To: Andrew Jones <drjones@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
References: <20200617130800.26355-1-philmd@redhat.com>
 <20200617152319.l77b4kdzwcftx7by@kamzik.brq.redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <69f9adc8-28ec-d949-60aa-ba760ea210a9@redhat.com>
Date: Wed, 17 Jun 2020 19:37:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200617152319.l77b4kdzwcftx7by@kamzik.brq.redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/17 02:02:46
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
Cc: Haibo Xu <haibo.xu@linaro.org>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, kvm@vger.kernel.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 17/06/20 17:23, Andrew Jones wrote:
>>
>> Fix by kvm_arm_<FEATURE>_supported() functions take a AccelState
>> argument (already realized/valid at this point) instead of a
>> CPUState argument.
> I'd rather not do that. IMO, a CPU feature test should operate on CPU,
> not an "accelerator".

If it's a test that the feature is enabled (e.g. via -cpu) then I agree.  
For something that ends up as a KVM_CHECK_EXTENSION or KVM_ENABLE_CAP on 
the KVM fd, however, I think passing an AccelState is better.
kvm_arm_pmu_supported case is clearly the latter, even the error message
hints at that:

+        if (kvm_enabled() && !kvm_arm_pmu_supported(current_accel())) {
             error_setg(errp, "'pmu' feature not supported by KVM on this host");
             return;
         }

but the same is true of kvm_arm_aarch32_supported and kvm_arm_sve_supported.

Applying the change to kvm_arm_pmu_supported as you suggest below would be
a bit of a bandaid because it would not have consistent prototypes.  Sp
for Philippe's patch

Acked-by: Paolo Bonzini <pbonzini@redhat.com>

Thanks,

Paolo

> How that test is implemented is another story.
> If the CPUState isn't interesting, but it points to something that is,
> or there's another function that uses globals to get the job done, then
> fine, but the callers of a CPU feature test shouldn't need to know that.
> 
> I think we should just revert d70c996df23f and then apply the same
> change to kvm_arm_pmu_supported() that other similar functions got
> with 4f7f589381d5.


