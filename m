Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A4C8C10F27
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 14:24:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A5EB24C6A
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 14:24:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R+IBAbhG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A5EB24C6A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jC2HX-0002oK-K9
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 10:24:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39436)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jC1wH-0007iV-Nu
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 10:02:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jC1wG-0000Qw-5X
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 10:02:25 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:46887)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jC1wF-0000N4-TS
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 10:02:24 -0400
Received: by mail-wr1-x443.google.com with SMTP id n15so2722433wrw.13
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2020 07:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=n949oA3YuQ22A4cl70Mvu++j99r31Vr6Zlu6yr+DMi4=;
 b=R+IBAbhGApkpyujdUtKgAAeJRO1vBz6XICWSVhNyoJb/+Ft4STaTVTcecHUJmmweYl
 jLAdipF5U+QjXcum84Wo/EuIcu0OSfWdN6KwqtOwsFRk/I4TYOZt3yjuw6Vwgl59z8/s
 mGEiQG73Kk0aE+SGCDbUWKyah69e6ePerCrQWvXolh1EOF2YYI+7kzE6OyXsIS0w12Gi
 n7AFlzULiW9xQT57Am0RJ7EJeTmEd93f3mF8IaXleTYiGkYvAE4fePYE29OekrfeZMsB
 0gIYcw3PjMKBPCjzdbnh/nIoHJrKPksVP9UG2Akx7WiLywOdQWNc2hHFhrMGcXrjQ9E0
 Cz4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=n949oA3YuQ22A4cl70Mvu++j99r31Vr6Zlu6yr+DMi4=;
 b=eukfWWthUGlDSqXN4aduPDQWehOWJ9Sr+1acuPwr7lCSsjRY9KsL6rb77DL0RxUhwL
 woKaG8uyZCA8W70mY20fCu7t3wWRIFtCLuUKiQs1WaShDWpcNly5MukFzs6EDpztVtaJ
 R9O78PhqVI92PKE+BR39+pZJRPsH59GgdqyM3mHOl8Gf1vL5ddL9W5SpswcRlJqbKJEW
 YAj7e9MxDUsEH18bfKCvFTtppNgSclRIiVf2lu+emeRIlt8H7ZTxUCcPYTeJkN2kRB0p
 16ao6E1A7e7OpEBP3XK2tCZ7AnKGX6RYlvE2rOWWWVm7FoTzbDZocP6meKX21kaLt/bG
 EDYw==
X-Gm-Message-State: ANhLgQ07tkjerVTFgh9NNchwQjl/G0mUVkcRN5iH5XgAvU7jJjoIusn+
 SpIIKtLTceN1HKd+v3y4R9WGGg==
X-Google-Smtp-Source: ADFU+vuDZ8IH+wyv3vS2zpRY9o8Ma2RUhvlY26IJCYxbB02bltJ35kwRHcD9GJAVIbFjELC4KXQrEQ==
X-Received: by 2002:a5d:5511:: with SMTP id b17mr4960944wrv.198.1583935339322; 
 Wed, 11 Mar 2020 07:02:19 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id t126sm5497927wmb.27.2020.03.11.07.02.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Mar 2020 07:02:17 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id CD8691FF7E;
 Wed, 11 Mar 2020 14:02:16 +0000 (GMT)
References: <20200310213203.18730-1-nieklinnenbank@gmail.com>
 <20200310213203.18730-18-nieklinnenbank@gmail.com>
User-agent: mu4e 1.3.9; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Niek Linnenbank <nieklinnenbank@gmail.com>
Subject: Re: [PATCH v7 17/18] tests/boot_linux_console: Test booting NetBSD
 via U-Boot on OrangePi PC
In-reply-to: <20200310213203.18730-18-nieklinnenbank@gmail.com>
Date: Wed, 11 Mar 2020 14:02:16 +0000
Message-ID: <87r1xzf0rb.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: peter.maydell@linaro.org, jasowang@redhat.com, qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, b.galvani@gmail.com,
 qemu-arm@nongnu.org, imammedo@redhat.com, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Niek Linnenbank <nieklinnenbank@gmail.com> writes:

> From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>
> This test boots U-Boot then NetBSD (stored on a SD card) on
> a OrangePi PC board.
>
> As it requires ~1.3GB of storage, it is disabled by default.
>
> U-Boot is built by the Debian project [1], and the SD card image
> is provided by the NetBSD organization [2].
>
> Once the compressed SD card image is downloaded (304MB) and
> extracted, this test is fast:
>
>   $ AVOCADO_ALLOW_LARGE_STORAGE=3Dyes \
>     avocado --show=3Dapp,console run -t machine:orangepi-pc \
>       tests/acceptance/boot_linux_console.py
>   console: U-Boot SPL 2020.01+dfsg-1 (Jan 08 2020 - 08:19:44 +0000)
>   console: DRAM: 1024 MiB
>   console: U-Boot 2020.01+dfsg-1 (Jan 08 2020 - 08:19:44 +0000) Allwinner=
 Technology
