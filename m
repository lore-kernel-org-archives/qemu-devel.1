Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C06F2C34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 18:13:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DD7621D56
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 18:13:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ULJs8M2G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DD7621D56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j47Mn-0006UB-Jl
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 13:13:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33169)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pmathieu@redhat.com>) id 1j47M1-0005sO-VL
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 13:12:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pmathieu@redhat.com>) id 1j47Lz-0001Bv-9d
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 13:12:17 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:48809
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pmathieu@redhat.com>) id 1j47Lz-00018U-6A
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 13:12:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582049533;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wML/uJ+u0MDichbvEgerDbC1wySMifI8PwyDwt83/9s=;
 b=ULJs8M2GT64EPmfc/Y8ucf1Yx1aadAEoSMIoTpoon9CwZWJUK7xj7UvN6HWMT+eKv90yeO
 WOuy8NkC5F1xmAcfSsTpgpNkf17PflSdA6R3yXC9a8YRY41wP3q2Ri09nBXlXbdTJMX21u
 7Go6sGSs2ud9PZIdO7o2UClkf5Hkw58=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-385-11rmyfarNsyP5vXuV7unBA-1; Tue, 18 Feb 2020 13:12:04 -0500
Received: by mail-wr1-f72.google.com with SMTP id n23so11237277wra.20
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2020 10:12:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=wML/uJ+u0MDichbvEgerDbC1wySMifI8PwyDwt83/9s=;
 b=MZh9XpwsPhCogR6k9pBgHcGsHIYvQ3faSdfKz5lt1wwXCyKKh6AGuVKM1t2pNnrUbR
 WMgGPskrwKdD7t9sHdN5LnYSt6hvipClv1702s9MlBoHk0GMPPfRDiTPjpBNpKwz2xfY
 27u+nuIcxNmcHpaxQ0hj29p4JMQ8adNk+YCVO3ARZF3n563P/yI7jzVhxaR9sMp0yjeI
 MAKm7s54+67yuaAth6H3yVcuI/S4G4yFyVGg67F2wn9zjmsetw+TOTIQyjzWWaq7TgGI
 uEt/toxZxO6zo+X1pqc5btltjICz52ydCPS58fuOZjT56f2UMxkoiGWMCsYf0dbAzC+Z
 QVng==
X-Gm-Message-State: APjAAAVXNjzlfGcx9kABPd5uYCF07hlFzzy0rs27pvUi7vkh/FiBib0J
 rh8hANvglFxoNbYBCxwaGjUt49+ykPtXPEfUYX0VN+7d3B9ffjmG+zzYgRiK5RcJfM2yHS9s+ym
 ErcLiYwkdXCt0ML3RdZ22DJa3Smjyh7Y=
X-Received: by 2002:adf:fa50:: with SMTP id y16mr32281946wrr.204.1582049522820; 
 Tue, 18 Feb 2020 10:12:02 -0800 (PST)
X-Google-Smtp-Source: APXvYqywoy3sIhgDxlMZvXoraL0KhwI0/oRNQHH8Pg3Q6RBavqEyAX2rSmMmGlpUOU7UxbCnkYM7Nh0ub/ukpuDYPYM=
X-Received: by 2002:adf:fa50:: with SMTP id y16mr32281902wrr.204.1582049522527; 
 Tue, 18 Feb 2020 10:12:02 -0800 (PST)
MIME-Version: 1.0
References: <20200201204751.17810-1-f4bug@amsat.org>
 <CAL1e-=gLg0tDH8nKtC6W6jrooGbJ=iV=X1KXDBH--cTWOV-Jxg@mail.gmail.com>
In-Reply-To: <CAL1e-=gLg0tDH8nKtC6W6jrooGbJ=iV=X1KXDBH--cTWOV-Jxg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Date: Tue, 18 Feb 2020 19:11:51 +0100
Message-ID: <CAP+75-V__ACHRUWKb=U+B27Z9=FJ7_H6N_NTs=QpyDP59WK5Xw@mail.gmail.com>
Subject: Re: [PATCH] tests/acceptance: Count multiple Tux logos displayed on
 framebuffer
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
X-MC-Unique: 11rmyfarNsyP5vXuV7unBA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>, Cleber Rosa <crosa@redhat.com>,
 Leon Alrae <leon.alrae@imgtec.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Aleksandar,

