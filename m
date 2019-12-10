Return-Path: <SRS0=2P1T=2A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 299B3C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 02:22:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E95712071E
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 02:22:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eXVt2mlW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E95712071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49228 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieVAB-0001GD-13
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 21:22:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41793)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1ieV9R-0000oJ-Px
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 21:21:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1ieV9N-0006k1-TK
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 21:21:23 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:31310
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1ieV9N-0006jn-Ny
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 21:21:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575944481;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=x4kZQ5Ka2bpy7QOohGHiGFONP/qg3hXqItWfG2qVYuw=;
 b=eXVt2mlWss0etdTXchsro9QEHxyRMYI3A9MBksoy+at11aFVJLrSAcM9eUSvR07PqNhotC
 BxoqcXycib9s5x9osaOb0q7M3idMy/LjbnzwwHXg412Dcpp3itagmjKrr4jU9JegptF+0c
 bJTIhAJ2SI2BVG9QDAguotqeuGjB11M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-233--hk7NZQKNYOZWBr78LMbkA-1; Mon, 09 Dec 2019 21:21:19 -0500
X-MC-Unique: -hk7NZQKNYOZWBr78LMbkA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9AC34800D4C;
 Tue, 10 Dec 2019 02:21:17 +0000 (UTC)
Received: from localhost.localdomain (ovpn-125-99.rdu2.redhat.com
 [10.10.125.99])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3A7D619C5B;
 Tue, 10 Dec 2019 02:21:11 +0000 (UTC)
Date: Mon, 9 Dec 2019 21:21:10 -0500
From: Cleber Rosa <crosa@redhat.com>
To: Wainer dos Santos Moschetta <wainersm@redhat.com>
Subject: Re: [PATCH 1/2] tests/acceptance: Add PVH boot test
Message-ID: <20191210022110.GF31990@localhost.localdomain>
References: <20191206140012.15517-1-wainersm@redhat.com>
 <20191206140012.15517-2-wainersm@redhat.com>
 <20191206165419.GC23522@dhcp-17-72.bos.redhat.com>
 <796713f8-1cb9-adc4-968f-e28d4d6ae23e@redhat.com>
MIME-Version: 1.0
In-Reply-To: <796713f8-1cb9-adc4-968f-e28d4d6ae23e@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Zs/RYxT/hKAHzkfQ"
Content-Disposition: inline
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
Cc: fam@euphon.net, alex.bennee@linaro.org, qemu-devel@nongnu.org,
 wrampazz@redhat.com, philmd@redhat.com, sgarzare@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Zs/RYxT/hKAHzkfQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 09, 2019 at 12:43:22PM -0200, Wainer dos Santos Moschetta wrote=
