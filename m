Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E3E1C1975A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 21:49:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0187E20724
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 21:49:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G/qd57Gu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0187E20724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEK5X-0000Nj-5F
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 17:49:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39716)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wrampazz@redhat.com>) id 1jEK4g-0008Oa-HY
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 17:48:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wrampazz@redhat.com>) id 1jEK4d-0002hZ-VX
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 17:48:34 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:41448)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wrampazz@redhat.com>) id 1jEK4d-0002ZD-Q5
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 17:48:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584481710;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eLrK382TAIvx84mg8MTtm2/JvChqb3Fw0UDDd0p1YUk=;
 b=G/qd57GuU2wg3GoKEYK+RnD00OulgfHM9SfVQM2Q9C2U1uJZq6yCq9y7WN0sVjNS3lCD24
 LNo5dPTYDqLumeLbOxZEQGca4C5GB9a9l51sVx9jSwOULYMieFKw51PZynPcGL+ltlDZwM
 sCr+mGRNWqzQtdV3izqInyu+18BaHFs=
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-34-psACNGoQNB6mHlD3_KNmcQ-1; Tue, 17 Mar 2020 17:48:24 -0400
X-MC-Unique: psACNGoQNB6mHlD3_KNmcQ-1
Received: by mail-vk1-f200.google.com with SMTP id y78so2427008vky.2
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 14:48:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=eLrK382TAIvx84mg8MTtm2/JvChqb3Fw0UDDd0p1YUk=;
 b=jqRMbSV1e/qnY8iBm6DVrhvLE2QEd1U9YSPsOepqaeNbCNN4bYwDra4DqUzvKdDwoy
 vSbYr3xa0v25bOlaSAn690fggTPHkqZ3LOTtgzpREOH7Dmp6AJHvw/BOmWgS0w0X3wEk
 ymNQcgYKYUCT/47f9/tT/Nho3A5nvVYZpU0lJ4AYpyZJxDZGkbQeXVH3KWSFe5/1wVWS
 AIsPs4XZUFmqerdttCV9WNRr9VAIj4xTHacz7J5rBIBEekt8rveJ/MTWy/ysbrdHNPMg
 jXY1N5xOL38LqBZhrASj6msnvnVSar5uM+BfUSwNtCxBAFOTMMkEX6HpoM/a60/Q0WDR
 kT7w==
X-Gm-Message-State: ANhLgQ0NqNzM6KFzVLVdywVAjopVnIkzJr/GyNwHtYuKp5LwfiLzhxzO
 b0Hy7y/8oyV5jafM7aAXpZV7fcVEiT1yEbvs1eS7/c85lUO9arGDOTE0PCZ3CeXlQDBoUPsKY/a
 BtaLLqsJqjUMpteaiwgSqY7Y+gKq8SfM=
X-Received: by 2002:a67:ecc1:: with SMTP id i1mr815423vsp.145.1584481703845;
 Tue, 17 Mar 2020 14:48:23 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vuoB1LuxTZmy8Dbtn/aHDW369/lQCBpYNboBu501mqK8vA+3NgDpObN/JaKda0usVz0rA38R5hSjL7akGbcRSM=
X-Received: by 2002:a67:ecc1:: with SMTP id i1mr815407vsp.145.1584481703453;
 Tue, 17 Mar 2020 14:48:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200317141654.29355-1-crosa@redhat.com>
 <20200317141654.29355-3-crosa@redhat.com>
