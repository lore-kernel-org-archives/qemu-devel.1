Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81C6AC43331
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 11:36:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F22A20722
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 11:36:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uVvlVbOn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F22A20722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34678 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH4KF-0005bJ-EM
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 07:35:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41817)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dnbrdsky@gmail.com>) id 1jH4Jf-00051i-72
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 07:35:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dnbrdsky@gmail.com>) id 1jH4Je-0002Op-Bh
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 07:35:23 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:41876)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dnbrdsky@gmail.com>) id 1jH4Je-0002Nd-65
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 07:35:22 -0400
Received: by mail-pf1-x443.google.com with SMTP id z65so910891pfz.8
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2020 04:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=rMzR1GEXMuRQsaQxhF25bQPDBXQhUi2zqmJpslcRFeA=;
 b=uVvlVbOnDoQC8Ofm961uosu2BiAW5GWZejGGasmXYPw6ltxIkBw5Di4+rl9HtXStkw
 zQbYSBgyuDD5eN0mqMCEoqYX2O+r/H+RfyIHE3X9q+jB/ue6v8lKn2ZWRMpcbICOzM8T
 CYRPcJhOEyKJ2V7lHyhmE3Z7fXqFLj2GUmRZHqi7g2MNdNRdjxIT4r77OEgFYDQisbSP
 gGvsxdf9kX+Cy9ZMwa/g3x1yXD4aSaGzrWO+FBhgdQhO6vwbPJ71J0KT/yp6fuO7Bc/c
 bsdZDUBovh1FnIaRl50T06QP8d68g37IPXiQX+zl8+S6kUVhPkHrGWswMtrQZGAocUhw
 GUXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=rMzR1GEXMuRQsaQxhF25bQPDBXQhUi2zqmJpslcRFeA=;
 b=SEKPILuFc5Hxm4v/voVNXJhgvUDmfMdKTyzFK7vvlKg7wJnBps0V7vcsAqmMA4wCiJ
 sseasqRSbD7zkSojdUjnxsdw2n/hZepOwAOJVszMh4VLyq96cG83Pg2x04uWjzf2T1Gb
 5RXKobi+/yfbJjb1XIHgE0RZK9UZEh72VDN4kSBMbJjksOmTtNBkaLPUErR1UxqwMdad
 3+OtZ+Xt67GarxTOru0WwWJBXnkSwdvhIZsIs7TBt43SxCmLG04pZd9E/SaGeUm4mZgU
 Q0Pi4yFn5iGjzTqovmmb+dAPsT5Ep8jOaIDtaoB5Kvfgd8LLWHQDcjc4mWthGz0endG8
 X1ow==
X-Gm-Message-State: ANhLgQ0Xu9WxEJpx/fKgdecGfBoOQHst5naHCX3RUsBJwRPrCqp3u9WX
 GdF2NYg8SQKxEHAPoLqIIXVyH/3ryZP6VanVsFc=
X-Google-Smtp-Source: ADFU+vudXhfX+9+boQSvYoWpBR3/S2NJT8UJ8U9Nc/J9TT429YgLTHPHeq9kQsLjyx0jOr7YTQ0g/qqk8/RkcG1Qvso=
X-Received: by 2002:a65:6558:: with SMTP id a24mr2839833pgw.220.1585136120612; 
 Wed, 25 Mar 2020 04:35:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200320123137.1937091-1-dnbrdsky@gmail.com>
 <158471180295.15515.1369533827289907154@39012742ff91>
 <20200323132556.GG261260@stefanha-x1.localdomain>
 <CA+ZmoZUFojqmMxNQ1bhGMzjML7OFgDt1GNbogGTw5rte5LD4iw@mail.gmail.com>
 <1b0fa063-6fe4-ad40-06b2-9c3f2f955a06@linaro.org>
 <04a411d6-72e7-d2d2-15f9-895f6a765d22@redhat.com>
In-Reply-To: <04a411d6-72e7-d2d2-15f9-895f6a765d22@redhat.com>
From: Daniel Brodsky <dnbrdsky@gmail.com>
Date: Wed, 25 Mar 2020 04:35:09 -0700
Message-ID: <CA+ZmoZXfrGh3+jnN4K-cfZitR+DVPL=ieZpTZGzH3cYSxko=eA@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] Replaced locks with lock guard macros
To: Eric Blake <eblake@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
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
 Richard Henderson <richard.henderson@linaro.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

>
> There may be ways to rewrite that expression to avoid triggering the
> warning on a 32-bit platform.  Untested, but does this help:
>
> if (sizeof(mask) > 4 && mask <= 0xffffffffu) {
>
> --
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3226
> Virtualization:  qemu.org | libvirt.org
>
Unfortunately, the compiler still catches that the statement is always
true for 32-bit.
An alternative might be to convert cases like this to a macro instead,
which doesn't
cause any errors.

