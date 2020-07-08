Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01675C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 22:26:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B922C20772
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 22:26:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hL5Ph0Lw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B922C20772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45312 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtIWX-0002re-0o
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 18:26:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41714)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jtI43-0003O7-Uk
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 17:57:15 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:27948)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jtI42-0005pu-4b
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 17:57:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594245433;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=krOrMaNDViBLAdn2O1gActk6oXSacNNMPEImh2PMkH4=;
 b=hL5Ph0Lw5XcDJ9tUQd9FyZnqNuqS6OKU5ms+6SlVYDWWuhcUBiZ4Wp1upNEWYIW0VvTzF0
 /O+EZpKIpi66Gh8/rfgcCvsmMvj2AnckUdL/hIhQMma3tUjfA9UBFo0nMzJH1HmUBIttGb
 uAJYn5Hcr7wZtxUO2QI+wDVkYifp7QI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-251-NpCPDnwyMRudtPcMcZJP1A-1; Wed, 08 Jul 2020 12:55:49 -0400
X-MC-Unique: NpCPDnwyMRudtPcMcZJP1A-1
Received: by mail-wr1-f70.google.com with SMTP id s16so39475652wrv.1
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2020 09:55:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=krOrMaNDViBLAdn2O1gActk6oXSacNNMPEImh2PMkH4=;
 b=fTl4/q4ygxX34MGE84g4Imum9C2Mt/c4hjKZ0MZnNQKi38LJ32r4oE4XGEzyr9gBMj
 skRL8/04eCzPvzP1yc6sSF7lqU9Z9w7+2CITdeYULQvIm56x7/YulgfLLAo+K0a5GpAn
 12Kroj3XrQ/n3b/mFnGoMhAZ90l7vH0PnGF+2K7P/ZLeYANF28iWqyKzPkXDIaPLXOoF
 p5QrRvli9uCVFuEfWpc1CoFutiK+3qY6dk6MrRmbynZtJlWdVX/kUYseubAFE9XI9Wza
 iLXhfMevB8Si90U9PJO/lNofZrfeuSNEdQrboeTQkyvufeYXqnWxwuwqIAqCP50NElQN
 HCLQ==
X-Gm-Message-State: AOAM533SYEnsf0AjrI/NhJERuIzoLnEy8GANs365Lbtr5Rhqnji0kVpb
 oi3mdONHQLaqJVj7PTdRLzutL3ipUFV0gu17N//R4h3RICKMSe/wA6Fau2/CKsH5m/CIGP+sgmk
 fZEMpMP/GLD7fIr0=
X-Received: by 2002:a5d:4a45:: with SMTP id v5mr59919270wrs.228.1594227347773; 
 Wed, 08 Jul 2020 09:55:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyouR+rGf3f8tM0Fl2jmqjUBefaOjD5gA37Wrcj2S4NQpNIVrbm93YcG3dEH4Jdcuhj+s6dvw==
X-Received: by 2002:a5d:4a45:: with SMTP id v5mr59919257wrs.228.1594227347544; 
 Wed, 08 Jul 2020 09:55:47 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9541:9439:cb0f:89c?
 ([2001:b07:6468:f312:9541:9439:cb0f:89c])
 by smtp.gmail.com with ESMTPSA id u65sm567385wmg.5.2020.07.08.09.55.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jul 2020 09:55:47 -0700 (PDT)
Subject: Re: [PULL 00/53] Misc patches for QEMU 5.1 soft freeze
To: Claudio Fontana <cfontana@suse.de>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20200706164155.24696-1-pbonzini@redhat.com>
 <CAFEAcA-F1FGde+=c3iS3wcRWG+i0RgYj5-jwafn0sX6EEYEsWA@mail.gmail.com>
 <1a9ad36f-f4ae-2ea5-3d69-03aa5580b60e@suse.de>
 <de27589f-6afb-b8cf-05a0-f5d34f9d2a58@redhat.com>
 <f17ca47d-f5e9-e710-5edb-9d92839ee7c1@suse.de>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <56c7e153-e47b-aa5c-80c0-ab4f5c3d85e8@redhat.com>
Date: Wed, 8 Jul 2020 18:55:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <f17ca47d-f5e9-e710-5edb-9d92839ee7c1@suse.de>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 17:25:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 08/07/20 18:45, Claudio Fontana wrote:
> C++ is used to link the final qemu-system binary and on my system c++ has LTO:
> 
> c++ -v
> Using built-in specs.
> COLLECT_GCC=c++
> COLLECT_LTO_WRAPPER=/usr/lib64/gcc/x86_64-suse-linux/7/lto-wrapper
> OFFLOAD_TARGET_NAMES=hsa:nvptx-none
> Target: x86_64-suse-linux
> Configured with: ../configure --prefix=/usr --infodir=/usr/share/info
> --mandir=/usr/share/man --libdir=/usr/lib64 --libexecdir=/usr/lib64
> --enable-languages=c,c++,objc,fortran,obj-c++,ada,go
> --enable-offload-targets=hsa,nvptx-none=/usr/nvptx-none,
> --without-cuda-driver --enable-checking=release --disable-werror
> --with-gxx-include-dir=/usr/include/c++/7 --enable-ssp --disable-libssp
> --disable-libvtv --disable-libcc1 --disable-plugin
> --with-bugurl=https://bugs.opensuse.org/ --with-pkgversion='SUSE Linux' --with-slibdir=/lib64 --with-system-zlib --enable-libstdcxx-allocator=new --disable-libstdcxx-pch --enable-version-specific-runtime-libs --with-gcc-major-version-only --enable-linker-build-id --enable-linux-futex --enable-gnu-indirect-function --program-suffix=-7 --without-system-libunwind --enable-multilib --with-arch-32=x86-64 --with-tune=generic --build=x86_64-suse-linux --host=x86_64-suse-linux
> Thread model: posix
> gcc version 7.5.0 (SUSE Linux) 
> 
> 
> I checked cc but did not think to check c++ . I will find a way to disable this thing and will correct the patch accordingly.

Having LTO support is not the same thing as having it enabled.  Are you
compiling and linking with "-flto"?

Paolo


