Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79A1DC43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 11:59:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44A6F2072B
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 11:59:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a/a1g32e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44A6F2072B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53100 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihXz7-0002vJ-Ux
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 06:59:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46458)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1ihXxw-0001iO-FJ
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 06:58:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1ihXxt-0005S0-7Q
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 06:58:06 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50596
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ihXxr-0005QJ-FX
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 06:58:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576670282;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=joZh8MfyteCWb1hnymRQX7M58D4SMjM7U4JH7U3ivwA=;
 b=a/a1g32eWRacYw9bMzTMc02HkCTWASC6T6yydtha4rQla3BzqVztkSD3RhVvmudR+1TCrB
 oDlOuVZiPOsurP6CwxA+hLBkFz4+I+2L45sUSxcaUEyqk8iO+Fpkz+yfz130KBJ0vur6ud
 7FWUWrVhm10YgapdpWZ2EjqGqvIpsuc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-401-9E61iVUcMC-Vi3IOpEdyLw-1; Wed, 18 Dec 2019 06:57:59 -0500
Received: by mail-wr1-f69.google.com with SMTP id l20so778607wrc.13
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 03:57:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=joZh8MfyteCWb1hnymRQX7M58D4SMjM7U4JH7U3ivwA=;
 b=bGuG6jjW783EbAEu9S1trlUdUGEjbpgiGP3Tg3rEmFpVHivJRyHz4x8pU1B0y0e3tR
 84g/oqgFtgC/GfnYhwe2Pt6WbhwNYlvHSSpqxswz4VPq4og1cXkk/K9h7ISxm+3c8SWA
 iJJrH6/VJJz91yn8wE2Pby3t6XConkrRjcC/wNyVlGifqYthOGPZ/nXFQIfjF7eWiC2B
 meeDVMmKyZqk1oYDZcHVy4GZdF+v/41H/AokEmbt0p/hz3iezZ9BnDRKaSFDK3hBgHgA
 H5IkP9Tm0arzmyhllezs8cSBiLufjmY0VIn95T6h99CYuJU8Z0sDn08EhiwQHZYK+Y12
 fWFA==
X-Gm-Message-State: APjAAAXV/isL6tMTLDtkger57B/1eDvGKHToZTflk7PJ4dehPPb33r3O
 jHfGchrZ+u+0MXJtAMPdNWmrWXuCpkXUzaflYR/grWRoFkud+9HUG2FiwyfoZlizyEsoFhMDRlz
 tX1DY/kvaTPE6MFc=
X-Received: by 2002:a05:600c:224d:: with SMTP id
 a13mr2884865wmm.57.1576670278355; 
 Wed, 18 Dec 2019 03:57:58 -0800 (PST)
X-Google-Smtp-Source: APXvYqwgwLEfzC4dQ5dQAY330lvkmO2rwcy/OV0kotzBrBEgYi7zea/e+POCKobt4nEf5eM/FwkpNA==
X-Received: by 2002:a05:600c:224d:: with SMTP id
 a13mr2884849wmm.57.1576670278128; 
 Wed, 18 Dec 2019 03:57:58 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:ac09:bce1:1c26:264c?
 ([2001:b07:6468:f312:ac09:bce1:1c26:264c])
 by smtp.gmail.com with ESMTPSA id h8sm2438820wrx.63.2019.12.18.03.57.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Dec 2019 03:57:57 -0800 (PST)
Subject: Re: [PATCH v2 0/7] Move qtests to a separate folder
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Laurent Vivier <lvivier@redhat.com>
References: <20191218103059.11729-1-thuth@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d1739286-9142-0be9-688b-7dc999b44036@redhat.com>
Date: Wed, 18 Dec 2019 12:58:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191218103059.11729-1-thuth@redhat.com>
Content-Language: en-US
X-MC-Unique: 9E61iVUcMC-Vi3IOpEdyLw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 18/12/19 11:30, Thomas Huth wrote:
> Our "tests" directory is very overcrowded - we store the qtests,
> unit test and other files there. That makes it difficult to
> determine which file belongs to each test subsystem, and the
> wildcards in the MAINTAINERS file are inaccurate, too.
> 
> Let's clean up this mess. The first patches disentangle some
> dependencies, and the last three patches then move the qtests
> and libqos (which is a subsystem of the qtests) to a new folder
> called "tests/qtest/".
> 
> v2:
>  - Rebase to current master branch
>  - Move all tests/tpm* files to tests/qtest (since they are part
>    of the corresponding qtests)
>  - Double-checked all entries in MAINTAINERS, so they should
>    hopefully be correct now

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>


