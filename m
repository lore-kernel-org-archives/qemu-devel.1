Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14091C432C3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 16:34:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D35E520675
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 16:34:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="clPCdiGR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D35E520675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icB7e-0008Ll-Ov
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 11:33:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51694)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1icAsI-0005I1-OU
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 11:18:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1icAsF-0001bE-PI
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 11:18:05 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:46345
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1icAsD-0001VM-Ec
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 11:18:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575389876;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l9hNy9KFizL9y7lRPqofevpKT99+9lIRrhIrzIb2//M=;
 b=clPCdiGRzUu71AFNJc61y7mWzSXAfCHtfY7T8eZMe7mMwdw3i40FabnneybrsciMsggugj
 DMBK1npWBhdQ7LrKIfgYT/vmifgxRJk5+cPnhpEnJSm95VGDANxEKmmaYHkGRk9N3hDqos
 oxLc704OdLSclh/DrPInOpl2tN7xocc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-248-QNUHrFboNkK7e6E5V4Hh4A-1; Tue, 03 Dec 2019 11:17:55 -0500
Received: by mail-wr1-f72.google.com with SMTP id 90so2033015wrq.6
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2019 08:17:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/QAkCFKTCcx1vYwtIJYeZwCPGj5dFiDi5GFxeDVTh+M=;
 b=OTyVbJ4Xv3ithNoNUUjDvjO8pexE4rjJB3GLqARya0Dt5ywdpoRle+qiSQwWvzbzla
 MYv+4Ew/NR50Dm9wmMOruTRKx6bxBo5mAxPhLEJBo2ATMsZl3hQj2UTsL4zQ6j3aWb1b
 37xzS6Uoa6g72SlPNVGzLcEFJZqilpkXh1Mv+kynzKCJleo6744laGHKcs6rOpSxsD3C
 6NlH3bQ7guO8K5OZ2T/S2rwHAzFNa10Zi+P7tojKFv+Fbe/DzgrR5KpnoCUVzj8NAmYX
 jP98fpS1UCX4eua8EfLYqkAjs5rk/4el2WmqkTQPwDSVX3KCkPSDb3G5PXfJSpPJEATR
 Zc4A==
X-Gm-Message-State: APjAAAU+FP3Fl4fxgCjugwd1mETR51563JZljpF+tZDpJFlpZMoi+S6p
 W/qBFwe+BIset6AKWMCzRCwT8BLUXzvek8GJOM35be0TOgH3EMHxFFAUj4j7ONDHpN1YnHLy093
 3dn1pdHkd1ZzKvUs=
X-Received: by 2002:a05:600c:2254:: with SMTP id
 a20mr35046539wmm.97.1575389873701; 
 Tue, 03 Dec 2019 08:17:53 -0800 (PST)
X-Google-Smtp-Source: APXvYqwDVyEk1W0WGONRCA2WoYnvN0mrVodw6ToPIgc13bAKCr/r8cc+fYv6P1qEAECrAK1v3N8ZuA==
X-Received: by 2002:a05:600c:2254:: with SMTP id
 a20mr35046498wmm.97.1575389873320; 
 Tue, 03 Dec 2019 08:17:53 -0800 (PST)
Received: from [192.168.1.35] (182.red-88-21-103.staticip.rima-tde.net.
 [88.21.103.182])
 by smtp.gmail.com with ESMTPSA id f24sm3464700wmb.37.2019.12.03.08.17.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Dec 2019 08:17:52 -0800 (PST)
Subject: Re: [PATCH 1/1] tests/vm: Allow to set qemu-img path
To: Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-devel@nongnu.org
References: <20191114134246.12073-1-wainersm@redhat.com>
 <20191114134246.12073-2-wainersm@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <3bac18c1-b0db-d178-656f-6eb30e471fb0@redhat.com>
Date: Tue, 3 Dec 2019 17:17:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191114134246.12073-2-wainersm@redhat.com>
Content-Language: en-US
X-MC-Unique: QNUHrFboNkK7e6E5V4Hh4A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
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
Cc: fam@euphon.net, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/14/19 2:42 PM, Wainer dos Santos Moschetta wrote:
> By default VM build test use qemu-img from system's PATH to
> create the image disk. Due the lack of qemu-img on the system
> or the desire to simply use a version built with QEMU, it would
> be nice to allow one to set its path. So this patch makes that
> possible by reading the path to qemu-img from QEMU_IMG if set,
> otherwise it fallback to default behavior.
>=20
> Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>

Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