:
>=20
> On 12/6/19 2:54 PM, Cleber Rosa wrote:
> > On Fri, Dec 06, 2019 at 09:00:11AM -0500, Wainer dos Santos Moschetta w=
rote:
> > > QEMU 4.0 onward is able to boot an uncompressed kernel
> > > image by using the x86/HVM direct boot ABI. It needs
> > > Linux >=3D 4.21 built with CONFIG_PVH=3Dy.
> > >=20
> > > This introduces an acceptance test which checks an
> > > uncompressed Linux kernel image boots properly.
> > >=20
> > > Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
> > > ---
> > >   tests/acceptance/pvh.py | 48 ++++++++++++++++++++++++++++++++++++++=
+++
> > >   1 file changed, 48 insertions(+)
> > >   create mode 100644 tests/acceptance/pvh.py
> > >=20
> > > diff --git a/tests/acceptance/pvh.py b/tests/acceptance/pvh.py
> > > new file mode 100644
> > > index 0000000000..c68489c273
> > > --- /dev/null
> > > +++ b/tests/acceptance/pvh.py
> > > @@ -0,0 +1,48 @@
> > > +# Copyright (c) 2019 Red Hat, Inc.
> > > +#
> > > +# Author:
> > > +#  Wainer dos Santos Moschetta <wainersm@redhat.com>
> > > +#
> > > +# This work is licensed under the terms of the GNU GPL, version 2 or
> > > +# later.  See the COPYING file in the top-level directory.
> > > +
> > > +"""
> > > +x86/HVM direct boot acceptance tests.
> > > +"""
> > > +
> > > +from avocado.utils.kernel import KernelBuild
> > > +from avocado_qemu import Test
> > > +from avocado_qemu import wait_for_console_pattern
> > > +
> > > +
> > > +class Pvh(Test):
> > > +    """
> > > +    Test suite for x86/HVM direct boot feature.
> > > +
> > > +    :avocado: tags=3Dslow,arch=3Dx86_64,machine=3Dq35

This should be:

   :avocado: tags=3Dslow,arch:x86_64,machine:q35

That is, the separator of key/val is ':', because the equal sign is
used to separate the docstring directive type (here it's "tags") from
their content.  `avocado list -V` should show you the tag keys with
all their values inside a parenthesis.  That is, for the following
docstring directive:

   :avocado: tags=3Dslow,arch:x86_64,machine:q35,machine:pc

You'd get:

   slow,arch(x86_64),machine(q35,pc)

> > > +    """
> > > +    def test_boot_vmlinux(self):
> > > +        """
> > > +        Boot uncompressed kernel image.
> > > +        """
> > > +        # QEMU can boot a vmlinux image for kernel >=3D 4.21 built
> > > +        # with CONFIG_PVH=3Dy
> > > +        kernel_version =3D '5.4.1'
> > > +        kbuild =3D KernelBuild(kernel_version, work_dir=3Dself.workd=
ir)
> > > +        try:
> > > +            kbuild.download()
> > > +            kbuild.uncompress()
> > > +            kbuild.configure(targets=3D['defconfig', 'kvmconfig'],
> > > +                             extra_configs=3D['CONFIG_PVH=3Dy'])
> > I'm aware of the reason why this uses APIs not fulfilled by
> > tests/requirements.txt, but, for the general public reviewing/testing
> > code with extra requirements, it's a good idea to bump the
> > requirements to a version that fulfills the requirement, and comment
> > out clearly on the temporary nature of the change (marking the patch).
>=20
> Good idea, thanks for the tip.
>=20
> >=20
> > For instance, for this requirement, we could have:
> >=20
> > diff --git a/tests/requirements.txt b/tests/requirements.txt
> > index a2a587223a..5498d67bc1 100644
> > --- a/tests/requirements.txt
> > +++ b/tests/requirements.txt
> > @@ -1,4 +1,5 @@
> >   # Add Python module requirements, one per line, to be installed
> >   # in the tests/venv Python virtual environment. For more info,
> >   # refer to: https://pip.pypa.io/en/stable/user_guide/#id1
> > -avocado-framework=3D=3D72.0
> > +# [REMOVE ME] use post 73.0 Avocado containing the new kernel build AP=
Is
> > +-e git+https://github.com/avocado-framework/avocado@d6fb24edcf847f09c3=
12b55df3c674c64c79793e#egg=3Davocado_framework
> >=20
> > This will not only help people to test it, but should also make
> > it work transparently on CI.
>=20
> True. It could had helped me to check the missing packages on Travis to
> build the kernel. I'm ashamed to tell how I did it. :)
>

Don't be, because you did check it. :)

