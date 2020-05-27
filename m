Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4FA5C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 14:42:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2A52207D8
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 14:42:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JbK2vxgf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2A52207D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdxFy-0002Qu-Un
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 10:42:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42484)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jdxF8-0001Fk-MG
 for qemu-devel@nongnu.org; Wed, 27 May 2020 10:41:18 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36492
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jdxF6-0007A1-QD
 for qemu-devel@nongnu.org; Wed, 27 May 2020 10:41:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590590475;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ziVRFa1fCUKTudME/zbhIJKFHIkzzhm2Ly3uSkWWeHQ=;
 b=JbK2vxgfyk/Bt/bHnNhraKW2wRIgitmyHLhgOF1A1n1OyG18oXOKkCVU567pQVrYnyy2nX
 PTIh5sS2zKh57m6i6FzaSQnBj0xFTSqpl6kBz4S+orX0tSJpp0FdxYnh+twl7XV/k4MVu6
 BacPEHgS0BD2zyjiojEjebhqp82Enbs=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-365-PevHxrcbOciSkFeZ0hgqBg-1; Wed, 27 May 2020 10:41:13 -0400
X-MC-Unique: PevHxrcbOciSkFeZ0hgqBg-1
Received: by mail-ed1-f71.google.com with SMTP id o12so10111281edj.12
 for <qemu-devel@nongnu.org>; Wed, 27 May 2020 07:41:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=ziVRFa1fCUKTudME/zbhIJKFHIkzzhm2Ly3uSkWWeHQ=;
 b=VJsdkHOQXKNwJFiCstS1IpmcaHr2lcSh8uHJO7Hc6e+GurTL+mc2RFQh0FivofIsGG
 1xqwE4p9gbkQ+9vN5uoRV6W60CXd3kVrmQvBDdgXHh8srLpFie8ud32DhaM44XhqwF4z
 E117hHPiTsgziuhTK2fBNlBZ2YskFfX2k6OPS0nUMkPjXoDqSceXDFJoGO9k5OkW+HJO
 CvJtNlnPE0niYK+Yaolc+etl+LfNnKWV+dnJedUEJuIfPvDcttXqObIL5lXpdQ5nkcUW
 Pv/jLTRFDDH8Ekjun+LZpeaE/WARRzoIREloS0Fau2mrl/1iUFLZD1MScr0hdfrPlEuU
 4ryw==
X-Gm-Message-State: AOAM530MnZlQAGocljhsAw069wLD/8w2YumCr+mNtkZuGoxud6JGy6iB
 +rtRUUyrMMCw/GEj8/u9jQir0Do+LF7vVbku568BOna0b8dlZrczFu5l/32bbt7auds0MZ9WmKu
 fp1yhZJiVRv59zsU=
X-Received: by 2002:a50:a7a5:: with SMTP id i34mr14558649edc.55.1590590472444; 
 Wed, 27 May 2020 07:41:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzUctIoF/pDUFiI9I+ofuTb3UxS22OPjtHgU1e3/yzWQWEytu4FvA8kXTcoVxKxwDpdL4UlKw==
X-Received: by 2002:a50:a7a5:: with SMTP id i34mr14558623edc.55.1590590472130; 
 Wed, 27 May 2020 07:41:12 -0700 (PDT)
