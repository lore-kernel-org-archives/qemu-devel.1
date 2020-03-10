Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D1E2C10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 15:03:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55B5620675
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 15:03:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lGW4ZUFe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55B5620675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35000 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBgPL-0002iO-Cs
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 11:02:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33026)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jBgGz-0005ha-Ru
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 10:54:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jBgGy-0008Vm-4c
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 10:54:21 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:36392)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jBgGx-0008Sg-S1
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 10:54:20 -0400
Received: by mail-wr1-x442.google.com with SMTP id s5so12362074wrg.3
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2020 07:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=IoDmdowU2DTHqu0Gp90+Y8f/NqJVCyaDVnCZ0mf2Kr8=;
 b=lGW4ZUFebK1oSpDbNeYjngRWWJ1hIs1PtjABRNacHzSmHkC5dFd+V4oVRQ9bSNvh1V
 pId9uV81sAN0sWmF7y61aB0uCOYXDXRBdz5xrnA9ViUEXkJg5VF5ozXclhHfD+0t9Jt9
 q2zF57E7caJNdp+Ysa5lmzw0eCksF58Un5Hde7fYqLpSOHJznMG5iH0sIDbBQ8IFb4e6
 iQcb0/mkrP4JA6EkURHzZrzIcnVG9DBda1idqcpPQq3Qw7hgjO+ecbZ+7sgu/hAHsFHA
 Is3iZfALdiS0rihI73iMg6+bh8o5nSl6qlweZh5cXRgiRNj42MwzBRlowUUJWknhP70r
 hC1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=IoDmdowU2DTHqu0Gp90+Y8f/NqJVCyaDVnCZ0mf2Kr8=;
 b=QRyGGMDZfwaqrohRNprGoJ/jh4ao2LHGbOOr9QyLmtVLg5p/Z0Tg0Xtauv8rivbJdV
 qD4gUsMtgcXNXbS5jVBRowX9uue+FN1/KWXO2YQgQM01y2kgqn5hzIZLdyrh4URkZvqf
 Y9u3jWOk4s1gRUthulr1wa5hwDwJkSXDnRGLDyZzNHtIICeIzP06IFK6Mh0nyyoQiVte
 IXcPpDfL+sAXwbu+bPVQrbij6zmO+JlsoH8A2TNWOwBO1YtfFcYrqOujjGwnhsX57zNS
 fkuDiUHY+hXKWg3CEsh8SPtL7sQwJv3/z391WOWUwMU2jlv9cOacu3Osl7fr7J6lZnaC
 bQVg==
X-Gm-Message-State: ANhLgQ1NVNazUDQk4+tS5VcGWx4Nbh5V5A4S4ne9pBlt/39+v2OF6rI4
 C3fFkoev+Z9OoJc3PG7Ki/PAyQ==
X-Google-Smtp-Source: ADFU+vv64or2Jyapr9vvw3Nhi/0OA9hPAIAdb20LXBan7iEDwdLkvjuT+aQG3KE4jMkI3kJtvGCEkA==
X-Received: by 2002:adf:ed86:: with SMTP id c6mr25376855wro.53.1583852057572; 
 Tue, 10 Mar 2020 07:54:17 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id n1sm21145923wrj.77.2020.03.10.07.54.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2020 07:54:14 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 3E3B61FF7E;
 Tue, 10 Mar 2020 14:54:14 +0000 (GMT)
References: <20200309215818.2021-1-peter.maydell@linaro.org>
 <20200309215818.2021-4-peter.maydell@linaro.org>
