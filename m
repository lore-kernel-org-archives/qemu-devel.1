Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21749C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 00:13:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDD792176D
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 00:13:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HikSekCT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDD792176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34264 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihjRB-00074z-WB
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 19:13:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51870)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ihjQN-0006dG-1t
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 19:12:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ihjQK-0008TA-3B
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 19:12:14 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:39234)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ihjQJ-0008Sa-VH
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 19:12:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576714330;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ABoNQem++Rki9wDEEoX93D9mBxupqeK6Tec33IRHSi4=;
 b=HikSekCT7q14UFPolZoCfrUPX5gF0Js3kcJ3EqQQLTLxL8kbbWYd32WkOzlm2K6YiFTrj/
 aAQyzVHjD8k1pkyPat9WLYDeqcZLbEOzb6fdv+FCmzn4lryWJ/eV50udDQAn2BPbDvoie2
 0VFZwzGHGrE1hQrPVqDvVjcFzsjxGOs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-15-e0lf34oYMaycjE9K66zcZQ-1; Wed, 18 Dec 2019 19:12:06 -0500
Received: by mail-wr1-f72.google.com with SMTP id t3so856160wrm.23
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 16:12:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ABoNQem++Rki9wDEEoX93D9mBxupqeK6Tec33IRHSi4=;
 b=pVXv+qgSH6uScVveNNFUgGM4WlUTnsYro5xLEerq4DPWR1rUk4YhvxTY27Zrg92A1f
 NZ4tkDG60UstC6NkXUhcPWeON5M2gaailVguz3Ro7U+PENG/kyW1JIMEQ/N3h2JTJqY8
 WcxjIjNbmM3/hdUIXyzMsEz9JE8GdI/jBbjZwkhJrYSA4ef7e0lUA/kCFUkWFfEwcR1w
 upkhASjbqHfGOa6ZO5pw4KOWEH4oi8/UXKxhPAc8EmkDxuiEiyET2gLMTrK3L7qBmSSF
 K5pRFSKoZPM0y2sQHTjpT5dKD94/E94EZgeMl5A6XzirAAcbN3R0TZLlgoOY5AYNx/PW
 Acfg==
X-Gm-Message-State: APjAAAXh8gewfRjF8kzhamzFwV9U1Sj2/Nqp07vj5dkcZT3avtvbYeRw
 7t2Rl+RCCqrcicIWJU4kjF/jnhfCi8BLCJnc2oUlAXI/5igaqJAAL1JZ6GjNZCQoGbGTpPpBYhU
 a9dMVoK04hKPsZcw=
X-Received: by 2002:a5d:56ca:: with SMTP id m10mr5661272wrw.313.1576714325051; 
 Wed, 18 Dec 2019 16:12:05 -0800 (PST)
X-Google-Smtp-Source: APXvYqzfH3N63aBuTj8V8h3HbNXiWMxQcl1KhrE2xZ8EYLiZEwVpYavDGf8Wml6ATfimoZ0222cm/Q==
X-Received: by 2002:a5d:56ca:: with SMTP id m10mr5661239wrw.313.1576714324669; 
 Wed, 18 Dec 2019 16:12:04 -0800 (PST)
