Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41413C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 12:55:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0249C20768
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 12:55:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FVks82g+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0249C20768
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40754 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyalK-0002F5-B4
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 08:55:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41722)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jyajV-0007LC-2d
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 08:53:57 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:46203)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jyajT-0007af-K8
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 08:53:56 -0400
Received: by mail-wr1-x441.google.com with SMTP id r12so5022984wrj.13
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2020 05:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=OyNgxJ50Mbz20a2McPY52u92q0z/Kp++oRFPUqQdW44=;
 b=FVks82g+Ai+uo2HpS4wyVleExb7FjdxYHpAibJNtjm4KqFgh4tf5hp45fBJCMpPBTk
 0BXa0nbv90tAyltYjMQKjVnxBRoSLwMo5ofJdcnoh9CT7okmT9z7V8aBX4WjjVLT5Sam
 zQASBCkhSG5SvFKc3AnDLH7bStGMhND1LVqNhej7DMsBvgDcmhWq7UiC9Q4d6QT54bWC
 PsCxg/kiwXoV0C/66+sGeAJxBnFcjnyZPNVJIK92NMQtPWyRxC1k894buZbp/FqySReH
 oz+cSFTGmMkymnuj94j7YOLh8gbcR8osk1tbwEoktrB9ohRgfIImlf4a528XOFzMocZU
 bVXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=OyNgxJ50Mbz20a2McPY52u92q0z/Kp++oRFPUqQdW44=;
 b=lTmBTJ9KNerie8gsZNjudUxbFO57YIMh27AxNe1czkKZGcgn4CWv9zjmo2IFuPtCdq
 c9QWY39sIoDOYSjqI3oPS3uoxaEbjIq05E1zmPex99bRIwGJ9XJArLQxlU1M+ltH8lW4
 htIi+CyAFSvxBjOXLjIuv8DB4axZpcnrr7KJlYjZC+SsyTw82vh5UtgqzQv6vYutaj4+
 I6qGyPupEKNfyBvVtLkTeqEUqW7qG258YLL6LsN0qbj25Ra2AI1sbCXndlAgcXf7EAuk
 Q1mpI1o+fZmNPjuLDsaNu2pEGfC3N+vGev8k/b3ZY0vMaz/N80JqU1raPZLwVwFGhi8/
 LWpw==
X-Gm-Message-State: AOAM532RLU6wxSAjXAwFtc4agHdYFtG+Wa2Qb4AFxopcio24fs11iLVZ
 I77D3ac73GUYjbORzHsvSsQJic9INCM=
X-Google-Smtp-Source: ABdhPJw/2c1HBpxVC4AQBS8Fm9/14SFfiUzTdMi2RtrWeBOioqrtLGZAjUcK34dfObh2+XdzN61XOA==
X-Received: by 2002:adf:9463:: with SMTP id 90mr3872324wrq.223.1595508834040; 
 Thu, 23 Jul 2020 05:53:54 -0700 (PDT)
Received: from [192.168.1.36] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id t2sm3231290wma.43.2020.07.23.05.53.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Jul 2020 05:53:53 -0700 (PDT)
Subject: Re: [PATCH 3/4] tests/acceptance: Disable the rx sash and arm
 cubieboard replay test on Gitlab
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20200723122800.723-1-thuth@redhat.com>
 <20200723122800.723-4-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <a78f13d8-5f81-43ae-f497-90f86f60f0bc@amsat.org>
Date: Thu, 23 Jul 2020 14:53:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200723122800.723-4-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Fam Zheng <fam@euphon.net>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/23/20 2:27 PM, Thomas Huth wrote:
> These tests always time out on Gitlab, not sure what's happening here.
> Let's disable them until somebody has enough spare time to debug the
> issues.

Is the Avocado cache working? Is it failing with an empty cache?
If so, maybe we need to run avocado cache fetching in a previous
step, before the testing job.

Can you share a url of failed job so I can have a look?

> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  tests/acceptance/machine_rx_gdbsim.py | 4 ++++
>  tests/acceptance/replay_kernel.py     | 1 +
>  2 files changed, 5 insertions(+)
> 
> diff --git a/tests/acceptance/machine_rx_gdbsim.py b/tests/acceptance/machine_rx_gdbsim.py
> index bff63e421d..0c72506028 100644
> --- a/tests/acceptance/machine_rx_gdbsim.py
> +++ b/tests/acceptance/machine_rx_gdbsim.py
> @@ -8,6 +8,9 @@
>  # This work is licensed under the terms of the GNU GPL, version 2 or
>  # later.  See the COPYING file in the top-level directory.
>  
> +import os
> +
> +from avocado import skipIf
>  from avocado_qemu import Test
>  from avocado_qemu import exec_command_and_wait_for_pattern
>  from avocado_qemu import wait_for_console_pattern
> @@ -42,6 +45,7 @@ class RxGdbSimMachine(Test):
>          # FIXME limit baudrate on chardev, else we type too fast
>          #exec_command_and_wait_for_pattern(self, 'version', gcc_version)
>  
> +    @skipIf(os.getenv('GITLAB_CI'), 'Running on GitLab')
>      def test_linux_sash(self):
>          """
>          Boots a Linux kernel and checks that the console is operational.
> diff --git a/tests/acceptance/replay_kernel.py b/tests/acceptance/replay_kernel.py
> index 62d2db8c64..b79fc8daf8 100644
> --- a/tests/acceptance/replay_kernel.py
> +++ b/tests/acceptance/replay_kernel.py
> @@ -126,6 +126,7 @@ class ReplayKernel(LinuxKernelTest):
>  
>          self.run_rr(kernel_path, kernel_command_line, console_pattern, shift=1)
>  
> +    @skipIf(os.getenv('GITLAB_CI'), 'Running on GitLab')
>      def test_arm_cubieboard_initrd(self):
>          """
>          :avocado: tags=arch:arm
> 


