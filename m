Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F32CC3F2D2
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 17:26:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CA6820705
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 17:26:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TyT3BFJu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CA6820705
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54040 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9uGG-0001yR-If
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 12:26:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39091)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1j9u6A-0003lZ-21
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 12:15:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1j9u65-0007D4-Tz
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 12:15:47 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55427
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1j9u64-0007BA-4K
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 12:15:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583428542;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7VKEUkzpAn5AFZ8jcvwKF8uRGWX7cVohhHqNaQ8Uvuo=;
 b=TyT3BFJuSDbT1879JzCZanYDjLrVr9z6rsiV5rew7HB6SzOFzddhjcScdrxDOTeAwdrjlA
 ejKdbTRRqxd50uCh701/JDfkDJaSrMv3LY23vus79s+EeixGayZMv19rID8HsqgAkfeCLM
 LuGtfXJjZv1hwB5tItWR0GQCn0xGVOQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-145-BJWGdp6MMcWPRfXrLhgXLQ-1; Thu, 05 Mar 2020 12:15:40 -0500
X-MC-Unique: BJWGdp6MMcWPRfXrLhgXLQ-1
Received: by mail-wr1-f71.google.com with SMTP id t14so2545972wrs.12
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2020 09:15:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=7VKEUkzpAn5AFZ8jcvwKF8uRGWX7cVohhHqNaQ8Uvuo=;
 b=bqqirckWsndS3PbrimQM+n9wF1SNb4LYZsQVdj//+xMrWXCaNg37yGxd+ZpscJzJay
 XqPNnrFZoWN7L/SW5EPMkNbvGMaK/MO0Sf0Iz0FMdTKhI5JbeexTzgj5l5uUnyxVKYR0
 LMSU5gRSZwursA48mBQndc8JzGCtp5TGAMhv8NtpMVWRKxfTigTGbkW27i7pn+4iibmY
 Vg+3JOvsxc34QxZpH7x9n8zGKMzISrL6+S4E6wyp16bTYHSirkllfM/O3qnPEB7Y2k9o
 LozQ3h0S7SbLVUBDvLrIxFeWTjZW++wBmRVNn35+Ir5sHD2a76yyURrleYP4JodFMsdD
 XVbQ==
X-Gm-Message-State: ANhLgQ3FpnVjqcXv93AKPS6AibDbNQm4yP28MNDP0MdJ24UIz5r/U+1m
 j3b4HWLE/7qwvTzcU2UFG0kFuo6faxuWUzFFGuwplsvWZaTkcTKDcNOeJWcFaz+w++i7poLswgr
 xTWR00RfusVDXNjc=
X-Received: by 2002:a05:600c:204a:: with SMTP id
 p10mr10535886wmg.55.1583428539493; 
 Thu, 05 Mar 2020 09:15:39 -0800 (PST)
X-Google-Smtp-Source: ADFU+vsKZuYUcv0Q6kgGZtVB6iuO/aUO2MZHTyQsfc3mp67auORMHxFOlljrEGuBCHAkvxttWRgsvw==
X-Received: by 2002:a05:600c:204a:: with SMTP id
 p10mr10535872wmg.55.1583428539278; 
 Thu, 05 Mar 2020 09:15:39 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:9def:34a0:b68d:9993?
 ([2001:b07:6468:f312:9def:34a0:b68d:9993])
 by smtp.gmail.com with ESMTPSA id n3sm10619428wmc.27.2020.03.05.09.15.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Mar 2020 09:15:38 -0800 (PST)
Subject: Re: [PATCH 2/7] aio-posix: move RCU_READ_LOCK() into
 run_poll_handlers()
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
References: <20200305170806.1313245-1-stefanha@redhat.com>
 <20200305170806.1313245-3-stefanha@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7218b5ad-84cd-a111-b88f-7043ee63d486@redhat.com>
Date: Thu, 5 Mar 2020 18:15:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200305170806.1313245-3-stefanha@redhat.com>
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 05/03/20 18:08, Stefan Hajnoczi wrote:
>  
> +    /*
> +     * Optimization: ->io_poll() handlers often contain RCU read critical
> +     * sections and we therefore see many rcu_read_lock() -> rcu_read_unlock()
> +     * -> rcu_read_lock() -> ... sequences with expensive memory
> +     * synchronization primitives.  Make the entire polling loop an RCU
> +     * critical section because nested rcu_read_lock()/rcu_read_unlock() calls
> +     * are cheap.
> +     */
> +    RCU_READ_LOCK_GUARD();
> +

Looks good, but I suggest that you compile with --enable-membarrier as
that makes RCU critical sections basically free.

Paolo


