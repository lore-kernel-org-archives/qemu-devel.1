Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6166DC2BA19
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 10:36:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B29E206C3
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 10:36:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eXX1QovB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B29E206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58476 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLP6r-0003EJ-CQ
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 06:36:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53466)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jLP6A-0002QO-Lg
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 06:35:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jLP69-0000Gb-MQ
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 06:35:22 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38013
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jLP69-0000GE-Ip
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 06:35:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586169321;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RZzQ8tjV0TEhmpDUdwum21Z0QBc8GmEqWuD8mkjSaaQ=;
 b=eXX1QovBQ5glHJo9pc8RDyK7f9tQdBZGWoLj1ErDBMANB2fBLSBIO8bHW2U9vvJy/ld/1/
 LadInM51xnmsBuuAjO8JPEkS83SQmYG4LOisyKJ7NgxTrYlD1Fs2dPxbv0s7Czyr9wPql0
 Ld4oT+my9q+ydTfBTmnHDA8MSYoDRHA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-291-WFvf2e6vOv69fHtvTYEPOw-1; Mon, 06 Apr 2020 06:35:19 -0400
X-MC-Unique: WFvf2e6vOv69fHtvTYEPOw-1
Received: by mail-wm1-f72.google.com with SMTP id w8so4752503wmk.5
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2020 03:35:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=RZzQ8tjV0TEhmpDUdwum21Z0QBc8GmEqWuD8mkjSaaQ=;
 b=Y+EkUQK9gP9iY1o6HCZpdaFCOH3HATOpkSmn8jb39D5GE/dU58eop+qkpm7EP/V+0j
 j81mYMOBWUrFTZu4DAv4vJ/48NS9u3xo2vT6M4tkcEimMyYvGoT5YUUlpCTlWXSK4tyl
 LTj+iDdfdE/dtQ9OKVUq/6uU+/o0UilqCQMus/BprjdgjVjarU+MUWPDelF7dwpWjkFe
 gUYs4dL5FNXD8XZpv1wmhEBpXV/PUodnPIQ322ybgmSxy0CgV+QkhXvPsHFvBwwA4cjF
 Y+5HoISCYWqJWK6s+2E3d+WAwQeHW51lYXATm+v9+bM860B00GXfUjYVqOSkbgoGrZfq
 yHVw==
X-Gm-Message-State: AGi0PubkizfgYGKGr2EI44ovWR6Za16LGSBis1sHctvThUDkPtONVAnv
 onz0Ld0fw1QyealTb6HQSw+qToLG2koB1nDP+1CQlwWtiBvP5KFS9r4CiS6AQMpqL8UmphbZ4hu
 OpV97G+e3OnCSPR0=
X-Received: by 2002:a5d:6742:: with SMTP id l2mr24650827wrw.124.1586169317833; 
 Mon, 06 Apr 2020 03:35:17 -0700 (PDT)
X-Google-Smtp-Source: APiQypI0RGJeImthCvjtnP7V/pjjZZhq9AkpX+7bQhW5OkOXSpbsdoJ4AS+h3NVEtHjMQ/S/cHif3Q==
X-Received: by 2002:a5d:6742:: with SMTP id l2mr24650794wrw.124.1586169317588; 
 Mon, 06 Apr 2020 03:35:17 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:80e8:806f:a5f9:88dc?
 ([2001:b07:6468:f312:80e8:806f:a5f9:88dc])
 by smtp.gmail.com with ESMTPSA id v7sm10287312wmg.3.2020.04.06.03.35.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Apr 2020 03:35:16 -0700 (PDT)
Subject: Re: QEMU participation to Google Season of Docs
To: John Snow <jsnow@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Stefan Weil <sw@weilnetz.de>
References: <de92e66d-c474-dd1b-ddab-194b2f92d1dd@redhat.com>
 <de4b6733-859b-eebe-32ab-c0eb0fcb6311@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f20f5784-d810-54d7-a25e-5394b2b75abd@redhat.com>
Date: Mon, 6 Apr 2020 12:35:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <de4b6733-859b-eebe-32ab-c0eb0fcb6311@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 qemu-discuss@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 04/04/20 03:37, John Snow wrote:
> This looks like it could be very good for us.
> 
> My only concern is that the scope and breadth of QEMU is huge and it may
> be a lot for a newcomer to tackle appropriately for top-level docs, so I
> feel like it requires a mentor who has a good understanding of the broad
> picture of QEMU.
> 
> Like the description says, we often write things bottom-up in areas of
> very specific focus. The broad picture is sometimes harder to conjure
> accurately.
> 
> I have a lot of opinions and thoughts on python and how docs should be
> laid out, but I'm afraid I'm not so good at understanding all of the
> options and "use cases" of QEMU to confidently lay out a top-level TOC.
> Maybe if we collaborated on a TOC we could give a clear project
> guideline to a GSoC/GSoD contributor.

That's actually how a good technical writer can help us!  The main
problem we have with our docs is the disconnect between docs/system
(formerly qemu-doc) and the .txt files in docs/.  We know the material,
but it's hard to reorganize docs/system to make room for everything else.

Reorganizing the TOC to fit all the material in both categories would be
the best outcome of our participation in GSoD.

Paolo


