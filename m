Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4759EC2D0C3
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 14:19:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16808206A5
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 14:19:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mvista-com.20150623.gappssmtp.com header.i=@mvista-com.20150623.gappssmtp.com header.b="wSPiJ7zv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16808206A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mvista.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igrDe-0006qS-7B
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 09:19:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:32877)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cminyard@mvista.com>) id 1igr7s-0000he-2K
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 09:13:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cminyard@mvista.com>) id 1igr7q-0002oN-Fm
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 09:13:31 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:36739)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <cminyard@mvista.com>) id 1igr7p-0002gs-TZ
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 09:13:30 -0500
Received: by mail-ot1-x343.google.com with SMTP id i4so9402589otr.3
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 06:13:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mvista-com.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=7K317lOkInAvgD928oRikb5UMaPEj5cRdLXFxA5JGM4=;
 b=wSPiJ7zv3jWCgYN9NV12x+XdU/hXYzYrcKNMK2CZdyQd5M36nepko38NuohNDrRsvw
 VsCwbdf+RH1uuwvXRlYsotI81LBBRV7edLbaf8hx5MuZnOo4mQ8cIq9Nc7rZODViE4LJ
 1AFOEiLTxCLFGqHd2yZ2rAFQIl1mrMOtBoTD9622OBAG86zuKDb5ekEwVjE6a4jwnV6Y
 8zsyIE8DDIRdcRVxcJW9dW6mCghOEPBdsR5E4r64oVFbDjdS2FA8PeAQ0NRw6lLGyEr0
 v28u/RLXsymiZA0y/okKXGKTgHmzHKn+eZNLXwId1IV6hKAndTrHB9t//22bLCmeFame
 MW5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
 :references:mime-version:content-disposition:in-reply-to:user-agent;
 bh=7K317lOkInAvgD928oRikb5UMaPEj5cRdLXFxA5JGM4=;
 b=mmwmoXn6/uLwTWnJrFlhILiQjuX2mdWNbDQdrBcWkKXrZQiGz/UsOobNLgLlI5bhJS
 YkXtWkEidcawm5moKl9kodJCeGVTcdrf0vjYyr0DUmV8XPFwUB+BbIG81IhUhZO1Gb4S
 5U+qdF1TEdR/HNg4kBVDJOY1M/GWZ+PhJ+Cs7ztwgP6dxR5p5eQrlQoSI3J7VATD3G/c
 cRYZGLJ+oXDp1Gh5dkaSI3ClBY2/B4XhQu/qIeWi7ttWSPRW0n1KBcjQbQj9vOGxiQZD
 LrnmUGQfR1j7PMc6zr/yRUU08fAoe+MftCByhmVeVXQZ5k0O5i8512w23oEN09ksq5yG
 i5/Q==
X-Gm-Message-State: APjAAAXta6bB02fMl90X94HA9n83EYrraEHwGQx2lDC+SenrafNr9ojg
 ik1WsFSm6JK3HWqDdhz2SCxxiQ==
X-Google-Smtp-Source: APXvYqwH5LTb+lrnWceKKIGbnbcrt4gS2O4DiK80CHHUyajGbml1JGQDu9XvGXOqnQFId1KqhkVUug==
X-Received: by 2002:a05:6830:1149:: with SMTP id
 x9mr33226654otq.156.1576505604138; 
 Mon, 16 Dec 2019 06:13:24 -0800 (PST)
Received: from minyard.net ([47.184.136.59])
 by smtp.gmail.com with ESMTPSA id y6sm6749815oti.44.2019.12.16.06.13.22
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 16 Dec 2019 06:13:23 -0800 (PST)
Date: Mon, 16 Dec 2019 08:13:20 -0600
From: Corey Minyard <cminyard@mvista.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH 11/21] hw/ipmi: Fix latent realize() error handling bugs
Message-ID: <20191216141320.GA7049@minyard.net>
References: <20191130194240.10517-1-armbru@redhat.com>
 <20191130194240.10517-12-armbru@redhat.com>
 <20191201182234.GA18195@minyard.net>
 <87mubsfwzf.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87mubsfwzf.fsf@dusky.pond.sub.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
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
Reply-To: cminyard@mvista.com
Cc: vsementsov@virtuozzo.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Dec 16, 2019 at 10:20:04AM +0100, Markus Armbruster wrote:
> Corey Minyard <cminyard@mvista.com> writes:
> 
> I've since posted v2 with a revamped commit message, and I'm ready to
> post a pull request.  I really want the whole thing committed before the
> Christmas break, so Vladimir can base on it more easily.  Options:
> 
> * You post a pull request before me.
> 
> * Ask me to drop this patch from my pull request, so you can take it
>   through your tree at your leisure.
> 
> * Post your Reviewed-by or Acked-by for me to include in my pull
>   request.
> 
> * Do nothing; I'll post my pull request later this week.
> 

Since you already have it ready, I'll choose the "do nothing" patch
and let you post the pull request.  Thanks.

-corey

