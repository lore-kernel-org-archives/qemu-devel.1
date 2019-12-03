Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB7C5C432C3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 11:40:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89CB120674
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 11:40:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KTAruHtL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89CB120674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52076 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ic6XH-0000Xt-M0
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 06:40:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51214)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1ic6SY-0006YM-KE
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 06:35:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1ic6SV-0001Wm-K5
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 06:35:13 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:47037)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1ic6SU-0001QL-Qz
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 06:35:11 -0500
Received: by mail-wr1-x441.google.com with SMTP id z7so3163967wrl.13
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2019 03:35:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=o5IdihkwIqoR4PLBRSQ3xofls6u1LyP+ydwV/1VQvGQ=;
 b=KTAruHtL6LlTgJt8BmQpZsJcJG1UcO0jkZtDlWhSwZyRBhhmugvaGS35MN42ncXIl6
 TNu/065nyopEpdWGTg3kS+gLwfAYtzRYubjY4fiygMdq2bZSOCuUlxB7/WyVLMzVbMfS
 eBw4Qq/5vglDI0gysDusFIcNAo/SW5BSiBLMpWhO2b6ZFNeqdXm3ZG5pvbX8oIOoYCAi
 i8llOUQ1vXPuRE2Zr5JMkVUJNKUVY2k2FZdG9CZsaI6v6dkF6V745RZ6ljQHPs2g2iHj
 ro5K/1ouzzS3WP7YJ8Q2ISyYr4yxbDSZFjPRHWeVp5vUZwEjOxUH0jXjkeGIYrFec6Se
 ndAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=o5IdihkwIqoR4PLBRSQ3xofls6u1LyP+ydwV/1VQvGQ=;
 b=MIeL2S9YGIHbk5EAPXrFa2s87SL7RIE3UPOj273KsoQY9JCi7qxlgZCPdq0iDjgfbi
 RLGvwXVMq7bwkf4ZhsRi4X5STikK1HN8OqQ74yAcg1c73yIc5r/UmU9KzxpX5GkzzZV7
 wp1e4dTzNaIqGSCHGSVZzo9U+efsPtoqGk/Q7ChNt85i9XbgJrNuWFca5RMMPr8Hwvml
 OavycAq+JU36AaKKP0VgQh4wcG/DBS2y6RNV2ppKIJ10P+8+fr8E/3t1tVhiRL2MVfuO
 Rfobs8e3uIjgTPTLygOzVsaJUn4Cb2B0KNy5DjwWHKxoYj370BtR1xXtFTun8gNi1P7E
 2MRA==
X-Gm-Message-State: APjAAAVpmwpvH7jDFiCMpGSRiFED7OtjZO8XnUJ8wHdVtktBfCpkHAW1
 hJPTgxzu2ctlX8RzVea92hhkPw==
X-Google-Smtp-Source: APXvYqzL6J7Yn3TwVgRWAUL0mEYBOoDhGFTcFWocQ9I2G50oiUsjpdH+jBx3oU1hYJxIXf6Kvr7DwQ==
X-Received: by 2002:adf:93c6:: with SMTP id 64mr4425037wrp.212.1575372908831; 
 Tue, 03 Dec 2019 03:35:08 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id k19sm2589820wmi.42.2019.12.03.03.35.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2019 03:35:07 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id DA4B11FF87;
 Tue,  3 Dec 2019 11:35:06 +0000 (GMT)
References: <20191114134246.12073-1-wainersm@redhat.com>
 <20191114134246.12073-2-wainersm@redhat.com>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Wainer dos Santos Moschetta <wainersm@redhat.com>
Subject: Re: [PATCH 1/1] tests/vm: Allow to set qemu-img path
In-reply-to: <20191114134246.12073-2-wainersm@redhat.com>
Date: Tue, 03 Dec 2019 11:35:06 +0000
Message-ID: <87fti1bq1h.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: fam@euphon.net, philmd@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Wainer dos Santos Moschetta <wainersm@redhat.com> writes:

> By default VM build test use qemu-img from system's PATH to
> create the image disk. Due the lack of qemu-img on the system
> or the desire to simply use a version built with QEMU, it would
> be nice to allow one to set its path. So this patch makes that
> possible by reading the path to qemu-img from QEMU_IMG if set,
> otherwise it fallback to default behavior.
>
> Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>