On Tue, Feb 18, 2020 at 7:07 PM Aleksandar Markovic
<aleksandar.m.mail@gmail.com> wrote:
> On Saturday, February 1, 2020, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg> wrote:
>>
>> Add a test that verifies that each core properly displays the Tux
>> logo on the framebuffer device.
>>
>> We simply follow the OpenCV "Template Matching with Multiple Objects"
>> tutorial, replacing Lionel Messi by Tux:
>> https://docs.opencv.org/4.2.0/d4/dc6/tutorial_py_template_matching.html
>>
>> When OpenCV and NumPy are installed, this test can be run using:
>>
>>   $ avocado --show=3Dapp,framebuffer \
>>     run -t cpu:i6400 \
>>     tests/acceptance/machine_mips_malta.py
>>   JOB ID     : 54f3d8efd8674f289b8aa01a87f5d70c5814544c
>>   JOB LOG    : avocado/job-results/job-2020-02-01T20.52-54f3d8e/job.log
>>    (1/3) tests/acceptance/machine_mips_malta.py:MaltaMachineFramebuffer.=
test_mips_malta_i6400_framebuffer_logo_1core:
>>   framebuffer: found Tux at position (x, y) =3D (0, 0)
>>   PASS (3.37 s)
>>    (2/3) tests/acceptance/machine_mips_malta.py:MaltaMachineFramebuffer.=
test_mips_malta_i6400_framebuffer_logo_7cores:
>>   framebuffer: found Tux at position (x, y) =3D (0, 0)
>>   framebuffer: found Tux at position (x, y) =3D (88, 0)
>>   framebuffer: found Tux at position (x, y) =3D (176, 0)
>>   framebuffer: found Tux at position (x, y) =3D (264, 0)
>>   framebuffer: found Tux at position (x, y) =3D (352, 0)
>>   framebuffer: found Tux at position (x, y) =3D (440, 0)
>>   framebuffer: found Tux at position (x, y) =3D (528, 0)
>>   PASS (5.80 s)
>>    (3/3) tests/acceptance/machine_mips_malta.py:MaltaMachineFramebuffer.=
test_mips_malta_i6400_framebuffer_logo_8cores:
>>   framebuffer: found Tux at position (x, y) =3D (0, 0)
>>   framebuffer: found Tux at position (x, y) =3D (88, 0)
>>   framebuffer: found Tux at position (x, y) =3D (176, 0)
>>   framebuffer: found Tux at position (x, y) =3D (264, 0)
>>   framebuffer: found Tux at position (x, y) =3D (352, 0)
>>   framebuffer: found Tux at position (x, y) =3D (440, 0)
>>   framebuffer: found Tux at position (x, y) =3D (528, 0)
>>   framebuffer: found Tux at position (x, y) =3D (616, 0)
>>   PASS (6.67 s)
>>   RESULTS    : PASS 3 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT 0=
 | CANCEL 0
