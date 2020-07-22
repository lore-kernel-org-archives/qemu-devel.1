Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A2EEC433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 11:18:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63AC8206F5
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 11:18:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DQU1o5ZT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63AC8206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59754 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyCl9-0005yp-K7
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 07:18:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59058)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jyCka-0005YJ-PS
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 07:17:28 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:38003
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jyCkX-00075O-Sa
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 07:17:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595416644;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DvGChwPX1H7+RnE2QiVB53u3SndMjeIh6hetBmuRwec=;
 b=DQU1o5ZTWUi9iX6RyRuZTJ7SdbdU2u3ejt/WjiSjsTm/7zWQ0u4ibodU782HWTFkxM+h7v
 3kiJE3ox2Be6F7sXumUowfqrU3IMQmQ0vqvUNYUpMXHvCrf4m9wlNhG1ct++orB1E5Re50
 w9GTkgq+lFEcK2VTRAqhuR2kcNqlSRg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-6-AvnP9eI9Nd2et3lvGoyAQw-1; Wed, 22 Jul 2020 07:17:19 -0400
X-MC-Unique: AvnP9eI9Nd2et3lvGoyAQw-1
Received: by mail-wm1-f69.google.com with SMTP id t26so372318wmn.4
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2020 04:17:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=ZbdItfMMS0nUnbvspjRwlGyNdqeunfwJGeW8Y//i944=;
 b=qCFdlYSN161MJVnWuUldLAVyg1cjcimrfwIItjtkNWPK3z9r6RebADjijhhZWMNbet
 BrkrVxzxiLn/lipdaai28WO+KR3/Y0gjDk4mEKaxFv1W7jNvRCGDb72PcAXnQWYjuJVC
 oj+Kxl2GGBgI6XIiUDW5i1i6RsLATAtp6W1T61drYyB2uDy+svi76+k7lMISzJMjOwux
 kbHM3VXb/dHQmlpos1nTwbKCfYlp93TJkUAS/dStJFP7yRPmps5DQMGjHqidg0HbeuWl
 OMKLmqhR5wn3xui3nOQiuXXG2HuP8pWYCxEJbPdhF/vC1S6y8qoHeViTlWJwaQWym3Hz
 6s5g==
X-Gm-Message-State: AOAM530Nqq35663001ypXpP7g8v7RESCd81C0k8mlqnrxPKnQNACGs2l
 c0sj3B+mrjGR7q0cO+3lWaviGj5095qhZom1wri3jUd4QvtUTt0aTBsUAno8Jp4Sd74VgL6pcTL
 YzGohFaXM0rB9U8s=
X-Received: by 2002:adf:e7c3:: with SMTP id e3mr933396wrn.356.1595416638123;
 Wed, 22 Jul 2020 04:17:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwGhAk6um1AheVCQjFIpD6QystFDji+jZZh0BLuMiih/30duX5wLMgNeOkDLJIePStg0wXIiA==
X-Received: by 2002:adf:e7c3:: with SMTP id e3mr933379wrn.356.1595416637899;
 Wed, 22 Jul 2020 04:17:17 -0700 (PDT)
Received: from redhat.com (bzq-79-182-82-99.red.bezeqint.net. [79.182.82.99])
 by smtp.gmail.com with ESMTPSA id
 t13sm17318552wru.65.2020.07.22.04.17.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2020 04:17:17 -0700 (PDT)
Date: Wed, 22 Jul 2020 07:17:14 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Subject: Re: [RFC PATCH-not-for-5.1? v2] hw/isa/isa-bus: Ensure ISA I/O
 regions are 8/16-bit accessible
Message-ID: <20200722071517-mutt-send-email-mst@kernel.org>
References: <20200720185758.21280-1-f4bug@amsat.org>
MIME-Version: 1.0
In-Reply-To: <20200720185758.21280-1-f4bug@amsat.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/21 21:28:05
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jul 20, 2020 at 08:57:58PM +0200, Philippe Mathieu-Daudé wrote:
> Since commit 5d971f9e67 we don't accept mismatching sizes
> in memory_region_access_valid(). This gives troubles when
> a device is on an ISA bus, because the CPU is free to use
> 8/16-bit accesses on the bus (or up to 32-bit on EISA bus),
> regardless what range is valid for the device.

Right, but I am not sure device is guaranteed to do something
sensible if the CPU does it.

Any examples where that is the case?

> Add a check to ensure devices plugged on the ISA bus can
> accept 8/16-bits accesses.
> 
> Related bug reports:
> 
> - https://lore.kernel.org/xen-devel/20200630170913.123646-1-anthony.perard@citrix.com/T/
> - https://bugs.debian.org/964793
> - https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=964247
> - https://bugs.launchpad.net/bugs/1886318


These all have to do with ACPI that Michael fixed, right?

> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
> MST: I really don't like this approach, I think the ISA bus
>      should adjust the access.
> 
> since v1: only 8/16-bit accesses enforced
> ---
>  hw/isa/isa-bus.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/hw/isa/isa-bus.c b/hw/isa/isa-bus.c
> index 58fde178f9..e142eeef06 100644
> --- a/hw/isa/isa-bus.c
> +++ b/hw/isa/isa-bus.c
> @@ -132,6 +132,20 @@ static inline void isa_init_ioport(ISADevice *dev, uint16_t ioport)
>  
>  void isa_register_ioport(ISADevice *dev, MemoryRegion *io, uint16_t start)
>  {
> +    if (io->ops->valid.min_access_size > 1) {
> +        /*
> +         * To be backward compatible with IBM-PC bus, ISA bus must accept
> +         * 8-bit accesses.
> +         */
> +        error_report("ISA device '%s' requires I/O min_access_size of 1 (byte)",
> +                     object_get_typename(OBJECT(dev)));
> +        exit(1);
> +    } else if (io->ops->valid.max_access_size < 2) {
> +        /* ISA bus must accept 16-bit accesses (EISA accepts 32-bit) */
> +        error_report("ISA device '%s' requires I/O max_access_size of "
> +                     "at least 2 (bytes)", object_get_typename(OBJECT(dev)));
> +        exit(1);
> +    }
>      memory_region_add_subregion(isabus->address_space_io, start, io);
>      isa_init_ioport(dev, start);
>  }
> -- 
> 2.21.3


