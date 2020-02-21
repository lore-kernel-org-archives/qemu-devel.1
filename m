Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5391AC35643
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 08:26:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CE3B24670
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 08:26:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Uj5IG/OJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CE3B24670
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53592 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j53e5-0007Ec-9R
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 03:26:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53972)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1j53dJ-0006hD-8w
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 03:26:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1j53dI-0003mr-Bj
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 03:26:01 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46148
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1j53dI-0003kx-5w
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 03:26:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582273559;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7KoXbgVHVj4oM2Uzto/agKsBDKFhabk9A1pD39By7/U=;
 b=Uj5IG/OJnkORi3+iybiQTNSv0WYh7Up8JWvEE/pLgeVXJP8vIKf1UUOOXHJNVJ3wLqQhNg
 WqH32Msxlms40ndgEJFnJFe1gHacUD8eDYkb+fPhkBPgw17DW3p3XADDEn6hE+ryWyhtkt
 em+CQ+f0RIVOOMj8WrkqxK8g9qsNUsc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-447-J_yAj5WlNSOrJXGRRKv1-Q-1; Fri, 21 Feb 2020 03:25:57 -0500
Received: by mail-wm1-f70.google.com with SMTP id p2so277393wma.3
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2020 00:25:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=7KoXbgVHVj4oM2Uzto/agKsBDKFhabk9A1pD39By7/U=;
 b=t65tRjFSXJSHNQin21t9mmCuPBg3YQVtBftg3WUSLH/oSS3J+rV9rP+40/4JoKk2Hz
 uMKdvH7urvfMrjy/mt3BEnX02ymdQLPnvmbAFimchzV10xrJCEyoRH4j4p9QXzP53b5p
 0QDrUlN91ULkIY56xzGrZSpfe3MVLEnIZXJDt8y57xeaYUlq96tFQbOTVANB2KXewYCk
 ienVXPJMxVHzizq65vTswpsXeKhGJDsUbuTvyxDomUhjjUDsOw51IGv5MqjIs0K8MqLp
 c9/BQM08v3xFPdfTKdwS7EN262dZ0Es4xiIV36q8crA/YNq4/sz2rKhbXRQ3OzHFZgmi
 6t5w==
X-Gm-Message-State: APjAAAW/5FD6LfzPwtOxfGln1IJd4olW1YeOT5KjXn004/5/qEhRBoHX
 mwUqEpAn3nmEMB0KCZgG9Nx9ZRuGLQon1Q2PO+ZpA27zHRt1viQIQUX8AYM6GeqzvUvkUk95Yes
 ucRhzGj4yDTrAglM=
X-Received: by 2002:a1c:c5:: with SMTP id 188mr2160426wma.187.1582273556823;
 Fri, 21 Feb 2020 00:25:56 -0800 (PST)
X-Google-Smtp-Source: APXvYqyNTRMgX713vcAwh/0eAoyOKckiV1hCQ4nQFLvgUgpH4YNSKz+VGUW/AWaOOsew2AhY9l5Eeg==
X-Received: by 2002:a1c:c5:: with SMTP id 188mr2160375wma.187.1582273556428;
 Fri, 21 Feb 2020 00:25:56 -0800 (PST)
Received: from [192.168.178.40] ([151.20.135.128])
 by smtp.gmail.com with ESMTPSA id r6sm3065160wrq.92.2020.02.21.00.25.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Feb 2020 00:25:55 -0800 (PST)
Subject: Re: [PATCH] hw/char/pl011: Enable TxFIFO and async transmission
To: Gavin Shan <gshan@redhat.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20200221044908.266883-1-gshan@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <12b3d4d4-736b-e861-6b6b-5b6885b7cbf1@redhat.com>
Date: Fri, 21 Feb 2020 09:25:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200221044908.266883-1-gshan@redhat.com>
Content-Language: en-US
X-MC-Unique: J_yAj5WlNSOrJXGRRKv1-Q-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: peter.maydell@linaro.org, maz@kernel.org, shan.gavin@gmail.com,
 marcandre.lureau@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 21/02/20 05:49, Gavin Shan wrote:
> @@ -306,6 +362,7 @@ static const VMStateDescription vmstate_pl011 = {
>          VMSTATE_UINT32(int_enabled, PL011State),
>          VMSTATE_UINT32(int_level, PL011State),
>          VMSTATE_UINT32_ARRAY(read_fifo, PL011State, 16),
> +        VMSTATE_UINT8_ARRAY(write_fifo, PL011State, 16),
>          VMSTATE_UINT32(ilpr, PL011State),
>          VMSTATE_UINT32(ibrd, PL011State),
>          VMSTATE_UINT32(fbrd, PL011State),
> @@ -313,6 +370,7 @@ static const VMStateDescription vmstate_pl011 = {
>          VMSTATE_INT32(read_pos, PL011State),
>          VMSTATE_INT32(read_count, PL011State),
>          VMSTATE_INT32(read_trigger, PL011State),
> +        VMSTATE_INT32(write_count, PL011State),

Hi Gavin, please add these two fields to a subsection, so that they are
emitted only if write_count > 0.

Thanks!

Paolo

>          VMSTATE_END_OF_LIST()
>      }
>  };
> diff --git a/include/hw/char/pl011.h b/include/hw/char/pl011.h
> index 14187165c6..aeaf332eca 100644
> --- a/include/hw/char/pl011.h
> +++ b/include/hw/char/pl011.h
> @@ -38,6 +38,7 @@ typedef struct PL011State {
>      uint32_t int_enabled;
>      uint32_t int_level;
>      uint32_t read_fifo[16];
> +    uint8_t  write_fifo[16];
>      uint32_t ilpr;
>      uint32_t ibrd;
>      uint32_t fbrd;
> @@ -45,6 +46,7 @@ typedef struct PL011State {
>      int read_pos;
>      int read_count;
>      int read_trigger;
> +    int write_count;
>      CharBackend chr;
>      qemu_irq irq[6];
>      const unsigned char *id;
> 


