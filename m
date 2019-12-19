Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65D1FC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 12:07:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20E3B20716
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 12:07:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RSpPMzQW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20E3B20716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihuas-0004yn-5t
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 07:07:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50304)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ihua4-0004aF-PD
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:07:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ihua1-0001Ar-1A
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:06:59 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:52372
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ihua0-00011k-9O
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:06:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576757215;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DFLbbZy4PFo8xKSx4uICuaQJnBQaMmiipkwv/DSAiUM=;
 b=RSpPMzQW65qydudH34aoXWW5t94zDa35AQSLPs07oPOOGupD+30bIqQaf+u9HacQO55YHB
 XKb+gGr92SNfl56KH6nG+sZWJGPiQjFWEjuzSKxgb4zGaA9PV1nq/SRq2HzLG8TyXyYzia
 svK9rzvw2V+kKVzBTufx3VQnnEKPr+w=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-235-lsvTfTgaM4-nCmU0QgypUA-1; Thu, 19 Dec 2019 07:06:52 -0500
Received: by mail-ed1-f71.google.com with SMTP id w3so78263edt.23
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2019 04:06:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=kqgFY1NocQS2kZPd7LGt41TJ4DIVnM2jDJ/OBHxgnNo=;
 b=JlPVIYeQXg/dY9Caj6Jlm7WhkuEpMfT6kUI87zB+BoeWlGs+JqfTq5L677jl6jK9BB
 vfhYS+BhVOgwPSgxsrBZJuYZAY6xrtUXKzVCjubg3nLFyQLwT1MUJkbOMo/ixAjQ10FP
 HxOTtdOV5tVr1jZy+lkmsBe3cjI9o23H87eYEFtqE9jLt+738NmIVEK5Xctr7AtGub7X
 Rs8ywANKZvhfga4yNVs7ESm1LZTjGWXxv3XYyiOSdo89hMB9fy0bsmtGwKuE40Dq1C3k
 FMeiOIZWKC/5/opl/i6zitiram7NRqfo3Mr9SRm0217dq3wrntVRrSQD9KbGiE6U+S9v
 pcQQ==
X-Gm-Message-State: APjAAAWRP7VnJnMO/tNW//0AmvIdk9d1Z5HjOAOrrybc0Y0QM4f7UPdz
 mabwAd6rogrcUV07n7vRkm8S09/pu8IG05fIbAg0sStb18TAyL8nvQsihCbu3y9RSOxbchdJK3S
 gPtMTpwqArXiOM+A=
X-Received: by 2002:aa7:da18:: with SMTP id r24mr8666508eds.111.1576757210110; 
 Thu, 19 Dec 2019 04:06:50 -0800 (PST)
X-Google-Smtp-Source: APXvYqxjSF3iq6I/7NkiQBfzNUNHO55rxMbMFBXnzmNxQpO0YJWSojC2HgkMVmY11ZOVh3idKf4b6g==
X-Received: by 2002:aa7:da18:: with SMTP id r24mr8666452eds.111.1576757209598; 
 Thu, 19 Dec 2019 04:06:49 -0800 (PST)
