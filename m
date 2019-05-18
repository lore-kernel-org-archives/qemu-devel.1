Return-Path: <SRS0=ZZp+=TS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1963AC04AAF
	for <qemu-devel@archiver.kernel.org>; Sat, 18 May 2019 22:56:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBFD420848
	for <qemu-devel@archiver.kernel.org>; Sat, 18 May 2019 22:56:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBFD420848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39536 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hS8Fb-0002CW-W7
	for qemu-devel@archiver.kernel.org; Sat, 18 May 2019 18:56:24 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54887)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hS8EY-0001S6-La
	for qemu-devel@nongnu.org; Sat, 18 May 2019 18:55:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hS8EW-0003MW-OF
	for qemu-devel@nongnu.org; Sat, 18 May 2019 18:55:18 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42391)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hS8ET-0003JW-Ji
	for qemu-devel@nongnu.org; Sat, 18 May 2019 18:55:15 -0400
Received: by mail-wr1-f65.google.com with SMTP id l2so10591085wrb.9
	for <qemu-devel@nongnu.org>; Sat, 18 May 2019 15:55:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=gHwmbgJW5vATWyj8d2aOuKWTS7VEUvoHwoGbC0AhGpU=;
	b=MLgWeqMSs8gWJO6D2DgC3VcHzNbotBVVBbeaWjqC08jwsf0ksXjVxEJuaE6xcEggy6
	UxZnlHtSyq2rkbSpqlCK1LoyO1PFlivUHnt9Mk2zrgkp+oSa+Y9076MDvb5fNmc9LnL8
	guwM1Xp5C88eurtAwlJpBdE64M7VA2jvHPsJZqy5yePgqtkIiA31Jndb3UKsHpAv6GWa
	h+U9aObvsA7Qt+zINhcVMoL54UfISuEye7fDDguJ14mwINuap1nm3H/ktkHszQ0eguxU
	7nm65nq/mSBbZLzzm7FyU0Xh1yCaFdARGRLLGEXDTzmTYK8KYpWWrOdXvgXsP2pE9PEw
	VYDA==
X-Gm-Message-State: APjAAAUhHCBKUM78fyXGfIFFBvJP6EfwHQfnCJTBItldzx6e2LKltkq3
	F7pxOEp/QTaxcZWvK6qpuF/uBg==
X-Google-Smtp-Source: APXvYqyN6GkmapN9txTXasLmMK4sCr80dkWEuEXEObcVpbYGbueCiR77hTX1/wUFkVqSRaoLTL/NHA==
X-Received: by 2002:adf:8043:: with SMTP id 61mr31123825wrk.47.1558220110839; 
	Sat, 18 May 2019 15:55:10 -0700 (PDT)
Received: from [192.168.1.38] (228.red-83-52-173.dynamicip.rima-tde.net.
	[83.52.173.228]) by smtp.gmail.com with ESMTPSA id
	s3sm23762638wre.97.2019.05.18.15.55.09
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Sat, 18 May 2019 15:55:10 -0700 (PDT)
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
References: <20190510104633.9428-1-kraxel@redhat.com>
	<20190510104633.9428-11-kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <40966599-9a55-8078-bc49-e2597ce5d498@redhat.com>
Date: Sun, 19 May 2019 00:55:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190510104633.9428-11-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] [PATCH v2 10/13] tests/vm: freebsd autoinstall,
 using serial console
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Fam Zheng <fam@euphon.net>, Ed Maste <emaste@freebsd.org>,
	Kamil Rytarowski <kamil@netbsd.org>,
	=?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
	Li-Wen Hsu <lwhsu@freebsd.org>, Brad Smith <brad@comstyle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Gerd,

On 5/10/19 12:46 PM, Gerd Hoffmann wrote:
> Instead of fetching the prebuilt image from patchew download the install
> iso and prepare the image locally.  Install to disk, using the serial
> console.  Create qemu user, configure ssh login.  Install packages
> needed for qemu builds.

I'm impressed how charmly this works :)

3 comments so far.

1/ We could record (in tests/vm/freebsd header?) roughly how many local
storage will be used (or display in 'make vm-help'?). FYI this image
takes ~3.1GiB.

2/ "Autoboot in 9 seconds, hit [Enter] to boot or any other key to stop"

