Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F252C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 15:41:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6817D20776
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 15:41:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EjPllqdF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6817D20776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdyBG-00030j-KL
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 11:41:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51842)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jdyAe-0001hB-K9
 for qemu-devel@nongnu.org; Wed, 27 May 2020 11:40:44 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:55139)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jdyAb-00006H-Ot
 for qemu-devel@nongnu.org; Wed, 27 May 2020 11:40:44 -0400
Received: by mail-wm1-x342.google.com with SMTP id h4so3494292wmb.4
 for <qemu-devel@nongnu.org>; Wed, 27 May 2020 08:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=E5o6ebt2h3zUMApK2FVuSTW+9BSPEODuK0pM4vlNU5E=;
 b=EjPllqdFm7CaPp0fX1nz3W3M/46/DMirCg9MxDgLDK2n8uAFgco7VLf8KLONBRK2VD
 rH0Ei/fMpjLNSlcLEd499BtXC65dM6xz2TaFs/ZDLGAMo9OoA6tcnnl3DHz5j4XaoBdO
 aO3t/szA771lZXsGbjAfVSiP1vTmLTT7LJ06YZCEMF/7VFjU0TvcjqHwcYwE06ugoqcA
 nMALJBQm5+bB5obMMJVe6fwExn2wls1+TkRR5f4JTP5awKA+YaSD0rwaLMD8xd5LyHHr
 vXxjMJojW+Wqkl1ZUALbDqPm6bjdwCCAcaEcbJzAOHOq0uqQk/2i99NqRQvYB4Okpb5M
 /vQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=E5o6ebt2h3zUMApK2FVuSTW+9BSPEODuK0pM4vlNU5E=;
 b=YVOUHJYpK5Pj19Sanc4eTXi18i/fPURlH2SAO/6hMoVYZ3i2/aP2PJHZ5E34oHl8Nb
 6nrAb5gFRRDyvgfTVIDxkTb2uHb4PQo3uaGtEGj8sWCA0/3aNmjNXmZZ2Qe2HU7j4Kum
 aufHrzZi9GpTzInMF+fMHTvt9o0r07nhq9jtJH3Z7tybqvU4W4H4MNeu79Y0aGQFykB7
 7SZbebtBahwytfA/qHMdRL81hW5B4UeMqbQB5aeeQzM1smFXf9IVftHa3KBuOZQrRDZf
 nrk2a1a2SGeOEKG0cSG24r6l41gCgGh4fBUzE0YWKD5Yk8YOPCPkcWUz9Ivqv6Qr1BE/
 GWyA==
X-Gm-Message-State: AOAM532QES1jF0Bmn93F4t8enIQPlxk05kLPC9DujZ5LJH6PAdYGIEcW
 7fGwFdhye76KRFRY9REwptsAdQ==
X-Google-Smtp-Source: ABdhPJzF4UywOxw/hS7nlx1zxzfWpT0HfVo6i+3ywLCuBQMUU0wpTESTs8jwMstl2/OpKcN9vlf2LA==
X-Received: by 2002:a1c:230a:: with SMTP id j10mr4802547wmj.124.1590594040067; 
 Wed, 27 May 2020 08:40:40 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id o15sm2934569wmh.35.2020.05.27.08.40.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2020 08:40:38 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E7EFF1FF7E;
 Wed, 27 May 2020 16:40:37 +0100 (BST)
References: <159057543840.16818.14393433996899521784.stgit@pasha-ThinkPad-X280>
 <159057546117.16818.15607496040935344350.stgit@pasha-ThinkPad-X280>
User-agent: mu4e 1.5.1; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pavel Dovgalyuk <Pavel.Dovgaluk@gmail.com>
Subject: Re: [PATCH v2 04/11] tests/acceptance: add kernel record/replay
 test for x86_64
In-reply-to: <159057546117.16818.15607496040935344350.stgit@pasha-ThinkPad-X280>
Date: Wed, 27 May 2020 16:40:37 +0100
Message-ID: <87v9kh5qtm.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: wrampazz@redhat.com, qemu-devel@nongnu.org, dovgaluk@ispras.ru,
 pavel.dovgaluk@ispras.ru, crosa@redhat.com, pbonzini@redhat.com,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Pavel Dovgalyuk <Pavel.Dovgaluk@gmail.com> writes:

> This patch adds a test for record/replay an execution of x86_64 machine.
> Execution scenario includes simple kernel boot, which allows testing
> basic hardware interaction in RR mode.
>
> Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
> ---
>  0 files changed
>
> diff --git a/tests/acceptance/replay_kernel.py b/tests/acceptance/replay_=
kernel.py
> index b8b277ad2f..c7526f1aba 100644
> --- a/tests/acceptance/replay_kernel.py
> +++ b/tests/acceptance/replay_kernel.py
> @@ -55,3 +55,19 @@ class ReplayKernel(LinuxKernelUtils):
>                      True, shift, args)
>          self.run_vm(kernel_path, kernel_command_line, console_pattern,
>                      False, shift, args)
> +
> +    def test_x86_64_pc(self):
> +        """
> +        :avocado: tags=3Darch:x86_64
> +        :avocado: tags=3Dmachine:pc
> +        """
> +        kernel_url =3D ('https://archives.fedoraproject.org/pub/archive/=
fedora'
> +                      '/linux/releases/29/Everything/x86_64/os/images/px=
eboot'
> +                      '/vmlinuz')
> +        kernel_hash =3D '23bebd2680757891cf7adedb033532163a792495'
> +        kernel_path =3D self.fetch_asset(kernel_url, asset_hash=3Dkernel=
_hash)
> +
> +        kernel_command_line =3D self.KERNEL_COMMON_COMMAND_LINE +
> 'console=3DttyS0'

I note that:

  KERNEL_COMMON_COMMAND_LINE =3D 'printk.time=3D0 '

and given we are looking for repeatability here maybe we should use our
own command line so we can compare the recorded and replayed boot?

> +        console_pattern =3D 'Kernel command line: %s' % kernel_command_l=
ine
> +
> +        self.run_rr(kernel_path, kernel_command_line,
> console_pattern)

--=20
Alex Benn=C3=A9e

