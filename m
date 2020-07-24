Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56FC6C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 12:54:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21BB52074A
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 12:54:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K06gvJyg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21BB52074A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57886 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyxDp-0004gd-D7
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 08:54:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36310)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jyxDD-0004Hh-43
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 08:54:07 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:45336
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jyxD8-0004wH-CL
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 08:54:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595595239;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=S3AErUclijnzgjodgOdO9wV9Y+e/IWU+Uk9BTgFaJ54=;
 b=K06gvJygNCTFXL837cArplgM8Z0AsASag3K7sKy94/KkBcxxWpdoNKh3Lt4D8ccunl7BVd
 D6MHTcrEPco/Vt9F+dGgIwAj3SY+lnh0jW+ZuVH5pqxB3fmUOTFTOZU5Chp8fcmvujqPro
 kyx79GZTH6B56evrN4SFlYuaQewxzfQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-315-R0JX6P91PR2IhU9eCWq9_w-1; Fri, 24 Jul 2020 08:53:58 -0400
X-MC-Unique: R0JX6P91PR2IhU9eCWq9_w-1
Received: by mail-wm1-f71.google.com with SMTP id x8so3164014wmk.2
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2020 05:53:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=S3AErUclijnzgjodgOdO9wV9Y+e/IWU+Uk9BTgFaJ54=;
 b=c8rZHPDNQzyi8bqK+niqnJ3dtMlzgJoyDPAbGjE1HKyl75mH73JmYUV4yG9mUQrHCb
 k5RRUMHhQtHKJdvxs4STD9MBQSbXMmsd583VocuDFUB+GMjkAktgETMPhilFkkYOxdw5
 28ssU92qD2jp9kNKtdghNjJG/bzKhc7zYuBZRc9oFIvrg+43Kmvgio4yzaeePkvQ2ZfW
 eyRdTF+8Msd94sUrYsYc+5YZE5sXtZtnCZE4tvQbfqf59+3ad+RzTGqk6D2v7H0wuHpb
 I6c05TIr7l6D1nEzqVqUjY0JPip+Us5DnZQg2uvVF747QNdLNXmzi/WaXlJ6jGwaYDIA
 BOZg==
X-Gm-Message-State: AOAM531yAwWCNlrHMMSZT9DhyLnb7jrjFIhVXAm1D33BwQ9L45DHYvTT
 OGzD/z0OxVZoOCZuaM+TtMImzsHGSubptCom++hQGKTRBE+m+nqkmCnWKSruVp/j2ezW7Pn3X6r
 FAKm/SE3LRE27z2Y=
X-Received: by 2002:a05:600c:d7:: with SMTP id
 u23mr8191759wmm.183.1595595237104; 
 Fri, 24 Jul 2020 05:53:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzXw2JOaMugHruIJG9p3rdgsoL7T39bvTvp/JbDwmuA3+kmuYQYNDsXSI5e+IK+eTzCxfk7+A==
X-Received: by 2002:a05:600c:d7:: with SMTP id
 u23mr8191743wmm.183.1595595236903; 
 Fri, 24 Jul 2020 05:53:56 -0700 (PDT)
Received: from redhat.com (bzq-79-179-105-63.red.bezeqint.net. [79.179.105.63])
 by smtp.gmail.com with ESMTPSA id f197sm7581855wme.33.2020.07.24.05.53.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2020 05:53:56 -0700 (PDT)
Date: Fri, 24 Jul 2020 08:53:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] hw/input/virtio-input-hid.c: Don't undef CONFIG_CURSES
Message-ID: <20200724085336-mutt-send-email-mst@kernel.org>
References: <20200723192457.28136-1-peter.maydell@linaro.org>
MIME-Version: 1.0
In-Reply-To: <20200723192457.28136-1-peter.maydell@linaro.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/24 00:00:27
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jul 23, 2020 at 08:24:57PM +0100, Peter Maydell wrote:
> virtio-input-hid.c undefines CONFIG_CURSES before including
> ui/console.h. However since commits e2f82e924d057935 and b0766612d16da18
> that header does not have behaviour dependent on CONFIG_CURSES.
> Remove the now-unneeded undef.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

Gerd pls feel free to pick this up.

> ---
> NB: tested with 'make check' only.
> 
>  hw/input/virtio-input-hid.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/hw/input/virtio-input-hid.c b/hw/input/virtio-input-hid.c
> index 09cf2609854..a7a244a95db 100644
> --- a/hw/input/virtio-input-hid.c
> +++ b/hw/input/virtio-input-hid.c
> @@ -12,7 +12,6 @@
>  #include "hw/qdev-properties.h"
>  #include "hw/virtio/virtio-input.h"
>  
> -#undef CONFIG_CURSES
>  #include "ui/console.h"
>  
>  #include "standard-headers/linux/input.h"
> -- 
> 2.20.1


