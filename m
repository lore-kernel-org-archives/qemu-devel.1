Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2C3EC43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 08:36:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BD512080C
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 08:36:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BD512080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41555 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLOFC-0003OF-O3
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 04:36:06 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44714)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hLOE0-0002Rx-IU
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 04:34:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hLODz-0007xq-FY
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 04:34:52 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35958)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hLODz-0007xO-9A
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 04:34:51 -0400
Received: by mail-wr1-f65.google.com with SMTP id o4so8022697wra.3
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 01:34:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=QwgUtUJ3XYWzienweeDVQJWjW7OyoxRiZprCa9xXUFg=;
	b=INWnA/E5Drm9rbAwkuYQOmI4onrVZvQiT/Yked03B3ikLI2TxIyLoryLcxdPpON/rm
	pDrLhiZoYOIyJn4yGtyvftz56SG48FV51ttFH6cNJfNs6a5JExRe1Ee3uI27CaR3VKxQ
	05gNczw1tT0DZ0HVdJNDgzVoWEcq7G3+Kp23S9ehVks/RasSiSRojbQPVFlkGz5UT+Ro
	qFZMEnOnbc1XvLf6DTJgHjzaggHKPmFUwceJGqRj1qlJICnFljjbn1JDfzwuHpRuEHp1
	XaE9kY1Tw9rB2PEJ9VX3UJwQI4kzqWm+GkO6Kvm71UFEo02Xe0/B7c3udoQ7fu4Gvw9k
	wCkA==
X-Gm-Message-State: APjAAAV3/LmLPRrh/sKNI2DO08Q+WoUmDrWQ3ZfrBfb7A2NLvl2fqsht
	6s+NUKw4Z58DLJvgrnwj6+7ReA==
X-Google-Smtp-Source: APXvYqwDo43vXZFsi1bysrX2dFt64hcjYwtXY3iDGMYzIfXa6IF9ji4jltNXv/M+48I/C2yO8lbrjg==
X-Received: by 2002:a5d:698b:: with SMTP id g11mr42588747wru.65.1556613290118; 
	Tue, 30 Apr 2019 01:34:50 -0700 (PDT)
Received: from [192.168.1.33] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193]) by smtp.gmail.com with ESMTPSA id
	r8sm11646671wrg.22.2019.04.30.01.34.47
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Tue, 30 Apr 2019 01:34:49 -0700 (PDT)
To: Thomas Huth <thuth@redhat.com>, yang.zhong@intel.com,
	Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
	pbonzini@redhat.com, "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
	Alistair Francis <alistair@alistair23.me>, Paul Burton
	<pburton@wavecomp.com>, David Gibson <david@gibson.dropbear.id.au>
References: <20190430071405.16714-1-thuth@redhat.com>
	<20190430071405.16714-31-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <53e321c9-5ce9-14ef-9f55-b5ee1fa3f0e9@redhat.com>
Date: Tue, 30 Apr 2019 10:34:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190430071405.16714-31-thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] [PATCH v6 30/30] hw/arm: Remove hard-enablement of
 the remaining PCI devices
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Rob Herring <robh@kernel.org>, Philippe Mathieu-Daude <f4bug@amsat.org>,
	qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
	Andrey Smirnov <andrew.smirnov@gmail.com>,
	Andrew Jeffery <andrew@aj.id.au>, Joel Stanley <joel@jms.id.au>,
	Subbaraya Sundeep <sundeep.lkml@gmail.com>,
	Beniamino Galvani <b.galvani@gmail.com>,
	Igor Mitsyanko <i.mitsyanko@gmail.com>,
	Cedric Le Goater <clg@kaod.org>, qemu-arm@nongnu.org,
	Jan Kiszka <jan.kiszka@web.de>, Gerd Hoffmann <kraxel@redhat.com>,
	Peter Chubb <peter.chubb@nicta.com.au>,
	Jean-Christophe Dubois <jcd@tribudubois.net>, John Snow <jsnow@redhat.com>,
	Aurelien Jarno <aurelien@aurel32.net>,
	Antony Pavlov <antonynpavlov@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190430083447.S1dpO3GhlT0KZQJV6BRRaP5UP9YJy5APhHaicZa8Zns@z>

On 4/30/19 9:14 AM, Thomas Huth wrote:
> The PCI devices should be pulled in by default if PCI_DEVICES
> is set, so there is no need anymore to enforce them in the configs
> file.
> 
> Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  default-configs/arm-softmmu.mak | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
> index 233937f394..f23ecfd5c5 100644
> --- a/default-configs/arm-softmmu.mak
> +++ b/default-configs/arm-softmmu.mak
> @@ -36,14 +36,6 @@ CONFIG_DIGIC=y
>  CONFIG_SABRELITE=y
>  CONFIG_EMCRAFT_SF2=y
>  CONFIG_MICROBIT=y
> -
> -CONFIG_VGA=y

OK for this one.

> -
>  CONFIG_FSL_IMX25=y
>  CONFIG_FSL_IMX7=y
>  CONFIG_FSL_IMX6UL=y
> -
> -CONFIG_PCIE_PORT=y
> -CONFIG_XIO3130=y
> -CONFIG_IOH3420=y
> -CONFIG_I82801B11=y

Since I don't understand the extent of commit 4681867544f0, I'll let
David/Edgar/Alistair review it.

Regards,

Phil.

