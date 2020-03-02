Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73708C3F2CD
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 18:34:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3102024676
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 18:34:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bm6Xsw5n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3102024676
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37176 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8ptE-00056i-Cx
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 13:34:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45953)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j8psR-0004D4-RN
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 13:33:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j8psP-0002RU-63
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 13:33:15 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23351
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j8psP-0002RN-0Z
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 13:33:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583173992;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Lafr6y8QUSdtu+G0uBoY3ejy0ag9aTI0k1KLcRnz3wA=;
 b=Bm6Xsw5naD4nQEy0PmJ4RNvJ65jcZals0K6PXf6VISBBNtJCHt2wl4t+BWRKloXnNsg/Fv
 Y+RoUp4/GC3CAX9q4nTN26pNnbRGXqPgQD8HPmVHP7oKhUvJxbSEHtZGXftwDoh080MWZN
 ZsUq5eR4G2wEC5wn/M4R8djfDvXWgto=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-363-KtNyx0vCM0u39nJVkQ8rGw-1; Mon, 02 Mar 2020 13:32:58 -0500
X-MC-Unique: KtNyx0vCM0u39nJVkQ8rGw-1
Received: by mail-wr1-f70.google.com with SMTP id o9so73968wrw.14
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2020 10:32:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=oB4NV5Mzh1wRWscE/Vj0wvoZKXpVeK02N7L6Vy/ztjQ=;
 b=EjH4TuyPsmiB5KRRizO/0JM9JREq/NOKLs+rsa1PB2cNNiQVSF/NWO7kYixbvK9ZZa
 2pz5jHzLfIEa9Y2CyiYnfCIWhHlHoIZUOBRLgPB+ZfX2dyyWx4N52AH9mBK8sF0ColOe
 Z2I1Xf/kDgoH1s7eVyu2wuq4/5dxv3BryCwb+TzAZMddMOGlLnAtCj4exp4OGsjKHK3+
 UNfHf2diLORhGcov57izsfMWM4wIu35It4N4jnWF/nOHqGS1ScKQUP3Vu3YQAkCRNKOp
 6FU+zv62fMuYFmU/tnUBnSacbeTSe9tXB+SS2yt/ZECy4vp6/t+Jzt7CD9P8EfO9Uab/
 ahDA==
X-Gm-Message-State: ANhLgQ2Ce/gOoZqAnyKng96fapSk11lhIUMQNWmRbe5j06H/Uf3mtTpS
 l6I09dYd6GSHdNMxuOCAPNFFQDQB0LNAYRqHvZwjV6W3wCMXyk6aFkVqbDiP2HqtVHsYVx/m+AX
 QCITMkfvWOmirnh0=
X-Received: by 2002:adf:de0d:: with SMTP id b13mr821351wrm.297.1583173976341; 
 Mon, 02 Mar 2020 10:32:56 -0800 (PST)
X-Google-Smtp-Source: ADFU+vsXH5StPe1sqXil1ctO5XKNseRV1qN9jfIIv5pWjEZ6r/QCphlqLGhfH0YeLQZRvxSg7Ql9lw==
X-Received: by 2002:adf:de0d:: with SMTP id b13mr821331wrm.297.1583173976085; 
 Mon, 02 Mar 2020 10:32:56 -0800 (PST)
Received: from ?IPv6:2a01:e35:2fb0:49e0:3f7b:4b69:b9c:cdc0?
 ([2a01:e35:2fb0:49e0:3f7b:4b69:b9c:cdc0])
 by smtp.gmail.com with ESMTPSA id g10sm30766825wrr.13.2020.03.02.10.32.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Mar 2020 10:32:55 -0800 (PST)
Subject: Re: [PATCH v1 05/10] tests/vm: Added gen_cloud_init_iso() to basevm.py
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200302181907.32110-1-alex.bennee@linaro.org>
 <20200302181907.32110-6-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <bf7ccc07-262b-51d5-afa0-4cc0b8d1d80d@redhat.com>
Date: Mon, 2 Mar 2020 19:32:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200302181907.32110-6-alex.bennee@linaro.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
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
Cc: Fam Zheng <fam@euphon.net>, Peter Puhov <peter.puhov@linaro.org>,
 Robert Foley <robert.foley@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/2/20 7:19 PM, Alex Benn=C3=A9e wrote:
