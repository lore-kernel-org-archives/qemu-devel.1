Return-Path: <SRS0=UEgn=BO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BF57C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 16:10:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42AA3206D4
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 16:10:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kFB0HPJn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42AA3206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2zWF-0005S4-EB
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 12:10:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45358)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1k2zVK-000453-2u
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 12:09:30 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:33586)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1k2zVI-0005qC-6m
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 12:09:29 -0400
Received: by mail-wm1-x343.google.com with SMTP id f18so2508599wmc.0
 for <qemu-devel@nongnu.org>; Tue, 04 Aug 2020 09:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=NPaszI0hRO09gzQUK790XM8Dh34iLZrv5p/Y2wvINak=;
 b=kFB0HPJnPCGmy7JeF/blIVDtHQ8VC2suv1Vmg6ti3SdaBI8JXuvLjkyU7jMJZbcchQ
 oR4BrQmjIBA4tvpjKbWwFV8zd2pIEP/IWbiWbkFXtHkfWfQ+vAAx2/lPq8RX7AnVvm8t
 s706WxUjTrf2zD2QXAHAkJ1GMZ0VgW5d+fHxZdx29cvMuHRO6pViQRBbq3ujLa+eipdp
 LwxjENh0+Dk+CkPMAlCtqIKt/ZVFcKiVIBMB5wAn+DFDvPxGLDL19dp3CqZ9VQJjxI7x
 +z+lRU++yhNwwRBCXgw6Y57r0fhvWoqSeGTtQLSq87NNlgUVtZ/60EpAsjWhFsitQyog
 edzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=NPaszI0hRO09gzQUK790XM8Dh34iLZrv5p/Y2wvINak=;
 b=ETbJyimLRpGITphtVkjKKypfax6Gy0pah47JQbSFfsWUwbsH3hdrdN2rs09shLrMmE
 rjoBA9LIKlUVHw9i14oYuq2pLu+fcEFmGJOzkV1O4YfnGgMcVijqhJywRFuM+IdNcoXY
 gWLQ8FbizHoKb2D9BdFcAY9ADAGuWr6M0qjPLM6Srmgg6RiCenapC9HfRg9ZHMtQNXnJ
 Xb9K27fzAd7vIDaYSrWxjHWQuKPCebV2hNuMHPtbUXALKI4MNkBfAFgD4bKZn+QiLQHV
 mOXif1+DRlLaDLyTLy92c4WOazxzdaqoPXx/yo/x+XOUXWFqExsu2IiMC0af5rYtU1J/
 RI4A==
X-Gm-Message-State: AOAM532JLTz+Mo+xR8wdB6SZ8pni0/L8/Ur2/+YiXOc6OFkUEudqh2HC
 s+5Thye/lRzjW9ZjH6lAQ4b43w==
X-Google-Smtp-Source: ABdhPJxU6svNQ2TUI9XOLWQuVZBTr/JLgwyoYPSoe1IavYGF3e7XAU8lhAtiVUesBGNb6JJS/hb9Xg==
X-Received: by 2002:a7b:c05a:: with SMTP id u26mr4607476wmc.134.1596557365516; 
 Tue, 04 Aug 2020 09:09:25 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id c15sm4904814wme.23.2020.08.04.09.09.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Aug 2020 09:09:24 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 4C6171FF7E;
 Tue,  4 Aug 2020 17:09:23 +0100 (BST)
References: <20200730141326.8260-1-thuth@redhat.com>
 <20200730141326.8260-3-thuth@redhat.com>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v2 2/4] tests/acceptance: Disable the rx sash and arm
 cubieboard replay test on Gitlab
In-reply-to: <20200730141326.8260-3-thuth@redhat.com>
Date: Tue, 04 Aug 2020 17:09:23 +0100
Message-ID: <87d046mlzg.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-devel@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Cleber Rosa <crosa@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Thomas Huth <thuth@redhat.com> writes:

> These tests always time out on Gitlab, not sure what's happening here.
> Let's disable them until somebody has enough spare time to debug the
> issues.
>
> Reviewed-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
> Reviewed-by: Cleber Rosa <crosa@redhat.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  tests/acceptance/machine_rx_gdbsim.py | 4 ++++
>  tests/acceptance/replay_kernel.py     | 1 +
>  2 files changed, 5 insertions(+)
>
> diff --git a/tests/acceptance/machine_rx_gdbsim.py b/tests/acceptance/mac=
hine_rx_gdbsim.py
> index bff63e421d..0c72506028 100644
> --- a/tests/acceptance/machine_rx_gdbsim.py
> +++ b/tests/acceptance/machine_rx_gdbsim.py
> @@ -8,6 +8,9 @@
>  # This work is licensed under the terms of the GNU GPL, version 2 or
>  # later.  See the COPYING file in the top-level directory.
>=20=20
> +import os
> +
> +from avocado import skipIf
>  from avocado_qemu import Test
>  from avocado_qemu import exec_command_and_wait_for_pattern
>  from avocado_qemu import wait_for_console_pattern
> @@ -42,6 +45,7 @@ class RxGdbSimMachine(Test):
>          # FIXME limit baudrate on chardev, else we type too fast
>          #exec_command_and_wait_for_pattern(self, 'version', gcc_version)
>=20=20
> +    @skipIf(os.getenv('GITLAB_CI'), 'Running on GitLab')
>      def test_linux_sash(self):
>          """
>          Boots a Linux kernel and checks that the console is operational.
> diff --git a/tests/acceptance/replay_kernel.py b/tests/acceptance/replay_=
kernel.py
> index 62d2db8c64..b79fc8daf8 100644
> --- a/tests/acceptance/replay_kernel.py
> +++ b/tests/acceptance/replay_kernel.py
> @@ -126,6 +126,7 @@ class ReplayKernel(LinuxKernelTest):
>=20=20
>          self.run_rr(kernel_path, kernel_command_line, console_pattern, s=
hift=3D1)
>=20=20
> +    @skipIf(os.getenv('GITLAB_CI'), 'Running on GitLab')
>      def test_arm_cubieboard_initrd(self):
>          """
>          :avocado: tags=3Darch:arm


--=20
Alex Benn=C3=A9e

