Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07B66C43461
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 16:59:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64F982193E
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 16:59:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hwGucUdq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64F982193E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56100 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIEIh-00060T-FA
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 12:59:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41042)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kIEHm-0005OT-SJ
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 12:58:30 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:27404
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kIEHk-0000zD-Ny
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 12:58:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600189106;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1PsjdetKq0hwwm1fGYkthknhoskaTzOH0B5Xupxyaaw=;
 b=hwGucUdq19LoG4RWrDJ2Ik2xyjz69wU4jch6naR3MlWFyEHk/BeUpEbk2uKSuzc2W0fu3l
 +ecfAxdZC7fmy9MBNgwVDqNc2XxsJpt+ILJr/ISoDR9ZXWjLPrioJMUmvDztG/6Cm6rBQV
 crxL2dW7JPq/CsCU452S3AUBVXKniOE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-452-P6w4V3lSMSuoMgyiwLFPyw-1; Tue, 15 Sep 2020 12:58:22 -0400
X-MC-Unique: P6w4V3lSMSuoMgyiwLFPyw-1
Received: by mail-wr1-f69.google.com with SMTP id a12so1453821wrg.13
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2020 09:58:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=1PsjdetKq0hwwm1fGYkthknhoskaTzOH0B5Xupxyaaw=;
 b=M8B7B8JKqLXrLMfOkjcyVzO0lnlZ6XsjLFxxXCz2MdEr5qX53hwbO4BkCkh6Lc/XKh
 PwHK4A62UpslttMA16tT3XF5o6JVcnIX5Sv8yuW2Dodz//OLQaM+AD8WtTTQiQ43OUX/
 BOc8aWsUrryTEz9WrAbffaaBDF9ZhW6luSj7b1vNL3FMHoBRl+u5MuOaRBX+H+gZkCPz
 KqPRXnKa3Ln48TH/OnMm8jqvqGsvi2RsN2gzBOYB36Bk1HSmLhRonOHjeo6ekbFvTp7W
 vRaaa7YoyYeF1sRVZYIbC+mn3lMA5y0nvFRF4GiKb9TnuvrTLPWF8nlJ+RunCh86FeGu
 oygw==
X-Gm-Message-State: AOAM530JGIn0Wb2cQoz8rKtl4Ba7ALUCBuI6H4LdS87edyH1na8QCEaf
 fYXzit2oz8vapl6M2ZxlZ8hAfg51pf/M+nwP2omdR9fd4WqTmEme0ePmbTM+xuil5haEYpSwPVP
 W5aCVRMfxnIn3Ntk=
X-Received: by 2002:a5d:4d48:: with SMTP id a8mr22048640wru.318.1600189100522; 
 Tue, 15 Sep 2020 09:58:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwtNBTnOUdVClwZX9G2nxSi3WN+C1rHq+tGTDEmOoEANIteLfINOA1YuXG+iTPdIvxy47ceQQ==
X-Received: by 2002:a5d:4d48:: with SMTP id a8mr22048625wru.318.1600189100310; 
 Tue, 15 Sep 2020 09:58:20 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:eac8:587f:8ca7:e1e8?
 ([2001:b07:6468:f312:eac8:587f:8ca7:e1e8])
 by smtp.gmail.com with ESMTPSA id q8sm27833915wrx.79.2020.09.15.09.58.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Sep 2020 09:58:19 -0700 (PDT)
Subject: Re: [PATCH v2 01/10] capstone: Convert Makefile bits to meson bits
To: Richard Henderson <richard.henderson@linaro.org>
References: <20200914230210.2185860-1-richard.henderson@linaro.org>
 <20200914230210.2185860-2-richard.henderson@linaro.org>
 <eced490f-0250-3516-5d75-c6c3ff6e97be@linaro.org>
 <CABgObfbWzf7DLgx23+yMqYqnMUaiJ=0WKaW4zvzkA4u5T9fQXQ@mail.gmail.com>
 <4813770a-34a4-72ce-17f7-7ea451a7af99@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <74eed6fb-3b83-9338-949a-4f3ce3098315@redhat.com>
Date: Tue, 15 Sep 2020 18:58:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <4813770a-34a4-72ce-17f7-7ea451a7af99@linaro.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/15 03:21:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: thuth@redhat.com, luoyonggang@gmail.com,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 15/09/20 16:27, Richard Henderson wrote:
> On 9/14/20 11:27 PM, Paolo Bonzini wrote:
>> Looks good. Can you just add a "# Submodules" heading above the test?
>>
>> I would also like to remove the "yes" value (that is, the default fails if the
>> internal copy is not there) but it can be done later for all submodules.
> 
> Unless you simply plan to rename {no, yes} to {disabled, enabled}, as for the
> Feature objects, why?
> 
> That seems to be the only sensible value for --enable-foo, without the =system
> or =git specifiers.  We *should* fail if no system library nor internal copy is
> present.

Yes, that was a bit concise.  I would like "auto" to take the meaning
that "yes" currently as.  Right now we have

no -> Easy :)
system -> System capstone if found, fail otherwise
internal/git -> Compile capstone if found, fail otherwise
auto -> System capstone, then internal, then disable
yes -> System capstone, then internal, then fail

I'm not sure of the usefulness of disabling a dependency because we
don't have it checked out, since we have the machinery to do the
checkout automatically.  So that would become:

no -> Easy :)
system -> System capstone if found, fail otherwise
internal/git -> Compile capstone if found, fail otherwise
auto -> System capstone, then internal, then fail

The disadvantage is that it would be different from other "auto"
symbols, which never fail.  But then those other "auto" symbols do not
have a built-in fallback, so the question is whether the combination of

1) building from a fresh git checkout
2) --disable-git-update
3) not having a system capstone/libfdt/slirp
4) not having --disable-{capstone,libfdt,slirp} on the command line

is more likely to be intentional or operator error.

Paolo