Received: from [192.168.1.36] (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id s1sm3149084ejh.81.2020.05.27.07.41.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 May 2020 07:41:11 -0700 (PDT)
Subject: Re: [PATCH v2 03/11] tests/acceptance: add base class record/replay
 kernel tests
To: Pavel Dovgalyuk <Pavel.Dovgaluk@gmail.com>, qemu-devel@nongnu.org
References: <159057543840.16818.14393433996899521784.stgit@pasha-ThinkPad-X280>
 <159057545565.16818.10615781697342502198.stgit@pasha-ThinkPad-X280>
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
Message-ID: <fb6a4cdf-7d66-d0c5-78cc-e81e6fd3199e@redhat.com>
Date: Wed, 27 May 2020 16:41:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <159057545565.16818.10615781697342502198.stgit@pasha-ThinkPad-X280>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/27 01:25:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: wrampazz@redhat.com, dovgaluk@ispras.ru, pavel.dovgaluk@ispras.ru,
 crosa@redhat.com, pbonzini@redhat.com, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/27/20 12:30 PM, Pavel Dovgalyuk wrote:
> This patch adds a base for testing kernel boot recording and replaying.
> Each test has the phase of recording and phase of replaying.
> Virtual machines just boot the kernel and do not interact with
> the network.
> Structure and image links for the tests are borrowed from boot_linux_console.py
> Testing controls the message pattern at the end of the kernel
> boot for both record and replay modes. In replay mode QEMU is also
> intended to finish the execution automatically.
> 
> Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
> 
> --
> 
> v2:
>  - changed default value of args to None (suggested by Willian Rampazzo)
>  - inherited common functions from boot_linux_console (suggested by Willian Rampazzo)
> ---
>  0 files changed
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 47ef3139e6..e9a9ce4f66 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2497,6 +2497,7 @@ F: net/filter-replay.c
>  F: include/sysemu/replay.h
>  F: docs/replay.txt
>  F: stubs/replay.c
> +F: tests/acceptance/replay_kernel.py
>  
>  IOVA Tree
>  M: Peter Xu <peterx@redhat.com>
> diff --git a/tests/acceptance/replay_kernel.py b/tests/acceptance/replay_kernel.py
> new file mode 100644
> index 0000000000..b8b277ad2f
> --- /dev/null
> +++ b/tests/acceptance/replay_kernel.py
> @@ -0,0 +1,57 @@
> +# Record/replay test that boots a Linux kernel
> +#
> +# Copyright (c) 2020 ISP RAS
> +#
> +# Author:
> +#  Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
> +#
> +# This work is licensed under the terms of the GNU GPL, version 2 or
> +# later.  See the COPYING file in the top-level directory.
> +
> +import os
> +import gzip
> +
> +from avocado_qemu import wait_for_console_pattern
> +from avocado.utils import process
> +from avocado.utils import archive
> +from boot_linux_console import LinuxKernelUtils
> +
> +class ReplayKernel(LinuxKernelUtils):
> +    """
> +    Boots a Linux kernel in record mode and checks that the console
> +    is operational and the kernel command line is properly passed
> +    from QEMU to the kernel.
> +    Then replays the same scenario and verifies, that QEMU correctly
> +    terminates.
> +    """
> +
> +    timeout = 90
> +
> +    def run_vm(self, kernel_path, kernel_command_line, console_pattern,
> +               record, shift, args):
> +        vm = self.get_vm()
> +        vm.set_console()
> +        if record:
> +            mode = 'record'
> +        else:
> +            mode = 'replay'
> +        vm.add_args('-icount', 'shift=%s,rr=%s,rrfile=%s' %
> +                    (shift, mode, os.path.join(self.workdir, 'replay.bin')),

Please make replay_filename an argument, so we can add tests replaying
without having to record, and or do verification on the replay_filename
(check size, check header, run with incorrect format...).

> +                    '-kernel', kernel_path,
> +                    '-append', kernel_command_line,
> +                    '-net', 'none')
> +        if args:
> +            vm.add_args(*args)
> +        vm.launch()
> +        self.wait_for_console_pattern(console_pattern, vm)
> +        if record:
> +            vm.shutdown()
> +        else:
> +            vm.wait()
> +
> +    def run_rr(self, kernel_path, kernel_command_line, console_pattern,
> +        shift=7, args=None):
> +        self.run_vm(kernel_path, kernel_command_line, console_pattern,
> +                    True, shift, args)
> +        self.run_vm(kernel_path, kernel_command_line, console_pattern,
> +                    False, shift, args)
> 

Also please consider this snippet for logging:

-- >8 --
--- a/tests/acceptance/replay_kernel.py
+++ b/tests/acceptance/replay_kernel.py
@@ -10,6 +10,7 @@

 import os
 import gzip
+import logging

 from avocado_qemu import wait_for_console_pattern
 from avocado.utils import process
@@ -51,8 +52,11 @@ def run_vm(self, kernel_path, kernel_command_line,
console_pattern,

     def run_rr(self, kernel_path, kernel_command_line, console_pattern,
         shift=7, args=None):
+        logger = logging.getLogger('replay')
+        logger.info('recording...')
         self.run_vm(kernel_path, kernel_command_line, console_pattern,
                     True, shift, args)
+        logger.info('replaying...')
         self.run_vm(kernel_path, kernel_command_line, console_pattern,
                     False, shift, args)
---

Then you can use the logger using:

avocado --show=app,replay run -t machine:vexpress-a9 \
  tests/acceptance/replay_kernel.py

Ideally I'd like to see timestamp (Avocado surely provide the option)
and record.bin size between.


