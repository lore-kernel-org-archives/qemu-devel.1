Return-Path: <SRS0=3HrQ=6A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FB60C2BB55
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 17:10:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59D082078E
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 17:10:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pBrubWH/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59D082078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37260 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jP825-0000r4-F2
	for qemu-devel@archiver.kernel.org; Thu, 16 Apr 2020 13:10:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35426)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jP81G-0000D3-Qj
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 13:09:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jP81F-00060J-7a
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 13:09:42 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:44463)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jP81F-0005yH-0T
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 13:09:41 -0400
Received: by mail-oi1-x241.google.com with SMTP id o25so17138933oic.11
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2020 10:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=AKgydUrU/Fn6ekzsFFMFlZAQx+wS1FvQ4F+WPYEsmCQ=;
 b=pBrubWH/FpA51fTOOuhPtGpTBglxmdF66+LaYPT+MwDKNvoOnysuEeL5yTAO2v6lTy
 Stj/4QwKspwgPQqjm6VwqWNgXNhB/CFEyM27kmSlCqHIOAnY02iOeO4U3y+sBHV9ulbU
 /bFHQg8Z5AmVQb801cnaDzQyn4NbMEMBm5Fk3RMhiIzxSIKfbUXn25SbCA0AL2CKwlQu
 zlUzuB0yye81/OcQlVmn2ks/NP+uLibg4YhOxULKBXNvo2ldZuQNVOxYzhTV+re4rvqN
 tRi3K4R/BOBl+iyIRYTO5w+gfSfgus2PxYxUtiYTU481XYTnIH/gRHrXuSJ8BR37Zul8
 tnQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=AKgydUrU/Fn6ekzsFFMFlZAQx+wS1FvQ4F+WPYEsmCQ=;
 b=AGo2lencYLzjWPYhhs0dXGN/3wtpIEU9xq/5YoOKOaRGIKCqH57sEkf6jAsuac+2fV
 NZVCbjQ17JGqx13FU3ZZuLHLWrzJdab6wkqpVVCvPPSqxMPMHnb2ywyl1Yi8JAxjn3yP
 ER+l/XYXlPYRE+mrEZVUg+DMTSSKJItGS3YTcHleTnywQfDFJvVyrbJ6iIOfZY15NhC+
 GZEjxkGDuEbwhpbOroFkxZCwLr6N8OgGDJMTmbeQQ7Lh4TFjYdDKcCX9eVhNqAcKlewC
 j/gvEu8YxXO/l4186o8ggba/yHOxRQDgBS8EXeok76ST27grMGe5ZNK+LH26TqgFHgRy
 EbWA==
X-Gm-Message-State: AGi0PubOUk+5A30LqZlpGuldcWw+a06LLZPYnyWNxtVtnTgzMH9/Bwd/
 AykUaMqmIaQfLmYh6gFOe22sf3q+WeK/epxtXF42Kw==
X-Google-Smtp-Source: APiQypKYye+QGhCYqv3OCe+Td0OPQbemKS3X4z6ZnDLtOrJfF6bmjaDQaYsvPhGqC3XUcbIXxNXFsOyhCg22a7mBOgM=
X-Received: by 2002:aca:dc56:: with SMTP id t83mr3435815oig.48.1587056980016; 
 Thu, 16 Apr 2020 10:09:40 -0700 (PDT)
MIME-Version: 1.0
References: <51b427f06838622da783d38ba56e3630d6d85c60.1586925392.git.dirty@apple.com>
In-Reply-To: <51b427f06838622da783d38ba56e3630d6d85c60.1586925392.git.dirty@apple.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Apr 2020 18:09:27 +0100
Message-ID: <CAFEAcA-YmjVq_CRyKySOHrfXU7z=1Myi7zPFAW-HGUkoB4t1=g@mail.gmail.com>
Subject: Re: [PATCH v2] nrf51: Fix last GPIO CNF address
To: Cameron Esfahani <dirty@apple.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
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
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 15 Apr 2020 at 05:37, Cameron Esfahani <dirty@apple.com> wrote:
>
> NRF51_GPIO_REG_CNF_END doesn't actually refer to the start of the last
> valid CNF register: it's referring to the last byte of the last valid
> CNF register.
>
> This hasn't been a problem up to now, as current implementation in
> memory.c turns an unaligned 4-byte read from 0x77f to a single byte read
> and the qtest only looks at the least-significant byte of the register.
>
> But when running with patches which fix unaligned accesses in memory.c,
> the qtest breaks.
>
> Considering NRF51 doesn't support unaligned accesses, the simplest fix
> is to actually set NRF51_GPIO_REG_CNF_END to the start of the last valid
> CNF register: 0x77c.
>
> Now, qtests work with or without the unaligned access patches.
>
> Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
> Tested-by: C=C3=A9dric Le Goater <clg@kaod.org>
> Reviewed-by: Joel Stanley <joel@jms.id.au>
> Signed-off-by: Cameron Esfahani <dirty@apple.com>



Applied to target-arm.next for 5.1, thanks.

-- PMM

