Return-Path: <SRS0=9vyd=ZP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28410C432C0
	for <qemu-devel@archiver.kernel.org>; Sat, 23 Nov 2019 09:58:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0B3620714
	for <qemu-devel@archiver.kernel.org>; Sat, 23 Nov 2019 09:58:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CBKRI4Nd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0B3620714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iYSB0-0005gg-2A
	for qemu-devel@archiver.kernel.org; Sat, 23 Nov 2019 04:58:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50876)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iYSAB-0005F3-UI
 for qemu-devel@nongnu.org; Sat, 23 Nov 2019 04:57:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iYSA8-0007pW-VV
 for qemu-devel@nongnu.org; Sat, 23 Nov 2019 04:57:09 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:38130
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iYSA8-0007nz-Lq
 for qemu-devel@nongnu.org; Sat, 23 Nov 2019 04:57:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574503026;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=Rmw1BIRMgvP8cb+Z+9WPtAF/dlgEmCzaZOHBOb9Fc7o=;
 b=CBKRI4NdfX+fiFDidUR0CUm1Z/7z7WZuNZpMbzqExwJsDJ+v2x8GXb3JHEoVeEWN3MKXY7
 5+AxwAcvWF7WlmkbjXtSGDeDjqw31WJ2CW3ht1GNeq8tPQDMnSCYHuSYbW543tRrDPytEB
 bytnB4fHa/nTVjs5Uh6G9MLU903Z/80=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-181-pDwu8nqLMA-jv9QFJGZggQ-1; Sat, 23 Nov 2019 04:57:02 -0500
Received: by mail-wr1-f71.google.com with SMTP id c6so5206821wrm.18
 for <qemu-devel@nongnu.org>; Sat, 23 Nov 2019 01:57:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=i13vXjWajqVEAuEauYEE2AGbBWkm54NumRttjCNvl34=;
 b=YvSOtkEfBS6bmfZVL0i9jPe+Ze8b/v7f3BagiKBCRiEEfECfEUh2Zt7y1TbPBLlXPa
 ouqQybEbKan3n0Z4kkG0XhvlO84D5i5yBEgSFsw7Tzg5zVzyZBPmvWEU6GZzPGv7lX+8
 QbHryeI7tFMvkwK+oIY0oNSvV6pWUKdCcaau8be5kwKwqI6SyO5YUwP+/l8x8mLojYQB
 3p7czqT8mb6OWer41+8g/MTdwIYpCXmYO13iXjcvDRdwp/tl4uBFcfvTsnYQKb05f5NH
 j5gRw7LQCyP1vVOmPeM2AWWelPUVR7GcmcBeysjpvdi2WWrV8eB2wzrMRMU4CWYl35FL
 keuA==
X-Gm-Message-State: APjAAAUS+bWouSUKbdLCqs7J7N7csuNHUd1/KekGOSs0ygCx7ZqtXKhV
 8nSG8l61QAw//g9bynXpWp9f3tkHrhd0214FryKf5slOCtm2wE6XHeTLvSk3N+aX7uJ6vpUIZp/
 Km6GcyPQum8QdpWo=
X-Received: by 2002:adf:cf0a:: with SMTP id o10mr7535970wrj.340.1574503020976; 
 Sat, 23 Nov 2019 01:57:00 -0800 (PST)
X-Google-Smtp-Source: APXvYqxq1gG80eBd7XJBEMV/SMd4PWS2ijr9ihivnW/KfCuOS389PdeKAfQQJr5PoTeNyaNBWUiJIw==
X-Received: by 2002:adf:cf0a:: with SMTP id o10mr7535945wrj.340.1574503020731; 
 Sat, 23 Nov 2019 01:57:00 -0800 (PST)
Received: from [192.168.42.104] (mob-109-112-4-118.net.vodafone.it.
 [109.112.4.118])
 by smtp.gmail.com with ESMTPSA id x2sm1291785wmc.3.2019.11.23.01.56.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 23 Nov 2019 01:57:00 -0800 (PST)
Subject: Re: [RFC PATCH-for-5.0] hw/pci-host: Add Kconfig selector for IGD
 PCIe pass-through
To: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
References: <20191122172201.11456-1-philmd@redhat.com>
 <20191122103438.5cfa0570@x1.home>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <a8aefe83-86fc-b696-0cbe-20e40a07c849@redhat.com>
Date: Sat, 23 Nov 2019 10:56:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191122103438.5cfa0570@x1.home>
Content-Language: en-US
X-MC-Unique: pDwu8nqLMA-jv9QFJGZggQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Thomas Huth <thuth@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 22/11/19 18:34, Alex Williamson wrote:
> +config INTEL_IGD_PASSTHROUGH
> +    default y

If it's "default y", it need not be "implied".  It probably shouldn't be
"default y", since it's I440FX-specific.

Paolo

> +    bool
> +
>  config PREP_PCI
>      bool
>      select PCI
> @@ -32,6 +36,7 @@ config PCI_I440FX
>      bool
>      select PCI
>      select PAM
> +    imply INTEL_IGD_PASSTHROUGH
> =20


