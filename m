Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D937CA9EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 17:36:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E662D2077C
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 17:36:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FRr2bw20"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E662D2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46344 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMbbW-0005B7-PT
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 13:36:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46236)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iMbWY-0000UQ-3a
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 13:31:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iMbWW-0006ZY-Mv
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 13:31:18 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:46209)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iMbWW-0006Z8-G7
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 13:31:16 -0400
Received: by mail-pg1-x542.google.com with SMTP id e15so8194016pgu.13
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2019 10:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=C8YxFo44lgzelGc8Uh/dW4ixatwCpU/rHF3sHuxs5+0=;
 b=FRr2bw20T5D3SbsAatVsvN6ELHn/VXkEdYvF5yx/PGsY9nnAGk8IDO4Fa0aKPZlC1y
 ujQjZ/A0MwDzHpYBnp+8nJIlwcKRIVtf5uWFlpwHzmzFFknPcSvEOLnqYjCc/lg1eTBO
 1NDtGzDhrQuCEiYX/0xxM093JuWuL/ZFTIRYCJC/gWdbe0rcdTwxvhkeGPIlXv9K0Rgc
 MayeT7t5sLIWXBHELOTFVLdG2ACpAG1tr6/i+fpx2KTt9umaUB/9n1jZ5SRWcefmv0vT
 Fr3c3380lQIarO2S0UOBdpApWGgVHF9+liYhYMd6v1l/PcnHVlcPNW0Tk9awE6B/deOd
 jp7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=C8YxFo44lgzelGc8Uh/dW4ixatwCpU/rHF3sHuxs5+0=;
 b=PSn5uwXMx7ZyzFe/8kuc5sAxvQkGR/qV+Kqv3GYbi3KXvtqZR9GgXX6gT/lJJGJLBp
 mMkK+aEGsgW0vfr4q8B873YLXPU2aKy0XW6HX64FGnbVY2Ud7H9Yy31ECfVRrsJ+ORRV
 Ati7Iv6pkYdQ4JJQngdRXgQp8nhUf5h92Xkv+BRMgUVsZTo1x/O8ahl0vto+IwOIntIP
 nYhPaa/YwL3dHoPxmAiqsz3N4+hWmZUmwMWqo8q0ZGeiUN7kDlqk1AHlIx2GaK7Bt4pL
 KrL0Kn1xa33MUj7dwk3vZAA1q5Jig+NoiDEeEY3sGK4MY/wWvu6K+mpmdJOlSeBB3lV0
 d0Pg==
X-Gm-Message-State: APjAAAVmjA9VoSJq+4RqCelOmPRZYpGqJJW+vc3gbrhc+h2o66wvdO9X
 uLjbwW/zk0hRTZtyJVY3NcWu5Q==
X-Google-Smtp-Source: APXvYqxMNA0USrAZgor9he10TENDVdit9cFIDrjMpkYplBZNy70M3eN6M6Xlw3xiKNcO4Pw8zchD4w==
X-Received: by 2002:a63:fd4b:: with SMTP id m11mr26779826pgj.452.1571679075508; 
 Mon, 21 Oct 2019 10:31:15 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id k8sm13362395pgm.14.2019.10.21.10.31.13
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 21 Oct 2019 10:31:14 -0700 (PDT)
Subject: Re: [PATCH 17/21] hw/m68k: Let the machine be the owner of the system
 memory
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
References: <20191020225650.3671-1-philmd@redhat.com>
 <20191020225650.3671-18-philmd@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <8e9725f7-6076-262c-2998-9bc9b9f1f2d9@linaro.org>
Date: Mon, 21 Oct 2019 10:31:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191020225650.3671-18-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
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
Cc: Paul Burton <pburton@wavecomp.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Leif Lindholm <leif.lindholm@linaro.org>, Andrew Jeffery <andrew@aj.id.au>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Rob Herring <robh@kernel.org>,
 Peter Maydell <peter.maydell@linaro.org>, Helge Deller <deller@gmx.de>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Antony Pavlov <antonynpavlov@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Joel Stanley <joel@jms.id.au>,
 Alistair Francis <alistair@alistair23.me>,
 Fabien Chouteau <chouteau@adacore.com>,
 Beniamino Galvani <b.galvani@gmail.com>, qemu-arm@nongnu.org,
 Peter Chubb <peter.chubb@nicta.com.au>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Richard Henderson <rth@twiddle.net>,
 Radoslaw Biernacki <radoslaw.biernacki@linaro.org>,
 Thomas Huth <huth@tuxfamily.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Andrey Smirnov <andrew.smirnov@gmail.com>, Michael Walle <michael@walle.cc>,
 qemu-ppc@nongnu.org, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Jan Kiszka <jan.kiszka@web.de>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/20/19 3:56 PM, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  hw/m68k/an5206.c    | 2 +-
>  hw/m68k/mcf5208.c   | 2 +-
>  hw/m68k/next-cube.c | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

