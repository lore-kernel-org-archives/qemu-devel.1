Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0949C3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 14:17:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B49520B1F
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 14:17:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e7niXEAb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B49520B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36660 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQXEU-0001oJ-NG
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 10:17:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44304 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jQXDq-0001PQ-Gj
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 10:16:30 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jQXDp-0003wF-7Y
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 10:16:30 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:35761)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jQXDo-0003th-GQ
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 10:16:28 -0400
Received: by mail-ot1-x344.google.com with SMTP id e20so8218087otl.2
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2020 07:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=hkugNSUCGf3cfZwlCyGaI8wXlqNC6+5VcP9fYiHhc0U=;
 b=e7niXEAbvSRqBiTADpU10S+vy4G0bJXBzYiUiFy5BWhFqfEMVtUDiCJOEnu2rpkC9S
 LyVWdkIAW/SWnQiTC00fJFmcDe24MOWwkIhMXXqS9nuJl7u/4dloA+yiSxbfKU4VSBYa
 9MSeXDwaJRtoxKAD5Vzul/GQiMlAFppl1Abk97ibf15Wlh5x6V8QLVzNq3c7wZgsvfvG
 bvFopOpQItIRPZLoSmt75oyXA4x9vH3RMILgIQcCHH53mqZYXvzjVwZlytmgSJMnntKK
 vUxcBi4plcfCLwH5OLsgPS8PDzvfYvkBL9l4D7yI+M98cCgsBNlFvz8AKqLkTE+oeoQ2
 3/Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=hkugNSUCGf3cfZwlCyGaI8wXlqNC6+5VcP9fYiHhc0U=;
 b=tUfb/PJJ5UU7K/kzK6dp26Mo5H55T3wSjEvMtItQslju2VEDcd85gl89ZgbZgFLxds
 26kt9wIqZKz5ePb+1NjWDaWg34RjNWS6SWdEnVH7BLMz5hWH5N8jSaK/Nipq8RjxdFMV
 nUDA7p/QSJpawmQXQRaYF9IAtinSChhAhQSjiQ3ptiUXNvokw1HA8DyaDBgply2MyZeA
 cBRjEH2TRXBMpDDUFRAhWN4E+fbhc+9k6sLmYF8lP/mfz9crKwzxo18pbzWDJRqlYQcP
 Eg6Zk3ON9lO2ErW3IB/SSo6jMiUwxvfr2qzLPOQLnMDqUc8eWVmqnHXd+JD27Eh5E/om
 h33Q==
X-Gm-Message-State: AGi0PuZ3y/4SW6Lewg9CO1AmTBSWF887Ijcu4tPALZpN/RrpH0R7wWEj
 jyx0w/isZ7GVh/3g4dhab+LqybVNhsMDH4Ee47z5IQ==
X-Google-Smtp-Source: APiQypIp1ELmzB5fG9uX2pq2H9g1KwYn5DLvW7xYOQHxUmsRNv0kKcTM1U3+9AGGZkAeL5s2GwWGOE1UtDZR/44XhdQ=
X-Received: by 2002:a05:6830:22dc:: with SMTP id
 q28mr9240147otc.221.1587392185768; 
 Mon, 20 Apr 2020 07:16:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200331133536.3328-1-linus.walleij@linaro.org>
 <CAFEAcA9Gep1HN+7WJHencp9g2uUBLhagxdgjHf-16AOdP5oOjg@mail.gmail.com>
 <87v9luwgc6.fsf@mid.deneb.enyo.de>
 <CAFEAcA-No3Z95+UQJZWTxDesd-z_Y5XnyHs6NMpzDo3RVOHQ4w@mail.gmail.com>
In-Reply-To: <CAFEAcA-No3Z95+UQJZWTxDesd-z_Y5XnyHs6NMpzDo3RVOHQ4w@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Apr 2020 15:16:14 +0100
Message-ID: <CAFEAcA-ExeobtFswHPh3krV0K_9HdJmS7eJ2hvtzET+Hho6ESw@mail.gmail.com>
Subject: Re: [PATCH] fcntl: Add 32bit filesystem mode
To: Florian Weimer <fw@deneb.enyo.de>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::344;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x344.google.com
X-detected-operating-system: by eggs1p.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
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
Cc: Theodore Ts'o <tytso@mit.edu>, Linux API <linux-api@vger.kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Andreas Dilger <adilger.kernel@dilger.ca>, Andy Lutomirski <luto@kernel.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Ext4 Developers List <linux-ext4@vger.kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 20 Apr 2020 at 12:38, Peter Maydell <peter.maydell@linaro.org> wrote:
> Whoops, good point. I was testing this via lkvm, so it's
> actually using a 9p filesystem... I'll see if I can figure
> out how to test with an ext3 fs, which I think is the one
> we most care about.

After some effort wrestling with kvmtool (which assumes that
if you provide it a disk image then you must have wanted that
to be your rootfs and can only be persuaded otherwise via
some undocumented and arcane options), I did a test with ext4:

bash-4.4# /qemu-no-fix /readdir-bug
dir=0x76108
readdir(dir)=(nil)
errno=75: Value too large for defined data type
bash-4.4# /qemu-fixed /readdir-bug
dir=0x76108
readdir(dir)=0x76128
errno=0: Success

(where the host kernel has Linus' fcntl patch, qemu-no-fix
is a current-git-master QEMU and qemu-fixed is one with
the patch in my previous email).

So for Linus' patch:

Tested-by: Peter Maydell <peter.maydell@linaro.org>

If 9pfs could be persuaded to honour the fcntl flag too
that would be really nice.

thanks
-- PMM