Received: from [192.168.1.35] (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id j63sm338791edd.81.2019.12.19.04.06.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Dec 2019 04:06:48 -0800 (PST)
Subject: Re: [PATCH v8 2/4] Acceptance test: add "boot_linux" tests
To: Cleber Rosa <crosa@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20191218232500.23530-1-crosa@redhat.com>
 <20191218232500.23530-3-crosa@redhat.com>
 <8753cd80-283d-82c7-c35f-e995a0ed14d0@redhat.com>
 <20191219003839.GB29918@localhost.localdomain>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <e0c9d71e-e27e-33a4-11c9-b3ff78b0f107@redhat.com>
Date: Thu, 19 Dec 2019 13:06:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191219003839.GB29918@localhost.localdomain>
Content-Language: en-US
X-MC-Unique: lsvTfTgaM4-nCmU0QgypUA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
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
Cc: Fam Zheng <fam@euphon.net>, Beraldo Leal <bleal@redhat.com>,
 qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Willian Rampazzo <wrampazz@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/19/19 1:38 AM, Cleber Rosa wrote:
> On Thu, Dec 19, 2019 at 01:12:02AM +0100, Philippe Mathieu-Daud=E9 wrote:
>> Hi Cleber,
>>
>> Few minor questions...
>>
>> On 12/19/19 12:24 AM, Cleber Rosa wrote:
>>> This acceptance test, validates that a full blown Linux guest can
>>> successfully boot in QEMU.  In this specific case, the guest chosen is
>>> Fedora version 31.
>>>
>>>    * x86_64, pc and q35 machine types, with and without kvm as an
>>>      accelerator
>>>
>>>    * aarch64 and virt machine type, with and without kvm as an
>>>      accelerator
>>>
>>>    * ppc64 and pseries machine type
>>>
>>>    * s390x and s390-ccw-virtio machine type
>>>
>>> The Avocado vmimage utils library is used to download and cache the
>>> Linux guest images, and from those images a snapshot image is created
>>> and given to QEMU.  If a qemu-img binary is available in the build
>>> directory, it's used to create the snapshot image, so that matching
>>> qemu-system-* and qemu-img are used in the same test run.  If qemu-img
>>> is not available in the build tree, one is attempted to be found
>>> installed system-wide (in the $PATH).  If qemu-img is not found in the
>>> build dir or in the $PATH, the test is canceled.
>>>
>>> The method for checking the successful boot is based on "cloudinit"
>>> and its "phone home" feature.  The guest is given an ISO image with
>>> the location of the phone home server, and the information to post
>>> (the instance ID).  Upon receiving the correct information, from the
>>> guest, the test is considered to have PASSed.
>>>
>>> This test is currently limited to user mode networking only, and
>>> instructs the guest to connect to the "router" address that is hard
>>> coded in QEMU.
>>>
>>> To create the cloudinit ISO image that will be used to configure the
>>> guest, the pycdlib library is also required and has been added as
>>> requirement to the virtual environment created by "check-venv".
>>>
>>> The console output is read by a separate thread, by means of the
>>> Avocado datadrainer utility module.
>>>
>>> Signed-off-by: Cleber Rosa <crosa@redhat.com>
>>> ---
>>>    .travis.yml                    |   2 +-
>>>    tests/acceptance/boot_linux.py | 180 +++++++++++++++++++++++++++++++=
++
>>>    tests/requirements.txt         |   3 +-
>>>    3 files changed, 183 insertions(+), 2 deletions(-)
>>>    create mode 100644 tests/acceptance/boot_linux.py
>>>
>>> diff --git a/.travis.yml b/.travis.yml
>>> index 6cb8af6fa5..10c24330fd 100644
>>> --- a/.travis.yml
>>> +++ b/.travis.yml
>>> @@ -264,7 +264,7 @@ matrix:
>>>        # Acceptance (Functional) tests
>>>        - env:
>>> -        - CONFIG=3D"--python=3D/usr/bin/python3 --target-list=3Dx86_64=
-softmmu,mips-softmmu,mips64el-softmmu,aarch64-softmmu,arm-softmmu,s390x-so=
ftmmu,alpha-softmmu,ppc-softmmu,ppc64-softmmu,m68k-softmmu,sparc-softmmu"
>>> +        - CONFIG=3D"--python=3D/usr/bin/python3 --enable-tools --targe=
t-list=3Dx86_64-softmmu,mips-softmmu,mips64el-softmmu,aarch64-softmmu,arm-s=
oftmmu,s390x-softmmu,alpha-softmmu,ppc-softmmu,ppc64-softmmu,m68k-softmmu,s=
parc-softmmu"
>>>            - TEST_CMD=3D"make check-acceptance"
>>>          after_failure:
>>>            - cat tests/results/latest/job.log
>>> diff --git a/tests/acceptance/boot_linux.py b/tests/acceptance/boot_lin=
ux.py
>>> new file mode 100644
>>> index 0000000000..495ff2963c
>>> --- /dev/null
>>> +++ b/tests/acceptance/boot_linux.py
>>> @@ -0,0 +1,180 @@
>>> +# Functional test that boots a complete Linux system via a cloud image
>>> +#
>>> +# Copyright (c) 2018-2019 Red Hat, Inc.
>>> +#
>>> +# Author:
>>> +#  Cleber Rosa <crosa@redhat.com>
>>> +#
>>> +# This work is licensed under the terms of the GNU GPL, version 2 or
>>> +# later.  See the COPYING file in the top-level directory.
>>> +
>>> +import os
>>> +
>>> +from avocado_qemu import Test, BLD_DIR
>>> +
>>> +from qemu.accel import kvm_available
>>> +
>>> +from avocado.utils import cloudinit
>>> +from avocado.utils import network
>>> +from avocado.utils import vmimage
>>> +from avocado.utils import datadrainer
>>> +
>>> +
>>> +KVM_NOT_AVAILABLE =3D "KVM accelerator does not seem to be available"
>>> +
>>> +
>>> +class BootLinux(Test):
>>> +    """
>>> +    Boots a Linux system, checking for a successful initialization
>>> +    """
>>> +
>>> +    timeout =3D 900
>>> +    chksum =3D None
>>> +
>>> +    def setUp(self):
>>> +        super(BootLinux, self).setUp()
>>> +        self.prepare_boot()
>>> +        self.vm.add_args('-smp', '2')
>>
>> Hmmm are we assuming everybody has multicore systems?
>>
>=20
> Not really, but isn't it possible to have virtual CPUs > actual CPUs?
> IMO testing with smp > 1 is a better test than with smp =3D=3D 1.

I guess it is unusual to run acceptance tests on non-multicore systems,=20
so this is probably not an issue.

>>> +        self.vm.add_args('-m', '2048')
>>
>> We should not fail the test if this condition is not possible.
>>
>=20
> You mean from the host side, right?  I have doubts about what to do
> here, in the sense that we can't easily and reliably set aside memory
> in the system to run qemu.  We could of course check the amount of
> physical or free memory in the system at the test start time, but
> there would still be somewhat of a race condition.

See:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg652535.html

On 15/10/2019 19:03, Peter Maydell wrote:
 > Hi. I just discovered that this makes 'make check' fail on
 > 32-bit systems, because you can't default to 2GB of RAM
 > for a board:
 >
 > (armhf)pmaydell@mustang-maydell:~/qemu$
 > ./build/all-a32/arm-softmmu/qemu-system-arm -M ast2600-evb
 > qemu-system-arm: at most 2047 MB RAM can be simulated

Looking at:
https://docs.python.org/2/library/platform.html#cross-platform

Maybe we can use:

   @skipUnless(sys.maxsize > 2**32, 'Require 64-bit host')

>=20
> Also, with tests running in parallel (ie, avocado nrun
> tests/acceptance/), this would be even trickier...

Yeah this is a complex case. Maybe for now we can add a tag for the=20
minimum of memory required for a test. Then later it might be easier=20
figure something.

This class can help:
https://psutil.readthedocs.io/en/latest/#psutil.virtual_memory

>>> +        self.vm.add_args('-drive', 'file=3D%s' % self.boot.path)
>>> +        self.prepare_cloudinit()
>>> +
>>> +    def prepare_boot(self):
>>> +        self.log.info('Downloading/preparing boot image')
>>> +        # Fedora 31 only provides ppc64le images
>>> +        image_arch =3D self.arch
>>> +        if image_arch =3D=3D 'ppc64':
>>> +            image_arch =3D 'ppc64le'
>>> +        # If qemu-img has been built, use it, otherwise the system wid=
e one
>>> +        # will be used.  If none is available, the test will cancel.
>>> +        qemu_img =3D os.path.join(BLD_DIR, 'qemu-img')
>>> +        if os.path.exists(qemu_img):
>>> +            vmimage.QEMU_IMG =3D qemu_img
>>> +        try:
>>> +            self.boot =3D vmimage.get(
>>> +                'fedora', arch=3Dimage_arch, version=3D'31',
>>> +                checksum=3Dself.chksum,
>>> +                algorithm=3D'sha256',
>>> +                cache_dir=3Dself.cache_dirs[0],
>>> +                snapshot_dir=3Dself.workdir)
>>> +        except:
>>> +            self.cancel('Failed to download/prepare boot image')
>>> +
>>> +    def prepare_cloudinit(self):
>>> +        self.log.info('Preparing cloudinit image')
>>> +        try:
>>> +            cloudinit_iso =3D os.path.join(self.workdir, 'cloudinit.is=
o')
>>> +            self.phone_home_port =3D network.find_free_port()
>>> +            cloudinit.iso(cloudinit_iso, self.name,
>>> +                          username=3D'root',
>>> +                          password=3D'password',
>>> +                          # QEMU's hard coded usermode router address
>>> +                          phone_home_host=3D'10.0.2.2',
>>> +                          phone_home_port=3Dself.phone_home_port)
>>> +            self.vm.add_args('-drive', 'file=3D%s,format=3Draw' % clou=
dinit_iso)
>>> +        except Exception:
>>> +            self.cancel('Failed to prepared cloudinit image')
>>> +
>>> +    def launch_and_wait(self):
>>> +        self.vm.set_console()
>>> +        self.vm.launch()
>>> +        console_drainer =3D datadrainer.LineLogger(self.vm.console_soc=
ket.fileno(),
>>> +                                                 logger=3Dself.log.get=
Child('console'))
>>> +        console_drainer.start()
>>> +        self.log.info('VM launched, waiting for boot confirmation from=
 guest')
>>> +        cloudinit.wait_for_phone_home(('0.0.0.0', self.phone_home_port=
), self.name)
>>> +
>>> +
>>> +class BootLinuxX8664(BootLinux):
>>> +    """
>>> +    :avocado: tags=3Darch:x86_64
>>> +    """
>>> +
>>> +    chksum =3D 'e3c1b309d9203604922d6e255c2c5d098a309c2d46215d8fc02695=
4f3c5c27a0'
>>> +
>>> +    def test_pc(self):
>>
>> I'd name this test_pc_i440fx_tcg, but are you sure the default is tcg?
>>
>=20
> Even if there's no matching machine type named "pc-i440fx"?

Hmm 'pc' is a confusing alias, kept for backward compatibility...
'q35' is also an alias, see:

$ qemu-system-x86_64 -M help
Supported machines are:
pc                   Standard PC (i440FX + PIIX, 1996) (alias of=20
pc-i440fx-3.1)
pc-i440fx-3.1        Standard PC (i440FX + PIIX, 1996) (default)
pc-i440fx-3.0        Standard PC (i440FX + PIIX, 1996)
pc-i440fx-2.9        Standard PC (i440FX + PIIX, 1996)
...
q35                  Standard PC (Q35 + ICH9, 2009) (alias of pc-q35-3.1)
pc-q35-3.1           Standard PC (Q35 + ICH9, 2009)
pc-q35-3.0           Standard PC (Q35 + ICH9, 2009)
pc-q35-2.9           Standard PC (Q35 + ICH9, 2009)
pc-q35-2.8           Standard PC (Q35 + ICH9, 2009)
...
isapc                ISA-only PC
none                 empty machine
xenfv                Xen Fully-virtualized PC
xenpv                Xen Para-virtualized PC

Historically the 'pc' machine was aiming at modeling a 'PC compatible'=20
machine, as described here:
https://en.wikipedia.org/wiki/IBM_PC_compatible

We currently have 3 emulated PC machines (excluding the virtual machines=20
such MicroVM, Xen).

Some history:

- commit 0824d6fc6
   The first pc machine is introduced, inside main().
   It only use an ISA bus. Today we know this as 'isapc'.

- commit 80cabfad1
   Refactor, the pc machine is extracted to hw/pc.c

- commit 69b910399
   PCI support is added.

- commit bb0c6722b
   PCI is used by default. The machine becomes what we today
   calls 'pc'.

- commit b5ff2d6e2
   The machine is officially called 'pc'.

- commit 3dbbdc255
   The 'isapc' machine is added back: it is the 'pc' machine
   with PCI disabled.

- commit df2d8b3ed
   The 'q35' machine is added.
   Instead of a i440FX northbridge and PIIX3 southbridge
   chipsets, it uses a Q35 northbridge and ICH9 southbridge.
   See: https://wiki.qemu.org/Features/Q35

So 'pc' is more a 'family' of different machines.

You can verify the codebase, the abstract parent is in hw/i386/pc.c:

static const TypeInfo pc_machine_info =3D {
     .name =3D TYPE_PC_MACHINE,
     .parent =3D TYPE_X86_MACHINE,
     .abstract =3D true,
     .instance_size =3D sizeof(PCMachineState),

While the children implementations are hw/i386/pc_piix.c and=20
hw/i386/pc_q35.c (pc_piix.c implements both isapc + i440fx).

I'm not sure why one is named by its southbridge chipset, and
the other one by its northbridge. I suppose because for a long
time the i440fx+piix were mixed in the same file. I cleaned that
recently in commits 0fd61a2d1..0f25d865a1:

$  git log --oneline --reverse 0fd61a2d1~..0f25d865a1
0fd61a2d1c hw/pci-host/piix: Move i440FX declarations to=20
hw/pci-host/i440fx.h
553b4559dc hw/pci-host/piix: Fix code style issues
14a026dd58 hw/pci-host/piix: Extract PIIX3 functions to hw/isa/piix3.c
0f25d865a1 hw/pci-host: Rename incorrectly named 'piix' as 'i440fx'

>>> +        """
>>> +        :avocado: tags=3Dmachine:pc
>>> +        """
>>> +        self.launch_and_wait()
>>> +
>>> +    def test_kvm_pc(self):
>>
>> This test_pc_i440fx_kvm
>>
>=20
> Ditto.
>=20
>>> +        """
>>> +        :avocado: tags=3Dmachine:pc
>>> +        :avocado: tags=3Daccel:kvm
>>> +        """
>>> +        if not kvm_available(self.arch, self.qemu_bin):
>>> +            self.cancel(KVM_NOT_AVAILABLE)
>>> +        self.vm.add_args("-accel", "kvm")
>>> +        self.launch_and_wait()
>>> +
>>> +    def test_q35(self):
>>
>> This one test_pc_q35_tcg
>>
>=20
> Both *pc* and *q35*?  I'm missing something here.  +1 for the explicit
> "tcg" along with an also explicit check for the availability of the
> tcg accel.
>=20
>>> +        """
>>> +        :avocado: tags=3Dmachine:q35
>>> +        """
>>> +        self.launch_and_wait()
>>> +
>>> +    def test_kvm_q35(self):
>>
>> Here test_pc_q35_kvm.
>>
>=20
> I don't get the "pc" part here.
>=20
>>> +        """
>>> +        :avocado: tags=3Dmachine:q35
>>> +        :avocado: tags=3Daccel:kvm
>>> +        """
>>> +        if not kvm_available(self.arch, self.qemu_bin):
>>> +            self.cancel(KVM_NOT_AVAILABLE)
>>> +        self.vm.add_args("-accel", "kvm")
>>> +        self.launch_and_wait()
>>> +
>>> +
>>> +class BootLinuxAarch64(BootLinux):
>>> +    """
>>> +    :avocado: tags=3Darch:aarch64
>>> +    :avocado: tags=3Dmachine:virt
>>> +    """
>>> +
>>> +    chksum =3D '1e18d9c0cf734940c4b5d5ec592facaed2af0ad0329383d5639c99=
7fdf16fe49'
>>> +
>>> +    def test_virt(self):
>>
>> We have other 'virt' machines:
>>
>> $ git grep '"virt"'
>> hw/arm/virt.c:83:            mc->alias =3D "virt"; \
>> hw/riscv/virt.c:613:    .name       =3D MACHINE_TYPE_NAME("virt"),
>> hw/xtensa/virt.c:135:DEFINE_MACHINE("virt", xtensa_virt_machine_init)
>>
>> Maybe rename test_aarch64_virt_tcg?
>>
>=20
> The "test name", or "test ID" includes the class name, so that already
> makes it clear (IMO) that this test is about the "virt" machine type
> for the "aarch64" arch.

OK, good point. 'tcg' suffix still?

>>> +        self.vm.add_args('-cpu', 'cortex-a53')
>>> +        self.vm.add_args('-bios',
>>> +                         os.path.join(BLD_DIR, 'pc-bios',
>>> +                                      'edk2-aarch64-code.fd'))
>>> +        self.vm.add_args('-device', 'virtio-rng-pci,rng=3Drng0')
>>> +        self.vm.add_args('-object', 'rng-random,id=3Drng0,filename=3D/=
dev/urandom')
>>> +        self.launch_and_wait()
>>> +
>>> +    def test_kvm_virt(self):
>>> +        """
>>> +        :avocado: tags=3Daccel:kvm
>>> +        """
>>> +        if not kvm_available(self.arch, self.qemu_bin):
>>> +            self.cancel(KVM_NOT_AVAILABLE)
>>> +        self.vm.add_args("-accel", "kvm")
>>> +        self.test_virt()
>>> +
>>> +
>>> +class BootLinuxPPC64(BootLinux):
>>> +    """
>>> +    :avocado: tags=3Darch:ppc64
>>> +    """
>>> +
>>> +    chksum =3D '7c3528b85a3df4b2306e892199a9e1e43f991c506f2cc390dc4efa=
2026ad2f58'
>>> +
>>> +    def test_pseries(self):
>>
>> Rename as test_ppc64el_pseries_tcg?
>>
>=20
> Same here (class name contains the arch).

Yes. 'tcg' suffix still?

>>> +        """
>>> +        :avocado: tags=3Dmachine:pseries
>>> +        """
>>> +        self.launch_and_wait()
>>> +
>>> +
>>> +class BootLinuxS390X(BootLinux):
>>> +    """
>>> +    :avocado: tags=3Darch:s390x
>>> +    """
>>> +
>>> +    chksum =3D '4caaab5a434fd4d1079149a072fdc7891e354f834d355069ca982f=
dcaf5a122d'
>>> +
>>> +    def test_s390_ccw_virtio(self):
>>> +        """
>>> +        :avocado: tags=3Dmachine:s390-ccw-virtio
>>> +        """
>>> +        self.launch_and_wait()
>>> diff --git a/tests/requirements.txt b/tests/requirements.txt
>>> index a2a587223a..0192c352cd 100644
>>> --- a/tests/requirements.txt
>>> +++ b/tests/requirements.txt
>>> @@ -1,4 +1,5 @@
>>>    # Add Python module requirements, one per line, to be installed
>>>    # in the tests/venv Python virtual environment. For more info,
>>>    # refer to: https://pip.pypa.io/en/stable/user_guide/#id1
>>> -avocado-framework=3D=3D72.0
>>> +avocado-framework=3D=3D73.0
>>> +pycdlib=3D=3D1.8.0
>>>


