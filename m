Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 547E3C43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 17:53:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 242A22053B
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 17:53:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AgnOAs0b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 242A22053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42610 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idHn9-0005kr-03
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 12:53:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46250)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1idGsR-0001Cf-QP
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 11:54:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1idGsP-0000Kc-5f
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 11:54:46 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:47912
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1idGsN-0000GV-8Y
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 11:54:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575651278;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4pImm1ynZ2qZS8i5s33WHcrlDe0qnvDmB3qze+RdLXY=;
 b=AgnOAs0bmTJ4n+b7i7eAet66nCxDePaNNtXFJtSvmnv/LXJM2NPRvPJF+tYiOLWMZ5fSgj
 9nmjo7Tdzy/0MOKRkE0sOEp4bH9Ag6Bwm9zsA/LdI6BJlN4VNFfyYR8UpkOMcCz2AhotQu
 4QmTsJovy/nJQe3uCHZVaehEt1FuhlU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-350-yorVxQj4OMi3xzt1s48m2A-1; Fri, 06 Dec 2019 11:54:35 -0500
X-MC-Unique: yorVxQj4OMi3xzt1s48m2A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3F87B1010FEF;
 Fri,  6 Dec 2019 16:54:34 +0000 (UTC)
Received: from dhcp-17-72.bos.redhat.com (dhcp-17-72.bos.redhat.com
 [10.18.17.72])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5ED7E6BF95;
 Fri,  6 Dec 2019 16:54:21 +0000 (UTC)
Date: Fri, 6 Dec 2019 11:54:19 -0500
From: Cleber Rosa <crosa@redhat.com>
To: Wainer dos Santos Moschetta <wainersm@redhat.com>
Subject: Re: [PATCH 1/2] tests/acceptance: Add PVH boot test
Message-ID: <20191206165419.GC23522@dhcp-17-72.bos.redhat.com>
References: <20191206140012.15517-1-wainersm@redhat.com>
 <20191206140012.15517-2-wainersm@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191206140012.15517-2-wainersm@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="R+My9LyyhiUvIEro"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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

--R+My9LyyhiUvIEro
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 06, 2019 at 09:00:11AM -0500, Wainer dos Santos Moschetta wrote=
:
> QEMU 4.0 onward is able to boot an uncompressed kernel
> image by using the x86/HVM direct boot ABI. It needs
> Linux >=3D 4.21 built with CONFIG_PVH=3Dy.
>=20
> This introduces an acceptance test which checks an
> uncompressed Linux kernel image boots properly.
>=20
> Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
> ---
>  tests/acceptance/pvh.py | 48 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 48 insertions(+)
>  create mode 100644 tests/acceptance/pvh.py
>=20
> diff --git a/tests/acceptance/pvh.py b/tests/acceptance/pvh.py
> new file mode 100644
> index 0000000000..c68489c273
> --- /dev/null
> +++ b/tests/acceptance/pvh.py
> @@ -0,0 +1,48 @@
> +# Copyright (c) 2019 Red Hat, Inc.
> +#
> +# Author:
> +#  Wainer dos Santos Moschetta <wainersm@redhat.com>
> +#
> +# This work is licensed under the terms of the GNU GPL, version 2 or
> +# later.  See the COPYING file in the top-level directory.
> +
> +"""
> +x86/HVM direct boot acceptance tests.
> +"""
> +
> +from avocado.utils.kernel import KernelBuild
> +from avocado_qemu import Test
> +from avocado_qemu import wait_for_console_pattern
> +
> +
> +class Pvh(Test):
> +    """
> +    Test suite for x86/HVM direct boot feature.
> +
> +    :avocado: tags=3Dslow,arch=3Dx86_64,machine=3Dq35
> +    """
> +    def test_boot_vmlinux(self):
> +        """
> +        Boot uncompressed kernel image.
> +        """
> +        # QEMU can boot a vmlinux image for kernel >=3D 4.21 built
> +        # with CONFIG_PVH=3Dy
> +        kernel_version =3D '5.4.1'
> +        kbuild =3D KernelBuild(kernel_version, work_dir=3Dself.workdir)
> +        try:
> +            kbuild.download()
> +            kbuild.uncompress()
> +            kbuild.configure(targets=3D['defconfig', 'kvmconfig'],
> +                             extra_configs=3D['CONFIG_PVH=3Dy'])

