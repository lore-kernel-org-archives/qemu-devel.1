Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DDFAC33C9E
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 12:15:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4A5E206DB
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 12:15:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="djw5ZjFv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4A5E206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42692 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipAFU-0004Xy-Jq
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 07:15:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52822)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1ipAEN-0003Za-Gt
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 07:14:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1ipAEL-0000EC-4t
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 07:14:34 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35083
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ipAEK-0000DJ-OQ
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 07:14:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578485671;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2PSTrkEUmEq8yVtCMe4CZo86wKH2aSQYOOHALIiDO9Q=;
 b=djw5ZjFvWUJHTCyAdc9awIOSe28vg4k3UFYfkZEBTsZW+FgvX61YgjjaGLIgLx1tvQxAZA
 9BjPGUV/wC9ePP2RLPX83h4zkjJXwrnnbkWq8xfTPBwGZP5rDKLJe78+vLcQMTzkJ+1vzF
 Vc5CaUJ+7Xg9nMVeGnLcyYPAtEWLX7A=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-411-MwbUz-3OMGGIr573mp63Pw-1; Wed, 08 Jan 2020 07:14:30 -0500
Received: by mail-wr1-f71.google.com with SMTP id f10so1364695wro.14
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2020 04:14:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=2PSTrkEUmEq8yVtCMe4CZo86wKH2aSQYOOHALIiDO9Q=;
 b=Cj/hsj95sniiRUBGw9MbHIvj62wF9HklPguq/qpMQ/OGcCCn7+PboP5ah12PJYsjYo
 pbzGzxjaMiq7tO9TbvsWN4ZMxAqzgb4v+9m3OQeLGFURRfArMRN0ZVzU161UgXTtYFYb
 7MgskJs6YXc8n3XsBvqVaWEA1sx/RkmRBJpMKiL/pxlozbjJO7FoBnvCk3rP2yPwhipg
 xrVgNtrx7UoTbZG1D0F9pi99wtqmuMjEUZcmByqdHeolv5tEUqTWtTiMqrud7cXmOkJE
 uoE90EvfBzBzs8vkkFPtt9zmAAl5A1tg3LSIz7+GcCfpCg++PJ4POBtK9Dlal3IpGi6O
 RAyA==
X-Gm-Message-State: APjAAAV44y9BTT91wWzgcVWNnGFPXPRBnvjcxM/suT2mgGkaYz8hS/Ht
 p9N4ZhuXiY9SUYn7TTJ7W+VFbDCouYU44jSp8yLymP6DWjoXYTNiisQ8uSy+5zUhYqKqwRUKqWp
 h+DxTpLZQMTQ3QCs=
X-Received: by 2002:adf:f2c1:: with SMTP id d1mr4095621wrp.111.1578485669009; 
 Wed, 08 Jan 2020 04:14:29 -0800 (PST)
X-Google-Smtp-Source: APXvYqwLGE/Zayzc49T6bqeK61OFosdnZKZRkB2vBFrvaZfvZhQaNJMurCIIG/d6QNkxUTpCIohnfQ==
X-Received: by 2002:adf:f2c1:: with SMTP id d1mr4095601wrp.111.1578485668742; 
 Wed, 08 Jan 2020 04:14:28 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c6d:4079:b74c:e329?
 ([2001:b07:6468:f312:c6d:4079:b74c:e329])
 by smtp.gmail.com with ESMTPSA id f207sm4000109wme.9.2020.01.08.04.14.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jan 2020 04:14:27 -0800 (PST)
Subject: Re: [External] Re: discuss about pvpanic
To: zhenwei pi <pizhenwei@bytedance.com>,
 Michal Privoznik <mprivozn@redhat.com>
References: <2feff896-21fe-2bbe-6f68-9edfb476a110@bytedance.com>
 <dd8e46c4-eac4-046a-82ec-7ae17df75035@redhat.com>
 <d0c57f84-a25c-9984-560b-2419807444e1@redhat.com>
 <05c5fcc0-24bd-ae6e-6bb8-23970ab0b56c@redhat.com>
 <d915c9e6-1ad7-4f8f-a66a-c418d43e977f@bytedance.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2b4b61b0-a586-83e7-dea8-a4942da32024@redhat.com>
Date: Wed, 8 Jan 2020 13:14:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <d915c9e6-1ad7-4f8f-a66a-c418d43e977f@bytedance.com>
Content-Language: en-US
X-MC-Unique: MwbUz-3OMGGIr573mp63Pw-1
X-Mimecast-Spam-Score: 0
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
Cc: "libvir-list@redhat.com" <libvir-list@redhat.com>,
 Greg KH <gregkh@linuxfoundation.org>, qemu-devel@nongnu.org,
 linux-kernel@vger.kernel.org, "yelu@bytedance.com" <yelu@bytedance.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 08/01/20 11:33, zhenwei pi wrote:
> In previous patch(https://lkml.org/lkml/2019/12/14/265), I defined a new bit (bit 1)
> PVPANIC_CRASH_LOADED for guest crash loaded event. And suggested by KH Greg, I moved
> the bit definition to an uapi header file.
> Then QEMU could include the header file from linux header and handle the new event.

Sure; QEMU has already got a mechanism to import files from Linux
(scripts/update-linux-headers.sh).

Paolo


