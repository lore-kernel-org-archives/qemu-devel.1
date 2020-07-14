Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 292DCC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 11:11:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C86A82084C
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 11:11:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JwrPsDIS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C86A82084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60068 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvIq8-0003yJ-32
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 07:11:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49394)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jvIpM-0003Rl-6q
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 07:10:24 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:41083
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jvIpK-0006HT-NJ
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 07:10:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594725020;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0BQsdguy4Hz/Gi/WOLPbVh8BSUd2arOphR0opNnaGo4=;
 b=JwrPsDISIczsN/ntu5Z9j0b48FFVy/SHlmnTFzF1VIZSVtyEGM32Dpi0xvs/tUzd6yj0Li
 1cZTd3rupkvPUCNkIJosR66JrHAN+q2RB/nNrFgbicLsh95VWvsN5xOcPgfxYFQDFg9JBT
 RsERsM0RaCtCane8CX+ouO7hu0x18+A=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-276-z7lI9sx0OSW2gC0pqMnegA-1; Tue, 14 Jul 2020 07:10:19 -0400
X-MC-Unique: z7lI9sx0OSW2gC0pqMnegA-1
Received: by mail-wr1-f70.google.com with SMTP id f5so21146300wrv.22
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2020 04:10:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=0BQsdguy4Hz/Gi/WOLPbVh8BSUd2arOphR0opNnaGo4=;
 b=A9k51DgKwf/Yq8sglu8x/jwTAsy7dr1qZgXd95jMAp+lAtofQJwQ+m1uPEugwfDNWN
 qPV1cYVOlvJTVr8qbMBjRaAfEuoHemYRmQtoWsDFd61YxgzmDa9W5bOOY/Vq+vcSyLtW
 FUFN+3EBWgk1sg4R/ukRF7QxTXDyXWPhyMVxpyNCsPxOl9mA81UbdbVyQ+9NgGOkX9tt
 eHReyXrWZC1bmZ5WllOYLXbw70yQZed42jKgwaqGpvAokdomYM+CvdhOdhHy8RjixIF0
 07BjzjFZwfnH72aCsN2CQDKgQ/YF1wNlBi1rlbjRb59udoX7fYNcmxx3TJE1LtQXWjJc
 hLow==
X-Gm-Message-State: AOAM533EYD/t2/BQmqMBgwQljNkHlP55aBnvNjzr55Gat9/ol/UTxJSk
 CNfWQ8HVG6TQld6bgn3X2ZhtqIyO4TyDDfJ8kypHTzVbsmX/j1tkdv29SrC0DNAHQ6FQenD9AlG
 3QjiOujFjnHDCrzI=
X-Received: by 2002:a1c:7216:: with SMTP id n22mr3915524wmc.189.1594725018163; 
 Tue, 14 Jul 2020 04:10:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwpwYES5KCcBqKL1pOqaWQ8+71ll6yG92xih+VD08YqgY+GNExkCHtvC9yVV9AErIJfKenYEg==
X-Received: by 2002:a1c:7216:: with SMTP id n22mr3915505wmc.189.1594725017968; 
 Tue, 14 Jul 2020 04:10:17 -0700 (PDT)
Received: from redhat.com (bzq-79-180-10-140.red.bezeqint.net. [79.180.10.140])
 by smtp.gmail.com with ESMTPSA id v11sm5919328wmb.3.2020.07.14.04.10.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2020 04:10:17 -0700 (PDT)
Date: Tue, 14 Jul 2020 07:10:14 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Subject: Re: [PATCH v2 for-5.1] acpi-pm-tmr: allow any small-size reads
Message-ID: <20200714070711-mutt-send-email-mst@kernel.org>
References: <20200714105113.32603-1-mjt@msgid.tls.msk.ru>
MIME-Version: 1.0
In-Reply-To: <20200714105113.32603-1-mjt@msgid.tls.msk.ru>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/14 03:57:32
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
Cc: Simon John <git@the-jedi.co.uk>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jul 14, 2020 at 01:51:13PM +0300, Michael Tokarev wrote:
> As found in LP#1886318, MacOS Catalina performs 2-byte reads
> on the acpi timer address space while the spec says it should
> be 4-byte. Allow any small reads.
> 
> Reported-By: Simon John <git@the-jedi.co.uk>
> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

Simon's explanation about the history is good to have here,
and I guess Fixes tags (both what you found and what Simon found)
can't hurt either. I would CC stable too.

Simon do you have the time to iterate on this patch or would
you rather have Michael do it?


> ---
>  hw/acpi/core.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> v2: fixed bug#, use the right form of S-o-b, and allow up to 1 byte reads.
> 
> I'm applying this to debian qemu package, need the fix
> faster in order to release security updates for other
> branches.
> 
> diff --git a/hw/acpi/core.c b/hw/acpi/core.c
> --- a/hw/acpi/core.c
> +++ b/hw/acpi/core.c
> @@ -530,7 +530,10 @@ static void acpi_pm_tmr_write(void *opaque, hwaddr addr, uint64_t val,
>  static const MemoryRegionOps acpi_pm_tmr_ops = {
>      .read = acpi_pm_tmr_read,
>      .write = acpi_pm_tmr_write,
> -    .valid.min_access_size = 4,
> +    .impl.min_access_size = 4,
> +     /* at least MacOS Catalina reads 2 bytes and fails if it doesn't work */
> +     /* allow 1-byte reads too */

... since historically we did in the past.

> +    .valid.min_access_size = 1,
>      .valid.max_access_size = 4,
>      .endianness = DEVICE_LITTLE_ENDIAN,
>  };
> -- 
> 2.20.1


