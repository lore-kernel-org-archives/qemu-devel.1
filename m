Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5098AC2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 11:32:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C60A20B7C
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 11:32:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kNXz1H8x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C60A20B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48666 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZD6b-0002lG-BW
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 07:32:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37725)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hZC6U-0003gm-0d
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 06:28:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hZC6N-0007uy-3f
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 06:28:06 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:38099)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hZC6K-0007ZM-Oh
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 06:28:02 -0400
Received: by mail-ot1-x343.google.com with SMTP id d17so1376802oth.5
 for <qemu-devel@nongnu.org>; Fri, 07 Jun 2019 03:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=G9tZs+bbHaZ/lmZ1JR/IpholDSHvIsp+2x6edWyF+Eo=;
 b=kNXz1H8xjL98uHpfpJ6acmnrU75ougVcWUFTPSnaHq0PUGuZHE/oWVOwIYlrHFJ/Py
 06QOqscuMqxVklNHd4guo47rz9kVMNvZv9uZjqzkbW0gwmpSCDBS37BCrOBUe2I7PLJI
 X+pDKXcR6e9tO+x+ERZdQT6DpiVqCXBZhpMSSjkkWPo50PU64yEpWXM+Tl+Q1vVIWAA1
 hAveAs+sni6N0na81qrWnom7Tk8ef8qJZD1cE31Q7ETTvw+JKgeubAvJkGOLxzWEf+uR
 iKsWj1unI1rUjGDZKxFOKeaka2h4KDOwebKLWoEXWdvbMTJcntfryE/pWO4bNBBeYEKa
 cz2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=G9tZs+bbHaZ/lmZ1JR/IpholDSHvIsp+2x6edWyF+Eo=;
 b=tJ2EJn5noatZoiUYfZEcSwUTehtm10SqeCNpa3r2x4gApZ9gW/fTNuLSl9DNcyz7eh
 AzgTgSUvA19OfxN5ylCOVODLY/ZVX87HdeXarSthXxKXD+C9Bvj2cUvVBeH+YMSyw68t
 tUZOQ6mSIhsAqSf9Gyk6mUcLsiVoQHQsrKajIPr/dGda2L98c4/UtN33lqJPt+6NN0oe
 GnYmOdzQNO1Pl5hbcHrkidb0DEg0N4/wBTKotCDwayacMZvLyTiSdSqj9ZbcazxZvKD7
 vxdD4bUqVA9qREKPxj8R/USrLygqQHAMu5EERpRgsU/AoDxfl9xN2dOfGwQRMkST7N6B
 p24w==
X-Gm-Message-State: APjAAAV4kq4Or+ylRJGnKHqfKqgXC0a1VADFtQTB7O7nEDcldZWj3lv9
 wGb9+cxHk8bbjxdxNEnMLFQgtz4kpZcqqBXhS61soQ==
X-Google-Smtp-Source: APXvYqw1jIOLhNJJKC8gdd46tANXr45evzHRywmklo7jvPxGVcs2NML/lHasiMNzj2vwqni+TzTHy1/qKeGB2oBh8b0=
X-Received: by 2002:a9d:193:: with SMTP id e19mr18286788ote.135.1559903274367; 
 Fri, 07 Jun 2019 03:27:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190603214653.29369-1-jsnow@redhat.com>
 <20190603214653.29369-3-jsnow@redhat.com>
In-Reply-To: <20190603214653.29369-3-jsnow@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 7 Jun 2019 11:27:43 +0100
Message-ID: <CAFEAcA_ibRpZW1W6BgNXOJVORKOLwft5qPrBz6ekadOFPAZywg@mail.gmail.com>
To: John Snow <jsnow@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
Subject: Re: [Qemu-devel] [PATCH v3 2/3] sphinx: add qmp_lexer
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
Cc: Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>,
 Aarushi Mehta <mehta.aaru20@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 3 Jun 2019 at 22:47, John Snow <jsnow@redhat.com> wrote:
>
> Sphinx, through Pygments, does not like annotated json examples very
> much. In some versions of Sphinx (1.7), it will render the non-json
> portions of code blocks in red, but in newer versions (2.0) it will
> throw an exception and not highlight the block at all. Though we can
> suppress this warning, it doesn't bring back highlighting on non-strict
> json blocks.
>
> We can alleviate this by creating a custom lexer for QMP examples that
> allows us to properly highlight these examples in a robust way, keeping
> our directionality and elision notations.
>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> Signed-off-by: John Snow <jsnow@redhat.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
(mostly reviewing the sphinx config bits -- I trust that
the actual lexer does what it says on the tin :-))

thanks
-- PMM

