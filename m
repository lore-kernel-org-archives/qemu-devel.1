Return-Path: <SRS0=LSdK=2Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37752C2D0DA
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Dec 2019 16:13:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E65C7206CB
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Dec 2019 16:13:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bZZ2nyIv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E65C7206CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ikVlH-0003wA-1w
	for qemu-devel@archiver.kernel.org; Thu, 26 Dec 2019 11:13:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59938)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wainersm@redhat.com>) id 1ikVke-0003SY-2f
 for qemu-devel@nongnu.org; Thu, 26 Dec 2019 11:12:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wainersm@redhat.com>) id 1ikVkb-00028t-3q
 for qemu-devel@nongnu.org; Thu, 26 Dec 2019 11:12:38 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23226
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1ikVka-00028G-M2
 for qemu-devel@nongnu.org; Thu, 26 Dec 2019 11:12:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577376755;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DcNxUq7l7GbiSA2uSzV2LEYu5l5jV69nEGxEnan5E3M=;
 b=bZZ2nyIvs+q2puNybttyGuO9Ii0UTZjwBel9ZlQrKnAAvDKXft35Wi3jZmM6gcCewXq1Lu
 61XfT+dV9al2svNXA2B+PLJ9qqADnl3AuoBKWX1IjeaKqbfZhiMMXr2EE1MrP5Mz6czWFh
 kBUSacbzCXU3tzLDHYNkINayaS8S7+4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-231-kOB5wWX8PeKT2kFFaGNO3Q-1; Thu, 26 Dec 2019 11:12:32 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C3A94189DF62;
 Thu, 26 Dec 2019 16:12:29 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-71.gru2.redhat.com
 [10.97.116.71])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4F1D79CA3;
 Thu, 26 Dec 2019 16:12:24 +0000 (UTC)
Subject: Re: [PATCH v8 2/4] Acceptance test: add "boot_linux" tests
To: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org
References: <20191218232500.23530-1-crosa@redhat.com>
 <20191218232500.23530-3-crosa@redhat.com>
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-ID: <2bad8edf-97cc-0dcb-4d70-002d78cabffa@redhat.com>
Date: Thu, 26 Dec 2019 14:12:22 -0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20191218232500.23530-3-crosa@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: kOB5wWX8PeKT2kFFaGNO3Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Willian Rampazzo <wrampazz@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Beraldo Leal <bleal@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Cleber,

just few comments below.

On 12/18/19 9:24 PM, Cleber Rosa wrote:
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
> +        self.vm.add_args('-m', '2048')
> +        self.vm.add_args('-drive', 'file=%s' % self.boot.path)

Perhaps move above line to prepare_boot() then following the same logic 
as in prepare_cloudinit() - which sets the -drive path to the ISO file.

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
> +        """
> +        :avocado: tags=machine:pc
> +        """
> +        self.launch_and_wait()
> +
> +    def test_kvm_pc(self):
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
> +        """
> +        :avocado: tags=machine:q35
> +        """
> +        self.launch_and_wait()
> +
> +    def test_kvm_q35(self):
> +        """
> +        :avocado: tags=machine:q35
> +        :avocado: tags=accel:kvm
> +        """
> +        if not kvm_available(self.arch, self.qemu_bin):
> +            self.cancel(KVM_NOT_AVAILABLE)
> +        self.vm.add_args("-accel", "kvm")


Following patch will allow to reduce the above boilerplate:

https://www.mail-archive.com/qemu-devel@nongnu.org/msg666239.html


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


