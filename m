Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41729C4332B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 17:35:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E8A92071C
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 17:35:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TrX3DurJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E8A92071C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41078 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEz4t-0006Vs-56
	for qemu-devel@archiver.kernel.org; Thu, 19 Mar 2020 13:35:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35008)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jEz4A-000631-TB
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 13:34:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jEz49-00082O-Qi
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 13:34:46 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:50651)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jEz49-000824-Mr
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 13:34:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584639285;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QoIRjVNYoiWdjQmzlNlt7rH878cRuDdgQFsK64XfhyU=;
 b=TrX3DurJCu4GvOa4oAoo2IBcHc0MtEvfwQvX+CF6n7ou6U/4WoV0MSLfq6zlAz9rjcLjWq
 Uy+8onhcUuMeIzQsNqQyvRx9BWRB4Tt9UWp2quOG6UAUCoq6ac90gxjPzWY6oTwBB53W9s
 S2x0VblfvIdpC/KHmESZD6Hcfg9v234=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-389-e4f8gYpCOka1SFSqKVPDmA-1; Thu, 19 Mar 2020 13:34:43 -0400
X-MC-Unique: e4f8gYpCOka1SFSqKVPDmA-1
Received: by mail-wm1-f72.google.com with SMTP id z16so1297998wmi.2
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2020 10:34:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=QoIRjVNYoiWdjQmzlNlt7rH878cRuDdgQFsK64XfhyU=;
 b=PEOq9Y27ujwyL6kXzV83vYzi6H2XqHJyaBn8Fz05bVWTOi5TDWGCh0SKQL5UGimP3m
 7rp00XOaHg3z66xFng0KxuF6CYjhRbzSH66OBK8R/5hic83yj+zIx3//jA2b+LdGKjGh
 F/JFBaFIWCRqjrZdj/fXnFAW4u5UdEJ5vqqyTWZB1c3Y30nag8nP3MTSfLWWNQs4QbL7
 ceeqiht/IJKFZQOJ67vYc7a0O6mwCYsHGyJpNOf/TErRq4b1HQeZB8KlUBtIdd+WDBbH
 qAHLCvYJiUDRjSbtzd6FQjIv2w6idxTTQnNNfJGb+v2rK9/Fx9OXlCcuWCxscnA49qs5
 Dxkw==
X-Gm-Message-State: ANhLgQ26n2J2oPPrS0VdRAQ8XsbGF+VFyYs41hUFxIrhI2E5dtTJDWFO
 x+9CfROw8TaJC3IkW1u8qbgZdK2XzB30ghmTLQV8qXUuG7Vh7gc6uQb6XSyErmDMocCRkmzkDUp
 QoYXP+ddKUZMfNOg=
X-Received: by 2002:a7b:c75a:: with SMTP id w26mr4852972wmk.2.1584639282754;
 Thu, 19 Mar 2020 10:34:42 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vuv9Cwez6nDlgVnkMbc2CmIYdr/N1vSEd8thcDH0H18SRBmmFYH0eKXO8il6ykIxCzmG8hldg==
X-Received: by 2002:a7b:c75a:: with SMTP id w26mr4852955wmk.2.1584639282462;
 Thu, 19 Mar 2020 10:34:42 -0700 (PDT)
Received: from [192.168.178.58] ([151.21.15.43])
 by smtp.gmail.com with ESMTPSA id b67sm4023235wmh.29.2020.03.19.10.34.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Mar 2020 10:34:41 -0700 (PDT)
Subject: Re: [PATCH 00/13] microvm: add acpi support
To: Gerd Hoffmann <kraxel@redhat.com>
References: <20200319080117.7725-1-kraxel@redhat.com>
 <2ed586e7-d7a1-77b2-ecc6-01b6fb38d72e@redhat.com>
 <20200319134046.uh2qvyshwtj6ubox@sirius.home.kraxel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <259fbf57-6d1f-e3cd-d455-d2e6bc4e8b38@redhat.com>
Date: Thu, 19 Mar 2020 18:34:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200319134046.uh2qvyshwtj6ubox@sirius.home.kraxel.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 19/03/20 14:40, Gerd Hoffmann wrote:
>> Also, can you confirm that it builds without CONFIG_I440FX and
>> CONFIG_Q35?  You probably need to add "imply ACPI" and possibly some
>> '#include "config-devices.h"' and '#ifdef CONFIG_ACPI' here and there.
> Hmm, is there some way to do this without modifying
> default-configs/i386-softmmu.mak in the source tree?  So I can have two
> build trees with different confugurations?  Also to reduce the risk that
> I commit default-config changes by mistake?

No, there is no way yet.

Paolo


