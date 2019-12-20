Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 375B1C43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 13:18:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 003D621D7E
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 13:18:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="POfyqAOf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 003D621D7E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55238 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiIAu-0004xE-4H
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 08:18:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37947)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iiI7R-0002JY-NI
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 08:15:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iiI7Q-0005Uy-K8
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 08:15:01 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60525
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iiI7Q-0005T3-EY
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 08:15:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576847699;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KOigBFCs1UONIqeb7rGBGPiNgu8rh+b4vF9G2Emd6l4=;
 b=POfyqAOfTPpP7GnTYYc3jpnZZpWn3xM3UegoBP+asSI69nU/qvsO30Mt75qAkiZgZ2PLlH
 82qY1FQBLq8psZcxK8zAu0PrD0y9odsI3tB3YOSDSqLM5n6Z3eBAzzr0GHGUHCpaU69Mq+
 3bk9cGU265FIEDDM3Cmyeb+T6IAvUIQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-408-RiIPDmYONaS76tV_GlJ_dg-1; Fri, 20 Dec 2019 08:14:58 -0500
Received: by mail-wr1-f72.google.com with SMTP id z15so1134349wrw.0
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2019 05:14:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=KOigBFCs1UONIqeb7rGBGPiNgu8rh+b4vF9G2Emd6l4=;
 b=pbGNlVSSz/oCa7dGxysLSgOIu17JnKVR7CAyRm2DyplcR+06EijsWWZeXu1K+M+qUI
 Yh0Pqg4n/sReR4dObWhf5eqTlw1wwPKX2JN8kf8x2+Qfth336eW0quDzfgQHXQ1pSGqo
 y+UWYHDglX28v/y8pS5Jxf+12CiVSF/aPoykxditRxfrA1lBqblCIZZk6WXTi6Ygc3Kr
 R6BZ8OLOtr+nAABFUv6KQs7hj6Aknu2XIbiJ1inKdFyqFt0+rhdvaHGE5cO4xtLt5HOn
 ODNk9NnOEkUC5hubAz6yAazYsB7T6B+k9ZYKU8s0OniJAy8sk9xg84tuVJ627t8hoTiO
 mOYg==
X-Gm-Message-State: APjAAAVNG/i5vHEoUO95IofFAsrcmD8MxYOyq4igUUUwthpAp72I4rUU
 wrkK5jv1+ZMCFuLEeneyFxd2bkWWB0Lil4BEGLETqx9dHqZX5rDQ9jKEMlD1VI3RXg0MT17L+G7
 tMvu2r3InwpRYAyA=
X-Received: by 2002:a5d:5592:: with SMTP id i18mr14318169wrv.55.1576847697544; 
 Fri, 20 Dec 2019 05:14:57 -0800 (PST)
X-Google-Smtp-Source: APXvYqyY/JqsahBeN1ZEOZu33UuHW2+e/iotAdu5snFQxj45Nn0SOb+UPG4CmODQW1WdzorCKZxgdA==
X-Received: by 2002:a5d:5592:: with SMTP id i18mr14318143wrv.55.1576847697318; 
 Fri, 20 Dec 2019 05:14:57 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:ac09:bce1:1c26:264c?
 ([2001:b07:6468:f312:ac09:bce1:1c26:264c])
 by smtp.gmail.com with ESMTPSA id g21sm10203526wrb.48.2019.12.20.05.14.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Dec 2019 05:14:56 -0800 (PST)
Subject: Re: [PATCH 0/2] numa: stop abusing numa_mem_supported
To: Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
References: <1576154936-178362-1-git-send-email-imammedo@redhat.com>
 <20191219142851.42cd33ff@redhat.com>
 <20191219083024-mutt-send-email-mst@kernel.org>
 <20191219144209.3c80dd69@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <465595b7-eadd-7fb7-deba-fee7b0ae1440@redhat.com>
Date: Fri, 20 Dec 2019 14:14:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191219144209.3c80dd69@redhat.com>
Content-Language: en-US
X-MC-Unique: RiIPDmYONaS76tV_GlJ_dg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Tao Xu <tao3.xu@intel.com>, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 19/12/19 14:42, Igor Mammedov wrote:
> On Thu, 19 Dec 2019 08:30:34 -0500
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
>> On Thu, Dec 19, 2019 at 02:28:51PM +0100, Igor Mammedov wrote:
>>> On Thu, 12 Dec 2019 13:48:54 +0100
>>> Igor Mammedov <imammedo@redhat.com> wrote:
>>>   
>>>> A fix  and cleanup for a mistakes that slipped by me in
>>>>   aa57020774 (numa: move numa global variable nb_numa_nodes into MachineState)  
>>>
>>> ping,
>>>
>>> could someone pick it up please?  
>>
>> Looks more like Eduardo's thing.
> 
> Yep if he is still available,
> but I wasn't sure with coming winter break.
> 
> In addition, this patch will be prerequisite for disabling
> deprecated '-numa node,mem'
> hence broadcast ping to make sure it won't get lost.

I'll take care of it (after new year).

Paolo


