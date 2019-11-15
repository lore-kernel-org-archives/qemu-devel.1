Return-Path: <SRS0=pQgJ=ZH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D72E0C432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 23:48:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94316206D6
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 23:48:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IFKmYM6c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94316206D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45766 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVlKJ-0004D7-P5
	for qemu-devel@archiver.kernel.org; Fri, 15 Nov 2019 18:48:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36000)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1iVlJF-0003ZO-Vb
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 18:47:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1iVlJE-000893-8h
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 18:47:25 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53505
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1iVlJE-00088p-24
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 18:47:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573861643;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ET81t6405wv/Q8Anr25tMH7cFiMVMkItqVzY4X9kl4I=;
 b=IFKmYM6cT8MslCRdQzSeDlv1R189ARHn1sQFBDod1GAfUo55IXGmjFR45zli/x+pQjq443
 7xQFaRFc1NmyT0gyLqPJ3+01n8qYjkTrvHczuhPyf6+jaGXTT167WATco2AuB4A9sOQiU4
 5R3AAHDUzOxbnA4i8Bwc94uFKWTrYQw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-231-KjDX9pQ8Pf-S2yuanit_ZQ-1; Fri, 15 Nov 2019 18:47:22 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 81694801FA1;
 Fri, 15 Nov 2019 23:47:20 +0000 (UTC)
Received: from localhost.localdomain (ovpn-125-0.rdu2.redhat.com [10.10.125.0])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 027211036C80;
 Fri, 15 Nov 2019 23:47:13 +0000 (UTC)
Date: Fri, 15 Nov 2019 18:47:11 -0500
From: Cleber Rosa <crosa@redhat.com>
To: Wainer dos Santos Moschetta <wainersm@redhat.com>
Subject: Re: [PATCH v7 8/8] Acceptance test: add "boot_linux" tests
Message-ID: <20191115234711.GK19559@localhost.localdomain>
References: <20191104151323.9883-1-crosa@redhat.com>
 <20191104151323.9883-9-crosa@redhat.com>
 <3cffa345-c61f-397e-2292-be5d6ed946bf@redhat.com>
MIME-Version: 1.0
In-Reply-To: <3cffa345-c61f-397e-2292-be5d6ed946bf@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: KjDX9pQ8Pf-S2yuanit_ZQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: Beraldo Leal <bleal@redhat.com>, qemu-devel@nongnu.org,
 Fabien Chouteau <chouteau@adacore.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>,
 Willian Rampazzo <wrampazz@redhat.com>, qemu-ppc@nongnu.org,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Nov 08, 2019 at 05:42:14PM -0200, Wainer dos Santos Moschetta wrote=
:
>=20
> On 11/4/19 1:13 PM, Cleber Rosa wrote:
> > This acceptance test, validates that a full blown Linux guest can
> > successfully boot in QEMU.  In this specific case, the guest chosen is
> > Fedora version 31.
> >=20
> >   * x86_64, pc and q35 machine types, with and without kvm as an
> >     accellerator
> >=20
> >   * aarch64 and virt machine type, with and without kvm as an
> >     accellerator
> >=20
> >   * ppc64 and pseries machine type
> >=20
> >   * s390x and s390-ccw-virtio machine type
> >=20
> > The method for checking the successful boot is based on "cloudinit"
> > and its "phone home" feature.  The guest is given an ISO image
> > with the location of the phone home server, and the information to
> > post (the instance ID).  Upon receiving the correct information,
> > from the guest, the test is considered to have PASSed.
> >=20
> > This test is currently limited to user mode networking only, and
> > instructs the guest to connect to the "router" address that is hard
> > coded in QEMU.
> >=20
> > To create the cloudinit ISO image that will be used to configure the
> > guest, the pycdlib library is also required and has been added as
> > requirement to the virtual environment created by "check-venv".
> >=20
> > The console output is read by a separate thread, by means of the
> > Avocado datadrainer utility module.
> >=20
> > Signed-off-by: Cleber Rosa <crosa@redhat.com>
> > ---
> >   tests/acceptance/boot_linux.py | 175 ++++++++++++++++++++++++++++++++=
+
> >   tests/requirements.txt         |   1 +
> >   2 files changed, 176 insertions(+)
> >   create mode 100644 tests/acceptance/boot_linux.py
> >=20
> > diff --git a/tests/acceptance/boot_linux.py b/tests/acceptance/boot_lin=
ux.py
> > new file mode 100644
> > index 0000000000..882f7dc5df
> > --- /dev/null
> > +++ b/tests/acceptance/boot_linux.py
> > @@ -0,0 +1,175 @@
> > +# Functional test that boots a complete Linux system via a cloud image
> > +#
> > +# Copyright (c) 2018-2019 Red Hat, Inc.
> > +#
> > +# Author:
> > +#  Cleber Rosa <crosa@redhat.com>
> > +#
> > +# This work is licensed under the terms of the GNU GPL, version 2 or
> > +# later.  See the COPYING file in the top-level directory.
> > +
> > +import os
> > +
> > +from avocado_qemu import Test, SRC_ROOT_DIR
> > +
> > +from qemu import kvm_available
> > +
> > +from avocado.utils import cloudinit
> > +from avocado.utils import network
> > +from avocado.utils import vmimage
> > +from avocado.utils import datadrainer
> > +
> > +
> > +KVM_NOT_AVAILABLE =3D "KVM accelerator does not seem to be available"
> > +
> > +
> > +class BootLinux(Test):
> > +    """
> > +    Boots a Linux system, checking for a successful initialization
> > +    """
> > +
> > +    timeout =3D 600
> > +    chksum =3D None
> > +
> > +    def setUp(self):
> > +        super(BootLinux, self).setUp()
> > +        self.prepare_boot()
> > +        self.vm.add_args('-smp', '2')
> > +        self.vm.add_args('-m', '2048')
> > +        self.vm.add_args('-drive', 'file=3D%s' % self.boot.path)
> > +        self.prepare_cloudinit()
> > +
> > +    def prepare_boot(self):
> > +        self.log.info('Downloading/preparing boot image')
> Cosmetic: replace 'Downloading/preparing' with 'Downloading' since this
> function does only download the boot image.

