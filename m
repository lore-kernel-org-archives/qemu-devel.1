Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BADBCC433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 12:03:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85C3B206B6
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 12:03:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PeqAR/fo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85C3B206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqbSL-0000TN-HI
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 08:03:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57948)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jqbRG-0007wP-KA
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 08:02:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20815
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jqbRD-0004VQ-BW
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 08:02:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593604921;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=upttUj7UH7Jl5jYNi0LTgfL6ldsPtfhQGw7sDxV+vlA=;
 b=PeqAR/fo2HToCWE32qIp59QklpNFFlilTItmLfQSzw17WoSq8nm9I0ayD4AG+kW5F/hOzw
 h5pQLsdxMJqaYH1BbBdoz++J8TGOnqlGwXltojbK0i1s5Q+9HzxFKH7aX6B9+HrCOPHOpw
 LIlpveQbCCbP08+brzoXB4dEVitBhxk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-110-C9ysPKbpPI2H86TPXvV53A-1; Wed, 01 Jul 2020 08:02:00 -0400
X-MC-Unique: C9ysPKbpPI2H86TPXvV53A-1
Received: by mail-wm1-f72.google.com with SMTP id q20so13094180wme.3
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2020 05:01:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=upttUj7UH7Jl5jYNi0LTgfL6ldsPtfhQGw7sDxV+vlA=;
 b=ShcX2bF0gKilQ9DQX3t9e/9ZRP0Wbpe/nbZ5rqcv3IwrcHd3hqT72usRjrGF5QxirQ
 OMdwTndI8QSQmg1k99se35eebLQuBLpKNJuypdbAS3zjFjvF4dU9aZOIP/cHLrZ10JS9
 X4BeqZ5oGhtPyIQMDSTuRHFHWhLSoSwS+EE1QpHlF8Ln02tSkehK5GsYrsUvH4J0b1kA
 iuRAyIZH+LUNsyAVHoTwAlG2jfdvdiw9bnyOHQjCMmzSDBGtY+bfQRKeLTDwSHoGhnxy
 Ia/kYy3qdhRltWUhKAn0oALAe7Kj1+zjb20VR+Cq2qY6HvmMEL8pNK14bO03NOM7zdO7
 rfQw==
X-Gm-Message-State: AOAM532bSZ3h4TW2Z+7jaLbyWEaUcWe5MmOHZXQMzES4GQCLUMHq2CKp
 ZdD9izJjUriXsRYXKmX5vOHZSNOdzKcmRpQYLQMUQFjW28l+GgCUff+/LCt/RTqMKlMjuR5AKL5
 +S5ycZpEzl+SCdi8=
X-Received: by 2002:a1c:5f45:: with SMTP id t66mr27819969wmb.144.1593604918703; 
 Wed, 01 Jul 2020 05:01:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz8evmIeEBwEbco9M+GUS4o4gTU6FaL4mEumz0IEAIqoi21t2HGkaK7uZ3V9CE9GERQLKApHg==
X-Received: by 2002:a1c:5f45:: with SMTP id t66mr27819939wmb.144.1593604918365; 
 Wed, 01 Jul 2020 05:01:58 -0700 (PDT)
Received: from redhat.com (bzq-79-182-31-92.red.bezeqint.net. [79.182.31.92])
 by smtp.gmail.com with ESMTPSA id
 u23sm7551973wru.94.2020.07.01.05.01.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2020 05:01:57 -0700 (PDT)
Date: Wed, 1 Jul 2020 08:01:55 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Anthony PERARD <anthony.perard@citrix.com>
Subject: Re: [PATCH] acpi: Fix access to PM1 control and status registers
Message-ID: <20200701075914-mutt-send-email-mst@kernel.org>
References: <20200701110549.148522-1-anthony.perard@citrix.com>
MIME-Version: 1.0
In-Reply-To: <20200701110549.148522-1-anthony.perard@citrix.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 22:25:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jul 01, 2020 at 12:05:49PM +0100, Anthony PERARD wrote:
> The ACPI spec state that "Accesses to PM1 control registers are
> accessed through byte and word accesses." (In section 4.7.3.2.1 PM1
> Control Registers of my old spec copy rev 4.0a).
> 
> With commit 5d971f9e6725 ("memory: Revert "memory: accept mismatching
> sizes in memory_region_access_valid""), it wasn't possible anymore to
> access the pm1_cnt register by reading a single byte, and that is use
> by at least a Xen firmware called "hvmloader".
> 
> Also, take care of the PM1 Status Registers which also have "Accesses
> to the PM1 status registers are done through byte or word accesses"
> (In section 4.7.3.1.1 PM1 Status Registers).
> 
> Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>


Can't we set impl.min_access_size to convert byte accesses
to word accesses?

