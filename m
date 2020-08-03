Return-Path: <SRS0=TdIk=BN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D00BEC433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 16:05:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D12520775
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 16:05:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GYUimTAs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D12520775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2cxw-000153-QZ
	for qemu-devel@archiver.kernel.org; Mon, 03 Aug 2020 12:05:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39762)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1k2cuj-0004k1-SR
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 12:02:13 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:50402
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1k2cuh-0002CY-CL
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 12:02:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596470530;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9Gcac5ewKC+IOr1hNoUE4I/EN5Zexy3iVwWgDm65T6g=;
 b=GYUimTAsYkL4yEroW+s/z9TLIfWeshbWXE1jl1R0d5f5h+TRIvm3qYbouKYETPC88vvnx9
 x21xQ9dhFEROZ9m3Xup6Jwc83GHMz0LtMS4ZUsPVYNRRBeKBSPlGThsLZY+AlRzu5ipNmY
 FV1ypzxvjusUTjzsqb/lmfxWA9JeFlA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-371-Sw9TFfB6OrWTMD6QMnaFbA-1; Mon, 03 Aug 2020 12:00:38 -0400
X-MC-Unique: Sw9TFfB6OrWTMD6QMnaFbA-1
Received: by mail-wm1-f71.google.com with SMTP id t26so25267wmn.4
 for <qemu-devel@nongnu.org>; Mon, 03 Aug 2020 09:00:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9Gcac5ewKC+IOr1hNoUE4I/EN5Zexy3iVwWgDm65T6g=;
 b=OX9lA4JzoVzsoE4hcUK7111xNJ5k0i0LaCo1iv4AfVop9qhz6b2mmwXBzqX7dLIcIR
 Tl2yS2Pxi1wL1FFWtH2ptG5fv2cT1HT1cn48WbUQ1m/BRJMIdDyfpCF58Bbl5n/Y04+R
 2rFVefCR5heMqbMPSXRmo571pIqowtjYGWs5nUTvGBDX8/27ybhxHpGe1Gh6H5nWdAGK
 uiexRZW0q8zlROmEnmOgkr45Lq/m9XPUiB0d9FWyKlTn+1GKhpwHTOT/svY12KJeSIWP
 A+Vdx9ZsLqf9qzPdJib6bfChP8bi+C6k/Gfyxa7dYco6Qj6slOropWGOo4dKxKaF3TQH
 8Ovw==
X-Gm-Message-State: AOAM531dzk2WxBVymq8bBsrO/CR1Kuqho6J2iq2RIObr3yRy0uxRO96u
 NhWfkLfmDXfm1gfuASoQfoJBiC5dWazr5eTow6kv2h6GgcHkccOWxEg7dQOoSHcRNVkljz8fd1I
 O2FUTOlSOqlzca3Q=
X-Received: by 2002:a1c:7fd3:: with SMTP id a202mr564672wmd.67.1596470436817; 
 Mon, 03 Aug 2020 09:00:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz75JY+wyVft0BMZfBIWZdKKzaTbdshMnFpi1omRaYenZAByPuECc83dM7Cnsix+Z+2kr4WzA==
X-Received: by 2002:a1c:7fd3:: with SMTP id a202mr564648wmd.67.1596470436577; 
 Mon, 03 Aug 2020 09:00:36 -0700 (PDT)
Received: from eperezma.remote.csb (122.227.191.92.dynamic.jazztel.es.
 [92.191.227.122])
 by smtp.gmail.com with ESMTPSA id j5sm11270wmb.12.2020.08.03.09.00.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2020 09:00:35 -0700 (PDT)
Message-ID: <7c17ff0c1be07c3e490fb02abb2b39a1d9f269b8.camel@redhat.com>
Subject: Re: [RFC v2 1/1] memory: Delete assertion in
 memory_region_unregister_iommu_notifier
From: Eugenio =?ISO-8859-1?Q?P=E9rez?= <eperezma@redhat.com>
To: Jason Wang <jasowang@redhat.com>, Peter Xu <peterx@redhat.com>
Date: Mon, 03 Aug 2020 18:00:34 +0200
In-Reply-To: <34fe0e55-c0ae-8e56-462b-6281b6cca4f5@redhat.com>
References: <20200626064122.9252-2-eperezma@redhat.com>
 <20200626212917.GD175520@xz-x1>
 <8cf25190-53e6-8cbb-372b-e3d4ec714dc5@redhat.com>
 <20200628144746.GA239443@xz-x1>
 <54d2cdfd-97b8-9e1d-a607-d7a5e96be3a1@redhat.com>
 <20200629133403.GA266532@xz-x1>
 <2589d0e9-cc5b-a4df-8790-189b49f1a40e@redhat.com>
 <20200630153911.GD3138@xz-x1>
 <69f6d6e7-a0b1-abae-894e-4e81b7e0cc90@redhat.com>
 <ff9e7af0-18c4-57e8-fc94-904fdce1123a@redhat.com>
 <20200702154540.GI40675@xz-x1>
 <34fe0e55-c0ae-8e56-462b-6281b6cca4f5@redhat.com>
X-Mailer: Evolution 3.28.5 (3.28.5-9.el8)
Mime-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/03 02:37:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Yan Zhao <yan.y.zhao@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "libvir-list@redhat.com" <libvir-list@redhat.com>,
 Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org,
 Eric Auger <eric.auger@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 2020-07-03 at 15:24 +0800, Jason Wang wrote:
> On 2020/7/2 下午11:45, Peter Xu wrote:
> > On Thu, Jul 02, 2020 at 11:01:54AM +0800, Jason Wang wrote:
> > > So I think we agree that a new notifier is needed?
> > Good to me, or a new flag should be easier (IOMMU_NOTIFIER_DEV_IOTLB)?
> 
> That should work but I wonder something as following is better.
> 
> Instead of introducing new flags, how about carry the type of event in 
> the notifier then the device (vhost) can choose the message it want to 
> process like:
> 
> static vhost_iommu_event(IOMMUNotifier *n, IOMMUTLBEvent *event)
> 
> {
> 
> switch (event->type) {
> 
> case IOMMU_MAP:
> case IOMMU_UNMAP:
> case IOMMU_DEV_IOTLB_UNMAP:
> ...
> 
> }
> 
> Thanks
> 
> 

Hi!

Sorry, I thought I had this clear but now it seems not so clear to me. Do you mean to add that switch to the current
vhost_iommu_unmap_notify, and then the "type" field to the IOMMUTLBEntry? Is that the scope of the changes, or there is
something I'm missing?

If that is correct, what is the advantage for vhost or other notifiers? I understand that move the IOMMUTLBEntry (addr,
len) -> (iova, mask) split/transformation to the different notifiers implementation could pollute them, but this is even a deeper change and vhost is not insterested in other events but IOMMU_UNMAP, isn't?

On the other hand, who decide what type of event is? If I follow the backtrace of the assert in 
https://lists.gnu.org/archive/html/qemu-devel/2020-07/msg01015.html, it seems to me that it should be
vtd_process_device_iotlb_desc. How do I know if it should be IOMMU_UNMAP or IOMMU_DEV_IOTLB_UNMAP? If I set it in some
function of memory.c, I should decide the type looking the actual notifier, isn't?

Thanks!


