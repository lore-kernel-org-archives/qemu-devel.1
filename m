Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09D3AC00A89
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 02:20:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9397A22243
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 02:20:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VCfyTdT7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9397A22243
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZlvw-0002mj-KP
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 21:20:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37370)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kZloE-0005fz-C8
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 21:12:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56260)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kZloC-0004DZ-QT
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 21:12:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604369545;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZLShU8l8nGVanUwnbwUmc67eR4WJS0nl6uROTb3rb2A=;
 b=VCfyTdT7VpUXQO8gk3XXxTK2LQ62bQiCy6XaYaMmz9yJAoIiPGmjMlpwjD4xsbIZAjTK8Y
 ydeu5z5GupQaHmHLMzjDZAhOXwj7RwoZjSaMNlfyhqWV563RX4uuRcA+ePRTJOQUtj2JbJ
 kHTFYeUw87By8/GColoVckz58qhvQ1c=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-257-jfEft-PrPRelOyQy4EKhBQ-1; Mon, 02 Nov 2020 21:12:21 -0500
X-MC-Unique: jfEft-PrPRelOyQy4EKhBQ-1
Received: by mail-wm1-f72.google.com with SMTP id u207so4058473wmu.4
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2020 18:12:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ZLShU8l8nGVanUwnbwUmc67eR4WJS0nl6uROTb3rb2A=;
 b=ljlrsAVW1O8puiaMJZFht3Z0t/fjx7enhssusrWWebEH7i8rk/wF2s8dl9AvloGM6k
 OnBHRRP3vtI+UJNQgOTEWwPlOUqcGryR0RdNtN04yDmv+MtDBYc+/sqJGvoWKkhVPoJL
 vWhyThDUcDWJ5VcdjoxOJH+ZUhC57pR5IjBT/E714FfDyTL6ZR1xhnEKSUd1f5XsBA1z
 nstegiHBDFPLMBZq8tpELHIMfvzdmaqNQz3rQFyZKeGcX8lGMsMTpJPjkagNYjOE5dDE
 WwNshRM/lDDrzJ1UqiSpMMrD66nwCEfb5u4fM/yzTHc3LyxvdoqvgNpnxrro7iiWHB4C
 h1qA==
X-Gm-Message-State: AOAM532geR1fnEVvD8GLgqe82diVhaCx+6svcDNhCT/R1RQ61cwOuUkW
 PbAssRLRKXwAOHKRvy24jIg1YD+wJbN9eTaK9m3y7Ji49LR/GhN4gKXChcfCIJ7wkymoMGDq50S
 8XQIxEqNrtjEKSAw=
X-Received: by 2002:a05:6000:4c:: with SMTP id
 k12mr22565725wrx.278.1604369540550; 
 Mon, 02 Nov 2020 18:12:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwQWK50gnG+2IocF2guAyCmcKwnN4cMfWYxoOaI80OcSkE9WuS0WJcYhq6/Tr6jIze+SapDcA==
X-Received: by 2002:a05:6000:4c:: with SMTP id
 k12mr22565709wrx.278.1604369540415; 
 Mon, 02 Nov 2020 18:12:20 -0800 (PST)
Received: from [192.168.1.36] (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id m14sm24233009wro.43.2020.11.02.18.12.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Nov 2020 18:12:19 -0800 (PST)
Subject: Re: [PATCH-for-5.2? 3/5] tests/acceptance: Skip incomplete
 virtio_version tests using '@skip'
To: "Daniel P . Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
References: <20201102144245.2134077-1-philmd@redhat.com>
 <20201102144245.2134077-4-philmd@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <974b193f-cf4b-832b-b963-e4a72fa14028@redhat.com>
Date: Tue, 3 Nov 2020 03:12:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201102144245.2134077-4-philmd@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/02 20:52:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
> Prefer skipping incomplete tests with the "@skip" keyword,
> rather than commenting the code.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  tests/acceptance/virtio_version.py | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/tests/acceptance/virtio_version.py b/tests/acceptance/virtio_version.py
> index 33593c29dd0..187bbfa1f42 100644
> --- a/tests/acceptance/virtio_version.py
> +++ b/tests/acceptance/virtio_version.py

And I forgot:

-- >8 --
@@ -14,6 +14,7 @@
 sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..',
'python'))
 from qemu.machine import QEMUMachine
 from avocado_qemu import Test
+from avocado import skip

 # Virtio Device IDs:
 VIRTIO_NET = 1
---

> @@ -140,17 +140,20 @@ def check_all_variants(self, qemu_devtype, virtio_devid):
>          self.assertIn('conventional-pci-device', trans_ifaces)
>          self.assertNotIn('pci-express-device', trans_ifaces)
>  
> +    @skip("virtio-blk requires 'driver' parameter")
> +    def test_conventional_devs_driver(self):
> +        self.check_all_variants('virtio-blk-pci', VIRTIO_BLOCK)
> +
> +    @skip("virtio-9p requires 'fsdev' parameter")
> +    def test_conventional_devs_fsdev(self):
> +        self.check_all_variants('virtio-9p-pci', VIRTIO_9P)
>  
>      def test_conventional_devs(self):
>          self.check_all_variants('virtio-net-pci', VIRTIO_NET)
> -        # virtio-blk requires 'driver' parameter
> -        #self.check_all_variants('virtio-blk-pci', VIRTIO_BLOCK)
>          self.check_all_variants('virtio-serial-pci', VIRTIO_CONSOLE)
>          self.check_all_variants('virtio-rng-pci', VIRTIO_RNG)
>          self.check_all_variants('virtio-balloon-pci', VIRTIO_BALLOON)
>          self.check_all_variants('virtio-scsi-pci', VIRTIO_SCSI)
> -        # virtio-9p requires 'fsdev' parameter
> -        #self.check_all_variants('virtio-9p-pci', VIRTIO_9P)
>  
>      def check_modern_only(self, qemu_devtype, virtio_devid):
>          """Check if a modern-only virtio device type behaves as expected"""
> 


