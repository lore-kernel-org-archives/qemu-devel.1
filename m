Received: from eggs.gnu.org ([2001:4830:134:3::10]:50480)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1g9mc8-0006sN-Ru
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 03:39:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1g9mc3-0004rQ-Tx
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 03:39:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42196)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1g9mc3-0004pw-6i
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 03:39:27 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7FA05309708F
	for <qemu-devel@nongnu.org>; Tue,  9 Oct 2018 07:39:20 +0000 (UTC)
Date: Tue, 9 Oct 2018 15:38:58 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20181009073858.GK18728@xz-x1>
References: <20181008064713.27349-1-peterx@redhat.com>
	<20181008064713.27349-3-peterx@redhat.com>
	<ce62a481-0b10-2044-dadb-def25af5b77e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ce62a481-0b10-2044-dadb-def25af5b77e@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/2] intel_iommu: handle invalid ce for
 shadow sync
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Auger Eric <eric.auger@redhat.com>
Cc: qemu-devel@nongnu.org, Maxime Coquelin <maxime.coquelin@redhat.com>, Jason Wang <jasowang@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Pei Zhang <pezhang@redhat.com>

On Tue, Oct 09, 2018 at 09:27:15AM +0200, Auger Eric wrote:

[...]

> > @@ -1056,12 +1058,28 @@ static int vtd_sync_shadow_page_table(VTDAddressSpace *vtd_as)
> >  {
> >      int ret;
> >      VTDContextEntry ce;
> > +    IOMMUNotifier *n;
> >  
> >      ret = vtd_dev_to_context_entry(vtd_as->iommu_state,
> >                                     pci_bus_num(vtd_as->bus),
> >                                     vtd_as->devfn, &ce);
> >      if (ret) {
> > -        return ret;
> > +        if (ret == -VTD_FR_CONTEXT_ENTRY_P) {
> > +            /*
> > +             * It's a valid scenario to have a context entry that is
> > +             * not present.  For example, when a device is removed
> > +             * from an existing domain then the context entry will be
> > +             * zeroed by the guest before it was put into another
> > +             * domain.  When this happens, instead of synchronizing
> > +             * the shadow pages we should invalidate all existing
> > +             * mappings and notify the backends.
> > +             */
> > +            IOMMU_NOTIFIER_FOREACH(n, &vtd_as->iommu) {
> > +                vtd_address_space_unmap(vtd_as, n);
> > +            }
> don't you want to return here also in this case?

Yes... a stupid mistake!

I'll repost.  Thank you,

-- 
Peter Xu
