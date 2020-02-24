Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C94C1C38BF9
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 21:39:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80D8121556
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 21:39:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AIODBflU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80D8121556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44240 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6LRi-00058u-OA
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 16:39:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52947)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j6Kqb-0006T1-U2
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 16:01:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j6KqZ-0006xl-S7
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 16:01:01 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:47911
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j6KqZ-0006xW-MH
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 16:00:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582578059;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ehvKGAPOosWcWjM7c+JiX7hQcGnYtgAyaHGeajZW5eI=;
 b=AIODBflUUnbXb3OmUAQz4Ph5ud5cEFXC3uIYJ+6CLMXNyUsGBSoy0cgdOhnf+bVoVKCdm9
 OYF+k53GnfktUDF6Ck88i3af/Zq90opX36XKNbx/smo7mxl9DCay+RR0lce7Jy9OIEWosK
 XaAVLCrh8u33JcnuPzGbil31wx+I3FY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-487-l-4UszzkNuyJgQ6-BFxxGw-1; Mon, 24 Feb 2020 16:00:52 -0500
X-MC-Unique: l-4UszzkNuyJgQ6-BFxxGw-1
Received: by mail-wm1-f70.google.com with SMTP id k21so148713wmi.2
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2020 13:00:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=YaYqhOso/0SethG4mmMAwY9GG/8uI+Dgyw1r6dW2mU0=;
 b=Ot1r4mCUPr7Cc2HqpybLAQywn2dpqaJtLvhfKt3MCMM/jVwJTeoLm16W5zFmQLLXf9
 Eo7JHybXWbyVbpJjQvhrM5W3JYdc/jFw7mUf2P5ZxY2kRC3wihHLlYnvomVKhTQ0wk1z
 czDMSiJ93S0BH8N/uxyQQr7Daa3Tlh6Vplw6GKgracrZU0KZRRgaHeiXj1y79vTDdoc0
 YV/581QsMJjqlUm2E6XnTX8N8PNGqryhwXL9Jcn6BdJhMSUItqBO7zdVksxZ728D+Us4
 fyFac6gZDVWmSWhDD14L7LKuJw+VWivB7LO9na0KBEtLOEosE4pHUdVgFWOzxxC+5o2x
 TtfQ==
X-Gm-Message-State: APjAAAVz2d7JszEGzbBndEcid40ZjEFQEB/STurVbrbdux3JUafLG77I
 tbsyOXdJVIVfuG1y0YJOX6FgrLRUaTG0qi9dSPon74sLaEgPpOjikQ3b9qzgnwSr2JF/k2z9T+5
 H9UCJ2pLZWEkkFWU=
X-Received: by 2002:a7b:c14d:: with SMTP id z13mr873501wmi.71.1582578050778;
 Mon, 24 Feb 2020 13:00:50 -0800 (PST)
X-Google-Smtp-Source: APXvYqxj4xEE3tb64O3s0QY/0hFnZ/dJiaS9DHJ/+eXlD+Y1/44wd4icBTPo+NadppqvBxEgVHmAYw==
X-Received: by 2002:a7b:c14d:: with SMTP id z13mr873475wmi.71.1582578050428;
 Mon, 24 Feb 2020 13:00:50 -0800 (PST)
