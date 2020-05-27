Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28584C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 14:45:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6FC620873
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 14:45:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KcOSe5SJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6FC620873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50956 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdxIu-0005Re-28
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 10:45:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42824)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jdxI0-0004OP-VV
 for qemu-devel@nongnu.org; Wed, 27 May 2020 10:44:16 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:34860
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jdxHz-0000fP-R8
 for qemu-devel@nongnu.org; Wed, 27 May 2020 10:44:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590590654;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=bfhzntkupzY5ZPm4Qivvt4NQxfLM8G8Ia2gmJpZZqRE=;
 b=KcOSe5SJ5Hmr7yjKd/mP3AnxR6u7zJGbnNYDuHdIXBR91Z4UD2nh5+oSH00LY285rs2wlZ
 RUa8xSu8imQ2CleLxLl/EJYz1CnFx6kvKzAA1DcDnGwVns2bj4gSDR7rYIjFr2uKudtyC3
 HlDukD/GNNQPeF7BzWqdFpE7jto0xmg=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-206-kNkYE6ybPVWO24q1rDOPqQ-1; Wed, 27 May 2020 10:44:08 -0400
X-MC-Unique: kNkYE6ybPVWO24q1rDOPqQ-1
Received: by mail-ej1-f72.google.com with SMTP id qo26so9085985ejb.1
 for <qemu-devel@nongnu.org>; Wed, 27 May 2020 07:44:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=bfhzntkupzY5ZPm4Qivvt4NQxfLM8G8Ia2gmJpZZqRE=;
 b=ESZKQdFFR11QaSRzhaXDE6shhnbp4yfwcg05PBEMBQtQkrBDBJUjEVgB44+MrvtUfT
 zWBTLhO1bssHSM5Ooo3E0oPGgrPdZg/7kkyeQsfhi3aLxLykQk6JOUHmOjlee4U0O7w1
 n3bflr9qDtf3NLGiYcrC7Tv06/IzdU6PWOL7mYfUNwoLA6T6ltK7cvTSkqJtbivS4w1m
 kzlBSbeVS+qU5g/eAtlD9w6z9hTP6JIxM4ppUBJ62OBIm8OlNRyz3+2pni4q1yZhSvI0
 bKYX9PF4ywbE1EzKsPFEQEmPAMT1Eff4lUeLKuQ+u0f6xh5wbHAS5OSHCbpHBoYWD1mk
 UPxA==
X-Gm-Message-State: AOAM531VOub25T9aeQ4IsuTTnJZ3AVfSgZt2f8DbGyTk5wyxUkBenn/8
 MEdNA8zQJHKoiPcz6iN6lheETvKF76bhdlI9sXrnddBCfDUK2fy/SDy/2qWRD8rsNBtQ3ONayjR
 skE3haCXQQeyb5Tg=
X-Received: by 2002:a05:6402:177c:: with SMTP id
 da28mr23959414edb.378.1590590647075; 
 Wed, 27 May 2020 07:44:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzjvdTZ/6DK0E6VG8OW2RxbcbBDfsBmucP5q4ko8ZedLHPL70roUQ3ugGMg+gQr6JB+JbcovA==
X-Received: by 2002:a05:6402:177c:: with SMTP id
 da28mr23959395edb.378.1590590646906; 
 Wed, 27 May 2020 07:44:06 -0700 (PDT)
Received: from [192.168.1.36] (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id p10sm2970126ejn.64.2020.05.27.07.44.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 May 2020 07:44:06 -0700 (PDT)
Subject: Re: [PATCH v2 05/11] tests/acceptance: add record/replay test for
 aarch64
To: Pavel Dovgalyuk <Pavel.Dovgaluk@gmail.com>, qemu-devel@nongnu.org
References: <159057543840.16818.14393433996899521784.stgit@pasha-ThinkPad-X280>
 <159057546689.16818.17382569698039249168.stgit@pasha-ThinkPad-X280>
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
Message-ID: <41b97e99-a4b5-123f-49de-9fbad1f0821f@redhat.com>
Date: Wed, 27 May 2020 16:44:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <159057546689.16818.17382569698039249168.stgit@pasha-ThinkPad-X280>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/27 05:46:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
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
Cc: wrampazz@redhat.com, dovgaluk@ispras.ru, pavel.dovgaluk@ispras.ru,
 crosa@redhat.com, pbonzini@redhat.com, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/27/20 12:31 PM, Pavel Dovgalyuk wrote:
> This patch adds a test for record/replay of the kernel
> image boot for aarch64 platform.
> 
> Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
> ---
>  0 files changed
> 
> diff --git a/tests/acceptance/replay_kernel.py b/tests/acceptance/replay_kernel.py
> index c7526f1aba..deca69d6cb 100644
> --- a/tests/acceptance/replay_kernel.py
> +++ b/tests/acceptance/replay_kernel.py
> @@ -71,3 +71,21 @@ class ReplayKernel(LinuxKernelUtils):
>          console_pattern = 'Kernel command line: %s' % kernel_command_line
>  
>          self.run_rr(kernel_path, kernel_command_line, console_pattern)
> +
> +    def test_aarch64_virt(self):
> +        """
> +        :avocado: tags=arch:aarch64
> +        :avocado: tags=machine:virt
> +        """
> +        kernel_url = ('https://archives.fedoraproject.org/pub/archive/fedora'
> +                      '/linux/releases/29/Everything/aarch64/os/images/pxeboot'
> +                      '/vmlinuz')
> +        kernel_hash = '8c73e469fc6ea06a58dc83a628fc695b693b8493'
> +        kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
> +
> +        kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
> +                               'console=ttyAMA0')
> +        console_pattern = 'Kernel command line: %s' % kernel_command_line
> +
> +        self.run_rr(kernel_path, kernel_command_line, console_pattern,
> +            args=('-cpu', 'cortex-a53'))

I thought this would be ':avocado: tags=cpu:cortex-a53' consumed by the
base class before starting the machine, but not (yet). Still, please add
the tag (for filtering).

Thanks.



