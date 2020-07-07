Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C654C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 19:55:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A0712067D
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 19:55:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="feXuP5AE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A0712067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36810 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jstgY-0000Om-HS
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 15:55:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57672)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1jstfq-0008Ph-1W
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 15:54:38 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:20793
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1jstfo-0000ym-0N
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 15:54:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594151674;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2cUTdI2+DitOy48/v14295u2qteXSjFnFh1WbzcxerM=;
 b=feXuP5AES7e1/KkfZ6eJFMp1E809Ho8lpi98PT0O4iwjnIuRGaQbV/tJxuVcSZ3OPpWSkN
 SLGBERDT0BTtZnDtKjRrUQCB1jjKYcl33JZSUrHCLJKTwEYvpMorvCv/38YGSIymc07Fi9
 Cr15EzV6aMIZxI1EbxYXxG6G/JLmIAM=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-297-9qAgd7AeOESHg9gyg_yy9g-1; Tue, 07 Jul 2020 15:54:32 -0400
X-MC-Unique: 9qAgd7AeOESHg9gyg_yy9g-1
Received: by mail-qk1-f199.google.com with SMTP id 204so29347363qki.20
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2020 12:54:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=2cUTdI2+DitOy48/v14295u2qteXSjFnFh1WbzcxerM=;
 b=cNt71fYzqatg1tqfZ6L8RdA2dzBwzl8/rbS9ujsKBwVZeN+U/LnhTcmHcpkbaAXKZ7
 fx0pJk5Lh8S89pZozEYVXYLceZoOwfSDaLKF52ax3O1tVtXcwpRJiFVNVrSfKfsN1gED
 VYDwcX3Zf4jQvy8AqXfxUE88lpRM/HH1EnQEPjLFq6/l894jFhqmqbL6/P72cha+5Ga8
 8I+a2u8+Jvn/Z1h8Ep12zC9TY8nCgisiIJbvnPPtPg+a4FPf6/Hn6UH72SJXO+J4Wawv
 cYNXYWfMDOzHRHe7dHzFbrIRcmFBLiOSoYfDyC+KHtpea9oVLgb1BvsGjJUvXtdhsI2v
 fKhQ==
X-Gm-Message-State: AOAM530aRXKVa1s5F5eFPKjntVFx45TxdqqZsLaINbH81Sqsvgmc/6uw
 j4LQpkACOu6ZIL1/T/fri1V3ORijE2OQ56jo7Z2bdHftiEAr2e2Nes6MS66yTk17irJmbijc0RV
 +KdFCyVdsptuPzv0=
X-Received: by 2002:ac8:6c29:: with SMTP id k9mr43527656qtu.290.1594151672031; 
 Tue, 07 Jul 2020 12:54:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJycqdJAlqXXOJTqNW/PgkQYFlWgEz3ljvVqX9p3CAqLlnxm7T/K0ZptxJwj2iD9wCnORt39+Q==
X-Received: by 2002:ac8:6c29:: with SMTP id k9mr43527627qtu.290.1594151671717; 
 Tue, 07 Jul 2020 12:54:31 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id q194sm24011261qke.90.2020.07.07.12.54.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2020 12:54:30 -0700 (PDT)
Date: Tue, 7 Jul 2020 15:54:29 -0400
From: Peter Xu <peterx@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [RFC v2 1/1] memory: Delete assertion in
 memory_region_unregister_iommu_notifier
Message-ID: <20200707195429.GF88106@xz-x1>
References: <54d2cdfd-97b8-9e1d-a607-d7a5e96be3a1@redhat.com>
 <20200629133403.GA266532@xz-x1>
 <2589d0e9-cc5b-a4df-8790-189b49f1a40e@redhat.com>
 <20200630153911.GD3138@xz-x1>
 <69f6d6e7-a0b1-abae-894e-4e81b7e0cc90@redhat.com>
 <ff9e7af0-18c4-57e8-fc94-904fdce1123a@redhat.com>
 <20200702154540.GI40675@xz-x1>
 <34fe0e55-c0ae-8e56-462b-6281b6cca4f5@redhat.com>
 <20200703130338.GD6677@xz-x1>
 <c985b804-126c-94a1-b05e-430075f9e390@redhat.com>
MIME-Version: 1.0
In-Reply-To: <c985b804-126c-94a1-b05e-430075f9e390@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=peterx@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 00:20:54
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Yan Zhao <yan.y.zhao@intel.com>,
 Juan Quintela <quintela@redhat.com>,
 "libvir-list@redhat.com" <libvir-list@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 Eric Auger <eric.auger@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jul 07, 2020 at 04:03:10PM +0800, Jason Wang wrote:
> 
> On 2020/7/3 下午9:03, Peter Xu wrote:
> > On Fri, Jul 03, 2020 at 03:24:19PM +0800, Jason Wang wrote:
> > > On 2020/7/2 下午11:45, Peter Xu wrote:
> > > > On Thu, Jul 02, 2020 at 11:01:54AM +0800, Jason Wang wrote:
> > > > > So I think we agree that a new notifier is needed?
> > > > Good to me, or a new flag should be easier (IOMMU_NOTIFIER_DEV_IOTLB)?
> > > 
> > > That should work but I wonder something as following is better.
> > > 
> > > Instead of introducing new flags, how about carry the type of event in the
> > > notifier then the device (vhost) can choose the message it want to process
> > > like:
> > > 
> > > static vhost_iommu_event(IOMMUNotifier *n, IOMMUTLBEvent *event)
> > > 
> > > {
> > > 
> > > switch (event->type) {
> > > 
> > > case IOMMU_MAP:
> > > case IOMMU_UNMAP:
> > > case IOMMU_DEV_IOTLB_UNMAP:
> > > ...
> > > 
> > > }
> > Looks ok to me, though imo we should still keep the registration information,
> > so VT-d knows which notifiers is interested in which events.  E.g., we can
> > still do something like vtd_as_has_map_notifier().
> 
> 
> Is this for a better performance?
> 
> I wonder whether it's worth since we can't not have both vhost and vtd to be
> registered into the same as.

/me failed to follow this sentence.. :(

> 
> So it should be functional equivalent to vtd_as_has_notifier().

For example: in vtd_iommu_replay() we'll skip the replay if vhost has
registered the iommu notifier because vtd_as_has_map_notifier() will return
false.  It'll only return true if the device is a vfio-pci device.

Without vtd_as_has_map_notifier(), how could we do that?

-- 
Peter Xu


