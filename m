Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1445BC43331
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 18:23:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0107206CC
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 18:23:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pUV9AdwS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0107206CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59478 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKQy7-0001gJ-W5
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 14:23:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46824)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jKQwY-0000iN-Aq
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 14:21:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jKQwX-0004K3-4L
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 14:21:25 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:42017)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jKQwW-0004G4-0H
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 14:21:24 -0400
Received: by mail-oi1-x243.google.com with SMTP id e4so6917107oig.9
 for <qemu-devel@nongnu.org>; Fri, 03 Apr 2020 11:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=vLKZheo+falulKlRLT42MgwKmcgpnY7d/Pc4nfpmDwA=;
 b=pUV9AdwShAwVdqMEZqxP+ABC/F13Xx4BPA2BIfm6ZQzMPPsK+yRsSzvmTNExIFFJ/n
 7xq8AOEM0ea6F/OIaiPM8aFwAeu9Nzd0so0FMrdTMITApuxLwWQMnf+F6AJa77/pz4NE
 t35MnQHUI0+8qh513b0CwxFef7E2cdEtomgtpAFpI4/lyfB9qNyIzVXyvNxaPOq38V5M
 obN877/wuI2XnQ+vKAJDXZ/08C+gRuD7u4kBJB1L7Dp/VMXbArwGdT9cU9rgpFoExPQC
 1Y3UwpVqq8N5NnoaPWrT3SVFTcsrzF1VslK+zkJRgnw5liUgH/NIyZ3RsMd8b5sGLgoa
 I5pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=vLKZheo+falulKlRLT42MgwKmcgpnY7d/Pc4nfpmDwA=;
 b=AvKqBKMtCuFQGGNcI6Jfy1ZLQ/cFTN+9JfkC6GZcsuGjwA6oqE0HYV7kpM+jGGF4YN
 JFsjDTjw+X8gUGw3TfncMZ+9KaVexj30+AWsEqZtY9NnVbhLIav5VlEzYlHpaAQdedvW
 jagU8PvVoDBeKA9G8r09YZJmSS8pgcy1EC0Mcn7aXcfzCuEaCl9B1dqew/Nlj9mLN6jY
 p0BysFqsMbxU7dTuvZzr1q9JotoyUqxU8lO2iI/v5tgL2c7uZhy/7mi2dyH3i4DCbhow
 RqDyEWQfT1QTiyQ7NmNsWUv2RBibBPFIRFBi5Y63ByPMIvlV9dbWEBMN8RqrXcSG25N9
 1R1w==
X-Gm-Message-State: AGi0PuYMa3tR7/8j3vmBEkJrbsKVh+RdN5BLSrJLr6yuuLXy1arqkdkg
 o04NaRgRsirAbnMZ4zgJj45141k7uOJv0nZL2ecxWw==
X-Google-Smtp-Source: APiQypLyQw/2tJEt/8xBo04I3bvvfux/6I3Fd9A1BiSS3Ca8jwdvvHPqBRDEA8gssM375AdOcMbs1wgno9iy7+OPDP4=
X-Received: by 2002:a05:6808:8cb:: with SMTP id
 k11mr3876593oij.48.1585938082922; 
 Fri, 03 Apr 2020 11:21:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200402143913.24005-1-alex.bennee@linaro.org>
In-Reply-To: <20200402143913.24005-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Apr 2020 19:21:11 +0100
Message-ID: <CAFEAcA-pw+xJnsxhG6N2ibWH0K2McqGQnJ_b5qAzWBa+TV8z4Q@mail.gmail.com>
Subject: Re: [PATCH] target/arm: don't expose "ieee_half" via gdbstub
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 2 Apr 2020 at 15:39, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
>
> While support for parsing ieee_half in the XML description was added
> to gdb in 2019 (a6d0f249) there is no easy way for the gdbstub to know
> if the gdb end will understand it. Disable it for now and allow older
> gdbs to successfully connect to the default -cpu max SVE enabled
> QEMUs.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---



Applied to target-arm.next for 5.0, thanks.

-- PMM