> >=20
> > > +            kbuild.build()
> > As stated in my response to the cover letter, I think we need to move
> > this elsewhere.  The *very* minimum is to have this in a setUp()
> > method, but we should strongly consider other solutions.
>=20
> On the proposed implementation the kernel is built only once and only for
> this test case. If I move the code to setUp() it will attempt to build th=
e
> vmlinux for every case even when not needed (suppose I add a 'boot not
> CONFIG_PVH vmlinux to check it properly handle error' case which uses
> distro's kernel). Unless I put a guard like 'do not build if already
> present' which IMHO is weird. In other words, IMHO setUp() should hold on=
ly
> code that is share-able across cases.
>

I was thinking of *this* test setUp(), not avocado_qemu.Test.setUp().

Anyway, looking at the other options we talked about, I was able to
boot a vmlinux image from a "mainstream distro" kernel package[1] that
already has CONFIG_PVH enabled[2] with recent QEMU (and also tested
that I wasn't able to do so with older QEMU).  Other distros also
provide a vmlinux image, but as part of the debuginfo packages and
they can be HUGE, so not recommended here.

If we go with this route, compilation would be a non-issue, and this
test would be just like the other "boot_linux_console.py" tests.

> >=20
> > > +        except:
> > > +            self.cancel("Unable to build vanilla kernel %s" % kernel=
_version)
> > > +
> > > +        self.vm.set_machine('q35')
> > > +        self.vm.set_console()
> > > +        kernel_command_line =3D 'printk.time=3D0 console=3DttyS0'
> > > +        self.vm.add_args('-kernel', kbuild.vmlinux,
> > > +                         '-append', kernel_command_line)
> > And just for being thorough (and purist? idealistic? Utopian? :), if
> > we stop and think about it, the following two lines are really what
> > this test is all about.  Everything else should be the test's setup.
> >=20
> > I'm not arguing in favor of being radical and reject anything that is
> > not perfect, but just reminding ourselves (myself very much included)
> > of this general direction.
>=20
> IMHO we should merge tests which are "good enough" then interactively
> improve them. At least they will run with some frequency and eventually
> catch regressions while infra bits are improved. Now, what's 'good enough=
'
> for an acceptance test? Perhaps a test that run consistently?
>

Right.  But even though this test can be proven stable (I can't
disprove it), we also have to watch for the overall user experience.
Like I've said before, I don't think users running this test are
interested in building a kernel, but asserting a QEMU feature, and
that can be a source of "test distrust" IMO.

> >=20
> > Cheers,
> > - Cleber.
> >=20
> > > +        self.vm.launch()
> > > +        wait_for_console_pattern(self, 'Kernel command line: %s' %
> > > +                                 kernel_command_line)
> > > --=20
> > > 2.21.0
> > >

Please let me know what you think of reusing an available kernel instead
of building one.

Cheers,
- Cleber.

[1] https://download.opensuse.org/repositories/openSUSE:/Factory/standard/x=
86_64/kernel-vanilla-5.3.12-1.1.x86_64.rpm
[2] https://kernel.opensuse.org/cgit/kernel-source/tree/config/x86_64/vanil=
la?h=3Dlinux-next&id=3D03bbea2f5521b0fe7bae800297509e9ca4c23117#n331
[3] http://mirrors.syringanetworks.net/fedora/linux/releases/31/Everything/=
x86_64/debug/tree/Packages/k/


--Zs/RYxT/hKAHzkfQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl3vARMACgkQZX6NM6Xy
CfNr+A/9EZDny26PEEzwnJFN5hEKTrH3YHdaDAWa2OAAx2VgqxB3LeJ8zG62O1TX
hMe4qECNwhQzp6Qk7PSlwtIBIRXfFUTC15gMDJqzNX6gdz9gri8dfANL18OA+Vqa
muw/44of+MvrqFiSM9CdgiFoTc94g46HLBp01l8fpYicfoxVVP/o8oPtbykiq6G9
6COFD70G2fpfJ1EQMGiiylfDP65hvyF0oWdK4V/SpMav07JrbVILXXX28L56kAca
3OpCTKmG/oH91hnBac8iL98DwpRZunZmqxlnB5Kn/Ed5Z9H9mIt3uLIXFFcP6AVN
ZZauig6plz72mh/BGn0en/f2BG/vLyQ+NeudUed5uvN3t5dedagdjr5bRTMXxWsP
OLPVEbyAfVm5uOpsp6pMkCo6/gUFXB9jBhS3cdnwQpwe7upZ+5ASd48kDFCxpR+C
r8yVSaHmsQSnMvhuRb2B2gKmHkHOAPMxGogEri95vB+77pzqtOuc7SjWtvoS4Gkh
HJ1y9iwNXHkTtCL89fTgK9Nk/lyIQOeIvuEqSh0o/Fy4ViPA2zJQEaYa49JI2pib
cwBVBZeGjO0aG1Uc1aWap8x0LU5n+ia4mI0f6BdlMAhsYMfcDXalahqFP+uVc4l/
m6RUgc4FTJKtTa5DzgvouY02NQa5VI/Nrf4VCZVV7wBeItC0J6g=
=9Ca5
-----END PGP SIGNATURE-----

--Zs/RYxT/hKAHzkfQ--


