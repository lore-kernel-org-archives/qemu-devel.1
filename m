Return-Path: <SRS0=C20x=A7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A386BC433F2
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 15:58:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E018206E9
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 15:58:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PNBH4VE/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E018206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxYBj-0007YA-MR
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 11:58:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57468)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jxYBC-00078U-4l
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 11:58:14 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:33702
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jxYBA-0001ia-F6
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 11:58:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595260691;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FmfEjwITvz9iiZvYuHvjn50oh88j7c8kpjID/Lkn3V4=;
 b=PNBH4VE/xTe09zTtNm12HY4o0XU3YdVflNmMmJxVnXZnJZ3TS4iignB4Tkdfxux7kJEaZ9
 Q4O/wJEgI8cDaf6AOBiWEhXiCOlOFxlfnOHP9b4uFllgeBEZ0dlPJaFSAZuCIX/9Tso0j/
 kHt+HaglnwyweuAp3LEhZFvjGyW74Fc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-308-bnWbbYRZPYCHp_2Tu2ueBg-1; Mon, 20 Jul 2020 11:58:09 -0400
X-MC-Unique: bnWbbYRZPYCHp_2Tu2ueBg-1
Received: by mail-wr1-f69.google.com with SMTP id t12so893907wrp.0
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2020 08:58:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=FmfEjwITvz9iiZvYuHvjn50oh88j7c8kpjID/Lkn3V4=;
 b=ZYcmsigk7u0Jc2xQ+FWtNM9TEsXBVC+EFqthJ+NIwyWNEPaQxXjn8PgFFv/PWoky95
 q93lMD7Fjqh+5MtsMY9r+KhvvPjyQVGB1MAKNDPjaOb9qAxlW9lcbD4ELmhp2ga90eeY
 VaKGoJSqzWeUyTPzZatXjWEjQJlGAHVzjjoZ3Fnjgd1KqPU2ug5L3NDGliW0z7rLHliO
 eaRnDnZ+LWlhmajEZzyHfJE/kO9D3sXbhzYRmqqXH7/1SvVz+3Z8xdEKykTSItKQCXfm
 TeuhFArJF9r9AiB5kGwPP39GNTQEvLrPHjfeXf1ajSPoUAVbibq/WHtV6+l7Vc5oiGBD
 I+mg==
X-Gm-Message-State: AOAM531JIpPLsYFoDRzVu0ToGJAF8CFm3NK60bVQPPBqft708ZtRWqyR
 sVu3Jl+XYYdoIca1uiYz48LSMW+jsNqs0av7QQUfOGAEwxKa1SE5oGwWS/0rMSKC/uAE7grvEuP
 2qBqcaA2u7EkauO4=
X-Received: by 2002:a05:600c:2295:: with SMTP id 21mr26237wmf.87.1595260687889; 
 Mon, 20 Jul 2020 08:58:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxITWS5zJjWR2S5P8RYQPJofTta1zW2iAgc16KC3+GAOlsFy33i5D32EI5RVDl3iWUw7BIT3A==
X-Received: by 2002:a05:600c:2295:: with SMTP id 21mr26225wmf.87.1595260687626; 
 Mon, 20 Jul 2020 08:58:07 -0700 (PDT)
Received: from redhat.com (bzq-79-179-105-63.red.bezeqint.net. [79.179.105.63])
 by smtp.gmail.com with ESMTPSA id c24sm8627963wrb.11.2020.07.20.08.58.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2020 08:58:07 -0700 (PDT)
Date: Mon, 20 Jul 2020 11:58:04 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Subject: Re: [PATCH for-5.1] acpi: allow accessing acpi-cnt register by byte
Message-ID: <20200720115730-mutt-send-email-mst@kernel.org>
References: <20200720153915.12267-1-mjt@msgid.tls.msk.ru>
MIME-Version: 1.0
In-Reply-To: <20200720153915.12267-1-mjt@msgid.tls.msk.ru>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/20 02:16:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jul 20, 2020 at 06:39:15PM +0300, Michael Tokarev wrote:
> >From the ACPI spec (4.8.3.2.1 PM1 Control Registers):
> 
> Register Location: <PM1a_CNT_BLK / PM1b_CNT_BLK> System I/O or Memory Space
> Default Value:     00h
> Attribute:         Read/Write
> Size:              PM1_CNT_LEN (2 bytes)
> The PM1 control registers contain the fixed hardware feature control bits.
> These bits can be split between two registers: PM1a_CNT or PM1b_CNT.
> Each register grouping can be at a different 32-bit aligned address
> and is pointed to by the PM1a_CNT_BLK or PM1b_CNT_BLK. The values
> for these pointers to the register space are found in the FADT.
> Accesses to PM1 control registers are accessed through byte
> and word accesses.
> 
> So allow 1-byte access too, not only 2-byte.
> 
> Fixes: afafe4bbe0cf7d3318e1ac7b40925561f86a6bd4
> Fixes: 5d971f9e672507210e77d020d89e0e89165c8fc9

Fixes links are a bit off. Should be:
Fixes: <short sha> ("commit subject")

> Buglink: https://lore.kernel.org/xen-devel/20200630170913.123646-1-anthony.perard@citrix.com/T/
> Buglink: https://bugs.debian.org/964793
> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
> ---
>  hw/acpi/core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/acpi/core.c b/hw/acpi/core.c
> index f6d9ec4f13..2c1199d9dc 100644
> --- a/hw/acpi/core.c
> +++ b/hw/acpi/core.c
> @@ -599,7 +599,8 @@ static void acpi_pm_cnt_write(void *opaque, hwaddr addr, uint64_t val,
>  static const MemoryRegionOps acpi_pm_cnt_ops = {
>      .read = acpi_pm_cnt_read,
>      .write = acpi_pm_cnt_write,
> -    .valid.min_access_size = 2,
> +    .impl.min_access_size = 2,
> +    .valid.min_access_size = 1,
>      .valid.max_access_size = 2,
>      .endianness = DEVICE_LITTLE_ENDIAN,
>  };
> -- 
> 2.20.1


