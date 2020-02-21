Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15BBEC35656
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 14:27:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4C1D208C4
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 14:27:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hWwuuBGD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4C1D208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58976 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j59HE-0000rD-2v
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 09:27:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47524)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j59Fg-0007oz-Rr
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 09:26:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j59Ff-0005Rv-R0
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 09:26:00 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:45740)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j59Ff-0005QH-Mg
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 09:25:59 -0500
Received: by mail-oi1-x241.google.com with SMTP id v19so1697711oic.12
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2020 06:25:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=nwOOFWB4szt5rdkEHn9Rc5Bmej30A0hc7MSMzaS5f8o=;
 b=hWwuuBGDynGYGhkITvGpv2BKN2eEo7xP3j0CxsofCUfphwaO7hf0J+LlE+3/nnbujx
 m1rmdE5nQjXuToGXGhCuM3rRuU7Uxk6rEFkwWU1is+SbXlpPAht2y23vrxrDeZCjO5jw
 5RUrMqCak0Nsu4ue+WWm5xq7wQm66lAM0mhrmVpYHo9VDSSWlKSQ4FBpzuv2/D0VSOm8
 wJpN9viSsDa1LdU8lr1hcXGpV8hu/M2mWyi0Scli7TTRM9FFAuDPkwwtLddJYZUE9q8u
 u8BE7Ru25APtujSD7sF4mmu5WzmhbgSpZvExfmnbWyzYtoqibWUWrbK9j29t/qPzXT9o
 4TXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=nwOOFWB4szt5rdkEHn9Rc5Bmej30A0hc7MSMzaS5f8o=;
 b=FEQi5lsMU1uh0MOjZt467MlNkfi/AmmBIQ8hDhTv+6e4XclfVAn8CzvDFaT2MmZQDi
 UUFHj/KJKywGlTRNeuXqGON4mYZbDbw3gwU7vD/obMiAzYm4dRwMySKwruGvh5T5BpM8
 mrOpc9eX3nIT++owj6gIXSxzY0Q7N9v9sdPtutrJE4CZE2ksnGJWhgm0vcoBnLVpSMJa
 lApVcLrzs/IK0RSoX+neyCpB226uV+eNlBf8NDPl3jxrfoLaE0QzipDZOgtxrLV+oJxw
 U6zHPgjhOVn8C8e+1wbisvhcfkoJ+6IilJa0+qtfRI0XW9oELpvQOlpO8OdF1f9ftZAw
 SEvg==
X-Gm-Message-State: APjAAAU4R20tb3O9bHvFRGbe0p7RiYGB+HRVHH3tcQGQPer56qTKs2yX
 6HHm18oHUB/CNZ4YZAFPvs3+VLXL+BG2GXUI0yjfBQ==
X-Google-Smtp-Source: APXvYqyUpseQGOHmeRWgbfdzmdQl5jlTq/FIHbFMhgTGow+mU6SWTHrGd0OC3Bd7qQijBDmENeGfLjf12D88R0vKP0A=
X-Received: by 2002:a05:6808:289:: with SMTP id
 z9mr2152171oic.48.1582295158721; 
 Fri, 21 Feb 2020 06:25:58 -0800 (PST)
MIME-Version: 1.0
References: <20200214132745.23392-1-eric.auger@redhat.com>
 <20200214132745.23392-10-eric.auger@redhat.com>
In-Reply-To: <20200214132745.23392-10-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 21 Feb 2020 14:25:47 +0000
Message-ID: <CAFEAcA8f=L_YJFukTk+wKBODBYh7nk8XCUfpDk7ywCCu6m6V0A@mail.gmail.com>
Subject: Re: [PATCH v16 09/10] hw/arm/virt: Add the virtio-iommu device tree
 mappings
To: Eric Auger <eric.auger@redhat.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, tnowicki@marvell.com,
 Juan Quintela <quintela@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Peter Xu <peterx@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, bharatb.linux@gmail.com,
 qemu-arm <qemu-arm@nongnu.org>, Eric Auger <eric.auger.pro@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 14 Feb 2020 at 13:29, Eric Auger <eric.auger@redhat.com> wrote:
>
> Adds the "virtio,pci-iommu" node in the host bridge node and
> the RID mapping, excluding the IOMMU RID.
>
> This is done in the virtio-iommu-pci hotplug handler which
> gets called only if no firmware is loaded or if -no-acpi is
> passed on the command line. As non DT integration is
> not yet supported by the kernel we must make sure we
> are in DT mode. This limitation will be removed as soon
> as the topology description feature gets supported.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

