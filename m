Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18821C2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 06:29:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2B4522277
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 06:29:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c8yGwEm1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2B4522277
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZpp4-000796-Qb
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 01:29:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52858)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kZpnF-0005Uf-Gn
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 01:27:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56414)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kZpnC-0000c0-PL
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 01:27:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604384862;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k3uNit64wra+1gEQyVBaBES7oo1xDoWHmAXkdcsfpNw=;
 b=c8yGwEm1TRBYmP4Ec3i6p5GeAS2IanXlAwWsQQ1CHs7p+ZueBqI8D3QjWOXtuBRCiJ2mMa
 2UkSXi+4EsVZXziYisaO5YfC40LOJafuxrHza/mrOtwraZ9rT8fd2ooFfnBvESOvJYBtKs
 K8KXRRL1AMms/sklDv7fO/KK92qZc1Y=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-425-CAwxFaXlOPifYVgzSXpAXQ-1; Tue, 03 Nov 2020 01:27:40 -0500
X-MC-Unique: CAwxFaXlOPifYVgzSXpAXQ-1
Received: by mail-wm1-f71.google.com with SMTP id u9so1277475wmb.2
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2020 22:27:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=k3uNit64wra+1gEQyVBaBES7oo1xDoWHmAXkdcsfpNw=;
 b=LctOqTsARxlL0RGvtCLEIFkoibzA1zW1zcQm3BGZJXrHlMkm2lEwrV+muid7dDPjaz
 8/3+AFyMjH0ARcwfoVZ0rgcgq96Rn9y8gFp3rI1jimzGcG0hezEHiAkmcR16W0TqDZmC
 IylkP/ULO3Yha/FVkKbJ59UNXRGW3Fsby5hxW0tKd5fCC0MlIdC1k66CHZjmZDIyXo5Q
 ++1nZHMDaWER0YZQhrqyn+VCgQm7YLJI6cTWAPwKm8F9J6mPMAKwFXcfvgux+/EUreVF
 segEIZ0Znw0GXnmm2T+Kn1ldBYsFp6BPxoIPXfcJV8Xlv8Y5hqZeCemKPh9WCMesdANB
 cIQw==
X-Gm-Message-State: AOAM5329030izf3M42XVXHua0+I60Okbj7ZThgvxR+vbfoJ7oAnQkrTS
 AOGgw4ClkoPtmKA3YW+mLHhMhwhRtWEW+TgXv6K3dAaKfP2BA7nE6L4ovICQoN5HqvqY9FVbYQS
 tjvkWA1PncjHQRxU=
X-Received: by 2002:adf:ef0d:: with SMTP id e13mr23999530wro.24.1604384859554; 
 Mon, 02 Nov 2020 22:27:39 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwYbCpehghVmABXxd/+Z9skk+2HT80U/QfCa9RtbnK2PNQiQTY7A+zksnU67sylHrnlynVYuA==
X-Received: by 2002:adf:ef0d:: with SMTP id e13mr23999489wro.24.1604384859314; 
 Mon, 02 Nov 2020 22:27:39 -0800 (PST)
Received: from [192.168.1.36] (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id b5sm24113137wrs.97.2020.11.02.22.27.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Nov 2020 22:27:38 -0800 (PST)
Subject: Re: [PATCH-for-5.2? 2/5] tests/acceptance: Restore MIPS Malta
 multicore tests
To: "Daniel P . Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>
References: <20201102144245.2134077-1-philmd@redhat.com>
 <20201102144245.2134077-3-philmd@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <e196ae4b-7d47-8ec3-6b04-f7cab0628547@redhat.com>
Date: Tue, 3 Nov 2020 07:27:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201102144245.2134077-3-philmd@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 00:03:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sarah Harris <S.E.Harris@kent.ac.uk>, Michael Rolnik <mrolnik@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Fabien Chouteau <chouteau@adacore.com>, Aurelien Jarno <aurelien@aurel32.net>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, qemu-ppc@nongnu.org,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Antony Pavlov <antonynpavlov@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/2/20 3:42 PM, Philippe Mathieu-Daudé wrote:
> Since 42a052333a6 ("hw/misc/mips_cpc: Start vCPU when powered on")
> the multicore support of the MIPS Malta board has been fixed.
> 
> This reverts commit 61bbce96fe4c8e3a2b7df5a67ba7dc6ba418e54b.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  tests/acceptance/machine_mips_malta.py | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/tests/acceptance/machine_mips_malta.py b/tests/acceptance/machine_mips_malta.py
> index 7c9a4ee4d2d..eea046141d6 100644
> --- a/tests/acceptance/machine_mips_malta.py
> +++ b/tests/acceptance/machine_mips_malta.py
> @@ -100,7 +100,6 @@ def test_mips_malta_i6400_framebuffer_logo_1core(self):
>          """
>          self.do_test_i6400_framebuffer_logo(1)
>  
> -    @skipIf(os.getenv('GITLAB_CI'), 'Running on GitLab')
>      def test_mips_malta_i6400_framebuffer_logo_7cores(self):
>          """
>          :avocado: tags=arch:mips64el
> @@ -110,7 +109,6 @@ def test_mips_malta_i6400_framebuffer_logo_7cores(self):
>          """
>          self.do_test_i6400_framebuffer_logo(7)
>  
> -    @skipIf(os.getenv('GITLAB_CI'), 'Running on GitLab')
>      def test_mips_malta_i6400_framebuffer_logo_8cores(self):

And this still doesn't work... :(
https://gitlab.com/philmd/qemu/-/jobs/826406235#L218