> From: Robert Foley <robert.foley@linaro.org>
>=20
> This method was located in both centos and ubuntu.i386.
>=20
> Signed-off-by: Robert Foley <robert.foley@linaro.org>
> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Reviewed-by: Peter Puhov <peter.puhov@linaro.org>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Message-Id: <20200219163537.22098-6-robert.foley@linaro.org>
> ---
>   tests/vm/basevm.py   | 40 ++++++++++++++++++++++++++++++++++++++++
>   tests/vm/centos      | 33 +--------------------------------
>   tests/vm/ubuntu.i386 | 37 +------------------------------------
>   3 files changed, 42 insertions(+), 68 deletions(-)
>=20
> diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
> index 7f268922685..8400b0e07f6 100644
> --- a/tests/vm/basevm.py
> +++ b/tests/vm/basevm.py
> @@ -345,6 +345,46 @@ class BaseVM(object):
>       def qmp(self, *args, **kwargs):
>           return self._guest.qmp(*args, **kwargs)
>  =20
> +    def gen_cloud_init_iso(self):
> +        cidir =3D self._tmpdir
> +        mdata =3D open(os.path.join(cidir, "meta-data"), "w")
> +        name =3D self.name.replace(".","-")
> +        mdata.writelines(["instance-id: {}-vm-0\n".format(name),
> +                          "local-hostname: {}-guest\n".format(name)])
> +        mdata.close()
> +        udata =3D open(os.path.join(cidir, "user-data"), "w")
> +        print("guest user:pw {}:{}".format(self._config['guest_user'],
> +                                           self._config['guest_pass']))
> +        udata.writelines(["#cloud-config\n",
> +                          "chpasswd:\n",
> +                          "  list: |\n",
> +                          "    root:%s\n" % self._config['root_pass'],
> +                          "    %s:%s\n" % (self._config['guest_user'],
> +                                           self._config['guest_pass']),
> +                          "  expire: False\n",
> +                          "users:\n",
> +                          "  - name: %s\n" % self._config['guest_user'],
> +                          "    sudo: ALL=3D(ALL) NOPASSWD:ALL\n",
> +                          "    ssh-authorized-keys:\n",
> +                          "    - %s\n" % self._config['ssh_pub_key'],
> +                          "  - name: root\n",
> +                          "    ssh-authorized-keys:\n",
> +                          "    - %s\n" % self._config['ssh_pub_key'],
> +                          "locale: en_US.UTF-8\n"])
> +        proxy =3D os.environ.get("http_proxy")
> +        if not proxy is None:
> +            udata.writelines(["apt:\n",
> +                              "  proxy: %s" % proxy])
> +        udata.close()
> +        subprocess.check_call(["genisoimage", "-output", "cloud-init.iso=
",
> +                               "-volid", "cidata", "-joliet", "-rock",
> +                               "user-data", "meta-data"],
> +                               cwd=3Dcidir,
> +                               stdin=3Dself._devnull, stdout=3Dself._std=
out,
> +                               stderr=3Dself._stdout)
> +
> +        return os.path.join(cidir, "cloud-init.iso")
> +
>   def parse_args(vmcls):
>  =20
>       def get_default_jobs():
> diff --git a/tests/vm/centos b/tests/vm/centos
> index a41ff109eb5..0ad4ecf4190 100755
> --- a/tests/vm/centos
> +++ b/tests/vm/centos
> @@ -31,37 +31,6 @@ class CentosVM(basevm.BaseVM):
>           make docker-test-mingw@fedora  {verbose} J=3D{jobs} NETWORK=3D1=
;
>       """
>  =20
> -    def _gen_cloud_init_iso(self):
> -        cidir =3D self._tmpdir
> -        mdata =3D open(os.path.join(cidir, "meta-data"), "w")
> -        mdata.writelines(["instance-id: centos-vm-0\n",
> -                          "local-hostname: centos-guest\n"])
> -        mdata.close()
> -        udata =3D open(os.path.join(cidir, "user-data"), "w")
> -        udata.writelines(["#cloud-config\n",
> -                          "chpasswd:\n",
> -                          "  list: |\n",
> -                          "    root:%s\n" % self.ROOT_PASS,
> -                          "    %s:%s\n" % (self.GUEST_USER, self.GUEST_P=
ASS),
> -                          "  expire: False\n",
> -                          "users:\n",
> -                          "  - name: %s\n" % self.GUEST_USER,
> -                          "    sudo: ALL=3D(ALL) NOPASSWD:ALL\n",
> -                          "    ssh-authorized-keys:\n",
> -                          "    - %s\n" % basevm.SSH_PUB_KEY,
> -                          "  - name: root\n",
> -                          "    ssh-authorized-keys:\n",
> -                          "    - %s\n" % basevm.SSH_PUB_KEY,
> -                          "locale: en_US.UTF-8\n"])
> -        udata.close()
> -        subprocess.check_call(["genisoimage", "-output", "cloud-init.iso=
",
> -                               "-volid", "cidata", "-joliet", "-rock",
> -                               "user-data", "meta-data"],
> -                               cwd=3Dcidir,
> -                               stdin=3Dself._devnull, stdout=3Dself._std=
out,
> -                               stderr=3Dself._stdout)
> -        return os.path.join(cidir, "cloud-init.iso")
> -
>       def build_image(self, img):
>           cimg =3D self._download_with_cache("https://cloud.centos.org/ce=
ntos/7/images/CentOS-7-x86_64-GenericCloud-1802.qcow2.xz")
>           img_tmp =3D img + ".tmp"
> @@ -69,7 +38,7 @@ class CentosVM(basevm.BaseVM):
>           subprocess.check_call(["ln", "-f", cimg, img_tmp + ".xz"])
>           subprocess.check_call(["xz", "--keep", "-dvf", img_tmp + ".xz"]=
)
>           self.exec_qemu_img("resize", img_tmp, "50G")
> -        self.boot(img_tmp, extra_args =3D ["-cdrom", self._gen_cloud_ini=
t_iso()])
> +        self.boot(img_tmp, extra_args =3D ["-cdrom", self.gen_cloud_init=
_iso()])
>           self.wait_ssh()
>           self.ssh_root_check("touch /etc/cloud/cloud-init.disabled")
>           self.ssh_root_check("yum update -y")
> diff --git a/tests/vm/ubuntu.i386 b/tests/vm/ubuntu.i386
> index 48e9cb1ad3d..3266038fbde 100755
> --- a/tests/vm/ubuntu.i386
> +++ b/tests/vm/ubuntu.i386
> @@ -29,41 +29,6 @@ class UbuntuX86VM(basevm.BaseVM):
>           make --output-sync {target} -j{jobs} {verbose};
>       """
>  =20
> -    def _gen_cloud_init_iso(self):
> -        cidir =3D self._tmpdir
> -        mdata =3D open(os.path.join(cidir, "meta-data"), "w")
> -        mdata.writelines(["instance-id: ubuntu-vm-0\n",
> -                          "local-hostname: ubuntu-guest\n"])
> -        mdata.close()
> -        udata =3D open(os.path.join(cidir, "user-data"), "w")
> -        udata.writelines(["#cloud-config\n",
> -                          "chpasswd:\n",
> -                          "  list: |\n",
> -                          "    root:%s\n" % self.ROOT_PASS,
> -                          "    %s:%s\n" % (self.GUEST_USER, self.GUEST_P=
ASS),
> -                          "  expire: False\n",
> -                          "users:\n",
> -                          "  - name: %s\n" % self.GUEST_USER,
> -                          "    sudo: ALL=3D(ALL) NOPASSWD:ALL\n",
> -                          "    ssh-authorized-keys:\n",
> -                          "    - %s\n" % basevm.SSH_PUB_KEY,
> -                          "  - name: root\n",
> -                          "    ssh-authorized-keys:\n",
> -                          "    - %s\n" % basevm.SSH_PUB_KEY,
> -                          "locale: en_US.UTF-8\n"])
> -        proxy =3D os.environ.get("http_proxy")
> -        if not proxy is None:
> -            udata.writelines(["apt:\n",
> -                              "  proxy: %s" % proxy])
> -        udata.close()
> -        subprocess.check_call(["genisoimage", "-output", "cloud-init.iso=
",
> -                               "-volid", "cidata", "-joliet", "-rock",
> -                               "user-data", "meta-data"],
> -                               cwd=3Dcidir,
> -                               stdin=3Dself._devnull, stdout=3Dself._std=
out,
> -                               stderr=3Dself._stdout)
> -        return os.path.join(cidir, "cloud-init.iso")
> -
>       def build_image(self, img):
>           cimg =3D self._download_with_cache(
>               "https://cloud-images.ubuntu.com/releases/bionic/release-20=
191114/ubuntu-18.04-server-cloudimg-i386.img",
> @@ -71,7 +36,7 @@ class UbuntuX86VM(basevm.BaseVM):
>           img_tmp =3D img + ".tmp"
>           subprocess.check_call(["cp", "-f", cimg, img_tmp])
>           self.exec_qemu_img("resize", img_tmp, "50G")
> -        self.boot(img_tmp, extra_args =3D ["-cdrom", self._gen_cloud_ini=
t_iso()])
> +        self.boot(img_tmp, extra_args =3D ["-cdrom", self.gen_cloud_init=
_iso()])
>           self.wait_ssh()
>           self.ssh_root_check("touch /etc/cloud/cloud-init.disabled")
>           self.ssh_root_check("apt-get update")
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


