Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF770C11D04
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 11:32:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADFFE2071E
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 11:32:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FUVkzQQP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADFFE2071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4k4a-0003bV-Sp
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 06:32:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41895)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1j4k3s-0003AE-N3
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 06:32:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1j4k3r-0002w5-QF
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 06:32:08 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34112
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1j4k3r-0002uq-M1
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 06:32:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582198326;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QWVB1EwMWCtwKFBhcpbo7xi/6/S5cmCGv79iOGlT5xw=;
 b=FUVkzQQPPvQRbsNppcrkXHZeSl2g462U7Icui67sjXZk3mCBEcNauNipPoP/uOa6EJCEBW
 5q0eF9Za5LLqG4+no1k1ohP0gME8cZ6OhLnRyEeBXoMbGX0/jAKxlcdWEvIuY5/NJTlv6m
 hqM705Se+6zKNKX2zPPSz4wpqhrpETs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-36-THszYAmjN_abvTjqK2grDQ-1; Thu, 20 Feb 2020 06:32:05 -0500
X-MC-Unique: THszYAmjN_abvTjqK2grDQ-1
Received: by mail-wm1-f71.google.com with SMTP id d4so498981wmd.7
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2020 03:32:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=QWVB1EwMWCtwKFBhcpbo7xi/6/S5cmCGv79iOGlT5xw=;
 b=GFYgr5B8D09eOvzTDHxcI30+ACZSPnaMlQKFz4z1OGTciRQixQUcLZm3jBw//bdHca
 Eccd6Xi1PpcwoJERBVtdiBcPOv3ep21fXW9J3ptVKXZuJsAX5Yg/SBU0BnfH8K45F5i2
 tQdpfIMhjFgzeVgM3hQmPOAsR72OlkSjM75bYTPB8jkD2gPFf5XxtwjIT0s1JC7mBgIr
 2BWSkpyffQEHudKNbRiXcLmyFk5Z30ZHhwj55I6q4SX+wk7TGOBvH+own71uLH49EaaL
 l9Kn9bi3sD6MwN/b1FPhJ7lvN0ya8bglkp1Ue9Lx6r4C40PEjlToZk8GE5v6qXY3+6fB
 rVOg==
X-Gm-Message-State: APjAAAWvrefco7yucvoOHo1QKoM+n2yw53AT0Mx5e2UIUsPwlkW79nEU
 k0bLxmxxSbVBm/hnoAeLbBhiDIjtFRNQsd9hdtFr37fQtUna0zT67NpAJSoXaPAfQmod+70YM/4
 NWmohrWsufiYBFtw=
X-Received: by 2002:a1c:3906:: with SMTP id g6mr4171979wma.49.1582198324271;
 Thu, 20 Feb 2020 03:32:04 -0800 (PST)
X-Google-Smtp-Source: APXvYqwsoI898pHRfDhuvY3JvyY0B/1bK61gq6BrS8ThT8yE8p9feUNDHNl/G1Axzr0++wyymYpNOw==
X-Received: by 2002:a1c:3906:: with SMTP id g6mr4171938wma.49.1582198324020;
 Thu, 20 Feb 2020 03:32:04 -0800 (PST)
Received: from [10.201.49.12] (nat-pool-mxp-u.redhat.com. [149.6.153.187])
 by smtp.gmail.com with ESMTPSA id a13sm4118958wrp.93.2020.02.20.03.32.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Feb 2020 03:32:03 -0800 (PST)
Subject: Re: [PATCH] Avoid cpu_physical_memory_rw() with a constant is_write
 argument
To: Peter Maydell <peter.maydell@linaro.org>, Stefan Weil <sw@weilnetz.de>
References: <20200218132023.22936-1-philmd@redhat.com>
 <87e06de3-179b-54a1-3451-39a0a30b65f0@weilnetz.de>
 <CAFEAcA9Jr2Yi1K8_9MGUJYt8C=OcKbWDh1UJjTQG1EspLux3JQ@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <86e6b3cf-f137-4980-739e-61690a9249c2@redhat.com>
Date: Thu, 20 Feb 2020 12:32:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9Jr2Yi1K8_9MGUJYt8C=OcKbWDh1UJjTQG1EspLux3JQ@mail.gmail.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Paul Durrant <paul@xen.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Anthony Perard <anthony.perard@citrix.com>,
 "open list:X86" <xen-devel@lists.xenproject.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 18/02/20 19:49, Peter Maydell wrote:
> Depending on which way we go we would either want to remove these
> casts, or not.
> 
> I guess that we have more cases of 'void*', and that would
> certainly be the easier way to convert (otherwise we probably
> need to add a bunch of new casts to uint8_t* in various callsites),
> but I don't have a strong opinion. Paolo ?

I agree we should use void* (possibly const).

Paolo


