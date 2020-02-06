Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFAF2C2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 14:13:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C0132082E
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 14:13:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Umtz1xaf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C0132082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39772 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izhty-0004G9-Nx
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 09:13:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47529)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1izhtK-0003Sj-Bd
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 09:12:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1izhtJ-0007JD-9o
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 09:12:26 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:22108
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1izhtJ-0007Ii-5p
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 09:12:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580998344;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6CM6/tRbqTCJKbPC8rz+G53n9zzLhjNSn2Ee2fBYIVw=;
 b=Umtz1xafIv4j/R+hLJ5hn2zKtYdEn/2INN6gE5k5BNL6GHw+8KaT+oH569KjMCs3bsMhh4
 hCn4MIvgHNfKC2ApXYrQmOY+bzADfWGTCZvqTB5blQSiSeYJ97rQQltyW1ibH+cUw/XvJf
 /Nt8r433pTQ3o+pmtf2paa8anm4Xlr4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-132-6U645_9GN-SrLupicntTRw-1; Thu, 06 Feb 2020 09:12:23 -0500
Received: by mail-wr1-f70.google.com with SMTP id o6so3427626wrp.8
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2020 06:12:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=6CM6/tRbqTCJKbPC8rz+G53n9zzLhjNSn2Ee2fBYIVw=;
 b=OsWNSrJNwW5H945lalcf9K1djo2GeQSu1SKdLnDccIVj2xmD1H2TqqQzHz4UUBO1Ah
 CTqWd02x4/9ofTgkUAjLb1ERwlVtrCcA1tZZlOc5ljxB91IINa4KK8QlrnDUc/iTPGwD
 uI9KZNodfh3LMFxGYx4BpNZkeBYwg5SrHxZ6jzaMr4C48Py23dQSe9VwECPfhx9C8zKG
 RydZeZQz8TRdxW5D6NG8AVoJTKbPY0QYIZ/kJX3ZUZUPR3L89vUnhsi3cOZmmxMP/lwW
 vw5OZXdw6OmFeAQHU2EVYr+gQAOickWYOhSauBCP4dYh9jbvWLQNS/8Jv13s2bWqggsL
 ekFg==
X-Gm-Message-State: APjAAAXiBX0MgzCZ2plt2daEe4yJG/+efi242ymK+g95cbpfZWEQd1/L
 dpS3pMy8/sctfHtduThJaqXDPmtZgYcChabR7qy+rjUuCQ3KSnCx+YDFLJK7y/xDtEf//Cty00A
 UwhLx/Y2/WvE9ryU=
X-Received: by 2002:a1c:20d6:: with SMTP id g205mr4976913wmg.38.1580998341280; 
 Thu, 06 Feb 2020 06:12:21 -0800 (PST)
X-Google-Smtp-Source: APXvYqyZ8HXn4wj7OhDdGjeQdwp5gzjSEO6BnFeXmlfKCrx4ge2zn5RPTiF9yM62037rwipz0SMMjA==
X-Received: by 2002:a1c:20d6:: with SMTP id g205mr4976892wmg.38.1580998341061; 
 Thu, 06 Feb 2020 06:12:21 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id f189sm4112260wmf.16.2020.02.06.06.12.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Feb 2020 06:12:20 -0800 (PST)
Subject: Re: [PATCH v2 2/6] tests/boot_linux_console: add BIOS acceptance test
To: Liam Merwick <liam.merwick@oracle.com>, alex.bennee@linaro.org,
 fam@euphon.net, wainersm@redhat.com, Cleber Rosa <crosa@redhat.com>
References: <1580914565-19675-1-git-send-email-liam.merwick@oracle.com>
 <1580914565-19675-3-git-send-email-liam.merwick@oracle.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <e7db8848-b8fb-94ff-a229-779b532c5e18@redhat.com>
Date: Thu, 6 Feb 2020 15:12:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1580914565-19675-3-git-send-email-liam.merwick@oracle.com>
Content-Language: en-US
X-MC-Unique: 6U645_9GN-SrLupicntTRw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, slp@redhat.com,
 sgarzare@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/5/20 3:56 PM, Liam Merwick wrote:
> Add a test to use qboot with the 'pc' machine class and SeaBIOS with
> the 'microvm' machine class (since microvm uses qboot by default) by
> adding the '-bios' option via self.vm.add_args() before
> calling do_test_x86_64_machine().
> 
> Signed-off-by: Liam Merwick <liam.merwick@oracle.com>
> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>   tests/acceptance/boot_linux_console.py | 17 ++++++++++++++++-
>   1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
> index 233601b429bd..e9375590bc1c 100644
> --- a/tests/acceptance/boot_linux_console.py
> +++ b/tests/acceptance/boot_linux_console.py
> @@ -61,7 +61,6 @@ class BootLinuxConsole(Test):
>                         '/vmlinuz')
>           kernel_hash = '23bebd2680757891cf7adedb033532163a792495'
>           kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
> -
>           self.vm.set_console()
>           kernel_command_line = self.KERNEL_COMMON_COMMAND_LINE + 'console=ttyS0'
>           self.vm.add_args('-kernel', kernel_path,
> @@ -77,6 +76,14 @@ class BootLinuxConsole(Test):
>           """
>           self.do_test_x86_64_machine()
>   
> +    def test_x86_64_pc_qboot(self):
> +        """
> +        :avocado: tags=arch:x86_64
> +        :avocado: tags=machine:pc
> +        """
> +        self.vm.add_args('-bios', 'pc-bios/bios-microvm.bin')

This breaks running once QEMU is installed:

  (2/4) 
tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_x86_64_pc_qboot:
qemu: could not load PC BIOS 'pc-bios/bios-microvm.bin'
ERROR: [Errno 104] Connection reset by peer (0.08 s)

Cleber, Wainer, what path should we use?

> +        self.do_test_x86_64_machine()
> +
>       def test_x86_64_microvm(self):
>           """
>           :avocado: tags=arch:x86_64
> @@ -84,6 +91,14 @@ class BootLinuxConsole(Test):
>           """
>           self.do_test_x86_64_machine()
>   
> +    def test_x86_64_microvm_seabios(self):
> +        """
> +        :avocado: tags=arch:x86_64
> +        :avocado: tags=machine:microvm
> +        """
> +        self.vm.add_args('-bios', 'pc-bios/bios.bin')
> +        self.do_test_x86_64_machine()
> +
>       def test_mips_malta(self):
>           """
>           :avocado: tags=arch:mips
> 