Received: from [192.168.1.35] (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id z14sm3632948wru.31.2020.02.24.13.00.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Feb 2020 13:00:49 -0800 (PST)
Subject: Re: [PATCH] tests/acceptance: Count multiple Tux logos displayed on
 framebuffer
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
References: <20200201204751.17810-1-f4bug@amsat.org>
 <CAL1e-=jqy1bcY-bt0hFxn+X_FQ095kqa__hRMUV1Bs0FjG8SiQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <65cb0397-baea-e18b-c549-c05efe55ecc1@redhat.com>
Date: Mon, 24 Feb 2020 22:00:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAL1e-=jqy1bcY-bt0hFxn+X_FQ095kqa__hRMUV1Bs0FjG8SiQ@mail.gmail.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
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
 QEMU Developers <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 "open list:Stellaris" <qemu-arm@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>, Cleber Rosa <crosa@redhat.com>,
 Leon Alrae <leon.alrae@imgtec.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Aleksandar,

On 2/24/20 9:54 PM, Aleksandar Markovic wrote:
> On Sat, Feb 1, 2020 at 9:48 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg> wrote:
>>
>> Add a test that verifies that each core properly displays the Tux
>> logo on the framebuffer device.
>>
>=20
> Philippe,
>=20
> I would like to select this patch for the next MIPS queue, scheduled
> in next few days.
>=20
> It looks to me there are no prerequisites for this patch to be applied
> on current master, but I may be wrong. Philippe, is this correct or
> not (selecting the patch for the queue independently on other similar
> or any other patches not yet in master)?

You are correct, there are no prerequisites.

If you want to quickly run a SMP test with:

"avocado --show=3Dapp run -t mips:smp tests/acceptance"

(see below...)

>=20
> Thanks again!
> Aleksandar
>=20
>=20
>> We simply follow the OpenCV "Template Matching with Multiple Objects"
>> tutorial, replacing Lionel Messi by Tux:
>> https://docs.opencv.org/4.2.0/d4/dc6/tutorial_py_template_matching.html
>>
>> When OpenCV and NumPy are installed, this test can be run using:
>>
>>    $ avocado --show=3Dapp,framebuffer \
>>      run -t cpu:i6400 \
>>      tests/acceptance/machine_mips_malta.py
>>    JOB ID     : 54f3d8efd8674f289b8aa01a87f5d70c5814544c
>>    JOB LOG    : avocado/job-results/job-2020-02-01T20.52-54f3d8e/job.log
>>     (1/3) tests/acceptance/machine_mips_malta.py:MaltaMachineFramebuffer=
.test_mips_malta_i6400_framebuffer_logo_1core:
>>    framebuffer: found Tux at position (x, y) =3D (0, 0)
>>    PASS (3.37 s)
>>     (2/3) tests/acceptance/machine_mips_malta.py:MaltaMachineFramebuffer=
.test_mips_malta_i6400_framebuffer_logo_7cores:
>>    framebuffer: found Tux at position (x, y) =3D (0, 0)
>>    framebuffer: found Tux at position (x, y) =3D (88, 0)
>>    framebuffer: found Tux at position (x, y) =3D (176, 0)
>>    framebuffer: found Tux at position (x, y) =3D (264, 0)
>>    framebuffer: found Tux at position (x, y) =3D (352, 0)
>>    framebuffer: found Tux at position (x, y) =3D (440, 0)
>>    framebuffer: found Tux at position (x, y) =3D (528, 0)
>>    PASS (5.80 s)
>>     (3/3) tests/acceptance/machine_mips_malta.py:MaltaMachineFramebuffer=
.test_mips_malta_i6400_framebuffer_logo_8cores:
>>    framebuffer: found Tux at position (x, y) =3D (0, 0)
>>    framebuffer: found Tux at position (x, y) =3D (88, 0)
>>    framebuffer: found Tux at position (x, y) =3D (176, 0)
>>    framebuffer: found Tux at position (x, y) =3D (264, 0)
>>    framebuffer: found Tux at position (x, y) =3D (352, 0)
>>    framebuffer: found Tux at position (x, y) =3D (440, 0)
>>    framebuffer: found Tux at position (x, y) =3D (528, 0)
>>    framebuffer: found Tux at position (x, y) =3D (616, 0)
>>    PASS (6.67 s)
>>    RESULTS    : PASS 3 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT =
0 | CANCEL 0
>>    JOB TIME   : 16.79 s
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
>>    $ AVOCADO_CV2_SCREENDUMP_PNG_PATH=3D/tmp/screendump_matched.png \
>>      avocado --show=3Dapp run -t cpu:i6400 \
>>      tests/acceptance/machine_mips_malta.py
>>    JOB ID     : 54f3d8efd8674f289b8aa01a87f5d70c5814544c
>>    JOB LOG    : avocado/job-results/job-2020-02-01T20.52-54f3d8e/job.log
>>     (1/3) tests/acceptance/machine_mips_malta.py:MaltaMachineFramebuffer=
.test_mips_malta_i6400_framebuffer_logo_1core: PASS (3.37 s)
>>     (2/3) tests/acceptance/machine_mips_malta.py:MaltaMachineFramebuffer=
.test_mips_malta_i6400_framebuffer_logo_7cores: PASS (5.80 s)
>>     (3/3) tests/acceptance/machine_mips_malta.py:MaltaMachineFramebuffer=
.test_mips_malta_i6400_framebuffer_logo_8cores: PASS (6.67 s)
>>    RESULTS    : PASS 3 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT =
0 | CANCEL 0
>>    JOB TIME   : 16.79 s
>> ---
>>   MAINTAINERS                            |   1 +
>>   tests/acceptance/machine_mips_malta.py | 116 +++++++++++++++++++++++++
>>   2 files changed, 117 insertions(+)
>>   create mode 100644 tests/acceptance/machine_mips_malta.py
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 4ceb1ad882..65a3dfb564 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -983,6 +983,7 @@ F: hw/mips/mips_malta.c
>>   F: hw/mips/gt64xxx_pci.c
>>   F: include/hw/southbridge/piix.h
>>   F: tests/acceptance/linux_ssh_mips_malta.py
>> +F: tests/acceptance/machine_mips_malta.py
>>
>>   Mipssim
>>   M: Aleksandar Markovic <amarkovic@wavecomp.com>
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

You might want to add this tag here (or similar):

             :avocado: tags=3Dmips:smp

>> +        """
>> +        self.do_test_i6400_framebuffer_logo(7)
>> +
>> +    def test_mips_malta_i6400_framebuffer_logo_8cores(self):
>> +        """
>> +        :avocado: tags=3Darch:mips64el
>> +        :avocado: tags=3Dmachine:malta
>> +        :avocado: tags=3Dcpu:i6400

And here:

             :avocado: tags=3Dmips:smp

Anyway we can add that later.

Regards,

Phil.

>> +        """
>> +        self.do_test_i6400_framebuffer_logo(8)
>> --
>> 2.21.1
>>
>>
>=20


