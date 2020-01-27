Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 542B3C2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 15:02:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09C6B214AF
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 15:02:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u5fkohGI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09C6B214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46568 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iw5uS-0000eb-7L
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 10:02:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42165)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iw5tO-0008Ul-9o
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 10:01:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iw5tL-0001aU-Mu
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 10:01:34 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:33029)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iw5tL-0001ZQ-Cz
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 10:01:31 -0500
Received: by mail-wr1-x436.google.com with SMTP id b6so11729985wrq.0
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2020 07:01:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=xqLG31zl12L2CFvSpBHsgw8f5+UitdoxDWCninRmQHM=;
 b=u5fkohGI3awDOoXYX10HU7rO73YrGRGB5Wn5DWyOHrctAJjexAZrHb2P+mKEj/oxbf
 FUMwwRXqgfv/g3VjiWiy7LtnTmHpkLVEVAbl91U0JL0k6MjTF2ASgAQiote9Cz5D26UY
 Kh3/MtsZ6SYP3nG8gLRU9XKpEOMtlmDgzXC8RhDof2TnJhvvuVmVK5IrJvimTyz1jOwp
 8o+ReNmrZBGbO34vM2OlZ+O2TilEEOmjXlO9kML7i3HzawTLKb6NCPVGNiktTPrSzWWP
 sNtDD77L1njrsnw7OlJD4y5ikQJgQ7HMfLk94m0gbul69gvQOqZ9wNAWhYBC7ziHDutD
 5Qgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=xqLG31zl12L2CFvSpBHsgw8f5+UitdoxDWCninRmQHM=;
 b=kgDWd0Mw5vWmPxKyyzQVXdD9FYjCiNqjmFt4cR1/Ou29hdniDWs85wOV0DRMNYydzL
 J6lSuINZ2LV/xVOJV3s1pYGUYgovgJ1sNUwZcuumCoT785lLMqzN9x+tmwBHT+My/gVz
 4f5k7cc6rYg+P8zeQ18dWwPORAFmYJL/DR1GgxtoBTQK7p/lVM9FmYWAlZxcChy/ZEq9
 2KqK6cMOxo+jIZGxCcdJIG8cSskUxSR9guzKK2Th/wagXFEaeFRTm9tKMUu9yzdHuOR0
 L8laPnoFxIwY/v13PpHjXkk/j6cXl8M9x0CJOaZK+h7/AgaVA5V6g1c0bQaglBJE90Pt
 6TUQ==
X-Gm-Message-State: APjAAAUtnVFtvpaANiWD5stD59Olp1h8qpTQ3QA7TUEsorKq7LoXZOFo
 e5hLJYE+qhIyNoVwnXrQxOVydw==
X-Google-Smtp-Source: APXvYqzGnQL/kmMjX3ny1aC14tXJ85vrC3wK+MAUxZjWiRY3lKhDIavFbXzAk0MbsOo/ibUmcBEUdw==
X-Received: by 2002:adf:f885:: with SMTP id u5mr22466569wrp.359.1580137289881; 
 Mon, 27 Jan 2020 07:01:29 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id x10sm20958559wrp.58.2020.01.27.07.01.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jan 2020 07:01:28 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 41C1C1FF87;
 Mon, 27 Jan 2020 15:01:27 +0000 (GMT)
References: <20200124165335.422-1-robert.foley@linaro.org>
 <20200124165335.422-8-robert.foley@linaro.org>
User-agent: mu4e 1.3.7; emacs 27.0.60
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Robert Foley <robert.foley@linaro.org>
Subject: Re: [PATCH 7/8] tests/vm: Added a new script for ubuntu.aarch64.
In-reply-to: <20200124165335.422-8-robert.foley@linaro.org>
Date: Mon, 27 Jan 2020 15:01:27 +0000
Message-ID: <87imkxeyew.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::436
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
Cc: fam@euphon.net, peter.puhov@linaro.org, philmd@redhat.com,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Robert Foley <robert.foley@linaro.org> writes:

