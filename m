Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B46C54FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 22:04:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16F802076E
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 22:04:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nKHC1p+A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16F802076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRNTQ-0007gT-9A
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 18:04:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59040)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <anthoine.bourgeois@gmail.com>) id 1jRNST-0007G3-26
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 18:03:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <anthoine.bourgeois@gmail.com>) id 1jRNSS-0002IM-1L
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 18:03:04 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:40020)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <anthoine.bourgeois@gmail.com>)
 id 1jRNSR-0002DE-Kt
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 18:03:03 -0400
Received: by mail-wr1-x443.google.com with SMTP id k13so4450008wrw.7
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2020 15:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=1u1uCjEwWDSciclXAdwZl8LcamUjIYmXboaSy5WJT5U=;
 b=nKHC1p+A0bcXC1z8bUS4VVGDUE6rW8auvy1JZkA1qXu0J3FtUiQjV/JmfqfCCZ8dGd
 6RXqBh7Ygx/Gp3a8BKiBXxQ5vVGGtGi+Jgblc/AHlbwYZXqNdfM40FEmxNjJG9eTiZTY
 L7LMOdOZlH9dIv1uHKV4PVLxiXer99SvY8a9MQ8hqtpw7a5PM1llIAawjylv702Xugnk
 pZMHJ4MwHj6x79eAWySD//2hSsi62ZgWm44nKFRz2uOM8ZnE+dcJi9L+vjxGP3Hij6cS
 5kE5RuERv1QAdIbhUugBsVKb3+5JsyDEQIxG1Iuc5+D1Y0jiuoGITOqCwL4vFo/pyCOB
 SKpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=1u1uCjEwWDSciclXAdwZl8LcamUjIYmXboaSy5WJT5U=;
 b=bN4ifybcIx+yCayNh7IeOliFmNLn4SXZv7Hw3rLGmn6DqIv0IdmbO3GvDQESLwivAx
 U0Qzc2TGZ6c/85TGZ0ah+/ZWd5C4m73xGksEnaV5UZskL/+0pdmLMfX21Xg9RKSoB17y
 oHNiRreUXZIe95KjmdATgWZtdpF8L/GtzzJahNNTyiPO5av4MN3pJCNrJQM1sq/dCrav
 2OirH8YXbsU3wmviWwr57pmKGNLHwhXBF9vjsSdAOaW4/Tb6wPzXC0mqZ0vshZy+fZ3p
 Wjgm+X0qpq4dl3svz/X3dQxGs2Udjlx/N4UB2/R8diTQ9a+9SLNEgb8HADoe8jq1emDA
 U3FA==
X-Gm-Message-State: AGi0PubFCFsvCzwBlzTslEvQPg0O/6TuYqay2CDDNCayla3KAL6mOVFj
 cjRKN+H9MX/rKndAc3InnSY=
X-Google-Smtp-Source: APiQypJJ2qIpax03DizOdAKy/thSLv+qJ5t6Z5rnM0j6tJLnt65Wv/+v2Zuec1zS0QP13xmMB0TDDw==
X-Received: by 2002:adf:f8c6:: with SMTP id f6mr1381792wrq.276.1587592981984; 
 Wed, 22 Apr 2020 15:03:01 -0700 (PDT)
Received: from gmail.com ([2a01:e35:2fb2:a0d0:6d28:3d72:693e:c474])
 by smtp.gmail.com with ESMTPSA id f18sm812043wrq.29.2020.04.22.15.03.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2020 15:03:01 -0700 (PDT)
Date: Thu, 23 Apr 2020 00:02:58 +0200
From: Anthoine Bourgeois <anthoine.bourgeois@gmail.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH] virtio-vga: fix virtio-vga bar ordering
Message-ID: <20200422220257.GA17009@gmail.com>
References: <20200421214853.14412-1-anthoine.bourgeois@gmail.com>
 <20200422104657.4fnzkp66l2c2m2cw@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200422104657.4fnzkp66l2c2m2cw@sirius.home.kraxel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=anthoine.bourgeois@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::443
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
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Apr 22, 2020 at 12:46:57PM +0200, Gerd Hoffmann wrote:
>> This fix exchange the modern io bar with the modern memory bar,
>> replacing the msix bar that is never impacted anyway.
>
>Well, msix was placed in bar 4 intentionally.  That keeps bar 1 (default
>msix location) free, so we have the option to turn bar 0 (vga compat
>vram) into a 64bit bar without shuffling around things.

That's a really good reason I didn't think of.
Just a question, why didn't we choose the virtio-vga order to avoid
shuffling from the beginning? Vga came after and we keep the
compatibility ?

>
>> -    vpci_dev->msix_bar_idx = 4;
>
>Please don't.
>
>> +    vpci_dev->modern_io_bar_idx = 4;
>
>We can use bar 5 instead.
>
>Alternatively just throw an error saying that modern-pio-notify is not
>supported.

As you like. I sent a v2 with modern_io_bar_idx to 5 but I can do a v3
with an error thrown.

>
>> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
>> index 4cb784389c..9c5efaa06e 100644
>> --- a/hw/virtio/virtio-pci.c
>> +++ b/hw/virtio/virtio-pci.c
>> @@ -1705,6 +1705,7 @@ static void virtio_pci_realize(PCIDevice *pci_dev, Error **errp)
>>       *
>>       *   region 0   --  virtio legacy io bar
>>       *   region 1   --  msi-x bar
>> +     *   region 2   --  virtio modern io bar
>>       *   region 4+5 --  virtio modern memory (64bit) bar
>
>Separate patch please.  Also worth noting that the modern io bar is off
>by default.

Done.

Thank you,
Anthoine


