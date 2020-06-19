Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEF6CC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 11:47:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9ACB20CC7
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 11:47:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a7QWYAV7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9ACB20CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmFUJ-0002Ke-TT
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 07:47:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48026)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jmFTR-0001Bg-0X
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 07:46:21 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:23996
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jmFTO-0003tv-DQ
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 07:46:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592567177;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JHrxsfCavGiyDkkSAZExmJW2OtFX6Se8crnVan55diI=;
 b=a7QWYAV7E3I/5h1QkZnTIDME7Ho2j7chJJfC7Gi2TA6n9k++rIv1juQ4zGDEm3yv/MPg3C
 AVWQR31DsgX+ouIlnLP/+zXpsNKc2BGeEWLzD2va2jweAY2SNfDKTuLh+7LKl+ioG4ySH2
 4HUUAtzWQXchXw+75HdWmWmfzd2+bXU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-152-OpCwg5cbOsK2juSqD0NE4Q-1; Fri, 19 Jun 2020 07:46:15 -0400
X-MC-Unique: OpCwg5cbOsK2juSqD0NE4Q-1
Received: by mail-wm1-f69.google.com with SMTP id b63so4030807wme.1
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2020 04:46:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=/txUJLTsCGWI2jJ+EPr2kRf/3k5YaazR3qPt83U1j94=;
 b=Zf9+Sdb/bOLngaBjNM482f3d7Jtq58wAl8OrpSH0Iq04DNIHTJ+7WkxElrLxCMiKt9
 JTWku23QVNP2MdhnXHL7RpL5p2715jzUYW1a1oqxZ/mwnfjIcGaUaA7wRRbihEDzZTOA
 3R0rs/ynhsSiPKjqiaGwoNm3fx88D2ZNmaJo7ZuEuAppyhX2nKKTkoU6RqrzToJ7OLhu
 OmrygooFOd5xDVzKvu4nZLzO/GYGjdfE8/yvW7ilpPyyNKnEHOasU/IsflmTxSvJcxE0
 4fczNZmDWpOyladkLJTfUxnmERe7CpbGpz4aQb1NtRvgJjoezeMDK7GvuV6bI9vzcXDG
 shNw==
X-Gm-Message-State: AOAM531Kr5pcK/KQ9vuoatyDPWcxWxW19gV8qvzkzuuc5FmH0C3OJGnR
 O7Wafnl0Afp2VJVYQ9t2k0gbfik3xeSQ5W5j8sXIMtzgTDIsCnwec4LrW5cwVmUBmIFPDRwPa4k
 h+ZIM3HmBe3hmA5E=
X-Received: by 2002:a5d:4903:: with SMTP id x3mr3831867wrq.351.1592567174592; 
 Fri, 19 Jun 2020 04:46:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzyE+AprZveIUH1rr2brcb+FX1fg23kiEzxeBsxNbpesGWafMAFpRcl46POsQmCIkorW834sw==
X-Received: by 2002:a5d:4903:: with SMTP id x3mr3831839wrq.351.1592567174362; 
 Fri, 19 Jun 2020 04:46:14 -0700 (PDT)
Received: from redhat.com (bzq-79-178-18-124.red.bezeqint.net. [79.178.18.124])
 by smtp.gmail.com with ESMTPSA id d2sm7036388wrs.95.2020.06.19.04.46.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jun 2020 04:46:13 -0700 (PDT)
Date: Fri, 19 Jun 2020 07:46:10 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH v3 9/9] host trust limitation: Alter virtio default
 properties for protected guests
Message-ID: <20200619074432-mutt-send-email-mst@kernel.org>
References: <20200619020602.118306-1-david@gibson.dropbear.id.au>
 <20200619020602.118306-10-david@gibson.dropbear.id.au>
 <20200619101245.GC700896@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200619101245.GC700896@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/19 02:45:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
 qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>,
 dgilbert@redhat.com, pasic@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org, pbonzini@redhat.com, Richard Henderson <rth@twiddle.net>,
 mdroth@linux.vnet.ibm.com, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jun 19, 2020 at 11:12:45AM +0100, Daniel P. Berrangé wrote:
> On Fri, Jun 19, 2020 at 12:06:02PM +1000, David Gibson wrote:
> > The default behaviour for virtio devices is not to use the platforms normal
> > DMA paths, but instead to use the fact that it's running in a hypervisor
> > to directly access guest memory.  That doesn't work if the guest's memory
> > is protected from hypervisor access, such as with AMD's SEV or POWER's PEF.
> > 
> > So, if a host trust limitation mechanism is enabled, then apply the
> > iommu_platform=on option so it will go through normal DMA mechanisms.
> > Those will presumably have some way of marking memory as shared with the
> > hypervisor or hardware so that DMA will work.
> > 
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > ---
> >  hw/core/machine.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> > 
> > diff --git a/hw/core/machine.c b/hw/core/machine.c
> > index a71792bc16..8dfc1bb3f8 100644
> > --- a/hw/core/machine.c
> > +++ b/hw/core/machine.c
> > @@ -28,6 +28,8 @@
> >  #include "hw/mem/nvdimm.h"
> >  #include "migration/vmstate.h"
> >  #include "exec/host-trust-limitation.h"
> > +#include "hw/virtio/virtio.h"
> > +#include "hw/virtio/virtio-pci.h"
> >  
> >  GlobalProperty hw_compat_5_0[] = {
> >      { "virtio-balloon-device", "page-poison", "false" },
> > @@ -1165,6 +1167,15 @@ void machine_run_board_init(MachineState *machine)
> >           * areas.
> >           */
> >          machine_set_mem_merge(OBJECT(machine), false, &error_abort);
> > +
> > +        /*
> > +         * Virtio devices can't count on directly accessing guest
> > +         * memory, so they need iommu_platform=on to use normal DMA
> > +         * mechanisms.  That requires disabling legacy virtio support
> > +         * for virtio pci devices
> > +         */
> > +        object_register_sugar_prop(TYPE_VIRTIO_PCI, "disable-legacy", "on");
> > +        object_register_sugar_prop(TYPE_VIRTIO_DEVICE, "iommu_platform", "on");
> >      }
> 
> Silently changing the user's request configuration like this is a bad idea.
> The "disable-legacy" option in particular is undesirable as that switches
> the device to virtio-1.0 only mode, which exposes a different PCI ID to
> the guest.
> 
> If some options are incompatible with encryption, then we should raise a
> fatal error at startup, so applications/admins are aware that their requested
> config is broken.
> 
> Regards,
> Daniel

Agreed - my suggestion is an on/off/auto property, auto value
changes automatically, on/off is validated.


> -- 
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


