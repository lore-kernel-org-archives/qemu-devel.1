Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 516B6C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 23:58:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18A6620409
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 23:58:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DMhc0Dam"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18A6620409
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixJhY-0004s7-7d
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 18:58:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56665)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ixJgy-0004TX-Rz
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 18:57:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ixJgx-0002Ah-Hj
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 18:57:48 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52097
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ixJgx-00029e-Dk
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 18:57:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580428666;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XEE0FrBa9R4BxmmT9MHro1FOsGJXAovxAeui33nGVNE=;
 b=DMhc0Dam720CbCIRoE7weMCLf2mjWJwXzNctUPiTV7DV2pbiuZLXxumZunqQPdgbii6J6u
 Thod6Aw/nNUePQA+ciQxFVpP2/NoyRf8Nk78pish59aC8eyp2xx8P8a5KNPohadLx3cYxN
 ua9TAS0dP/vPS6+J+nlnad0rGQWQKxQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-406-TT5-GiVAMJCSOnhE7GxABw-1; Thu, 30 Jan 2020 18:57:39 -0500
Received: by mail-wr1-f71.google.com with SMTP id u18so2437167wrn.11
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2020 15:57:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=XEE0FrBa9R4BxmmT9MHro1FOsGJXAovxAeui33nGVNE=;
 b=pXbuN9w5wm8GYQvb8xOgZyDuxuQLik5bLTOpD5ApNU1/NRqboScqJtDhUT72YeWaGd
 UJxhLwJeCzCdtMTy0rVcAcS4el2frIHhtY8NZPSyYkl+STAeu1IbOVgi80Et0O5fZ9k9
 w0Mc1kmWGFA4wwGZfOBQjKEM+0XLJ1O1bQ8x5V8wLTVxZ2+W6oXjBd324zpBes/vkfpQ
 ipB9YlhnctRaYturr/ahUCrkufCVBVD2bEloZs1P6iJI3rXALP3N3S/5HjCn2ExRXbWj
 zWYYZtj+ggPmu/bQhXVPV105Id/fo6c2/2oZafr0hx4YYAMspYg/OTjEPFzMD+HxoAbZ
 Bzgg==
X-Gm-Message-State: APjAAAWN2tUA/CxVRXr2yQe0JgEAWaXEcaydlguDVO8RpL3rFPMvi6OE
 hsb2NUU5Ah/QU17Nni6vZVVlRvCvIvM3ht7GN1HMNSYjE5VNQEoT2sV+DJtJJd/+HbPl4/O/6Ux
 4F3YWRQJJZWkyaOg=
X-Received: by 2002:adf:ee0c:: with SMTP id y12mr8231983wrn.341.1580428657717; 
 Thu, 30 Jan 2020 15:57:37 -0800 (PST)
X-Google-Smtp-Source: APXvYqzXgpEjj9GPzMBFOSpYv3rX0Mga9SnaKJQfo30XEkffCxVE47u1NzfBooi6fXm8J6jQkYVHMw==
X-Received: by 2002:adf:ee0c:: with SMTP id y12mr8231962wrn.341.1580428657483; 
 Thu, 30 Jan 2020 15:57:37 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id w17sm8989796wrt.89.2020.01.30.15.57.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jan 2020 15:57:36 -0800 (PST)
Subject: Re: [PATCH 6/6] tests/boot_linux_console: add PVH acceptance tests
To: Liam Merwick <liam.merwick@oracle.com>, alex.bennee@linaro.org,
 fam@euphon.net
References: <1580142994-1836-1-git-send-email-liam.merwick@oracle.com>
 <1580142994-1836-7-git-send-email-liam.merwick@oracle.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <33e03e74-e579-c0e8-e1fc-bd408aeb32e8@redhat.com>
Date: Fri, 31 Jan 2020 00:57:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1580142994-1836-7-git-send-email-liam.merwick@oracle.com>
Content-Language: en-US
X-MC-Unique: TT5-GiVAMJCSOnhE7GxABw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, wainersm@redhat.com,
 slp@redhat.com, sgarzare@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/27/20 5:36 PM, Liam Merwick wrote:
