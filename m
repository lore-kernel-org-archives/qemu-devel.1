Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F221C433E3
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 12:45:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29BF8207BB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 12:45:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EQcRHHEW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29BF8207BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyabL-0006YV-Ew
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 08:45:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39392)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jyaaT-0005u0-T8
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 08:44:37 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:42987
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jyaaR-0005ww-Lo
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 08:44:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595508274;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xC7Tj39CjdXAN8iTuIpZLrGpZUblquZV8bI/RY9S8s0=;
 b=EQcRHHEWVOQlFxLcbFGVvFdQfghj3McQRUV03qp8ING2PDdDdPm9Kt9ASyhqwwknK4Ip6r
 rWcH0M2dqAW4dGW3DZXWC8oWZr8uYEgxQwgGZ+W06dSPiI8Ayme2ctInd0B8viSLW+zYHH
 PwmWAzJSZBXZuUwHISHdBitEYL/+vcE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-99-b-lYA3qsPA-W_fHfpmZTrg-1; Thu, 23 Jul 2020 08:44:33 -0400
X-MC-Unique: b-lYA3qsPA-W_fHfpmZTrg-1
Received: by mail-wr1-f70.google.com with SMTP id 89so1363041wrr.15
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2020 05:44:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=xC7Tj39CjdXAN8iTuIpZLrGpZUblquZV8bI/RY9S8s0=;
 b=kRe6YIn3tdlvfNbTIQwJFdaliFXrd7XRuXLz72Tdt3pPe6j/n3AnaQUERVx+GzhwTw
 P0sslDogIM1hD8w1ZRxCp6JZayVQdQNDF12sUNNQS9B4OraCjBHkcDZgkX37rk4VkLHa
 1H1y6rLEoVferkYhCSa0FRXFFLYOXRqj2QvOUugQzLpVhQpAPtbhDSNWyJpPxXO8YEIC
 gL+FL+rdAtuZZRJ6HhpPhlV+vAOno74tUHWNUUNmiRJ8l8QS7l+EW5NVhywvXVRW8I0J
 n1lAiEduS7R2Nzr7zvr0YB4lc04GjIilRmQ/7AAxizi9IFY7CmfbUksZKfSRpVV+WCKS
 udrA==
X-Gm-Message-State: AOAM531o8EohiIa0lIAuxqGRqHmowg4H86PIczkdZlQiy8teOiyOO6tm
 GsdpA3bqWITSsMhLTW1qsiiBXNFjS2AJQbQyCVJeOVPLWBTBmzhQHARh3DBQdTDJsy5qav1Xpo0
 WUTxO7ULY1so5mRA=
X-Received: by 2002:a1c:2045:: with SMTP id g66mr3834101wmg.184.1595508271944; 
 Thu, 23 Jul 2020 05:44:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxF/uwQfWadWmhHCBAhPE/+bbgrf3Yz5NhYGZNSQXFyB4NYcKbQ2eoikTQbaKcO8HEmPQyGwA==
X-Received: by 2002:a1c:2045:: with SMTP id g66mr3834080wmg.184.1595508271700; 
 Thu, 23 Jul 2020 05:44:31 -0700 (PDT)
Received: from redhat.com (bzq-79-179-105-63.red.bezeqint.net. [79.179.105.63])
 by smtp.gmail.com with ESMTPSA id v5sm3228590wmh.12.2020.07.23.05.44.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2020 05:44:30 -0700 (PDT)
Date: Thu, 23 Jul 2020 08:44:27 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Anthony PERARD <anthony.perard@citrix.com>
Subject: Re: [PATCH] acpi: Fix access to PM1 control and status registers
Message-ID: <20200723084405-mutt-send-email-mst@kernel.org>
References: <20200701110549.148522-1-anthony.perard@citrix.com>
 <20200701075914-mutt-send-email-mst@kernel.org>
 <20200701124836.GD2030@perard.uk.xensource.com>
 <20200702063310-mutt-send-email-mst@kernel.org>
 <20200710094258.GF2030@perard.uk.xensource.com>
MIME-Version: 1.0
In-Reply-To: <20200710094258.GF2030@perard.uk.xensource.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/23 02:26:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery <andrew@aj.id.au>,
 Alistair Francis <alistair@alistair23.me>, qemu-devel@nongnu.org,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, pbonzini@redhat.com,
 Igor Mammedov <imammedo@redhat.com>, "open list:PReP" <qemu-ppc@nongnu.org>,
 Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jul 10, 2020 at 10:42:58AM +0100, Anthony PERARD wrote:
> On Thu, Jul 02, 2020 at 07:12:08AM -0400, Michael S. Tsirkin wrote:
> > memory: align to min access size
> > 
> > If impl.min_access_size > valid.min_access_size access callbacks
> > can get a misaligned access as size is increased.
> > They don't expect that, let's fix it in the memory core.
> > 
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > 
> > ---
> > 
> > 
> > diff --git a/memory.c b/memory.c
> > index 9200b20130..ea489ce405 100644
> > --- a/memory.c
> > +++ b/memory.c
> > @@ -532,6 +532,7 @@ static MemTxResult access_with_adjusted_size(hwaddr addr,
> >      }
> >  
> >      /* FIXME: support unaligned access? */
> > +    addr &= ~(access_size_min - 1);
> >      access_size = MAX(MIN(size, access_size_max), access_size_min);
> >      access_mask = MAKE_64BIT_MASK(0, access_size * 8);
> >      if (memory_region_big_endian(mr)) {
> 
> I've tried this (and .impl.min_access_size=2) but that wasn't enough.
> 
> In the guest, I did `inb(base_addr + 1)`, but I've got back the value as
> if `inb(base_addr)` was run.
> 
> The device emulation read callbacks did get addr=0 width=2, so that's
> fine, but the result returned to the guest wasn't shifted. Same thing
> for write access, the write value isn't shifted, so a write to the
> second byte would be written to the first.
> 
> Thanks,

So is there still an issue with my latest pull req?
Or is everything fixed?


> -- 
> Anthony PERARD


