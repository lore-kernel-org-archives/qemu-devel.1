Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FC69C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 17:34:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 122232072C
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 17:34:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BKd3jaTd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 122232072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45572 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbp5J-0000il-8x
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 13:34:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56172)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jbp4T-0007cC-5m
 for qemu-devel@nongnu.org; Thu, 21 May 2020 13:33:29 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:58092
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jbp4R-0008Oq-LY
 for qemu-devel@nongnu.org; Thu, 21 May 2020 13:33:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590082406;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OQzcYHoz5Czl27l47Bsn/r0C/ioFvgugtKBDv+ZDzvI=;
 b=BKd3jaTdJZlKpIiPYJps+4CmyyAdpO3vlWAD0UYrXnpUMqSeZGpi0q8h25T5yQgQpCUUoP
 4Ebaj+3/ynkwxkVpb7DixFOVYKt7y/p3Ini9mhwaxdxBWabaE32TT8+fR4dU1irtsMZUoJ
 FRGZM2r67oBkb4/h98YUhVumQ/pihUw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-373-_rRrHnJ9OimFUG5nEqW69Q-1; Thu, 21 May 2020 13:33:23 -0400
X-MC-Unique: _rRrHnJ9OimFUG5nEqW69Q-1
Received: by mail-wm1-f70.google.com with SMTP id l2so2943215wmi.2
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 10:33:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=OQzcYHoz5Czl27l47Bsn/r0C/ioFvgugtKBDv+ZDzvI=;
 b=Ha6TTBKLyLN1Ye6zUdezLli9rE7ESftDLZB4JPvK7YbLRtUiobt/K5dK7qTr+mT7iS
 KZb55M7G7DgpqGyEX1ABK9tj2LL9z17MQmQ55lF6zfR4fk7Z9ohW0ZfhX8zdSrPuNRq8
 IpZEhsqcMgT5gRGQftvxRRhXgNuOZeR7QJBms91oggNKLaT5WZijr7H7YU2Pk9EbxKI/
 zYa3s/gHjFvPhvpr5HqcRyDPWgzL2BuI+NrTyyO4AiTpJv+ZOtFDD4sLKZTyjreMsxK5
 UfSNZ3jYJCIgvzbppUn5+diX0IqYc+q/MGo1xy5DQnGu8Z0vin3dXk3hXCCP0uiVn49z
 vBMw==
X-Gm-Message-State: AOAM531kgf7Uf5IlL4iUEmrxfOgVkAU294CyljNr2XDwnk8r9nNOf7Ja
 GU1zdAc+iS8WPVRnOf/VMfJbj6W4nb/32el04m00soksFM0AHFcHnomxcrcwXpu0zTpzpuEJ/K4
 asRV6EBotuUVjNYf8kYMWg4GzgZ2G7Ks=
X-Received: by 2002:adf:ea90:: with SMTP id s16mr9308896wrm.19.1590082402025; 
 Thu, 21 May 2020 10:33:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx+INRqLmVepUVc5FujEo7H1z2llLpkyx3c2FVOPx4CQ4GD5/5NAX2vE17qQsk32IOk3uQVnK0Q8A0dHSMAjyk=
X-Received: by 2002:adf:ea90:: with SMTP id s16mr9308857wrm.19.1590082401656; 
 Thu, 21 May 2020 10:33:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200515170804.5707-1-philmd@redhat.com>
 <20200515170804.5707-10-philmd@redhat.com>
In-Reply-To: <20200515170804.5707-10-philmd@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Date: Thu, 21 May 2020 19:33:10 +0200
Message-ID: <CAP+75-WA8mDfBHkUtHvz_q3n__CH-XmKA-Jf92FHFFOQR4oUFQ@mail.gmail.com>
Subject: Re: [PATCH v2 09/10] Makefile: Allow target-specific optional Kconfig
To: QEMU Developers <qemu-devel@nongnu.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/21 01:44:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Marek Vasut <marex@denx.de>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Chris Wulff <crwulff@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 qemu-arm <qemu-arm@nongnu.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Michael Walle <michael@walle.cc>, Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, May 15, 2020 at 7:08 PM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> Allow use of target-specific Kconfig file.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  Makefile | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/Makefile b/Makefile
> index b4c0830b26..5fce168fcb 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -423,11 +423,13 @@ MINIKCONF_INPUTS =3D $(SRC_PATH)/Kconfig.host \
>                     $(SRC_PATH)/accel/Kconfig \
>                     $(SRC_PATH)/hw/Kconfig
>  MINIKCONF_DEPS =3D $(MINIKCONF_INPUTS) \
> -                 $(wildcard $(SRC_PATH)/hw/*/Kconfig)
> +                 $(wildcard $(SRC_PATH)/hw/*/Kconfig) \
> +                 $(wildcard $(SRC_PATH)/target/*/Kconfig)
>  MINIKCONF =3D $(PYTHON) $(SRC_PATH)/scripts/minikconf.py
>
>  $(SUBDIR_DEVICES_MAK): %/config-devices.mak: default-configs/%.mak $(MIN=
IKCONF_DEPS) $(BUILD_DIR)/config-host.mak
>         $(call quiet-command, $(MINIKCONF) $(MINIKCONF_ARGS) \
> +               $(wildcard $(SRC_PATH)/target/$(firstword $(subst -, ,$@)=
)/Kconfig) \

This is incorrect, $@ is a $TARGET_ARCH (example aarch64) and we want
to include $TARGET_BASE_ARCH (example arm).

>                 > $@.tmp, "GEN", "$@.tmp")
>         $(call quiet-command, if test -f $@; then \
>           if cmp -s $@.old $@; then \
> --
> 2.21.3
>


