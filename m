Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BADC9C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 15:37:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88549206F6
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 15:37:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Oxp/41Nz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88549206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34476 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbnGL-0005OQ-Pz
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 11:37:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41752)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jbnFH-0003sb-S6
 for qemu-devel@nongnu.org; Thu, 21 May 2020 11:36:31 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38142
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jbnFG-0007uB-6P
 for qemu-devel@nongnu.org; Thu, 21 May 2020 11:36:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590075389;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OhGdJYZRFQlKEuHXm/zV2F6LPHVNY86TzM0AKdO40bc=;
 b=Oxp/41Nz3pLF9aMrrOvzUhzXxEqPMcvv8TGW57QOvgLR5NEyxEEcNFvt+AYETwOkxMfOsX
 0+yaHkSKiYgdTKgEox/HihwzwdAWt3WAg7SA/OoDw0yMgnKNiOMqmpo1y6S1yWfV682SX7
 ZLxaVNAPFM556GBFW2SBtx3T0bwFXDQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-185-MuE8dljTPMedlmqt3J43aA-1; Thu, 21 May 2020 11:36:27 -0400
X-MC-Unique: MuE8dljTPMedlmqt3J43aA-1
Received: by mail-wr1-f70.google.com with SMTP id i9so3093827wrx.0
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 08:36:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=OhGdJYZRFQlKEuHXm/zV2F6LPHVNY86TzM0AKdO40bc=;
 b=s4EuaHkWjqxOHzfHMWL9TzaaW7wYCjo88uCrtkHzfbXgoJpp5wM/JcEyPrZCeKLfAc
 ll0eb8A5AuJ1dtmaJcfN+NzOWg8jPoUguotR48QlmZgaCj+00bTJxElH+NQUqgmp80lJ
 jX8ZkLwX1ldRhhV3ofEAzloHmygVhlblez/lDI5G3P70ezkIWDOKaXDeWRQNzGCJTvPZ
 5MqosQMoVlRpsol6P+GuAmkhOYk3flQKskIG3MKnuEcnIDGiZVQu727/eNTdlAZiZ5Ou
 1OUbOmVAgF3Q7UvxfNbSUSIp6NbD0S5LgIqHy1ClZf0hz1vL4OUS4gdumPNc+WkiBqJb
 i9eQ==
X-Gm-Message-State: AOAM532gNBfxaO9TlheuYlTu4xKSzgs2GCzMGPxDzIEX6aTJjzv6nQZD
 fezelMJRcVJHb78cjRd+7ikF5k55hvLPYsBpcVhQBEjTHyjziEmTV3eta7yQ726doP0dsysu9tg
 X5EQFBBSEI8DTX6A=
X-Received: by 2002:a5d:4b0a:: with SMTP id v10mr8296910wrq.33.1590075386431; 
 Thu, 21 May 2020 08:36:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzJY1daNtQsgeHXoaWJl8XKt7TK1NGnd8ysx6t4Kxm3wo7DSqoaRNGvJE3U8bghx+Kq1q3R6A==
X-Received: by 2002:a5d:4b0a:: with SMTP id v10mr8296888wrq.33.1590075386191; 
 Thu, 21 May 2020 08:36:26 -0700 (PDT)
Received: from [192.168.178.58] ([151.21.160.154])
 by smtp.gmail.com with ESMTPSA id 40sm5636014wrc.15.2020.05.21.08.36.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 May 2020 08:36:25 -0700 (PDT)
Subject: Re: [PATCH 0/5] target/i386: fxtract, fscale fixes
To: Joseph Myers <joseph@codesourcery.com>, qemu-devel@nongnu.org,
 rth@twiddle.net, ehabkost@redhat.com
References: <alpine.DEB.2.21.2005070038550.18350@digraph.polyomino.org.uk>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <226d60ef-b283-f257-c746-ab1e8943b9f8@redhat.com>
Date: Thu, 21 May 2020 17:36:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.2005070038550.18350@digraph.polyomino.org.uk>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/21 01:44:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

On 07/05/20 02:42, Joseph Myers wrote:
> Among the various bugs in the x87 floating-point emulation that show
> up through a combination of glibc testing and code inspection, there
> are several in the implementations of the fxtract and fscale
> instructions.  This series fixes those bugs.
> 
> Bugs in other instructions, and bugs relating to floating-point
> exceptions and flag setting, will be addressed separately.  In
> particular, while some of these patches add code that sets exception
> flags in the softfloat state, it's generally the case that the x87
> emulation ignores exceptions in that state rather than propagating
> them to the status word (and to generating traps where appropriate).
> I intend to address that missing propagation of exceptions in a
> subsequent patch series; until it's addressed, the code setting
> exceptions won't actually do anything useful.  (There is also code in
> the x87 emulation, including that of fscale, that would result in
> spurious exceptions being set from a naive propagation of exceptions
> from the softfloat state, and thus will need updating to avoid
> propagating inappropriate exceptions when such propagation is
> implemented.)
> 
> Joseph Myers (5):
>   target/i386: implement special cases for fxtract
>   target/i386: fix fscale handling of signaling NaN
>   target/i386: fix fscale handling of invalid exponent encodings
>   target/i386: fix fscale handling of infinite exponents
>   target/i386: fix fscale handling of rounding precision
> 
>  target/i386/fpu_helper.c           |  59 +++++++++++++-
>  tests/tcg/i386/test-i386-fscale.c  | 108 ++++++++++++++++++++++++++
>  tests/tcg/i386/test-i386-fxtract.c | 120 +++++++++++++++++++++++++++++
>  3 files changed, 285 insertions(+), 2 deletions(-)
>  create mode 100644 tests/tcg/i386/test-i386-fscale.c
>  create mode 100644 tests/tcg/i386/test-i386-fxtract.c
> 

Queued, thanks.

Paolo