> ubuntu.aarch64 provides a script to create an Ubuntu 18.04 VM.
> Another new file is also added aarch64vm.py, which is a module with
> common methods used by aarch64 VMs, such as how to create the
> flash images.
>
> Signed-off-by: Robert Foley <robert.foley@linaro.org>
> Reviewed-by: Peter Puhov <peter.puhov@linaro.org>
> ---
>  tests/vm/Makefile.include |   7 +-
>  tests/vm/aarch64vm.py     |  41 +++++++++++
>  tests/vm/ubuntu.aarch64   | 144 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 190 insertions(+), 2 deletions(-)
>  create mode 100644 tests/vm/aarch64vm.py
>  create mode 100755 tests/vm/ubuntu.aarch64
>
> diff --git a/tests/vm/Makefile.include b/tests/vm/Makefile.include
> index 9e7c46a473..966b417ba7 100644
> --- a/tests/vm/Makefile.include
> +++ b/tests/vm/Makefile.include
> @@ -2,7 +2,7 @@
>=20=20
>  .PHONY: vm-build-all vm-clean-all
>=20=20
> -IMAGES :=3D ubuntu.i386 freebsd netbsd openbsd centos fedora
> +IMAGES :=3D ubuntu.i386 freebsd netbsd openbsd centos fedora ubuntu.aarc=
h64
>  IMAGES_DIR :=3D $(HOME)/.cache/qemu-vm/images
>  IMAGE_FILES :=3D $(patsubst %, $(IMAGES_DIR)/%.img, $(IMAGES))
>=20=20
> @@ -18,6 +18,7 @@ vm-help vm-test:
>  	@echo "  vm-build-openbsd                - Build QEMU in OpenBSD VM"
>  	@echo "  vm-build-centos                 - Build QEMU in CentOS VM, wit=
h Docker"
>  	@echo "  vm-build-fedora                 - Build QEMU in Fedora VM"
> +	@echo "  vm-build-ubuntu.aarch64         - Build QEMU in ubuntu aarch64=
 VM"
