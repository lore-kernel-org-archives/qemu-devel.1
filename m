Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A1A3C4332D
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 09:37:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5433720663
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 09:37:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NJgdo7Qw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5433720663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35404 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jErcF-00062P-Fv
	for qemu-devel@archiver.kernel.org; Thu, 19 Mar 2020 05:37:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43079)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jErbY-0005P8-9P
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 05:36:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jErbW-0007Rj-EF
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 05:36:43 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:30894)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jErbW-0007RN-5K
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 05:36:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584610600;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nvaTKHUBBUCOkuOTysgUbSkVzgev+JlBQWmFD9tCe0k=;
 b=NJgdo7Qw4Gb8XgeympdxIS7G8JuKnMZ+VVKwngJVXhNDZ3mYMCqIbrE0rV42qMfZbqkrXT
 2MSTMpw5hwDOkxRJF0Lysi0EgSTNu00ADeN2+GVM14YI0LE+8bwt9s1XIP1ah0iusD50SK
 fYxHdFpV5Vwzv4iSnlGMUzgSKaE71a8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-165-kTU3F8ROOjCAJEA9mT-3Ng-1; Thu, 19 Mar 2020 05:36:39 -0400
X-MC-Unique: kTU3F8ROOjCAJEA9mT-3Ng-1
Received: by mail-wr1-f71.google.com with SMTP id q18so724643wrw.5
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2020 02:36:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=fLhqJ13NxSMk1GIKsHC/zgtQyta5gxNxjt/UqvTio1E=;
 b=magXFBE9Mda+B5f0xCuiCsS0Tqc8saKTlLPW69+xT+RNgiGAHF+uoosxBmlpbpkTdq
 tLVPjegK3McM6zsKKoKf3yxeUF+p1dBShlpVCknF0QiEsArIsGYZ9EPCCnU0A5L9bPss
 ohT+p30mnhtlQ/C2Fwgxc9fVeNhtaPNAMg+pAH2/CUWQd2pqS+yMyg9ubY0TmIeYvRbC
 LaXISoreoMSYlaby+ztJFPwTzOc++77DBhJ5vWunqUv/OF06TXRlJ+pznHza7utYPec4
 knUT0ag/OV3OEyoT7rOOhvYCbx7yeqkoz6B4yP7hy9g+FmK2WxXGAI37pkjLzc/YMJru
 lE+Q==
X-Gm-Message-State: ANhLgQ05WfUTuEd9IjIAYco9et12VBkezqAF4mrYMHEEoNFEj80xyI1u
 HEBjeWetqu+AezrJpapwzvXKyS0z3iiH4ShXg76wmkccUwVjzV0SC+SRgLpjnL76DXiVgPpft2f
 1BsH/9jcK8+IjKhM=
X-Received: by 2002:a05:6000:100f:: with SMTP id
 a15mr2409814wrx.382.1584610598013; 
 Thu, 19 Mar 2020 02:36:38 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vujQiCVjmJvvP22qT7u4GJNTq/S4WxSA9jM+zBGE9DaleNZBoFu+H8ebYzAb8K0/4YEBTYOYQ==
X-Received: by 2002:a05:6000:100f:: with SMTP id
 a15mr2409789wrx.382.1584610597835; 
 Thu, 19 Mar 2020 02:36:37 -0700 (PDT)
Received: from [192.168.178.58] ([151.21.15.43])
 by smtp.gmail.com with ESMTPSA id p16sm2243375wmc.46.2020.03.19.02.36.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Mar 2020 02:36:36 -0700 (PDT)
Subject: Re: [PATCH-for-5.0 1/2] hw/acpi/piix4: Add 'system-hotplug-support'
 property
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200318221531.22910-1-philmd@redhat.com>
 <20200318221531.22910-2-philmd@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3ac0d8f1-15d8-51d3-b40e-8975ec1353ad@redhat.com>
Date: Thu, 19 Mar 2020 10:36:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200318221531.22910-2-philmd@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Igor Mammedov <imammedo@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 18/03/20 23:15, Philippe Mathieu-Daud=C3=A9 wrote:
> The I/O ranges registered by the piix4_acpi_system_hot_add_init()
> function are not documented in the PIIX4 datasheet.
> This appears to be a PC-only feature added in commit 5e3cb5347e
> ("initialize hot add system / acpi gpe") which was then moved
> to the PIIX4 device model in commit 9d5e77a22f ("make
> qemu_system_device_hot_add piix independent")
> Add a property (default enabled, to not modify the current
> behavior) to allow machines wanting to model a simple PIIX4
> to disable this feature.

Yes, all hotplug stuff (PCI/memory/CPU) are custom additions by QEMU.

> +    DEFINE_PROP_BOOL("system-hotplug-support", PIIX4PMState,
> +                     use_acpi_system_hotplug, true),

Why not cpu-hotplug-support?

Paolo


