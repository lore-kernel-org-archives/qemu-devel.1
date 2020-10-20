Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BB9AC4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 16:17:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F2EB21481
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 16:17:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VTffRYFw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F2EB21481
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34410 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUuKI-0005sz-AU
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 12:17:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37526)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kUu0t-0004l6-0w
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 11:57:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:51973)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kUu0p-0003tE-5J
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 11:57:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603209441;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kipOOKJo5yLUIadBh/0UsO2xryBcw31fxo0+FFKLqio=;
 b=VTffRYFwovxUFXccvARBri488us18Ftq8TpitrHUaodx2YXbw0lX2ZIca6/pwqHnwm10eU
 N5FDUy0x5fjl4S7pAni4dq3V6pzBgha9gzjekksCH1mBu/y4sKoMPmB1OIwaZ56R5VkwMx
 qXqPue7eHLUGUl6FJdhxuZZTbQjwEk0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-238-Z4RoQ6IcOVGEmPwcxZ00hw-1; Tue, 20 Oct 2020 11:57:19 -0400
X-MC-Unique: Z4RoQ6IcOVGEmPwcxZ00hw-1
Received: by mail-wr1-f71.google.com with SMTP id r8so989290wrp.5
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2020 08:57:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=kipOOKJo5yLUIadBh/0UsO2xryBcw31fxo0+FFKLqio=;
 b=J5UpV7x/Fu/99Ct42gTVMw43c12QjlEXbYVzGVVH+80qLFJbB3WQYxvUjEplRWdDB7
 bSy3W8xLbxFDoRh2e3qzuva0XYqWMjXGuPwBlN79kv1CoPkO1lNZemCKw+1dXd2MLrc2
 X5Y8qFF8iCqgcLQVnbTjyOsqYogFTnHcs9YVRWjDX3mbkmOH+amMgnBRfCJAYS4vwR8e
 ak5i7JZn1zSAqDgtaDrWEI61JMvOzKs6zvR+i8q+/N9QIfeBPhzYM6EMIxE3DutdXmtP
 E4FAvG4g9h12PsEGnVbm8Dk0YHWEyUTaRVzK5XG+LgrWGaT5KyP1EB7e7vaiv49NNZqk
 NpdQ==
X-Gm-Message-State: AOAM532X/NiUa6lr1Oyj9QlusJMw4K2i9YUHBW+s22kPK5CMoe78kmgF
 Q6ubP4Bs1zWWgOE64CBh1QchSSEeejBp4HgB0Ir/Z/W7PtS7FDSERgywa4mgiNWsxT3fnfDZabJ
 D8Cut3TLz1VKoeNo=
X-Received: by 2002:a5d:60c4:: with SMTP id x4mr4567474wrt.175.1603209437913; 
 Tue, 20 Oct 2020 08:57:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwhS3ShUDinqJWU7Dd1+vqojjQ3+igk2Vlp3d49JcHb8JORTDXlN1VVM9nc1V4rX/r05Okf3A==
X-Received: by 2002:a5d:60c4:: with SMTP id x4mr4567457wrt.175.1603209437718; 
 Tue, 20 Oct 2020 08:57:17 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a?
 ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
 by smtp.gmail.com with ESMTPSA id m14sm3727212wro.43.2020.10.20.08.57.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Oct 2020 08:57:17 -0700 (PDT)
Subject: Re: [PATCH] Remove deprecated -no-kvm option
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20201020155254.56589-1-thuth@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <cc8719ce-3c7e-ee56-f0eb-849c7a2034f0@redhat.com>
Date: Tue, 20 Oct 2020 17:57:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201020155254.56589-1-thuth@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 01:15:43
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: qemu-trivial@nongnu.org, "Daniel P . Berrange" <berrange@redhat.com>,
 John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 libvir-list@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 20/10/20 17:52, Thomas Huth wrote:
> The option has never been mentioned in our documentation, it's been
> deprecated since years, it's marked with QEMU_ARCH_I386 (which does
> not make sense anymore since KVM is available on other architectures,
> too), it does not do anything by default in upstream QEMU (since TCG
> is the default here anyway), and we're spending too much precious time
> each year discussing whether it makes sense to keep this option as a
> nice suger or not... let's finally put an end on this and remove it.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  docs/system/deprecated.rst | 5 -----
>  qemu-options.hx            | 3 ---
>  softmmu/vl.c               | 4 ----
>  3 files changed, 12 deletions(-)
> 
> diff --git a/docs/system/deprecated.rst b/docs/system/deprecated.rst
> index 905628f3a0..66ef89b872 100644
> --- a/docs/system/deprecated.rst
> +++ b/docs/system/deprecated.rst
> @@ -27,11 +27,6 @@ System emulator command line arguments
>  The ``enforce-config-section`` parameter is replaced by the
>  ``-global migration.send-configuration={on|off}`` option.
>  
> -``-no-kvm`` (since 1.3.0)
> -'''''''''''''''''''''''''
> -
> -The ``-no-kvm`` argument is now a synonym for setting ``-accel tcg``.
> -

And of course it's going to need a v2 because it should be added in the
"removed" section.  It's really cursed. :)

Paolo


