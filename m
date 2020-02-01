Return-Path: <SRS0=CCzH=3V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 797D0C35249
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2020 22:18:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EBC620643
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2020 22:18:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cKm864uG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EBC620643
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51156 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iy15j-0007HN-D0
	for qemu-devel@archiver.kernel.org; Sat, 01 Feb 2020 17:18:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38313)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iy14g-0006kP-RI
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 17:17:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iy14e-0004Y6-VF
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 17:17:10 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:32946)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iy14X-0004X8-79; Sat, 01 Feb 2020 17:17:01 -0500
Received: by mail-wm1-x342.google.com with SMTP id m10so11466283wmc.0;
 Sat, 01 Feb 2020 14:17:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=vRa+GHdgQR9xYJ5AT1pyCqgSUaKXcTwVPlr8NMMgRJQ=;
 b=cKm864uGxfcP3a5HOslKEG80pJNegLtvT7LH46No2/tcldC+woGTgcjTmunUaofGMZ
 LSy+snPEcx0ERfTnkcwBDZtuE50lQ017GquXgmb8fgB4rD90LDqrjIPaUluh8EGI8Eoo
 sNfiUFuS6Ovsl+uJpWTAcXdb2+U2PztuR2Jj8WOHkElk4eNF3VO7bSh6LChHThOEnRds
 ylukKJ4M/U9NEs2OukSjhd8Qid9Z3D6WcWPR54hnv9oxrljogfkZRNDU5c5c47tc6uTl
 u76yMUMKDIrgEHbkSWs14JHcpTpbro8Xq1FBV4q3dpr8JGLYaRME37lYsoxJGN9dkhpd
 xNJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=vRa+GHdgQR9xYJ5AT1pyCqgSUaKXcTwVPlr8NMMgRJQ=;
 b=mSOGSq4WfrKBPv5Uqfiy2OYyFYzTX0LYSpgjsRfYQ+hChMNRC/M3fkhjaxLqdsPy0r
 lOiR6YQKD5wz0Zrv/gDC7c9R9AdHOt/eBBsNnjBLm5UIjSNAB4wzdk+fp9nGO0Sugt9o
 Eja9WYM23QqWWBob3OCx8d3szd7OLY5+BFott3jHWIqj95DjTfW6KMD85c7SfHyPqDl2
 kkhvPiNENcTT16FXZq5KqiHfjfjnOzvHcm93ixEGRl/YGPh6VtmsOE+UdscLZis+nmK9
 M1nPovueg2DGxKDOyAuAmJi6fy772yLcJb47MZFpfL7wzCD2l3+D3tHS6W7te9zMwOK1
 kR6g==
X-Gm-Message-State: APjAAAVMV1+Uf97K4BNro0gngc9pJqU/q7iknZ23FplunBAlvl8mOpct
 6oX7mM+x3fIFWKrfxXCCAhc=
X-Google-Smtp-Source: APXvYqwZR0mmuJs8npwFF8g6bnM1VPKJ7sdnXxLYVjvD27CMXZN6zVdXEBdvTBh/uuplAG+hqnfpaQ==
X-Received: by 2002:a1c:a514:: with SMTP id o20mr11846615wme.179.1580595419829; 
 Sat, 01 Feb 2020 14:16:59 -0800 (PST)
Received: from [192.168.1.35] (162.red-83-52-55.dynamicip.rima-tde.net.
 [83.52.55.162])
 by smtp.gmail.com with ESMTPSA id t81sm16515996wmg.6.2020.02.01.14.16.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 01 Feb 2020 14:16:59 -0800 (PST)
