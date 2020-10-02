Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3016C4727D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 12:03:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5517D2074B
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 12:03:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f/pGP871"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5517D2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42098 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOJmJ-0000dL-80
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 08:03:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54546)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kOJlV-0000AZ-QT
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 08:02:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39364)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kOJlT-0002MX-33
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 08:02:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601640138;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cmpdhvKX0A2n9TsxkMB81fmT2C0+L5qXVSz6awlCNIA=;
 b=f/pGP871yrM2vbBa7pnyhPLk9U/7PUVJTV6vKLksejMIKrxzyeHmUrZwYN5AmxrKfa3d85
 UbWdasS3zul58gb+1pkC0cKDUiL0DhBKKlKeYzfzvLJqEel+f/kY+KqqIBMmNpiaGD6++I
 QZtIaneT4omQQSNUEIU5a5RBV0IEV4U=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-569-QkP034iYNemJnLW3r03xDw-1; Fri, 02 Oct 2020 08:02:13 -0400
X-MC-Unique: QkP034iYNemJnLW3r03xDw-1
Received: by mail-wr1-f69.google.com with SMTP id i10so471685wrq.5
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2020 05:02:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=cmpdhvKX0A2n9TsxkMB81fmT2C0+L5qXVSz6awlCNIA=;
 b=Lb03c8CFcHolcOiAkbAJbKr4fNbYkFqptU80FeEVXQIOl/TMBGF5hCVuiXdebhiIu5
 TM5sbT2zU+ZyBkv/VU8sxy6jv0t9DDa9zs/Yi7uHSlBte7gPQYUGFCizNrT5UW0wp8XF
 5bR02CmbEac9CXV+fpbQ3ZqvBEx8JMVBFzoPrDpTyMyX8DSraAQ2/dxu06ps3QwBvQn0
 pGA0HNU41YAYEJlQK1Sci/csmNj5gq/EZHlEt+OvrFkJVpRPVVuoGcsnnL1eagEqGQEh
 FoseHlwfNyEjC45DC+mK7wncSHSONNGDu4sCRsdMu0wU3SVhXnmDzw/bHwWaGwAyjaSN
 m/7A==
X-Gm-Message-State: AOAM5333RG0BU+1XtGFms4XgCcnT1uniLPF6m+M4QM4M6ivBBEp9XwEQ
 0LwkvTAw4JHllXMd0oL3fifN+8MuEO5xSFQDR4+T+TAeT/drPVV5ZQ0tWc5xQydatn9+SKWG3HN
 XRoRcWHql6IEvpZY=
X-Received: by 2002:a1c:7e90:: with SMTP id z138mr2485930wmc.122.1601640132184; 
 Fri, 02 Oct 2020 05:02:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzk8rDxK3PWVmuA7V33SRNUJW92mhdYu7fengcnxTYcjxQYpkrbPrC7evtOv2CgMw5jQC4tgQ==
X-Received: by 2002:a1c:7e90:: with SMTP id z138mr2485893wmc.122.1601640131869; 
 Fri, 02 Oct 2020 05:02:11 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:11eb:3314:c22:e3c7?
 ([2001:b07:6468:f312:11eb:3314:c22:e3c7])
 by smtp.gmail.com with ESMTPSA id a7sm344780wmh.6.2020.10.02.05.02.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Oct 2020 05:02:11 -0700 (PDT)
Subject: Re: [PATCH] meson.build: Don't look for libudev for static builds
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20201002105239.2444-1-peter.maydell@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b1a6000a-c9a1-43fb-7646-b6ea87797b2e@redhat.com>
Date: Fri, 2 Oct 2020 14:02:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201002105239.2444-1-peter.maydell@linaro.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/02 01:13:31
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.256, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 02/10/20 12:52, Peter Maydell wrote:
> commit f01496a314d916 moved the logic for detecting libudev from
> configure to meson.build, but in the process it dropped the condition
> that meant we only ask pkg-config about libudev for a non-static
> build.
> 
> This breaks static builds of the system emulators on at least Ubuntu
> 18.04.4, because on that host there is no static libudev but
> pkg-config still claims it exists.
> 
> Reinstate the logic that we had in the configure check.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

I don't think this is a good idea.  Having a completely new build system
also lets us notice all these weird one-off tests, decide whether they
are worth being kept (like the SDL -Wno-undef workaround) or not, and
possibly come up with a policy that avoids having to make one-off decisions.

If "../configure --static" worked and now doesn't then it would be a
clear regression, but a one off check should have a bigger justification
than "39 --disable switches have worked so far and 39 < 40".

Here are three alternatives to the patch:

- the workaround: just leave things as they are and add
--disable-libudev to your script.  We have just added a month ago a
completely new dependency that would have the same issue (libu2f); we
didn't add "test $static" just because you don't have libu2f installed
and therefore you didn't notice.  The day you updated your system ended
up with libu2f-dev installed, you would probably just add
--disable-libu2f instead of adding a test for $static.  So why should
libudev be treated differently?

- the cheap fix: deprecate static building of emulators in the configure
script (in the meanwhile you add --disable-libudev); if people complain,
we figure out the dependencies that they care about and we try to
understand if it's actually possible to build a statically linked
emulator for their usecase.

- the complicated fix: check which statically linked libraries are
available in e.g. Debian and disable _all_ other dependencies with
--static (most of them will be the ones that you already have to disable
 in your script, and most of them will be in configure).  Based on the
outcome, decide whether it's actually possible to build a statically
linked emulator that makes sense.

I wouldn't be surprised if people trying to statically build emulators
are getting worse performance just due to a missing static libaio or
libio_uring, for example, and these people might even be building a
statically-linked QEMU for use with KVM (like Firecracker), i.e. they
would care about performance.

Finally, no matter how we proceed, static building of system emulators
is not covered by either CI or tests/docker (only user-mode emulators
are).  Even if we deprecate it, we should make sure that your
configuration is reproduced in either Travis or GitLab, otherwise people
will keep on breaking it.  That would also document that building a
statically-linked system emulator is messy and requires a few dozen
--disable options.

Thanks,

Paolo

> We could certainly do something cleverer here, but basic "convert
> from configure to meson" should in general not also be changing the
> detection logic IMHO.  We can make the logic smarter as a follow-on
> patch if desired.
> ---
>  meson.build | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/meson.build b/meson.build
> index 3161c1f037a..07da66e1d81 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -271,7 +271,7 @@ if 'CONFIG_CURL' in config_host
>                              link_args: config_host['CURL_LIBS'].split())
>  endif
>  libudev = not_found
> -if targetos == 'linux' and (have_system or have_tools)
> +if targetos == 'linux' and (have_system or have_tools) and not enable_static
>    libudev = dependency('libudev',
>                         required: get_option('mpath').enabled(),
>                         static: enable_static)
> 