>>   JOB TIME   : 16.79 s
>>
>> If the AVOCADO_CV2_SCREENDUMP_PNG_PATH environment variable is set, the
>> test will save the screenshot with matched squares to it.
>>
>> Test inspired by the following post:
>> https://www.mips.com/blog/how-to-run-smp-linux-in-qemu-on-a-mips64-relea=
se-6-cpu/
>> Kernel built with the following Docker file:
>> https://github.com/philmd/qemu-testing-blob/blob/malta_i6400/mips/malta/=
mips64el/Dockerfile
>>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> ---
>> The resulting match can be visualised at https://pasteboard.co/ISIj6ZA.p=
ng
>> Generated using:
>>
>>   $ AVOCADO_CV2_SCREENDUMP_PNG_PATH=3D/tmp/screendump_matched.png \
>>     avocado --show=3Dapp run -t cpu:i6400 \
>>     tests/acceptance/machine_mips_malta.py
>>   JOB ID     : 54f3d8efd8674f289b8aa01a87f5d70c5814544c
>>   JOB LOG    : avocado/job-results/job-2020-02-01T20.52-54f3d8e/job.log
>>    (1/3) tests/acceptance/machine_mips_malta.py:MaltaMachineFramebuffer.=
test_mips_malta_i6400_framebuffer_logo_1core: PASS (3.37 s)
>>    (2/3) tests/acceptance/machine_mips_malta.py:MaltaMachineFramebuffer.=
test_mips_malta_i6400_framebuffer_logo_7cores: PASS (5.80 s)
>>    (3/3) tests/acceptance/machine_mips_malta.py:MaltaMachineFramebuffer.=
test_mips_malta_i6400_framebuffer_logo_8cores: PASS (6.67 s)
>>   RESULTS    : PASS 3 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT 0=
 | CANCEL 0
