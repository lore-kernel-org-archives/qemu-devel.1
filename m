Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64481C3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 09:13:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EA8C233A0
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 09:13:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S5jV9A7I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EA8C233A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i15d7-0006VT-66
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 05:13:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50010)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i15bw-0005kf-Jh
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 05:11:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i15bv-0005Q0-H1
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 05:11:56 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:41646)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i15bv-0005Pn-BG
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 05:11:55 -0400
Received: by mail-ot1-x342.google.com with SMTP id o101so8126031ota.8
 for <qemu-devel@nongnu.org>; Fri, 23 Aug 2019 02:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=gk8uTeXlvmyFUsG2SonNSYAtqUpOgVSqq22OjL6pwCI=;
 b=S5jV9A7I0/p5u2/ln+ASlYskP+aQyHtf/QT0Gtu7BECt1gp5FDShnyfsTI0aoDflWn
 HnjRyoDn4eophkcGeTxUAWnh276DgDGTNFm6EqOEYlO8EZaiIOCy1hdpsIaWhmiIEK3+
 9iRXi3SapS5C8DovTuM5I4eLytYBaAxwGC3zMfIS8lI2AD/lN3hduqR96r9HvNUUhWz7
 fL1yprM+cf1VieypPyDLMDatfc5x/DKNbYhlx2tqzSO2w0/YCAWx+e65piYUam+3FbAa
 CtCahyyfF/eyqVGPx1EA6Zw7iZtD3vKu9rTlV7eW/3J1eQ5KeKoysjAp+fRwK5ScyVdP
 bhmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=gk8uTeXlvmyFUsG2SonNSYAtqUpOgVSqq22OjL6pwCI=;
 b=mt7llDw4VK1Hz8OOnRrpuClfYe2DGR9GZwE4IQd9lD46kbdvKYCJpEzRoYxC8omO5Z
 eKQpZYJ815Nq+N7cirx+XTujD1pOKD43kOAVCf2CmSEQrGNInlICZMAf/4c/tsL325U3
 v7rsWRiMpyiXcHb9lpR+mzItuz/4uZ8/KhWCvOQZz8gVKrh3IX1MKdgmGitEItOvhi5n
 IGpxo6m4fCXthhQObUZ7KPW4LZzz1O2UIbQ+0oKcVAo8nkgoBP9logzqQBdNaVi461tS
 oijBE93iED8Zz2heZIBBUue/y2aroquZ6roD3jmDs25FCEf4LdezrDbizJLSts0whJc1
 QYuw==
X-Gm-Message-State: APjAAAWJHzgmLd5Nu5jvHB3suiGK3g5hnBetIP9m1ypW0/kwu2t797Dt
 nxn/zYw40sQuZa8Hv1d6aixt0aXaQTF/PsNdYeZcgA==
X-Google-Smtp-Source: APXvYqwiMBaQjRlReB6HKt+EuGaH8qCYAaImEZX9PMByn+tcvOEwvCFgSgVmqPJWq/dgkxL44J87magkFpMqTazbSoE=
X-Received: by 2002:a9d:4817:: with SMTP id c23mr458447otf.97.1566551514361;
 Fri, 23 Aug 2019 02:11:54 -0700 (PDT)
MIME-Version: 1.0
References: <1566495734-23297-1-git-send-email-pbonzini@redhat.com>
 <9492af41-2125-9543-203a-312f0cd9087c@redhat.com>
In-Reply-To: <9492af41-2125-9543-203a-312f0cd9087c@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Aug 2019 10:11:43 +0100
Message-ID: <CAFEAcA__BNnW4oSyv4iTAd7rsMUfcjyNJgk0nOwbkRQtmLj9jQ@mail.gmail.com>
To: Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
Subject: Re: [Qemu-devel] [PATCH] modules-test: fix const cast
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 23 Aug 2019 at 10:06, Thomas Huth <thuth@redhat.com> wrote:
>
> On 8/22/19 7:42 PM, Paolo Bonzini wrote:
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > ---
> >  tests/modules-test.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tests/modules-test.c b/tests/modules-test.c
> > index 3aef0e5..a8118e9 100644
> > --- a/tests/modules-test.c
> > +++ b/tests/modules-test.c
> > @@ -4,7 +4,7 @@
> >  static void test_modules_load(const void *data)
> >  {
> >      QTestState *qts;
> > -    const char **args = data;
> > +    const char **args = (const char **)data;
> >
> >      qts = qtest_init(NULL);
> >      qtest_module_load(qts, args[0], args[1]);
>
> Why did nobody notice this before? ... some additional words in the
> patch description would be fine.

It got into the tree because I don't have an --enable-modules
config in my set of things I run before merging. It's in
the Travis build set, but that only runs after the fact.

thanks
-- PMM

