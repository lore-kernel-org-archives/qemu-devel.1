Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2227AC432C0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 11:57:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2B122068E
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 11:57:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NoDC0fwm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2B122068E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52244 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ic6ny-0008OO-3q
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 06:57:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43360)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1ic6iJ-000721-Nl
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 06:51:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1ic6i9-0007OO-N3
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 06:51:24 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:30470
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ic6i8-0007Lw-Ko
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 06:51:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575373878;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A3LLEr3E3K2K7Bi4eRhsJUF7iecTI7a84MLmxXEs2TM=;
 b=NoDC0fwmIb3pp44fwjA9QzKtlL/liR3Cg3/rfrUGty5Y22paAwh842KzqHqN2XX+n7NbwL
 DGC5o1KxEw5xHqr4J2BnreqFjziJnVkLmCPhLUIiU21LIaAzcl/JbYcvisgQe2c/kwUv7K
 IttXZXNq3W4aW/DCZEZK0WE/jN9Klqw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-434-wpJZxNqmN_KdV1y5ghAhMw-1; Tue, 03 Dec 2019 06:51:15 -0500
Received: by mail-wm1-f71.google.com with SMTP id n4so872782wmd.7
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2019 03:51:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=A3LLEr3E3K2K7Bi4eRhsJUF7iecTI7a84MLmxXEs2TM=;
 b=rjTiI9liO1vZM7zZfucmTOXfbO+WDhX8v7a7C4jciz0uKcfSQ88ADpzhdXU241bLhW
 2ncInC4n3fp3NHvSquJB1PtMA4nfsL6kKo/8uhCebZlZH0co9k/CsXK9piDbLjwJptDb
 KITHCAw+62Y9yOmrFQHLTZupB5Lpm/6LesYSyID0TVsdzqdVgSW3y3IZ9OdgxI5BKqU6
 PYfg+WPN4F76fbdUnlExqkCGH2nKLs1BLiWRM36EzJ6N8BUAKbXdhEtDUF2vR7l8G9tO
 syAQrxNQCxFpqKNzyMFG1RQLRxhWV2KXKp6XWMBI5XKn3cCBE006/KjL+QxRyqZq5lgm
 sS4Q==
X-Gm-Message-State: APjAAAW4SdiBb3n6wFt3FR99flZEigZ+Y6XvpHKcfKwMJ8I9DmyReQ/a
 ah+Km1sjUCpyQsSpsL4jDIsTI4RI82tg8Q4iqpPxGVQXGxJwPKLGHVhLDV4+w0iAImCslHe6Vtv
 AWihPNKeWi8NQzK4=
X-Received: by 2002:a5d:62d0:: with SMTP id o16mr4551159wrv.197.1575373874044; 
 Tue, 03 Dec 2019 03:51:14 -0800 (PST)
X-Google-Smtp-Source: APXvYqwzTWLMF+Uyo0fvl0anTPTuHWtgvHul7ur9JIHUJI8XLSvNVHfnBGxbGyXpfrF1aoDfBpr+mw==
X-Received: by 2002:a5d:62d0:: with SMTP id o16mr4551136wrv.197.1575373873776; 
 Tue, 03 Dec 2019 03:51:13 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:8dc6:5dd5:2c0a:6a9a?
 ([2001:b07:6468:f312:8dc6:5dd5:2c0a:6a9a])
 by smtp.gmail.com with ESMTPSA id f19sm3373240wrf.23.2019.12.03.03.51.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Dec 2019 03:51:13 -0800 (PST)
Subject: Re: [PATCH] virtfs-proxy-helper: switch from libcap to libcap-ng
To: Greg Kurz <groug@kaod.org>
References: <20191129111632.22840-2-pbonzini@redhat.com>
 <20191129133241.738b70ed@bahia.w3ibm.bluemix.net>
 <4e49ea13-fe0c-2b06-052e-474d714b88ad@redhat.com>
 <20191129135937.74a9b264@bahia.w3ibm.bluemix.net>
 <20191203113449.4b2e129e@bahia.w3ibm.bluemix.net>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <cd75561d-a10b-94d5-12c1-75aeac61ca0c@redhat.com>
Date: Tue, 3 Dec 2019 12:51:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191203113449.4b2e129e@bahia.w3ibm.bluemix.net>
Content-Language: en-US
X-MC-Unique: wpJZxNqmN_KdV1y5ghAhMw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: Thomas Huth <thuth@redhat.com>, berrange@redhat.com, qemu-devel@nongnu.org,
 dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 03/12/19 11:34, Greg Kurz wrote:
> On Fri, 29 Nov 2019 13:59:37 +0100
> Greg Kurz <groug@kaod.org> wrote:
> 
>> On Fri, 29 Nov 2019 13:49:20 +0100
>> Paolo Bonzini <pbonzini@redhat.com> wrote:
>>
>>> On 29/11/19 13:32, Greg Kurz wrote:
>>>> Nice. :)
>>>>
>>>> Reviewed-by: Greg Kurz <groug@kaod.org>
>>>>
>>>> Paolo,
>>>>
>>>> I can take this through my 9p tree if you want. Otherwise,
>>>>
>>>> Acked-by: Greg Kurz <groug@kaod.org>
>>>
>>> Yes, please do it since it's self-contained.  You'd probably also test
>>> it better than me. :)
>>>
>>> Paolo
>>>
>>
>> Ok I'll just do that then.
>>
> 
> And it happens to be missing an extra-change in Makefile :)
> 
> -fsdev/virtfs-proxy-helper$(EXESUF): LIBS += -lcap
> +fsdev/virtfs-proxy-helper$(EXESUF): LIBS += -lcap-ng

The new line is not needed, -lcap-ng should already be in LIBS via

LIBS+=-lz $(LIBS_TOOLS)

However, removing -lcap is certainly a good idea. :)

Paolo


