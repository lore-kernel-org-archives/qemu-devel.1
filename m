Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BEE5C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 13:34:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8DFE2072F
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 13:34:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H/G8Z78I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8DFE2072F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60542 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiHv1-0004Fc-8b
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 09:34:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48958)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jiHtr-0003Qs-Vy
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 09:33:15 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:24538
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jiHtq-0005sO-Ev
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 09:33:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591623193;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jy3UQ9TwolgMzcs+mF+EHL8I0EaYgGjLeRsKkZIF4Go=;
 b=H/G8Z78IKWPNV7iFcjGRZocLlnMvtlCTI9kghA/U4vRsIlbc4c3A9OtOu+V90Ypu66VUMx
 hgdy8uU6CXF7Ma+LxIolu/xKdzi8LL+f+jJrPpiqk2WkcirhvuwkwXTKSkN9sFhNDec8zy
 WQ/NjWvIdxH8QsUdv0vWthEUjr7rRug=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-36-9Yx-z0cXMiqCIA0F31Mj4A-1; Mon, 08 Jun 2020 09:33:12 -0400
X-MC-Unique: 9Yx-z0cXMiqCIA0F31Mj4A-1
Received: by mail-wm1-f69.google.com with SMTP id s15so5245154wmc.8
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2020 06:33:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=jy3UQ9TwolgMzcs+mF+EHL8I0EaYgGjLeRsKkZIF4Go=;
 b=gabSd8ZosbNErxrPoB+AYTk4kF5SEHYUg0mAWIegz5bCB+gskfeiNY70hjJQ0yKPtR
 TGE0X4/JQFQQCJebuWBfD4NkLvmb0ZwmxlECUjsmgMLQaQnkx2pNkFyEi7d8hHmaiSXE
 tl6RsqpTI+613QXKWAim+JzFTWvlg0BMRuFWHE8j+MEav2xT28K6wWu9fN4i0cUOXfSi
 N8bbzomQtjoBbMaexI/n9647X/+2/pJphfJzAHA+NoBDhh0S8Kgp3uGQU8ZGFMR6Rkqk
 DLETRb20OaTsxas0Tz4/ck53K6G6UKOPNHOh3j8BtYEASCoJ8IXLVtJFg5jGp3y/Zzyz
 JKpA==
X-Gm-Message-State: AOAM533r+n7DWg9kIoDIlRK4/knX1BFthVlol/6ODJqEPOZOcgkQNXgC
 JwSLT44fWZZSOlj37yfOjcd22XcIfcSBOxfim+SakKm600viiRAGxDQnx1ONz+RDkzPmEc62IaJ
 aprJrxv4MuShPM8Q=
X-Received: by 2002:a7b:c18a:: with SMTP id y10mr17443039wmi.73.1591623190889; 
 Mon, 08 Jun 2020 06:33:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz9bnbokhnVLN46q9sCb6V6ovAK9n5BS2Myq9eEvkQEpQdDlMBW6QLuyUv0QuXRGF4o3ryjhA==
X-Received: by 2002:a7b:c18a:: with SMTP id y10mr17443008wmi.73.1591623190701; 
 Mon, 08 Jun 2020 06:33:10 -0700 (PDT)
Received: from redhat.com (bzq-109-64-41-91.red.bezeqint.net. [109.64.41.91])
 by smtp.gmail.com with ESMTPSA id
 88sm25269941wre.45.2020.06.08.06.33.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2020 06:33:10 -0700 (PDT)
Date: Mon, 8 Jun 2020 09:33:07 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v3 4/4] microvm: move virtio base to 0xfeb00000
Message-ID: <20200608093247-mutt-send-email-mst@kernel.org>
References: <20200529073957.8018-1-kraxel@redhat.com>
 <20200529073957.8018-5-kraxel@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200529073957.8018-5-kraxel@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/08 01:20:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 Paul Durrant <paul@xen.org>, qemu-devel@nongnu.org, imammedo@redhat.com,
 xen-devel@lists.xenproject.org, Anthony Perard <anthony.perard@citrix.com>,
 Paolo Bonzini <pbonzini@redhat.com>, philmd@redhat.com,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, May 29, 2020 at 09:39:57AM +0200, Gerd Hoffmann wrote:
> Place virtio-mmio devices near the other mmio regions,
> next ioapic is at @ 0xfec00000.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  include/hw/i386/microvm.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/hw/i386/microvm.h b/include/hw/i386/microvm.h
> index ba68d1f22bb3..fd34b78e0d2a 100644
> --- a/include/hw/i386/microvm.h
> +++ b/include/hw/i386/microvm.h
> @@ -26,7 +26,7 @@
>  #include "hw/i386/x86.h"
>  
>  /* Platform virtio definitions */
> -#define VIRTIO_MMIO_BASE      0xc0000000
> +#define VIRTIO_MMIO_BASE      0xfeb00000
>  #define VIRTIO_IRQ_BASE       5
>  #define VIRTIO_NUM_TRANSPORTS 8
>  #define VIRTIO_CMDLINE_MAXLEN 64

OK, and let's hope we don't need to move it again.

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

> -- 
> 2.18.4


