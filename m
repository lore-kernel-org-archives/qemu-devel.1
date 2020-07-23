Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3FF2C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 04:00:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADD2F206F4
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 04:00:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b2CruEUm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADD2F206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35818 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jySPf-0002ll-T5
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 00:00:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51708)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jySOp-0002En-Hh
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 00:00:03 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25987
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jySOm-0004xs-Sf
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 00:00:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595476799;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CXgRiTKYeJsRpPgYYo245QQcm1duVCQ3uULgDXZGylM=;
 b=b2CruEUmrMz+9fsYnrPQYW9NTFwZyDxzaCDKnrGm/cWddcnNBbaWbD/gfufQBMYesMmKsE
 t4WYviNRfAYDYgnTOtLsYxgYtIa9GfA5fe076ccvIQdMPMYRlEQgoqlBF2Q4vBaEA+i7cX
 D/uZuf4pWeF3rt78/Ru9D+O1C6dZuVk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-376-bh2gACSUPyiPBBLnuuh1Mw-1; Wed, 22 Jul 2020 23:59:55 -0400
X-MC-Unique: bh2gACSUPyiPBBLnuuh1Mw-1
Received: by mail-wr1-f69.google.com with SMTP id z1so1011049wrn.18
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2020 20:59:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=CXgRiTKYeJsRpPgYYo245QQcm1duVCQ3uULgDXZGylM=;
 b=svP4CR8FUqoO5MztKXrFXcIXSCjm1pS2XRh/Nu+pFL8W5RixyKgBd4GsQHsEWBlpsU
 3HLOn7pTG5u816j6m5P++Te8vnLJ7f0eDR/l3eWrkOZ1vFAQTLDtJE9V80joMmGaxmIM
 E8Y8GIcDQ4flNsey9gfAAOrceaQGeoBRyFOaZkjJ7EG4aVEcaGkEk89LdpdhrBKtdhvW
 F8ouSYf6UWKb/jpucE2rBGfH5dCNXnSjnUepCwGexyrJR/yS8gtv0ED0chLCKhp7WGZc
 FeQJLyMKBK0kV00hJyqs5TN++Yk5cOvJHSiEGPMH+EHwByCBx/8K4QWKbtt3qW88TZuc
 PBIA==
X-Gm-Message-State: AOAM531sWw4/6eWLRRRb3HdbKCVSGKSB9IM4h72X9x9K7oLNqXHpZysw
 1OllOox7UMNBCd1NtKxBA4vI75AJo4XtLBFIntFqsC7NcVw5j/9Gwx6gCTFQUkWDKZvHVBMyzTM
 bJjXoKre6Ro2kt2A=
X-Received: by 2002:a1c:2e57:: with SMTP id u84mr2473012wmu.52.1595476794513; 
 Wed, 22 Jul 2020 20:59:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw+gk1VGJXvuG7jv/s/UF820VRfHnlazGRkWEfba7BEvBpzUyUhRU9n2ML3Mrh/OWx4T4AelA==
X-Received: by 2002:a1c:2e57:: with SMTP id u84mr2472997wmu.52.1595476794301; 
 Wed, 22 Jul 2020 20:59:54 -0700 (PDT)
Received: from redhat.com (bzq-79-179-105-63.red.bezeqint.net. [79.179.105.63])
 by smtp.gmail.com with ESMTPSA id u20sm1734276wmc.42.2020.07.22.20.59.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2020 20:59:53 -0700 (PDT)
Date: Wed, 22 Jul 2020 23:59:50 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v2] virtio-balloon: always indicate S_DONE when migration
 fails
Message-ID: <20200722235758-mutt-send-email-mst@kernel.org>
References: <20200629080615.26022-1-david@redhat.com>
 <20200722080356-mutt-send-email-mst@kernel.org>
 <d52e7c61-a458-141c-5b7c-515173724fe8@redhat.com>
MIME-Version: 1.0
In-Reply-To: <d52e7c61-a458-141c-5b7c-515173724fe8@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/22 22:23:06
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
Cc: virtio-dev@lists.oasis-open.org,
 Alexander Duyck <alexander.h.duyck@linux.intel.com>,
 Wei Wang <wei.w.wang@intel.com>, qemu-devel@nongnu.org,
 Alexander Duyck <alexander.duyck@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jul 22, 2020 at 02:05:19PM +0200, David Hildenbrand wrote:
> On 22.07.20 14:04, Michael S. Tsirkin wrote:
> > On Mon, Jun 29, 2020 at 10:06:15AM +0200, David Hildenbrand wrote:
> >> If something goes wrong during precopy, before stopping the VM, we will
> >> never send a S_DONE indication to the VM, resulting in the hinted pages
> >> not getting released to be used by the guest OS (e.g., Linux).
> >>
> >> Easy to reproduce:
> >> 1. Start migration (e.g., HMP "migrate -d 'exec:gzip -c > STATEFILE.gz'")
> >> 2. Cancel migration (e.g., HMP "migrate_cancel")
> >> 3. Oberve in the guest (e.g., cat /proc/meminfo) that there is basically
> >>    no free memory left.
> >>
> >> While at it, add similar locking to virtio_balloon_free_page_done() as
> >> done in virtio_balloon_free_page_stop. Locking is still weird, but that
> >> has to be sorted out separately.
> >>
> >> There is nothing to do in the PRECOPY_NOTIFY_COMPLETE case. Add some
> >> comments regarding S_DONE handling.
> >>
> >> Fixes: c13c4153f76d ("virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_HINT")
> >> Reviewed-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> >> Cc: Wei Wang <wei.w.wang@intel.com>
> >> Cc: Alexander Duyck <alexander.duyck@gmail.com>
> >> Signed-off-by: David Hildenbrand <david@redhat.com>
> > 
> > IIUC this is superceded by Alexander's patches right?
> 
> Not that I know ... @Alex?
> 
> > If not pls rebase ...
> > 

OK then I guess I was confused. This is older so I guess I should
have applied this and asked Alex to rebase his patches, but I did the
reverse.., Sorry about that. Could you rebase on top of
the pci tree pls?


Thanks and sorry for messing up.

> 
> 
> -- 
> Thanks,
> 
> David / dhildenb


