Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C68EC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 13:29:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1679E2067D
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 13:29:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T+BwTpTU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1679E2067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33092 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k18d9-0006KY-EQ
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 09:29:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41996)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1k18cZ-0005uu-EQ
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 09:29:19 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:43890
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1k18cX-0006dc-T2
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 09:29:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596115756;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XwdKuI9GnN2Lfy+iR6y9zMOsARdfweOVryJ01rISwaI=;
 b=T+BwTpTUyjNykLOO/Ib6eOHmluXAKE5hmUGptVkMf+SU60om4usigSPAd+m/RiDhharqcc
 fuE4VT0qYzornwxShE9leZjRD8a1gkfNx42N9EtvRm7XSnJcJGIcVtXf2XoGNmgW7nbxku
 /vI7Yiubw18LbrLanAGHXRdHgga/XCc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-503-YQIUjbk7MeeAc9O_S6Tbdw-1; Thu, 30 Jul 2020 09:29:13 -0400
X-MC-Unique: YQIUjbk7MeeAc9O_S6Tbdw-1
Received: by mail-wm1-f71.google.com with SMTP id q15so2231790wmj.6
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2020 06:29:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=XwdKuI9GnN2Lfy+iR6y9zMOsARdfweOVryJ01rISwaI=;
 b=uNn7/6IH9mAruFwBvaLkrwqLKhhAUYagbp5g5z2yMl1G0ihHaBH/auxY5wVnxy1+R3
 iIXVzUaog2gFof4c35ODVal+frUkrR+zEn1DKhlWOckpBHLhy66oAMRs7Yjp5mPPCc/U
 +HEPEHw4SmdnlXKG/oNUiFMBRGIhNQVfvKabv5wT97QEJkObfb2CrVuiHL/fRE2f5fVG
 nlmSj7O7CHPHrvrWJ4hs3S54I53VWA+qCeuwyNUYeRoqUNe0HLOvr1lZ7Li9qZZFHAWb
 PpUYKnEbXBdM6cZl3I4rxaBfuU3n6Q57IW+4wrp2auWPnqZKL5j+gSplWtnmzpV0oLh2
 O+EQ==
X-Gm-Message-State: AOAM532FLoxLfEnsK/z7p6B9N2uF+I3fgONKaG0Tzv501fCV98w8tBZY
 l5aSJMxx6drICUSay48h8hcq5yeiD+j/OYEhZDwqIBRrL3UwVD/XL8Jv2fV/yEB5AtlnMICK26J
 VFJ61/jc6kElJDU8=
X-Received: by 2002:adf:9e8b:: with SMTP id a11mr33251992wrf.309.1596115752330; 
 Thu, 30 Jul 2020 06:29:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzwI0Xmbgk/BXDJh/TJ5c2lIv5OCpFLQMP1YaCw2D9/YwsZjrUOLVzH0bcPkRk6qCLV0mYJEA==
X-Received: by 2002:adf:9e8b:: with SMTP id a11mr33251972wrf.309.1596115752090; 
 Thu, 30 Jul 2020 06:29:12 -0700 (PDT)
Received: from steredhat.lan ([5.180.207.22])
 by smtp.gmail.com with ESMTPSA id 129sm9625548wmd.48.2020.07.30.06.29.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2020 06:29:11 -0700 (PDT)
Date: Thu, 30 Jul 2020 15:28:56 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bruce Rogers <brogers@suse.com>
Subject: Re: [PATCH] virtio-mem: Correct format specifier mismatch for RISC-V
Message-ID: <20200730132856.fggzdptyxtmkwuy2@steredhat.lan>
References: <20200730130519.168475-1-brogers@suse.com>
MIME-Version: 1.0
In-Reply-To: <20200730130519.168475-1-brogers@suse.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/30 03:51:24
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
Cc: qemu-devel@nongnu.org, david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jul 30, 2020 at 07:05:19AM -0600, Bruce Rogers wrote:
> This likely affects other, less popular host architectures as well.
> Less common host architectures under linux get QEMU_VMALLOC_ALIGN (from
> which VIRTIO_MEM_MIN_BLOCK_SIZE is derived) define to a variable of
> type uintptr, which isn't compatible with the format specifier used to
> print a user message. Since this particular usage of the underlying data
> seems unique to this file, the simple fix is to just cast
> QEMU_VMALLOC_ALIGN to uint32_t, which corresponds to the format specifier
> used.
> 
> Signed-off-by: Bruce Rogers <brogers@suse.com>
> ---
>  hw/virtio/virtio-mem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
> index c12e9f79b0..7740fc613f 100644
> --- a/hw/virtio/virtio-mem.c
> +++ b/hw/virtio/virtio-mem.c
> @@ -36,7 +36,7 @@
>   * Use QEMU_VMALLOC_ALIGN, so no THP will have to be split when unplugging
>   * memory (e.g., 2MB on x86_64).
>   */
> -#define VIRTIO_MEM_MIN_BLOCK_SIZE QEMU_VMALLOC_ALIGN
> +#define VIRTIO_MEM_MIN_BLOCK_SIZE ((uint32_t)QEMU_VMALLOC_ALIGN)
>  /*
>   * Size the usable region bigger than the requested size if possible. Esp.
>   * Linux guests will only add (aligned) memory blocks in case they fully
> -- 
> 2.27.0
> 

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks,
Stefano


