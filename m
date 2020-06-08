Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74C7AC433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 14:18:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 402982076C
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 14:18:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O1jxZEs7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 402982076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51682 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiIbz-0001NK-CH
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 10:18:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53168)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jiIZP-0007fp-Vk
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 10:16:13 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60002
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jiIZP-0004Ir-6J
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 10:16:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591625769;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=naE/KBqSLqVR0OFsSAmkm2Q+4eefA4nokgtoyr4TRgQ=;
 b=O1jxZEs7QzrXSj0e52JUe5HWgnzzg/Cuk3epjDG7Ct1jEgVY/PYwwAiN1usoxVK3dG4Npo
 j9oibXZrQB7J4ozV0SmJScmXc9Uet42F2YOaUxqqZtx9agflbAvfE6ZlZZ6uJ/sAIeFMb6
 f6sHfxLhyhgCPPGRTHmTwrwj5RXfiaI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-202-X8zhOEURMjmGeSs6U3ThAA-1; Mon, 08 Jun 2020 10:16:07 -0400
X-MC-Unique: X8zhOEURMjmGeSs6U3ThAA-1
Received: by mail-wr1-f70.google.com with SMTP id s7so7236030wrm.16
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2020 07:16:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=naE/KBqSLqVR0OFsSAmkm2Q+4eefA4nokgtoyr4TRgQ=;
 b=q5ktAtlTOhm/cH3iNJX90UR6rvWVNBkb4tYqBqcCBPqvmpGOShaBil6ZVKy0G9Dze6
 30rYH9FSfLl/6LBoNs3XIwBZSXM8XenbxXK35VTQvHnY1Ro1GP3jqkkLYCauHQGyUp/I
 CCN7pInuI11JvURpFQ8bAFzj1YJ7S3dSiwQ+DqVAQOmv2TJ9cHPJBHuJPnbn3twihozP
 6H852KBcm/TDs02rnSvcRpazo1M9tF7qmvWqXSpuUePhGVHvU8FdmgPTK7AKcWH1jpbQ
 1SA4ZYe2i1ltSVpZT72HHHVTIg/yxCZHW8wZU3z0UEGpWlhbryCaXpny9MXOAaOTFHM3
 wg7w==
X-Gm-Message-State: AOAM531YlZLeKzwIYpGzpPTebdS3Xf++WtV1Mfmk3mYFMLLflBghDNGY
 4XDN4eKm2LFv/QM99pGGvDZRU5HnkB13H/a/Y9NNSBlo1pZcSKTTJnzxM+CMZ/j5oI4AZbB1hQR
 6hV+ux6DSOpJIEZg=
X-Received: by 2002:a1c:bc42:: with SMTP id m63mr16993695wmf.11.1591625766378; 
 Mon, 08 Jun 2020 07:16:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJysaIilnzg7MWcIex4IhturJCQfgPb2y1b1d1ibkcytuTmBOyJx3H6ettfU37zc2MNJQUR30Q==
X-Received: by 2002:a1c:bc42:: with SMTP id m63mr16993672wmf.11.1591625766133; 
 Mon, 08 Jun 2020 07:16:06 -0700 (PDT)
Received: from [192.168.178.58] ([151.30.87.23])
 by smtp.gmail.com with ESMTPSA id r2sm24452168wrg.68.2020.06.08.07.16.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jun 2020 07:16:05 -0700 (PDT)
Subject: Re: [PATCH v1] hmp: Make json format optional for qom-set
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20200608140650.91517-1-david@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <652a6692-2ba4-94b0-503d-9cea876c859c@redhat.com>
Date: Mon, 8 Jun 2020 16:16:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200608140650.91517-1-david@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/08 01:05:50
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 08/06/20 16:06, David Hildenbrand wrote:
>      {
>          .name       = "qom-set",
> -        .args_type  = "path:s,property:s,value:S",
> -        .params     = "path property value",
> -        .help       = "set QOM property",
> +        .args_type  = "json:-j,path:s,property:s,value:s",

I think this should remain an uppercase "S", so that it grabs the rest
of the input rather than stop at the first space.

Paolo

> +        .params     = "[-j] path property value",
> +        .help       = "set QOM property.\n\t\t\t"
> +                      "-j: the property is specified in json format.",
>          .cmd        = hmp_qom_set,
>          .flags      = "p",
>      },
> diff --git a/qom/qom-hmp-cmds.c b/qom/qom-hmp-cmds.c