> Add tests to boot an uncompressed kernel using the x86/HVM direct boot ABI.
> The vmlinux binary is obtained from a small RPM for Kata containers and
> extracted using the new extract_from_rpm() method.
> 
> Signed-off-by: Liam Merwick <liam.merwick@oracle.com>
> ---
>   tests/acceptance/boot_linux_console.py | 49 +++++++++++++++++++++++++++++-----
>   1 file changed, 43 insertions(+), 6 deletions(-)
> 
> diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
> index 6af19ae3b14a..ab2200aa0e47 100644
> --- a/tests/acceptance/boot_linux_console.py
> +++ b/tests/acceptance/boot_linux_console.py
> @@ -65,15 +65,26 @@ class BootLinuxConsole(Test):
>           os.chdir(cwd)
>           return self.workdir + '/' + path
>   
> -    def do_test_x86_64_machine(self):
> +    def do_test_x86_64_machine(self, pvh=False):
>           """
>           :avocado: tags=arch:x86_64
>           """
> -        kernel_url = ('https://archives.fedoraproject.org/pub/archive/fedora'
> -                      '/linux/releases/29/Everything/x86_64/os/images/pxeboot'
> -                      '/vmlinuz')
> -        kernel_hash = '23bebd2680757891cf7adedb033532163a792495'
> -        kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
> +        if pvh:
> +            rpm_url = ('https://yum.oracle.com/repo/OracleLinux/'
> +                       'OL7/olcne/x86_64/getPackage/'
> +                       'kernel-uek-container-4.14.35-1902.6.6.1.el7.x86_64.rpm')
> +            rpm_hash = '4c781711a9d32dcb8e81da2b397cb98926744e23'
> +            rpm_path = self.fetch_asset(rpm_url, asset_hash=rpm_hash)
> +            kernel_path = self.extract_from_rpm(rpm_path,
> +                                                './usr/share/kata-containers/'
> +                                    'vmlinux-4.14.35-1902.6.6.1.el7.container')
> +        else:
> +            kernel_url = ('https://archives.fedoraproject.org/pub/archive/'
> +                          'fedora/linux/releases/29/Everything/x86_64/os/'
> +                          'images/pxeboot/vmlinuz')
> +            kernel_hash = '23bebd2680757891cf7adedb033532163a792495'
> +            kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
> +

Can you try using a dictionaries instead? This way we can add more 
images easily.
See IMAGE_INFO in tests/acceptance/linux_ssh_mips_malta.py.

>           self.vm.set_console()
>           kernel_command_line = self.KERNEL_COMMON_COMMAND_LINE + 'console=ttyS0'
>           self.vm.add_args('-kernel', kernel_path,
> @@ -95,6 +106,19 @@ class BootLinuxConsole(Test):
>           self.vm.add_args('-bios', 'pc-bios/bios-microvm.bin')
>           self.do_test_x86_64_machine()
>   
> +    def test_x86_64_pc_pvh(self):
> +        """
> +        :avocado: tags=machine:pc
> +        """
> +        self.do_test_x86_64_machine(pvh=True)
> +
> +    def test_x86_64_pc_qboot_pvh(self):
> +        """
> +        :avocado: tags=machine:pc
> +        """
> +        self.vm.add_args('-bios', 'pc-bios/bios-microvm.bin')
> +        self.do_test_x86_64_machine(pvh=True)
> +
>       def test_x86_64_microvm(self):
>           """
>           :avocado: tags=machine:microvm
> @@ -108,6 +132,19 @@ class BootLinuxConsole(Test):
>           self.vm.add_args('-bios', 'pc-bios/bios-microvm.bin')
>           self.do_test_x86_64_machine()
>   
> +    def test_x86_64_microvm_pvh(self):
> +        """
> +        :avocado: tags=machine:microvm
> +        """
> +        self.do_test_x86_64_machine(pvh=True)
> +
> +    def test_x86_64_microvm_qboot_pvh(self):
> +        """
> +        :avocado: tags=machine:microvm
> +        """
> +        self.vm.add_args('-bios', 'pc-bios/bios-microvm.bin')
> +        self.do_test_x86_64_machine(pvh=True)
> +
>       def test_mips_malta(self):
>           """
>           :avocado: tags=arch:mips
> 