Queued to testing/next, thanks.

> ---
>  docs/devel/testing.rst    | 6 ++++--
>  tests/vm/Makefile.include | 1 +
>  tests/vm/basevm.py        | 5 +++++
>  tests/vm/centos           | 2 +-
>  tests/vm/fedora           | 4 +---
>  tests/vm/freebsd          | 3 +--
>  tests/vm/netbsd           | 3 +--
>  tests/vm/openbsd          | 3 +--
>  tests/vm/ubuntu.i386      | 2 +-
>  9 files changed, 16 insertions(+), 13 deletions(-)
>
> diff --git a/docs/devel/testing.rst b/docs/devel/testing.rst
> index 8e981e062d..9be6cd4410 100644
> --- a/docs/devel/testing.rst
> +++ b/docs/devel/testing.rst
> @@ -418,13 +418,15 @@ access, so they SHOULD NOT be exposed to external i=
nterfaces if you are
>  concerned about attackers taking control of the guest and potentially
>  exploiting a QEMU security bug to compromise the host.
>=20=20
> -QEMU binary
> ------------
> +QEMU binaries
> +-------------
>=20=20
>  By default, qemu-system-x86_64 is searched in $PATH to run the guest. If=
 there
>  isn't one, or if it is older than 2.10, the test won't work. In this cas=
e,
>  provide the QEMU binary in env var: ``QEMU=3D/path/to/qemu-2.10+``.
>=20=20
> +Likewise the path to qemu-img can be set in QEMU_IMG environment variabl=
e.
> +
>  Make jobs
>  ---------
>=20=20
> diff --git a/tests/vm/Makefile.include b/tests/vm/Makefile.include
> index fea348e845..9e7c46a473 100644
> --- a/tests/vm/Makefile.include
> +++ b/tests/vm/Makefile.include
> @@ -34,6 +34,7 @@ vm-help vm-test:
>  	@echo "    DEBUG=3D1              	 - Enable verbose output on host and=
 interactive debugging"
