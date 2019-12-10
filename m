Return-Path: <SRS0=2P1T=2A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00747C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 11:17:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF35320726
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 11:17:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VUglSBoT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF35320726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iedWH-0006jQ-QQ
	for qemu-devel@archiver.kernel.org; Tue, 10 Dec 2019 06:17:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55424)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iedVY-0006J6-4E
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 06:16:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iedVW-0001o2-W9
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 06:16:48 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35377
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iedVW-0001ns-S8
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 06:16:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575976606;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JOQmc2e6sBlnB4Wve06oJXdUGtOMK3MPY7atrnV51RA=;
 b=VUglSBoTeSb+kDisKRnmDVkoU4tNrgbL3LihnZxd9vNTqfbhACGdAF+wKPl76P9fEPyzc1
 VuAM1KY1ei8LvHCjWkj9fi35USwxLFVBNgz4R/bGEAnqahdHcJbh09ZRy2uWLQu/8SFL/P
 URC8QPTw4y+fvo4I6/7uzYkf5ZqWzB4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-350-7PIirCXpONOVH9dSQE5vKg-1; Tue, 10 Dec 2019 06:16:45 -0500
Received: by mail-wm1-f69.google.com with SMTP id o135so509034wme.2
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2019 03:16:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=JOQmc2e6sBlnB4Wve06oJXdUGtOMK3MPY7atrnV51RA=;
 b=N/xy2408dhSngS3idaCkVyT+h+akxGAOuurM0eMprFxPY0MXMFe0WV0/V9pB/1eiby
 AdFLOdZ0ZVsPx+Tc9B9kfA9PmraNi5/245caf8xEIh4o62HbHylDajUe3nlaJY8cUcKX
 astPQfxHNKU1eJ/zjWVVbLe/QTDdqHyrnPmTknwhQqcy7ICzFEFZcmaLVxzpeDU7HhV5
 R+o643U1JtYvz5IRhs5jsLtE5qw91TAaF2/jEQqMsZ4KTi2zS1v31TuGXfLowsumbTsq
 AAy+jMUc9/TNjq2d6+40zqS5s5MSYaj9/dVSgy8bjwE7yPPiiKY/2FalkMC9V/oi4Qrw
 hjCQ==
X-Gm-Message-State: APjAAAVJx+l8QxZlsQjQek3NEM8N+HHS2rtcaCZmfpRUEJzU1aEyCTeA
 d0yZPvL+MzhJJpJKX48GMqKZDYtAoyWtxCLNEQkUuf/gGzh7APoILzsP4U7rCFgv5cCwUHqdLyC
 FEPoNE83q9O4RK6A=
X-Received: by 2002:a05:600c:2283:: with SMTP id
 3mr4675026wmf.100.1575976603775; 
 Tue, 10 Dec 2019 03:16:43 -0800 (PST)
X-Google-Smtp-Source: APXvYqxhCULSqy8h7yq9ZzPgZE6PWBhLLxIeqn+Ny+46+CJvRRz9YQofOJshjDwMavyhGlF+wVZGjA==
X-Received: by 2002:a05:600c:2283:: with SMTP id
 3mr4674996wmf.100.1575976603522; 
 Tue, 10 Dec 2019 03:16:43 -0800 (PST)
Received: from [192.168.1.35] (182.red-88-21-103.staticip.rima-tde.net.
 [88.21.103.182])
 by smtp.gmail.com with ESMTPSA id p9sm2707849wmg.45.2019.12.10.03.16.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Dec 2019 03:16:43 -0800 (PST)
Subject: Re: [PATCH 1/2] tests/acceptance: Add PVH boot test
To: Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-devel@nongnu.org, 
 crosa@redhat.com
References: <20191206140012.15517-1-wainersm@redhat.com>
 <20191206140012.15517-2-wainersm@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <3a53263f-944e-9d5d-4360-96a77212f999@redhat.com>
Date: Tue, 10 Dec 2019 12:16:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191206140012.15517-2-wainersm@redhat.com>
Content-Language: en-US
X-MC-Unique: 7PIirCXpONOVH9dSQE5vKg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: fam@euphon.net, alex.bennee@linaro.org, wrampazz@redhat.com,
 sgarzare@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/6/19 3:00 PM, Wainer dos Santos Moschetta wrote:
> QEMU 4.0 onward is able to boot an uncompressed kernel
> image by using the x86/HVM direct boot ABI. It needs
> Linux >= 4.21 built with CONFIG_PVH=y.
> 
> This introduces an acceptance test which checks an
> uncompressed Linux kernel image boots properly.
> 
> Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
> ---
>   tests/acceptance/pvh.py | 48 +++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 48 insertions(+)
>   create mode 100644 tests/acceptance/pvh.py
> 
> diff --git a/tests/acceptance/pvh.py b/tests/acceptance/pvh.py
> new file mode 100644
> index 0000000000..c68489c273
> --- /dev/null
> +++ b/tests/acceptance/pvh.py
> @@ -0,0 +1,48 @@
> +# Copyright (c) 2019 Red Hat, Inc.
> +#
> +# Author:
> +#  Wainer dos Santos Moschetta <wainersm@redhat.com>
> +#
> +# This work is licensed under the terms of the GNU GPL, version 2 or
> +# later.  See the COPYING file in the top-level directory.
> +
> +"""
> +x86/HVM direct boot acceptance tests.
> +"""
> +
> +from avocado.utils.kernel import KernelBuild
> +from avocado_qemu import Test
> +from avocado_qemu import wait_for_console_pattern
> +
> +
> +class Pvh(Test):
> +    """
> +    Test suite for x86/HVM direct boot feature.
> +
> +    :avocado: tags=slow,arch=x86_64,machine=q35

Why is it slow? Because of the time spent to build the kernel?

This should be split in "prepare test" (here: slow) VS "run test", like 
we do when downloading assets.

> +    """
> +    def test_boot_vmlinux(self):
> +        """
> +        Boot uncompressed kernel image.
> +        """
> +        # QEMU can boot a vmlinux image for kernel >= 4.21 built
> +        # with CONFIG_PVH=y
> +        kernel_version = '5.4.1'
> +        kbuild = KernelBuild(kernel_version, work_dir=self.workdir)
> +        try:
> +            kbuild.download()
> +            kbuild.uncompress()
> +            kbuild.configure(targets=['defconfig', 'kvmconfig'],
> +                             extra_configs=['CONFIG_PVH=y'])
> +            kbuild.build()

I like this feature, but I don't think it should be default for all 
users, they might start complaining, such:
- test drained battery while using laptop on the move
- test filled $HOME

This should be configurable, like users suggested they don't want the 
"download required assets from internet" feature.

Is it possible to build this once (ideally on some CI) and add the 
result binary + SHA1 hash in the Avocado assets public repository?

So users can fetch the prebuilt image, and are free to rebuild it.

> +        except:
> +            self.cancel("Unable to build vanilla kernel %s" % kernel_version)
> +
> +        self.vm.set_machine('q35')
> +        self.vm.set_console()
> +        kernel_command_line = 'printk.time=0 console=ttyS0'
> +        self.vm.add_args('-kernel', kbuild.vmlinux,
> +                         '-append', kernel_command_line)
> +        self.vm.launch()
> +        wait_for_console_pattern(self, 'Kernel command line: %s' %
> +                                 kernel_command_line)
> 


