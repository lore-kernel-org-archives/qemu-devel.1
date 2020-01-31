Return-Path: <SRS0=aXOp=3U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 636A1C33CB2
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 07:47:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29A7620705
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 07:47:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ID3wsDRd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29A7620705
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49594 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixR1x-0004ac-D0
	for qemu-devel@archiver.kernel.org; Fri, 31 Jan 2020 02:47:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34499)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1ixR0l-0003s0-TZ
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 02:46:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1ixR0i-0001Lf-QZ
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 02:46:42 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:23353
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ixR0i-0001DP-Fd
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 02:46:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580456797;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a+vUXabzGE8CMWWHdbrASFWKVmNBXDAs1YrZ9R3+Db8=;
 b=ID3wsDRdmTlCZKuTub1K3pvsePbesKxI0e4Cl2RlX2iF4j1ULOiEVdfu1E6XkJUvEWJEtf
 IuOYhPUJfmo5E5ZszKu5nVOMmSVlx5OQnDQjB1ISEO2otO47w9zndmkm9ASXk5PVhJ7V+y
 dJ8oobsdABObqM34nRZOO0Y4nXIHtJw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-177-xj0KbE-BP124TFKMmHy3uA-1; Fri, 31 Jan 2020 02:46:35 -0500
Received: by mail-wm1-f69.google.com with SMTP id z7so1725764wmi.0
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2020 23:46:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=a+vUXabzGE8CMWWHdbrASFWKVmNBXDAs1YrZ9R3+Db8=;
 b=py80XLmTkHA/FWYEYcNGfaiDnPZqfi+GJE8Fh96bVFWaBLlgwQ37MPHZB6RATij80y
 J9Z1aoVFRtS3ZcvbuYHowUezQo2TiAtePyYNlTwlc65eIhTOeUYA+dhtoTwTblKTLvmE
 RNFUNeVXfAQMl47oxPsF8MFvMbfSux+7gSgM/dncvtMyWZSPu3LPdhaoioaxvwbIRKz5
 VfJ4tIUchHm+Fr0tySDGwh29/KNXZh+VBaSiRCRkLEbOUZeMG670TGrP5XFTJrYGadt5
 RHWhZVW6rcYs9fB0WplJCNlexydqoUvDTgZO8VBpN/iZSlOfs90uZQ/iJRhXsMSotaXc
 8fiQ==
X-Gm-Message-State: APjAAAXTfqE8qJ0g7waPzx3TEdsquH1IboOvggiqG0f1u5jx6t0vU0AI
 OGthvf+ppVdotDGmjIoO6diBFuzUPDPEwmQN656Q04cr5ZFRSyMst2Tgj3Hp1mhWRVklWTleXdU
 BhAkz1/Lwl7AmUAQ=
X-Received: by 2002:a5d:62d1:: with SMTP id o17mr10750146wrv.9.1580456794517; 
 Thu, 30 Jan 2020 23:46:34 -0800 (PST)
X-Google-Smtp-Source: APXvYqw9NXmLdaykfsoDpKC0SeCzopgnUF0PjYu68jSb8RbeI7qDl0g2jz1x+X/sYh1/BhezvhujBA==
X-Received: by 2002:a5d:62d1:: with SMTP id o17mr10750093wrv.9.1580456794122; 
 Thu, 30 Jan 2020 23:46:34 -0800 (PST)
Received: from [10.1.251.141] ([80.188.125.198])
 by smtp.gmail.com with ESMTPSA id y6sm10788235wrl.17.2020.01.30.23.46.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jan 2020 23:46:33 -0800 (PST)
Subject: Re: Improving QOM documentation [Was: Re: Making QEMU easier for
 management tools and applications]
To: Markus Armbruster <armbru@redhat.com>,
 Kashyap Chamarthy <kchamart@redhat.com>
References: <20200108104306.GC5057@dhcp-200-226.str.redhat.com>
 <97F153BD-FB8A-46C7-90D0-9E894B9E0292@redhat.com>
 <20200108133842.GE5057@dhcp-200-226.str.redhat.com>
 <87d0bmchq0.fsf@dusky.pond.sub.org>
 <1B253197-5592-472A-AA26-E0614A13C91A@redhat.com>
 <87o8v52hz9.fsf@dusky.pond.sub.org>
 <8CF8359B-1E52-4F7A-944E-C1C14FEC4F92@redhat.com>
 <87r200zzje.fsf@dusky.pond.sub.org> <20200115121953.GJ93923@redhat.com>
 <874kwwvmuv.fsf@dusky.pond.sub.org> <20200130210902.GA25927@paraplu>
 <87y2toi29o.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0a626b76-1b45-991f-ebf9-d6dec2a84ffb@redhat.com>
Date: Fri, 31 Jan 2020 08:46:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <87y2toi29o.fsf@dusky.pond.sub.org>
Content-Language: en-US
X-MC-Unique: xj0KbE-BP124TFKMmHy3uA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 "Denis V. Lunev" <den@virtuozzo.com>, Stefan Hajnoczi <stefanha@gmail.com>,
 qemu-devel <qemu-devel@nongnu.org>,
 Christophe de Dinechin <dinechin@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Dominik Csapak <d.csapak@proxmox.com>, John Snow <jsnow@redhat.com>,
 ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 31/01/20 07:11, Markus Armbruster wrote:
> May I present you Armbru's Comment Trust Levels:
> 
> ACTL2: The comment may be overly terse or incomplete, but the
> probability for it to be outright wrong is low.
> 
> ACTL1: Treat as helpful guidance (with gratitude), but trust only the
> code.
> 
> ACTL0: It is a tale Told by an idiot[**], full of sound and fury,
> Signifying nothing.
> 
> Most comments in decently maintained code are at ACTL1.
> 
> Around the time initial QOM development solidified, object.h's comments
> were ACTL2.  The neglect that is now clearly visible there makes me
> downgrade to ACTL1.
> 
> Paolo will have a more informed and possibly different opinion.

I think around initial development it was ACTL3, now it's around 1.8.

Paolo


