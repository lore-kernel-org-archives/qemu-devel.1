Return-Path: <SRS0=1YIe=ZE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84347C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 15:09:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E43F2067B
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 15:09:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yuC6UnDN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E43F2067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUXnU-0005kh-9T
	for qemu-devel@archiver.kernel.org; Tue, 12 Nov 2019 10:09:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40202)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <beata.michalska@linaro.org>) id 1iUXj1-0008Qv-BQ
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 10:05:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <beata.michalska@linaro.org>) id 1iUXiy-0004UH-VG
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 10:04:59 -0500
Received: from mail-il1-x144.google.com ([2607:f8b0:4864:20::144]:32810)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <beata.michalska@linaro.org>)
 id 1iUXiy-0004Ts-QW
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 10:04:56 -0500
Received: by mail-il1-x144.google.com with SMTP id m5so15833562ilq.0
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2019 07:04:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=A8GwyGE0nnEwG7mF7m13PVJq9f5H0ktfAMJ2piycuYg=;
 b=yuC6UnDNT8Cmus+Wb9Yz8RS1eT6FWT/2zAaie8GsxrAVzVed578TVE+ydeYoTFjg+x
 TuxzRg/s5Y1oS7TGKjhdcFq8DDhI1Y/pezVSoVjkkeeu0Yj3y72c/IsSU4XnYK0X06Jk
 6F8pp/q5Nlx3/KjulB1ZPJwwP5KH9ez4X9Gwle1fpFsGNd+nRMlh9ED6CHgvWzH54fJV
 70lcu9GSzWiFGKP6Iivbr70UlE1hkc76QsQZZsgR+6OjRxYVlObuoBPsMGZ+7hjLCYHe
 +CALv6xKnfVlCFb4BfcKt8mGq760excvi7muY5QYZYCGhMISDKcAdNTjInh8wlviuHjo
 alnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=A8GwyGE0nnEwG7mF7m13PVJq9f5H0ktfAMJ2piycuYg=;
 b=Kr4cLIGzvaW6gGp9/MiLPIm8x/DBpOGtOWq07PHBBRQVxuifA1om8ayMP/R/t2qpxs
 PpwpRR1AWxBRFT5o4j7XR7FbPUum/2RwMWcmo3FgO8LJcNhyCG2plrvUnoCCrEfDeaw8
 GxHhDxWziYencqnuh/eN5zVwpycYXF3OlvZXtxwJJzVxYbgowJzWQd2QzMz6xJskoiWE
 DK/77zqwKlmdZYFE8nVM0gwKQzTZUCxvSFR+zwE4AnOqLniIqAOlAUgpFX1jlRQfZE3M
 sgyDg7lXmWEEDt4HqSzpUXKHml9+7xWafG1L0Vy+ek0rriGeJatlhTSvBDWeg30N2ppD
 NIVg==
X-Gm-Message-State: APjAAAVwMGafRnRHsO1KnRW++jWEscSgT9GMThZpvr3aZi/lUYeoHQDz
 MMQCmdzu5mKSofp/ADu80CWcGobcF6eMAOf64c1saA==
X-Google-Smtp-Source: APXvYqzkNI3pQ+oF5e7+HJJGe4zzTor2UVcJ5WKVDR7jvSvTsXz7l3IDotVlwXzhlboxxb7zJ20f2p5RqHPikM77KCw=
X-Received: by 2002:a92:60b:: with SMTP id x11mr35167575ilg.69.1573571096072; 
 Tue, 12 Nov 2019 07:04:56 -0800 (PST)
MIME-Version: 1.0
References: <20191015103900.313928-1-its@irrelevant.dk>
 <20191015103900.313928-5-its@irrelevant.dk>
In-Reply-To: <20191015103900.313928-5-its@irrelevant.dk>
From: Beata Michalska <beata.michalska@linaro.org>
Date: Tue, 12 Nov 2019 15:04:45 +0000
Message-ID: <CADSWDzvPd0=Qp4dtCz9X_DObKMUYe47e8wpYA5EHyQD-kxNJhg@mail.gmail.com>
Subject: Re: [PATCH v2 04/20] nvme: populate the mandatory subnqn and ver
 fields
To: Klaus Jensen <its@irrelevant.dk>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::144
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Javier Gonzalez <javier@javigon.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Keith Busch <keith.busch@intel.com>, Paul Durrant <Paul.Durrant@citrix.com>,
 Stephen Bates <sbates@raithlin.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Klaus

On Tue, 15 Oct 2019 at 11:42, Klaus Jensen <its@irrelevant.dk> wrote:
>
> Required for compliance with NVMe revision 1.2.1 or later. See NVM
> Express 1.2.1, Section 5.11 ("Identify command"), Figure 90 and Section
> 7.9 ("NVMe Qualified Names").
>
> This also bumps the supported version to 1.2.1.
>
> Signed-off-by: Klaus Jensen <klaus.jensen@cnexlabs.com>
> ---
>  hw/block/nvme.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index 277700fdcc58..16f0fba10b08 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -9,9 +9,9 @@
>   */
>
>  /**
> - * Reference Specs: http://www.nvmexpress.org, 1.2, 1.1, 1.0e
> + * Reference Specification: NVM Express 1.2.1
>   *
> - *  http://www.nvmexpress.org/resources/
> + *   https://nvmexpress.org/resources/specifications/
>   */
>
>  /**
> @@ -1366,6 +1366,7 @@ static void nvme_realize(PCIDevice *pci_dev, Error **errp)
>      id->ieee[0] = 0x00;
>      id->ieee[1] = 0x02;
>      id->ieee[2] = 0xb3;
> +    id->ver = cpu_to_le32(0x00010201);
>      id->oacs = cpu_to_le16(0);
>      id->frmw = 7 << 1;
>      id->lpa = 1 << 0;
> @@ -1373,6 +1374,10 @@ static void nvme_realize(PCIDevice *pci_dev, Error **errp)
>      id->cqes = (0x4 << 4) | 0x4;
>      id->nn = cpu_to_le32(n->num_namespaces);
>      id->oncs = cpu_to_le16(NVME_ONCS_WRITE_ZEROS | NVME_ONCS_TIMESTAMP);
> +
> +    strcpy((char *) id->subnqn, "nqn.2019-08.org.qemu:");
> +    pstrcat((char *) id->subnqn, sizeof(id->subnqn), n->params.serial);
> +
>      id->psd[0].mp = cpu_to_le16(0x9c4);
>      id->psd[0].enlat = cpu_to_le32(0x10);
>      id->psd[0].exlat = cpu_to_le32(0x4);
> @@ -1387,7 +1392,7 @@ static void nvme_realize(PCIDevice *pci_dev, Error **errp)
>      NVME_CAP_SET_CSS(n->bar.cap, 1);
>      NVME_CAP_SET_MPSMAX(n->bar.cap, 4);
>
> -    n->bar.vs = 0x00010200;
> +    n->bar.vs = 0x00010201;

Very minor:

The version number is being set twice in the patch series already.
And it is being set in two places.
It might be worth to make a #define out of it so that only one
needs to be changed.

BR


Beata
>      n->bar.intmc = n->bar.intms = 0;
>
>      if (n->params.cmb_size_mb) {
> --
> 2.23.0
>
>

