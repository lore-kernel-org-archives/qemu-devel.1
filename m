Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9A16C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 07:57:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98F2620874
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 07:57:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Izek+lYp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98F2620874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48070 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jo0HT-0004Tt-Qm
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 03:57:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37628)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jo0GR-0002zb-Gk
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 03:56:11 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:60858
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jo0GO-0007IG-A3
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 03:56:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592985367;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t606ioH+MyToxmIqUfDOa8Few5lSAvsNjrEA0eu5ko0=;
 b=Izek+lYp5uER/pj6mjo5GN0LcZCMHWFoFFGCZGZE7V0ljM4McoOlbEVEHBgrl7zc5FwpH3
 lIRX26Jj6Eo1R2ehGUXBGDldGjDpX3QZQTin4l8jf9gw30vw1x7HnvCOzSmIDomuAOwgHK
 u0iN2G5pz6p3FSXRTQ56pa3WA8i/Rl0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-291-QLiEdWc3OMqedp0bcIDQWw-1; Wed, 24 Jun 2020 03:56:05 -0400
X-MC-Unique: QLiEdWc3OMqedp0bcIDQWw-1
Received: by mail-wr1-f71.google.com with SMTP id n4so206161wrj.15
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2020 00:56:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=jGLpjtaK4gx9ypihPopUPCr5NEjJhJ3CIRNBT38ZCPg=;
 b=Ry2q6IRpx2nxtkBVBG9xCyk7jdV+i0qYN9/Dt6FDDyXIHfMZV0OeckBtDYkIyUFiXr
 4BMVnrqXWP2bYXgmY2yum25SOqEPwz23+ni4YvFc4+7mrjIdyu6l6FgjfndhLQ5EZz6b
 7QP4vYwoE3u1prat8Oq3gn56T1JiuUodevFtgU64zB7HtA0MTGrFq+pbOZ3jP3phMnaX
 rC7nknQpk3FauV5XQRoFs+ffwdOg7PNYQcc4+JCR/D25ihZc0LQGP1js568Ahq0Yv8rE
 r1b1voYGv6UdmkXnVDv5lAJjFlf8NhnFKRIIhYAAqPYvd0AwmKCTVoiBjxoEp+D6Owtn
 drWg==
X-Gm-Message-State: AOAM530C+XkvdZgX/MMPyhRmZIFZBfinsigcJbvhuFQi0FCstwNHWWTf
 +IDcQrgbBue+mC414qwFD6AIdA9qEQn1xje7BzLF71JIQaRRY1A71rq17NK2Wq+nkSnb3BRSzh/
 pMhqjgVGsqQmTDes=
X-Received: by 2002:a5d:6651:: with SMTP id f17mr16581137wrw.29.1592985364628; 
 Wed, 24 Jun 2020 00:56:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxQierUv/ZViS8VI68a8MUeEYG60ndQYpclpxQhLzof5wumctFwEDuPBGfgqDfPpwi858vT7g==
X-Received: by 2002:a5d:6651:: with SMTP id f17mr16581112wrw.29.1592985364323; 
 Wed, 24 Jun 2020 00:56:04 -0700 (PDT)
Received: from redhat.com ([82.166.20.53])
 by smtp.gmail.com with ESMTPSA id c18sm1057269wmk.18.2020.06.24.00.56.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2020 00:56:03 -0700 (PDT)
Date: Wed, 24 Jun 2020 03:55:59 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH v3 9/9] host trust limitation: Alter virtio default
 properties for protected guests
Message-ID: <20200624034932-mutt-send-email-mst@kernel.org>
References: <20200619020602.118306-1-david@gibson.dropbear.id.au>
 <20200619020602.118306-10-david@gibson.dropbear.id.au>
 <20200619101245.GC700896@redhat.com>
 <20200619074432-mutt-send-email-mst@kernel.org>
 <20200619074630-mutt-send-email-mst@kernel.org>
 <20200619121638.GK700896@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200619121638.GK700896@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/24 01:59:40
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
Cc: pair@us.ibm.com, brijesh.singh@amd.com, frankja@linux.ibm.com,
 kvm@vger.kernel.org, david@redhat.com, cohuck@redhat.com,
 qemu-devel@nongnu.org, dgilbert@redhat.com, pasic@linux.ibm.com,
 qemu-s390x@nongnu.org, qemu-ppc@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>, pbonzini@redhat.com,
 Richard Henderson <rth@twiddle.net>, mdroth@linux.vnet.ibm.com,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jun 19, 2020 at 01:16:38PM +0100, Daniel P. Berrangé wrote:
