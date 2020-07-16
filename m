Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C544C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 06:45:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C91BD206F5
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 06:45:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MO8/5ogS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C91BD206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvxdv-0000N4-31
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 02:45:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58342)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jvxcJ-0007YG-03
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 02:43:39 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:27169
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jvxcF-00082F-9h
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 02:43:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594881813;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=92A49Ojmn2AU0Fmvk+D6Q53rRv9UoaDayPIPpa5wWcs=;
 b=MO8/5ogSgdemiaogmGgiARWFGj9RpG7wn1e0V0kcMI0DZdR+MWf7nt2aF+VvyQEGYfW5WF
 UaEEooi7g4df/WZkWuDPmbinoStPKP5l0Qy2Px00HmAG89DpftWGRcVvT6W8vH9cMWAEGA
 ws6/qnCT6oi+j1k2QXU8604NBG1/cJ8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-187-ijgyNRjVOUaM0pvX8UnZ3w-1; Thu, 16 Jul 2020 02:43:29 -0400
X-MC-Unique: ijgyNRjVOUaM0pvX8UnZ3w-1
Received: by mail-wm1-f72.google.com with SMTP id c124so4240913wme.0
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2020 23:43:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=92A49Ojmn2AU0Fmvk+D6Q53rRv9UoaDayPIPpa5wWcs=;
 b=rxUh9dm2U51802cD4fDbsqxf8A6rddgNToxes7QHf/vK2hL3m+4e6I0LSJ5ZtOrj0Q
 sJNUbFg8JQHayjPJ1sjMWGgCXosOMQOvb0/NjuKAxedsxfL6K++b0WO98oJeZsQ36scj
 Pfv2QM5z75Mq9HO8TnKpwUaF/TDCUhcp97DK7zGSr41X9Z9Ro4O28g4naOrW+bZnpTsQ
 xY0MnOlBGa97liyKUd//EHRuGeJYxU5O5P9X7lMLYcmPrnLZxFaHDnA9XNj4/fOCx+Lu
 8CQ2qUYpEy42DgYYTmKFg5DtPFFQ8lWvpGB+dBnufm5xNp0WfhiHhHfwLLZYXeWNyJIX
 6bUA==
X-Gm-Message-State: AOAM533q7Pdzt/b7l3LqzDec01pLfcPp385qpbIVbmxj7jXrPE1bgyAj
 m9cWn1J5hLdMWcl0gz56eC7Re8GfOPtfeziJmDachrkGn3t9wqe2OvzH6rcLGrtbnlhEI1o/Qd8
 ZsnHvZQu2dvg0Kdw=
X-Received: by 2002:a1c:9a07:: with SMTP id c7mr2963453wme.147.1594881808608; 
 Wed, 15 Jul 2020 23:43:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw6DpABEgJSEbkgqOOGpGbulniuOcb/AXbRsfBNAusCpgTzcOusCDH2paSBBwm1ZZJQp/CfjQ==
X-Received: by 2002:a1c:9a07:: with SMTP id c7mr2963420wme.147.1594881808359; 
 Wed, 15 Jul 2020 23:43:28 -0700 (PDT)
Received: from redhat.com (bzq-79-182-31-92.red.bezeqint.net. [79.182.31.92])
 by smtp.gmail.com with ESMTPSA id
 g3sm8085920wrb.59.2020.07.15.23.43.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2020 23:43:27 -0700 (PDT)
Date: Thu, 16 Jul 2020 02:43:25 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Hui Zhu <teawater@gmail.com>
Subject: Re: [RFC for Linux v4 1/2] virtio_balloon: Add
 VIRTIO_BALLOON_F_CONT_PAGES and inflate_cont_vq
Message-ID: <20200716024114-mutt-send-email-mst@kernel.org>
References: <1594867315-8626-1-git-send-email-teawater@gmail.com>
 <1594867315-8626-2-git-send-email-teawater@gmail.com>
MIME-Version: 1.0
In-Reply-To: <1594867315-8626-2-git-send-email-teawater@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/16 01:37:26
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
Cc: virtio-dev@lists.oasis-open.org, david@redhat.com, qemu-devel@nongnu.org,
 jasowang@redhat.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
 Hui Zhu <teawaterz@linux.alibaba.com>, akpm@linux-foundation.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jul 16, 2020 at 10:41:51AM +0800, Hui Zhu wrote:
> diff --git a/include/uapi/linux/virtio_balloon.h b/include/uapi/linux/virtio_balloon.h
> index dc3e656..4d0151a 100644
> --- a/include/uapi/linux/virtio_balloon.h
> +++ b/include/uapi/linux/virtio_balloon.h
> @@ -37,6 +37,7 @@
>  #define VIRTIO_BALLOON_F_FREE_PAGE_HINT	3 /* VQ to report free pages */
>  #define VIRTIO_BALLOON_F_PAGE_POISON	4 /* Guest is using page poisoning */
>  #define VIRTIO_BALLOON_F_REPORTING	5 /* Page reporting virtqueue */
> +#define VIRTIO_BALLOON_F_CONT_PAGES	6 /* VQ to report continuous pages */
>  
>  /* Size of a PFN in the balloon interface. */
>  #define VIRTIO_BALLOON_PFN_SHIFT 12

So how does the guest/host interface look like?
Could you write up something about it?


