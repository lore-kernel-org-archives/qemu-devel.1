Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2696C3F2D2
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 17:29:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FBAB20637
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 17:29:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UCASKiom"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FBAB20637
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9uJG-00048Z-Mp
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 12:29:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41507)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1j9uIX-0003dz-Oa
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 12:28:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1j9uIW-0000b1-FJ
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 12:28:37 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22351
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1j9uIW-0000aW-Ai
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 12:28:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583429315;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SHZQIWyX/5Hz1UwE7NhmczpoZtEm6zAg/llvWf5DNMc=;
 b=UCASKiomKdAN9GCwNQHDpzUYxCh6qyoGy3zLjRT2WEFsw4y6vj6QKZhUvpwGK9zYVe8PpV
 SH3xoflEprx9nwgKLMKftySm3/racgCdCQm0vrFUFe3e8uZkRtzN45dLLJFtGsABHqD0RZ
 oK6n95aGCHJ+J6cxYBKMTDGTOyYFq8Q=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-302-BnMfnEccM9-yWRvez31PcA-1; Thu, 05 Mar 2020 12:28:34 -0500
X-MC-Unique: BnMfnEccM9-yWRvez31PcA-1
Received: by mail-wr1-f71.google.com with SMTP id b12so2595126wro.4
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2020 09:28:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=SHZQIWyX/5Hz1UwE7NhmczpoZtEm6zAg/llvWf5DNMc=;
 b=K3L81b93IkqOzz2e4NDsCfxd5FO8RgTbypITJHFqLQNclf1RNvEmSg5RNO0z89IyFB
 PvAncbZf8KU0WisOFNAfyIiP7F3O8C6clISW5YL9EFJ9If6HSTaApuhlAMLk92tX0AeJ
 lv6o4sTqRYWagXVOIDuzhmdJ5nvZ7HylDvd3Rvy/ksGbieW7i0zxdU4/rLX7EWiHbRq8
 eoLaPVLhpOnjNRHPbjfW4US9hxXuV16QZDVAPEf7ancfwqPxqbUxVkJYwrwjonAsqamM
 9nOzRWV4Tz/a8Lgy1so8a/PD8GDxAOjnZlN7rK16LZDGhjh/XiuwZHlfUxnNgq4Q3JHk
 B+HQ==
X-Gm-Message-State: ANhLgQ1GUgoZz/k2OFST7xx/kq+3PhcmsIzIfGqirDsgD4WlQtjGHioz
 bJnwlo7ySpdZimL5NVXG/H1CVXanCUejm8I5AxeNHQnrKmnOj+5lmo43WDUOS+sfgOeR79VkL9F
 gNZI05Z0X7nyRviY=
X-Received: by 2002:adf:eac1:: with SMTP id o1mr24050wrn.234.1583429312780;
 Thu, 05 Mar 2020 09:28:32 -0800 (PST)
X-Google-Smtp-Source: ADFU+vvocFhIdWvbsVx3vWhlLXrGEkUBIhxfEj0ARNz363226voURm61kSMYgQ1RCJp2OvjnrgFfqw==
X-Received: by 2002:adf:eac1:: with SMTP id o1mr24033wrn.234.1583429312583;
 Thu, 05 Mar 2020 09:28:32 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:9def:34a0:b68d:9993?
 ([2001:b07:6468:f312:9def:34a0:b68d:9993])
 by smtp.gmail.com with ESMTPSA id t1sm49560138wrs.41.2020.03.05.09.28.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Mar 2020 09:28:31 -0800 (PST)
Subject: Re: [PATCH 7/7] aio-posix: remove idle poll handlers to improve
 scalability
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
References: <20200305170806.1313245-1-stefanha@redhat.com>
 <20200305170806.1313245-8-stefanha@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <58ce9251-77ba-9db2-b1c1-fd97cd175e9a@redhat.com>
Date: Thu, 5 Mar 2020 18:28:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200305170806.1313245-8-stefanha@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
> +    /*
> +     * List of handlers participating in userspace polling.  Accessed almost
> +     * exclusively from aio_poll() and therefore not an RCU list.  Protected by
> +     * ctx->list_lock.
> +     */
> +    AioHandlerList poll_aio_handlers;
> +

Not sure I understand the "almost" part.  If it's accessed only from
aio_poll() it is protected via either AIO_WAIT_WHILE or the BQL, not by
ctx->list_lock; if it's protected by ctx->list_lock (using
qemu_lockcnt_inc in readers), it is an RCU list.

Paolo