User-agent: mu4e 1.3.9; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 3/5] docs/system/target-arm.rst: Add some introductory text
In-reply-to: <20200309215818.2021-4-peter.maydell@linaro.org>
Date: Tue, 10 Mar 2020 14:54:14 +0000
Message-ID: <877dzsi7l5.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> Now we've moved the various bits of per-board documentation into
> their own files, the top level document is a little bare. Add
> some introductory information, including a note that many
> of the board models we support are currently undocumented.
>
> (Most sections of this new text were originally written by me
> for the wiki page https://wiki.qemu.org/Documentation/Platforms/ARM)
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
> ---
>  docs/system/target-arm.rst | 66 ++++++++++++++++++++++++++++++++++++--
>  1 file changed, 64 insertions(+), 2 deletions(-)
>
> diff --git a/docs/system/target-arm.rst b/docs/system/target-arm.rst
> index c7df6fc1f97..86ea6f2f568 100644
> --- a/docs/system/target-arm.rst
> +++ b/docs/system/target-arm.rst
> @@ -1,9 +1,71 @@
>  .. _ARM-System-emulator:
>=20=20
> -ARM System emulator
> +Arm System emulator
>  -------------------
>=20=20
> -Use the executable ``qemu-system-arm`` to simulate a ARM machine.
> +QEMU can emulate both 32-bit and 64-bit Arm CPUs. Use the
> +``qemu-system-aarch64`` executable to simulate a 64-bit Arm machine.
> +You can use either ``qemu-system-arm`` or ``qemu-system-aarch64``
> +to simulate a 32-bit Arm machine: in general, command lines that
> +work for ``qemu-system-arm`` will behave the same when used with
> +``qemu-system-aarch64``.
> +
> +QEMU has generally good support for Arm guests. It has support for
> +nearly fifty different machines. The reason we support so many is that
> +Arm hardware is much more widely varying than x86 hardware. Arm CPUs
> +are generally built into "system-on-chip" (SoC) designs created by
> +many different companies with different devices, and these SoCs are
> +then built into machines which can vary still further even if they use
> +the same SoC. Even with fifty boards QEMU does not cover more than a
> +small fraction of the Arm hardware ecosystem.
> +
> +The situation for 64-bit Arm is fairly similar, except that we don't
> +implement so many different machines.
> +
> +As well as the more common "A-profile" CPUs (which have MMUs and will
> +run Linux) QEMU also supports "M-profile" CPUs such as the Cortex-M0,
> +Cortex-M4 and Cortex-M33 (which are microcontrollers used in very
> +embedded boards). For most boards the CPU type is fixed (matching what
> +the hardware has), so typically you don't need to specify the CPU type
> +by hand, except for special cases like the ``virt`` board.
> +
> +Choosing a board model
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +For QEMU's Arm system emulation, you must specify which board
> +model you want to use with the ``-M`` or ``--machine`` option;
> +there is no default.
> +
> +Because Arm systems differ so much and in fundamental ways, typically
> +operating system or firmware images intended to run on one machine
> +will not run at all on any other. This is often surprising for new
> +users who are used to the x86 world where every system looks like a
> +standard PC. (Once the kernel has booted, most userspace software
> +cares much less about the detail of the hardware.)
> +
> +If you already have a system image or a kernel that works on hardware
> +and you want to boot with QEMU, check whether QEMU lists that machine
> +in its ``-machine help`` output. If it is listed, then you can probably
> +use that board model. If it is not listed, then unfortunately your image
> +will almost certainly not boot on QEMU. (You might be able to
> +extract the filesystem and use that with a different kernel which
> +boots on a system that QEMU does emulate.)
> +
> +If you don't care about reproducing the idiosyncrasies of a particular
> +bit of hardware, such as small amount of RAM, no PCI or other hard
> +disk, etc., and just want to run Linux, the best option is to use the
> +``virt`` board. This is a platform which doesn't correspond to any
> +real hardware and is designed for use in virtual machines. You'll
> +need to compile Linux with a suitable configuration for running on
> +the ``virt`` board. ``virt`` supports PCI, virtio, recent CPUs and
> +large amounts of RAM. It also supports 64-bit CPUs.
> +
> +Board-specific documentation
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> +
> +Unfortunately many of the Arm boards QEMU supports are currently
> +undocumented; you can get a complete list by running
> +``qemu-system-aarch64 --machine help``.
>=20=20
>  .. toctree::


--=20
Alex Benn=C3=A9e

