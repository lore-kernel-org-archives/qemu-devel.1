Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E9D3C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 05:40:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38F9920784
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 05:40:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oti2Drf4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38F9920784
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJsaJ-0005wD-AY
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 01:40:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39882)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bmeng.cn@gmail.com>) id 1jJsZN-0005Tp-SM
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 01:39:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1jJsZM-0000Zq-QX
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 01:39:13 -0400
Received: from mail-yb1-xb41.google.com ([2607:f8b0:4864:20::b41]:38477)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1jJsZM-0000Y9-MS; Thu, 02 Apr 2020 01:39:12 -0400
Received: by mail-yb1-xb41.google.com with SMTP id 204so1449634ybw.5;
 Wed, 01 Apr 2020 22:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=t2EG+cIlPj5vy+M3PVYxO9zR6V+LgfrjP4Y2mgyuC2U=;
 b=oti2Drf4BvXVIrw4rFu52E5GNQT4/KXS1loSUroQ7Qg5olnS0sQB64MTqYzEJe5JtY
 eYxfE+ZDq4yXvmSpOZTiW6KhBn75I9uFzIGarzuwbYig5jQRreXaI6bjUTEl8C4DU7F5
 Tg4be6nxh4p+Bu6G1S6BK2QdsDzec2pPWH99j4WDKe5JymjxYtR8az5OlfzmsgiZOlmb
 T08rPgGUGoJHlqYG0cPO7UOPGzXL/UqSbYp5GcUDYZJ4BlAe+cyNUsJQZQszwhInHenq
 6VLlBT6PhMrNSnpyTVl1g6wWvPAmpbkPRv5mAAVUP8puFIDeCa/G7W4s7MnHNcCb35Wo
 7uhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=t2EG+cIlPj5vy+M3PVYxO9zR6V+LgfrjP4Y2mgyuC2U=;
 b=R/xangcacdH4UBRi7hLSdZd8SrToEe5uwQW+a7LkvpSKYZfohcgJ5mM/AHkYDR8g7X
 +4OulYM2YwFgL2lKPDEgdX/fCQPuvdmrEynXzAIxZO91FQRUZwqvqDKJw13PbEpga6DW
 b4gJ+1t4LhSknMrVUeb4iUjMwX4AoMnXj1rTdgJDqPiK1wlnwzUYn11b3b8a9VbYCYq8
 1cfZ+YuYGtCEfq45/Cpd5INq0G9ntKEM7c8S3pdjRcdv9f0V6P0QoNffeGUAAJIkPXpL
 vihm60ukQKmTCgmP96MuBSlSIOhyQhxH2lI5jkhyWp7qVaTNZw0oMTp8d8Qrlqr/T6i6
 tNhQ==
X-Gm-Message-State: AGi0PuZxpBqOruW7WmBPJ2Dodp3PVIKlrNWOnWNSAHQ/olo0MQUcdzp9
 5KPCtSkMOuoL48nc3L4J8/dTb56C1slNzUVeX+I=
X-Google-Smtp-Source: APiQypL6NRVjBDXPh8bQ/FWSlgjNoc9fkrA2/njOryJYnewMrKkINsj6/HvKF1a/Pp8Dyl86shzsDTbmxp7hGFHJf1k=
X-Received: by 2002:a25:ae8c:: with SMTP id b12mr2620036ybj.392.1585805951703; 
 Wed, 01 Apr 2020 22:39:11 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1583530528.git.alistair.francis@wdc.com>
 <CAEUhbmUHNLYoJutr3dg0hpEPehuzRD4r6eux1EStZxCknMst0w@mail.gmail.com>
In-Reply-To: <CAEUhbmUHNLYoJutr3dg0hpEPehuzRD4r6eux1EStZxCknMst0w@mail.gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Thu, 2 Apr 2020 13:39:00 +0800
Message-ID: <CAEUhbmWEEBJ67R=kktq=93a2h_ROA0C45Baj+Za73jg251W=WQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] hw/riscv: Add a serial property to sifive_u
To: Alistair Francis <alistair.francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b41
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
Cc: Alistair Francis <alistair23@gmail.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Mar 24, 2020 at 10:08 AM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> Hi Palmer,
>
> On Sat, Mar 7, 2020 at 5:45 AM Alistair Francis
> <alistair.francis@wdc.com> wrote:
> >
> > At present the board serial number is hard-coded to 1, and passed
> > to OTP model during initialization. Firmware (FSBL, U-Boot) uses
> > the serial number to generate a unique MAC address for the on-chip
> > ethernet controller. When multiple QEMU 'sifive_u' instances are
> > created and connected to the same subnet, they all have the same
> > MAC address hence it creates a unusable network.
> >
> > A new "serial" property is introduced to specify the board serial
> > number. When not given, the default serial number 1 is used.
> >
>
> Could you please take this for v5.0.0?

Ping?