Received: from [192.168.1.35] (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id x16sm4351414wmk.35.2019.12.18.16.12.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Dec 2019 16:12:03 -0800 (PST)
Subject: Re: [PATCH v8 2/4] Acceptance test: add "boot_linux" tests
To: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org
References: <20191218232500.23530-1-crosa@redhat.com>
 <20191218232500.23530-3-crosa@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <8753cd80-283d-82c7-c35f-e995a0ed14d0@redhat.com>
Date: Thu, 19 Dec 2019 01:12:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191218232500.23530-3-crosa@redhat.com>
Content-Language: en-US
X-MC-Unique: e0lf34oYMaycjE9K66zcZQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Cc: Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Willian Rampazzo <wrampazz@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Beraldo Leal <bleal@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Cleber,

Few minor questions...

On 12/19/19 12:24 AM, Cleber Rosa wrote:
> This acceptance test, validates that a full blown Linux guest can
> successfully boot in QEMU.  In this specific case, the guest chosen is
> Fedora version 31.
> 
>   * x86_64, pc and q35 machine types, with and without kvm as an
>     accelerator
> 
>   * aarch64 and virt machine type, with and without kvm as an
>     accelerator
> 
>   * ppc64 and pseries machine type
> 
>   * s390x and s390-ccw-virtio machine type
> 
> The Avocado vmimage utils library is used to download and cache the
> Linux guest images, and from those images a snapshot image is created
> and given to QEMU.  If a qemu-img binary is available in the build
> directory, it's used to create the snapshot image, so that matching
> qemu-system-* and qemu-img are used in the same test run.  If qemu-img
> is not available in the build tree, one is attempted to be found
> installed system-wide (in the $PATH).  If qemu-img is not found in the
> build dir or in the $PATH, the test is canceled.
> 
> The method for checking the successful boot is based on "cloudinit"
> and its "phone home" feature.  The guest is given an ISO image with
> the location of the phone home server, and the information to post
> (the instance ID).  Upon receiving the correct information, from the
> guest, the test is considered to have PASSed.
> 
> This test is currently limited to user mode networking only, and
> instructs the guest to connect to the "router" address that is hard
> coded in QEMU.
> 
> To create the cloudinit ISO image that will be used to configure the
> guest, the pycdlib library is also required and has been added as
> requirement to the virtual environment created by "check-venv".
> 
> The console output is read by a separate thread, by means of the
> Avocado datadrainer utility module.
> 
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> ---
>   .travis.yml                    |   2 +-
>   tests/acceptance/boot_linux.py | 180 +++++++++++++++++++++++++++++++++
>   tests/requirements.txt         |   3 +-
>   3 files changed, 183 insertions(+), 2 deletions(-)
>   create mode 100644 tests/acceptance/boot_linux.py
> 
> diff --git a/.travis.yml b/.travis.yml
> index 6cb8af6fa5..10c24330fd 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -264,7 +264,7 @@ matrix:
>   
>       # Acceptance (Functional) tests
>       - env:
> -        - CONFIG="--python=/usr/bin/python3 --target-list=x86_64-softmmu,mips-softmmu,mips64el-softmmu,aarch64-softmmu,arm-softmmu,s390x-softmmu,alpha-softmmu,ppc-softmmu,ppc64-softmmu,m68k-softmmu,sparc-softmmu"
> +        - CONFIG="--python=/usr/bin/python3 --enable-tools --target-list=x86_64-softmmu,mips-softmmu,mips64el-softmmu,aarch64-softmmu,arm-softmmu,s390x-softmmu,alpha-softmmu,ppc-softmmu,ppc64-softmmu,m68k-softmmu,sparc-softmmu"
>           - TEST_CMD="make check-acceptance"
>         after_failure:
>           - cat tests/results/latest/job.log
> diff --git a/tests/acceptance/boot_linux.py b/tests/acceptance/boot_linux.py
> new file mode 100644
> index 0000000000..495ff2963c
> --- /dev/null
> +++ b/tests/acceptance/boot_linux.py
> @@ -0,0 +1,180 @@
> +# Functional test that boots a complete Linux system via a cloud image
> +#
> +# Copyright (c) 2018-2019 Red Hat, Inc.
> +#
> +# Author:
> +#  Cleber Rosa <crosa@redhat.com>
> +#
> +# This work is licensed under the terms of the GNU GPL, version 2 or
> +# later.  See the COPYING file in the top-level directory.
> +
> +import os
> +
> +from avocado_qemu import Test, BLD_DIR
> +
> +from qemu.accel import kvm_available
> +
> +from avocado.utils import cloudinit
> +from avocado.utils import network
> +from avocado.utils import vmimage
> +from avocado.utils import datadrainer
> +
> +
> +KVM_NOT_AVAILABLE = "KVM accelerator does not seem to be available"
> +
> +
> +class BootLinux(Test):
> +    """
> +    Boots a Linux system, checking for a successful initialization
> +    """
> +
> +    timeout = 900
> +    chksum = None
> +
> +    def setUp(self):
> +        super(BootLinux, self).setUp()
> +        self.prepare_boot()
> +        self.vm.add_args('-smp', '2')

Hmmm are we assuming everybody has multicore systems?

> +        self.vm.add_args('-m', '2048')

We should not fail the test if this condition is not possible.

> +        self.vm.add_args('-drive', 'file=%s' % self.boot.path)
> +        self.prepare_cloudinit()
> +
> +    def prepare_boot(self):
> +        self.log.info('Downloading/preparing boot image')
> +        # Fedora 31 only provides ppc64le images
> +        image_arch = self.arch
> +        if image_arch == 'ppc64':
> +            image_arch = 'ppc64le'
> +        # If qemu-img has been built, use it, otherwise the system wide one
> +        # will be used.  If none is available, the test will cancel.
> +        qemu_img = os.path.join(BLD_DIR, 'qemu-img')
> +        if os.path.exists(qemu_img):
> +            vmimage.QEMU_IMG = qemu_img
> +        try:
> +            self.boot = vmimage.get(
> +                'fedora', arch=image_arch, version='31',
> +                checksum=self.chksum,
> +                algorithm='sha256',
> +                cache_dir=self.cache_dirs[0],
> +                snapshot_dir=self.workdir)
> +        except:
> +            self.cancel('Failed to download/prepare boot image')
> +
> +    def prepare_cloudinit(self):
> +        self.log.info('Preparing cloudinit image')
> +        try:
> +            cloudinit_iso = os.path.join(self.workdir, 'cloudinit.iso')
> +            self.phone_home_port = network.find_free_port()
> +            cloudinit.iso(cloudinit_iso, self.name,
> +                          username='root',
> +                          password='password',
> +                          # QEMU's hard coded usermode router address
> +                          phone_home_host='10.0.2.2',
> +                          phone_home_port=self.phone_home_port)
> +            self.vm.add_args('-drive', 'file=%s,format=raw' % cloudinit_iso)
> +        except Exception:
> +            self.cancel('Failed to prepared cloudinit image')
> +
> +    def launch_and_wait(self):
> +        self.vm.set_console()
> +        self.vm.launch()
> +        console_drainer = datadrainer.LineLogger(self.vm.console_socket.fileno(),
> +                                                 logger=self.log.getChild('console'))
> +        console_drainer.start()
> +        self.log.info('VM launched, waiting for boot confirmation from guest')
> +        cloudinit.wait_for_phone_home(('0.0.0.0', self.phone_home_port), self.name)
> +
> +
> +class BootLinuxX8664(BootLinux):
> +    """
> +    :avocado: tags=arch:x86_64
> +    """
> +
> +    chksum = 'e3c1b309d9203604922d6e255c2c5d098a309c2d46215d8fc026954f3c5c27a0'
> +
> +    def test_pc(self):

I'd name this test_pc_i440fx_tcg, but are you sure the default is tcg?

> +        """
> +        :avocado: tags=machine:pc
> +        """
> +        self.launch_and_wait()
> +
> +    def test_kvm_pc(self):

This test_pc_i440fx_kvm

> +        """
> +        :avocado: tags=machine:pc
> +        :avocado: tags=accel:kvm
> +        """
> +        if not kvm_available(self.arch, self.qemu_bin):
> +            self.cancel(KVM_NOT_AVAILABLE)
> +        self.vm.add_args("-accel", "kvm")
> +        self.launch_and_wait()
> +
> +    def test_q35(self):

This one test_pc_q35_tcg

> +        """
> +        :avocado: tags=machine:q35
> +        """
> +        self.launch_and_wait()
> +
> +    def test_kvm_q35(self):

Here test_pc_q35_kvm.

> +        """
> +        :avocado: tags=machine:q35
> +        :avocado: tags=accel:kvm
> +        """
> +        if not kvm_available(self.arch, self.qemu_bin):
> +            self.cancel(KVM_NOT_AVAILABLE)
> +        self.vm.add_args("-accel", "kvm")
> +        self.launch_and_wait()
> +
> +
> +class BootLinuxAarch64(BootLinux):
> +    """
> +    :avocado: tags=arch:aarch64
> +    :avocado: tags=machine:virt
> +    """
> +
> +    chksum = '1e18d9c0cf734940c4b5d5ec592facaed2af0ad0329383d5639c997fdf16fe49'
> +
> +    def test_virt(self):

We have other 'virt' machines:

$ git grep '"virt"'
hw/arm/virt.c:83:            mc->alias = "virt"; \
hw/riscv/virt.c:613:    .name       = MACHINE_TYPE_NAME("virt"),
hw/xtensa/virt.c:135:DEFINE_MACHINE("virt", xtensa_virt_machine_init)

Maybe rename test_aarch64_virt_tcg?

> +        self.vm.add_args('-cpu', 'cortex-a53')
> +        self.vm.add_args('-bios',
> +                         os.path.join(BLD_DIR, 'pc-bios',
> +                                      'edk2-aarch64-code.fd'))
> +        self.vm.add_args('-device', 'virtio-rng-pci,rng=rng0')
> +        self.vm.add_args('-object', 'rng-random,id=rng0,filename=/dev/urandom')
> +        self.launch_and_wait()
> +
> +    def test_kvm_virt(self):
> +        """
> +        :avocado: tags=accel:kvm
> +        """
> +        if not kvm_available(self.arch, self.qemu_bin):
> +            self.cancel(KVM_NOT_AVAILABLE)
> +        self.vm.add_args("-accel", "kvm")
> +        self.test_virt()
> +
> +
> +class BootLinuxPPC64(BootLinux):
> +    """
> +    :avocado: tags=arch:ppc64
> +    """
> +
> +    chksum = '7c3528b85a3df4b2306e892199a9e1e43f991c506f2cc390dc4efa2026ad2f58'
> +
> +    def test_pseries(self):

Rename as test_ppc64el_pseries_tcg?

> +        """
> +        :avocado: tags=machine:pseries
> +        """
> +        self.launch_and_wait()
> +
> +
> +class BootLinuxS390X(BootLinux):
> +    """
> +    :avocado: tags=arch:s390x
> +    """
> +
> +    chksum = '4caaab5a434fd4d1079149a072fdc7891e354f834d355069ca982fdcaf5a122d'
> +
> +    def test_s390_ccw_virtio(self):
> +        """
> +        :avocado: tags=machine:s390-ccw-virtio
> +        """
> +        self.launch_and_wait()
> diff --git a/tests/requirements.txt b/tests/requirements.txt
> index a2a587223a..0192c352cd 100644
> --- a/tests/requirements.txt
> +++ b/tests/requirements.txt
> @@ -1,4 +1,5 @@
>   # Add Python module requirements, one per line, to be installed
>   # in the tests/venv Python virtual environment. For more info,
>   # refer to: https://pip.pypa.io/en/stable/user_guide/#id1
> -avocado-framework==72.0
> +avocado-framework==73.0
> +pycdlib==1.8.0
> 


