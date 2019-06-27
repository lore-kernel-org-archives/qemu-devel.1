Return-Path: <SRS0=nUPg=U2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15597C48BD7
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 12:04:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 954CB20656
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 12:04:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uK3yTlel"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 954CB20656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49570 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgT8U-00074v-Oq
	for qemu-devel@archiver.kernel.org; Thu, 27 Jun 2019 08:04:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40334)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1hgT4g-0005Xn-9U
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 08:00:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1hgT4e-0000nT-8V
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 08:00:22 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:37272)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1hgT4e-0000cI-1k
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 08:00:20 -0400
Received: by mail-wr1-x443.google.com with SMTP id v14so2249198wrr.4
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2019 05:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:openpgp:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=gm4LdduBLyyw6nCIvzcThbt306btlB/ggeB0XLCY+sQ=;
 b=uK3yTlelAbngnaUvmZrmTXvbV9arCKX4fGA0Z3QMrxd6Mg9cGhzNKcJrz8Qpuq5D43
 0nBDQMy58kYMbn8CAVkSyw4NMUjFCNSlJ7KLZ5OCb+rdU18nB0x66ivxytSlmScmtHeH
 AQ6jgM/r1YDnrha/Zcnp+ZAVx3vKD06FHMr1oQqRQUAeL8puWnfFa/hXei3Tk0ojuT3c
 dB6lJNODfFmufonyCRAkoHajWxlxPolQxHZZdmnWA4cFPmUBIwymDFQIbW2s+E5Xs03e
 ryJGrepfpvlxzPw3WCi+rWch6sM+inr7LeB07O2xDAG7d3jS13tCZOdydf/KgIZHnfB6
 SzXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:openpgp
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=gm4LdduBLyyw6nCIvzcThbt306btlB/ggeB0XLCY+sQ=;
 b=tpvTGJm7Qgi4JlDoW/cABh25rejzmvadYI5lpbIx1TDUiveIlkWfGyuRKQ9pEmM3cw
 MREKz8/FEj0tzCyf/+zwxmRFk9fP5Q6GDPQ5+o16B57md9ilsigupguSxDuM9KcD2VBg
 bWVohjHWd3MkEjT1vRD9UuxuEjf7CoDPGXPCzy1Jrwr1nyHyKOsEoobRcZteGvc9yAeK
 NbV47cs3CjWhVJT3ZBYiCVGdkLnQ7WpC6FAeiduU0F5l+62ZRtHPwsh4zxHEB+7c97lC
 /H12TUHqHspls0XfXkm4B90ChOUKjocK6xruy/sbrXONxusROSOfi6gujo0jsiZ2ofq9
 1rMA==
X-Gm-Message-State: APjAAAWTVEl3qfke8SBKJgLpjALT2tMHqFFh48+77OMn18/tJwHjwVkB
 XCclq1nnOpglI6cDEpxCl1s=
X-Google-Smtp-Source: APXvYqx2hphleOh+E2e33z9JU7nEQ64b9u5aUyXu9+MoXCpbSEKgEurrO5GwppXDAxls6lPex/c9hw==
X-Received: by 2002:a5d:49c4:: with SMTP id t4mr3016754wrs.318.1561636816531; 
 Thu, 27 Jun 2019 05:00:16 -0700 (PDT)
Received: from [192.168.1.38] (183.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.183])
 by smtp.gmail.com with ESMTPSA id v4sm6340821wmg.22.2019.06.27.05.00.14
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Thu, 27 Jun 2019 05:00:15 -0700 (PDT)
To: qemu-devel@nongnu.org
References: <20190627110201.1999-1-f4bug@amsat.org>
 <20190627110201.1999-2-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Openpgp: url=http://pgp.mit.edu/pks/lookup?op=get&search=0xE3E32C2CDEADC0DE
Message-ID: <86219d39-81e4-9796-f0ca-d1389b1608b0@amsat.org>
Date: Thu, 27 Jun 2019 14:00:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190627110201.1999-2-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: Re: [Qemu-devel] [PATCH 1/5] tests/acceptance: Add test that runs
 NetBSD installer on PRep/40p
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
Cc: Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>,
 Thomas Huth <huth@tuxfamily.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Kamil Rytarowski <kamil@netbsd.org>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