> ---
>   docs/devel/testing.rst    | 6 ++++--
>   tests/vm/Makefile.include | 1 +
>   tests/vm/basevm.py        | 5 +++++
>   tests/vm/centos           | 2 +-
>   tests/vm/fedora           | 4 +---
>   tests/vm/freebsd          | 3 +--
>   tests/vm/netbsd           | 3 +--
>   tests/vm/openbsd          | 3 +--
>   tests/vm/ubuntu.i386      | 2 +-
>   9 files changed, 16 insertions(+), 13 deletions(-)
>=20
> diff --git a/docs/devel/testing.rst b/docs/devel/testing.rst
> index 8e981e062d..9be6cd4410 100644
> --- a/docs/devel/testing.rst
> +++ b/docs/devel/testing.rst
> @@ -418,13 +418,15 @@ access, so they SHOULD NOT be exposed to external i=
nterfaces if you are
>   concerned about attackers taking control of the guest and potentially
>   exploiting a QEMU security bug to compromise the host.
>  =20
> -QEMU binary
> ------------
> +QEMU binaries
> +-------------
>  =20
>   By default, qemu-system-x86_64 is searched in $PATH to run the guest. I=
f there
>   isn't one, or if it is older than 2.10, the test won't work. In this ca=
se,
>   provide the QEMU binary in env var: ``QEMU=3D/path/to/qemu-2.10+``.
>  =20
> +Likewise the path to qemu-img can be set in QEMU_IMG environment variabl=
e.
> +
>   Make jobs
>   ---------
>  =20
> diff --git a/tests/vm/Makefile.include b/tests/vm/Makefile.include
> index fea348e845..9e7c46a473 100644
> --- a/tests/vm/Makefile.include
> +++ b/tests/vm/Makefile.include
> @@ -34,6 +34,7 @@ vm-help vm-test:
>   =09@echo "    DEBUG=3D1              =09 - Enable verbose output on hos=
t and interactive debugging"
>   =09@echo "    V=3D1=09=09=09=09 - Enable verbose ouput on host and gues=
t commands"
>   =09@echo "    QEMU=3D/path/to/qemu=09=09 - Change path to QEMU binary"
> +=09@echo "    QEMU_IMG=3D/path/to/qemu-img=09 - Change path to qemu-img =
tool"
>  =20
>   vm-build-all: $(addprefix vm-build-, $(IMAGES))
>  =20
> diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
> index 91a9226026..d1efeb3646 100755
> --- a/tests/vm/basevm.py
> +++ b/tests/vm/basevm.py
> @@ -152,6 +152,11 @@ class BaseVM(object):
>       def build_image(self, img):
>           raise NotImplementedError
>  =20
> +    def exec_qemu_img(self, *args):
> +        cmd =3D [os.environ.get("QEMU_IMG", "qemu-img")]
> +        cmd.extend(list(args))
> +        subprocess.check_call(cmd)
> +
>       def add_source_dir(self, src_dir):
>           name =3D "data-" + hashlib.sha1(src_dir.encode("utf-8")).hexdig=
est()[:5]
>           tarfile =3D os.path.join(self._tmpdir, name + ".tar")
> diff --git a/tests/vm/centos b/tests/vm/centos
> index 53976f1c4c..eac07dacd6 100755
> --- a/tests/vm/centos
> +++ b/tests/vm/centos
> @@ -68,7 +68,7 @@ class CentosVM(basevm.BaseVM):
>           sys.stderr.write("Extracting the image...\n")
>           subprocess.check_call(["ln", "-f", cimg, img_tmp + ".xz"])
>           subprocess.check_call(["xz", "--keep", "-dvf", img_tmp + ".xz"]=
)
> -        subprocess.check_call(["qemu-img", "resize", img_tmp, "50G"])
> +        self.exec_qemu_img("resize", img_tmp, "50G")
>           self.boot(img_tmp, extra_args =3D ["-cdrom", self._gen_cloud_in=
it_iso()])
>           self.wait_ssh()
>           self.ssh_root_check("touch /etc/cloud/cloud-init.disabled")
> diff --git a/tests/vm/fedora b/tests/vm/fedora
> index 7fec1479fb..8e270fc0f0 100755
> --- a/tests/vm/fedora
> +++ b/tests/vm/fedora
> @@ -74,9 +74,7 @@ class FedoraVM(basevm.BaseVM):
>  =20
>           self.print_step("Preparing iso and disk image")
>           subprocess.check_call(["cp", "-f", cimg, iso])
> -        subprocess.check_call(["qemu-img", "create", "-f", "qcow2",
> -                               img_tmp, self.size])
> -
> +        self.exec_qemu_img("create", "-f", "qcow2", img_tmp, self.size)
>           self.print_step("Booting installer")
>           self.boot(img_tmp, extra_args =3D [
>               "-bios", "pc-bios/bios-256k.bin",
> diff --git a/tests/vm/freebsd b/tests/vm/freebsd
> index 2a19461a90..1825cc5821 100755
> --- a/tests/vm/freebsd
> +++ b/tests/vm/freebsd
> @@ -82,8 +82,7 @@ class FreeBSDVM(basevm.BaseVM):
>           self.print_step("Preparing iso and disk image")
>           subprocess.check_call(["cp", "-f", cimg, iso_xz])
>           subprocess.check_call(["xz", "-dvf", iso_xz])
> -        subprocess.check_call(["qemu-img", "create", "-f", "qcow2",
> -                               img_tmp, self.size])
> +        self.exec_qemu_img("create", "-f", "qcow2", img_tmp, self.size)
>  =20
>           self.print_step("Booting installer")
>           self.boot(img_tmp, extra_args =3D [
> diff --git a/tests/vm/netbsd b/tests/vm/netbsd
> index 611e6cc5b5..ec6f3563b2 100755
> --- a/tests/vm/netbsd
> +++ b/tests/vm/netbsd
> @@ -77,8 +77,7 @@ class NetBSDVM(basevm.BaseVM):
>  =20
>           self.print_step("Preparing iso and disk image")
>           subprocess.check_call(["ln", "-f", cimg, iso])
> -        subprocess.check_call(["qemu-img", "create", "-f", "qcow2",
> -                               img_tmp, self.size])
> +        self.exec_qemu_img("create", "-f", "qcow2", img_tmp, self.size)
>  =20
>           self.print_step("Booting installer")
>           self.boot(img_tmp, extra_args =3D [
> diff --git a/tests/vm/openbsd b/tests/vm/openbsd
> index b92c39f89a..6df5162dbf 100755
> --- a/tests/vm/openbsd
> +++ b/tests/vm/openbsd
> @@ -73,8 +73,7 @@ class OpenBSDVM(basevm.BaseVM):
>  =20
>           self.print_step("Preparing iso and disk image")
>           subprocess.check_call(["cp", "-f", cimg, iso])
> -        subprocess.check_call(["qemu-img", "create", "-f", "qcow2",
> -                               img_tmp, self.size])
> +        self.exec_qemu_img("create", "-f", "qcow2", img_tmp, self.size)
>  =20
>           self.print_step("Booting installer")
>           self.boot(img_tmp, extra_args =3D [
> diff --git a/tests/vm/ubuntu.i386 b/tests/vm/ubuntu.i386
> index 38f740eabf..39bbe9cc21 100755
> --- a/tests/vm/ubuntu.i386
> +++ b/tests/vm/ubuntu.i386
> @@ -70,7 +70,7 @@ class UbuntuX86VM(basevm.BaseVM):
>               sha256sum=3D"e30091144c73483822b7c27193e9d47346dd1064229da5=
77c3fedcf943f7cfcc")
>           img_tmp =3D img + ".tmp"
>           subprocess.check_call(["cp", "-f", cimg, img_tmp])
> -        subprocess.check_call(["qemu-img", "resize", img_tmp, "50G"])
> +        self.exec_qemu_img("resize", img_tmp, "50G")
>           self.boot(img_tmp, extra_args =3D ["-cdrom", self._gen_cloud_in=
it_iso()])
>           self.wait_ssh()
>           self.ssh_root_check("touch /etc/cloud/cloud-init.disabled")
>=20


