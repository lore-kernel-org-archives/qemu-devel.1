Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE97DC3F2D0
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 07:35:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F7A024655
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 07:35:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eH4kyPL3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F7A024655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54620 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBZQ8-0006v0-Md
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 03:35:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55834)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jBZPJ-0006Hb-NW
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 03:34:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jBZPI-0007D7-Bt
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 03:34:29 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:37833)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jBZPI-00079w-3e
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 03:34:28 -0400
Received: by mail-wr1-x441.google.com with SMTP id 6so14444873wre.4
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2020 00:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=BjZk2KlzcWVBLjHLmlVyq/Kv1FPkgAcuLUTEmatsZ0k=;
 b=eH4kyPL3Zibp0fycKsoPXkNgm8SJ8AbdZ7r/rLKnvhoUmhrDLiaqtTk+sUKK2xmlw8
 UQimm8e6tKiHM1ulS6zQiUT+QkskMybBJ9NextfKlStUqCMZYcnDBboDmS7oW/7Zez2S
 cYd6jN/VY1mJPQcmOle4ORP/y4QlmgSxCzxLr5f+V5X9cmuDpa8ls1TeNUgoPEJYMfFg
 p1/kpB7eQbNqnxEK1QyHBOaIK7ONGHJozyWsmlFMSncYvad4R7jFj1rqecfsC4zz70HL
 2fai4Gdh/SQbpFLKBoZMlzz4oUnTIh3Dr9/87fvtG6a110ydV2YWA3FHd2V3mrhZKQ/n
 A+oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=BjZk2KlzcWVBLjHLmlVyq/Kv1FPkgAcuLUTEmatsZ0k=;
 b=WmhA0esYRGmanmNYgjoDgnS2IC5uu67oevuOWAopeDhz7tOfiDKb0vLA+5FbS8OSXW
 BhbWMIEH/2Yrfefhiv8nuWPNktiHgMSSykMn4esjneUyHzl9I+uhOsXTX2OP48ahwg6M
 yeNgRUPNTcgYAlxC1hC9oh/AhR4kT+w05q23lKFJ8xTAEPrRLPr6N8BHbYPclO3mZVYC
 lnisJRk1J6RRXWltoDsa2FEo1siX83p+XL2JRxbOr60snTWIIjlUshWSbo0n50jApqZg
 BI5nb0tUglBHW7OG0GJdL/yPNCh083lHnpt0V10rA0pFiK+7Z31xv1g9Yb+yt+5FXVQA
 IClw==
X-Gm-Message-State: ANhLgQ0EwJPurjnc61BUkXS9dHKNOVktchi3mrnUcW1rHRpm4rxNuPIO
 uFlMYvrSA08nJhKNF7Pt1uE+Ig==
X-Google-Smtp-Source: ADFU+vs5FSQyOvAK0tgEZ7CglC6wLUvHSAwr++lj2vl2JxLXARbxc1dHPzJbqLmp3t9eFBruIpY/oA==
X-Received: by 2002:a5d:5090:: with SMTP id a16mr23425458wrt.191.1583825666531; 
 Tue, 10 Mar 2020 00:34:26 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id j66sm2943561wmb.21.2020.03.10.00.34.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2020 00:34:25 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 7AF061FF7E;
 Tue, 10 Mar 2020 07:34:24 +0000 (GMT)
References: <20200309202318.3481-1-alex.bennee@linaro.org>
 <20200309202318.3481-6-alex.bennee@linaro.org>
User-agent: mu4e 1.3.9; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH  v1 5/5] tests/acceptance: disable two more tests while
 in CI
In-reply-to: <20200309202318.3481-6-alex.bennee@linaro.org>
Date: Tue, 10 Mar 2020 07:34:24 +0000
Message-ID: <87sgigiry7.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: Cleber Rosa <cleber@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fabien Chouteau <chouteau@adacore.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> These keep timing out on Travis. The reason is unknown so add a FIXME
> for those who want to track down exactly why this is happening. In the
> meantime you can still run check-acceptance manually without change.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  tests/acceptance/machine_mips_malta.py  | 2 ++
>  tests/acceptance/machine_sparc_leon3.py | 2 ++
>  2 files changed, 4 insertions(+)
>
> diff --git a/tests/acceptance/machine_mips_malta.py b/tests/acceptance/ma=
chine_mips_malta.py
> index 92b4f28a112..deebf532e95 100644
> --- a/tests/acceptance/machine_mips_malta.py
> +++ b/tests/acceptance/machine_mips_malta.py
> @@ -99,6 +99,8 @@ class MaltaMachineFramebuffer(Test):
>          """
>          self.do_test_i6400_framebuffer_logo(1)
>=20=20
> +    # FIXME: why does this keep timing out on Travis?
> +    @skipIf(os.getenv('CONTINUOUS_INTEGRATION'), 'Running on Travis-CI')
>      def test_mips_malta_i6400_framebuffer_logo_7cores(self):
>          """
>          :avocado: tags=3Darch:mips64el
<snip>

I can replicate this on my local machine with either 7 or 8 core runs by
using tasksel to limit the threads to two cores (like the Travis VM). I
suspect this is a MTTCG bug because it smell racy.

The failure I see is:

Brought up 8 CPUs
devtmpfs: initialized
clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns:=
 19112604462750000 ns
NET: Registered protocol family 16
pm-cps: CPC does not support clock gating
vgaarb: loaded
SCSI subsystem initialized
PCI host bridge to bus 0000:00
pci_bus 0000:00: root bus resource [mem 0x10000000-0x17ffffff]
pci_bus 0000:00: root bus resource [io  0x1000-0x1fffff]
pci_bus 0000:00: root bus resource [??? 0x00000000 flags 0x0]
pci_bus 0000:00: No busn resource found for root bus, will use [bus 00-ff]
pci 0000:00:00.0: [Firmware Bug]: reg 0x14: invalid BAR (can't size)
pci 0000:00:00.0: [Firmware Bug]: reg 0x18: invalid BAR (can't size)
pci 0000:00:00.0: [Firmware Bug]: reg 0x1c: invalid BAR (can't size)
pci 0000:00:00.0: [Firmware Bug]: reg 0x20: invalid BAR (can't size)
pci 0000:00:00.0: [Firmware Bug]: reg 0x24: invalid BAR (can't size)
pci 0000:00:0a.1: legacy IDE quirk: reg 0x10: [io  0x01f0-0x01f7]
pci 0000:00:0a.1: legacy IDE quirk: reg 0x14: [io  0x03f6]
pci 0000:00:0a.1: legacy IDE quirk: reg 0x18: [io  0x0170-0x0177]
pci 0000:00:0a.1: legacy IDE quirk: reg 0x1c: [io  0x0376]

At which point the kernel doesn't complete and ends up not progressing
beyond this point. Possibly an IRQ gets missed?

Ideas?

--=20
Alex Benn=C3=A9e