typo "PRep" -> "PReP" in patch subject

On 6/27/19 1:01 PM, Philippe Mathieu-Daudé wrote:
> User case from:
> http://mail-index.netbsd.org/port-prep/2017/04/11/msg000112.html
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  tests/acceptance/ppc_prep_40p.py | 63 ++++++++++++++++++++++++++++++++
>  1 file changed, 63 insertions(+)
>  create mode 100644 tests/acceptance/ppc_prep_40p.py

Hervé, in v2 I plan to rename it machine_ppc_prep_40p.py and add an
entry in MAINTAINERS:

-- >8 --
diff --git a/MAINTAINERS b/MAINTAINERS
@@ -1051,6 +1051,7 @@ F: hw/timer/m48t59-isa.c
 F: include/hw/isa/pc87312.h
 F: include/hw/timer/m48t59.h
 F: pc-bios/ppc_rom.bin
+F: tests/acceptance/machine_ppc_prep_40p.py

---

> 
> diff --git a/tests/acceptance/ppc_prep_40p.py b/tests/acceptance/ppc_prep_40p.py
> new file mode 100644
> index 0000000000..53f2d2ecf0
> --- /dev/null
> +++ b/tests/acceptance/ppc_prep_40p.py
> @@ -0,0 +1,63 @@
> +# Functional test that boots a PReP/40p machine and checks its serial console.
> +#
> +# Copyright (c) Philippe Mathieu-Daudé <f4bug@amsat.org>
> +#
> +# This work is licensed under the terms of the GNU GPL, version 2 or
> +# later. See the COPYING file in the top-level directory.
> +
> +import os
> +import logging
> +
> +from avocado import skipIf
> +from avocado_qemu import Test
> +
> +
> +class IbmPrep40pMachine(Test):
> +
> +    timeout = 60
> +
> +    # TODO refactor to MachineTest
> +    def wait_for_console_pattern(self, success_message, failure_message=None):
> +        """
> +        Waits for messages to appear on the console, while logging the content
> +
> +        :param success_message: if this message appears, test succeeds
> +        :param failure_message: if this message appears, test fails
> +        """
> +        console = self.vm.console_socket.makefile()
> +        console_logger = logging.getLogger('console')
> +        while True:
> +            msg = console.readline().strip()
> +            if not msg:
> +                continue
> +            console_logger.debug(msg)
> +            if success_message in msg:
> +                break
> +            if failure_message and failure_message in msg:
> +                fail = 'Failure message found in console: %s' % failure_message
> +                self.fail(fail)
> +
> +    @skipIf(os.getenv('CONTINUOUS_INTEGRATION'), 'Running on Travis-CI')
> +    def test_factory_firmware_and_netbsd(self):
> +        """
> +        :avocado: tags=arch:ppc
> +        :avocado: tags=machine:40p
> +        :avocado: tags=slowness:high
> +        """
> +        bios_url = ('ftp://ftp.boulder.ibm.com/rs6000/firmware/'
> +                    '7020-40p/P12H0456.IMG')
> +        bios_hash = '1775face4e6dc27f3a6ed955ef6eb331bf817f03'
> +        bios_path = self.fetch_asset(bios_url, asset_hash=bios_hash)
> +        drive_url = ('https://ftp.netbsd.org/pub/NetBSD/NetBSD-archive/'
> +                     'NetBSD-4.0/prep/installation/floppy/generic_com0.fs')
> +        drive_hash = 'dbcfc09912e71bd5f0d82c7c1ee43082fb596ceb'
> +        drive_path = self.fetch_asset(drive_url, asset_hash=drive_hash)
> +
> +        self.vm.set_machine('40p')
> +        self.vm.set_console()
> +        self.vm.add_args('-bios', bios_path,
> +                         '-fda', drive_path)
> +        self.vm.launch()
> +        os_banner = 'NetBSD 4.0 (GENERIC) #0: Sun Dec 16 00:49:40 PST 2007'
> +        self.wait_for_console_pattern(os_banner)
> +        self.wait_for_console_pattern('Model: IBM PPS Model 6015')
> 

