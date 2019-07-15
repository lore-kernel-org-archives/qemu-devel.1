Return-Path: <SRS0=IjNW=VM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F28C5C7618F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 11:10:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B660F20665
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 11:10:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="exghL4HV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B660F20665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hmysE-00008q-3Z
	for qemu-devel@archiver.kernel.org; Mon, 15 Jul 2019 07:10:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45954)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <chihmin.chao@sifive.com>) id 1hmyrw-00082j-Df
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 07:10:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chihmin.chao@sifive.com>) id 1hmyru-0007lY-9T
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 07:10:08 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:43697)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <chihmin.chao@sifive.com>)
 id 1hmyrt-0007kJ-QE
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 07:10:06 -0400
Received: by mail-wr1-x42b.google.com with SMTP id p13so16591771wru.10
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2019 04:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=1CufUaU31s52ZAtkFPjqx0Vx314VzSAm9wMoCf3YXCQ=;
 b=exghL4HVEg+QwLra6S8fvaTu9Ylk2+s7XzfXnEGqS/Mf/Mn88pVh5tXSXRUFDSh8q0
 te9LeEJ/ceR1wvG0ghiVEeRUpum1uvVK5CzZW+NsGzBeCUsQxiqC+bOuTijd832DxZH+
 R61tZPeOvB0+DT9vZL3slBjVRkUbeLQX+bOOqEJbw8fAEB4mV8l1E+6+j2XVf8vd9Exp
 B6yDQUwaDyAQVnhEOeoGd55hoYmaIefN7Msj3rZgN7PmiV+QLXkzCnDRsKu5S/rSZuAA
 SBUD6pu6QW/rHofHu96pdTbLTOW/jGbIhz74F2fZDtP1lS6gmYbz6NpNBXaQyLPzcEZs
 nwrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=1CufUaU31s52ZAtkFPjqx0Vx314VzSAm9wMoCf3YXCQ=;
 b=FlTtWTqI2IancGGmjVGQzEPahwpMncUlPQ5H+q6E98+NM2XxkkisSegX3CvAQ6W+QT
 56xK/9KEIMvCS8cBpug8KkXNcvDF7BJdFEtzD+l9wkhywutnZtDYDb9XPoyoaGx+37oT
 HxEGTz+pCRmjObkzgdz90Vd4otkymY6lDUagBF2Ik88jup5fvMICNNwOtvSP0IzabfmK
 WJsv/z54sXTbp7PI/kkSsJXsXbN2cOhWV1o8SQgCBsxL2Y4pMm1rXlp2N8Xe3UXGugL6
 avs2J3l+4N8TiJNA0ZRoTxYVM8+MckpmC5FGTa/vatmMODMi9G84byR+ngaaN2BXjT9o
 yOiQ==
X-Gm-Message-State: APjAAAUfe9wLjKcltpyvaVRrGVdzwjFB3XsBDav6FFH1a3NVpPEUVqiG
 FaDdtwDUPPJDgcBixQhzhEOwqdJ23p/M3KhZnDoI7g==
X-Google-Smtp-Source: APXvYqzMHfnj1bkeYuPHAdevOfotjEck8kUY1SWgMNaUnG22Lpa6fqkV6Y/BRsI28cdOMrIrnCtodI6kgTniBXXMnJo=
X-Received: by 2002:adf:ecd0:: with SMTP id s16mr28401083wro.324.1563189003411; 
 Mon, 15 Jul 2019 04:10:03 -0700 (PDT)
MIME-Version: 1.0
References: <1563181721-5055-1-git-send-email-chihmin.chao@sifive.com>
 <93b35a5e-c40a-535b-2a91-2c210b4a5928@redhat.com>
In-Reply-To: <93b35a5e-c40a-535b-2a91-2c210b4a5928@redhat.com>
From: Chih-Min Chao <chihmin.chao@sifive.com>
Date: Mon, 15 Jul 2019 19:09:52 +0800
Message-ID: <CAEiOBXXxS-93rTAQuvY_Tkxi1pYc1YfJenpBC_8gG2ou9uUZMg@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH v2] tests/boot_linux_console: add a test
 for riscv64 + virt
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
Cc: Fam Zheng <fam@euphon.net>, "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jul 15, 2019 at 5:15 PM Philippe Mathieu-Daud=C3=A9 <philmd@redhat.=
com>
wrote:

