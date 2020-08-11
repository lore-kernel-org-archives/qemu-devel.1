Return-Path: <SRS0=wQM/=BV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF552C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 13:14:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86F6C2076B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 13:14:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iwGlgCig"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86F6C2076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42276 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5U7G-0006qe-Rl
	for qemu-devel@archiver.kernel.org; Tue, 11 Aug 2020 09:14:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48218)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1k5U6h-0006MK-Ps
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 09:14:23 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:27603
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1k5U6f-0002Ef-RM
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 09:14:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597151661;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TVz+WvKu02KshY69UDG58BjK5JTgpqlEiVYjTGuurb8=;
 b=iwGlgCigxjg2C5VEPC4x51De3VEClLRV50IZQsjoLerViEVNxSLHMwMZCfkw04mw6ZlMrZ
 JqXEWoCn4KKNzvmJrOy1FzSHEOoahmcpN+kDsdYpn745qMESQ2H7F9Be7LoX2l/I74a62Y
 SKvMqweFGE3VrDJiLjf0EkIo7B2zGf8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-486-W4ZCG_dXPCKBj8yuhppSRw-1; Tue, 11 Aug 2020 09:14:19 -0400
X-MC-Unique: W4ZCG_dXPCKBj8yuhppSRw-1
Received: by mail-wr1-f71.google.com with SMTP id t12so5621895wrp.0
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2020 06:14:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=TVz+WvKu02KshY69UDG58BjK5JTgpqlEiVYjTGuurb8=;
 b=EVBm/yCQWS5KV+WYx1j4AXoOg8zSO3MTkj1mO+aU2fXqVlQ3A0GnKsghrgxt9+zOnq
 A6aBqc+Q8OEJcJ1N5EzLxBBjFjtC8HvkfFMCw6cvalmLtBDlyA3RpKf9AB2yZ/ugOB5z
 D+adWTydO0ZAda5JdpVmWlewNprmBvWWdgW2v0CXXs1xa8B6Rwajbf9Eu+gQYdZAiuB2
 dO8/cfbTi3ic0h3AQqwlxBrWQbXZhIZkMUoMSxnEz/5uMZNM6+ifftPT2ni1Q5L4VNP0
 zIOzhnd8sXQ6zFpkne2aB5PgZcDtjgVt+c3TXK/DrUnEfE5CLUyHm2qtHSTcAq5swFnM
 wKPg==
X-Gm-Message-State: AOAM532SvHAiF/oeNBKWxDmTdmk5QNYh0qWxxHTVkVHRrEDCAae8SCq2
 MDEDbiNQAmU8qSOYCxCx2zrzy9NXHffDHBVHtH4iBVNmI+m3kghlZEwsKtm+lNdgdEw6eZOEVHR
 snE3k57zYwIJyY0k=
X-Received: by 2002:adf:efcc:: with SMTP id i12mr6233193wrp.308.1597151658386; 
 Tue, 11 Aug 2020 06:14:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJximOrX4ndTC56X3oS5Gm0xyEvOpSMyMP0LgEghqenVVNIrUQJBsodOLvQ5AAZmZT5uSJO9Gw==
X-Received: by 2002:adf:efcc:: with SMTP id i12mr6233172wrp.308.1597151658141; 
 Tue, 11 Aug 2020 06:14:18 -0700 (PDT)
Received: from redhat.com ([147.161.12.106])
 by smtp.gmail.com with ESMTPSA id g188sm5809032wma.5.2020.08.11.06.14.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2020 06:14:17 -0700 (PDT)
Date: Tue, 11 Aug 2020 09:14:09 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH v2] virtio-rng: return available data with O_NONBLOCK
Message-ID: <20200811090814-mutt-send-email-mst@kernel.org>
References: <20200715133255.10526-1-mwilck@suse.com>
 <7cfc4316-922b-8606-72ce-80205ef55572@redhat.com>
 <7affb721-9686-1262-b7cf-d9681646b602@redhat.com>
 <810451cf80032d131d5d3feb4fc8300549516f3d.camel@suse.com>
 <b764a4bb-b81f-b14f-9b7f-d6d087a8b1ea@redhat.com>
 <b8b19be7fd9b3fab629506eb30d9f0c820aa57d2.camel@suse.com>
 <085f699b-e391-7363-b63e-3b11cc04e50d@redhat.com>
MIME-Version: 1.0
In-Reply-To: <085f699b-e391-7363-b63e-3b11cc04e50d@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/11 06:40:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: Amit Shah <amit@kernel.org>, Jason Wang <jasowang@redhat.com>,
 qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Martin Wilck <mwilck@suse.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Aug 11, 2020 at 03:00:14PM +0200, Laurent Vivier wrote:
> No problem. This code is tricky and it took me several months to really
> start to understand it ...

Oh great, we actually have someone who understands the code!
Maybe you can help me understand: virtio_read
takes the buf pointer and puts it in the vq.
It can then return to caller (e.g. on a signal).
Device can meanwhile write into the buffer.

It looks like if another call then happens, and that
other call uses a different buffer, virtio rng
will happily return the data written into the
original buf pointer, confusing the caller.

Is that right?

-- 
MST


