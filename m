Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7A58FA372C
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 17:14:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85E6220673
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 17:14:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vWl9oRKq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85E6220673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57974 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT7pz-0005Fr-Fn
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 12:14:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39763)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iT7mq-0002vx-GE
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 12:11:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iT7mp-0002xt-6C
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 12:11:04 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:37519)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iT7mp-0002xc-0B
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 12:11:03 -0500
Received: by mail-ot1-x344.google.com with SMTP id d5so5817184otp.4
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2019 09:11:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=mnalJx4H7+m/gSnRqRgd6jzyL97VfmT3+CQtQppxItA=;
 b=vWl9oRKqH9BvBjJwegeaDDYe1gHbJV7c4uXSC/eAox4LxcYqnDg17y3EPVL0umWtek
 kzLz0crhgqK9Rn/kItlcBbbR6D9X3i/DwapfoPsKt6G5u82gLfSumbrx0bqPoSr2yrOE
 AYp/jtgLF78PIiWA2U4yOIy6v0gj2pez6925/GORFJpW8MIHx4eQiZus8Tc+9M5OsjPF
 pUzjm2jF34lDMQMLmMLxVJh+65vj8GelDxKszM9y0gDKZjNXcu6/n884/jq+MKhEUWrI
 Zm9YYXw6OFueBiO0g99xCDArjaCparfKHjCI2b7Bz3tMKrsho48lYt/HSAGGXtz5840F
 BQZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=mnalJx4H7+m/gSnRqRgd6jzyL97VfmT3+CQtQppxItA=;
 b=FlMHrCLsZGZbWQLoNeOhXhsAjUv5NeOKZO+1p752PEuXOtkdQETA1nme6PBVlb5d6H
 kECU6RFYTzRD8aSa4jcAgn5IiTSH8p7e8rMeCc+KHcvoT1V0V577H7OnWhJKcuV2Tqrk
 3BH/9ho+f9b0jG4rz/HV7AjFkai2BENmJZCTSB0tBEHG15mlPYnSPM4CQDaMkug9Kyrg
 Wado6Aw0LBkDkwsgVXowF54yybmPJEKQtcV+R/N2nJCOrg58VRW834aY2hJglNH4oC81
 /LyEZfU+KUt1P/8Plp0OVUqjPxpk0o/0V99h56H/MxoT0+R4c377hzazM7Se00thfksi
 dDIA==
X-Gm-Message-State: APjAAAU4hayFUChvgj+RtmrplYiRrAxSHEl9OY3R6nGYwTo7qJDwhe0B
 oY74qhZUt0ALJw8/ROd+Nbsl/j8tM4F0K36R4iHdvINWQYs=
X-Google-Smtp-Source: APXvYqy0x/mWqnLFvbmckS7rUPfeqSOnUktV77TWLR8MK3xAF3eS7ywry2xUnlQh+zI/z1LANrL1YKX51SvQ3e+iRhs=
X-Received: by 2002:a9d:68cc:: with SMTP id i12mr5771433oto.97.1573233061926; 
 Fri, 08 Nov 2019 09:11:01 -0800 (PST)
MIME-Version: 1.0
References: <20191108102805.8258-1-philmd@redhat.com>
 <862eb773-609d-4250-b46b-d922fc5a86a7@redhat.com>
 <00cca0a5-7a51-f2d1-5120-821c335954b8@redhat.com>
 <51f9b2d9-b196-c30e-dc67-988e29b5df47@redhat.com>
In-Reply-To: <51f9b2d9-b196-c30e-dc67-988e29b5df47@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 8 Nov 2019 17:10:50 +0000
Message-ID: <CAFEAcA8EijZRqhFerQbq5cCbaq-qzrMzOrQjc6Ro=v2p6=W_pA@mail.gmail.com>
Subject: Re: [PATCH] configure: Check bzip2 is available
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
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
Cc: Thomas Huth <thuth@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>,
 QEMU Trivial <qemu-trivial@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 8 Nov 2019 at 17:07, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com=
> wrote:
> On 11/8/19 4:43 PM, Eric Blake wrote:
> > bzip2 is no longer a favored compression.  If we are trying to pick a
> > compression that is most likely to be present on any system, go with
> > gzip.  If we are trying to pick a compression that packs tighter and
> > uncompresses faster, pick xz or zstd.  But bzip2 does neither: it packs
> > slightly tighter than gzip but has slower performance in doing so, and
> > thus is no longer used as a default compression.
>
> The problem was with OpenBSD 6.1 which hadn't xz available.
>
> In commit 12745eaa02 Gerd updated the VM to OpenBSD 6.5 and we now have
> access to xz. IIRC OSX supported versions also provide xz.
>
> If we want to revert Laszlo's patches and apply his first version (using
> xz), we should do that during 5.0 dev cycle, now it is too late.
> I'd prefer we simply fix bzip2 for the next release.

I don't think we should try to use 'xz' because I don't see
the point. We should use something that's generally available,
whether that's bzip2 or gzip. Life's too short to deal with
yet another file compression tool and format.

thanks
-- PMM

