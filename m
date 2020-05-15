Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6008C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 09:55:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 724DC20709
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 09:55:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q9P1zagY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 724DC20709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54246 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZX3Z-0007mK-Jt
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 05:55:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40294)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jZX2o-0006mE-2e
 for qemu-devel@nongnu.org; Fri, 15 May 2020 05:54:18 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:51449)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jZX2m-0004gD-9a
 for qemu-devel@nongnu.org; Fri, 15 May 2020 05:54:17 -0400
Received: by mail-wm1-x341.google.com with SMTP id f134so1679289wmf.1
 for <qemu-devel@nongnu.org>; Fri, 15 May 2020 02:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=B6Sv+HOYx+Qldwi32HxA1lDrwuJY4msW58ZS4Yf2LYQ=;
 b=q9P1zagY8XCiwbE9DyB70yy3rcj1PNistxCs2BJkiOpKwLXCljb+f/s4ATHwIhpD6F
 SvOFI2+gyF6dlUDHFrrWPhmIYXbQvpSPKoKSrkeo57ceinIipYrKBHtHRdAUo+7aG0cO
 Znjp3KfpZqU+fH0INOz6LPLMZPAYmw6DzUOEkbMgtFIouqKlowWw0jdEs4ZWUjXxwXMt
 CsuLwg0qu9CYMZP5BsAn0+pAZ4DRCo0YFbDGG6Y1La2MP7wv6OHMxeo4Kdka58RIUsYl
 uUKM2i63vB1/zvWeKG5blXRPHA2Bf3C+9dIEICzvzCSZMfW1CmmdVBxhbOTy19C1Yvz5
 UGGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=B6Sv+HOYx+Qldwi32HxA1lDrwuJY4msW58ZS4Yf2LYQ=;
 b=VkLr+KYFJ7Xd9J10nvl9aNLpZyJg2VJdWDwfIwJvqRtaGSgCqLvC9EBOd3B+BOC/xs
 xpAoYKugPTwlk/SGccuBqmX4Ks8T4wK23q8QiM2Xrdo+yMjd7bnkcL5Kqnd1vE2apkvu
 wjI8Sbcwbaj97GRsSIesbf4GLKTUyce4P32leiC2xCvyMV7eu/tc6sYPUY6Vd899dcrm
 vW7GM/556SHzet71iBr1x52OSnphuRfWl8XszhxjWTIdYc2vMaUI6JQYbRzskRWhjlNN
 FSlrQ/a4GJoxqFSSjP2VEp5zAmDqaCtL3F2oc4H7jJ8EaV576G0L1IF9yygJWj2iE6MT
 sEWw==
X-Gm-Message-State: AOAM530I8fCsPPZVxG6j+gZwoxDOcAIJUkaaGRFrgnAWY/xwC5mCmt+8
 LV8n5bBVwJqNard9xK9xDMGpgA==
X-Google-Smtp-Source: ABdhPJztqZjGEFW9LSIX249wN82zuCyrTIcOenEmMNpTcgSRZDEDYkv4NYD4+JuDDTtOue/fy5imPg==
X-Received: by 2002:a1c:ed04:: with SMTP id l4mr3196127wmh.93.1589536454445;
 Fri, 15 May 2020 02:54:14 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id g10sm2704455wrx.4.2020.05.15.02.54.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2020 02:54:12 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 1EDE31FF7E;
 Fri, 15 May 2020 10:54:12 +0100 (BST)
References: <20200507151819.28444-1-peter.maydell@linaro.org>
 <20200507151819.28444-4-peter.maydell@linaro.org>
User-agent: mu4e 1.4.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 3/5] docs/system: Document Arm Versatile Express boards
In-reply-to: <20200507151819.28444-4-peter.maydell@linaro.org>
Date: Fri, 15 May 2020 10:54:12 +0100
Message-ID: <87k11dcym3.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> Provide a minimal documentation of the Versatile Express boards
> (vexpress-a9, vexpress-a15).
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  docs/system/arm/vexpress.rst | 60 ++++++++++++++++++++++++++++++++++++
>  docs/system/target-arm.rst   |  1 +
>  MAINTAINERS                  |  1 +
>  3 files changed, 62 insertions(+)
>  create mode 100644 docs/system/arm/vexpress.rst
>
> diff --git a/docs/system/arm/vexpress.rst b/docs/system/arm/vexpress.rst
> new file mode 100644
> index 00000000000..7f1bcbef078
> --- /dev/null
> +++ b/docs/system/arm/vexpress.rst
> @@ -0,0 +1,60 @@
> +Arm Versatile Express boards (``vexpress-a9``, ``vexpress-a15``)
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +QEMU models two variants of the Arm Versatile Express development
> +board family:
> +
> +- ``vexpress-a9`` models the combination of the Versatile Express
> +  motherboard and the CoreTile Express A9x4 daughterboard
> +- ``vexpress-a15`` models the combination of the Versatile Express
> +  motherboard and the CoreTile Express A15x2 daughterboard
> +
> +Note that as this hardware does not have PCI, IDE or SCSI,
> +the only available storage option is emulated SD card.
> +
> +Implemented devices:
> +
> +- PL041 audio
> +- PL181 SD controller
> +- PL050 keyboard and mouse
> +- PL011 UARTs
> +- SP804 timers
> +- I2C controller
> +- PL031 RTC
> +- PL111 LCD display controller
> +- Flash memory
> +- LAN9118 ethernet
> +
> +Unimplemented devices:
> +
> +- SP810 system control block
> +- PCI-express
> +- USB controller (Philips ISP1761)
> +- Local DAP ROM
> +- CoreSight interfaces
> +- PL301 AXI interconnect
> +- SCC
> +- System counter
> +- HDLCD controller (``vexpress-a15``)
> +- SP805 watchdog
> +- PL341 dynamic memory controller
> +- DMA330 DMA controller
> +- PL354 static memory controller
> +- BP147 TrustZone Protection Controller
> +- TrustZone Address Space Controller
> +
> +Other differences between the hardware and the QEMU model:
> +
> +- QEMU will default to creating one CPU unless you pass a different
> +  ``-smp`` argument
> +- QEMU allows the amount of RAM provided to be specified with the
> +  ``-m`` argument
> +- QEMU defaults to providing a CPU which does not provide either
> +  TrustZone or the Virtualization Extensions: if you want these you
> +  must enable them with ``-machine secure=3Don`` and ``-machine
> +  virtualization=3Don``
> +- QEMU provides 4 virtio-mmio virtio transports; these start at
> +  address ``0x10013000`` for ``vexpress-a9`` and at ``0x1c130000`` for
> +  ``vexpress-a15``, and have IRQs from 40 upwards. If a dtb is
> +  provided on the command line then QEMU will edit it to include
> +  suitable entries describing these transports for the guest.

TIL ;-)

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e