>  	@echo ""
>  	@echo "  vm-build-all                    - Build QEMU in all VMs"
>  	@echo "  vm-clean-all                    - Clean up VM images"
> @@ -35,6 +36,8 @@ vm-help vm-test:
>  	@echo "    V=3D1				 - Enable verbose ouput on host and guest commands"
>  	@echo "    QEMU=3D/path/to/qemu		 - Change path to QEMU binary"
>  	@echo "    QEMU_IMG=3D/path/to/qemu-img	 - Change path to qemu-img tool"
> +	@echo "    QEMU_CONFIG=3D/path/conf.yml    - Change path to VM configur=
ation .yml file."
> +	@echo "                                    See config_example.yml for f=
ile format details."
>=20=20
>  vm-build-all: $(addprefix vm-build-, $(IMAGES))
>=20=20
> @@ -80,7 +83,7 @@ vm-boot-serial-%: $(IMAGES_DIR)/%.img
>=20=20
>  vm-boot-ssh-%: $(IMAGES_DIR)/%.img
>  	$(call quiet-command, \
> -		$(SRC_PATH)/tests/vm/$* \
> +		$(PYTHON) $(SRC_PATH)/tests/vm/$* \

This seems like it should be in a different patch.

>  		$(if $(J),--jobs $(J)) \
>  		--image "$<" \
>  		--interactive \
> diff --git a/tests/vm/aarch64vm.py b/tests/vm/aarch64vm.py
> new file mode 100644
> index 0000000000..43f841571f
> --- /dev/null
> +++ b/tests/vm/aarch64vm.py
> @@ -0,0 +1,41 @@
> +#!/usr/bin/env python
> +#
> +# VM testing aarch64 library
> +#
> +# Copyright 2020 Linaro
> +#
> +# Authors:
> +#  Robert Foley <robert.foley@linaro.org>
> +#
> +# This code is licensed under the GPL version 2 or later.  See
> +# the COPYING file in the top-level directory.
> +#
> +import os
> +import sys
> +import subprocess
> +import basevm
> +
> +
> +def create_flash_images():
> +    """Creates the appropriate pflash files
> +       for an aarch64 VM."""
> +    subprocess.check_call(["dd", "if=3D/dev/zero", "of=3Dflash0.img",
> +                           "bs=3D1M", "count=3D64"])
> +    # A reliable way to get the QEMU EFI image is via an installed packa=
ge.
> +    efi_img =3D "/usr/share/qemu-efi-aarch64/QEMU_EFI.fd"
> +    if not os.path.exists(efi_img):
> +        sys.stderr.write("*** {} is missing\n".format(efi_img))
> +        sys.stderr.write("*** please install qemu-efi-aarch64 package\n")
> +        exit(3)
> +    subprocess.check_call(["dd", "if=3D{}".format(efi_img),
> +                           "of=3Dflash0.img", "conv=3Dnotrunc"])
> +    subprocess.check_call(["dd", "if=3D/dev/zero",
> +                           "of=3Dflash1.img", "bs=3D1M", "count=3D64"])
> +
> +def get_pflash_args():
> +    """Returns a string that can be used to
> +       boot qemu using the appropriate pflash files
> +       for aarch64."""
> +    pflash_args =3D "-drive file=3Dflash0.img,format=3Draw,if=3Dpflash "\
> +                  "-drive file=3Dflash1.img,format=3Draw,if=3Dpflash"
> +    return pflash_args.split(" ")
> diff --git a/tests/vm/ubuntu.aarch64 b/tests/vm/ubuntu.aarch64
> new file mode 100755
> index 0000000000..941f7f5166
> --- /dev/null
> +++ b/tests/vm/ubuntu.aarch64
> @@ -0,0 +1,144 @@
> +#!/usr/bin/env python
> +#
> +# Ubuntu aarch64 image
> +#
> +# Copyright 2020 Linaro
> +#
> +# Authors:
> +#  Robert Foley <robert.foley@linaro.org>
> +#  Originally based on ubuntu.i386 Fam Zheng <famz@redhat.com>
> +#
> +# This code is licensed under the GPL version 2 or later.  See
> +# the COPYING file in the top-level directory.
> +#
> +
> +import os
> +import sys
> +import subprocess
> +import basevm
> +import time
> +import aarch64vm
> +
> +DEFAULT_CONFIG =3D {
> +    'cpu'          : "max",
> +    'machine'      : "virt,gic-version=3Dmax",

According to virt.c:

  Valid values are 2, 3 and host

but max should work on TCG. However we need a more recent QEMU than my
system one for it to work. Otherwise you see:

  DEBUG:qemu.machine:Error launching VM
  DEBUG:qemu.machine:Command: 'qemu-system-aarch64 -display none -vga none =
-chardev socket,id=3Dmon,path=3D/var/tmp/qemu-18443-monitor.sock -mon chard=
ev=3Dmon,mode=3Dcontrol -machine
  virt,gic-version=3Dmax -chardev socket,id=3Dconsole,path=3D/var/tmp/qemu-=
18443-console.sock,server,nowait -serial chardev:console -nodefaults -m 4G =
-cpu max -netdev user,id=3Dvnet,hostfwd=3D:127.0.0.1:0-:22 -device virtio-n=
et-pci,netdev=3Dvnet -vnc 127.0.0.1:0,to=3D20 -drive file=3D/home/alex.benn=
ee/.cache/qemu-vm/images/ubuntu.aarch64.img.tmp,if=3Dnone,id=3Ddrive0,cache=
=3Dwriteback -device virtio-blk,drive=3Ddrive0,bootindex=3D0 -cdrom /home/a=
lex.bennee/lsrc/qemu.git/builds/all/vm-test-v8jttvl3.tmp/cloud-init.iso -dr=
ive file=3Dflash0.img,format=3Draw,if=3Dpflash -drive file=3Dflash1.img,for=
mat=3Draw,if=3Dpflash -accel tcg,thread=3Dmulti -smp 8 -device VGA'
  DEBUG:qemu.machine:Output: 'qemu-system-aarch64: Invalid gic-version valu=
e\nValid values are 3, 2, host.\n'
  ERROR:root:Failed to launch QEMU, command line:
  ERROR:root:qemu-system-aarch64 -nodefaults -m 4G -cpu max -netdev user,id=
=3Dvnet,hostfwd=3D:127.0.0.1:0-:22 -device virtio-net-pci,netdev=3Dvnet -vn=
c 127.0.0.1:0,to=3D20 -drive file=3D/home/alex.bennee/.cache/qemu-vm/images=
/ubuntu.aarch64.img.tmp,if=3Dnone,id=3Ddrive0,cache=3Dwriteback -device vir=
tio-blk,drive=3Ddrive0,bootindex=3D0 -cdrom /home/alex.bennee/lsrc/qemu.git=
/builds/all/vm-test-v8jttvl3.tmp/cloud-init.iso -drive file=3Dflash0.img,fo=
rmat=3Draw,if=3Dpflash -drive file=3Dflash1.img,format=3Draw,if=3Dpflash -a=
ccel tcg,thread=3Dmulti -smp 8 -device VGA
  ERROR:root:Log:
  ERROR:root:qemu-system-aarch64: Invalid gic-version value
  Valid values are 3, 2, host.

  ERROR:root:QEMU version >=3D 2.10 is required
  Failed to prepare guest environment
  Traceback (most recent call last):
    File "/home/alex.bennee/lsrc/qemu.git/tests/vm/basevm.py", line 514, in=
 main
      return vm.build_image(args.image)
    File "/home/alex.bennee/lsrc/qemu.git/tests/vm/ubuntu.aarch64", line 11=
4, in build_image
      self.boot(img_tmp, extra_args =3D ["-cdrom", ci_img])
    File "/home/alex.bennee/lsrc/qemu.git/tests/vm/ubuntu.aarch64", line 10=
5, in boot
      super(UbuntuAarch64VM, self).boot(img, extra_args=3Dextra_args)
    File "/home/alex.bennee/lsrc/qemu.git/tests/vm/basevm.py", line 246, in=
 boot
      guest.launch()
    File "/home/alex.bennee/lsrc/qemu.git/tests/vm/../../python/qemu/machin=
e.py", line 302, in launch
      self._launch()
    File "/home/alex.bennee/lsrc/qemu.git/tests/vm/../../python/qemu/machin=
e.py", line 329, in _launch
      self._post_launch()
    File "/home/alex.bennee/lsrc/qemu.git/tests/vm/../../python/qemu/machin=
e.py", line 274, in _post_launch
      self._qmp.accept()
    File "/home/alex.bennee/lsrc/qemu.git/tests/vm/../../python/qemu/qmp.py=
", line 157, in accept
      return self.__negotiate_capabilities()
    File "/home/alex.bennee/lsrc/qemu.git/tests/vm/../../python/qemu/qmp.py=
", line 73, in __negotiate_capabilities
      raise QMPConnectError
  qemu.qmp.QMPConnectError
  /home/alex.bennee/lsrc/qemu.git/tests/vm/Makefile.include:51: recipe for =
target '/home/alex.bennee/.cache/qemu-vm/images/ubuntu.aarch64.img' failed
  make: *** [/home/alex.bennee/.cache/qemu-vm/images/ubuntu.aarch64.img] Er=
ror 2


> +    'install_cmds' : "apt-get update,"\
> +                     "apt-get build-dep -y qemu,"\
> +                     "apt-get install -y libfdt-dev flex bison",
> +    # We increase beyond the default time since during boot
> +    # it can take some time (many seconds) to log into the VM
> +    # especially using softmmu.
> +    'ssh_timeout'  : 60,
> +}
> +
> +class UbuntuAarch64VM(basevm.BaseVM):
> +    name =3D "ubuntu.aarch64"
> +    arch =3D "aarch64"
> +    image_name =3D "ubuntu-18.04-server-cloudimg-arm64.img"
> +    image_link =3D "https://cloud-images.ubuntu.com/releases/18.04/relea=
se/" + image_name
> +    login_prompt =3D "ubuntu-guest login:"
> +    BUILD_SCRIPT =3D """
> +        set -e;
> +        cd $(mktemp -d);
> +        sudo chmod a+r /dev/vdb;
> +        tar --checkpoint=3D.10 -xf /dev/vdb;
> +        ./configure {configure_opts};
> +        make --output-sync {target} -j{jobs} {verbose};
> +    """
> +    def _gen_cloud_init_iso(self):
> +        cidir =3D self._tmpdir
> +        mdata =3D open(os.path.join(cidir, "meta-data"), "w")
> +        mdata.writelines(["instance-id: ubuntu-vm-0\n",
> +                          "local-hostname: ubuntu-guest\n"])
> +        mdata.close()
> +        udata =3D open(os.path.join(cidir, "user-data"), "w")
> +        print("guest user:pw {}:{}".format(self.GUEST_USER, self.GUEST_P=
ASS))
> +        udata.writelines(["#cloud-config\n",
> +                          "chpasswd:\n",
> +                          "  list: |\n",
> +                          "    root:%s\n" % self.ROOT_PASS,
> +                          "    %s:%s\n" % (self.GUEST_USER, self.GUEST_P=
ASS),
> +                          "  expire: False\n",
> +                          "users:\n",
> +                          "  - name: %s\n" % self.GUEST_USER,
> +                          "    sudo: ALL=3D(ALL) NOPASSWD:ALL\n",
> +                          "    ssh-authorized-keys:\n",
> +                          "    - %s\n" % self.ssh_pub_key,
> +                          "  - name: root\n",
> +                          "    ssh-authorized-keys:\n",
> +                          "    - %s\n" % self.ssh_pub_key,
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

It seems this function is proliferating. It certainly seems common
enough to be basevm functionality.

> +
> +    def boot(self, img, extra_args=3DNone):
> +        aarch64vm.create_flash_images()
> +        default_args =3D aarch64vm.get_pflash_args()
> +        if extra_args:
> +            extra_args.extend(default_args)
> +        else:
> +            extra_args =3D default_args
> +        # We always add these performance tweaks
> +        # because without them, we boot so slowly that we
> +        # can time out finding the boot efi device.
> +        if os.geteuid() !=3D 0:
> +            extra_args.extend(["-accel", "tcg,thread=3Dmulti"])

Hmmm thread=3Dmulti should already be enabled by default where it is safe
to do so. Also what has it to do with euid?

> +        if '-smp' not in extra_args and \
> +           '-smp' not in self._config['extra_args'] and \
> +           '-smp' not in self._args:
> +            # Only add if not already there to give caller option to cha=
nge it.
> +            extra_args.extend(["-smp", "8"])
> +
> +        # We have overridden boot() since aarch64 has additional paramet=
ers.
> +        # Call down to the base class method.
> +        super(UbuntuAarch64VM, self).boot(img, extra_args=3Dextra_args)
> +
> +    def build_image(self, img):
> +        os_img =3D self._download_with_cache(self.image_link)
> +        img_tmp =3D img + ".tmp"
> +        subprocess.check_call(["cp", "-f", os_img, img_tmp])
> +        subprocess.check_call(["qemu-img", "resize", img_tmp, "+50G"])
> +        ci_img =3D self._gen_cloud_init_iso()
> +
> +        self.boot(img_tmp, extra_args =3D ["-cdrom", ci_img])
> +        self.wait_ssh(wait_root=3DTrue)
> +        # Fix for slow ssh login.
> +        self.ssh_root("chmod -x /etc/update-motd.d/*")
> +        self.ssh_root("touch /etc/cloud/cloud-init.disabled")
> +        # Disable auto upgrades.
> +        # We want to keep the VM system state stable.
> +        self.ssh_root('sed -ie \'s/"1"/"0"/g\' /etc/apt/apt.conf.d/20aut=
o-upgrades')
> +
> +        # If the user chooses *not* to do the second phase,
> +        # then we will jump right to the graceful shutdown
> +        if self._config['install_cmds'] !=3D "":
> +            # Don't check the status in case the guest hang up too quick=
ly
> +            self.ssh_root("sync && reboot")
> +
> +            self.wait_ssh(wait_root=3DTrue)
> +            # The previous update sometimes doesn't survive a reboot, so=
 do it again
> +            self.ssh_root("sed -ie s/^#\ deb-src/deb-src/g /etc/apt/sour=
ces.list")
> +
> +            # Issue the install commands.
> +            # This can be overriden by the user in the config .yml.
> +            install_cmds =3D self._config['install_cmds'].split(',')
> +            for cmd in install_cmds:
> +                self.ssh_root(cmd)
> +        self.graceful_shutdown()
> +        self.wait()
> +        os.rename(img_tmp, img)
> +        return 0
> +
> +if __name__ =3D=3D "__main__":
> +    sys.exit(basevm.main(UbuntuAarch64VM, DEFAULT_CONFIG))


--=20
Alex Benn=C3=A9e

