Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7909C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 19:22:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 951C122BF3
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 19:22:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P2PaXZCS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 951C122BF3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5DNq-0001qG-Qh
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 15:22:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46150)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k5DNF-0001JO-4Y
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 15:22:21 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:44783
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k5DNC-0001nG-Kv
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 15:22:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597087336;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P7vfOm54WaET0EdF8s8WXpCZuMK2jhbf2ZrEYAn/l7s=;
 b=P2PaXZCSFfywRwD61EybYNIBWs66yMOqUnKPTIrXH8jkDe9g5Ns2xbULx/JGwRLpTNK4me
 bNvvrRZFxHKVUt2++sraX9gHpmGoT7t14q6+V9X1Y6kuaw1Xr0ZE6tEtzBqJNs/iC2na6a
 TNWE74v5iypvTmD6yKXYQ2ivZWeRA1k=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-502-JJ9FZJKONECKqHO6WMMLtA-1; Mon, 10 Aug 2020 15:22:15 -0400
X-MC-Unique: JJ9FZJKONECKqHO6WMMLtA-1
Received: by mail-wm1-f69.google.com with SMTP id v8so163345wma.6
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2020 12:22:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=P7vfOm54WaET0EdF8s8WXpCZuMK2jhbf2ZrEYAn/l7s=;
 b=UPCoUXoDXjKeHZ53opWUQRCKHGkOxAOY+WxN4Nb3smowe5USV+tdLHDcTHhQLao1r5
 OsXDuig3exKNx7FrelgR7Pm0xOt7gWcu33J29aImYoQAQOuIegFB8LsVxkm8gXRHgBx+
 BBL4JfiXCA0ouZ3Wp7Fr/5iHrDA2yik3HxfRCzix/dRxCg8cKSYySMdHK2M+/AvfPZDX
 +cJ2RStDSN7vqhtsZ8NXkgTLp2U4ZiS+7EATHXwlhnQlpZDruA6gL9bbMbssSudfJEVc
 vsX84vB0ACexUI1MTQyH+I5FTSy2rLERFyId0wqH9GhMvUlMC4P/35K7hIylcdp0gd22
 O5rw==
X-Gm-Message-State: AOAM533Tgm6MouSgWwvE2NUnCkhi/bm522whnxJ59oQC+cF3jmogXOpM
 E4AAfIkghwnLN9XxD9cpCyiLecO5UmDtDWLDn0ujYY2SemjzYHoZdtcaSdh9qaoAXGjQ5+3PllN
 By8osTIiEtv+WYDE=
X-Received: by 2002:a1c:ed16:: with SMTP id l22mr50699wmh.80.1597087333928;
 Mon, 10 Aug 2020 12:22:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzl3jGaslxgeMleH+n+8qIwoPxnsOzam9VZwb+0UFFe9JPZu7OUSXezQ+MilMbofGgKpB7D/Q==
X-Received: by 2002:a1c:ed16:: with SMTP id l22mr50678wmh.80.1597087333709;
 Mon, 10 Aug 2020 12:22:13 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:5d6c:f50:4462:5103?
 ([2001:b07:6468:f312:5d6c:f50:4462:5103])
 by smtp.gmail.com with ESMTPSA id g70sm894832wmg.24.2020.08.10.12.22.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Aug 2020 12:22:12 -0700 (PDT)
Subject: Re: [PATCH 000/147] Meson integration for 5.2
To: Peter Maydell <peter.maydell@linaro.org>
References: <1597079345-42801-1-git-send-email-pbonzini@redhat.com>
 <CAFEAcA_icj94N6eotg9W7FutXTY_6U-Ak6pJMyYH0n9eggunrg@mail.gmail.com>
 <CAFEAcA8smstwpQUD9UJzMuE6Cq2WutQzBPrKLLs=3wvfXUmpUg@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b710345e-1644-782a-44a9-537493b85d95@redhat.com>
Date: Mon, 10 Aug 2020 21:22:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8smstwpQUD9UJzMuE6Cq2WutQzBPrKLLs=3wvfXUmpUg@mail.gmail.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/10 03:29:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 Alexander Bulekov <alxndr@bu.edu>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/08/20 21:16, Peter Maydell wrote:
> And the remainders:
> 
> The tests/vm FreeBSD and OpenBSD setups succeed but emit this warning
> (as well as the the usual ones):
> 
> WARNING: Gettext not found, all translation targets will be ignored.

This is a real warning.  I'll see if we can add a configure option to
disable the translations bug it's fairly low priority.

> OSX succeeds but has this extra warning:
> 
> ../../meson.build:42: WARNING: add_languages is missing native:,
> assuming languages are wanted for both host and build.

Fixed.

> All other configs built OK (with the same set of warnings as
> for x86).

Great, thanks!

Paolo


