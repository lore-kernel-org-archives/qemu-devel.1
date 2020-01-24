Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B3EEC2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 15:46:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAA0F2072C
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 15:46:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="agPiy6Ts"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAA0F2072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iv1AL-0004Nj-2i
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 10:46:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57111)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iv19V-0003pO-Gw
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 10:45:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iv19S-0004f5-Uv
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 10:45:44 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:57517
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iv19S-0004ej-F0
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 10:45:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579880741;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ft6Js2g8r48tbCyOVcYZwWFlaXb0cqxAevi/+1+w3dI=;
 b=agPiy6TsetFFYD1QfMN29RTyvekRwUjwf5qy3I8xmFJU3WExG/YEAq13+rale/i7+WI2dQ
 qWU+JWvGbLPALuyrBCn/+yvA1aTq5bQFeorFT4VwlHHbJq00dHBAUJI/hW9JlSdxkPWdjw
 HXrCFpTDKmySCnSLbrcGTBIpH0P6hv8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-244-Bxlvy91nPB-LEHQiD0k-gw-1; Fri, 24 Jan 2020 10:45:39 -0500
Received: by mail-wr1-f69.google.com with SMTP id z10so1503577wrt.21
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2020 07:45:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Ft6Js2g8r48tbCyOVcYZwWFlaXb0cqxAevi/+1+w3dI=;
 b=lhPuwmkttwstyyOPh3Ww+0D7SN1cJX+NapxmNV1b6cceaDSkvdDVpFdZWfmQtYWtYJ
 YPXX2nlN/kNzcJGztL0LK5+OlAD96OB4ou/HP+4cJsiRnOkALhYtMLmtmPbwLqUbz+I8
 8vM+DCmKGDEBXpJcevEaOiTX7ino4XIF+ocO/HSXVrhvr3+WN28dbGt7LVAJDvdrHsz5
 jFoOMugqpi3vzLNREpTNqyZ63WSuy9iwKqtgA8DC92GJp9a+pjLNVbyz/gSFp8t7ZdZv
 BLICOvmo/BHunu346Lo8/3MVh1dLvD1ubp5c/0en5dfcFTK6kymOp5ix+auoh/Gv4IPr
 rxYQ==
X-Gm-Message-State: APjAAAV+60xtdzNoPmEyo2CAgcPZzARsfKcCdrGj7HujD41TPyoZLRTF
 V70WD6UeRbkHphlt45XCGy+yPneqIzRdcYwqvFWMP2Jq3bQg4KDbVsRekQaovh9UcPWiX3tGhof
 He5i9uwTtBQHinnE=
X-Received: by 2002:adf:e6c5:: with SMTP id y5mr5356017wrm.210.1579880737862; 
 Fri, 24 Jan 2020 07:45:37 -0800 (PST)
X-Google-Smtp-Source: APXvYqw8E+bOB8enthnxzpbWR/rKmpgxCmZH1uNOPahdEE8uDe2p7akV4Ebs8ZPwcY+7FfML0O28+g==
X-Received: by 2002:adf:e6c5:: with SMTP id y5mr5355996wrm.210.1579880737640; 
 Fri, 24 Jan 2020 07:45:37 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id i5sm8012970wrv.34.2020.01.24.07.45.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Jan 2020 07:45:37 -0800 (PST)
Subject: Re: [PATCH v3 2/4] tests/acceptance: boot_linux_console: Add boot
 Linux with kvm tests
To: Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-devel@nongnu.org, 
 crosa@redhat.com
References: <20200122012753.9846-1-wainersm@redhat.com>
 <20200122012753.9846-3-wainersm@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <75a9cd31-a978-0b31-1d6d-1b34800e13a6@redhat.com>
Date: Fri, 24 Jan 2020 16:45:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200122012753.9846-3-wainersm@redhat.com>
Content-Language: en-US
X-MC-Unique: Bxlvy91nPB-LEHQiD0k-gw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, thuth@redhat.com,
 alex.bennee@linaro.org, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/22/20 2:27 AM, Wainer dos Santos Moschetta wrote:
> Added boot Linux test cases that launch QEMU with kvm
> enabled. Likewise it was added tests for tcg.
> 
> Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
> ---
>   tests/acceptance/boot_linux_console.py | 88 ++++++++++++++++++++------
>   1 file changed, 68 insertions(+), 20 deletions(-)
> 
> diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
> index e40b84651b..a36eae630c 100644
> --- a/tests/acceptance/boot_linux_console.py
> +++ b/tests/acceptance/boot_linux_console.py
> @@ -51,11 +51,7 @@ class BootLinuxConsole(Test):
>           os.chdir(cwd)
>           return self.workdir + path
>   
> -    def test_x86_64_pc(self):
> -        """
> -        :avocado: tags=arch:x86_64
> -        :avocado: tags=machine:pc
> -        """
> +    def do_test_x86_64_pc(self):
>           kernel_url = ('https://archives.fedoraproject.org/pub/archive/fedora'
>                         '/linux/releases/29/Everything/x86_64/os/images/pxeboot'
>                         '/vmlinuz')
> @@ -70,6 +66,22 @@ class BootLinuxConsole(Test):
>           console_pattern = 'Kernel command line: %s' % kernel_command_line
>           self.wait_for_console_pattern(console_pattern)
>   
> +    def test_x86_64_pc_kvm(self):
> +        """
> +        :avocado: tags=arch:x86_64
> +        :avocado: tags=machine:pc
> +        :avocado: tags=accel:kvm
> +        """
> +        self.do_test_x86_64_pc()
> +
> +    def test_x86_64_pc_tcg(self):
> +        """
> +        :avocado: tags=arch:x86_64
> +        :avocado: tags=machine:pc
> +        :avocado: tags=accel:tcg
> +        """
> +        self.do_test_x86_64_pc()
[...]
So you want to test a binary linked with multiple accelerators.

Isn't it possible to have something clever/simpler?

    def test_x86_64_pc(self):
        """
        :avocado: tags=arch:x86_64
        :avocado: tags=machine:pc
        :avocado: tags=accel:kvm
        :avocado: tags=accel:tcg
        """
        self.do_test_x86_64_pc()

And use a mux config?

Because else we are duplicating a lot of code, and there are various 
accelerators available:

$ git grep ACCEL_CLASS_NAME
accel/qtest.c:41:#define TYPE_QTEST_ACCEL ACCEL_CLASS_NAME("qtest")
accel/tcg/tcg-all.c:46:#define TYPE_TCG_ACCEL ACCEL_CLASS_NAME("tcg")
hw/xen/xen-common.c:200:#define TYPE_XEN_ACCEL ACCEL_CLASS_NAME("xen")
include/sysemu/hvf.h:100:#define TYPE_HVF_ACCEL ACCEL_CLASS_NAME("hvf")
include/sysemu/kvm_int.h:36:#define TYPE_KVM_ACCEL ACCEL_CLASS_NAME("kvm")
target/i386/hax-all.c:1127:    .name = ACCEL_CLASS_NAME("hax"),
target/i386/whpx-all.c:1533:    .name = ACCEL_CLASS_NAME("whpx"),

And also pending:
target/i386/nvmm-all.c:   .name = ACCEL_CLASS_NAME("nvmm"),
https://www.mail-archive.com/qemu-devel@nongnu.org/msg668697.html


