Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4B3EC43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 18:02:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8050320714
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 18:02:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fP/wVSYu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8050320714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57288 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHWpd-0001ZY-KD
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 14:02:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45990)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jHWoh-0001AR-Ou
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 14:01:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jHWog-0003rW-FC
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 14:01:19 -0400
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543]:41436)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jHWog-0003py-8K
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 14:01:18 -0400
Received: by mail-ed1-x543.google.com with SMTP id v1so7948924edq.8
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 11:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=J2/7QbpcaWm+SJuEJkw2PhTYrndQ4RQBuLVBXfxvq/8=;
 b=fP/wVSYuFBXMkeS2zNa0k+GcpUjLWOpybqjMRZivHgCiyQVMgT69j7eNPDZPFon1uV
 3CFVk+TQN9AcmqvORBI3QwgYJDv07DBc1+yp/cBLw0345G/kNQS9J0W6A1CfQRmvGp0r
 KB7WWQHoyEmaS0TK3jXut7WURCORY2QHMlF0rVPH3fhQ82i3uc7Rr6Xpk4cIMwCzli+Z
 0FgnuTAGlqiegkSdqbFtdHD6vPG2T5OLMdvC9FbVXqB1zbKlrewtdMedFurSB/sQc71v
 Tcs5fn9qygyhsTzGKc+ilkwLlSIfRUfO3xSoGvTriaB+LgSyG8whS4UzMIQ8wLFo4ut6
 jy6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=J2/7QbpcaWm+SJuEJkw2PhTYrndQ4RQBuLVBXfxvq/8=;
 b=Os/BCF1viMAdUovQ8dJMr1UKGEbyGQvBoKIucilzU1AoTQLQrrOOAr6RR8S2G4UJaw
 uqaO0aA0xyUc+A6RLsdwKQJo3EgOc5Cbed55dlLqX84ZbKoBtBdfzwf4pDWZ//2VfoNA
 w9e6kY+VNuCRgokveHEClvToIunRSOFpT0XMbRSHNAx9cbEP/bVAKGcE+/In4UGyWfG6
 kltrLb0LDkdhSFbW9OKsN4CczH8LWb7xLDCzZRbQ9Yu5KBVff2fNsjcvTCErVGe9HWk5
 dU2SiR2T1BxZU+yYOMd+EtEuQmJaHDgT+TADPp0BhMItj/Tm+pMrKVnV8U3C32xDQHLI
 rNHQ==
X-Gm-Message-State: ANhLgQ1oqLrsKyT1WIhn+dna4AravgPeGHgw4AsDNn1q1DcZMkv6/xp5
 hl7IGHT2krJazZVTJ9jM9QAqJDm82M+RtaGsQgpYmw==
X-Google-Smtp-Source: ADFU+vsaqOrpWac4LsR9y6yWsz45OOgUvvTTB/bdmWU89+va8NUpqXmvJypGYMsIc2zmj8wdrhEV/eXFq9Pxc73+wB4=
X-Received: by 2002:a17:906:bb16:: with SMTP id
 jz22mr8807158ejb.246.1585245676778; 
 Thu, 26 Mar 2020 11:01:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200320123137.1937091-1-dnbrdsky@gmail.com>
 <158471180295.15515.1369533827289907154@39012742ff91>
 <20200323132556.GG261260@stefanha-x1.localdomain>
 <CA+ZmoZUFojqmMxNQ1bhGMzjML7OFgDt1GNbogGTw5rte5LD4iw@mail.gmail.com>
 <1b0fa063-6fe4-ad40-06b2-9c3f2f955a06@linaro.org>
 <04a411d6-72e7-d2d2-15f9-895f6a765d22@redhat.com>
 <CA+ZmoZXfrGh3+jnN4K-cfZitR+DVPL=ieZpTZGzH3cYSxko=eA@mail.gmail.com>
In-Reply-To: <CA+ZmoZXfrGh3+jnN4K-cfZitR+DVPL=ieZpTZGzH3cYSxko=eA@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 26 Mar 2020 11:01:05 -0700
Message-ID: <CAFXwXrkkOzuS=4Gfqm9XtkL5kc5m_5-9WmuziGgTfhFdm8VD0A@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] Replaced locks with lock guard macros
To: Daniel Brodsky <dnbrdsky@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::543
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
Cc: Stefan Hajnoczi <stefanha@gmail.com>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 25 Mar 2020 at 04:35, Daniel Brodsky <dnbrdsky@gmail.com> wrote:
> > There may be ways to rewrite that expression to avoid triggering the
> > warning on a 32-bit platform.  Untested, but does this help:
> >
> > if (sizeof(mask) > 4 && mask <= 0xffffffffu) {
> >
> > --
> > Eric Blake, Principal Software Engineer
> > Red Hat, Inc.           +1-919-301-3226
> > Virtualization:  qemu.org | libvirt.org
> >
> Unfortunately, the compiler still catches that the statement is always
> true for 32-bit.
> An alternative might be to convert cases like this to a macro instead,
> which doesn't
> cause any errors.

My preference is to add -Wno-tautological-type-limit-compare in
configure, so we don't have to work around this same issue elsewhere
in the code base.

r~

