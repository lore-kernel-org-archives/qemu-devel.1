Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCE7EC0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 17:37:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 994C2205ED
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 17:37:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YgKbCK4v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 994C2205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDtfo-0001Y3-Op
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 13:37:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60643)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jDtHQ-0000Ws-Gw
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 13:11:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jDtHP-0007JA-5r
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 13:11:56 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:38705)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jDtHO-0007Cc-W5
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 13:11:55 -0400
Received: by mail-ot1-x341.google.com with SMTP id t28so15977959ott.5
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 10:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=jGqYMRdq+LB8A/GFfRTKfqhbPMZ1y7l+2Nofeb6biR4=;
 b=YgKbCK4v/DosAcCr/gjPFUczjd0OmJ6Veyb2qjAruXqGF0EJ02OTVJzlie+LQ4hVRz
 PcDTuEcM9JGw0OH6X88OF/7/08IgrgIoBSyEqJNBcHGkedrd/XCo6ZfD/6DLSgv0LHLH
 ExwvxF5F0Yh1n31FAGH8drqhnJ/ULGamjlBRsJF6KJc0WaKZoDhriC0e+sSNex2TqYi9
 5gDBQgPTFLTDkndw5EiVuHRmwH1LHd7W3E5PP+ChyixvqS1KtqN1r6j2Uq0JiycTup5i
 TgpHYGMOxC0BB+bJl3IsVqsqtRjVLppyFw2N+w4y9Eb+2n0Ct75Q3H2bk+88FA87Sdh0
 Wdog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=jGqYMRdq+LB8A/GFfRTKfqhbPMZ1y7l+2Nofeb6biR4=;
 b=dLSf+ifJOSMoFXQUWW93WFdg0qM378fQolj04Ww35jqC3uZVB7954zlPnQ2kPWYk21
 JxhyKOodJ4UKESGZIdZcheWOmvsbr+KQWmopHy0g1Q92nGnnlEa2TYOvxE0+0KyRu57w
 WFo4vDp/yAzBjfrQSiARENNq2NXl8L7tBRrmtyqW4sLvTM0qj/XgOcEGzigSqS3/in0d
 aHTTws0n62Lx62XbWFKoyoBSycIzsAbU1TF9qI9yhj27Sto0C9Kf5RzzqpG3m1ak9bQv
 KTv6qxIQB1wjOUI23F5j3GhmnTaB8azZ/sMZHcmjA2zNQAD/AHJiJDSN8tzeNX1+o8Fr
 1s0A==
X-Gm-Message-State: ANhLgQ3QnjfOMdH8XF4HbfXD21SMjRmjk0uQHbxnloNB6LmYERlbWmY2
 2bBUXglao2jJjRtfEkzp4SgqBs6hCicWtbmqgMWGyg==
X-Google-Smtp-Source: ADFU+vvoWGysq3r5lRnRM5NKLd1UWK0pjHyrPiNZU34PNJZFCmSxBRDw8Ugb5d9gZs9dpVzqX8nq0ix0va8GcoCMtHM=
X-Received: by 2002:a9d:1d43:: with SMTP id m61mr213922otm.91.1584378713933;
 Mon, 16 Mar 2020 10:11:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200316160634.3386-1-philmd@redhat.com>
 <20200316160634.3386-19-philmd@redhat.com>
In-Reply-To: <20200316160634.3386-19-philmd@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Mar 2020 17:11:42 +0000
Message-ID: <CAFEAcA_bXb_RZFxMSYJ8FAoAahAxrq3c0PBzidu+Z0iXTzZqFw@mail.gmail.com>
Subject: Re: [PATCH v3 18/19] hw/arm: Do not build to 'virt' machine on Xen
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>, kvm-devel <kvm@vger.kernel.org>,
 Paul Durrant <paul@xen.org>, Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 "open list:X86" <xen-devel@lists.xenproject.org>,
 Anthony Perard <anthony.perard@citrix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 16 Mar 2020 at 16:08, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
>
> Xen on ARM does not use QEMU machines [*]. Disable the 'virt'
> machine there to avoid odd errors such:
>
>     CC      i386-softmmu/hw/cpu/a15mpcore.o
>   hw/cpu/a15mpcore.c:28:10: fatal error: kvm_arm.h: No such file or direc=
tory
>
> [*] https://wiki.xenproject.org/wiki/Xen_ARM_with_Virtualization_Extensio=
ns#Use_of_qemu-system-i386_on_ARM
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
> Cc: Stefano Stabellini <sstabellini@kernel.org>
> Cc: Anthony Perard <anthony.perard@citrix.com>
> Cc: Paul Durrant <paul@xen.org>
> Cc: xen-devel@lists.xenproject.org
> ---
>  hw/arm/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index 8e801cd15f..69a8e30125 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -1,5 +1,6 @@
>  config ARM_VIRT
>      bool
> +    depends on !XEN
>      default y if KVM
>      imply PCI_DEVICES
>      imply TEST_DEVICES
> --

This seems odd to me:
(1) the error message you quote is for a15mpcore.c, not virt.c
(2) shouldn't this be prevented by something saying "don't build
guest architecture X boards into Y-softmmu", rather than a specific
flag for a specific arm board ?

thanks
-- PMM

