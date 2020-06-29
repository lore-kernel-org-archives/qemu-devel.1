Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CCA6C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 15:09:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D05A23D4E
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 15:09:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TDmGtieW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D05A23D4E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpvPD-0004jJ-JA
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 11:09:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56146)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jpvN1-0002ZT-Bd
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 11:06:55 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:41917
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jpvMz-0006EN-Ed
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 11:06:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593443209;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NdDt4rQJBder4A06aENzHnzVeGla/e47f3tdY2pMllo=;
 b=TDmGtieW/LoFQQKAqUuaP568muFgL8WtsdVffGv0mMnW8FFjQIFXze6WM8zdJeF/s4OcTw
 X6PdQljxvMxDo6aIsc/Xr+W3esc/JpX9gQFGEJjqe1az+1r+969N3IboNn7nITyWKK4sar
 8msqetkgo44W9RTk5gt4ePECZ2qxJPk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-184-b5KNkD5nP1yqWdRgIYe7qQ-1; Mon, 29 Jun 2020 11:05:56 -0400
X-MC-Unique: b5KNkD5nP1yqWdRgIYe7qQ-1
Received: by mail-wr1-f69.google.com with SMTP id i12so16593578wrx.11
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2020 08:05:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=NdDt4rQJBder4A06aENzHnzVeGla/e47f3tdY2pMllo=;
 b=K4oZyQkO9koNbdb0R1iZxtE1diantzrHmP1lSvG9MaikTjA8KYmULIl1WzN68xqWTq
 3IesoOEmVfjFIW0QRbaNTJEtFzwVTBMPSPY4leqtMI40iIE0nBeqjo4AXGVsAhw9pXKB
 kvSRu6ajXEYhF8354Z7EurDB0bXyh8FjW8A7iArzq9aYCSB25porAPRRLLLFesRYUJMP
 axj8XXD0CghlnKD+cRuQfEvk//5qVKPL4YXWBhI1d+yOjwNYC16ghjuv/xcVROYAphcb
 +7WtHts9yqAV5lw2nPy6nbxOZYd8jsgHg4YNuJr69c1zY6dN8W3Fb39YxzQS9dVNYOc4
 rSLQ==
X-Gm-Message-State: AOAM5302xP0LGP3pLQCTbQnGV+va4yrvl3eKXAQ4dI3A0lwyWf08m4tW
 DOMCuJQ8aZcsRSBCuWg665ZU6YuYx0OsxrI9U2SYHkiXMOaAbwqKfGbKS4wx4ewOJ5YUGzAw33l
 VASPMQ+d2fMSX5Ao=
X-Received: by 2002:adf:f04c:: with SMTP id t12mr15881448wro.382.1593443146919; 
 Mon, 29 Jun 2020 08:05:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwxRtzyO/a7OMHGixy8D7mPjkb3hZ7RcDCDpwQguqpDcDre6XOg0bTAPr6BPNgakzmuCYjXqg==
X-Received: by 2002:adf:f04c:: with SMTP id t12mr15881431wro.382.1593443146667; 
 Mon, 29 Jun 2020 08:05:46 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:b0e5:c632:a580:8b9a?
 ([2001:b07:6468:f312:b0e5:c632:a580:8b9a])
 by smtp.gmail.com with ESMTPSA id c25sm32897wml.46.2020.06.29.08.05.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jun 2020 08:05:46 -0700 (PDT)
Subject: Re: [RFC v2 0/1] memory: Delete assertion in
 memory_region_unregister_iommu_notifier
To: =?UTF-8?Q?Eugenio_P=c3=a9rez?= <eperezma@redhat.com>, qemu-devel@nongnu.org
References: <20200626064122.9252-1-eperezma@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <52d97ca5-7dbd-3178-64d6-509a8f096f0b@redhat.com>
Date: Mon, 29 Jun 2020 17:05:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200626064122.9252-1-eperezma@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/29 01:06:01
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 Avi Kivity <avi@redhat.com>, Peter Xu <peterx@redhat.com>,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 26/06/20 08:41, Eugenio Pérez wrote:
> If we examinate *entry in frame 4 of backtrace:
> *entry = {target_as = 0x555556f6c050, iova = 0x0, translated_addr = 0x0,
> addr_mask = 0xffffffffffffffff, perm = 0x0}
> 
> Which (I think) tries to invalidate all the TLB registers of the device.
> 
> Just deleting that assert is enough for the VM to start and communicate
> using IOMMU, but maybe a better alternative is possible. We could move
> it to the caller functions in other cases than IOMMU invalidation, or
> make it conditional only if not invalidating.

Yes, I think moving it up in the call stack is better.  I cannot say
where because the backtrace was destroyed by git (due to lines starting
with "#").

Paolo

> Any comment would be appreciated. Thanks!
> 
> Guest kernel version: kernel-3.10.0-1151.el7.x86_64
> 
> Bug reference: https://bugs.launchpad.net/qemu/+bug/1885175
> 
> v2: Actually delete assertion instead of just commenting out using C99
> 
> Eugenio Pérez (1):
>   memory: Delete assertion in memory_region_unregister_iommu_notifier
> 
>  memory.c | 2 --
>  1 file changed, 2 deletions(-)
> 


