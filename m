Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79EC4C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 19:27:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41D2720753
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 19:27:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ufWK8By/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41D2720753
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDvOZ-0005Fq-E0
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 15:27:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48897)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jDvHb-0001jG-Sl
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 15:20:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jDvHa-000676-Pi
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 15:20:15 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:45298)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jDvHa-00063z-Ja
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 15:20:14 -0400
Received: by mail-ot1-x342.google.com with SMTP id e9so11855222otr.12
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 12:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=cFODzTkX5tNbBR2vnGIyVCmfvGDiw7qKMa8wynYRbRo=;
 b=ufWK8By/tgSE3G09+GNBUzLeo2hZq5ez7HrUTfMB3Zj1/aZ1qpFbbFJAY4uezDa4L9
 c4eN27QCls7/O5NMP37o603U9Ki0JPJxuHAHHLKCIWqfhNGeTSC7uuTBvmaxeVuO/Nt2
 YDe3b8N08fyY18uHC3+XgXYLP4wlFTovm1G2FU5EWaiBJMXOVudy+j9Ju5CQV5TdQvMZ
 h3nNbrRpiZHgQEyOtFJdEvmziMSXaRkdFOMjh9sB9TC0oNuRcTW/MKxoZlPjKLKTgkvi
 jaU8O5WXiLcQbV+N+FFO5VEVFGzJiEkTk7L8t9POHIE1lZ7S0IDNW4qTSf9YomQmMPG3
 ZJxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=cFODzTkX5tNbBR2vnGIyVCmfvGDiw7qKMa8wynYRbRo=;
 b=mQ/gPHaODRPbhHoHs5ZGsgOoer57meBAO1iYUtwcjhqwTQ1+M+D35Gg5VvT4Vpyvs8
 ODKvRa9xs5q13wdGMzl4SiLQQMcbM744FYGzR9x/Lr8SpuHlv8yOM+DW/bomW1islNAv
 iI0T+SuEjDJu3t0RD1pfpWJotT+ziau7wHI2C2XGPkyTCwrBtVBYRYTpldCVgFNqz/Ag
 9LApZ+kirBD4Mwx+1y+sW5lXITHR+Zoo4waabJeyWDSWlb1Dze1ZMycRl0GzE1c8uIJp
 X+MlwzgvsfBYbykwtxkNpUD9Mx6NlHNY0p0zBAUYeo+EhBKNU6L4I5PT/xjBUBer3yGc
 VGfg==
X-Gm-Message-State: ANhLgQ1aFs7rsXaZya4t+GemrjIxUo2tATwqSfYhZRgQBkBxDkyHymsO
 /CvS7vmDx1ka+QD1ukTSwyWh4vIroofNAgqT429GFw==
X-Google-Smtp-Source: ADFU+vswIaJfFvcY3/dKOheAkVqoFFf455YHAoad+70ntpvTdoJJyIiZ2OZz87XUVN9BitNWXvOXBHZydMmIo4diBmQ=
X-Received: by 2002:a9d:1d43:: with SMTP id m61mr640075otm.91.1584386413554;
 Mon, 16 Mar 2020 12:20:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200311232342.1614944-1-ehabkost@redhat.com>
 <20200311232342.1614944-3-ehabkost@redhat.com>
 <20200315154559.GW1187748@habkost.net>
 <20200315170229-mutt-send-email-mst@kernel.org>
 <20200316173039.GB1817047@habkost.net>
 <CAFEAcA9CYeTjmUSbMtGjDazrh1p=5vLAd3bq7JBtLd0RfnruDw@mail.gmail.com>
 <20200316184046.GD1817047@habkost.net>
In-Reply-To: <20200316184046.GD1817047@habkost.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Mar 2020 19:20:02 +0000
Message-ID: <CAFEAcA-i_S1TZWoDQ5L4J32t3N+aHWvm9dGqHxFHB7wuKpE0iA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] mmap-alloc: Include osdep.h before checking
 CONFIG_LINUX
To: Eduardo Habkost <ehabkost@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
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
Cc: Jingqi Liu <jingqi.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?J=C3=A1n_Tomko?= <jtomko@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 16 Mar 2020 at 18:40, Eduardo Habkost <ehabkost@redhat.com> wrote:
>
> On Mon, Mar 16, 2020 at 06:08:54PM +0000, Peter Maydell wrote:
> > The usual approach is that if you don't have the Linux-specific
> > feature available you quietly fall back to whatever the sensible
> > behaviour is for when the feature isn't present. We definitely
> > don't want to be printing warnings on non-Linux systems that
> > are effectively just saying "you're not running Linux". Same goes
> > for "host happens not to be running a bleeding-edge Linux kernel
> > and this feature isn't available yet".
>
> I don't think using pmem=on without MAP_SYNC is expected to be a
> supported use case, is it?  If a use case is not supported, the
> sensible behavior is to tell the user it is not supported.

Yeah, that's fair. But the code at the moment does a fallback
to "proceed without SHARED_VALIDATE | SYNC", so I assumed it
was supposed to work.

thanks
-- PMM

