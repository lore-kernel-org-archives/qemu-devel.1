Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8DCAC388F9
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 17:39:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21F7C21556
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 17:39:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VZqkoFxn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21F7C21556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59908 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZdnX-0008Ey-6S
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 12:39:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59580)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1kZdm2-0007Du-Eu
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 12:37:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28805)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1kZdlz-0001QX-LK
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 12:37:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604338656;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mL6b+c+wfL/tfWSFvR/mnAAS0lAbH053vcgvpxdNCt4=;
 b=VZqkoFxnXiNhSfFheBTvzNcu2qxAklttV0n+9t/jwaI3d+Z8uHoCfCuxjZbyAmUXUZImU/
 zGzK0N9qsjGTaqaN0rcqPnQNMOlyCuG9Ag9Fc1N/Q+XG35ZdGkKgnSvycT87T2W/Q+3znc
 VvXt3Gfw/4xMNOyqpc0YSlwGUJdD3jw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-596-yIlA2IALOsamxu1pKarhRQ-1; Mon, 02 Nov 2020 12:37:34 -0500
X-MC-Unique: yIlA2IALOsamxu1pKarhRQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 24B265708C;
 Mon,  2 Nov 2020 17:37:33 +0000 (UTC)
Received: from w520.home (ovpn-112-213.phx2.redhat.com [10.3.112.213])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 30D1D5B4A9;
 Mon,  2 Nov 2020 17:37:24 +0000 (UTC)
Date: Mon, 2 Nov 2020 10:37:23 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v10 10/10] vfio: Don't issue full 2^64 unmap
Message-ID: <20201102103723.71fafca7@w520.home>
In-Reply-To: <49788b62-ee5d-0b6f-36ff-3c2ba144df39@redhat.com>
References: <20201008171558.410886-1-jean-philippe@linaro.org>
 <20201008171558.410886-11-jean-philippe@linaro.org>
 <20201008152214.3cb1425b@w520.home>
 <20201030062513-mutt-send-email-mst@kernel.org>
 <20201030112622.0edaa660@w520.home>
 <49788b62-ee5d-0b6f-36ff-3c2ba144df39@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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

On Fri, 30 Oct 2020 19:19:14 +0100
Paolo Bonzini <pbonzini@redhat.com> wrote:

> On 30/10/20 18:26, Alex Williamson wrote:
> >>  
> >>      if (try_unmap) {
> >> +        if (llsize == int128_2_64()) {
> >> +            /* The unmap ioctl doesn't accept a full 64-bit span. */
> >> +            llsize = int128_rshift(llsize, 1);
> >> +            ret = vfio_dma_unmap(container, iova, int128_get64(llsize));
> >> +            if (ret) {
> >> +                error_report("vfio_dma_unmap(%p, 0x%"HWADDR_PRIx", "
> >> +                             "0x%"HWADDR_PRIx") = %d (%m)",
> >> +                             container, iova, int128_get64(llsize), ret);
> >> +            }
> >> +            iova += int128_get64(llsize);
> >> +        }
> >>          ret = vfio_dma_unmap(container, iova, int128_get64(llsize));
> >>          if (ret) {
> >>              error_report("vfio_dma_unmap(%p, 0x%"HWADDR_PRIx", "    
> > We're still susceptible that splitting the range in two could result in
> > unmap calls that attempt to bisect a mapping that spans both ranges.
> > Both unmap calls would fail in that case.  I think we could solve this
> > more completely with a high water marker, but this probably good enough
> > for now.
> > 
> > Acked-by: Alex Williamson <alex.williamson@redhat.com>    
> 
> Could it also be fixed by passing an Int128 to vfio_dma_unmap?

I think we still have the issue at the vfio ioctl which takes __u64 iova
and size parameters, in bytes.  Therefore we cannot unmap an entire
64-bit address space with a single ioctl call.  We'd need to make use
of a flag to modify the ioctl behavior to work terms of some page size
to achieve this, for example if iova and size were in terms of 4K
pages, we wouldn't have this issue.  Thanks,

Alex


