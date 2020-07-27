Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47D8DC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 14:43:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11D2D20714
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 14:43:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ve08nfQK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11D2D20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44480 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k04Le-0003b1-Cs
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 10:43:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54810)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k04Ku-0002Ee-85
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 10:42:40 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:20333
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k04Ks-0002du-Pt
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 10:42:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595860958;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LgUcK7AW317W7xaK4NEWuXJcDMIWeZWvFDqzfYiDQR8=;
 b=Ve08nfQKRxoC33boMUqBzE45xHWSBKvqQFOrgaZn+9eDoT8ZfdPr/6FsKh3ne9CUtjeS4s
 GIPmZg9H69BwWDQZo8yVkeZauQPx5dGRSMvHysQEQ8ePuf6SRWBMmqnZSVwp0pI9rc8U5P
 vKQKw/HD+YfvHNtXoHdDw9na/BoDrEA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-219-yx0MJFgdNKe77Ij5dTwlFQ-1; Mon, 27 Jul 2020 10:42:36 -0400
X-MC-Unique: yx0MJFgdNKe77Ij5dTwlFQ-1
Received: by mail-wr1-f70.google.com with SMTP id f14so3987019wrm.22
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2020 07:42:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=LgUcK7AW317W7xaK4NEWuXJcDMIWeZWvFDqzfYiDQR8=;
 b=aiefia6f08zAo55zK2bcWA14LDStJdkkXo7bO8XOsWPnIdNkybB7vefXIJ8542kl+A
 CW9QL0N8APzZ852rpv6pBV2WILgJkqSPLoeIMKDrrCZBQEJBBgACLUp6R3DMzRzfTrwK
 IOOTKxQ8ZN/2hJnbFcs7dkCtE5w3wJSAkdkSRDP9eqLCMwTXKdH3drIGhloRBbv0bVdJ
 lMMm18IfC2M6pecpXq4Ab1clZ8YoOVr60LZnQApGTjkyD9FXiwoIsoDPvSkJA7BwduwJ
 QNCWafAGWnQwFo0GIOAgPfQrC3ewo+yC+BSB1EZpxVcye8S8PSe/VKQHa6/tPTwv77Yo
 BzhQ==
X-Gm-Message-State: AOAM532AMN2FCOX4OYcXm+XrsaJpN0JD78hgYPpAJa3YTVJCQjJyekHl
 GDuGIxKYjPZTCIvo7IYxvwjExyoLLXlO4jC/HYCn2BhQy8/M9e/fprv7r97nIwvHfSKPkCSr6+f
 VfZg7N7G8QH6r3ss=
X-Received: by 2002:a5d:4bc8:: with SMTP id l8mr20234225wrt.159.1595860954434; 
 Mon, 27 Jul 2020 07:42:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwdCHtsjjLhqfdsbFH0iueUNGuEBnzdaP2I/FSOdNFxlctFz0hhNlwC0VYuC1vcsNKoBysuvg==
X-Received: by 2002:a5d:4bc8:: with SMTP id l8mr20234212wrt.159.1595860954221; 
 Mon, 27 Jul 2020 07:42:34 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:4502:3ee3:2bae:c612?
 ([2001:b07:6468:f312:4502:3ee3:2bae:c612])
 by smtp.gmail.com with ESMTPSA id i9sm18451892wmb.11.2020.07.27.07.42.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Jul 2020 07:42:33 -0700 (PDT)
Subject: Re: [PATCH-for-5.1 v2] hw/isa/isa-superio: Fix IDE controller
 realization
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200721124516.9602-1-f4bug@amsat.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1309c64b-3cdd-9512-0d8b-8467b54291f3@redhat.com>
Date: Mon, 27 Jul 2020 16:42:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200721124516.9602-1-f4bug@amsat.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 03:37:14
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: qemu-trivial@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 21/07/20 14:45, Philippe Mathieu-Daudé wrote:
> When realizing a Super I/O with IDE controller [*], we get:
> 
>   qom/object.c:1684: object_property_try_add_child: Assertion `!child->parent' failed.
>   Aborted (core dumped)
> 
> This is because the device is already realized when we try to
> add the QOM property to the parent. Fix by realizing *after*
> adding the QOM relationship.
> 
> [*] Set ISASuperIOClass::ide.count = N with N not zero
>     (no such thing currently exists; the bug is latent)
> 
> Fixes: e508430619 ("hw/isa/superio: Make the components QOM children")
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
> v2: Reword bug is latent (Markus)
> ---
>  hw/isa/isa-superio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/isa/isa-superio.c b/hw/isa/isa-superio.c
> index e2e47d8fd9..179c185695 100644
> --- a/hw/isa/isa-superio.c
> +++ b/hw/isa/isa-superio.c
> @@ -158,8 +158,8 @@ static void isa_superio_realize(DeviceState *dev, Error **errp)
>          if (k->ide.get_irq) {
>              qdev_prop_set_uint32(d, "irq", k->ide.get_irq(sio, 0));
>          }
> -        isa_realize_and_unref(isa, bus, &error_fatal);
>          object_property_add_child(OBJECT(sio), "isa-ide", OBJECT(isa));
> +        isa_realize_and_unref(isa, bus, &error_fatal);
>          sio->ide = isa;
>          trace_superio_create_ide(0,
>                                   k->ide.get_iobase ?
> 

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>


