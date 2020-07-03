Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83F98C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 11:58:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E09820782
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 11:58:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gT/tLkMW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E09820782
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39316 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrKKT-0004Cn-Hi
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 07:58:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53574)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jrKJv-0003mU-Jz
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 07:57:31 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:30518
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jrKJt-00066A-LT
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 07:57:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593777447;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Vguke/qtwFZxNa/JyDoWeyEUdyrOhuZE11Fv/Kd8Lxs=;
 b=gT/tLkMWTMGOWgUHmQf4IUqFhg8DDq1U0fXQHy7mvsSjWVHt5BlVhanEeAhuKFxDhhONpu
 A7aSwpBgEg6a7f4b58rMXb00ZZV7Ch4AulIVUcqJsDqyO/gptJ6dxFdGud0g21YjC4xWWS
 lwvoi8cVCuIxuoVvP7dpedHu6Zx4k3Y=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-259-3Nf1IzdmOIeSWXpPXPjIJw-1; Fri, 03 Jul 2020 07:57:24 -0400
X-MC-Unique: 3Nf1IzdmOIeSWXpPXPjIJw-1
Received: by mail-wm1-f70.google.com with SMTP id g6so28872243wmk.4
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2020 04:57:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Vguke/qtwFZxNa/JyDoWeyEUdyrOhuZE11Fv/Kd8Lxs=;
 b=JinFXEU7eGh45veOiN/hOmVj54J3JFv2UxBuTcwTo6QtH75IbQtD/5y/CERRKP78a0
 QAZOOgsj0JPr5kHKBFrSQ6DYAC8Gops+3bBuiH7nom8xsCoRXbyRkR6P4xvK+webpryj
 TBcV6aKJl10FPGlLVfpeK9UmqolNJ53mG9WZ8gsv1kA+Ce8r+yhJCGxRjU/YhIQ+Swd9
 mOPpq8Wm75aBNM1sGrbhZBEqFTzeK25Ayke4y+3D/GknBDXT5UALLEKYrjNobD/bgUtD
 Cb+/McqyTroHS7RR0bp9aMTeJzS4dxNweX72/PePjeeEF99x7Jz1EYJH/yi0Iizmc+aa
 7M6w==
X-Gm-Message-State: AOAM531IAMG5YgqnnS05RCRRIfzCVE4qltqpN1431mp8EAsqRGR5gL6I
 iCe3QHGpCRYBN/vx6Ph8JyBA/Xp7HV9vXP1BCnX3ksfL5Wu8IX1z0pUsLJdbqLS0Iw+SfS3zqjf
 vOGdiXyHOsT2p+Ko=
X-Received: by 2002:adf:9062:: with SMTP id h89mr33730550wrh.285.1593777442688; 
 Fri, 03 Jul 2020 04:57:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyb51LgLMXS4Pu5vBKIKaww2jRDnYSUGTOwYMr4mM+8Xra1hNP690hF3ro32wVISdhRKFuKXA==
X-Received: by 2002:adf:9062:: with SMTP id h89mr33730534wrh.285.1593777442500; 
 Fri, 03 Jul 2020 04:57:22 -0700 (PDT)
Received: from redhat.com (bzq-79-182-31-92.red.bezeqint.net. [79.182.31.92])
 by smtp.gmail.com with ESMTPSA id
 59sm14372843wrj.37.2020.07.03.04.57.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2020 04:57:21 -0700 (PDT)
Date: Fri, 3 Jul 2020 07:57:18 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v1] virtio-mem: fix cross-compilation due to
 VIRTIO_MEM_USABLE_EXTENT
Message-ID: <20200703075708-mutt-send-email-mst@kernel.org>
References: <20200626072248.78761-1-david@redhat.com>
 <20200703104027.30441-1-david@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200703104027.30441-1-david@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 01:34:15
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
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jul 03, 2020 at 12:40:27PM +0200, David Hildenbrand wrote:
> The usable extend depends on the target, not on the destination. This
> fixes cross-compilation on other architectures than x86-64.
> 
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

I folded this into 890f95d1adc8e0cb9fe88f74d1b76aad6d2763d6.
Thanks!

> ---
>  hw/virtio/virtio-mem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
> index bf9b414522..65850530e7 100644
> --- a/hw/virtio/virtio-mem.c
> +++ b/hw/virtio/virtio-mem.c
> @@ -51,7 +51,7 @@
>   * necessary (as the section size can change). But it's more likely that the
>   * section size will rather get smaller and not bigger over time.
>   */
> -#if defined(__x86_64__)
> +#if defined(TARGET_X86_64) || defined(TARGET_I386)
>  #define VIRTIO_MEM_USABLE_EXTENT (2 * (128 * MiB))
>  #else
>  #error VIRTIO_MEM_USABLE_EXTENT not defined
> -- 
> 2.26.2