In-Reply-To: <20200317141654.29355-3-crosa@redhat.com>
From: Willian Rampazzo <wrampazz@redhat.com>
Date: Tue, 17 Mar 2020 18:48:12 -0300
Message-ID: <CAKJDGDY+J_FwiLEfmT-RBXraEPwtWGAqu-8LxH+3O8JYzPYjoA@mail.gmail.com>
Subject: Re: [PATCH v10 2/3] Acceptance test: add "boot_linux" tests
To: Cleber Rosa <crosa@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Beraldo Leal <bleal@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Mar 17, 2020 at 11:17 AM Cleber Rosa <crosa@redhat.com> wrote:
>
> This acceptance test, validates that a full blown Linux guest can
> successfully boot in QEMU.  In this specific case, the guest chosen is
> Fedora version 31.
>
>  * x86_64, pc-i440fx and pc-q35 machine types, with TCG and KVM as
>    accelerators
>
>  * aarch64 and virt machine type, with TCG and KVM as accelerators
>
>  * ppc64 and pseries machine type with TCG as accelerator
>
>  * s390x and s390-ccw-virtio machine type with TCG as accelerator
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
>  .travis.yml                    |   2 +-
>  tests/acceptance/boot_linux.py | 222 +++++++++++++++++++++++++++++++++
>  tests/requirements.txt         |   1 +
>  3 files changed, 224 insertions(+), 1 deletion(-)
>  create mode 100644 tests/acceptance/boot_linux.py
>
> diff --git a/.travis.yml b/.travis.yml
> index b92798ac3b..c460059a7b 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -315,7 +315,7 @@ jobs:
>      - name: "GCC check-acceptance"
>        dist: bionic
>        env:
> -        - CONFIG=3D"--target-list=3Daarch64-softmmu,alpha-softmmu,arm-so=
ftmmu,m68k-softmmu,microblaze-softmmu,mips-softmmu,mips64el-softmmu,nios2-s=
oftmmu,or1k-softmmu,ppc-softmmu,ppc64-softmmu,s390x-softmmu,sparc-softmmu,x=
86_64-softmmu,xtensa-softmmu"
> +        - CONFIG=3D"--enable-tools --target-list=3Daarch64-softmmu,alpha=
-softmmu,arm-softmmu,m68k-softmmu,microblaze-softmmu,mips-softmmu,mips64el-=
softmmu,nios2-softmmu,or1k-softmmu,ppc-softmmu,ppc64-softmmu,s390x-softmmu,=
sparc-softmmu,x86_64-softmmu,xtensa-softmmu"
>          - TEST_CMD=3D"make check-acceptance"
>        after_script:
>          - python3 -c 'import json; r =3D json.load(open("tests/results/l=
atest/results.json")); [print(t["logfile"]) for t in r["tests"] if t["statu=
s"] not in ("PASS", "SKIP")]' | xargs cat
> diff --git a/tests/acceptance/boot_linux.py b/tests/acceptance/boot_linux=
.py
> new file mode 100644
> index 0000000000..075a386300
> --- /dev/null
> +++ b/tests/acceptance/boot_linux.py
> @@ -0,0 +1,222 @@
> +# Functional test that boots a complete Linux system via a cloud image
> +#
> +# Copyright (c) 2018-2020 Red Hat, Inc.
> +#
> +# Author:
> +#  Cleber Rosa <crosa@redhat.com>
> +#
> +# This work is licensed under the terms of the GNU GPL, version 2 or
> +# later.  See the COPYING file in the top-level directory.
> +
> +import os
> +
> +from avocado_qemu import Test, BUILD_DIR
> +
> +from qemu.accel import kvm_available
> +from qemu.accel import tcg_available
> +
> +from avocado.utils import cloudinit
> +from avocado.utils import network
> +from avocado.utils import vmimage
> +from avocado.utils import datadrainer
> +from avocado.utils.path import find_command
> +
> +ACCEL_NOT_AVAILABLE_FMT =3D "%s accelerator does not seem to be availabl=
e"
> +KVM_NOT_AVAILABLE =3D ACCEL_NOT_AVAILABLE_FMT % "KVM"
> +TCG_NOT_AVAILABLE =3D ACCEL_NOT_AVAILABLE_FMT % "TCG"
> +
> +
> +class BootLinux(Test):
> +    """
> +    Boots a Linux system, checking for a successful initialization
> +    """
> +
> +    timeout =3D 900
> +    chksum =3D None
> +
> +    def setUp(self):
> +        super(BootLinux, self).setUp()
> +        self.vm.add_args('-smp', '2')
> +        self.vm.add_args('-m', '1024')
> +        self.prepare_boot()
> +        self.prepare_cloudinit()
> +
> +    def prepare_boot(self):
> +        self.log.debug('Looking for and selecting a qemu-img binary to b=
e '
> +                       'used to create the bootable snapshot image')
> +        # If qemu-img has been built, use it, otherwise the system wide =
one
> +        # will be used.  If none is available, the test will cancel.
> +        qemu_img =3D os.path.join(BUILD_DIR, 'qemu-img')
> +        if not os.path.exists(qemu_img):
> +            qemu_img =3D find_command('qemu-img', False)
> +        if qemu_img is False:
> +            self.cancel('Could not find "qemu-img", which is required to=
 '
> +                        'create the bootable image')
> +        vmimage.QEMU_IMG =3D qemu_img
> +
> +        self.log.info('Downloading/preparing boot image')
> +        # Fedora 31 only provides ppc64le images
> +        image_arch =3D self.arch
> +        if image_arch =3D=3D 'ppc64':
> +            image_arch =3D 'ppc64le'
> +        try:
> +            self.boot =3D vmimage.get(
> +                'fedora', arch=3Dimage_arch, version=3D'31',
> +                checksum=3Dself.chksum,
> +                algorithm=3D'sha256',
> +                cache_dir=3Dself.cache_dirs[0],
> +                snapshot_dir=3Dself.workdir)
> +            self.vm.add_args('-drive', 'file=3D%s' % self.boot.path)
> +        except:
> +            self.cancel('Failed to download/prepare boot image')
> +
> +    def prepare_cloudinit(self):
> +        self.log.info('Preparing cloudinit image')
> +        try:
> +            cloudinit_iso =3D os.path.join(self.workdir, 'cloudinit.iso'=
)
> +            self.phone_home_port =3D network.find_free_port()
> +            cloudinit.iso(cloudinit_iso, self.name,
> +                          username=3D'root',
> +                          password=3D'password',
> +                          # QEMU's hard coded usermode router address
> +                          phone_home_host=3D'10.0.2.2',
> +                          phone_home_port=3Dself.phone_home_port)
> +            self.vm.add_args('-drive', 'file=3D%s,format=3Draw' % cloudi=
nit_iso)
> +        except Exception:
> +            self.cancel('Failed to prepared cloudinit image')
> +
> +    def launch_and_wait(self):
> +        self.vm.set_console()
> +        self.vm.launch()
> +        console_drainer =3D datadrainer.LineLogger(self.vm.console_socke=
t.fileno(),
> +                                                 logger=3Dself.log.getCh=
ild('console'))
> +        console_drainer.start()
> +        self.log.info('VM launched, waiting for boot confirmation from g=
uest')
> +        cloudinit.wait_for_phone_home(('0.0.0.0', self.phone_home_port),=
 self.name)
> +
> +
> +class BootLinuxX8664(BootLinux):
> +    """
> +    :avocado: tags=3Darch:x86_64
> +    """
> +
> +    chksum =3D 'e3c1b309d9203604922d6e255c2c5d098a309c2d46215d8fc026954f=
3c5c27a0'
> +
> +    def test_pc_i440fx_tcg(self):
> +        """
> +        :avocado: tags=3Dmachine:pc
> +        :avocado: tags=3Daccel:tcg
> +        """
> +        if not tcg_available(self.qemu_bin):
> +            self.cancel(TCG_NOT_AVAILABLE)
> +        self.vm.add_args("-accel", "tcg")
> +        self.launch_and_wait()
> +
> +    def test_pc_i440fx_kvm(self):
> +        """
> +        :avocado: tags=3Dmachine:pc
> +        :avocado: tags=3Daccel:kvm
> +        """
> +        if not kvm_available(self.arch, self.qemu_bin):
> +            self.cancel(KVM_NOT_AVAILABLE)
> +        self.vm.add_args("-accel", "kvm")
> +        self.launch_and_wait()
> +
> +    def test_pc_q35_tcg(self):
> +        """
> +        :avocado: tags=3Dmachine:q35
> +        :avocado: tags=3Daccel:tcg
> +        """
> +        if not tcg_available(self.qemu_bin):
> +            self.cancel(TCG_NOT_AVAILABLE)
> +        self.vm.add_args("-accel", "tcg")
> +        self.launch_and_wait()
> +
> +    def test_pc_q35_kvm(self):
> +        """
> +        :avocado: tags=3Dmachine:q35
> +        :avocado: tags=3Daccel:kvm
> +        """
> +        if not kvm_available(self.arch, self.qemu_bin):
> +            self.cancel(KVM_NOT_AVAILABLE)
> +        self.vm.add_args("-accel", "kvm")
> +        self.launch_and_wait()
> +
> +
> +class BootLinuxAarch64(BootLinux):
> +    """
> +    :avocado: tags=3Darch:aarch64
> +    :avocado: tags=3Dmachine:virt
> +    :avocado: tags=3Dmachine:gic-version=3D2
> +    """
> +
> +    chksum =3D '1e18d9c0cf734940c4b5d5ec592facaed2af0ad0329383d5639c997f=
df16fe49'
> +
> +    def add_common_args(self):
> +        self.vm.add_args('-bios',
> +                         os.path.join(BUILD_DIR, 'pc-bios',
> +                                      'edk2-aarch64-code.fd'))
> +        self.vm.add_args('-device', 'virtio-rng-pci,rng=3Drng0')
> +        self.vm.add_args('-object', 'rng-random,id=3Drng0,filename=3D/de=
v/urandom')
> +
> +    def test_virt_tcg(self):
> +        """
> +        :avocado: tags=3Daccel:tcg
> +        :avocado: tags=3Dcpu:max
> +        """
> +        if not tcg_available(self.qemu_bin):
> +            self.cancel(TCG_NOT_AVAILABLE)
> +        self.vm.add_args("-accel", "tcg")
> +        self.vm.add_args("-cpu", "max")
> +        self.vm.add_args("-machine", "virt,gic-version=3D2")
> +        self.add_common_args()
> +        self.launch_and_wait()
> +
> +    def test_virt_kvm(self):
> +        """
> +        :avocado: tags=3Daccel:kvm
> +        :avocado: tags=3Dcpu:host
> +        """
> +        if not kvm_available(self.arch, self.qemu_bin):
> +            self.cancel(KVM_NOT_AVAILABLE)
> +        self.vm.add_args("-accel", "kvm")
> +        self.vm.add_args("-cpu", "host")
> +        self.vm.add_args("-machine", "virt,gic-version=3D2")
> +        self.add_common_args()
> +        self.launch_and_wait()
> +
> +
> +class BootLinuxPPC64(BootLinux):
> +    """
> +    :avocado: tags=3Darch:ppc64
> +    """
> +
> +    chksum =3D '7c3528b85a3df4b2306e892199a9e1e43f991c506f2cc390dc4efa20=
26ad2f58'
> +
> +    def test_pseries_tcg(self):
> +        """
> +        :avocado: tags=3Dmachine:pseries
> +        :avocado: tags=3Daccel:tcg
> +        """
> +        if not tcg_available(self.qemu_bin):
> +            self.cancel(TCG_NOT_AVAILABLE)
> +        self.vm.add_args("-accel", "tcg")
> +        self.launch_and_wait()
> +
> +
> +class BootLinuxS390X(BootLinux):
> +    """
> +    :avocado: tags=3Darch:s390x
> +    """
> +
> +    chksum =3D '4caaab5a434fd4d1079149a072fdc7891e354f834d355069ca982fdc=
af5a122d'
> +
> +    def test_s390_ccw_virtio_tcg(self):
> +        """
> +        :avocado: tags=3Dmachine:s390-ccw-virtio
> +        :avocado: tags=3Daccel:tcg
> +        """
> +        if not tcg_available(self.qemu_bin):
> +            self.cancel(TCG_NOT_AVAILABLE)
> +        self.vm.add_args("-accel", "tcg")
> +        self.launch_and_wait()
> diff --git a/tests/requirements.txt b/tests/requirements.txt
> index f4f1736a08..f9c84b4ba1 100644
> --- a/tests/requirements.txt
> +++ b/tests/requirements.txt
> @@ -2,3 +2,4 @@
>  # in the tests/venv Python virtual environment. For more info,
>  # refer to: https://pip.pypa.io/en/stable/user_guide/#id1
>  avocado-framework=3D=3D76.0
> +pycdlib=3D=3D1.9.0
> --
> 2.25.1
>

Reviewed-by: Willian Rampazzo <willianr@redhat.com>
Tested-by: Willian Rampazzo <willianr@redhat.com>


