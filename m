Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82D23C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 18:03:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FEFA20738
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 18:03:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BQqszVJV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FEFA20738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jguDN-00077f-30
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 14:03:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35356)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jguCf-0006dg-DP
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 14:02:57 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:38613
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jguCe-0001Ls-6E
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 14:02:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591293774;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0gNb87vh7KjnpMzXiimIYYJFqA9SUUytzgc5a7clbmA=;
 b=BQqszVJVEUX5duUdgPIRg5QoZ4RU6cd+nhS9x90Bg7DR5TwL6ULSrPHx+XdYQBbeCPhamX
 PWZivkokzIl/yObdEoTEGZm5tPWut5gQZeRVh6WiVdMgJI3qIkLbm0aCXUSmojtLP1K38Z
 a1OBJ/XQGpCFPNsApeMKDiI8rLjgsoc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-504-RXmuf4ppM4Gx5AyYqU37zA-1; Thu, 04 Jun 2020 14:02:50 -0400
X-MC-Unique: RXmuf4ppM4Gx5AyYqU37zA-1
Received: by mail-wm1-f70.google.com with SMTP id s15so2220047wmc.8
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2020 11:02:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=0gNb87vh7KjnpMzXiimIYYJFqA9SUUytzgc5a7clbmA=;
 b=GlclHbXAj5yiI5pct2Iql+oNCI8x2zsm2mJZck/bJUR/A6x0J58cAbl6kCess4/UNE
 xP1RSdNyFhftk1OKjujziv3WRH8+34G8jw620XoGVN5QWEgGr2K+Bj90CtA26pTZ7FiM
 S/NTJ4aVZqNexICaxTdR6GDh3sNFn9o+d9iNmx3NhoaLsp6VanrrgyDUhZm1KrvjPvyE
 YwKp+A6UqZwcRVeec8slDHTQlX1CBMeGZQAon54mMInStNQXZ2B+VTYqTW4pGImEcqSa
 +CTEMjZoifmgdDuo/BVxtTchb2deev+MpYoWl0okhdgvSjCHLoQmGFO1BFvOickF9a4n
 zHGw==
X-Gm-Message-State: AOAM530J1ZXSafcA9NI5uqnXyo8jv8M5vaFHDFmNReZvwAVbVIhjqPVs
 xieIzmKU/D6u+CGcjHv8IloDAVfMFk/LDJdY9tyxx3L+wt3MuZngICEj2r1V6t6m+eEd1WjXTJv
 4u4H4bVmm6r2F+cI=
X-Received: by 2002:a1c:9e52:: with SMTP id h79mr5126141wme.84.1591293768980; 
 Thu, 04 Jun 2020 11:02:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw2w1viHdhZccn1XZgsPyh2MtcMcI3Rfv+KCmiBCdRx5CYLvgeU9HQoXiO7vVnsR6qR5oE+Fw==
X-Received: by 2002:a1c:9e52:: with SMTP id h79mr5126124wme.84.1591293768748; 
 Thu, 04 Jun 2020 11:02:48 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:a0c0:5d2e:1d35:17bb?
 ([2001:b07:6468:f312:a0c0:5d2e:1d35:17bb])
 by smtp.gmail.com with ESMTPSA id a3sm8085895wmb.7.2020.06.04.11.02.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jun 2020 11:02:48 -0700 (PDT)
Subject: Re: [PATCH 0/4] target/i386: miscellaneous x87 fixes
To: Joseph Myers <joseph@codesourcery.com>, qemu-devel@nongnu.org,
 rth@twiddle.net, ehabkost@redhat.com
References: <alpine.DEB.2.21.2005132345100.11687@digraph.polyomino.org.uk>
 <alpine.DEB.2.21.2006021837050.3673@digraph.polyomino.org.uk>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5f87db12-de34-0582-2a0f-e49a12c2ae67@redhat.com>
Date: Thu, 4 Jun 2020 20:02:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.2006021837050.3673@digraph.polyomino.org.uk>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/04 01:08:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 02/06/20 20:38, Joseph Myers wrote:
> Ping for this patch series 
> <https://lists.gnu.org/archive/html/qemu-devel/2020-05/msg03543.html>, and 
> the subsequent series 
> <https://lists.gnu.org/archive/html/qemu-devel/2020-05/msg04462.html> and 
> individual patch 
> <https://lists.gnu.org/archive/html/qemu-devel/2020-05/msg06521.html>.

Hi Joseph,

these are the patches that I have queued:

Joseph Myers (12):
      target/i386: implement special cases for fxtract
      target/i386: fix fscale handling of signaling NaN
      target/i386: fix fscale handling of invalid exponent encodings
      target/i386: fix fscale handling of infinite exponents
      target/i386: fix fscale handling of rounding precision
      target/i386: fix floating-point load-constant rounding
      target/i386: fix fxam handling of invalid encodings
      target/i386: fix fbstp handling of negative zero
      target/i386: fix fbstp handling of out-of-range values
      target/i386: fix fisttpl, fisttpll handling of out-of-range values
      target/i386: fix IEEE x87 floating-point exception raising
      target/i386: correct fix for pcmpxstrx substring search

I was busy because Linus opened the merge window this week and because
of some public holidays, but I hope to send the pull request tomorrow as
it's grown quite big.

Paolo


