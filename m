Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B164BC352A2
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 13:37:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D66C214AF
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 13:37:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ne83/KJU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D66C214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56490 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j03pC-0004i7-Lt
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 08:37:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33893)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j03oJ-0003dd-RY
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 08:36:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j03oI-0000w7-KN
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 08:36:43 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:43144)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j03oI-0000tb-EE
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 08:36:42 -0500
Received: by mail-ot1-x341.google.com with SMTP id p8so2119814oth.10
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2020 05:36:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=mFKOQXnbjPCOHC53DmP31TRPNZG4/glAvd2SjGayMKQ=;
 b=Ne83/KJUTxzMZeVvAeY1MQdKNafUoc354vYjf+6GvKHmOObKHGVh/UbNaRXhsA9Ffx
 wxC99Rmhe+2PFbT+O4evSXYQgVPMIeqSOck0ewEgWmOuJh8iu05pMyN0tQVTLz4IVXmv
 P3Z5xSySKsApeVYIm7wDCyed+ZNSM77TjI5EX/JyZNFVSCmDn/ES5gSg3f2ofG4pnzNC
 cqCnj0dX6Pleh+jNj9JemLVu4qF8H1bKtmVTWkPENlj0jyR+hbMSeI0Vlf9QtD+SX1sA
 nIvQjWBcvlNzVa0n94ZCWkc1Fyl5c3ABn9YkyzbhW6mL+rYt7F9nl26/OwuYvHbhQIqy
 VH0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=mFKOQXnbjPCOHC53DmP31TRPNZG4/glAvd2SjGayMKQ=;
 b=i47CKRRwEKKbxgxxnahn/uiWyqwvuRIWOQKAbLXLHWlRDjXEiTJ0BAf+QOpFOMENB1
 S2tzPsSY2UWa7QV3uh9h6PIsWGdDZx0VSk2ARoPUrb4M9eyNmIkoxMfJeSUK9I31Yq+k
 9lMPORUbd/0vXkwtqSoFokeuS47UGyXO0qzAR4q2RW5yvn6mwdRRcjp4pxcBQq0iV4vX
 h8WIE9aUPE4LC3i5cq9RB2hJuDXsPNLiuCiSboZ53VXmZ5YXoPvYFETQF9i9i8rXX31L
 sSV/z8k+wMtLl9SD9EXQZWrNU1hEeiPvHqEmaWp/n5de6n200IvDmFmW179OdNlDzvzc
 Vy/g==
X-Gm-Message-State: APjAAAUq5OwuSn3P2qk8WQtL54fp4X5ZOLgJkEcKiDuSxFYqO4QDO6NN
 WkF3B8vj3hEgu+W1bzfG80Oc+1/+lKZPmRsF+zcpRA==
X-Google-Smtp-Source: APXvYqx9NUOLcLAfbtehD1A3zkAZTRwB9DkoJZM4BB7PIadya3BxoP5k8UWCfohLhpOt/PkQbKW/EmKztwAlYBOOkk8=
X-Received: by 2002:a05:6830:13da:: with SMTP id
 e26mr2543438otq.97.1581082600069; 
 Fri, 07 Feb 2020 05:36:40 -0800 (PST)
MIME-Version: 1.0
References: <20200206225148.23923-1-philmd@redhat.com>
 <20200207082643.m7pkyjbx5h2o4zh7@kamzik.brq.redhat.com>
In-Reply-To: <20200207082643.m7pkyjbx5h2o4zh7@kamzik.brq.redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 7 Feb 2020 13:36:29 +0000
Message-ID: <CAFEAcA_yEgCtTR3MJ6-co0uHbckUkvduHFi3yiqYV-N-M-ZUUw@mail.gmail.com>
Subject: Re: [PATCH v2] docs/arm-cpu-features: Make kvm-no-adjvtime comment
 clearer
To: Andrew Jones <drjones@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 7 Feb 2020 at 08:26, Andrew Jones <drjones@redhat.com> wrote:
>
> On Thu, Feb 06, 2020 at 11:51:48PM +0100, Philippe Mathieu-Daud=C3=A9 wro=
te:
> > The bold text sounds like 'knock knock'. Only bolding the
>
> Who's there?
>
> > second 'not' makes it easier to read.
> >
> > Fixes: dea101a1ae
> > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> > ---
> > v2: Removed unrelated hunk
> > ---
> >  docs/arm-cpu-features.rst | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/docs/arm-cpu-features.rst b/docs/arm-cpu-features.rst
> > index dbf3b7cf42..fc1623aeca 100644
> > --- a/docs/arm-cpu-features.rst
> > +++ b/docs/arm-cpu-features.rst
> > @@ -185,7 +185,7 @@ the list of KVM VCPU features and their description=
s.
> >
> >    kvm-no-adjvtime          By default kvm-no-adjvtime is disabled.  Th=
is
> >                             means that by default the virtual time
> > -                           adjustment is enabled (vtime is *not not*
> > +                           adjustment is enabled (vtime is not *not*
> >                             adjusted).
> >
> >                             When virtual time adjustment is enabled eac=
h
> > --
> > 2.21.1
> >

Applied to target-arm.next.

> Not-Not-Reviewed-by: Andrew Jones <drjones@redhat.com>

:-)  but for the purpose of the commit message I've dropped
the 'Not-Not-' prefix, since we want to have a standard set
of tags in commit message rather than a random accumulation.
(We really should make checkpatch warn about nonstandard tags.)

thanks
-- PMM

