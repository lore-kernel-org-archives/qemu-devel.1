Return-Path: <SRS0=NdIa=7N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8F8AC433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2020 10:37:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91E1C2074A
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2020 10:37:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KtzjfaE2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91E1C2074A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52352 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfLLV-0003cd-Tr
	for qemu-devel@archiver.kernel.org; Sun, 31 May 2020 06:37:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50824)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jfLKx-0003DJ-6o
 for qemu-devel@nongnu.org; Sun, 31 May 2020 06:37:03 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:33142
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jfLKv-0008QK-VU
 for qemu-devel@nongnu.org; Sun, 31 May 2020 06:37:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590921421;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=SQVTzxmRHiy4hlxKTJXke602L6aPs2N+muqL6/5kgrs=;
 b=KtzjfaE2M8sK3FX5mBgJTTeFjMBfaL2deahthPT9oXjHA2OJeOhFI1W6QJF3XPtRqch4J5
 332G5GmQIK5erdMLL26tlfr8JDd2qTh1Df2DfcgKgjKHFhHQHhojPWNWYyhjiau4p9dUtR
 x05gXnD3cP3ZtfGmXyQARbNzU0zIY7Y=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-307-9x0BtYDXPnKbpajIpb31Zg-1; Sun, 31 May 2020 06:36:40 -0400
X-MC-Unique: 9x0BtYDXPnKbpajIpb31Zg-1
Received: by mail-wr1-f72.google.com with SMTP id n6so3329649wrv.6
 for <qemu-devel@nongnu.org>; Sun, 31 May 2020 03:36:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=SQVTzxmRHiy4hlxKTJXke602L6aPs2N+muqL6/5kgrs=;
 b=JV3avQJuQCnat7DogBbZkIi2zwDwRa5uey3JkR8yip6x3ABRCJE0ScbAFrAMBca/7n
 N3cGeVcvIf4FVq6l2D1y7ut1IHgES6Bjhbq3O/AN8ggRjnwtXtVe2Svf54ln12dDMQTf
 yAmXNv9bcqGQ7ZP/JLWxjfIscqMcIAJP+N40uDVk3wQpfNJlchiesDBndxW+uQEGcugS
 2cqFW3/Zdr0FxO0TgxryGovE867WRfUynb65trr//uS1tV4nBcUZT8mf1eNyhZASjHX/
 aEGxMyhKyTLLEhTHVmEwRiqQVEC+vG/psAOHF2URVukA3ppx5pV0mz74K5ALB7pK2Dlq
 eH9A==
X-Gm-Message-State: AOAM531p+6uHCbRmGwQr9FRvChV/OkUT4cLge8vUAGVyeOH5W1pp93N0
 BpUSylnytjRMfkP/aFp5MlRO3fqmOfkWddanCzE8s20Yl2jd2XMDECA2hnZBKIo648PLLy07zZP
 C/wOf9A4szg2UnqU=
X-Received: by 2002:a1c:6606:: with SMTP id a6mr16091921wmc.37.1590921398924; 
 Sun, 31 May 2020 03:36:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyubxZVr66AFBFXmb4wzGhx0Pmrvq0BGwBUOY22AdkOtetGbRO3omP5ZvitWWZc7AnnCntO5w==
X-Received: by 2002:a1c:6606:: with SMTP id a6mr16091911wmc.37.1590921398596; 
 Sun, 31 May 2020 03:36:38 -0700 (PDT)
Received: from [192.168.1.34] (43.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.43])
 by smtp.gmail.com with ESMTPSA id f11sm16616626wrm.13.2020.05.31.03.36.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 31 May 2020 03:36:37 -0700 (PDT)
Subject: Re: [PATCH v8 07/12] tests/vm: Add common Ubuntu python module
To: Robert Foley <robert.foley@linaro.org>, qemu-devel@nongnu.org
References: <20200529203458.1038-1-robert.foley@linaro.org>
 <20200529203458.1038-8-robert.foley@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <3cfd11c3-a99b-3766-4607-39c2174f1652@redhat.com>
