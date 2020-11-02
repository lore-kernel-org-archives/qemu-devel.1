Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61233C00A89
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 18:02:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9B0D21D91
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 18:02:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JYczR8a0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9B0D21D91
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZe9a-0003Rd-Bq
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 13:02:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36744)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1kZe8m-0002zd-Rr
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 13:01:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:22061)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1kZe8i-0004Wm-Us
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 13:01:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604340066;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=trnOgtvgVEBCOLCTDby1Y1Q0fmhnCvvz2QZtyMJHqb0=;
 b=JYczR8a03cifO9MaIMy8rLyr0X96FkFODqmnl+TkB8YgkQBkG9UQi3N+q9BeOuTAByzSKo
 Xj+7klUoPnyUHTMOgz+rhZR36Q+FbkAeKLyMCbsDGwjwZR6BwIhVKATexnvTjNwkTqmO3q
 nKTM1amweEskJ+z2KiJnomgtlzVQoVc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-540-B4dm1z5uOEGVYQWzJnLQVQ-1; Mon, 02 Nov 2020 13:01:04 -0500
X-MC-Unique: B4dm1z5uOEGVYQWzJnLQVQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EF872188C124;
 Mon,  2 Nov 2020 18:01:02 +0000 (UTC)
Received: from w520.home (ovpn-112-213.phx2.redhat.com [10.3.112.213])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3CD0E6198E;
 Mon,  2 Nov 2020 18:00:53 +0000 (UTC)
Date: Mon, 2 Nov 2020 11:00:52 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v10 10/10] vfio: Don't issue full 2^64 unmap
Message-ID: <20201102110052.410b1d35@w520.home>
In-Reply-To: <cf320b8e-d3a3-ae69-69ec-405bb58948ed@redhat.com>
References: <20201008171558.410886-1-jean-philippe@linaro.org>
 <20201008171558.410886-11-jean-philippe@linaro.org>
 <20201008152214.3cb1425b@w520.home>
 <20201030062513-mutt-send-email-mst@kernel.org>
 <20201030112622.0edaa660@w520.home>
 <49788b62-ee5d-0b6f-36ff-3c2ba144df39@redhat.com>
 <20201102103723.71fafca7@w520.home>
 <cf320b8e-d3a3-ae69-69ec-405bb58948ed@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=alex.williamson@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/02 03:02:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 peterx@redhat.com, eric.auger@redhat.com, bbhushan2@marvell.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 2 Nov 2020 18:44:11 +0100
Paolo Bonzini <pbonzini@redhat.com> wrote:

> On 02/11/20 18:37, Alex Williamson wrote:
> > I think we still have the issue at the vfio ioctl which takes __u64 iova
> > and size parameters, in bytes.  Therefore we cannot unmap an entire
> > 64-bit address space with a single ioctl call.  We'd need to make use
> > of a flag to modify the ioctl behavior to work terms of some page size
> > to achieve this, for example if iova and size were in terms of 4K
> > pages, we wouldn't have this issue.  Thanks,  
> 
> What happens to the last page if size is unaligned (e.g. iova==0, size==
> 2^64-1)?

Both args are currently required to be aligned to the minimum IOMMU
page size.  Thanks,

Alex


