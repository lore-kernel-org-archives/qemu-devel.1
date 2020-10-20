Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C4FDC388F2
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 22:45:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48EE52225C
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 22:45:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g374DleV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48EE52225C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kV0Ns-0006HA-Vr
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 18:45:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51196)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1kV0N8-0005lj-JS
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 18:44:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47323)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1kV0N5-0006NQ-Jb
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 18:44:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603233884;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fyFjWRDQSVItQziWqVfoiHK7eFj3/+R+YjdLmujGUBs=;
 b=g374DleVYm7zjsqelQJ550uZakXy1pYJGk4KrKDPxLRzjfEizbFcY8Oz3VVk7XI/xQQdxU
 1JtBKcTTN0R05MX6a0sxTiB+neH6/F4i7/loqm90Zwnyd1m1bMQj/yg92zY8lr577+W3EX
 IL+KX1Z1DBjuRNpTwjWIysfgq/znyI8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-558-bTpq2lpBMOKE_kbLxHPCtA-1; Tue, 20 Oct 2020 18:44:41 -0400
X-MC-Unique: bTpq2lpBMOKE_kbLxHPCtA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9A736803F4D;
 Tue, 20 Oct 2020 22:44:39 +0000 (UTC)
Received: from w520.home (ovpn-112-77.phx2.redhat.com [10.3.112.77])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9741860C07;
 Tue, 20 Oct 2020 22:44:38 +0000 (UTC)
Date: Tue, 20 Oct 2020 16:44:37 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 1/1] Skip flatview_simplify() for cpu vendor zhaoxin
Message-ID: <20201020164437.5e3cb4ce@w520.home>
In-Reply-To: <4d2b96cb-8f7f-2598-39e6-4cf0f61d567b@redhat.com>
References: <20201016112933.14856-1-FelixCui-oc@zhaoxin.com>
 <20201016112933.14856-2-FelixCui-oc@zhaoxin.com>
 <a971c9db-469f-ddc0-1a27-3e21958f6ff7@redhat.com>
 <20201019130206.1d3baffc@w520.home>
 <4d2b96cb-8f7f-2598-39e6-4cf0f61d567b@redhat.com>
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
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 01:15:43
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
Cc: FelixCuioc <FelixCui-oc@zhaoxin.com>, Eduardo Habkost <ehabkost@redhat.com>,
 CobeChen-oc@zhaoxin.com, qemu-devel@nongnu.org, TonyWWang-oc@zhaoxin.com,
 RockCui-oc@zhaoxin.com, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 20 Oct 2020 11:24:58 +0200
Paolo Bonzini <pbonzini@redhat.com> wrote:

> On 19/10/20 21:02, Alex Williamson wrote:
> >> For KVM we were thinking of changing the whole
> >> memory map with a single ioctl, but that's much easier because KVM
> >> builds its page tables lazily. It would be possible for the IOMMU too
> >> but it would require a relatively complicated comparison of the old and
> >> new memory maps in the kernel.  
> >
> > We can only build IOMMU page tables lazily if we get faults, which we
> > generally don't.  We also cannot atomically update IOMMU page tables
> > relative to a device,  
> 
> Yeah, I didn't mean building IOMMU page tables lazily, rather replacing
> the whole VFIO memory map with a single ioctl.
> 
> I don't think that requires atomic updates of the IOMMU page table root,
> but it would require atomic updates of IOMMU page table entires; VFIO
> would compare the old and new memory map and modify the page tables when
> it sees a difference.  Is that possible?

Theoretically possible, probably.  I imagine any IOMMU worth it's
silicon should be able to update ptes atomically, but there's probably
a substantial re-engineering of the internal IOMMU API and external
vfio IOMMU uAPI to get there.  For example, I don't expect we have
support at the IOMMU driver level to reshuffle ptes when an IOMMU super
page is broken.  Instead, for an unmap operation, the IOMMU API allows
the driver to return a larger number of unmapped pages than requested.
I'd be nervous about an agreed baseline for modifications to pages
covered by an IOMMU super page as well.  The vfio IOMMU type1 uAPI is
largely a reflection of this internal API with further restrictions for
tracking and accounting of user mappings.  Therefore we don't allow
mappings that modify or overlap existing mappings nor do we allow an
unmap which bisects any existing mapping.

To support a memory map approach (which implicitly negates those sorts
of rules) we'd need to know if the IOMMU driver itself can atomically
handle arbitrary maps and unmaps, performing any necessary super page
fix-ups atomically.  The internal mechanics of the vfio IOMMU would
need to change quite a bit too for tracking and pinning, I suspect.

Do we necessarily need a memory map ioctl for this or could it be the
QEMU code that compares the old and new maps to trigger map and unmap
ioctls?  For example (aiui) our race is that if we have contiguous
memory regions A and B and flatview_simplify() tries to expand A and
delete B we'll see a series of listener notifications deleting A and B
and adding A'.  But the vfio QEMU code could parse the memory map to
determine that old A + B is functionally equivalent to A' and do
nothing.  Do you foresee any breakdowns for such an approach?  Hotplug
concerns me in that a new device only has the current simplified
flatview, ex. we only know A' rather than A + B, so we can't get back
to A + !B like a device with more history could.  Thanks,

Alex


