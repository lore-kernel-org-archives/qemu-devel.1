Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85F88C33CAC
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 14:04:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51F3A2082E
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 14:04:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h4yNt754"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51F3A2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41382 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iycLI-0005Ca-II
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 09:04:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58546)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iycK4-0003u3-L5
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 09:03:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iycK2-0007bj-Lk
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 09:03:32 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:33060)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iycK2-0007bF-Fu
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 09:03:30 -0500
Received: by mail-ot1-x341.google.com with SMTP id b18so13744914otp.0
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2020 06:03:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=g47PT5lt/iJyYcUt6t9a4d2giehtZw2lN1sbG54X8jE=;
 b=h4yNt754J9oq9dRlRUyCU5FsT9uUKfxsBS0w+jAhRlB6lXhOd1eA98BTjJbustxZPb
 cjFx/lLT0kaxJyZJ4iBagN/Pr5m16qD6x/hLAiSjfZDrRLIv0ju2gZ9LmT8Fgtj4XS2D
 meDg2M1MPj4jtMaBZi1Vq6E6UAEl1hrARLjGo7YnhGe3/fWq2pscaZwLAYOc+f7QgWrb
 0Y/UXvB+nXH61znESX5XBxRKiZ7VEtBEINEUiP4oQrSWjk0ZfdmzirlXG/SGJnTXyopd
 o7ZYCjX0kRQv798DJVSgYLO8ivYHsvBfwKliAWj5L+okqBM5vK6xOl5EryemyXw+a5A4
 nncg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=g47PT5lt/iJyYcUt6t9a4d2giehtZw2lN1sbG54X8jE=;
 b=seSDvwqR6NQ9LDUroqOPToMtdJFiGiK6lkZeg9li2e1xcW5oS0ePJOgdPTsSvL7sAY
 EA76iLmPmScDeh2Wdx429Rup8/P6GaY4L7keLujvmQaZSlfCdhwogcog8XBWvMvy3o1M
 Sfslue7tfSblLBVwm0PRqGPBUEPyYrnjPaaFbQ1rXCE9qF6mr6BKeoaZ7xRfcotAUYYx
 wq6QjJMkdc32TUk/guXP+++dif9YlKU+muDLk7tii97tD8c0YfctuCbYyAmT3U6mFkVr
 yyXDnYaXNpSt50yl4xSBZnLxFGtBqmxMIOaL15cdw1gNMhK2y2o5ZO2Z60epcmu5LAKd
 YOhQ==
X-Gm-Message-State: APjAAAVNditXzuzuQVArYliygisey/7Q6BXruCW9XbdlOPlh3GMNpWVW
 8dXFxCYUTt/z/MO+Aa590iF5eFeSvY3yAWvFk36+HA==
X-Google-Smtp-Source: APXvYqwXk5pY6aQhsCtke+nDOpxMhKIIUidCmtw93a0Dp2O8LXn62OlyZsLx/za7nQDeZ/WxMqvph03hWhs9zihIomU=
X-Received: by 2002:a05:6830:13da:: with SMTP id
 e26mr16817164otq.97.1580738609492; 
 Mon, 03 Feb 2020 06:03:29 -0800 (PST)
MIME-Version: 1.0
References: <20200203001505.52573-1-guoheyi@huawei.com>
 <20200203014246-mutt-send-email-mst@kernel.org>
 <455d16a4-e7b6-af9b-0b7e-43be70e22f7b@huawei.com>
In-Reply-To: <455d16a4-e7b6-af9b-0b7e-43be70e22f7b@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 3 Feb 2020 14:03:18 +0000
Message-ID: <CAFEAcA_g3XXnxiV2O37zpj7gw8For042hg0Vau44qm=ByOuXdw@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] Some cleanup in arm/virt/acpi
To: Heyi Guo <guoheyi@huawei.com>
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 Igor Mammedov <imammedo@redhat.com>, wanghaibin.wang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 3 Feb 2020 at 13:33, Heyi Guo <guoheyi@huawei.com> wrote:
>
>
> =E5=9C=A8 2020/2/3 14:43, Michael S. Tsirkin =E5=86=99=E9=81=93:
> > On Mon, Feb 03, 2020 at 08:14:58AM +0800, Heyi Guo wrote:
> >> Remove conflict _ADR objects, and fix and refine PCI device definition=
 in
> >> ACPI/DSDT.
> >>
> >> Cc: Peter Maydell <peter.maydell@linaro.org>
> >> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> >> Cc: Igor Mammedov <imammedo@redhat.com>
> >> Cc: Shannon Zhao <shannon.zhaosl@gmail.com>
> >> Cc: qemu-arm@nongnu.org
> >> Cc: qemu-devel@nongnu.org
> >
> > Series
> >
> > Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> >
> > merge through ARM tree pls.
>
> Thanks, Michael :)
>
>
> Hi Peter,
>
> Do I need to send v3 to update the commit message of patch 4/7 as
> Michael suggested?

This patchset seems to be corrupt somehow:

e104462:bionic:qemu$ patches apply -s
id:20200203001505.52573-1-guoheyi@huawei.com
Applying: bios-tables-test: prepare to change ARM virt ACPI DSDT
Applying: arm/virt/acpi: remove meaningless sub device "RP0" from PCI0
Applying: arm/virt/acpi: remove _ADR from devices identified by _HID
Applying: arm/acpi: fix PCI _PRT definition
Applying: arm/acpi: fix duplicated _UID of PCI interrupt link devices
Applying: arm/acpi: simplify the description of PCI _CRS
Applying: virt/acpi: update golden masters for DSDT update
error: corrupt patch at line 68
error: could not build fake ancestor
hint: Use 'git am --show-current-patch' to see the failed patch
Patch failed at 0007 virt/acpi: update golden masters for DSDT update
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".

Patchew didn't like it either:
https://patchew.org/QEMU/20200203001505.52573-1-guoheyi@huawei.com/

I think the problem here is the quoting of the diff in
the commit message of patch 7: git am and friends think
that is part of the actual patch body and get confused.
You might be able to avoid that by not putting the
  diff --git a/DSDT.dsl.orig b/DSDT.dsl
  index ed3e5f0fa9..10cf70c886 100644
  --- a/DSDT.dsl.orig
  +++ b/DSDT.dsl

part in the commit message, but I haven't tested that.

So resending a v4 would probably be a good idea anyway.

thanks
-- PMM

