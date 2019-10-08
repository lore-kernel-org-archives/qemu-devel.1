Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F35EC4360C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 14:14:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCDB52064A
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 14:14:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DgLF8s6y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCDB52064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56230 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHqFU-0004jk-RA
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 10:14:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47283)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iHqA7-0006r1-Bf
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 10:08:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iHqA2-0003ja-DM
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 10:08:27 -0400
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c]:36684)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iHqA2-0003jT-73
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 10:08:22 -0400
Received: by mail-oi1-x22c.google.com with SMTP id k20so14904349oih.3
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2019 07:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=DaK4LFhDMurmiD/03hY6fQL9Kpa5N1Imhd3ePMwymoM=;
 b=DgLF8s6ysngRTKkE6pDNWG40ck+VwORjW/+Xx0pB9JJU7ymfIUMQR0YMF9JiofgGb3
 B4lYhQEGKRIsgJk6m3GMU/DZY9ZGi8kTh5TKLYzA7ocTRbo3Fxk7XD4DFGNMObdq2eHI
 BjSltVve2qMj7MHhcrPOY6iWR3JhGH7rjsbaIc4FdW24UJ8UUfytD2Ymc9xhtOrV+Hbh
 YfARTjrOw1MrihFztb79LuKTIhjlMfgKjW/5FAJvvXdK26VfPzen0Lt6v8B/c2dMs41g
 41YLAc0FC8k/DMBv3q7xMrWJXa4fEch7zZZz9NptnpHeMGroKAyOk7mX9hmLViD7oXZF
 IR1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=DaK4LFhDMurmiD/03hY6fQL9Kpa5N1Imhd3ePMwymoM=;
 b=S+xzrV45nlVtNuQ1mXECS0jjLkcxA3UtiG0rcCTFmyF2Jux/+Ibr+gkSb7xLd8N+fi
 SuVBlPR2dSiQF9SV06DyvKYm6+1xs7Klw0aAW5d5d+YM9YYjyDEWfG6T9rzrXK0zEOid
 jhS3GZszKpkQlslICnM0iobnb31VfZAirun2Ezo+PxQvyPnPMptYsvb3UkU1M2JqJpWt
 wwoZnMFeQU5l+1iT4nwAgD1V/cISRUOq3+bfd46WzrP0goXKSg3Fn5tUuD2Q36Zas8wX
 gquyQQA66x9Ge0GaIdx7J+p/pUT0TOlOPsyaCn0KGjbksqSpR7ktq4/T1Nj5UZ5jxjLv
 /xcQ==
X-Gm-Message-State: APjAAAVnK2ilYZpuSUF5NJKiopT7VScfAzVqCtd6f6NJ5o9wVWx45rw/
 ZyNCQxEzUrNH7xQaTK2sdvJVyFeBwyWqfNLDT8DfBpS3Ays=
X-Google-Smtp-Source: APXvYqwZ8c0hK8JzGRNqEM31Q4u4Lk8mpCnSyI5cVt+uf7iyAH0snNUVfQwDImhVkLRG6e9ATVUfm6WZm7ZZK1Df5io=
X-Received: by 2002:aca:b646:: with SMTP id g67mr4087596oif.163.1570543701400; 
 Tue, 08 Oct 2019 07:08:21 -0700 (PDT)
MIME-Version: 1.0
References: <20191007133540.30623-1-philmd@redhat.com>
In-Reply-To: <20191007133540.30623-1-philmd@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 8 Oct 2019 15:08:10 +0100
Message-ID: <CAFEAcA-+WMMgP36i4XBrRXhs+-nBna-ruZmyhGdn0wY0RO479Q@mail.gmail.com>
Subject: Re: [PULL 0/5] edk2-next patches for 2019-10-07
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::22c
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
Cc: Laszlo Ersek <lersek@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 7 Oct 2019 at 14:37, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com=
> wrote:
>
> The following changes since commit 9e5319ca52a5b9e84d55ad9c36e2c0b317a122=
bb:
>
>   Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into s=
taging (2019-10-04 18:32:34 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/philmd/qemu.git tags/edk2-next-20191007
>
> for you to fetch changes up to 037973bb0d2b1a3c8618ccf41caa4da3666588c3:
>
>   edk2 build scripts: work around TianoCore#1607 without forcing Python 2=
 (2019-10-07 15:14:15 +0200)
>
> ----------------------------------------------------------------
> Improve scripts relying on the EDK2 submodule,
> drop Python2 dependency in EDK2 build scripts.
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM

