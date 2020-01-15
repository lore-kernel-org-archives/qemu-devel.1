Return-Path: <SRS0=2fDQ=3E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B12FDC32771
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 16:42:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EE652081E
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 16:42:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NrNuslfk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EE652081E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56988 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irlke-0002U4-KO
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 11:42:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57863)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1irl2E-0000Hp-2d
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 10:56:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1irl27-0007Oz-Pv
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 10:56:43 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:49677
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1irl27-0007OE-Ld
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 10:56:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579103796;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nZpmwQKxwXROtuAyOfXnZyQm1rjRPpx/VyQokxymeNc=;
 b=NrNuslfkqkimyShHSeTur1Rp4BFtV3OyNW4MiOPIKUNnVhwiV2j1flI+w28t6Z36WMEpNo
 e1j5qRqUyRPXMaSjlWWGdIgMrUvwHhVY/ZG9ILPWTupRRVV/srdS4HgsarjlwL1yTPtcDD
 QJOCXONoatuzxgp77p+ucyNb8fPRlX0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-323-0yr8jGieNBGfni3UfeHpSg-1; Wed, 15 Jan 2020 10:56:33 -0500
Received: by mail-wm1-f69.google.com with SMTP id w205so106633wmb.5
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2020 07:56:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nZpmwQKxwXROtuAyOfXnZyQm1rjRPpx/VyQokxymeNc=;
 b=ATS5ILunuxm01DdOGRHrinRSGCA30VUOOCc6PUeh7Hyzf1HGNMcomwH6Kx5C0nMG6b
 NJcykXJoeXs5Ui9UtJcDUzohA/fsMVrSfPXzOD+qRLDreT5ua3Yek+cJFcmwz6+tbr9P
 ClFr/cHuinMascQBOR40dUgzvaRmicXyTVHOZhsFq2f2wAKn9yXW88VlJoAMytOBiHi/
 6S5rE4WJplB/JfZMZY2ix+TrTu2qHZqT1f+1nUwok5CYhaaA99wpANuneAa4KMfgngd6
 VVrwwe2ckSzBzvYnIRIdUxFDmCH1RvPWCuYQQDlZd9oCwtsqCjTlVunXbkfAT943EgFg
 ijSQ==
X-Gm-Message-State: APjAAAVgiT1bvMmLGjkORTUwv6g22+79K889pLtlX4zvVHG4Phcv3eNq
 X7HEDY6ZtPuaDPFAoYO7WpHGC7tXjU4yrM5nIQb63ThYxwTQUSVt8SwNN9Y9nA6KvIXftSaX4Ec
 2dl4FumvhiW/yh6o=
X-Received: by 2002:adf:fe43:: with SMTP id m3mr32773970wrs.213.1579103792307; 
 Wed, 15 Jan 2020 07:56:32 -0800 (PST)
X-Google-Smtp-Source: APXvYqwDkfFJ6l82nKphKAo5+3miNaDYTqrRPBK3zBorzutga3YmU57NCCQT15LjAmLfzeqfXpYShw==
X-Received: by 2002:adf:fe43:: with SMTP id m3mr32773948wrs.213.1579103792067; 
 Wed, 15 Jan 2020 07:56:32 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:436:e17d:1fd9:d92a?
 ([2001:b07:6468:f312:436:e17d:1fd9:d92a])
 by smtp.gmail.com with ESMTPSA id o16sm340692wmc.18.2020.01.15.07.56.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Jan 2020 07:56:31 -0800 (PST)
Subject: Re: [PATCH v2 02/86] machine: introduce ram-memdev property
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <1579100861-73692-1-git-send-email-imammedo@redhat.com>
 <1579100861-73692-3-git-send-email-imammedo@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <80dae4c8-a902-4f9e-9878-95b69f9390df@redhat.com>
Date: Wed, 15 Jan 2020 16:56:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <1579100861-73692-3-git-send-email-imammedo@redhat.com>
Content-Language: en-US
X-MC-Unique: 0yr8jGieNBGfni3UfeHpSg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 15/01/20 16:06, Igor Mammedov wrote:
>  
> +    object_property_add_link(obj, "ram-memdev", TYPE_MEMORY_BACKEND,
> +                             (Object **)&ms->ram_memdev,
> +                             object_property_allow_set_link,
> +                             OBJ_PROP_LINK_STRONG, &error_abort);
> +    object_property_set_description(obj, "ram-memdev",
> +                                    "Set RAM backend"
> +                                    "Valid value is ID of hostmem based backend",
> +                                     &error_abort);
> +

Obligatory bikeshedding, why not just ram (the MachineState field can
remain "ram_memdev").  Or memory-backend matching the QOM type names.

Paolo