I'm aware of the reason why this uses APIs not fulfilled by
tests/requirements.txt, but, for the general public reviewing/testing
code with extra requirements, it's a good idea to bump the
requirements to a version that fulfills the requirement, and comment
out clearly on the temporary nature of the change (marking the patch).

For instance, for this requirement, we could have:

diff --git a/tests/requirements.txt b/tests/requirements.txt
index a2a587223a..5498d67bc1 100644
--- a/tests/requirements.txt
+++ b/tests/requirements.txt
@@ -1,4 +1,5 @@
 # Add Python module requirements, one per line, to be installed
 # in the tests/venv Python virtual environment. For more info,
 # refer to: https://pip.pypa.io/en/stable/user_guide/#id1
-avocado-framework=3D=3D72.0
+# [REMOVE ME] use post 73.0 Avocado containing the new kernel build APIs
+-e git+https://github.com/avocado-framework/avocado@d6fb24edcf847f09c312b5=
5df3c674c64c79793e#egg=3Davocado_framework

This will not only help people to test it, but should also make
it work transparently on CI.

> +            kbuild.build()

As stated in my response to the cover letter, I think we need to move
this elsewhere.  The *very* minimum is to have this in a setUp()
method, but we should strongly consider other solutions.

> +        except:
> +            self.cancel("Unable to build vanilla kernel %s" % kernel_ver=
sion)
> +
> +        self.vm.set_machine('q35')
> +        self.vm.set_console()
> +        kernel_command_line =3D 'printk.time=3D0 console=3DttyS0'
> +        self.vm.add_args('-kernel', kbuild.vmlinux,
> +                         '-append', kernel_command_line)

And just for being thorough (and purist? idealistic? Utopian? :), if
we stop and think about it, the following two lines are really what
this test is all about.  Everything else should be the test's setup.

I'm not arguing in favor of being radical and reject anything that is
not perfect, but just reminding ourselves (myself very much included)
of this general direction.

Cheers,
- Cleber.

> +        self.vm.launch()
> +        wait_for_console_pattern(self, 'Kernel command line: %s' %
> +                                 kernel_command_line)
> --=20
> 2.21.0
>=20

--R+My9LyyhiUvIEro
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl3qh7kACgkQZX6NM6Xy
CfNmWA//RxAM1nsl8ib03VnMUMvw5G0JE7D2gx5raelt/RpYizqOy/L6TmbCVBw1
tKWURSVgXNlwMK/ooxrI9ssoXlgzk4wZT3aVaaXfLojV0pKYXhql9c6osrBb+Omi
WRMxmtUBNXbG3GtKyvFj91Tx22CUZ3XarhHDVEkpAvJlxsnxR22vhVSCOxZ4jTjx
LDF2LxAs+gH18etgyu9nB2+F4zpSjOTb/k84CoAXzgW94qWA9k/T2vRSl5F04s8X
jGAt7hvFqz2nppSRmW2/m4jhD4O6E5j8xmyHm1PG7P+kB+EOGi6B8ypQlpLJbRKS
n81TJAblHRAW5CdMLboSLPy10IUJHNn4g9G0BlrfusHf5Y0vbmKrprM9KW6EYKHC
THRLGzZUCJrqAZWnRKK/QWw5VpyMT5YafkbDe53/9T140l06mABbVrpHSgPsaRQm
piqs0+F9EZyP5lyYQ7qWsHdB21MtLfxsEi0QtvWxCxoKuGqF2iDX2+fxnlV8TxTd
wFWOnJDL6w2HQtKWOCW3RWrRGQgWd1ySm7m+OZJxIEocYnw8XlmZ3LG+weEmAOXu
nwmK3qRoIHr7fPNKU+l6ARGMk+oKdDyVQjq5i6K/UGXJqTRwNflWkZpiEc+Hp6hg
ODDvz/CwUgTEGKQ3ax3hHBKWXGqvfX3slpzpzs2s4ReyTruyG+A=
=gb6d
-----END PGP SIGNATURE-----

--R+My9LyyhiUvIEro--