> ---
>  hw/acpi/core.c | 46 +++++++++++++++++++++++++++++++++++++---------
>  1 file changed, 37 insertions(+), 9 deletions(-)
> 
> diff --git a/hw/acpi/core.c b/hw/acpi/core.c
> index 45cbed49abdd..31974e2f91bf 100644
> --- a/hw/acpi/core.c
> +++ b/hw/acpi/core.c
> @@ -394,9 +394,17 @@ uint16_t acpi_pm1_evt_get_sts(ACPIREGS *ar)
>      return ar->pm1.evt.sts;
>  }
>  
> -static void acpi_pm1_evt_write_sts(ACPIREGS *ar, uint16_t val)
> +static void acpi_pm1_evt_write_sts(ACPIREGS *ar, hwaddr addr, uint16_t val,
> +                                   unsigned width)
>  {
>      uint16_t pm1_sts = acpi_pm1_evt_get_sts(ar);
> +    if (width == 1) {
> +        if (addr == 0) {
> +            val |= pm1_sts & 0xff00;
> +        } else if (addr == 1) {
> +            val = (val << BITS_PER_BYTE) | (pm1_sts & 0xff);
> +        }
> +    }
>      if (pm1_sts & val & ACPI_BITMASK_TIMER_STATUS) {
>          /* if TMRSTS is reset, then compute the new overflow time */
>          acpi_pm_tmr_calc_overflow_time(ar);
> @@ -404,8 +412,16 @@ static void acpi_pm1_evt_write_sts(ACPIREGS *ar, uint16_t val)
>      ar->pm1.evt.sts &= ~val;
>  }
>  
> -static void acpi_pm1_evt_write_en(ACPIREGS *ar, uint16_t val)
> +static void acpi_pm1_evt_write_en(ACPIREGS *ar, hwaddr addr, uint16_t val,
> +                                  unsigned width)
>  {
> +    if (width == 1) {
> +        if (addr == 0) {
> +            val |= ar->pm1.evt.en & 0xff00;
> +        } else if (addr == 1) {
> +            val = (val << BITS_PER_BYTE) | (ar->pm1.evt.en & 0xff);
> +        }
> +    }
>      ar->pm1.evt.en = val;
>      qemu_system_wakeup_enable(QEMU_WAKEUP_REASON_RTC,
>                                val & ACPI_BITMASK_RT_CLOCK_ENABLE);
> @@ -434,9 +450,11 @@ static uint64_t acpi_pm_evt_read(void *opaque, hwaddr addr, unsigned width)
>      ACPIREGS *ar = opaque;
>      switch (addr) {
>      case 0:
> -        return acpi_pm1_evt_get_sts(ar);
> +    case 1:
> +        return acpi_pm1_evt_get_sts(ar) >> (addr * BITS_PER_BYTE);
>      case 2:
> -        return ar->pm1.evt.en;
> +    case 3:
> +        return ar->pm1.evt.en >> ((addr - 2) * BITS_PER_BYTE);
>      default:
>          return 0;
>      }
> @@ -448,11 +466,13 @@ static void acpi_pm_evt_write(void *opaque, hwaddr addr, uint64_t val,
>      ACPIREGS *ar = opaque;
>      switch (addr) {
>      case 0:
> -        acpi_pm1_evt_write_sts(ar, val);
> +    case 1:
> +        acpi_pm1_evt_write_sts(ar, addr, val, width);
>          ar->pm1.evt.update_sci(ar);
>          break;
>      case 2:
> -        acpi_pm1_evt_write_en(ar, val);
> +    case 3:
> +        acpi_pm1_evt_write_en(ar, addr - 2, val, width);
>          ar->pm1.evt.update_sci(ar);
>          break;
>      }
> @@ -461,7 +481,7 @@ static void acpi_pm_evt_write(void *opaque, hwaddr addr, uint64_t val,
>  static const MemoryRegionOps acpi_pm_evt_ops = {
>      .read = acpi_pm_evt_read,
>      .write = acpi_pm_evt_write,
> -    .valid.min_access_size = 2,
> +    .valid.min_access_size = 1,
>      .valid.max_access_size = 2,
>      .endianness = DEVICE_LITTLE_ENDIAN,
>  };
> @@ -590,19 +610,27 @@ void acpi_pm1_cnt_update(ACPIREGS *ar,
>  static uint64_t acpi_pm_cnt_read(void *opaque, hwaddr addr, unsigned width)
>  {
>      ACPIREGS *ar = opaque;
> -    return ar->pm1.cnt.cnt;
> +    return ar->pm1.cnt.cnt >> (addr * BITS_PER_BYTE);
>  }
>  
>  static void acpi_pm_cnt_write(void *opaque, hwaddr addr, uint64_t val,
>                                unsigned width)
>  {
> +    ACPIREGS *ar = opaque;
> +    if (width == 1) {
> +        if (addr == 0) {
> +            val |= ar->pm1.cnt.cnt & 0xff00;
> +        } else if (addr == 1) {
> +            val = (val << BITS_PER_BYTE) | (ar->pm1.cnt.cnt & 0xff);
> +        }
> +    }
>      acpi_pm1_cnt_write(opaque, val);
>  }
>  
>  static const MemoryRegionOps acpi_pm_cnt_ops = {
>      .read = acpi_pm_cnt_read,
>      .write = acpi_pm_cnt_write,
> -    .valid.min_access_size = 2,
> +    .valid.min_access_size = 1,
>      .valid.max_access_size = 2,
>      .endianness = DEVICE_LITTLE_ENDIAN,
>  };
> -- 
> Anthony PERARD