>>   JOB TIME   : 16.79 s
>> ---
>
>
> Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
>
> I may add this file to yet another section in MAINTAINTERS (main MIPS tar=
get section) (I'll do it while applying, no need to respin), since its impo=
rtance is significant (tests MIPS' smp fearure).

Hmm you mean the "MIPS TCG CPUs"? Yes why not.

>
> Once again, a gorgeous test!

Thanks :)

>
> Aleksandar
>
>>
>>  MAINTAINERS                            |   1 +
>>  tests/acceptance/machine_mips_malta.py | 116 +++++++++++++++++++++++++
>>  2 files changed, 117 insertions(+)
>>  create mode 100644 tests/acceptance/machine_mips_malta.py
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 4ceb1ad882..65a3dfb564 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -983,6 +983,7 @@ F: hw/mips/mips_malta.c
>>  F: hw/mips/gt64xxx_pci.c
>>  F: include/hw/southbridge/piix.h
>>  F: tests/acceptance/linux_ssh_mips_malta.py
>> +F: tests/acceptance/machine_mips_malta.py
>>
>>  Mipssim
>>  M: Aleksandar Markovic <amarkovic@wavecomp.com>
>> diff --git a/tests/acceptance/machine_mips_malta.py b/tests/acceptance/m=
achine_mips_malta.py
>> new file mode 100644
>> index 0000000000..2764143d15
>> --- /dev/null
>> +++ b/tests/acceptance/machine_mips_malta.py
>> @@ -0,0 +1,116 @@
>> +# Functional tests for the MIPS Malta board
>> +#
>> +# Copyright (c) Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> +#
>> +# This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
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
>> +NUMPY_AVAILABLE =3D True
>> +try:
>> +    import numpy as np
>> +except ImportError:
>> +    NUMPY_AVAILABLE =3D False
>> +
>> +CV2_AVAILABLE =3D True
>> +try:
>> +    import cv2
>> +except ImportError:
>> +    CV2_AVAILABLE =3D False
>> +
>> +
>> +@skipUnless(NUMPY_AVAILABLE, 'Python NumPy not installed')
>> +@skipUnless(CV2_AVAILABLE, 'Python OpenCV not installed')
>> +class MaltaMachineFramebuffer(Test):
>> +
>> +    timeout =3D 30
>> +
>> +    KERNEL_COMMON_COMMAND_LINE =3D 'printk.time=3D0 '
>> +
>> +    def do_test_i6400_framebuffer_logo(self, cpu_cores_count):
>> +        """
>> +        Boot Linux kernel and check Tux logo is displayed on the frameb=
uffer.
>> +        """
>> +        screendump_path =3D os.path.join(self.workdir, 'screendump.pbm'=
)
>> +
>> +        kernel_url =3D ('https://github.com/philmd/qemu-testing-blob/ra=
w/'
>> +                      'a5966ca4b5/mips/malta/mips64el/'
>> +                      'vmlinux-4.7.0-rc1.I6400.gz')
>> +        kernel_hash =3D '096f50c377ec5072e6a366943324622c312045f6'
>> +        kernel_path_gz =3D self.fetch_asset(kernel_url, asset_hash=3Dke=
rnel_hash)
>> +        kernel_path =3D self.workdir + "vmlinux"
>> +        archive.gzip_uncompress(kernel_path_gz, kernel_path)
>> +
>> +        tuxlogo_url =3D ('https://github.com/torvalds/linux/raw/v2.6.12=
/'
>> +                       'drivers/video/logo/logo_linux_vga16.ppm')
>> +        tuxlogo_hash =3D '3991c2ddbd1ddaecda7601f8aafbcf5b02dc86af'
>> +        tuxlogo_path =3D self.fetch_asset(tuxlogo_url, asset_hash=3Dtux=
logo_hash)
>> +
>> +        self.vm.set_console()
>> +        kernel_command_line =3D (self.KERNEL_COMMON_COMMAND_LINE +
>> +                               'clocksource=3DGIC console=3Dtty0 consol=
e=3DttyS0')
>> +        self.vm.add_args('-kernel', kernel_path,
>> +                         '-cpu', 'I6400',
>> +                         '-smp', '%u' % cpu_cores_count,
>> +                         '-vga', 'std',
>> +                         '-append', kernel_command_line)
>> +        self.vm.launch()
>> +        framebuffer_ready =3D 'Console: switching to colour frame buffe=
r device'
>> +        wait_for_console_pattern(self, framebuffer_ready,
>> +                                 failure_message=3D'Kernel panic - not =
syncing')
>> +        self.vm.command('human-monitor-command', command_line=3D'stop')
>> +        self.vm.command('human-monitor-command',
>> +                        command_line=3D'screendump %s' % screendump_pat=
h)
>> +        logger =3D logging.getLogger('framebuffer')
>> +
>> +        match_threshold =3D 0.95
>> +        screendump_bgr =3D cv2.imread(screendump_path, cv2.IMREAD_COLOR=
)
>> +        tuxlogo_bgr =3D cv2.imread(tuxlogo_path, cv2.IMREAD_COLOR)
>> +        result =3D cv2.matchTemplate(screendump_bgr, tuxlogo_bgr,
>> +                                   cv2.TM_CCOEFF_NORMED)
>> +        loc =3D np.where(result >=3D match_threshold)
>> +        tuxlogo_count =3D 0
>> +        h, w =3D tuxlogo_bgr.shape[:2]
>> +        debug_png =3D os.getenv('AVOCADO_CV2_SCREENDUMP_PNG_PATH')
>> +        for tuxlogo_count, pt in enumerate(zip(*loc[::-1]), start=3D1):
>> +            logger.debug('found Tux at position (x, y) =3D %s', pt)
>> +            cv2.rectangle(screendump_bgr, pt,
>> +                          (pt[0] + w, pt[1] + h), (0, 0, 255), 2)
>> +        if debug_png:
>> +            cv2.imwrite(debug_png, screendump_bgr)
>> +        self.assertGreaterEqual(tuxlogo_count, cpu_cores_count)
>> +
>> +    def test_mips_malta_i6400_framebuffer_logo_1core(self):
>> +        """
>> +        :avocado: tags=3Darch:mips64el
>> +        :avocado: tags=3Dmachine:malta
>> +        :avocado: tags=3Dcpu:i6400
>> +        """
>> +        self.do_test_i6400_framebuffer_logo(1)
>> +
>> +    def test_mips_malta_i6400_framebuffer_logo_7cores(self):
>> +        """
>> +        :avocado: tags=3Darch:mips64el
>> +        :avocado: tags=3Dmachine:malta
>> +        :avocado: tags=3Dcpu:i6400
>> +        """
>> +        self.do_test_i6400_framebuffer_logo(7)
>> +
>> +    def test_mips_malta_i6400_framebuffer_logo_8cores(self):
>> +        """
>> +        :avocado: tags=3Darch:mips64el
>> +        :avocado: tags=3Dmachine:malta
>> +        :avocado: tags=3Dcpu:i6400
>> +        """
>> +        self.do_test_i6400_framebuffer_logo(8)
>> --
>> 2.21.1
>>
>>


