Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47B6DC433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 06:49:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E75B206FA
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 06:49:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jRhNLp94"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E75B206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35904 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kApFd-0003J0-6f
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 02:49:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41036)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kApEe-0002qJ-Ls
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 02:48:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:31045)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kApEd-0003KH-5L
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 02:48:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598424517;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yAYJRLBbd9fZtgTJxC8UNAk72sBSSJgjNFiptB+zLJg=;
 b=jRhNLp94BIZHuka31FXI2+eWSAGLnrQgOHysLvNfvryaUWhOdJNtOMJeSuN8EvdoqeXPMU
 /9OrJJtfciC7PAyYEEYK5f+5oMpIWooRN2qVEl/76+HboHv2jurblME8bcpSfZWuEgptWd
 d6663lIX4iisYswmsBF/2SklbZQ9rXs=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-464-JrxqA-BgMuefu0Kzxlvwhw-1; Wed, 26 Aug 2020 02:48:35 -0400
X-MC-Unique: JrxqA-BgMuefu0Kzxlvwhw-1
Received: by mail-ed1-f70.google.com with SMTP id z19so309154edr.10
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2020 23:48:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=yAYJRLBbd9fZtgTJxC8UNAk72sBSSJgjNFiptB+zLJg=;
 b=FORZRx4p3laRsluTZJxBL63h05GUZSGTj2rTSuYleRIfFbvhbFerqBtbvj2Gx+XEza
 h+p1vqHhJLw9iPU45LTlh3jsCpDCHfX7bfWNXDuh28pqo+2KyowAVEtw0KGjfPT0kVBO
 BWOjtA8YiZL8OASzk3VGNkJBoX1XPm3G6Lw7H9qkd/3SI+5jEL/Zfgp7qsS5tnT8gnhq
 RsMH33seRKOHxtaZ4aKX9tEFBSmzUIgK+xe4Zc4OcwqOk/9/7ANTzteM3+d0hAgttwE1
 qicZigbCsgPMAwORG43c5BMb/MqRIigTWAIuQfj/UFdjo8T3MeNuaIlMLdRWuq6H22zH
 Elcw==
X-Gm-Message-State: AOAM533CzsSbBCsmV8246XaN8I7bETUHPP3egOCu+hvTZ6XFWyTu7k6C
 i0s5QTs52Uki5b+iymhEzniaMegdBjPCowmX0MoF/3YbcKiHaU/PjXxtTTwTQLWGrFIcRMiZs7r
 yiOpRUa7byNbQvSJyXqcFjgvvQAwtC2g=
X-Received: by 2002:a17:906:328d:: with SMTP id
 13mr14789109ejw.71.1598424513759; 
 Tue, 25 Aug 2020 23:48:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz3Jmrff56KkpXxnO2ZihS/k7IcOYp6AvjQFh2HGKXpw9e9dSXm+PNGgFzGz6aC/G/z3erScAjGM6rWcGXLjjg=
X-Received: by 2002:a17:906:328d:: with SMTP id
 13mr14789097ejw.71.1598424513559; 
 Tue, 25 Aug 2020 23:48:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200825165341.520-1-luoyonggang@gmail.com>
 <20200825165341.520-3-luoyonggang@gmail.com>
 <b4d17b13-2a11-58b4-0e5d-8ca95ec3068b@ilande.co.uk>
In-Reply-To: <b4d17b13-2a11-58b4-0e5d-8ca95ec3068b@ilande.co.uk>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 26 Aug 2020 08:48:22 +0200
Message-ID: <CABgObfZ49Y2nJCx9jOdUsDe1SPGd5NBcSVOdxf5fpnWxSU15sA@mail.gmail.com>
Subject: Re: [PATCH 3/4] meson: Mingw64 gcc doesn't recognize system
 include_type for sdl2
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/26 02:45:17
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.958,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>,
 luoyonggang@gmail.com,
 =?UTF-8?B?RGFuaWVsIFAgLiBCZXJyYW5n6IyF?= <berrange@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Aug 25, 2020 at 11:38 PM Mark Cave-Ayland
<mark.cave-ayland@ilande.co.uk> wrote:
> Marc-Andr=C3=A9 had a query about why this is marked as a system include,=
 however I can
> confirm that it fixes the missing "SDL.h" issue during build.

It was marked as a system include in an attempt to work around the SDL
2.0.8 bug that requires -Wno-undef. In general we enable lots of
warnings and sometimes they trip dependencies, so using include_type:
'system' in principle makes sense. But if it doesn't work with
Windows, it's not a regression to remove it.

Paolo