Actually the "preparing" is intentional, because this will also
prepare the snapshot image (the original vmimage is never touched).

> > +        # Fedora 31 only provides ppc64le images
> > +        image_arch =3D self.arch
> > +        if image_arch =3D=3D 'ppc64':
> > +            image_arch =3D 'ppc64le'
> > +        try:
> > +            self.boot =3D vmimage.get(
> > +                'fedora', arch=3Dimage_arch, version=3D'31',
> > +                checksum=3Dself.chksum,
> > +                algorithm=3D'sha256',
> > +                cache_dir=3Dself.cache_dirs[0],
> > +                snapshot_dir=3Dself.workdir)
> > +        except:
> > +            self.cancel('Failed to download/prepare boot image')
>=20
> Likewise.
>

Likewise too :)

> > +
> > +    def prepare_cloudinit(self):
> > +        self.log.info('Preparing cloudinit image')
> > +        try:
> > +            cloudinit_iso =3D os.path.join(self.workdir, 'cloudinit.is=
o')
> > +            self.phone_home_port =3D network.find_free_port()
> > +            cloudinit.iso(cloudinit_iso, self.name,
> > +                          username=3D'root',
> > +                          password=3D'password',
> > +                          # QEMU's hard coded usermode router address
> > +                          phone_home_host=3D'10.0.2.2',
> > +                          phone_home_port=3Dself.phone_home_port)
> > +            self.vm.add_args('-drive', 'file=3D%s,format=3Draw' % clou=
dinit_iso)
> > +        except Exception:
> > +            self.cancel('Failed to prepared cloudinit image')
> > +
> > +    def launch_and_wait(self):
> > +        self.vm.set_console()
> > +        self.vm.launch()
> > +        console_drainer =3D datadrainer.LineLogger(self.vm.console_soc=
ket.fileno(),
> > +                                                 logger=3Dself.log.get=
Child('console'))
> > +        console_drainer.start()
> > +        self.log.info('VM launched, waiting for boot confirmation from=
 guest')
> > +        cloudinit.wait_for_phone_home(('0.0.0.0', self.phone_home_port=
), self.name)
> > +
> > +
> > +class BootLinuxX8664(BootLinux):
> > +    """
> > +    :avocado: tags=3Darch:x86_64
> > +    """
> > +
> > +    chksum =3D 'e3c1b309d9203604922d6e255c2c5d098a309c2d46215d8fc02695=
4f3c5c27a0'
> > +
> > +    def test_pc(self):
> > +        """
> > +        :avocado: tags=3Dmachine:pc
> > +        """
> > +        self.launch_and_wait()
> > +
> > +    def test_kvm_pc(self):
> > +        """
> > +        :avocado: tags=3Dmachine:pc
> > +        :avocado: tags=3Daccel:kvm
> > +        """
> > +        if not kvm_available(self.arch):
> > +            self.cancel(KVM_NOT_AVAILABLE)
>=20
> kvm_available() solely checks for kvm presence on host, not if enabled in
> the target binary. That said, as a follow up we could adapt this test to =
use
> a strengthen approach as I proposed in patch 02 of '[PATCH 0/3] Acceptanc=
e
> tests: boot Linux with KVM test' [1] series.
>=20
> [1] https://www.mail-archive.com/qemu-devel@nongnu.org/msg627498.html
>

Yes, I'll revisit that.  Thanks for the reminder.

> > +        self.vm.add_args("-accel", "kvm")
> > +        self.launch_and_wait()
> > +
> > +    def test_q35(self):
> > +        """
> > +        :avocado: tags=3Dmachine:q35
> > +        """
> > +        self.launch_and_wait()
> > +
> > +    def test_kvm_q35(self):
> > +        """
> > +        :avocado: tags=3Dmachine:q35
> > +        :avocado: tags=3Daccel:kvm
> > +        """
> > +        if not kvm_available(self.arch):
> > +            self.cancel(KVM_NOT_AVAILABLE)
> > +        self.vm.add_args("-accel", "kvm")
> > +        self.launch_and_wait()
> > +
> > +
> > +class BootLinuxAarch64(BootLinux):
> > +    """
> > +    :avocado: tags=3Darch:aarch64
> > +    :avocado: tags=3Dmachine:virt
> > +    """
> > +
> > +    chksum =3D '1e18d9c0cf734940c4b5d5ec592facaed2af0ad0329383d5639c99=
7fdf16fe49'
> > +
> > +    def test_virt(self):
> > +        self.vm.add_args('-cpu', 'cortex-a53')
> > +        self.vm.add_args('-bios',
> > +                         os.path.join(SRC_ROOT_DIR, 'pc-bios',
> > +                                      'edk2-aarch64-code.fd'))
> > +        self.vm.add_args('-device', 'virtio-rng-pci,rng=3Drng0')
> > +        self.vm.add_args('-object', 'rng-random,id=3Drng0,filename=3D/=
dev/urandom')
> > +        self.launch_and_wait()
> > +
> > +    def test_kvm_virt(self):
> > +        """
> > +        :avocado: tags=3Daccel:kvm
> > +        """
> > +        if not kvm_available(self.arch):
> > +            self.cancel(KVM_NOT_AVAILABLE)
> > +        self.vm.add_args("-accel", "kvm")
> > +        self.test_virt()
> > +
> > +
> > +class BootLinuxPPC64(BootLinux):
> > +    """
> > +    :avocado: tags=3Darch:ppc64
> > +    """
> > +
> > +    chksum =3D '7c3528b85a3df4b2306e892199a9e1e43f991c506f2cc390dc4efa=
2026ad2f58'
> > +
> > +    def test_pseries(self):
> > +        """
> > +        :avocado: tags=3Dmachine:pseries
> > +        """
> > +        self.launch_and_wait()
> > +
> > +
> > +class BootLinuxS390X(BootLinux):
> > +    """
> > +    :avocado: tags=3Darch:s390x
> > +    """
> > +
> > +    chksum =3D '4caaab5a434fd4d1079149a072fdc7891e354f834d355069ca982f=
dcaf5a122d'
> > +
> > +    def test_s390_ccw_virtio(self):
> > +        """
> > +        :avocado: tags=3Dmachine:s390-ccw-virtio
> > +        """
> > +        self.launch_and_wait()
> > diff --git a/tests/requirements.txt b/tests/requirements.txt
> > index a2a587223a..3893361e0c 100644
> > --- a/tests/requirements.txt
> > +++ b/tests/requirements.txt
> > @@ -2,3 +2,4 @@
> >   # in the tests/venv Python virtual environment. For more info,
> >   # refer to: https://pip.pypa.io/en/stable/user_guide/#id1
> >   avocado-framework=3D=3D72.0
> > +pycdlib=3D=3D1.8.0
>=20
> Besides the cosmetics suggestions, this test is ready to go.
>=20
> In other to write powerful tests there will be needed a mechanism to boot=
 a
> full blown guest which can be interacted with. I see the proposed BootLin=
ux
> class here as the first milestone towards that goal. Another reason to me=
rge
> this as soon as possible.
>

Yes, agreed.

> Ran the tests on my x86_68 machine with RHEL 8.1, and all pass
> (BootLinuxAarch64.test_kvm_virt correctly skipped).
>=20
> Reviewed-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
>=20
> Thanks,
>=20
> Wainer
>=20

Thanks!
- Cleber.


