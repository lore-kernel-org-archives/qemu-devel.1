Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E012C433E1
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 16:27:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFDCF207F5
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 16:27:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nuviainc-com.20150623.gappssmtp.com header.i=@nuviainc-com.20150623.gappssmtp.com header.b="GW1Nt/7m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFDCF207F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nuviainc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48474 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgsiQ-0006fW-8V
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 12:27:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51996)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leif@nuviainc.com>) id 1jgsh5-0005Tb-7x
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 12:26:15 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:38373)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <leif@nuviainc.com>) id 1jgsh2-0008Aj-5U
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 12:26:14 -0400
Received: by mail-wr1-x430.google.com with SMTP id e1so6829600wrt.5
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2020 09:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuviainc-com.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=wPNOw/I3JlqrIBS08wbKJdDUrxe00vptH4YgEIKXUXo=;
 b=GW1Nt/7mRR+HXAVpKpab1YPXsp6jAhm5Tmuojf44O3zCZndJ2iRunuY8wxCyXmjnfV
 az/6GaLKnpl+lC283v35kVr4KQVxzAiEAJ0HJoKBrhmbMdLXSRoGnBmsf44EaUWhEPuF
 ButZb9uvSF8Tx9VgRxlOmr8A76gkTNrMsxmbmac6sOt1M6inDljTAtWmFt/xyEAUeNlr
 c6M4PlxJe27uKIp1KiXfClTOSzidiO8P71UiI1AgsldvtfuvelWi7ceHXcP8bKSRGFBA
 psxGmEmBhyl8qCYOdz/NwggtYiQMUriLJ6DHvFShiKRS+yrga/xvwObaf8MBvNr+iB1r
 5UYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=wPNOw/I3JlqrIBS08wbKJdDUrxe00vptH4YgEIKXUXo=;
 b=lR0SgKRhPozg2TNQEQbfSSWY1wiCQ0P6LAmCVH/uqpko+BI3vVicipS0UGFwpdM2j9
 B6PBCCisvahUqYnSzikgSPN/j1xyESgCXvkgTx9vypgz5HKQzTq5CZwyCMERiFM/ufib
 hWcNieVw6Yy0ymdYRSb5h9Cy0LVoOEghNZnrzJHSAmyuqJ9M1SWXwqd7TyOJRexzbNo7
 LnW9Ir/ELJi6QjnNOR3y4CLZzu+DvuuNxJE4Os7CEpjKzDa5WWcKoRO1uEiX1phNbedF
 M1ZRrbp16IFXTjx0450RwpTxvtxsnZsQvpzS6RqQYvi0bf2vpMLoJW86rcEEejV1tQCT
 OjcQ==
X-Gm-Message-State: AOAM532vLrmKD+lvNK7byA7/aXFxvwpuTSGrXPwiC177fUu44hAak7Av
 K7RYsJ1vuOIcILIOq4aNYUDxDA==
X-Google-Smtp-Source: ABdhPJxReuTHWa4kGCayi9HnspEWzoDJ1VuQn72USC9K8my3P+q4NJZCAqH/6aBdvAvmzAl0T7o86w==
X-Received: by 2002:adf:bbc5:: with SMTP id z5mr5262670wrg.269.1591287970196; 
 Thu, 04 Jun 2020 09:26:10 -0700 (PDT)
Received: from vanye ([2001:470:1f09:12f0:b26e:bfff:fea9:f1b8])
 by smtp.gmail.com with ESMTPSA id c81sm8322311wmd.42.2020.06.04.09.26.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2020 09:26:09 -0700 (PDT)
Date: Thu, 4 Jun 2020 17:26:07 +0100
From: Leif Lindholm <leif@nuviainc.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: kvm_target, QEMU_KVM_ARM_TARGET_GENERIC_V8 questions
Message-ID: <20200604162607.GC28566@vanye>
References: <20200604125544.GW28566@vanye>
 <20200604131802.7w4hncgq2gopbw6z@kamzik.brq.redhat.com>
 <20200604160300.GB28566@vanye>
 <CAFEAcA8MTB5VQQbMuSfkGc9JcGeawL_GUY8Pcs3yxT9kdncZJw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA8MTB5VQQbMuSfkGc9JcGeawL_GUY8Pcs3yxT9kdncZJw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=leif@nuviainc.com; helo=mail-wr1-x430.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Andrew Jones <drjones@redhat.com>,
 qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jun 04, 2020 at 17:09:30 +0100, Peter Maydell wrote:
> On Thu, 4 Jun 2020 at 17:03, Leif Lindholm <leif@nuviainc.com> wrote:
> > But there's also things like:
> > - a57_initfn explicitly setting kvm_target, then only being called
> >   from max_initfn for !kvm_enabled()
> 
> Expected -- a KVM 'max' is nothing to do with a TCG 'max':
>  * for KVM, -cpu max means "same as -cpu host"
>  * for TCG, -cpu max means "start with an A57, then add in all the
>    extra architectural features that have been added since then".

Sure. But why are we setting the kvm_target at all for the
!kvm_enabled() case?

> kvm_target being set by a57_initfn is specifically for the case
> where a KVM user is using "-cpu cortex-a57".
> 
> > - a57_initfn setting cpu->dtb_compatible to "arm,cortex-a57"
> 
> What else would it set it to?

Hmm, I had been hoping there was a generic v8a one - kvm64.c kind of
got my hopes up with "arm,arm-v8". Still, for "max", would it not be
useful to update it to the track the most architecturally advanced cpu
supported? At this point "arm,cortex-a72".

> > - a57 initfn setting cpu->midr, max_initfn overwriting parts of it
> 
> Also expected, TCG's -cpu max is "A57 with lots of extras".

Maybe I'm being too rigid in my thinking here, but it does kind of jar
to see code call a function called aarch64_a57_initfn to have it write
a value where it then throws away the only thing in the value that
made it a57.

> The way we create a TCG -cpu max is a bit odd, as the code was
> originally written in a situation where A57 was the most advanced
> TCG CPU we had and there were no extra architectural features
> supported by our CPU emulation. Today we have an A72 model as
> well and a lot of extra architectural features, so the "code
> borrowed" to "extras added" ratio looks a bit unbalanced.
> Cleaning it up would not be a bad idea.

I might start by doing that bit. It might make a lot of the above
niggles simply disappear.

Not entirely unrelated question:
Would you take added field definitions in target/arm/cpu.h for
features not yet emulated in QEMU but defined in released versions of
ARM ARM?

Regards,

Leif