>  	@echo "    V=3D1				 - Enable verbose ouput on host and guest commands"
>  	@echo "    QEMU=3D/path/to/qemu		 - Change path to QEMU binary"
> +	@echo "    QEMU_IMG=3D/path/to/qemu-img	 - Change path to qemu-img tool"
>=20=20
>  vm-build-all: $(addprefix vm-build-, $(IMAGES))
>=20=20
> diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
> index 91a9226026..d1efeb3646 100755
> --- a/tests/vm/basevm.py
> +++ b/tests/vm/basevm.py
> @@ -152,6 +152,11 @@ class BaseVM(object):
>      def build_image(self, img):
>          raise NotImplementedError
>=20=20
> +    def exec_qemu_img(self, *args):
> +        cmd =3D [os.environ.get("QEMU_IMG", "qemu-img")]
> +        cmd.extend(list(args))
> +        subprocess.check_call(cmd)
> +
>      def add_source_dir(self, src_dir):
>          name =3D "data-" + hashlib.sha1(src_dir.encode("utf-8")).hexdige=
st()[:5]
>          tarfile =3D os.path.join(self._tmpdir, name + ".tar")
> diff --git a/tests/vm/centos b/tests/vm/centos
> index 53976f1c4c..eac07dacd6 100755
> --- a/tests/vm/centos
> +++ b/tests/vm/centos
> @@ -68,7 +68,7 @@ class CentosVM(basevm.BaseVM):
>          sys.stderr.write("Extracting the image...\n")
>          subprocess.check_call(["ln", "-f", cimg, img_tmp + ".xz"])
>          subprocess.check_call(["xz", "--keep", "-dvf", img_tmp + ".xz"])
> -        subprocess.check_call(["qemu-img", "resize", img_tmp, "50G"])
> +        self.exec_qemu_img("resize", img_tmp, "50G")
>          self.boot(img_tmp, extra_args =3D ["-cdrom", self._gen_cloud_ini=
t_iso()])
>          self.wait_ssh()
>          self.ssh_root_check("touch /etc/cloud/cloud-init.disabled")
> diff --git a/tests/vm/fedora b/tests/vm/fedora
> index 7fec1479fb..8e270fc0f0 100755
> --- a/tests/vm/fedora
> +++ b/tests/vm/fedora
> @@ -74,9 +74,7 @@ class FedoraVM(basevm.BaseVM):
>=20=20
>          self.print_step("Preparing iso and disk image")
>          subprocess.check_call(["cp", "-f", cimg, iso])
> -        subprocess.check_call(["qemu-img", "create", "-f", "qcow2",
> -                               img_tmp, self.size])
> -
> +        self.exec_qemu_img("create", "-f", "qcow2", img_tmp, self.size)
>          self.print_step("Booting installer")
>          self.boot(img_tmp, extra_args =3D [
>              "-bios", "pc-bios/bios-256k.bin",
> diff --git a/tests/vm/freebsd b/tests/vm/freebsd
> index 2a19461a90..1825cc5821 100755
> --- a/tests/vm/freebsd
> +++ b/tests/vm/freebsd
> @@ -82,8 +82,7 @@ class FreeBSDVM(basevm.BaseVM):
>          self.print_step("Preparing iso and disk image")
>          subprocess.check_call(["cp", "-f", cimg, iso_xz])
>          subprocess.check_call(["xz", "-dvf", iso_xz])
> -        subprocess.check_call(["qemu-img", "create", "-f", "qcow2",
> -                               img_tmp, self.size])
> +        self.exec_qemu_img("create", "-f", "qcow2", img_tmp, self.size)
>=20=20
>          self.print_step("Booting installer")
>          self.boot(img_tmp, extra_args =3D [
> diff --git a/tests/vm/netbsd b/tests/vm/netbsd
> index 611e6cc5b5..ec6f3563b2 100755
> --- a/tests/vm/netbsd
> +++ b/tests/vm/netbsd
> @@ -77,8 +77,7 @@ class NetBSDVM(basevm.BaseVM):
>=20=20
>          self.print_step("Preparing iso and disk image")
>          subprocess.check_call(["ln", "-f", cimg, iso])
> -        subprocess.check_call(["qemu-img", "create", "-f", "qcow2",
> -                               img_tmp, self.size])
> +        self.exec_qemu_img("create", "-f", "qcow2", img_tmp, self.size)
>=20=20
>          self.print_step("Booting installer")
>          self.boot(img_tmp, extra_args =3D [
> diff --git a/tests/vm/openbsd b/tests/vm/openbsd
> index b92c39f89a..6df5162dbf 100755
> --- a/tests/vm/openbsd
> +++ b/tests/vm/openbsd
> @@ -73,8 +73,7 @@ class OpenBSDVM(basevm.BaseVM):
>=20=20
>          self.print_step("Preparing iso and disk image")
>          subprocess.check_call(["cp", "-f", cimg, iso])
> -        subprocess.check_call(["qemu-img", "create", "-f", "qcow2",
> -                               img_tmp, self.size])
> +        self.exec_qemu_img("create", "-f", "qcow2", img_tmp, self.size)
>=20=20
>          self.print_step("Booting installer")
>          self.boot(img_tmp, extra_args =3D [
> diff --git a/tests/vm/ubuntu.i386 b/tests/vm/ubuntu.i386
> index 38f740eabf..39bbe9cc21 100755
> --- a/tests/vm/ubuntu.i386
> +++ b/tests/vm/ubuntu.i386
> @@ -70,7 +70,7 @@ class UbuntuX86VM(basevm.BaseVM):
>              sha256sum=3D"e30091144c73483822b7c27193e9d47346dd1064229da57=
7c3fedcf943f7cfcc")
>          img_tmp =3D img + ".tmp"
>          subprocess.check_call(["cp", "-f", cimg, img_tmp])
> -        subprocess.check_call(["qemu-img", "resize", img_tmp, "50G"])
> +        self.exec_qemu_img("resize", img_tmp, "50G")
>          self.boot(img_tmp, extra_args =3D ["-cdrom", self._gen_cloud_ini=
t_iso()])
>          self.wait_ssh()
>          self.ssh_root_check("touch /etc/cloud/cloud-init.disabled")


--=20
Alex Benn=C3=A9e

