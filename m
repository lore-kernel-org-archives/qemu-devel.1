Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B6A2CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 17:04:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E809221D7C
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 17:04:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fgu6jw0b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E809221D7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43540 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLVfd-0005US-4M
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 13:04:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54797)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iLVaW-0001XF-9q
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 12:58:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iLVaT-0004E7-PY
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 12:58:51 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:35854)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iLVaT-0004Df-Hy
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 12:58:49 -0400
Received: by mail-oi1-x241.google.com with SMTP id k20so5801575oih.3
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2019 09:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=wofiPsvRbp+QeTuDJUj+hUidGtWOPEsWdjPIhzLcOjE=;
 b=fgu6jw0b2ZfeC1V0TyPDQ9QaoHHk5U6pUbGOp4mkaoiin4AhxPLxKk2DOAEMDrIrjB
 qQOR1FNKHus87x5NqFlA85vhytXYERIr7QW2UA0LEKbxpuM8H9B5d8daLTSn4nNNYlRs
 svoMUNxd+83444gFkfzxGm5ssgWx+z4OFrCQh6zhx/res+OKP6PhVVq0CpJIR4OMwQeT
 +0P1/GRMlJcZE3lB12wLyTtwktJ/AKd6W5BT0XTsHWSGF13toRv3b8s5DtOCwOCCsR0K
 uikzwNZCzvPS89GfEbPa0tSPoInwXZj0wRhd8g8YcEVKCHtvzLP2aqdeCTKyWtbtiVZk
 sWHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=wofiPsvRbp+QeTuDJUj+hUidGtWOPEsWdjPIhzLcOjE=;
 b=HNeypa0ffysvEdeSXySdQmEcKt+B6kXI88AGo8ODrSrZrB32t4DQbMNeFmOFdpRhXk
 UV5tIYxwovJExY7gYTCocWygwOb5meeQ0PzAVT5oZt92paHK7XNKqbiPWtofZ9uC9gE9
 Niu+maw7zCl6o5O5LDKL6X1Ag7gZ24oW12px6DgZx25XlD8H13RawWpsFfi0Lrkxj5b4
 Crd4gi50ExJgc/04QW51MapvCA64IQs4n0soqckPmJmlc1Yut4bqpuA9opunFLv1LdYI
 JjEdbpc16YV8haXU5KyBcJpbIAZeKgp65+1t8wkYkKSJYA+B5NbVJkUeWzeC7VvB2ZJU
 berQ==
X-Gm-Message-State: APjAAAWFE40I58Z+C9srJeFX7jS5y+Vw0mwOQu3ZH/Y2hB8aeUGM0wVJ
 AzW97uCJUxDItF988wOmLCAd/miKEm1gaMSKd5z4PQ==
X-Google-Smtp-Source: APXvYqzlMfM2Mga9T9UOMNK4pKBvtv4DCQL1UvU/IJdy4J524Aff+sTX/ac1lEUGzJUCqkEOLFekXDsBunVDjYRyNaQ=
X-Received: by 2002:a05:6808:9:: with SMTP id u9mr8956761oic.98.1571417928577; 
 Fri, 18 Oct 2019 09:58:48 -0700 (PDT)
MIME-Version: 1.0
References: <20191018154212.13458-1-marcandre.lureau@redhat.com>
 <20191018154212.13458-14-marcandre.lureau@redhat.com>
In-Reply-To: <20191018154212.13458-14-marcandre.lureau@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 18 Oct 2019 17:58:37 +0100
Message-ID: <CAFEAcA9KYviP8YQeD5YaYR5pL_-S=C2cn23pLSdX=j_6=3qqmQ@mail.gmail.com>
Subject: Re: [PATCH 13/14] qdev: remove PROP_MEMORY_REGION
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
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
Cc: Corey Minyard <cminyard@mvista.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Aleksandar Rikalo <arikalo@wavecomp.com>, Magnus Damm <magnus.damm@gmail.com>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Fabien Chouteau <chouteau@adacore.com>, qemu-arm <qemu-arm@nongnu.org>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-ppc <qemu-ppc@nongnu.org>, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 18 Oct 2019 at 16:44, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> PROP_MEMORY_REGION was a derivative of PROP_PTR, added in commit
> ed03d749f3f513b8fb0287757cfda2cb6825f063 (qdev: add MemoryRegion
> property) and thankfully no longer needed since commit
> 3eff40dbf44896a8180c86c84dbdefb2eb173fbe (hw/misc: Remove
> mmio_interface device).
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  include/hw/qdev-properties.h | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
> index c6a8cb5516..16837ab5dd 100644
> --- a/include/hw/qdev-properties.h
> +++ b/include/hw/qdev-properties.h
> @@ -216,8 +216,6 @@ extern const PropertyInfo qdev_prop_pcie_link_width;
>      DEFINE_PROP_UNSIGNED(_n, _s, _f, 0, qdev_prop_blocksize, uint16_t)
>  #define DEFINE_PROP_PCI_HOST_DEVADDR(_n, _s, _f) \
>      DEFINE_PROP(_n, _s, _f, qdev_prop_pci_host_devaddr, PCIHostDeviceAdd=
ress)
> -#define DEFINE_PROP_MEMORY_REGION(_n, _s, _f)             \
> -    DEFINE_PROP(_n, _s, _f, qdev_prop_ptr, MemoryRegion *)
>  #define DEFINE_PROP_OFF_AUTO_PCIBAR(_n, _s, _f, _d) \
>      DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_off_auto_pcibar, \
>                          OffAutoPCIBAR)
> --
> 2.23.0.606.g08da6496b6

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

