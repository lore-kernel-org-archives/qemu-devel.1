Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F376AC4727E
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 19:18:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F1F020739
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 19:18:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EmLe4Eii"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F1F020739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kO463-0003sX-6z
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 15:18:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58272)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kO43j-0002py-EL
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 15:16:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:40035)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kO43g-0001Y0-B1
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 15:16:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601579762;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i2gg3Rw2f9X8A7hw9UwBrwZrXarhfrnfTZKMV2j6fyI=;
 b=EmLe4EiitAy9ZrcW54DkTbO5VFpc5ohfEBviXhEarGC0CG6gyn9sjEV88/cpnQ+TKIcf4M
 QKWoM7a2wJAL4WYRpQeY1HeWUWGEmJj6anbBN8Ux73fH3o7KooYcXhEXq67PJavCo+p+Uj
 lAg6mmt+wUaFou+fn/35gQtkutIFztA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-492-poh2gFNBMFO8iij1xZnqkw-1; Thu, 01 Oct 2020 15:16:01 -0400
X-MC-Unique: poh2gFNBMFO8iij1xZnqkw-1
Received: by mail-wr1-f70.google.com with SMTP id 33so2421403wrk.12
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2020 12:16:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=i2gg3Rw2f9X8A7hw9UwBrwZrXarhfrnfTZKMV2j6fyI=;
 b=CNjdR6EBHBEoK9QFfC2ZPx9piU0UUgukmGR0Zl99E7l8qjcMh6zNE6EZ54qCQ4Rn6A
 S1RGgnQal2smQUdxHI12B8Uh66d/lITaNxQpCK9SEOBaMxoYYAl9yuShW/+x1UAZIQwL
 X2TLOZXynZabnbfhwvISgcgu48xP5gGM80uQ+BlgTXV+rsx2z+Ugk7wlprkvcJSVUsET
 ViBDQzWGbkJfIgjLOBE7B2JWa6yVqW6szcSHMyrzJxlB7AipL/N2RCMci5xhMdfdYBz5
 2jmg2t+qjdI32iUK2gXhV1cPNab2Kv4YJueTO8LQglrHI+MuH1wK2FwsWQXrag0A572N
 ui3w==
X-Gm-Message-State: AOAM533oJ1Yv1CEzgyr2kvLejjFY+Au/63ouApkLvAA6CM8EkEJlvHxW
 ZMk6tIhDsgwtGLNhWHFxg/hgbMBLxkHQ0J3BiGpgrmQ8xYUvE6xMFMLV8R9eVvuTifOHhV/JcQQ
 8E9zzoZ/wbGcdyHI=
X-Received: by 2002:a5d:6305:: with SMTP id i5mr10226415wru.337.1601579760036; 
 Thu, 01 Oct 2020 12:16:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyn4Hqqr82STw2mdDqS7s6OJC5o9dZPxZqsmXm754ETF0jCk6/fEX8jym7UIPg7LZ7exXtWug==
X-Received: by 2002:a5d:6305:: with SMTP id i5mr10226394wru.337.1601579759793; 
 Thu, 01 Oct 2020 12:15:59 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:11eb:3314:c22:e3c7?
 ([2001:b07:6468:f312:11eb:3314:c22:e3c7])
 by smtp.gmail.com with ESMTPSA id w2sm10174573wrs.15.2020.10.01.12.15.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Oct 2020 12:15:59 -0700 (PDT)
Subject: Re: [PULL 29/86] meson: move libudev test
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200930195850.278104-1-pbonzini@redhat.com>
 <20200930195850.278104-2-pbonzini@redhat.com>
 <CAFEAcA98nJiysUkGEUaq4OMJ815pQRTKz4TWxZFHqzzNX2r2uw@mail.gmail.com>
 <5eba8be2-0076-025a-2e21-281427b69d23@redhat.com>
 <CAFEAcA9iGZBKAyDnZmb=ieuSZvb2FkkzFqE_Ax-5TNHjY8oy5w@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <85451b4a-c07a-cf42-c058-e12c93a68b43@redhat.com>
Date: Thu, 1 Oct 2020 21:15:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9iGZBKAyDnZmb=ieuSZvb2FkkzFqE_Ax-5TNHjY8oy5w@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 02:15:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.26, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 01/10/20 20:51, Peter Maydell wrote:
> Yes, I have a lot of --disable-foo options. Ideally I wouldn't
> need any, because our configure/build system would identify "there
> isn't actually a static version of this dependency present"
> rather than blindly trusting pkg-config when it lies to us.
> (Is it possible to get Meson to just always do a "test that
> a trivial program with these cflags and libs will build" as
> part of whatever magic it does as part of dependency() ?

Unfortunately there are many special cases, including libraries that
require symbols in the executable, so its not possible to do that.  For
this reason the "static library not found for dependency" is just a warning.

We can add such a compile test ourselves.  Of course it might add to the
compile time if we do it for every dependency, but perhaps we can do one
with all the dependencies and if it fails loop on single dependencies to
give a better error.

Paolo


