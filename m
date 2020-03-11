Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAD92C10F27
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 14:12:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76A4820726
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 14:12:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BlyoWFkT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76A4820726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jC25n-00053Z-M9
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 10:12:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38944)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jC1uf-00050g-RI
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 10:00:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jC1ue-0007EJ-By
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 10:00:45 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:39340)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jC1uc-0007A3-Ho
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 10:00:42 -0400
Received: by mail-wm1-x344.google.com with SMTP id f7so2254640wml.4
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2020 07:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=dvJ6osPaIEnztJRCn1efbmycc98N7Q/u5+xC4cjTYWs=;
 b=BlyoWFkTYmrBpOvXhjHv6FtX+2T9Nrlyrmi48+g6uj7inX7SiFcCdm2cV8eQWwOLrV
 TSRqigUBdoKtzn/1imfJr8n3XuW7dws7/N10dVoQnq5BdLeyitwx3sSimDaW0i7hUHa4
 K4AC3yBTubtHIesg41FMScIFrBLWqPAHHwVgWierm0oEXMs6FFR9P5U3Ejgz1aEbgvRF
 AufM1GK89KquUpQfjh2s/8bjtiSJfPLnOxk0vuBEd5SDK8wZfjGaRIbkOPsccmhbTHBb
 NlKNvSSa01f85qr5oxfE8bPtWfBug6GBOAEdC6jyNivgde86E9EohK1XbCTMV/smHVFb
 ocfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=dvJ6osPaIEnztJRCn1efbmycc98N7Q/u5+xC4cjTYWs=;
 b=AH7jwyZSDOQFR/ttSof7k943zL2da2JSf6WoZo0gcxkSrEGZhQzBG+oaUY5dfFls/S
 ASWGHBw1NngketltyIswAweCaqaONlMGLUre20+cterQ2DoSYPiAEGtPqYVz2ZWx/t1o
 F7lL2xKOP22WxWhXQprkyNmCBSetzCV5jgUcrENw55wo8A/604uyuYy3yEoELqJnXGT0
 xgIn1+nyagbG2j8uzUtIPI6XsJw4m3yTiGDJRuqsDyrlBF/wOlzBOQL0jMaLmgTEL3aI
 IfgXrP4fJfVVp5U31tpuh5ZL+mj5cuqpwXaaIbUE70ntlgxtttAeRDGZGrDQ25DqGdbv
 hzdw==
X-Gm-Message-State: ANhLgQ3B85LjoGueIyv45O4CEyy1962fQHe2azjGvN7kctr/Mb4BZPI3
 +skgW/FnsTKNZyz032BW64vEMg==
X-Google-Smtp-Source: ADFU+vuq0TCSDCgkULUrve3F2O6zwrMujp/L8ZjXuTyJNFIBVp6cmV2yhX0NXGIt+tAulzpe8th90A==
X-Received: by 2002:a1c:568a:: with SMTP id k132mr3884190wmb.2.1583935239992; 
 Wed, 11 Mar 2020 07:00:39 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id y15sm15432535wrq.89.2020.03.11.07.00.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Mar 2020 07:00:38 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D45CA1FF7E;
 Wed, 11 Mar 2020 14:00:37 +0000 (GMT)
References: <20200310213203.18730-1-nieklinnenbank@gmail.com>
 <20200310213203.18730-14-nieklinnenbank@gmail.com>
User-agent: mu4e 1.3.9; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Niek Linnenbank <nieklinnenbank@gmail.com>
Subject: Re: [PATCH v7 13/18] tests/boot_linux_console: Add a quick test for
 the OrangePi PC board
In-reply-to: <20200310213203.18730-14-nieklinnenbank@gmail.com>
Date: Wed, 11 Mar 2020 14:00:37 +0000
Message-ID: <8736afgfei.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
> This test boots a Linux kernel on a OrangePi PC board and verify
> the serial output is working.
>
> The kernel image and DeviceTree blob are built by the Armbian
> project (based on Debian):
> https://www.armbian.com/orange-pi-pc/
>
> If ARM is a target being built, "make check-acceptance" will
> automatically include this test by the use of the "arch:arm" tags.
>
> Alternatively, this test can be run using:
>
>   $ make check-venv
>   $ ./tests/venv/bin/avocado --show=3Dconsole,app run -t machine:orangepi=
-pc tests/acceptance/boot_linux_console.py
>   JOB ID     : 2e4d15eceb13c33672af406f08171e6e9de1414a
>   JOB LOG    : ~/job-results/job-2019-12-17T05.46-2e4d15e/job.log
>   (1/1) tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_arm_=
orangepi:
>   console: Uncompressing Linux... done, booting the kernel.
>   console: Booting Linux on physical CPU 0x0
>   console: Linux version 4.20.7-sunxi (root@armbian.com) (gcc version 7.2=
.1 20171011 (Linaro GCC 7.2-2017.11)) #5.75 SMP Fri Feb 8 09:02:10 CET 2019
>   console: CPU: ARMv7 Processor [410fc075] revision 5 (ARMv7), cr=3D50c53=
87d
>   console: CPU: div instructions available: patching division code
>   console: CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruc=
tion cache
>   console: OF: fdt: Machine model: Xunlong Orange Pi PC
>   console: Memory policy: Data cache writealloc
>   console: OF: reserved mem: failed to allocate memory for node 'cma@4a00=
0000'
>   console: cma: Failed to reserve 128 MiB
>   console: psci: probing for conduit method from DT.
>   console: psci: PSCIv0.2 detected in firmware.
>   console: psci: Using standard PSCI v0.2 function IDs
>   console: psci: Trusted OS migration not required
>   console: random: get_random_bytes called from start_kernel+0x8d/0x3c2 w=
ith crng_init=3D0
>   console: percpu: Embedded 18 pages/cpu @(ptrval) s41228 r8192 d24308 u7=
3728
>   console: Built 1 zonelists, mobility grouping on.  Total pages: 32480
>   console: Kernel command line: printk.time=3D0 console=3DttyS0,115200
>   PASS (8.59 s)
>   JOB TIME   : 8.81 s
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> [NL: rename in commit message Raspbian to Armbian, remove vm.set_machine(=
)]
> Signed-off-by: Niek Linnenbank <nieklinnenbank@gmail.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e

