Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8A00C2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 14:25:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F57521775
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 14:25:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hGjv/4Ji"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F57521775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39914 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izi63-0003mu-QF
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 09:25:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52663)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1izi5P-0003Fd-9Z
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 09:24:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1izi5N-0004Ql-S4
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 09:24:55 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27631
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1izi5N-0004O2-Nm
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 09:24:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580999093;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=InG/4xyAq0M2rdc4xvnhEfoC2oztnUlBDxC34p7VGgs=;
 b=hGjv/4JiwwyAuaYgPwZfj/zoIie3GkUQztDkVsiF/3YGjtA+GBkfiOpq5WLt75N3UiZDbY
 Ds+opTeNq5q30ZEo35RjsltNFuZzIUgFXge2cWEJaVE1XTM1F/BpFZJiKEzjh/sW79aVPf
 Bhoyas9qI0eOfcHose2TTffbBciRoXE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-251-enzO29VnMdCd4KjqMTc3hQ-1; Thu, 06 Feb 2020 09:24:46 -0500
Received: by mail-wm1-f70.google.com with SMTP id n17so51447wmk.1
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2020 06:24:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=InG/4xyAq0M2rdc4xvnhEfoC2oztnUlBDxC34p7VGgs=;
 b=ns/3eMmw+nL/Mg1K9bBGb93MF9GJsl/7MtqsXVFotGSl+hKOC9g5AqkZqG22K550Zh
 tTALvAqz+s8VNW4bGwFQMY2pYRLzXEClBfM+/9Lq5gZqsLuw0puhbXoqnEsEOkxXs7o0
 kT4rm9Ej9Su/wCj0wCbz3eXhR0pJBOD6TzVyZRvAXWJZ2zmt7zVsrDO+KW5EWSIJYF1O
 NnVUrV0laxXPjQst4QXGV6+3hDZEgSh+emEKhV7x1ra9qT26/X52bnrmyCQNlMSeDBVm
 mNMThhjgVY7lH8RZXrA7PRWmJWF38kr6Url+m2dpLE4AJ8s+VTu1IWuJY4eOzTC0LInB
 OazA==
X-Gm-Message-State: APjAAAUk7Te5XKXRuFC4gdlGR5ZIdNBQTGh1Xt1jiHR/L5esEg8CKD1Q
 +KicT/evQWYr9yqk4OG+nwAKJnFZwWryRDGVoHVhZ2E+cbKfIdj50n5xsJZhkN9zN8wy/N88jj6
 2MVUB8rNRDRi6jyU=
X-Received: by 2002:adf:f581:: with SMTP id f1mr4130011wro.264.1580999084072; 
 Thu, 06 Feb 2020 06:24:44 -0800 (PST)
X-Google-Smtp-Source: APXvYqxTYfpVaTFXs3qt17PvlvRJpiq89uUTydPmqfk4nfe0UqhPGf0mFzBwLrna3OK8qBwteOg1/Q==
X-Received: by 2002:adf:f581:: with SMTP id f1mr4129990wro.264.1580999083842; 
 Thu, 06 Feb 2020 06:24:43 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id i4sm2021253wmd.23.2020.02.06.06.24.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Feb 2020 06:24:43 -0800 (PST)
Subject: Re: [PATCH v2 5/6] tests/boot_linux_console: add PVH acceptance tests
To: Liam Merwick <liam.merwick@oracle.com>, alex.bennee@linaro.org,
 fam@euphon.net
References: <1580914565-19675-1-git-send-email-liam.merwick@oracle.com>
 <1580914565-19675-6-git-send-email-liam.merwick@oracle.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <6718b0e5-ed72-44b7-cb01-075eac06bb3e@redhat.com>
Date: Thu, 6 Feb 2020 15:24:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1580914565-19675-6-git-send-email-liam.merwick@oracle.com>
Content-Language: en-US
X-MC-Unique: enzO29VnMdCd4KjqMTc3hQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
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
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, wainersm@redhat.com,
 slp@redhat.com, sgarzare@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/5/20 3:56 PM, Liam Merwick wrote:
