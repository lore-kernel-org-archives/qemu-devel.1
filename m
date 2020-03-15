Return-Path: <SRS0=WIOf=5A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A5CCC10DCE
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 18:39:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40B7F206B1
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 18:39:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pPrcmkrz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40B7F206B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56988 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDYAn-0005vr-AL
	for qemu-devel@archiver.kernel.org; Sun, 15 Mar 2020 14:39:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41789)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <beata.michalska@linaro.org>) id 1jDY7F-0004pg-1S
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 14:36:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <beata.michalska@linaro.org>) id 1jDY7D-0001IH-UR
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 14:36:00 -0400
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:45216)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <beata.michalska@linaro.org>)
 id 1jDY7D-0001Ae-Os
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 14:35:59 -0400
Received: by mail-io1-xd43.google.com with SMTP id w9so14864922iob.12
 for <qemu-devel@nongnu.org>; Sun, 15 Mar 2020 11:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=c6rvGe6qiS9edty2AHSQkpLqwQdVmf0ROJL+Sl14+QA=;
 b=pPrcmkrzdcHQTPq55B9yoiAh8RYJbva9CDfetb/a/JiRGBo3MVMoQHYrO5MBPxJaNg
 VyNeCK9wTgW6572156e2NbRcnEaL5D/oBlMuejCAQZX1aBPOxPWK1kcK6v8z5d5zr8ih
 vXc5C3FF52nGEaFg8C71vLEabHJDmJVsBkAa6Z8ACPioqR4b/FCTEJvHJ25Md3UGa8Ah
 2D7DGAmyJgi/4rzghZhcfPyEzc6G+jfQx+voUNSfFDq9GmD37ZGCxM6EzE8HKFatE6dY
 hEpGyUfQEkxN39rExvyyVMSPQZq7mlTaGlmTuZJHfW9+QA5u+3w6sIOeEZBDRfOF3XNo
 gQhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=c6rvGe6qiS9edty2AHSQkpLqwQdVmf0ROJL+Sl14+QA=;
 b=NjB8Cz7YnjpEWaZFAmly1PufSuA8Z6PiLZjtTZQ6V3++KJGkY6ChBCNDDRSm1+U00f
 zzUDM1sXy2MkqCNcsE5sfb/5GCgTjAm0u5Bgakn305q8KAxcHquK+yjb7e+65UoVndJk
 4gdR9plCqXTrKm2QQmA+4FZYMdxyQDp9GWPjywXpsdWybsnoDp3pTCjnveo2MZGKjfdd
 9luEOdEU2oMIrYOAYGXnq8y7YiF9rzP5QPPFJfW7aQk72KmFvTzAI3r8q7NxPblO2Mxe
 R9JvAhgJr3P/+D5UmMLdGQPWsXpLTDrAGP6nhX545O8gFKQcNGhRo0QCxgwi5B8zjeRf
 l/Ew==
X-Gm-Message-State: ANhLgQ3CYmWwzwLDLOyfjqEa54RH/WXnndeoSBX0RTiWYj3ztc+cT3iU
 m2Z6pKlbXvekg52bCd5X7jaJquhf/4rQ6anM+m9J/g==
X-Google-Smtp-Source: ADFU+vuN2xGw3Yo9Y0hRVQ6IxMH7tUTZtyjNfgim+GPkr7Ppg+3AD/qi6U+ErJMb4OaNOV4p/4PVJi9euN7xvJlaAgU=
X-Received: by 2002:a05:6638:102:: with SMTP id x2mr5910753jao.5.1584297358066; 
 Sun, 15 Mar 2020 11:35:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200312003401.29017-1-beata.michalska@linaro.org>
 <20200312003401.29017-2-beata.michalska@linaro.org>
 <CAFEAcA_5avBsNJUDh6o8vGfm4DGcFA-iT-UNG5h8M+hPDOif9g@mail.gmail.com>
In-Reply-To: <CAFEAcA_5avBsNJUDh6o8vGfm4DGcFA-iT-UNG5h8M+hPDOif9g@mail.gmail.com>
From: Beata Michalska <beata.michalska@linaro.org>
Date: Sun, 15 Mar 2020 18:35:45 +0000
Message-ID: <CADSWDzuUC70uNyv5Gad2tC47wHS4jC5Lm7u-hu1fa=raKQXFHQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] target/arm: kvm: Inject events at the last stage
 of sync
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d43
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
Cc: Andrew Jones <drjones@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Christoffer Dall <Christoffer.Dall@arm.com>, qemu-arm <qemu-arm@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, kvmarm@lists.cs.columbia.edu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 12 Mar 2020 at 16:33, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Thu, 12 Mar 2020 at 00:34, Beata Michalska
> <beata.michalska@linaro.org> wrote:
> >
> > KVM_SET_VCPU_EVENTS might actually lead to vcpu registers being modified.
> > As such this should be the last step of sync to avoid potential overwriting
> > of whatever changes KVM might have done.
> >
> > Signed-off-by: Beata Michalska <beata.michalska@linaro.org>
>
> Hi; I'm going to take patch 1 into target-arm.next since it
> seems worth having on its own and I'm doing a pullreq today
> anyway. Andrew's given you feedback on patch 2.
>
Hi,

Thanks for that. Will drop this one from the next version of the patchset
once I address all the comments.

BR
Beata
> thanks
> -- PMM