Subject: Re: [PATCH] tests/acceptance: Count multiple Tux logos displayed on
 framebuffer
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
References: <20200201204751.17810-1-f4bug@amsat.org>
 <CAL1e-=iA99dGqDMy7mtGtiSv7EmXG3SoxvUr-gh-ierMoWzvcw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Autocrypt: addr=f4bug@amsat.org; keydata=
 mQINBDU8rLoBEADb5b5dyglKgWF9uDbIjFXU4gDtcwiga9wJ/wX6xdhBqU8tlQ4BroH7AeRl
 u4zXP0QnBDAG7EetxlQzcfYbPmxFISWjckDBFvDbFsojrZmwF2/LkFSzlvKiN5KLghzzJhLO
 HhjGlF8deEZz/d/G8qzO9mIw8GIBS8uuWh6SIcG/qq7+y+2+aifaj92EdwU79apZepT/U3vN
 YrfcAuo1Ycy7/u0hJ7rlaFUn2Fu5KIgV2O++hHYtCCQfdPBg/+ujTL+U+sCDawCyq+9M5+LJ
 ojCzP9rViLZDd/gS6jX8T48hhidtbtsFRj/e9QpdZgDZfowRMVsRx+TB9yzjFdMO0YaYybXp
 dg/wCUepX5xmDBrle6cZ8VEe00+UQCAU1TY5Hs7QFfBbjgR3k9pgJzVXNUKcJ9DYQP0OBH9P
 ZbZvM0Ut2Bk6bLBO5iCVDOco0alrPkX7iJul2QWBy3Iy9j02GnA5jZ1Xtjr9kpCqQT+sRXso
 Vpm5TPGWaWljIeLWy/qL8drX1eyJzwTB3A36Ck4r3YmjMjfmvltSZB1uAdo1elHTlFEULpU/
 HiwvvqXQ9koB15U154VCuguvx/Qnboz8GFb9Uw8VyawzVxYVNME7xw7CQF8FYxzj6eI7rBf2
 Dj/II6wxWPgDEy3oUzuNOxTB7sT3b/Ym76yOJzWX5BylXQIJ5wARAQABtDFQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoRjRCVUcpIDxmNGJ1Z0BhbXNhdC5vcmc+iQJVBBMBCAA/AhsPBgsJ
 CAcDAgYVCAIJCgsEFgIDAQIeAQIXgBYhBPqr514SkXIh3P1rsuPjLCzercDeBQJd660aBQks
 klzgAAoJEOPjLCzercDe2iMP+gMG2dUf+qHz2uG8nTBGMjgK0aEJrKVPodFA+iedQ5Kp3BMo
 jrTg3/DG1HMYdcvQu/NFLYwamUfUasyor1k+3dB23hY09O4xOsYJBWdilkBGsJTKErUmkUO2
 3J/kawosvYtJJSHUpw3N6mwz/iWnjkT8BPp7fFXSujV63aZWZINueTbK7Y8skFHI0zpype9s
 loU8xc4JBrieGccy3n4E/kogGrTG5jcMTNHZ106DsQkhFnjhWETp6g9xOKrzZQbETeRBOe4P
 sRsY9YSG2Sj+ZqmZePvO8LyzGRjYU7T6Z80S1xV0lH6KTMvq7vvz5rd92f3pL4YrXq+e//HZ
 JsiLen8LH/FRhTsWRgBtNYkOsd5F9NvfJtSM0qbX32cSXMAStDVnS4U+H2vCVCWnfNug2TdY
 7v4NtdpaCi4CBBa3ZtqYVOU05IoLnlx0miKTBMqmI05kpgX98pi2QUPJBYi/+yNu3fjjcuS9
 K5WmpNFTNi6yiBbNjJA5E2qUKbIT/RwQFQvhrxBUcRCuK4x/5uOZrysjFvhtR8YGm08h+8vS
 n0JCnJD5aBhiVdkohEFAz7e5YNrAg6kOA5IVRHB44lTBOatLqz7ntwdGD0rteKuHaUuXpTYy
 CRqCVAKqFJtxhvJvaX0vLS1Z2dwtDwhjfIdgPiKEGOgCNGH7R8l+aaM4OPOd
Message-ID: <ec2eb60f-d46f-20f5-3867-a1bda763caa6@amsat.org>
Date: Sat, 1 Feb 2020 23:16:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAL1e-=iA99dGqDMy7mtGtiSv7EmXG3SoxvUr-gh-ierMoWzvcw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Thomas Huth <huth@tuxfamily.org>,
 Leon Alrae <leon.alrae@imgtec.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, qemu-arm@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/1/20 9:58 PM, Aleksandar Markovic wrote:
