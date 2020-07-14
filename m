Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,WEIRD_QUOTING
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF61AC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 14:59:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7349B2245A
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 14:59:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wld4/tim"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7349B2245A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47326 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvMOe-0002Fx-O2
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 10:59:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33462)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jvMNv-0001Gx-0a
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 10:58:19 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:46739)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jvMNs-0005Wn-F6
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 10:58:18 -0400
Received: by mail-wr1-x441.google.com with SMTP id r12so22172555wrj.13
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2020 07:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=lv7hYlkGnW1rWcDv6BRNknF1Q7ibX8kdSLjSmxuFngo=;
 b=Wld4/timG7vx6/XNETDngauohqdwQlzhU/nOVx6EvnMnTaqYNkzjiVSPV9vvUvFeIC
 tQsFpU2tiHBT8cynaaO20VSz+v4BbL3WOxHn5R38QpOzhDp6bM1BL61QhHJkUQWT5ywP
 wkw/EaQ7L+QqYnNyB4FoIhX0ITd5rZ7mDsWLBcHBBHVSdkVQrjdgxGmis1O6nag72bkB
 GYcbwrjiFdZ0V5AyDKHk3zRUAlSjZ2sGcFu0IhLDdTGFAH0A+WEk1CtmT11WN9w7KZSv
 g17ea86v6GEXRoMx7IZicYnuTCIBRZIIXzAQugCoPkBHfRPA6r2hqbeFJxuzyC1jN7D2
 0ibQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=lv7hYlkGnW1rWcDv6BRNknF1Q7ibX8kdSLjSmxuFngo=;
 b=YiVeZBQjufQxLpUBxM9Iz4YiPpJ7DFHsCpodXRm/bf5nPbFuDxLk1v9P4LmDV0gb6c
 UE3eAYPsEGFk82R17iQP4G92z56C71fdTr1Od+RM5VUqR3B+6vAhwsnNA0HlLmXKvNOI
 a4bbbMHwUItc9ry7sy0azhQjHku1J7kyx8hOI8p4e+7lbTtY+z202OykkCNouWqsW/YG
 ItNzqROETyDV/t68p21DnG9Qtt7rI2M/ifuWhxbxqSv5gSMigU/haBqhv4j5g9kjGn9J
 kxTDC2B4+T9rC/UgKeLDfgozcKW3eMIMTfV0uYT7nJHsUKKvkXk1VKxJjyMpSJmxNllV
 K5zg==
X-Gm-Message-State: AOAM531o06IQSXh8oW1B4UQBjktY7nw8w+V/8UVYLjb3e/Ih6yEX2dtf
 pUPuO6oCWW+/GIUgvtwX1KAPfQ==
X-Google-Smtp-Source: ABdhPJxFy3zdPQFWYBlLeO0LtQkTq/o+S3diqMM55OolZ7sKIBAz10DfP9Eigkrs2Rl/xG4hOM4SWQ==
X-Received: by 2002:a5d:44d1:: with SMTP id z17mr6135592wrr.259.1594738694797; 
 Tue, 14 Jul 2020 07:58:14 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id u84sm4767223wmg.7.2020.07.14.07.58.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2020 07:58:13 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A44271FF7E;
 Tue, 14 Jul 2020 15:58:12 +0100 (BST)
References: <20200713175746.5936-1-peter.maydell@linaro.org>
 <20200713175746.5936-5-peter.maydell@linaro.org>
User-agent: mu4e 1.5.4; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH for-5.1 4/4] docs/system: Document the arm virt board
In-reply-to: <20200713175746.5936-5-peter.maydell@linaro.org>
Date: Tue, 14 Jul 2020 15:58:12 +0100
Message-ID: <871rleywhn.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 WEIRD_QUOTING=0.001 autolearn=unavailable autolearn_force=no
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

> Document the arm 'virt' board, which has been undocumented
> for far too long given that it is the main recommended board
> type for arm guests.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  docs/system/arm/virt.rst   | 157 +++++++++++++++++++++++++++++++++++++
>  docs/system/target-arm.rst |   1 +
>  MAINTAINERS                |   1 +
>  3 files changed, 159 insertions(+)
>  create mode 100644 docs/system/arm/virt.rst
>
> diff --git a/docs/system/arm/virt.rst b/docs/system/arm/virt.rst
> new file mode 100644
> index 00000000000..6a7823d8bca
> --- /dev/null
> +++ b/docs/system/arm/virt.rst
> @@ -0,0 +1,157 @@
> +'virt' generic virtual platform (``virt``)
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +The `virt` board is a platform which does not correspond to any
> +real hardware; it is designed for use in virtual machines.
> +It is the recommended board type if you simply want to run
> +a guest such as Linux and do not care about reproducing the
> +idiosyncrasies and limitations of a particular bit of real-world
> +hardware.
> +
> +This is a "versioned" board model, so as well as the ``virt`` machine
> +type itself (which may have improvements, bugfixes and other minor
> +changes between QEMU versions) a version is provided that guarantees
> +to have the same behaviour as that of previous QEMU releases, so
> +that VM migration will work between QEMU versions. For instance the
> +``virt-5.0`` machine type will behave like the ``virt`` machine from
> +the QEMU 5.0 release, and migration should work between ``virt-5.0``
> +of the 5.0 release and ``virt-5.0`` of the 5.1 release. Migration
> +is not guaranteed to work between different QEMU releases for
> +the non-versioned ``virt`` machine type.
> +
> +Supported devices
> +"""""""""""""""""
> +
> +The virt board supports:
> +
> +- Flash memory
> +- One PL011 UART
> +- An RTC
> +- The fw_cfg device that allows a guest to obtain data from QEMU
> +- A PL061 GPIO controller
> +- An optional SMMUv3 IOMMU
> +- hotpluggable DIMMs
> +- hotpluggable NVDIMs
> +- 32 virtio-mmio transport devices

We seem to miss out we also support the virtio-pci transports here.

Otherwise:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>


--=20
Alex Benn=C3=A9e

