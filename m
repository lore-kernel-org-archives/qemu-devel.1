Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08B8FC4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 19:19:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2119A2224A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 19:19:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NMjeO1cr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2119A2224A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUxA7-0000XP-RC
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 15:19:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37410)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1kUx8I-0007wv-9w
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 15:17:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41028)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1kUx8F-0006ry-WF
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 15:17:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603221433;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7Q9DI35sHTYqBoQs1d4E6iesJ9aamM0qa4wGkPbasmU=;
 b=NMjeO1crL8EbzBJMqsb1TvR0vKGDNopI+xoI9M+exn3iTLaHoeKdgSTYvbpy71KZH9f+07
 lAE3fd5eT9jHQJjJRWqAtoNdykslnQ4Q2jsMVO2fhUdiX375vtXIVMWvjJ9CKt6dgubs6r
 +uWAxZqFvANx6sIwqOVbTqxeVhALuL0=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-349-OvCK5Qu7O7STl-UBsHmchg-1; Tue, 20 Oct 2020 15:17:10 -0400
X-MC-Unique: OvCK5Qu7O7STl-UBsHmchg-1
Received: by mail-qk1-f200.google.com with SMTP id n125so2755131qke.19
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2020 12:17:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=7Q9DI35sHTYqBoQs1d4E6iesJ9aamM0qa4wGkPbasmU=;
 b=VcIpkKxZvWW4SN0+ZDY5y6dR5jQIUkglbv7sAr3BWIu8GUkGy9D7pE7EUgtaImxp81
 xQfazHhbvoE6sbDVIqUjRYVMBcsS/2l4YUSM9uvewR309HhDuV/CLi73y1knhhoP97cT
 t0mhzmCb8McewKu6wn6wAtV4lRZHLOy7LC4bXG8lW8PP3Ms4vd7I9Lp6mnE4D0jKKrXG
 u/QX1LlonZ8aaWnukcUvdiIAyOQIMe0hv4TbIAzOi4xboOfp5azr+mGD1gUqSlRYxRmR
 nuQhUwuYU++rMdkcpFVWsLnfNwIsFqxhAHDHhZmzXIm4A12V0TzZk1P/PE9fyBWi3nqa
 /o9Q==
X-Gm-Message-State: AOAM532cbTti5wQGSrJcFHU0MMbgx3vIq+D7TtDOpA2kNHPE5xsPSYM2
 tpRDt0cCnG4xjLhu6IIb9dxSnqBuqMr1p8l2CnyvDUB3Ju+xU4FvLAi1vhkd2qVxp0bwfz7eAHU
 lhq5mbImgQAjxYmk=
X-Received: by 2002:a05:6214:546:: with SMTP id
 ci6mr5077950qvb.0.1603221429556; 
 Tue, 20 Oct 2020 12:17:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwoPyl4MqRn2qWmKxqU0KGkSu2qx8t54LciyZWe6LOJhV8Kw3ZwKnXs1FG6pPUtNrZj4IncCQ==
X-Received: by 2002:a05:6214:546:: with SMTP id
 ci6mr5077921qvb.0.1603221429254; 
 Tue, 20 Oct 2020 12:17:09 -0700 (PDT)
Received: from xz-x1 (toroon474qw-lp140-04-174-95-215-133.dsl.bell.ca.
 [174.95.215.133])
 by smtp.gmail.com with ESMTPSA id k16sm1209554qtu.45.2020.10.20.12.17.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2020 12:17:08 -0700 (PDT)
Date: Tue, 20 Oct 2020 15:17:06 -0400
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH PROTOTYPE 4/6] memory: Extend
 ram_block_discard_(require|disable) by two discard types
Message-ID: <20201020191706.GB200400@xz-x1>
References: <20200924160423.106747-1-david@redhat.com>
 <20200924160423.106747-5-david@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200924160423.106747-5-david@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=peterx@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 01:16:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Luiz Capitulino <lcapitulino@redhat.com>, Auger Eric <eric.auger@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Wei Yang <richardw.yang@linux.intel.com>, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Sep 24, 2020 at 06:04:21PM +0200, David Hildenbrand wrote:
> We want to separate the two cases whereby
> - balloning drivers do random discards on random guest memory (e.g.,
>   virtio-balloon) - uncoordinated discards
> - paravirtualized memory devices do discards in well-known granularity,
>   and always know which block is currently accessible or inaccessible by
>   a guest. - coordinated discards
> 
> This will be required to get virtio_mem + vfio running - vfio still
> wants to block random memory ballooning.
> 
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Cc: Wei Yang <richardw.yang@linux.intel.com>
> Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
> Cc: Peter Xu <peterx@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  exec.c                | 109 ++++++++++++++++++++++++++++++++++--------
>  include/exec/memory.h |  36 ++++++++++++--
>  2 files changed, 121 insertions(+), 24 deletions(-)
> 
> diff --git a/exec.c b/exec.c
> index e34b602bdf..83098e9230 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -4098,52 +4098,121 @@ void mtree_print_dispatch(AddressSpaceDispatch *d, MemoryRegion *root)
>   * If positive, discarding RAM is disabled. If negative, discarding RAM is
>   * required to work and cannot be disabled.
>   */
> -static int ram_block_discard_disabled;
> +static int uncoordinated_discard_disabled;
> +static int coordinated_discard_disabled;

Instead of duplicating the codes, how about start to make it an array?

Btw, iiuc these flags do not need atomic operations at all, because all callers
should be with BQL and called majorly during machine start/reset.  Even not, I
think we can also use a mutex, maybe it could make things simpler.  No strong
opinion, though.

-- 
Peter Xu