> 21:48 Sub, 01.02.2020. Philippe Mathieu-Daudé <f4bug@amsat.org
> <mailto:f4bug@amsat.org>> је написао/ла:
>>
>> Add a test that verifies that each core properly displays the Tux
>> logo on the framebuffer device.
>>
> 
> Excellent test!
> 
> Glad that Leon blog post was the inspiration. I'll email him about this,
> if I find his address, one of my colegues might have it.
> 
> I don't have dev setup at hand, is 8 cores limit? I think it is. If not,
> perhaps you can push the limit with 16 tuxes.

I tried, QEMU instantiates the 16 cores but the kernel only initialize
8. I don't see any restriction on the kernel side. Maybe some QEMU
device is slashing a value.

16 is the upper limit of the Malta machine, however this doesn't seem to
make much sense, the limit should be on the CPU used (or better, the
daughter card used).

1438 static void mips_malta_machine_init(MachineClass *mc)
1439 {
1440     mc->desc = "MIPS Malta Core LV";
1441     mc->init = mips_malta_init;
1442     mc->block_default_type = IF_IDE;
1443     mc->max_cpus = 16;

> 
> THANK YOU, PHILIPPE!

You are welcome :)

> 
> Aleksandar
> 
>> We simply follow the OpenCV "Template Matching with Multiple Objects"
>> tutorial, replacing Lionel Messi by Tux:
>> https://docs.opencv.org/4.2.0/d4/dc6/tutorial_py_template_matching.html
>>
>> When OpenCV and NumPy are installed, this test can be run using:
>>
>>   $ avocado --show=app,framebuffer \
>>     run -t cpu:i6400 \
>>     tests/acceptance/machine_mips_malta.py
>>   JOB ID     : 54f3d8efd8674f289b8aa01a87f5d70c5814544c
>>   JOB LOG    : avocado/job-results/job-2020-02-01T20.52-54f3d8e/job.log
>>    (1/3)
> tests/acceptance/machine_mips_malta.py:MaltaMachineFramebuffer.test_mips_malta_i6400_framebuffer_logo_1core:
>>   framebuffer: found Tux at position (x, y) = (0, 0)
>>   PASS (3.37 s)
>>    (2/3)
> tests/acceptance/machine_mips_malta.py:MaltaMachineFramebuffer.test_mips_malta_i6400_framebuffer_logo_7cores:
>>   framebuffer: found Tux at position (x, y) = (0, 0)
>>   framebuffer: found Tux at position (x, y) = (88, 0)
>>   framebuffer: found Tux at position (x, y) = (176, 0)
>>   framebuffer: found Tux at position (x, y) = (264, 0)
>>   framebuffer: found Tux at position (x, y) = (352, 0)
>>   framebuffer: found Tux at position (x, y) = (440, 0)
>>   framebuffer: found Tux at position (x, y) = (528, 0)
>>   PASS (5.80 s)
>>    (3/3)
> tests/acceptance/machine_mips_malta.py:MaltaMachineFramebuffer.test_mips_malta_i6400_framebuffer_logo_8cores:
>>   framebuffer: found Tux at position (x, y) = (0, 0)
>>   framebuffer: found Tux at position (x, y) = (88, 0)
>>   framebuffer: found Tux at position (x, y) = (176, 0)
>>   framebuffer: found Tux at position (x, y) = (264, 0)
>>   framebuffer: found Tux at position (x, y) = (352, 0)
>>   framebuffer: found Tux at position (x, y) = (440, 0)
>>   framebuffer: found Tux at position (x, y) = (528, 0)
>>   framebuffer: found Tux at position (x, y) = (616, 0)
>>   PASS (6.67 s)
>>   RESULTS    : PASS 3 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT
> 0 | CANCEL 0
>>   JOB TIME   : 16.79 s
>>
>> If the AVOCADO_CV2_SCREENDUMP_PNG_PATH environment variable is set, the
>> test will save the screenshot with matched squares to it.
>>
>> Test inspired by the following post:
>>
> https://www.mips.com/blog/how-to-run-smp-linux-in-qemu-on-a-mips64-release-6-cpu/
>> Kernel built with the following Docker file:
>>
> https://github.com/philmd/qemu-testing-blob/blob/malta_i6400/mips/malta/mips64el/Dockerfile
>>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org
> <mailto:f4bug@amsat.org>>
>> ---
>> The resulting match can be visualised at https://pasteboard.co/ISIj6ZA.png
>> Generated using:
>>
>>   $ AVOCADO_CV2_SCREENDUMP_PNG_PATH=/tmp/screendump_matched.png \
>>     avocado --show=app run -t cpu:i6400 \
>>     tests/acceptance/machine_mips_malta.py
>>   JOB ID     : 54f3d8efd8674f289b8aa01a87f5d70c5814544c
>>   JOB LOG    : avocado/job-results/job-2020-02-01T20.52-54f3d8e/job.log
>>    (1/3)
> tests/acceptance/machine_mips_malta.py:MaltaMachineFramebuffer.test_mips_malta_i6400_framebuffer_logo_1core:
> PASS (3.37 s)
>>    (2/3)
> tests/acceptance/machine_mips_malta.py:MaltaMachineFramebuffer.test_mips_malta_i6400_framebuffer_logo_7cores:
> PASS (5.80 s)
>>    (3/3)
> tests/acceptance/machine_mips_malta.py:MaltaMachineFramebuffer.test_mips_malta_i6400_framebuffer_logo_8cores:
> PASS (6.67 s)
>>   RESULTS    : PASS 3 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT
> 0 | CANCEL 0
>>   JOB TIME   : 16.79 s
>> ---
>>  MAINTAINERS                            |   1 +
>>  tests/acceptance/machine_mips_malta.py | 116 +++++++++++++++++++++++++
>>  2 files changed, 117 insertions(+)
>>  create mode 100644 tests/acceptance/machine_mips_malta.py
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 4ceb1ad882..65a3dfb564 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -983,6 +983,7 @@ F: hw/mips/mips_malta.c
>>  F: hw/mips/gt64xxx_pci.c
>>  F: include/hw/southbridge/piix.h
>>  F: tests/acceptance/linux_ssh_mips_malta.py
>> +F: tests/acceptance/machine_mips_malta.py
>>
>>  Mipssim
>>  M: Aleksandar Markovic <amarkovic@wavecomp.com
> <mailto:amarkovic@wavecomp.com>>
>> diff --git a/tests/acceptance/machine_mips_malta.py
> b/tests/acceptance/machine_mips_malta.py
>> new file mode 100644
>> index 0000000000..2764143d15
>> --- /dev/null
>> +++ b/tests/acceptance/machine_mips_malta.py
>> @@ -0,0 +1,116 @@
>> +# Functional tests for the MIPS Malta board
>> +#
>> +# Copyright (c) Philippe Mathieu-Daudé <f4bug@amsat.org
> <mailto:f4bug@amsat.org>>
>> +#
>> +# This work is licensed under the terms of the GNU GPL, version 2 or
> later.
>> +# See the COPYING file in the top-level directory.
>> +#
>> +# SPDX-License-Identifier: GPL-2.0-or-later
>> +
>> +import os
>> +import gzip
>> +import logging
>> +
>> +from avocado import skipUnless
>> +from avocado_qemu import Test
>> +from avocado_qemu import wait_for_console_pattern
>> +from avocado.utils import archive
>> +
>> +
>> +NUMPY_AVAILABLE = True
>> +try:
>> +    import numpy as np
>> +except ImportError:
>> +    NUMPY_AVAILABLE = False
>> +
>> +CV2_AVAILABLE = True
>> +try:
>> +    import cv2
>> +except ImportError:
>> +    CV2_AVAILABLE = False
>> +
>> +
>> +@skipUnless(NUMPY_AVAILABLE, 'Python NumPy not installed')
>> +@skipUnless(CV2_AVAILABLE, 'Python OpenCV not installed')
>> +class MaltaMachineFramebuffer(Test):
>> +
>> +    timeout = 30
>> +
>> +    KERNEL_COMMON_COMMAND_LINE = 'printk.time=0 '
>> +
>> +    def do_test_i6400_framebuffer_logo(self, cpu_cores_count):
>> +        """
>> +        Boot Linux kernel and check Tux logo is displayed on the
> framebuffer.
>> +        """
>> +        screendump_path = os.path.join(self.workdir, 'screendump.pbm')
>> +
>> +        kernel_url = ('https://github.com/philmd/qemu-testing-blob/raw/'
>> +                      'a5966ca4b5/mips/malta/mips64el/'
>> +                      'vmlinux-4.7.0-rc1.I6400.gz')
>> +        kernel_hash = '096f50c377ec5072e6a366943324622c312045f6'
>> +        kernel_path_gz = self.fetch_asset(kernel_url,
> asset_hash=kernel_hash)
>> +        kernel_path = self.workdir + "vmlinux"
>> +        archive.gzip_uncompress(kernel_path_gz, kernel_path)
>> +
>> +        tuxlogo_url = ('https://github.com/torvalds/linux/raw/v2.6.12/'
>> +                       'drivers/video/logo/logo_linux_vga16.ppm')
>> +        tuxlogo_hash = '3991c2ddbd1ddaecda7601f8aafbcf5b02dc86af'
>> +        tuxlogo_path = self.fetch_asset(tuxlogo_url,
> asset_hash=tuxlogo_hash)
>> +
>> +        self.vm.set_console()
>> +        kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
>> +                               'clocksource=GIC console=tty0
> console=ttyS0')
>> +        self.vm.add_args('-kernel', kernel_path,
>> +                         '-cpu', 'I6400',
>> +                         '-smp', '%u' % cpu_cores_count,
>> +                         '-vga', 'std',
>> +                         '-append', kernel_command_line)
>> +        self.vm.launch()
>> +        framebuffer_ready = 'Console: switching to colour frame
> buffer device'
>> +        wait_for_console_pattern(self, framebuffer_ready,
>> +                                 failure_message='Kernel panic - not
> syncing')
>> +        self.vm.command('human-monitor-command', command_line='stop')
>> +        self.vm.command('human-monitor-command',
>> +                        command_line='screendump %s' % screendump_path)
>> +        logger = logging.getLogger('framebuffer')
>> +
>> +        match_threshold = 0.95
>> +        screendump_bgr = cv2.imread(screendump_path, cv2.IMREAD_COLOR)
>> +        tuxlogo_bgr = cv2.imread(tuxlogo_path, cv2.IMREAD_COLOR)
>> +        result = cv2.matchTemplate(screendump_bgr, tuxlogo_bgr,
>> +                                   cv2.TM_CCOEFF_NORMED)
>> +        loc = np.where(result >= match_threshold)
>> +        tuxlogo_count = 0
>> +        h, w = tuxlogo_bgr.shape[:2]
>> +        debug_png = os.getenv('AVOCADO_CV2_SCREENDUMP_PNG_PATH')
>> +        for tuxlogo_count, pt in enumerate(zip(*loc[::-1]), start=1):
>> +            logger.debug('found Tux at position (x, y) = %s', pt)
>> +            cv2.rectangle(screendump_bgr, pt,
>> +                          (pt[0] + w, pt[1] + h), (0, 0, 255), 2)
>> +        if debug_png:
>> +            cv2.imwrite(debug_png, screendump_bgr)
>> +        self.assertGreaterEqual(tuxlogo_count, cpu_cores_count)
>> +
>> +    def test_mips_malta_i6400_framebuffer_logo_1core(self):
>> +        """
>> +        :avocado: tags=arch:mips64el
>> +        :avocado: tags=machine:malta
>> +        :avocado: tags=cpu:i6400
>> +        """
>> +        self.do_test_i6400_framebuffer_logo(1)
>> +
>> +    def test_mips_malta_i6400_framebuffer_logo_7cores(self):
>> +        """
>> +        :avocado: tags=arch:mips64el
>> +        :avocado: tags=machine:malta
>> +        :avocado: tags=cpu:i6400
>> +        """
>> +        self.do_test_i6400_framebuffer_logo(7)
>> +
>> +    def test_mips_malta_i6400_framebuffer_logo_8cores(self):
>> +        """
>> +        :avocado: tags=arch:mips64el
>> +        :avocado: tags=machine:malta
>> +        :avocado: tags=cpu:i6400
>> +        """
>> +        self.do_test_i6400_framebuffer_logo(8)
>> --
>> 2.21.1
>>
>>
> 

