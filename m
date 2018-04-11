Received: from eggs.gnu.org ([2001:4830:134:3::10]:42055)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1f6BsI-0002Q7-UK
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 05:17:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1f6BsF-0000YC-Pc
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 05:17:06 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46700 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1f6BsF-0000Wg-K1
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 05:17:03 -0400
Date: Wed, 11 Apr 2018 17:16:47 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180411091647.GG13887@xz-mi>
References: <20180411072027.5656-1-tiwei.bie@intel.com>
	<20180411080036.GD13887@xz-mi>
	<20180411082556.3hjaubnnw3hbpnp3@debian>
	<20180411083716.GE13887@xz-mi>
	<20180411085525.ius2cj2z2e2j6vs7@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180411085525.ius2cj2z2e2j6vs7@debian>
Subject: Re: [Qemu-devel] [RFC] vhost-user: introduce F_NEED_ALL_IOTLB
 protocol feature
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Tiwei Bie <tiwei.bie@intel.com>
Cc: mst@redhat.com, jasowang@redhat.com, qemu-devel@nongnu.org, dan.daly@intel.com, cunming.liang@intel.com, zhihong.wang@intel.com

On Wed, Apr 11, 2018 at 04:55:25PM +0800, Tiwei Bie wrote:
> On Wed, Apr 11, 2018 at 04:37:16PM +0800, Peter Xu wrote:
> > On Wed, Apr 11, 2018 at 04:25:56PM +0800, Tiwei Bie wrote:
> > > On Wed, Apr 11, 2018 at 04:00:36PM +0800, Peter Xu wrote:
> > > > On Wed, Apr 11, 2018 at 03:20:27PM +0800, Tiwei Bie wrote:
> > > > 
> > > > [...]
> > > > 
> > > > > This is just a RFC for now. It seems that, it doesn't work
> > > > > as expected when guest is using kernel driver (To handle
> > > > > this case, it seems that some RAM regions' events also need
> > > > > to be listened). Any comments would be appreciated! Thanks!
> > > > 
> > > > Hi, Tiwei,
> > > > 
> > > > What's your kernel command line in the guest?  Is iommu=pt there?
> > > 
> > > Yeah, you are right! The related things in kernel command line are:
> > > 
> > > iommu=pt intel_iommu=on
> > > 
> > > Hmm, how will this param affect vIOMMU's behaviour?..
> > 
> > If iommu=pt is there, guest kernel will try to bypass IOMMU, the IOMMU
> > regions will be disabled completely in that case, hence it's very
> > possible that your IOMMU memory listeners won't get anything useful.
> > 
> > Maybe you can consider removing iommu=pt in the guest parameter to see
> > whether the guest kernel driver could work.
> 
> Cool. I'll give it a try! Considering we may also need to
> handle the iommu=pt case, is there any event in QEMU can
> be used to know whether the IOMMU regions are disabled
> or enabled by the guest?

You may consider to use similar way like below patch to detect that:

  https://patchwork.kernel.org/patch/9735739/

That was a patch trying to preheat the vhost cache.  It was refused at
that time, but IMHO the logic can be used.  You can just send the
updates only if your new flag set.  Then that won't be a preheat any
more, but a must for your hardwares to work.

-- 
Peter Xu
