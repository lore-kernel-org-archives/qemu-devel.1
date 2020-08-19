Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C40DDC433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 18:26:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 905F520738
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 18:26:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c9Krctqy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 905F520738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8Sn2-0001wN-Q5
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 14:26:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58964)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1k8Sm5-0001JX-4z
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 14:25:25 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:28065
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1k8Sm0-0001Om-4h
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 14:25:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597861519;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EZ/NSxXuc4gQW24jpW8g+EYTk+8ei1XVvr+N+eiAlEw=;
 b=c9KrctqyVoPcIkNaEfW8IxsazD7rCnBx45g2ptObcbQ1DwRAhpOsu5/8rqyNsY4SSgrqSb
 fUV01JUf5AQi0NKjZ6dI2CD2EHUNmHQznv2ebqB6axpNt9g1jWs6suRk7W+NS4sF08D7x7
 nqNM81ZY7TKzOt47Gk0kTq/tD1pDRH4=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-30-aTGGQDcpOw6o7GQYEiLEtw-1; Wed, 19 Aug 2020 14:25:17 -0400
X-MC-Unique: aTGGQDcpOw6o7GQYEiLEtw-1
Received: by mail-qk1-f200.google.com with SMTP id d6so15985114qkg.6
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2020 11:25:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=EZ/NSxXuc4gQW24jpW8g+EYTk+8ei1XVvr+N+eiAlEw=;
 b=riwPB4TR1g99duooVf4388oFwvhg6agCTKgwYO1WtbuzLZcfqPyhZGKpab7SA3AzDL
 r+1dZp/Xn7YyrDkkgY6krCuhhhaFB3hvtWEAkj0XivI+TTQehV1nTyXZnelIRcVHs5kO
 I5186PwL6l0ktp1GQYYWfXRsdFCE0oM1u6l5cYLSCwVHf7wCINB3b88E0nNvMboFxX3h
 7FNdZXt6474Emf7XnTXK8d6YxSpaNsyZ5NQXex/Xq4m95r909oqhi+X7fijjd3XOyfhn
 xXcZp2gFEyz971WJz+hYjHL0SIC6huyRDS9fkkF5ThwedeBFA16+RlOb0cln35bIdcyE
 SWAg==
X-Gm-Message-State: AOAM530CM9+Bcm45VL8ZCD2g3sv82j4Qnx8ICQlxretrF43gw20BOMx3
 PyVSuPMSnzP4M53odwmIVJAM9NZODhcGw7sTkImwF+SgvtQSy8VfdtOUm1VSZiamiYE57JW6QY6
 dLR17y2rPvr/GIzA=
X-Received: by 2002:a37:6351:: with SMTP id x78mr22766051qkb.394.1597861517063; 
 Wed, 19 Aug 2020 11:25:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxzeSrdkuxWRzMf4k9Eilg9Dp4uWVIZtyXRMX89Z8TRjEK65yw0/JCuSYU07mr8/1qOXAnbMg==
X-Received: by 2002:a37:6351:: with SMTP id x78mr22766018qkb.394.1597861516769; 
 Wed, 19 Aug 2020 11:25:16 -0700 (PDT)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-11-70-53-122-15.dsl.bell.ca.
 [70.53.122.15])
 by smtp.gmail.com with ESMTPSA id o15sm24870610qkk.95.2020.08.19.11.25.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2020 11:25:15 -0700 (PDT)
Date: Wed, 19 Aug 2020 14:25:13 -0400
From: Peter Xu <peterx@redhat.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
Subject: Re: [RFC v4 2/2] memory: Skip bad range assertion if notifier is
 DEVIOTLB type
Message-ID: <20200819182513.GD305409@xz-x1>
References: <20200818130151.31678-1-eperezma@redhat.com>
 <20200818130151.31678-3-eperezma@redhat.com>
 <20200819164002.GB305409@xz-x1>
 <CAJaqyWfazchLdyeRrr6yn9SMyY7tkYoEwadQ=u2DUq39tjv07w@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJaqyWfazchLdyeRrr6yn9SMyY7tkYoEwadQ=u2DUq39tjv07w@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=peterx@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/19 04:57:22
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Juan Quintela <quintela@redhat.com>,
 qemu-devel@nongnu.org, Eric Auger <eric.auger@redhat.com>, qemu-arm@nongnu.org,
 Avi Kivity <avi@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Aug 19, 2020 at 07:47:32PM +0200, Eugenio Perez Martin wrote:
> On Wed, Aug 19, 2020 at 6:40 PM Peter Xu <peterx@redhat.com> wrote:
> >
> > On Tue, Aug 18, 2020 at 03:01:51PM +0200, Eugenio Pérez wrote:
> > > Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
> >
> > The changes on the callers of memory_region_notify_one_iommu() seems to be
> > still missing (and, to embed the type into the notification process)..
> >
> 
> Hi Peter.
> 
> I thought that these were left for a future patch series (the main
> motivation was to avoid for guest code to hit the assertion).
> 
> Do you want me to put them in this series?

Imho it would be good to do that altogether.

For example, you have defined:

   /* Notify changes on device IOTLB entries */
   IOMMU_NOTIFIER_DEVIOTLB = 0x04,

The comment says we'll only notify on device iotlbs, however with the code
change we'll still notify even with normal iotlb invalidations (but always with
the type IOMMU_NOTIFIER_DEVIOTLB ).  IOW vhost with ats=on will still receive
two invalidations for the same range just like before.

-- 
Peter Xu


