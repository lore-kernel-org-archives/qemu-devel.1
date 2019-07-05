Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B894C46499
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 10:27:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3194B20989
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 10:27:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FYgnc4y2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3194B20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjLRJ-0004Ro-7M
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 06:27:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53798)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hjLOT-000304-O4
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 06:24:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hjLOP-0005xj-Q3
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 06:24:41 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:37248)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hjLON-0005a1-Hl
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 06:24:36 -0400
Received: by mail-wr1-x444.google.com with SMTP id n9so219360wrr.4
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2019 03:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=uQdYE/AVIrWdOvyaHAPVmk+aMlsyCgbqZj2Kh8lJ8+0=;
 b=FYgnc4y2ciu8jNs89GWonf9RaE9u46HpyiJc+IWfHNTOnOv2dd70NnHnMOIyp2+2tP
 fQ5uf5qf14e9ex0UVEjRmancUTr7NJQDx2891OzN+JfNNZjAxEQX8005LBRcebj0ezGY
 pBg3VRRidwIi5qOVfQfdCbyladahGVPN7DJek1cmX692o1AHOigUay6d+DR2y47ren4p
 do65yM3yeOiBB1mmDE5PPC++SXohN80y2kf7RrFY5qjr/TLHYgqQPPScMD/HCDCbdh4h
 QbJbPn8iIwE82Bdhxyizzhv9jVR9ySa6f1v/QTQA0IlFPwNd/wgWgoGZl70B1eaMsPgT
 eRmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=uQdYE/AVIrWdOvyaHAPVmk+aMlsyCgbqZj2Kh8lJ8+0=;
 b=eKVJDqcI2sm4NAOrslg5+BubETijkAe4hPQFE//O8bZsijT70VgMYcAfcfohhkPc8v
 Qdl23u/KXNJ4tUj8M+9HUTN7owCulq1Ng2X5IfersVvmJe0A5Dq3KDHfxixv0z5IsyMp
 ZExyuxAxYMcWt+mt2g6O2nB1uqhaJyY416YXewt711nGGTTDU3Yp0Nh16cvoJzQ5zywo
 xVpRsrJJWhnflcGzzH24GqsalUmVPVf72Z7XIZ4ZtEu9KDQPoE0LI1lchKv5aek6XsrI
 144h44fN5PZLq08aWOhOLnxkhZlROlKp7NhIjJ1wbQ1Xszr+KbQRKIoV5wtAv20DrJ9G
 wJ2w==
X-Gm-Message-State: APjAAAVCKtg3NA7U8h5A2WmbnbpW8U/lzL/Fwlk9Iz47eH6jeySTKsDG
 brdV3x4zDj6SzutVAnOtmii6j8Plfxw=
X-Google-Smtp-Source: APXvYqwsCsZxUjUXrV1SPhbeDJnsdXTUWWE/Jx7JwqHCoLntinZst+/DpoiBRqqN0QhGvSLr8ZjG5A==
X-Received: by 2002:adf:e802:: with SMTP id o2mr3628161wrm.171.1562322267621; 
 Fri, 05 Jul 2019 03:24:27 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id a3sm8565724wmb.35.2019.07.05.03.24.26
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 05 Jul 2019 03:24:26 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 9F5521FF87;
 Fri,  5 Jul 2019 11:24:26 +0100 (BST)
References: <20190617043858.8290-1-kraxel@redhat.com>
 <20190617043858.8290-10-kraxel@redhat.com>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Gerd Hoffmann <kraxel@redhat.com>
In-reply-to: <20190617043858.8290-10-kraxel@redhat.com>
Date: Fri, 05 Jul 2019 11:24:26 +0100
Message-ID: <87zhlsvkx1.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: Re: [Qemu-devel] [PATCH v4 09/11] tests/vm: netbsd autoinstall,
 using serial console
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Ed Maste <emaste@freebsd.org>, qemu-devel@nongnu.org,
 Kamil Rytarowski <kamil@netbsd.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Brad Smith <brad@comstyle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Gerd Hoffmann <kraxel@redhat.com> writes:

> Instead of fetching the prebuilt image from patchew download the install
> iso and prepare the image locally.  Install to disk, using the serial
> console.  Create qemu user, configure ssh login.  Install packages
> needed for qemu builds.

I've had to drop this from my v3 PR as Peter was seeing a very
slow/hanging install when running his merge tests. I've tried to
reproduce and I see it stall while installing packages but nowhere near
the delay Peter has seen.

Any pointers on how to debug gratefully received.

