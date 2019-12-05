Return-Path: <SRS0=YrRb=Z3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78F4BC43603
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 08:40:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41F252245C
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 08:40:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H98HaKzO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41F252245C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51534 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icmgf-00008q-Fu
	for qemu-devel@archiver.kernel.org; Thu, 05 Dec 2019 03:40:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43978)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1icmfQ-0007XQ-Oi
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 03:39:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1icmfP-0003in-Jb
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 03:39:20 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56408
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1icmfP-0003gm-9G
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 03:39:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575535158;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WEw3d+DqTbpKJERAhcdHK2F5dU6bzzDjmvLgz+gaJQ0=;
 b=H98HaKzOVl5eusB1sMuBL4lkYdHwVop0tXN5HQ72TmgFL9FnXmjXOWhcRQQLIGHtLDzcCC
 7GL0/bOXhipHAN5g7h/BQuvXOwhK3V2ceK6gkhl9d9YPjnw674LGbb9IhWkZlZOrDF9qnK
 o9MV2mUAau+cB5HPNPLeEiZUKgs+aH8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-22-Vv2LqZlkOUWmOhPLzVbL5w-1; Thu, 05 Dec 2019 03:39:15 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 292518017DF;
 Thu,  5 Dec 2019 08:39:14 +0000 (UTC)
Received: from [10.36.116.117] (ovpn-116-117.ams2.redhat.com [10.36.116.117])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 555526012C;
 Thu,  5 Dec 2019 08:39:13 +0000 (UTC)
Subject: Re: [PATCH 5/5] hw/arm/smmuv3: Report F_STE_FETCH fault address in
 correct word position
To: Simon Veith <sveith@amazon.de>, qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <1575467748-28898-1-git-send-email-sveith@amazon.de>
 <1575467748-28898-6-git-send-email-sveith@amazon.de>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <39341988-f302-c750-9801-4710ff50c2fe@redhat.com>
Date: Thu, 5 Dec 2019 09:39:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1575467748-28898-6-git-send-email-sveith@amazon.de>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: Vv2LqZlkOUWmOhPLzVbL5w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=windows-1252
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Simon,

On 12/4/19 2:55 PM, Simon Veith wrote:
> The smmuv3_record_event() function that generates the F_STE_FETCH error
> uses the EVT_SET_ADDR macro to record the fetch address, placing it in
> 32-bit words 4 and 5.
> 
> The correct position for this address is in words 6 and 7, per the
> SMMUv3 Architecture Specification.
> 
> Update the function to use the EVT_SET_ADDR2 macro instead, which is the
> macro intended for writing to these words.
> 
> ref. ARM IHI 0070C, section 7.3.4.
> 
> Signed-off-by: Simon Veith <sveith@amazon.de>
> Cc: Eric Auger <eric.auger@redhat.com>
> Cc: qemu-devel@nongnu.org
> Cc: qemu-arm@nongnu.org
> ---
>  hw/arm/smmuv3.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index 2d6c275..125e47d 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -172,7 +172,7 @@ void smmuv3_record_event(SMMUv3State *s, SMMUEventInfo *info)
>      case SMMU_EVT_F_STE_FETCH:
>          EVT_SET_SSID(&evt, info->u.f_ste_fetch.ssid);
>          EVT_SET_SSV(&evt,  info->u.f_ste_fetch.ssv);
> -        EVT_SET_ADDR(&evt, info->u.f_ste_fetch.addr);
> +        EVT_SET_ADDR2(&evt, info->u.f_ste_fetch.addr);
>          break;
>      case SMMU_EVT_C_BAD_STE:
>          EVT_SET_SSID(&evt, info->u.c_bad_ste.ssid);
> 
Acked-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric


