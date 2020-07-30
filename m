Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1D40C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 16:12:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B049320838
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 16:12:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RCYIN8yl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B049320838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54568 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1BAt-0005dG-23
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 12:12:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60208)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1k1B2Z-0002C7-Qf
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 12:04:19 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:28062
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1k1B2W-0006dK-Gi
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 12:04:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596125054;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Om/S5CoiVZkr7uxg8+K6ByXJ1ieNR2ZOETlg85kKHr0=;
 b=RCYIN8ylWMu1FRbOYMtNpRlKVTKoZ6y9y0M6dJLUKV+fWZzZsXWdg/07y6oedDv37Ylo1p
 wM1R6rCc4UD+RG6wJWxOh9mRdfNJQtUfHCVT/xjM7uH9TmhOgTxF8wgskDk8W3Ukr79/fh
 bZtFACUHLmI5rrinGdw/eys/EZAL/wY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-130-O24P1IC_NsaVsVvbUZSjCg-1; Thu, 30 Jul 2020 12:04:13 -0400
X-MC-Unique: O24P1IC_NsaVsVvbUZSjCg-1
Received: by mail-wm1-f72.google.com with SMTP id c124so1481734wme.0
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2020 09:04:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Om/S5CoiVZkr7uxg8+K6ByXJ1ieNR2ZOETlg85kKHr0=;
 b=bVDkAbYwXG4m4nfnPAKGguovEvuAx7UI6klJyz5SS/ylUwDJSQdoP8AI4HVCBRgDq4
 m1/oQANwGrZQZzSB+gwEybxbyIEvjvdItFkpxbiHxWrU6YVR9bj4DxxwRP1uNS6lBFvt
 LOPFMzR86HYLfHGASMmpll82ubS30Q8C0ZWyy+QQ4HtyAFXqcifhllE/bLmH91ahlN4z
 yanEoezkeLa0I79KUEXN1N5y7O1xUkLyoP9/ZO7zDjJc15DtTIn2aqkijIptZLAbcDUw
 PMgrUj2AeJPrKOmrYDyYxVqUYsKRbe4YljM1sR+M0xIhQauHwFX4rUO6S3mtCVSz+0FP
 vCag==
X-Gm-Message-State: AOAM5319/zo5Xf9qrk0EVPyE1YVGrQ73g6vGXp2eilQkeomYeBbv9CYa
 zIPEN8aeYF1QNBEOxh5JMoEwIsEMxgiSt3e0iJHY7sGEK6378+tH7xLb0hM2qGIrtRoyA7BgePP
 w0Xg/Y69FxFhOuE4=
X-Received: by 2002:a5d:414e:: with SMTP id c14mr3723833wrq.57.1596125051657; 
 Thu, 30 Jul 2020 09:04:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyT6+ac2+9Ubo0BVPp7x/1C0Zhdi+en5Titigx3VL6I09vZzhxWglrjVuIl+OExBkhvz+596g==
X-Received: by 2002:a5d:414e:: with SMTP id c14mr3723807wrq.57.1596125051432; 
 Thu, 30 Jul 2020 09:04:11 -0700 (PDT)
Received: from redhat.com (bzq-79-179-105-63.red.bezeqint.net. [79.179.105.63])
 by smtp.gmail.com with ESMTPSA id i66sm10307372wma.35.2020.07.30.09.04.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2020 09:04:10 -0700 (PDT)
Date: Thu, 30 Jul 2020 12:04:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
Subject: Re: [PATCH 1/1] pci/pcie: refuse another hotplug/unplug event if
 attention button is pending
Message-ID: <20200730120153-mutt-send-email-mst@kernel.org>
References: <20200722161722.51416-1-mlevitsk@redhat.com>
 <20200722161722.51416-2-mlevitsk@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200722161722.51416-2-mlevitsk@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/30 03:41:52
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
Cc: jusual@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jul 22, 2020 at 07:17:22PM +0300, Maxim Levitsky wrote:
> Curently it is possible to hotplug a device and then immediatly
> hotunplug it before the OS notices, and that will result
> in missed unplug event since we can only send one attention button event.
> 
> Moreover the device will stuck in unplugging state forever.
> 
> Error out in such cases and rely on the caller (e.g libvirt) to retry
> the unplug a bit later
> 
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>  hw/pci/pcie.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
> index 5b48bae0f6..9e836cf2f4 100644
> --- a/hw/pci/pcie.c
> +++ b/hw/pci/pcie.c
> @@ -402,6 +402,17 @@ static void pcie_cap_slot_plug_common(PCIDevice *hotplug_dev, DeviceState *dev,
>           */
>          error_setg_errno(errp, EBUSY, "slot is electromechanically locked");
>      }
> +
> +    if (sltsta & PCI_EXP_SLTSTA_ABP) {
> +        /*
> +         * Attention button is pressed, thus we can't send another
> +         * hotpplug event

typo

> +         */
> +        error_setg_errno(errp, EBUSY,
> +                         "attention button is already pressed, can't "
> +                         "send another hotplug event");
> +    }
> +
>  }

It would be neater if we could queue the event up
in qemu. Alternatively - can we clean up the unhandled
event so guest does not even notice the device
briefly appeared?

>  
>  void pcie_cap_slot_pre_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
> -- 
> 2.26.2


