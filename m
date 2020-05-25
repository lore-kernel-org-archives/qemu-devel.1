Return-Path: <SRS0=XKWp=7H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA6CFC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 14:33:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F9322078B
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 14:33:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FPBR6NhN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F9322078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37704 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdEAj-0007NI-RJ
	for qemu-devel@archiver.kernel.org; Mon, 25 May 2020 10:33:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49638)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jdE8g-0005Uh-Ac; Mon, 25 May 2020 10:31:38 -0400
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:41361)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jdE8f-0007yP-8O; Mon, 25 May 2020 10:31:37 -0400
Received: by mail-lj1-x241.google.com with SMTP id v16so21000541ljc.8;
 Mon, 25 May 2020 07:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=e4XS+9UCetgzP++Ff8M0j6IuSmmjc7ZWbzKdT+VXDIE=;
 b=FPBR6NhNJs6mrYNG8mUlbt1LSnlx5NxMQp7sIKlFKHDKLBVR7El4k1oI9xFy2PDbI+
 B5BQd+rgF7FQqYkovZtH+eIqkYdGGR5HUE7MUa7KIWbVYKECBoDGEumyOInrB3n4GLAn
 5RVyUTlt1NI87dJJKzvHYhPr16RUgp2J6y9cBYImydG9tjsG3vqR5rna+SugCx1zGC7U
 Kepr5zlzlVrykZvgjN8cMzQErBwprWSeTlDyaizp1WoGOQLFjnpz9ij5lobz5g31la2N
 qgm0JHB/I7+q7oBCDDFOG7L1GwX+roLYfd+vLbvNKKxvF1k6a4sdraRH0LZhLc9CgeEw
 aAkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=e4XS+9UCetgzP++Ff8M0j6IuSmmjc7ZWbzKdT+VXDIE=;
 b=JvAEYXJ5Lh/4Ctjthd70QRNA9iwYAq1Ulm02cEq6JA1KIFI8tyGjauobgzrn8Iq7eG
 koO0ARZRyD6kbJvJlHSLfvuPPJiPJjbQky4FdhCke0XmkY4Xq9UsALWqdKDmGR+mquhO
 Tdr9NCgZAaOS12l9V1+r4pUffryHBocA4NQkTjnF5dMElci4GyNqzLp/O8m0HkCZkn6q
 B1C2eoS1QDNcZzrJkM2lFUJmNGZabmCtCMvanMTRZXpjcEUH6u/mJODh7KG+SCdJKEQI
 BtLyJ7HK3GuqJfFyrt0I1GaquFB14LHPB/jhn7OEK6/FJ6+Ug542rU+CQZW+QQVDRHoy
 KZWA==
X-Gm-Message-State: AOAM531Ik/9cyntO7yiuYaszXqqNTZgDMat19gam8QCWNNhb/1V3WDWL
 F8DqDi2x1OmkGifZz9CIrdg=
X-Google-Smtp-Source: ABdhPJxMQU06ELRj1wDoAKtkpAxYP6U+0Vd88pY29NsBrAHiNHPf+tjGym737VX6HBX+iF0ORTdCWg==
X-Received: by 2002:a2e:2c0a:: with SMTP id s10mr12593568ljs.447.1590417094544; 
 Mon, 25 May 2020 07:31:34 -0700 (PDT)
Received: from localhost (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id 5sm4634405lju.87.2020.05.25.07.31.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2020 07:31:33 -0700 (PDT)
Date: Mon, 25 May 2020 16:31:32 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v2] tests/acceptance: Add a boot test for the
 xlnx-versal-virt machine
Message-ID: <20200525143132.GA8957@toto>
References: <20200525141237.15243-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200525141237.15243-1-thuth@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Received-SPF: pass client-ip=2a00:1450:4864:20::241;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lj1-x241.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>, qemu-devel@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>,
 qemu-arm@nongnu.org, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, May 25, 2020 at 04:12:37PM +0200, Thomas Huth wrote:
> As described by Edgar here:
> 
>  https://www.mail-archive.com/qemu-devel@nongnu.org/msg605124.html
> 
> we can use the Ubuntu kernel for testing the xlnx-versal-virt machine.
> So let's add a boot test for this now.

Great, thanks Thomas!

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>



> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  v2: Added "tags=device:pl011" and "tags=device:arm_gicv3"
> 
>  tests/acceptance/boot_linux_console.py | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
> index 0653c8c1bf..965272387c 100644
> --- a/tests/acceptance/boot_linux_console.py
> +++ b/tests/acceptance/boot_linux_console.py
> @@ -307,6 +307,32 @@ class BootLinuxConsole(Test):
>          console_pattern = 'Kernel command line: %s' % kernel_command_line
>          self.wait_for_console_pattern(console_pattern)
>  
> +    def test_aarch64_xlnx_versal_virt(self):
> +        """
> +        :avocado: tags=arch:aarch64
> +        :avocado: tags=machine:xlnx-versal-virt
> +        :avocado: tags=device:pl011
> +        :avocado: tags=device:arm_gicv3
> +        """
> +        kernel_url = ('http://ports.ubuntu.com/ubuntu-ports/dists/'
> +                      'bionic-updates/main/installer-arm64/current/images/'
> +                      'netboot/ubuntu-installer/arm64/linux')
> +        kernel_hash = '5bfc54cf7ed8157d93f6e5b0241e727b6dc22c50'
> +        kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
> +
> +        initrd_url = ('http://ports.ubuntu.com/ubuntu-ports/dists/'
> +                      'bionic-updates/main/installer-arm64/current/images/'
> +                      'netboot/ubuntu-installer/arm64/initrd.gz')
> +        initrd_hash = 'd385d3e88d53e2004c5d43cbe668b458a094f772'
> +        initrd_path = self.fetch_asset(initrd_url, asset_hash=initrd_hash)
> +
> +        self.vm.set_console()
> +        self.vm.add_args('-m', '2G',
> +                         '-kernel', kernel_path,
> +                         '-initrd', initrd_path)
> +        self.vm.launch()
> +        self.wait_for_console_pattern('Checked W+X mappings: passed')
> +
>      def test_arm_virt(self):
>          """
>          :avocado: tags=arch:arm
> -- 
> 2.18.1
> 

