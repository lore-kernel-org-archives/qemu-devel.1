Return-Path: <SRS0=XKWp=7H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 748B1C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 13:59:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 404062071A
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 13:59:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FEqWznxi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 404062071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60312 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdDdc-0005yh-Fa
	for qemu-devel@archiver.kernel.org; Mon, 25 May 2020 09:59:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46310)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jdDce-0005Kp-1o
 for qemu-devel@nongnu.org; Mon, 25 May 2020 09:58:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59866
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jdDcc-0002eJ-Bu
 for qemu-devel@nongnu.org; Mon, 25 May 2020 09:58:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590415108;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RhffWCFRgTxEb3C4JLfhrdKHcsCwrKJ7H99yx63v9mI=;
 b=FEqWznxiIPNgGaXv0HjDHxXBq+Ymz5BqBhsHuny+M5P8BuDZPSnPqs+xPl4TYNWR6l0G1V
 SMg6bMtRFpPhmRUC5yvmHBaASxZYelteYHCxa66d3InyLoQLczx37O1oUBGHeLRIA5Q3Ns
 ESxyQVqB6wWxSxMbtvPqaBeDx95r8wI=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-410-Li7tNpOnM_CuBWUab6ZXRQ-1; Mon, 25 May 2020 09:58:27 -0400
X-MC-Unique: Li7tNpOnM_CuBWUab6ZXRQ-1
Received: by mail-ed1-f70.google.com with SMTP id bs5so7467288edb.18
 for <qemu-devel@nongnu.org>; Mon, 25 May 2020 06:58:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=RhffWCFRgTxEb3C4JLfhrdKHcsCwrKJ7H99yx63v9mI=;
 b=l4YY1f6p23pdlGQEtFJ9rVghPoaQw4Re4n4076C8fR3ZErpQsQj2jLumfdGZE2owb0
 Nvc8B2WlYJEP6vNVIyHDEMo7U4XChGljMLLwVfxJ89VsHH3QmcK2HIfHiMSpMxuGGrC1
 HQBP/gxezvdXycqWH1y25ExSkiKdyZnQ4QvCkkzqQITGYXAn1fK1CgNgIpFuP+YG9fCY
 jpWCkitKqyXWe0f24gW/EEA1p1cYScYs6Wrug6jzIer/QU2PAujZAdaojVxMt9Bi8BoH
 nJx1tTjT5DOokv5jQQUgWW8AcU9Kxn7IWUzwj3qXNXJt+6zBWFhgjhGSnW/8YBLSB1ht
 0/hg==
X-Gm-Message-State: AOAM530c0MhQ54tY0g81NGpHmNJC5nfGp+mHn25KaKqnBJkHjycl2sW7
 syNanVPMCGDoor8O/29qfZyRI3qhYlktiV0uWReB31DGI0JESGjkFlRPYmElHUVXawOTI9SkyPX
 uJgdpGBGM0916ArA=
X-Received: by 2002:a05:6402:3cd:: with SMTP id
 t13mr15798800edw.285.1590415106065; 
 Mon, 25 May 2020 06:58:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzYiF3SYsCiTABpw/rUWhrf0ktAVNudjej4HKk2tdx4YJDJ88UhczVCec54ArkYWPXdKpDfzw==
X-Received: by 2002:a05:6402:3cd:: with SMTP id
 t13mr15798772edw.285.1590415105867; 
 Mon, 25 May 2020 06:58:25 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.170.5])
 by smtp.gmail.com with ESMTPSA id s1sm16319179ejh.81.2020.05.25.06.58.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 May 2020 06:58:25 -0700 (PDT)
Subject: Re: [PATCH 0/3] microvm: memory config tweaks
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
References: <20200525134101.24740-1-kraxel@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <dc1a35f1-d9b5-acca-9714-9b0955ff12ad@redhat.com>
Date: Mon, 25 May 2020 15:56:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200525134101.24740-1-kraxel@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/25 01:44:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, imammedo@redhat.com, philmd@redhat.com,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 25/05/20 15:40, Gerd Hoffmann wrote:
> With more microvm memory config tweaks split this into its owns series,
> the microvm acpi patch series is already big enough ...
> 
> take care,
>   Gerd
> 
> Gerd Hoffmann (3):
>   microvm: use 2G split unconditionally
>   microvm: drop max-ram-below-4g support
>   x86: move max-ram-below-4g to pc
> 
>  include/hw/i386/pc.h  |  2 ++
>  include/hw/i386/x86.h |  4 ----
>  hw/i386/microvm.c     | 35 +-------------------------------
>  hw/i386/pc.c          | 46 +++++++++++++++++++++++++++++++++++++++++++
>  hw/i386/pc_piix.c     | 10 +++++-----
>  hw/i386/pc_q35.c      | 10 +++++-----
>  hw/i386/x86.c         | 46 -------------------------------------------
>  7 files changed, 59 insertions(+), 94 deletions(-)
> 

Acked-by: Paolo Bonzini <pbonzini@redhat.com>