> Add tests to boot an uncompressed kernel using the x86/HVM direct boot ABI.
> The vmlinux binary is obtained from a small RPM for Kata containers and
> extracted using the new extract_from_rpm() method.
> 
> Signed-off-by: Liam Merwick <liam.merwick@oracle.com>
> ---
>   tests/acceptance/boot_linux_console.py | 60 ++++++++++++++++++++++++++++++----
>   1 file changed, 53 insertions(+), 7 deletions(-)
> 
> diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
> index 6a473363a122..9c55218cb5bb 100644
> --- a/tests/acceptance/boot_linux_console.py
> +++ b/tests/acceptance/boot_linux_console.py
> @@ -67,16 +67,40 @@ class BootLinuxConsole(Test):
>           os.chdir(cwd)
>           return os.path.normpath(os.path.join(self.workdir, path))
>   
> -    def do_test_x86_64_machine(self):
> +    def do_test_x86_64_machine(self, kernel_type='bzImage'):
>           """
>           Common routine to boot an x86_64 guest.
>           Caller must specify tags=arch and tags=machine
> -        """
> -        kernel_url = ('https://archives.fedoraproject.org/pub/archive/fedora'
> -                      '/linux/releases/29/Everything/x86_64/os/images/pxeboot'
> -                      '/vmlinuz')
> -        kernel_hash = '23bebd2680757891cf7adedb033532163a792495'
> -        kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
> +        :param kernel: specify kernel type to be downloaded and booted:
> +                       compressed = 'bzImage', uncompressed = 'vmlinux'
> +        """
> +
> +        KERNEL_PATH_INFO = {
> +            'bzImage': {
> +                'type': 'file',
> +                'url': 'https://archives.fedoraproject.org/'
> +                       'pub/archive/fedora/linux/releases/29/Everything/'
> +                       'x86_64/os/images/pxeboot/vmlinuz',
> +                'hash': '23bebd2680757891cf7adedb033532163a792495'
> +            },
> +            'vmlinux': {
> +                'type': 'rpm',
> +                'url': 'https://yum.oracle.com/'
> +                       'repo/OracleLinux/OL7/olcne/x86_64/getPackage/'
> +                       'kernel-uek-container-4.14.35-1902.6.6.1.el7.x86_64.rpm',
> +                'file': './usr/share/kata-containers/'
> +                        'vmlinux-4.14.35-1902.6.6.1.el7.container',
> +                'hash': '4c781711a9d32dcb8e81da2b397cb98926744e23'
> +            }
> +        }
> +
> +        k = KERNEL_PATH_INFO[kernel_type]
> +        if k['type'] is 'file':
> +            kernel_path = self.fetch_asset(k['url'], asset_hash=k['hash'])
> +        else:
> +            assert k['type'] is 'rpm'
> +            rpm_path = self.fetch_asset(k['url'], asset_hash=k['hash'])
> +            kernel_path = self.extract_from_rpm(rpm_path, k['file'])
>           self.vm.set_console()
>           kernel_command_line = self.KERNEL_COMMON_COMMAND_LINE + 'console=ttyS0'
>           self.vm.add_args('-kernel', kernel_path,
> @@ -100,6 +124,21 @@ class BootLinuxConsole(Test):
>           self.vm.add_args('-bios', 'pc-bios/bios-microvm.bin')
>           self.do_test_x86_64_machine()
>   
> +    def test_x86_64_pc_pvh(self):
> +        """
> +        :avocado: tags=arch:x86_64
> +        :avocado: tags=machine:pc
> +        """
> +        self.do_test_x86_64_machine(kernel_type='vmlinux')

This test doesn't pass with my distrib QEMU, it gets killed after using 
100% of a core during 1min30:

  (3/7) 
tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_x86_64_pc_pvh:
INTERRUPTED: Test interrupted by SIGTERM (90.32 s)

I see PVH was introduced in QEMU v4.2, so with these patches:

https://www.mail-archive.com/qemu-devel@nongnu.org/msg675077.html
https://www.mail-archive.com/qemu-devel@nongnu.org/msg675075.html

You could use:

     :avocado: tags=version-min:4.2

Do you mind reviewing them?

> +
> +    def test_x86_64_pc_qboot_pvh(self):
> +        """
> +        :avocado: tags=arch:x86_64
> +        :avocado: tags=machine:pc
> +        """
> +        self.vm.add_args('-bios', 'pc-bios/bios-microvm.bin')
> +        self.do_test_x86_64_machine(kernel_type='vmlinux')
> +
>       def test_x86_64_microvm(self):
>           """
>           :avocado: tags=arch:x86_64
> @@ -115,6 +154,13 @@ class BootLinuxConsole(Test):
>           self.vm.add_args('-bios', 'pc-bios/bios.bin')
>           self.do_test_x86_64_machine()
>   
> +    def test_x86_64_microvm_pvh(self):
> +        """
> +        :avocado: tags=arch:x86_64
> +        :avocado: tags=machine:microvm
> +        """
> +        self.do_test_x86_64_machine(kernel_type='vmlinux')
> +
>       def test_mips_malta(self):
>           """
>           :avocado: tags=arch:mips
> 