> On 7/15/19 11:08 AM, Chih-Min Chao wrote:
> > Similar to the mips + malta test, it boots a Linux kernel on a virt
> > board and verify the serial is working.  Also, it relies on the serial
> > device set by the machine itself.
> >
> > If riscv64 is a target being built, "make check-acceptance" will
> > automatically include this test by the use of the "arch:riscv64" tags.
> >
> > Alternatively, this test can be run using:
> >
> >   $ avocado run -t arch:riscv64 tests/acceptance
> >
> > packages
> >   debian official
> >     binutils-riscv64-linux-gnu_2.32-8
> >     opensbi_0.4-1_all
> >     linux-image-4.19.0-5-riscv64 4.19.37-4
> >   third-party
> >
> https://github.com/groeck/linux-build-test/rootfs/riscv64/rootfs.cpio.gz
> >     (the repo is also used in mips target acceptance)
> >
> > Signed-off-by: Chih-Min Chao <chihmin.chao@sifive.com>
> > ---
> >  .travis.yml                            |  2 +-
> >  tests/acceptance/boot_linux_console.py | 66
> ++++++++++++++++++++++++++++++++++
> >  2 files changed, 67 insertions(+), 1 deletion(-)
> >
> > diff --git a/.travis.yml b/.travis.yml
> > index 5d3d6ee..21fcead 100644
> > --- a/.travis.yml
> > +++ b/.travis.yml
> > @@ -232,7 +232,7 @@ matrix:
> >
> >      # Acceptance (Functional) tests
> >      - env:
> > -        - CONFIG=3D"--python=3D/usr/bin/python3
> --target-list=3Dx86_64-softmmu,mips-softmmu,mips64el-softmmu,aarch64-soft=
mmu,arm-softmmu,s390x-softmmu,alpha-softmmu"
> > +        - CONFIG=3D"--python=3D/usr/bin/python3
> --target-list=3Dx86_64-softmmu,mips-softmmu,mips64el-softmmu,aarch64-soft=
mmu,arm-softmmu,s390x-softmmu,alpha-softmmu,riscv64-softmmu"
> >          - TEST_CMD=3D"make check-acceptance"
> >        after_failure:
> >          - cat tests/results/latest/job.log
> > diff --git a/tests/acceptance/boot_linux_console.py
> b/tests/acceptance/boot_linux_console.py
> > index 3215950..0f638bc 100644
> > --- a/tests/acceptance/boot_linux_console.py
> > +++ b/tests/acceptance/boot_linux_console.py
> > @@ -354,3 +354,69 @@ class BootLinuxConsole(Test):
> >          self.vm.launch()
> >          console_pattern =3D 'Kernel command line: %s' %
> kernel_command_line
> >          self.wait_for_console_pattern(console_pattern)
> > +
> > +    def test_riscv64_virt(self):
> > +        """
> > +        :avocado: tags=3Darch:riscv64
> > +        :avocado: tags=3Dmachine:virt
> > +        """
> > +        deb_url =3D ('https://snapshot.debian.org/archive/debian/'
> > +                         '20190424T171759Z/pool/main/b/binutils/'
> > +                         'binutils-riscv64-linux-gnu_2.32-8_amd64.deb'=
)
> > +        deb_hash =3D ('7fe376fd4452696c03acd508d6d613ca553ea15e')
> > +        deb_path =3D self.fetch_asset(deb_url, asset_hash=3Ddeb_hash)
> > +        objcopy_path =3D '/usr/bin/riscv64-linux-gnu-objcopy'
> > +        objcopy_path =3D self.extract_from_deb(deb_path, objcopy_path)
> > +        libbfd_path =3D '/usr/lib/x86_64-linux-gnu/libbfd-2.32-riscv64=
.so
> '
> > +        libbfd_path =3D self.extract_from_deb(deb_path, libbfd_path)
> > +        process.run('ls -al %s' % (objcopy_path))
> > +
> > +        deb_url =3D ('https://snapshot.debian.org/archive/debian/'
> > +                   '20190708T032337Z/pool/main/o/opensbi/'
> > +                   'opensbi_0.4-1_all.deb')
> > +        deb_hash =3D ('2319dcd702958291d323acf5649fd98a11d90112')
> > +        deb_path =3D self.fetch_asset(deb_url, asset_hash=3Ddeb_hash)
> > +        opensbi_path =3D ('/usr/lib/riscv64-linux-gnu/opensbi/'
> > +                        'qemu/virt/fw_jump.elf')
> > +        opensbi_path =3D self.extract_from_deb(deb_path, opensbi_path)
> > +
> > +        deb_url =3D ('https://snapshot.debian.org/archive/debian-ports=
/'
> > +                   '20190620T095935Z/pool-riscv64/main/l/linux/'
> > +                   'linux-image-4.19.0-5-riscv64_4.19.37-4_riscv64.deb=
')
> > +        deb_hash =3D ('bf5b5680c41d92134d22caef4fbd277c5217e1f0')
> > +        deb_path =3D self.fetch_asset(deb_url, asset_hash=3Ddeb_hash)
> > +        kernel_path =3D '/boot/vmlinux-4.19.0-5-riscv64'
> > +        kernel_path =3D self.extract_from_deb(deb_path, kernel_path)
> > +        kimage_path =3D self.workdir + "/Image"
> > +        env =3D os.environ
> > +        env['LD_LIBRARY_PATH'] =3D ('%s:' %
> (os.path.dirname(libbfd_path)) +
> > +                                 env.get('LD_LIBRARY_PATH', ''))
> > +        process.run(('%s -O binary -O binary -R'
> > +                     '.note -R .note.gnu.build-id -R .comment -S %s
> %s') %
> > +                     (objcopy_path, kernel_path, kimage_path))
>
> Please explain why you need to do that...
>
> Also note these tests are run on other host architecture than x86, at
> least ppc64/s390x (so this won't work there).
>
> it is because riscv64 vmlinux doesn't have physical loading address
information and
depends on certain stage bootloader to move kernel raw data to specific
physical address (0x8020_0000)

The vmlinux program headers are
  Type             Offset       VirtAddr                  PhysAddr
  FileSiz  MemSiz   Flg Align
  LOAD           0x001000 0xffffffe000000000 0x0000000000000000 0x0303a6
0x0303a6 R E 0x1000
  LOAD           0x032000 0xffffffe000031000 0x0000000000031000 0x828f0c
0x828f0c RWE 0x1000
  NOTE           0x85aec0 0xffffffe000859ec0 0x0000000000859ec0 0x00004c
0x00004c R   0x4

For legacy bootloader, bbl, It can handle payload in ELF format.  However,
for the newer OpenSBI, it can only handle raw data and
debian doesn't provide linux image in raw data format.



> > +
> > +        initrd_url =3D ('https://github.com/groeck/linux-build-test/ra=
w/'
> > +                      '8584a59ed9e5eb5ee7ca91f6d74bbb06619205b8/rootfs=
/'
> > +                      'riscv64/rootfs.cpio.gz')
> > +        initrd_hash =3D 'f4867d263754961b6f626cdcdc0cb334c47e3b49'
> > +        initrd_path =3D self.fetch_asset(initrd_url,
> asset_hash=3Dinitrd_hash)
> > +
> > +        self.vm.set_machine('virt')
> > +        self.vm.set_console()
> > +        kernel_command_line =3D (self.KERNEL_COMMON_COMMAND_LINE
> > +                               + 'console=3DttyS0 noreboot')
> > +        self.vm.add_args('-bios', opensbi_path,
> > +                         '-kernel', kimage_path,
> > +                         '-initrd', initrd_path,
> > +                         '-append', kernel_command_line,
> > +                         '-no-reboot')
> > +
> > +        self.vm.launch()
> > +        self.wait_for_console_pattern('Boot successful.')
> > +
> > +        self.exec_command_and_wait_for_pattern('cat /proc/cpuinfo',
> > +                                               'isa')
> > +        self.exec_command_and_wait_for_pattern('uname -a',
> > +                                               'SMP Debian')
> > +        self.exec_command_and_wait_for_pattern('reboot',
> > +                                               'reboot: Restarting
> system')
> >
>