Date: Sun, 31 May 2020 12:36:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200529203458.1038-8-robert.foley@linaro.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/31 05:58:14
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Fam Zheng <fam@euphon.net>, peter.puhov@linaro.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/29/20 10:34 PM, Robert Foley wrote:
> Add a common Ubuntu python module and make use of
> it with the ubuntu.i386 script.
> This is preparation for adding an Ubuntu script
> ubuntu.aarch64.  Splitting out the common
> logic such as build_image() will reduce duplication.
> 
> Signed-off-by: Robert Foley <robert.foley@linaro.org>
> ---
>  tests/vm/ubuntu.i386 | 46 +++++++++--------------------------
>  tests/vm/ubuntuvm.py | 58 ++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 70 insertions(+), 34 deletions(-)
>  create mode 100644 tests/vm/ubuntuvm.py
> 
> diff --git a/tests/vm/ubuntu.i386 b/tests/vm/ubuntu.i386
> index 1570775335..c699eaf8d7 100755
> --- a/tests/vm/ubuntu.i386
> +++ b/tests/vm/ubuntu.i386
> @@ -11,15 +11,22 @@
>  # the COPYING file in the top-level directory.
>  #
>  
> -import os
>  import sys
> -import subprocess
>  import basevm
> -import time
> +import ubuntuvm
>  
> -class UbuntuX86VM(basevm.BaseVM):
> +DEFAULT_CONFIG = {
> +    'install_cmds' : "apt-get update,"\
> +                     "apt-get build-dep -y qemu,"\
> +                     "apt-get install -y libfdt-dev flex bison language-pack-en",
> +}
> +
> +class UbuntuX86VM(ubuntuvm.UbuntuVM):
>      name = "ubuntu.i386"
>      arch = "i386"
> +    image_link="https://cloud-images.ubuntu.com/releases/bionic/"\
> +               "release-20191114/ubuntu-18.04-server-cloudimg-i386.img"
> +    image_sha256="28969840626d1ea80bb249c08eef1a4533e8904aa51a327b40f37ac4b4ff04ef"
>      BUILD_SCRIPT = """
>          set -e;
>          cd $(mktemp -d);
> @@ -29,34 +36,5 @@ class UbuntuX86VM(basevm.BaseVM):
>          make --output-sync {target} -j{jobs} {verbose};
>      """
>  
> -    def build_image(self, img):
> -        cimg = self._download_with_cache(
> -            "https://cloud-images.ubuntu.com/releases/bionic/release-20191114/ubuntu-18.04-server-cloudimg-i386.img",
> -            sha256sum="28969840626d1ea80bb249c08eef1a4533e8904aa51a327b40f37ac4b4ff04ef")
> -        img_tmp = img + ".tmp"
> -        subprocess.check_call(["cp", "-f", cimg, img_tmp])
> -        self.exec_qemu_img("resize", img_tmp, "50G")
> -        self.boot(img_tmp, extra_args = [
> -            "-device", "VGA",
> -            "-cdrom", self.gen_cloud_init_iso()
> -        ])
> -        self.wait_ssh()
> -        self.ssh_root_check("touch /etc/cloud/cloud-init.disabled")
> -        self.ssh_root_check("apt-get update")
> -        self.ssh_root_check("apt-get install -y cloud-initramfs-growroot")
> -        # Don't check the status in case the guest hang up too quickly
> -        self.ssh_root("sync && reboot")
> -        time.sleep(5)
> -        self.wait_ssh()
> -        # The previous update sometimes doesn't survive a reboot, so do it again
> -        self.ssh_root_check("sed -ie s/^#\ deb-src/deb-src/g /etc/apt/sources.list")
> -        self.ssh_root_check("apt-get update")
> -        self.ssh_root_check("apt-get build-dep -y qemu")
> -        self.ssh_root_check("apt-get install -y libfdt-dev flex bison language-pack-en")
> -        self.ssh_root("poweroff")
> -        self.wait()
> -        os.rename(img_tmp, img)
> -        return 0
> -
>  if __name__ == "__main__":
> -    sys.exit(basevm.main(UbuntuX86VM))
> +    sys.exit(basevm.main(UbuntuX86VM, DEFAULT_CONFIG))
> diff --git a/tests/vm/ubuntuvm.py b/tests/vm/ubuntuvm.py
> new file mode 100644
> index 0000000000..96f29dcc15
> --- /dev/null
> +++ b/tests/vm/ubuntuvm.py
> @@ -0,0 +1,58 @@
> +#!/usr/bin/env python3
> +#
> +# Ubuntu VM testing library
> +#

Maybe:

   # Copyright 2017 Red Hat Inc.

> +# Copyright 2020 Linaro
> +#
> +# Authors:

And:

   #  Fam Zheng <famz@redhat.com>

or a line "copied from ..."?

> +#  Robert Foley <robert.foley@linaro.org>
> +#
> +# This code is licensed under the GPL version 2 or later.  See
> +# the COPYING file in the top-level directory.
> +
> +import os
> +import subprocess
> +import basevm
> +
> +class UbuntuVM(basevm.BaseVM):
> +
> +    def __init__(self, args, config=None):
> +        self.login_prompt = "ubuntu-{}-guest login:".format(self.arch)
> +        basevm.BaseVM.__init__(self, args, config)
> +
> +    def build_image(self, img):
> +        """Build an Ubuntu VM image.  The child class will
> +           define the install_cmds to init the VM."""
> +        os_img = self._download_with_cache(self.image_link,
> +                                           sha256sum=self.image_sha256)
> +        img_tmp = img + ".tmp"
> +        subprocess.check_call(["cp", "-f", os_img, img_tmp])
> +        self.exec_qemu_img("resize", img_tmp, "+50G")
> +        ci_img = self.gen_cloud_init_iso()
> +
> +        self.boot(img_tmp, extra_args = [ "-device", "VGA", "-cdrom", ci_img, ])
> +
> +        # First command we issue is fix for slow ssh login.
> +        self.wait_ssh(wait_root=True,
> +                      cmd="chmod -x /etc/update-motd.d/*")
> +        # Wait for cloud init to finish
> +        self.wait_ssh(wait_root=True,
> +                      cmd="ls /var/lib/cloud/instance/boot-finished")
> +        self.ssh_root("touch /etc/cloud/cloud-init.disabled")
> +        # Disable auto upgrades.
> +        # We want to keep the VM system state stable.
> +        self.ssh_root('sed -ie \'s/"1"/"0"/g\' '\
> +                      '/etc/apt/apt.conf.d/20auto-upgrades')
> +        self.ssh_root("sed -ie s/^#\ deb-src/deb-src/g /etc/apt/sources.list")
> +
> +        # If the user chooses not to do the install phase,
> +        # then we will jump right to the graceful shutdown
> +        if self._config['install_cmds'] != "":
> +            # Issue the install commands.
> +            # This can be overriden by the user in the config .yml.
> +            install_cmds = self._config['install_cmds'].split(',')
> +            for cmd in install_cmds:
> +                self.ssh_root(cmd)
> +        self.graceful_shutdown()
> +        os.rename(img_tmp, img)
> +        return 0
> 

Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>


