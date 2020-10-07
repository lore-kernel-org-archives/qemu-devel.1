Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0296FC4363D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 12:24:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6996C20789
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 12:24:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IRbnyutm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6996C20789
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44166 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQ8UF-00028H-BU
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 08:24:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37572)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kQ8BO-0002PQ-L9
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 08:04:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53979)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kQ8BJ-0002XL-Qg
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 08:04:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602072269;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ANpKyxB7hmXVGI1rDwcbSfSbvlpPNoIeA5bKoXd/mlo=;
 b=IRbnyutmdIC4WpP6AC8CaAJYjBnc4g8f9h4sXf87VXlgAchzH+5p4Ef40oMEi/DonTbCgB
 +mNAMXTEXaDrOdmtyh/YGshUueZBu8Aoc0dyZgxN+4h+O2/vHKwRrgd74jdnaK2IjKQVDT
 n8LXAwdB/7SqbRHCu7R6LAVOkI+fMzk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-161--zmxzIGjO8SmCTRS9ngBPw-1; Wed, 07 Oct 2020 08:04:27 -0400
X-MC-Unique: -zmxzIGjO8SmCTRS9ngBPw-1
Received: by mail-wm1-f70.google.com with SMTP id s25so411274wmj.7
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2020 05:04:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ANpKyxB7hmXVGI1rDwcbSfSbvlpPNoIeA5bKoXd/mlo=;
 b=s7RgQuOXHqPEhBF0YYtYFj8QXmwvclSmRdkF/AJxCjOWG66WO7TIRFBKzi8F5BgYtH
 V5E0VmLTd0WJ2U+GaoYKvyDwcJnalnEpbJQAq6WHVE+bsBORFyPVd5++/Y/LIm6wEhau
 MFvlpqUxXZMDOvGo5oHSWawAQdNIaCBHTeW3sQDM1vb6oybP1fKe1qWnfU8FA2StTKlk
 PZCovNzxyzdZXngTCCuvtQX3CNq1iWdUkp+nIqEe4OhoSX+tDA39AT4d7M83cfx4HnBr
 87S7HFuATZAJ3Ggw0/uk45O6fB6uqhY9swfU5xFX5+/8bqDtJ5xfsuLgJVuD8b6Uigzl
 ShWA==
X-Gm-Message-State: AOAM530aimDP080IKuNElWQE0U7vJQT9YRR5O6O03IMdCOHjTmXouvQl
 /XQ2A/eF4iB3+6ilrZaw4mMbw6UI8FGY5ZSN974fFjVwnGfTRU8aH/BCsYwPKXijqfDrDLPA5t/
 W4P1phRyrgTu1zAQ=
X-Received: by 2002:adf:f2d0:: with SMTP id d16mr3049321wrp.332.1602072266364; 
 Wed, 07 Oct 2020 05:04:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwCu9OmnzlHdozLn01R7ao39zKoLvSiajbo9DdjcSgcF41i6s3srKg7o59huB9PY/x05GsrAw==
X-Received: by 2002:adf:f2d0:: with SMTP id d16mr3049298wrp.332.1602072266085; 
 Wed, 07 Oct 2020 05:04:26 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:d2f4:5943:190c:39ff?
 ([2001:b07:6468:f312:d2f4:5943:190c:39ff])
 by smtp.gmail.com with ESMTPSA id y14sm2331564wma.48.2020.10.07.05.04.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Oct 2020 05:04:25 -0700 (PDT)
Subject: Re: Purpose of QOM properties registered at realize time?
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
References: <20201006220647.GR7303@habkost.net>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a6e652d9-548f-4d4e-e451-48e3f5e11031@redhat.com>
Date: Wed, 7 Oct 2020 14:04:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201006220647.GR7303@habkost.net>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/07 00:54:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.742,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-riscv@nongnu.org,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 "Daniel P. Berrange" <berrange@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07/10/20 00:06, Eduardo Habkost wrote:
> Hi,
> 
> While trying to understand how QOM properties are used in QEMU, I
> stumbled upon multiple cases where alias properties are added at
> realize time.
> 
> Now, I don't understand why those properties exist.  As the
> properties are added at realize time, I assume they aren't
> supposed to be touched by the user at all.  If they are not
> supposed to be touched by the user, what exactly is the purpose
> of those QOM properties?

In the case of GPIOs, I think they will be used by other devices that
are added afterwards.

The remaining ones are:

> hw/arm/allwinner-h3.c=232=static void allwinner_h3_realize(DeviceState *dev, Error **errp)
> hw/arm/allwinner-h3.c:359:    object_property_add_alias(OBJECT(s), "sd-bus", OBJECT(&s->mmc0),
> --
> hw/arm/bcm2835_peripherals.c=128=static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
> hw/arm/bcm2835_peripherals.c:322:    object_property_add_alias(OBJECT(s), "sd-bus", OBJECT(&s->gpio), "sd-bus");
> --
> hw/arm/bcm2836.c=69=static void bcm2836_realize(DeviceState *dev, Error **errp)
> hw/arm/bcm2836.c:87:    object_property_add_alias(OBJECT(s), "sd-bus", OBJECT(&s->peripherals),
> --
> hw/arm/xlnx-zynqmp.c=276=static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
> hw/arm/xlnx-zynqmp.c:522:        object_property_add_alias(OBJECT(s), bus_name, sdhci, "sd-bus");

And this are probably usable with "bus=sd-bus" or something like that on
other devices, too.

Paolo


