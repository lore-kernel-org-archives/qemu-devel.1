Return-Path: <SRS0=3J8r=XY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3977CC4360C
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Sep 2019 06:59:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB09420659
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Sep 2019 06:59:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IdbqH6xg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB09420659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37120 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iETAk-0000nI-3j
	for qemu-devel@archiver.kernel.org; Sun, 29 Sep 2019 02:59:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52708)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <estebanbosse@gmail.com>) id 1iET9b-0008Sb-9z
 for qemu-devel@nongnu.org; Sun, 29 Sep 2019 02:58:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <estebanbosse@gmail.com>) id 1iET9a-00019R-5A
 for qemu-devel@nongnu.org; Sun, 29 Sep 2019 02:57:59 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:35416)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <estebanbosse@gmail.com>)
 id 1iET9Z-00017x-Vk; Sun, 29 Sep 2019 02:57:58 -0400
Received: by mail-wm1-x342.google.com with SMTP id y21so9398437wmi.0;
 Sat, 28 Sep 2019 23:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=message-id:subject:from:to:cc:date:in-reply-to:references
 :user-agent:mime-version:content-transfer-encoding;
 bh=rqYk9EkDk9gyOaNdTxkh8oeo+Du3GR0cKc17NNYoo+o=;
 b=IdbqH6xgjUu5kyNbK8KULoAgMsf73GOmGLXP3Lc8oAXIC4BMpEBAkmCtGn7vjc8+UK
 y1Tm8iMjkqGwf/SP/Z8Ie3PYJtbt/5hqKIAlUswMqlpImT5xWbbdeqQYGVI4LxR5GUiw
 IIHFzO+9cAwr6QSnleyOodhODhcdWDtS0WOXTAgpZcFFbBovLqq6xO1d8SyGZRCWprWC
 3ElpXTZdX4M6gZ43tshKdf6AMhw2BJK4/iind9sQs+8QQayWvLy8gEgjuthXoe90/yK+
 qR/OwXQQSfj2VOFDTivomf4J8Qj3zUMZKcqqbb2OHJCPrFJMXg0vWcYTBxzOs8C0r0h9
 rs9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:user-agent:mime-version:content-transfer-encoding;
 bh=rqYk9EkDk9gyOaNdTxkh8oeo+Du3GR0cKc17NNYoo+o=;
 b=Oh2EWVEhsRMJLPlkos+kZIIxSIGPrPGoWwAEN3OPQFtPdFKRvaBvnklKT7XZ2QSC57
 kROQWMAYbrK/2HneHcaBJOJNSGFbqB49dnf8CPVEktpRPTqUF5knPKzYtPNjG3bcquFl
 aKNduQM4qbqm+xO1OhWcVAZjejyszkkayTCTZZkcoXBvXyVeluS03VM6Mg+XogPXqrHH
 VqzUbr1f6bNfDPvgwIrkT+8xcjq+z9wgdZKaBQy1YaQsf5PtyewCzBko7qLEOkrj54yF
 kB18frr77iYttSm2uJ7EQV6LXJFsELgyLzzIBhSh252zankK87K2x513KjbFr56rgX5C
 /D9Q==
X-Gm-Message-State: APjAAAWcpzD9VVh1M8KeK8knRq6dT8OVWJa0WwBWyXtVypPD+2QjtKXC
 6Ax+8Tv+3JoNvy8IoNx0G0U=
X-Google-Smtp-Source: APXvYqwtpXgro+5ORsdaShG72lYzaJ3cg5BOxdowfPSyW0/zecHklY37qGUytQLt5Nxv0dbPqagLug==
X-Received: by 2002:a05:600c:295b:: with SMTP id
 n27mr12831652wmd.128.1569740276225; 
 Sat, 28 Sep 2019 23:57:56 -0700 (PDT)
Received: from ?IPv6:2a01:c22:b04f:b200:7a70:bbc8:8101:45be?
 ([2a01:c22:b04f:b200:7a70:bbc8:8101:45be])
 by smtp.gmail.com with ESMTPSA id o22sm24158457wra.96.2019.09.28.23.57.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Sep 2019 23:57:55 -0700 (PDT)
Message-ID: <5232fe825315f265a9cd7f73404bc2713cbf0b04.camel@gmail.com>
Subject: Re: [PATCH 01/14] hw/arm/raspi: Use the IEC binary prefix definitions
From: Esteban Bosse <estebanbosse@gmail.com>
To: Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Peter
 Maydell <peter.maydell@linaro.org>, Andrew Baumann
 <Andrew.Baumann@microsoft.com>,  qemu-devel@nongnu.org, Pekka Enberg
 <penberg@iki.fi>,  =?ISO-8859-1?Q?Zolt=E1n?= Baldaszti <bztemail@gmail.com>
Date: Sun, 29 Sep 2019 08:57:45 +0200
In-Reply-To: <20190904171315.8354-2-f4bug@amsat.org>
References: <20190904171315.8354-1-f4bug@amsat.org>
 <20190904171315.8354-2-f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: qemu-arm@nongnu.org, Clement Deschamps <clement.deschamps@antfield.fr>,
 =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

El mié, 04-09-2019 a las 19:13 +0200, Philippe Mathieu-Daudé escribió:
> IEC binary prefixes ease code review: the unit is explicit.
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  hw/arm/raspi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
> index 74c062d05e..615d755879 100644
> --- a/hw/arm/raspi.c
> +++ b/hw/arm/raspi.c
> @@ -230,7 +230,7 @@ static void raspi2_machine_init(MachineClass *mc)
>      mc->max_cpus = BCM283X_NCPUS;
>      mc->min_cpus = BCM283X_NCPUS;
>      mc->default_cpus = BCM283X_NCPUS;
> -    mc->default_ram_size = 1024 * 1024 * 1024;
> +    mc->default_ram_size = 1 * GiB;
>      mc->ignore_memory_transaction_failures = true;
>  };
>  DEFINE_MACHINE("raspi2", raspi2_machine_init)
> @@ -252,7 +252,7 @@ static void raspi3_machine_init(MachineClass *mc)
>      mc->max_cpus = BCM283X_NCPUS;
>      mc->min_cpus = BCM283X_NCPUS;
>      mc->default_cpus = BCM283X_NCPUS;
> -    mc->default_ram_size = 1024 * 1024 * 1024;
> +    mc->default_ram_size = 1 * GiB;
>  }
>  DEFINE_MACHINE("raspi3", raspi3_machine_init)
>  #endif

Reviewed-by: Esteban Bosse <estebanbosse@gmail.com>