>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> Reviewed-by: Kamil Rytarowski <n54@gmx.com>
> Tested-by: Thomas Huth <thuth@redhat.com>
> ---
>  tests/vm/netbsd | 187 +++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 177 insertions(+), 10 deletions(-)
>
> diff --git a/tests/vm/netbsd b/tests/vm/netbsd
> index 4c6624ea5ed5..be59a2c1da1d 100755
> --- a/tests/vm/netbsd
> +++ b/tests/vm/netbsd
> @@ -2,10 +2,11 @@
>  #
>  # NetBSD VM image
>  #
> -# Copyright 2017 Red Hat Inc.
> +# Copyright 2017-2019 Red Hat Inc.
>  #
>  # Authors:
>  #  Fam Zheng <famz@redhat.com>
> +#  Gerd Hoffmann <kraxel@redhat.com>
>  #
>  # This code is licensed under the GPL version 2 or later.  See
>  # the COPYING file in the top-level directory.
> @@ -13,32 +14,198 @@
>
>  import os
>  import sys
> +import time
>  import subprocess
>  import basevm
>
>  class NetBSDVM(basevm.BaseVM):
>      name =3D "netbsd"
>      arch =3D "x86_64"
> +
> +    link =3D "https://cdn.netbsd.org/pub/NetBSD/NetBSD-8.0/images/NetBSD=
-8.0-amd64.iso"
> +    size =3D "20G"
> +    pkgs =3D [
> +        # tools
> +        "git-base",
> +        "pkgconf",
> +        "xz",
> +        "python37",
> +
> +        # gnu tools
> +        "bash",
> +        "gmake",
> +        "gsed",
> +        "flex", "bison",
> +
> +        # libs: crypto
> +        "gnutls",
> +
> +        # libs: images
> +        "jpeg",
> +        "png",
> +
> +	# libs: ui
> +        "SDL2",
> +        "gtk3+",
> +        "libxkbcommon",
> +    ]
> +
>      BUILD_SCRIPT =3D """
>          set -e;
> -        rm -rf /var/tmp/qemu-test.*
> -        cd $(mktemp -d /var/tmp/qemu-test.XXXXXX);
> +        rm -rf /home/qemu/qemu-test.*
> +        cd $(mktemp -d /home/qemu/qemu-test.XXXXXX);
> +        mkdir src build; cd src;
>          tar -xf /dev/rld1a;
> -        ./configure --python=3Dpython2.7 {configure_opts};
> +        cd ../build
> +        ../src/configure --python=3Dpython3.7 --disable-opengl {configur=
e_opts};
>          gmake --output-sync -j{jobs} {target} {verbose};
>      """
> +    poweroff =3D "/sbin/poweroff"
>
>      def build_image(self, img):
> -        cimg =3D self._download_with_cache("http://download.patchew.org/=
netbsd-7.1-amd64.img.xz",
> -                                         sha256sum=3D'b633d565b0eac3d020=
15cd0c81440bd8a7a8df8512615ac1ee05d318be015732')
> -        img_tmp_xz =3D img + ".tmp.xz"
> +        cimg =3D self._download_with_cache(self.link)
>          img_tmp =3D img + ".tmp"
> -        sys.stderr.write("Extracting the image...\n")
> -        subprocess.check_call(["cp", "-f", cimg, img_tmp_xz])
> -        subprocess.check_call(["xz", "-dvf", img_tmp_xz])
> +        iso =3D img + ".install.iso"
> +
> +        self.print_step("Preparing iso and disk image")
> +        subprocess.check_call(["cp", "-f", cimg, iso])
> +        subprocess.check_call(["qemu-img", "create", "-f", "qcow2",
> +                               img_tmp, self.size])
> +
> +        self.print_step("Booting installer")
> +        self.boot(img_tmp, extra_args =3D [
> +            "-bios", "pc-bios/bios-256k.bin",
> +            "-machine", "graphics=3Doff",
> +            "-cdrom", iso
> +        ])
> +        self.console_init()
> +        self.console_wait("Primary Bootstrap")
> +
> +        # serial console boot menu output doesn't work for some
> +        # reason, so we have to fly blind ...
> +        for char in list("5consdev com0\n"):
> +            time.sleep(0.2)
> +            self.console_send(char)
> +            self.console_wait("")
> +        self.console_wait_send("> ", "boot\n")
> +
> +        self.console_wait_send("Terminal type",            "xterm\n")
> +        self.console_wait_send("a: Installation messages", "a\n")
> +        self.console_wait_send("b: US-English",            "b\n")
> +        self.console_wait_send("a: Install NetBSD",        "a\n")
> +        self.console_wait("Shall we continue?")
> +        self.console_wait_send("b: Yes",                   "b\n")
> +
> +        self.console_wait_send("a: ld0",                   "a\n")
> +        self.console_wait_send("a: This is the correct",   "a\n")
> +        self.console_wait_send("b: Use the entire disk",   "b\n")
> +        self.console_wait("NetBSD bootcode")
> +        self.console_wait_send("a: Yes",                   "a\n")
> +        self.console_wait_send("b: Use existing part",     "b\n")
> +        self.console_wait_send("x: Partition sizes ok",    "x\n")
> +        self.console_wait_send("for your NetBSD disk",     "\n")
> +        self.console_wait("Shall we continue?")
> +        self.console_wait_send("b: Yes",                   "b\n")
> +
> +        self.console_wait_send("b: Use serial port com0",  "b\n")
> +        self.console_wait_send("f: Set serial baud rate",  "f\n")
> +        self.console_wait_send("a: 9600",                  "a\n")
> +        self.console_wait_send("x: Exit",                  "x\n")
> +
> +        self.console_wait_send("a: Full installation",     "a\n")
> +        self.console_wait_send("a: CD-ROM",                "a\n")
> +
> +        self.print_step("Installation started now, this will take a whil=
e")
> +        self.console_wait_send("Hit enter to continue",    "\n")
> +
> +        self.console_wait_send("d: Change root password",  "d\n")
> +        self.console_wait_send("a: Yes",                   "a\n")
> +        self.console_wait("New password:")
> +        self.console_send("%s\n" % self.ROOT_PASS)
> +        self.console_wait("New password:")
> +        self.console_send("%s\n" % self.ROOT_PASS)
> +        self.console_wait("Retype new password:")
> +        self.console_send("%s\n" % self.ROOT_PASS)
> +
> +        self.console_wait_send("o: Add a user",            "o\n")
> +        self.console_wait("username")
> +        self.console_send("%s\n" % self.GUEST_USER)
> +        self.console_wait("to group wheel")
> +        self.console_wait_send("a: Yes",                   "a\n")
> +        self.console_wait_send("a: /bin/sh",               "a\n")
> +        self.console_wait("New password:")
> +        self.console_send("%s\n" % self.GUEST_PASS)
> +        self.console_wait("New password:")
> +        self.console_send("%s\n" % self.GUEST_PASS)
> +        self.console_wait("Retype new password:")
> +        self.console_send("%s\n" % self.GUEST_PASS)
> +
> +        self.console_wait_send("a: Configure network",     "a\n")
> +        self.console_wait_send("a: vioif0",                "a\n")
> +        self.console_wait_send("Network media type",       "\n")
> +        self.console_wait("autoconfiguration")
> +        self.console_wait_send("a: Yes",                   "a\n")
> +        self.console_wait_send("DNS domain",               "localnet\n")
> +        self.console_wait("Are they OK?")
> +        self.console_wait_send("a: Yes",                   "a\n")
> +        self.console_wait("installed in /etc")
> +        self.console_wait_send("a: Yes",                   "a\n")
> +
> +        self.console_wait_send("e: Enable install",        "e\n")
> +        proxy =3D os.environ.get("http_proxy")
> +        if not proxy is None:
> +            self.console_wait_send("f: Proxy",             "f\n")
> +            self.console_wait("Proxy")
> +            self.console_send("%s\n" % proxy)
> +        self.console_wait_send("x: Install pkgin",         "x\n")
> +        self.console_init(1200)
> +        self.console_wait_send("Hit enter to continue", "\n")
> +        self.console_init()
> +
> +        self.console_wait_send("g: Enable sshd",           "g\n")
> +        self.console_wait_send("x: Finished conf",         "x\n")
> +        self.console_wait_send("Hit enter to continue",    "\n")
> +
> +        self.print_step("Installation finished, rebooting")
> +        self.console_wait_send("d: Reboot the computer",   "d\n")
> +
> +        # setup qemu user
> +        prompt =3D "localhost$"
> +        self.console_ssh_init(prompt, self.GUEST_USER, self.GUEST_PASS)
> +        self.console_wait_send(prompt, "exit\n")
> +
> +        # setup root user
> +        prompt =3D "localhost#"
> +        self.console_ssh_init(prompt, "root", self.ROOT_PASS)
> +        self.console_sshd_config(prompt)
> +
> +        # setup virtio-blk #1 (tarfile)
> +        self.console_wait(prompt)
> +        self.console_send("echo 'chmod 666 /dev/rld1a' >> /etc/rc.local\=
n")
> +
> +        # turn off mprotect (conflicts with tcg)
> +        self.console_wait(prompt)
> +        self.console_send("echo security.pax.mprotect.enabled=3D0 >> /et=
c/sysctl.conf\n")
> +
> +        self.print_step("Configuration finished, rebooting")
> +        self.console_wait_send(prompt, "reboot\n")
> +        self.console_wait("login:")
> +        self.wait_ssh()
> +
> +        self.print_step("Installing packages")
> +        self.ssh_root_check("pkgin update\n")
> +        self.ssh_root_check("pkgin -y install %s\n" % " ".join(self.pkgs=
))
> +
> +        # shutdown
> +        self.ssh_root(self.poweroff)
> +        self.console_wait("entering state S5")
> +        self.wait()
> +
>          if os.path.exists(img):
>              os.remove(img)
>          os.rename(img_tmp, img)
> +        os.remove(iso)
> +        self.print_step("All done")
>
>  if __name__ =3D=3D "__main__":
>      sys.exit(basevm.main(NetBSDVM))


--
Alex Benn=C3=A9e