3/ I am a bit annoyed it overwrote my previous
~/.cache/qemu-vm/images/freebsd.img VM. Not sure what's the best hash to
use, maybe "git log -n 1 --pretty=format:%H -- tests/vm/freebsd"?
(Similarly for other images).

> Note that freebsd package downloads are delivered as non-cachable
> content, so I had to configure squid with "ignore-no-store
> ignore-private ignore-reload" for pkgmir.geo.freebsd.org to make the
> caching actually work.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  tests/vm/freebsd | 175 ++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 165 insertions(+), 10 deletions(-)
> 
> diff --git a/tests/vm/freebsd b/tests/vm/freebsd
> index b0066017a617..57e5c97f3b26 100755
> --- a/tests/vm/freebsd
> +++ b/tests/vm/freebsd
> @@ -2,43 +2,198 @@
>  #
>  # FreeBSD VM image
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
>  #
>  
>  import os
> +import re
>  import sys
> +import time
> +import socket
>  import subprocess
>  import basevm
>  
>  class FreeBSDVM(basevm.BaseVM):
>      name = "freebsd"
>      arch = "x86_64"
> +
> +    link = "https://download.freebsd.org/ftp/releases/ISO-IMAGES/12.0/FreeBSD-12.0-RELEASE-amd64-disc1.iso.xz"
> +    csum = "1d40015bea89d05b8bd13e2ed80c40b522a9ec1abd8e7c8b80954fb485fb99db"
> +    size = "20G"
> +    pkgs = [
> +        # build tools
> +        "git",
> +        "pkgconf",
> +        "bzip2",
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
> +        "jpeg-turbo",
> +        "png",
> +
> +        # libs: ui
> +        "sdl2",
> +        "gtk3",
> +        "libxkbcommon",
> +
> +        # libs: opengl
> +        "libepoxy",
> +        "mesa-libs",
> +    ]
> +
>      BUILD_SCRIPT = """
>          set -e;
> -        rm -rf /var/tmp/qemu-test.*
> -        cd $(mktemp -d /var/tmp/qemu-test.XXXXXX);
> +        rm -rf /home/qemu/qemu-test.*
> +        cd $(mktemp -d /home/qemu/qemu-test.XXXXXX);
> +        mkdir src build; cd src;
>          tar -xf /dev/vtbd1;
> -        ./configure {configure_opts};
> +        cd ../build
> +        ../src/configure --python=python3.6 {configure_opts};
>          gmake --output-sync -j{jobs} {target} {verbose};
>      """
>  
> +    def console_boot_serial(self):
> +        self.console_wait_send("Autoboot", "3")
> +        self.console_wait_send("OK", "set console=comconsole\n")
> +        self.console_wait_send("OK", "boot\n")
> +
>      def build_image(self, img):
> -        cimg = self._download_with_cache("http://download.patchew.org/freebsd-11.1-amd64.img.xz",
> -                sha256sum='adcb771549b37bc63826c501f05121a206ed3d9f55f49145908f7e1432d65891')
> -        img_tmp_xz = img + ".tmp.xz"
> +        self.print_step("Downloading install iso")
> +        cimg = self._download_with_cache(self.link, sha256sum=self.csum)
>          img_tmp = img + ".tmp"
> -        sys.stderr.write("Extracting the image...\n")
> -        subprocess.check_call(["cp", "-f", cimg, img_tmp_xz])
> -        subprocess.check_call(["xz", "-dvf", img_tmp_xz])
> +        iso = img + ".install.iso"
> +        iso_xz = iso + ".xz"
> +
> +        self.print_step("Preparing iso and disk image")
> +        subprocess.check_call(["cp", "-f", cimg, iso_xz])
> +        subprocess.check_call(["xz", "-dvf", iso_xz])
> +        subprocess.check_call(["qemu-img", "create", "-f", "qcow2",
> +                               img_tmp, self.size])
> +
> +        self.print_step("Booting installer")
> +        self.boot(img_tmp, extra_args = [
> +            "-machine", "graphics=off",
> +            "-cdrom", iso
> +        ])
> +        self.console_init()
> +        self.console_boot_serial()
> +        self.console_wait_send("Console type",          "xterm\n")
> +
> +        # pre-install configuration
> +        self.console_wait_send("Welcome",               "\n")
> +        self.console_wait_send("Keymap Selection",      "\n")
> +        self.console_wait_send("Set Hostname",          "freebsd\n")
> +        self.console_wait_send("Distribution Select",   "\n")
> +        self.console_wait_send("Partitioning",          "\n")
> +        self.console_wait_send("Partition",             "\n")
> +        self.console_wait_send("Scheme",                "\n")
> +        self.console_wait_send("Editor",                "f")
> +        self.console_wait_send("Confirmation",          "c")
> +
> +        self.print_step("Installation started now, this will take a while")
> +
> +        # post-install configuration
> +        self.console_wait("New Password:")
> +        self.console_send("%s\n" % self.ROOT_PASS)
> +        self.console_wait("Retype New Password:")
> +        self.console_send("%s\n" % self.ROOT_PASS)
> +
> +        self.console_wait_send("Network Configuration", "\n")
> +        self.console_wait_send("IPv4",                  "y")
> +        self.console_wait_send("DHCP",                  "y")
> +        self.console_wait_send("IPv6",                  "n")
> +        self.console_wait_send("Resolver",              "\n")
> +
> +        self.console_wait_send("Time Zone Selector",    "a\n")
> +        self.console_wait_send("Confirmation",          "y")
> +        self.console_wait_send("Time & Date",           "\n")
> +        self.console_wait_send("Time & Date",           "\n")
> +
> +        self.console_wait_send("System Configuration",  "\n")
> +        self.console_wait_send("System Hardening",      "\n")
> +
> +        # qemu user
> +        self.console_wait_send("Add User Accounts", "y")
> +        self.console_wait("Username")
> +        self.console_send("%s\n" % self.GUEST_USER)
> +        self.console_wait("Full name")
> +        self.console_send("%s\n" % self.GUEST_USER)
> +        self.console_wait_send("Uid",                   "\n")
> +        self.console_wait_send("Login group",           "\n")
> +        self.console_wait_send("Login group",           "\n")
> +        self.console_wait_send("Login class",           "\n")
> +        self.console_wait_send("Shell",                 "\n")
> +        self.console_wait_send("Home directory",        "\n")
> +        self.console_wait_send("Home directory perm",   "\n")
> +        self.console_wait_send("Use password",          "\n")
> +        self.console_wait_send("Use an empty password", "\n")
> +        self.console_wait_send("Use a random password", "\n")
> +        self.console_wait("Enter password:")
> +        self.console_send("%s\n" % self.GUEST_PASS)
> +        self.console_wait("Enter password again:")
> +        self.console_send("%s\n" % self.GUEST_PASS)
> +        self.console_wait_send("Lock out",              "\n")
> +        self.console_wait_send("OK",                    "yes\n")
> +        self.console_wait_send("Add another user",      "no\n")
> +
> +        self.console_wait_send("Final Configuration",   "\n")
> +        self.console_wait_send("Manual Configuration",  "\n")
> +        self.console_wait_send("Complete",              "\n")
> +
> +        self.print_step("Installation finished, rebooting")
> +        self.console_boot_serial()
> +
> +        # setup qemu user
> +        prompt = "$"
> +        self.console_ssh_init(prompt, self.GUEST_USER, self.GUEST_PASS)
> +        self.console_wait_send(prompt, "exit\n")
> +
> +        # setup root user
> +        prompt = "root@freebsd:~ #"
> +        self.console_ssh_init(prompt, "root", self.ROOT_PASS)
> +        self.console_sshd_config(prompt)
> +
> +        # setup serial console
> +        self.console_wait(prompt)
> +        self.console_send("echo 'console=comconsole' >> /boot/loader.conf\n")
> +
> +        # setup virtio-blk #1 (tarfile)
> +        self.console_wait(prompt)
> +        self.console_send("echo 'chmod 666 /dev/vtbd1' >> /etc/rc.local\n")
> +
> +        self.print_step("Configuration finished, rebooting")
> +        self.console_wait_send(prompt, "reboot\n")
> +        self.console_wait("login:")
> +        self.wait_ssh()
> +
> +        self.print_step("Installing packages")
> +        self.ssh_root_check("pkg install -y %s\n" % " ".join(self.pkgs))
> +
> +        # shutdown
> +        self.ssh_root(self.poweroff)
> +        self.console_wait("Uptime:")
> +        self.wait()
> +
>          if os.path.exists(img):
>              os.remove(img)
>          os.rename(img_tmp, img)
> +        os.remove(iso)
> +        self.print_step("All done")
>  
>  if __name__ == "__main__":
>      sys.exit(basevm.main(FreeBSDVM))
> 

