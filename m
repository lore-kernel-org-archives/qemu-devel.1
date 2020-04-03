Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DAC1C2D0E8
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 08:46:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CDF720787
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 08:46:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QURH2uOg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CDF720787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKHy3-000507-Jr
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 04:46:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48016)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jKHx3-00042M-VJ
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 04:45:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jKHx2-000194-L1
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 04:45:21 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:39613)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jKHx2-00017k-CT
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 04:45:20 -0400
Received: by mail-ot1-x341.google.com with SMTP id x11so6490450otp.6
 for <qemu-devel@nongnu.org>; Fri, 03 Apr 2020 01:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=dZZP5FAIdXrF5Nac0rkejEorBRkiNDjVF6CWBAXyXpM=;
 b=QURH2uOg83V7y5QMWuKyPHOKUS8WUMrJJBnVFA0GGy6yOIS11N1q9kWduG1Ua2zhSN
 NBVpcZ1ofmy5uLM6j85YMzARmEr7XdEveUc62cmYdwAEThAV6jkOzZOmosCZAwyRqdvC
 i1FZPKA45ZWdly2YxATT+AuBzDo6qIdnj1jtF3M8YwR6uvvgHf/QtqNieL//G9fIuRgy
 G0LgcqoZrvGG8T42o28EzIOzVqy1YfRjf8HRQOUe6MzJuyZ1Z0iWxxIWDHTj8ncNv9/p
 EZr/gycbZfxBkwy2oSQC3Ue0NuYMe7r4H/sZYt33X6J1i6IsXxEy0uzydIB0EgED7R3A
 I76g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=dZZP5FAIdXrF5Nac0rkejEorBRkiNDjVF6CWBAXyXpM=;
 b=QwVJkGD05piQq1gu3gwujJzyhauv7zSykS+PTlxwmec2kJ69dgy/CpulvmYku2F6bn
 hAuERRZk0tR8AD/u3jlQ9pkF8t1jV7IVJN7Dg1vg57GT/QiVrBhEWPvpphDDGzxh5Nzs
 iFqH4wpO7ZC18qY6fspe+ZfnDj4WZ03w6ZsslRETARg37rGwJmkh3P5uGfGqkngtkwoA
 AOO9R7knrksJLm2v7qWJwEPKo+0EpdUsKTTbFLeT8HqEs0byE6D3Fx7oPJdkLStJxhFG
 /6OEVgZVrXeUgzYggf+u6h4JGxh8Dbf+LoebKAo8O3+wdakcky/aNoLLM0mLZLJRz4Eb
 e40A==
X-Gm-Message-State: AGi0PuYs8cELsqoQOH+AFY1i/ClyzZayUMje3T/PCuofUFwH42q8VK3a
 Q/4KwJ2fHdiAseY8Npx20UJ6CJjRDfjNTosAhkBtMQ==
X-Google-Smtp-Source: APiQypJGADqc7QZxin50jDL3qy1wP5Dc4Nn3Izk3kVK+UzBtrMhb26tjmwB+g/mV5LtA8PzXdffe9EhShMGbY46iUhU=
X-Received: by 2002:a05:6830:1f39:: with SMTP id
 e25mr5672154oth.135.1585903519211; 
 Fri, 03 Apr 2020 01:45:19 -0700 (PDT)
MIME-Version: 1.0
References: <XSF-9CLAGYMG1ivdwoihQBZm3XT2vWdKVqHtMLExgA1LJwkSeISDoKKVEJ3E3qhZaNvki44j2CdXdQ81ljytvtS0MGmXL3gFhO2kQmWA2Kk=@protonmail.com>
 <CAFEAcA_-aRethWOmzaKqft8yMg6dGUUwvf1kX36R4+R=yWS2RA@mail.gmail.com>
 <001201d6098e$0ef0b3b0$2cd21b10$@protonmail.com>
In-Reply-To: <001201d6098e$0ef0b3b0$2cd21b10$@protonmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Apr 2020 09:45:06 +0100
Message-ID: <CAFEAcA8_9vKCtJFhT0LYLKkCzuxHwG25FruX+nsS-6+evuxyCQ@mail.gmail.com>
Subject: Re: Qemu doesn't detect hard drive
To: "Aijaz.Baig" <Aijaz.Baig@protonmail.com>
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 3 Apr 2020 at 09:01, <Aijaz.Baig@protonmail.com> wrote:
> I am looking at 'dumping' a Debian like rootfs on the MMC and then use th=
at as the default rootfs instead of the busybox one. Is there an easy to fo=
llow guide that you can point me at?  Would save me a couple hours. Also, m=
erely specifying that partition as the kernel 'root' parameter should suffi=
ce right?

If you just want to run Debian on a 32-bit arm model and you
don't care about it specifically being vexpress (or that it's
cortex-a9 rather than -a15) you're probably better off using
the "virt" board, which has more memory, supports pci and
so can use real hard disks and a more efficient network
interface, etc.

This walkthrough is a few years old now but should still
be basically correct I think:
https://translatedcode.wordpress.com/2016/11/03/installing-debian-on-qemus-=
32-bit-arm-virt-board/

thanks
-- PMM