>   console: CPU:   Allwinner H3 (SUN8I 0000)
>   console: scanning bus usb@1c1b000 for devices... 1 USB Device(s) found
>   console: scanning bus usb@1c1d000 for devices... 1 USB Device(s) found
>   console: scanning usb for storage devices... 0 Storage Device(s) found
>   console: Hit any key to stop autoboot:  0
>   console: =3D> setenv bootargs root=3Dld0a
>   console: =3D> setenv kernel netbsd-GENERIC.ub
>   console: =3D> setenv fdtfile dtb/sun8i-h3-orangepi-pc.dtb
>   console: =3D> boot
>   console: ## Booting kernel from Legacy Image at 42000000 ...
>   console: Image Name:   NetBSD/earmv7hf 9.0_RC1
>   console: Image Type:   ARM Linux Kernel Image (no loading done) (uncomp=
ressed)
>   console: XIP Kernel Image (no loading done)
>   console: Loading Device Tree to 49ff6000, end 49fffe01 ... OK
>   console: Starting kernel ...
>   console: [   1.0000000] NetBSD/evbarm (fdt) booting ...
>   console: [   1.0000000] NetBSD 9.0 (GENERIC) #0: Fri Feb 14 00:06:28 UT=
C 2020
>   console: [   1.0000000]         mkrepro@mkrepro.NetBSD.org:/usr/src/sys=
/arch/evbarm/compile/GENERIC
>   console: [   1.0000000] total memory =3D 1024 MB
>   console: [   1.0000000] avail memory =3D 1003 MB
>   console: [   1.0000000] armfdt0 (root)
>   console: [   1.0000000] simplebus0 at armfdt0: Xunlong Orange Pi PC
>   console: [   1.0000000] cpu0 at cpus0: Cortex-A7 r0p5 (Cortex V7A core)
>   console: [   1.0000000] cpu0: DC enabled IC enabled WB enabled LABT bra=
nch prediction enabled
>   console: [   1.0000000] cpu0: 32KB/64B 2-way L1 VIPT Instruction cache
>   console: [   1.0000000] cpu0: 32KB/64B 2-way write-back-locking-C L1 PI=
PT Data cache
>   console: [   1.0000000] cpu0: 2304KB/64B 16-way write-through L2 PIPT U=
nified cache
>   console: [   1.0000000] vfp0 at cpu0: NEON MPE (VFP 3.0+), rounding, Na=
N propagation, denormals
>   ...
>   console: [   2.3812082] sdmmc0: SD card status: 4-bit, C0
>   console: [   2.3812082] ld0 at sdmmc0: <0xaa:0x5859:QEMU!:0x01:0xdeadbe=
ef:0x062>
>   console: [   2.4012856] ld0: 1226 MB, 622 cyl, 64 head, 63 sec, 512 byt=
es/sect x 2511872 sectors
>   console: [   2.5321222] ld0: 4-bit width, High-Speed/SDR25, 50.000 MHz
>   console: [   3.1068718] WARNING: 4 errors while detecting hardware; che=
ck system log.
>   console: [   3.1179868] boot device: ld0
>   console: [   3.1470623] root on ld0a dumps on ld0b
>   console: [   3.2464436] root file system type: ffs
>   console: [   3.2897123] kern.module.path=3D/stand/evbarm/9.0/modules
>   console: Mon Feb 17 20:33:35 UTC 2020
>   console: Starting root file system check:
>   PASS (35.96 s)
>   RESULTS    : PASS 1 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT 0 =
| CANCEL 0
>   JOB TIME   : 36.09 s
>
> Note, this test only took ~65 seconds to run on Travis-CI, see: [3].
>
> This test is based on a description from Niek Linnenbank from [4].
>
> [1] https://wiki.debian.org/InstallingDebianOn/Allwinner#Creating_a_boota=
ble_SD_Card_with_u-boot
> [2] https://wiki.netbsd.org/ports/evbarm/allwinner/
> [3] https://travis-ci.org/philmd/qemu/jobs/638823612#L3778
> [4] https://www.mail-archive.com/qemu-devel@nongnu.org/msg669347.html
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> [NL: changed test to use NetBSD 9.0 final release and -global allwinner-r=
tc.base-year]
> Tested-by: Niek Linnenbank <nieklinnenbank@gmail.com>
> Signed-off-by: Niek Linnenbank <nieklinnenbank@gmail.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e