> On Fri, Jun 19, 2020 at 07:47:20AM -0400, Michael S. Tsirkin wrote:
> > On Fri, Jun 19, 2020 at 07:46:14AM -0400, Michael S. Tsirkin wrote:
> > > On Fri, Jun 19, 2020 at 11:12:45AM +0100, Daniel P. BerrangÃƒÂ© wrote:
> > > > On Fri, Jun 19, 2020 at 12:06:02PM +1000, David Gibson wrote:
> > > > > The default behaviour for virtio devices is not to use the platforms normal
> > > > > DMA paths, but instead to use the fact that it's running in a hypervisor
> > > > > to directly access guest memory.  That doesn't work if the guest's memory
> > > > > is protected from hypervisor access, such as with AMD's SEV or POWER's PEF.
> > > > > 
> > > > > So, if a host trust limitation mechanism is enabled, then apply the
> > > > > iommu_platform=on option so it will go through normal DMA mechanisms.
> > > > > Those will presumably have some way of marking memory as shared with the
> > > > > hypervisor or hardware so that DMA will work.
> > > > > 
> > > > > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > > > > ---
> > > > >  hw/core/machine.c | 11 +++++++++++
> > > > >  1 file changed, 11 insertions(+)
> > > > > 
> > > > > diff --git a/hw/core/machine.c b/hw/core/machine.c
> > > > > index a71792bc16..8dfc1bb3f8 100644
> > > > > --- a/hw/core/machine.c
> > > > > +++ b/hw/core/machine.c
> > > > > @@ -28,6 +28,8 @@
> > > > >  #include "hw/mem/nvdimm.h"
> > > > >  #include "migration/vmstate.h"
> > > > >  #include "exec/host-trust-limitation.h"
> > > > > +#include "hw/virtio/virtio.h"
> > > > > +#include "hw/virtio/virtio-pci.h"
> > > > >  
> > > > >  GlobalProperty hw_compat_5_0[] = {
> > > > >      { "virtio-balloon-device", "page-poison", "false" },
> > > > > @@ -1165,6 +1167,15 @@ void machine_run_board_init(MachineState *machine)
> > > > >           * areas.
> > > > >           */
> > > > >          machine_set_mem_merge(OBJECT(machine), false, &error_abort);
> > > > > +
> > > > > +        /*
> > > > > +         * Virtio devices can't count on directly accessing guest
> > > > > +         * memory, so they need iommu_platform=on to use normal DMA
> > > > > +         * mechanisms.  That requires disabling legacy virtio support
> > > > > +         * for virtio pci devices
> > > > > +         */
> > > > > +        object_register_sugar_prop(TYPE_VIRTIO_PCI, "disable-legacy", "on");
> > > > > +        object_register_sugar_prop(TYPE_VIRTIO_DEVICE, "iommu_platform", "on");
> > > > >      }
> > > > 
> > > > Silently changing the user's request configuration like this is a bad idea.
> > > > The "disable-legacy" option in particular is undesirable as that switches
> > > > the device to virtio-1.0 only mode, which exposes a different PCI ID to
> > > > the guest.
> > > > 
> > > > If some options are incompatible with encryption, then we should raise a
> > > > fatal error at startup, so applications/admins are aware that their requested
> > > > config is broken.
> > >
> > > Agreed - my suggestion is an on/off/auto property, auto value
> > > changes automatically, on/off is validated.
> > 
> > In fact should we extend all bit properties to allow an auto value?
> 
> If "auto" was made the default that creates a similar headache, as to
> preserve existing configuration semantics we expose to apps, libvirt
> would need to find all the properties changed to use "auto" and manually
> set them back to on/off explicitly.
> 
> Regards,
> Daniel

It's QEMU's job to try and have more or less consistent semantics across
versions. QEMU does not guarantee not to change any option defaults
though.

My point is to add ability to differentiate between property values
set by user and ones set by machine type for compatibility.


-- 
MST


