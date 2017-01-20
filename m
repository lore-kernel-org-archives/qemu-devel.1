Received: from eggs.gnu.org ([2001:4830:134:3::10]:41773)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1cUdoL-0004ae-Cx
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 13:21:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1cUdoH-0000PU-3A
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 13:21:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45672)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1cUdoG-0000P2-Qi
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 13:21:13 -0500
Date: Fri, 20 Jan 2017 11:21:10 -0700
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20170120112110.1493481d@t450s.home>
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D190C14B9E@SHSMSX101.ccr.corp.intel.com>
References: <1483175588-17006-1-git-send-email-caoj.fnst@cn.fujitsu.com>
	<1483175588-17006-4-git-send-email-caoj.fnst@cn.fujitsu.com>
	<20170118153152.2869a1aa@t450s.home>
	<AADFC41AFE54684AB9EE6CBC0274A5D190C14B9E@SHSMSX101.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC v11 3/4] vfio-pci: pass the aer error
 to guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Cao jin <caoj.fnst@cn.fujitsu.com>, Chen Fan <chen.fan.fnst@cn.fujitsu.com>, "izumi.taku@jp.fujitsu.com" <izumi.taku@jp.fujitsu.com>, Dou Liyang <douly.fnst@cn.fujitsu.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "mst@redhat.com" <mst@redhat.com>, Peter Xu <peterx@redhat.com>, "Lan, Tianyu" <tianyu.lan@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>

On Fri, 20 Jan 2017 06:57:22 +0000
"Tian, Kevin" <kevin.tian@intel.com> wrote:

> > From: Alex Williamson
> > Sent: Thursday, January 19, 2017 6:32 AM
> > 
> > On Sat, 31 Dec 2016 17:13:07 +0800
> > Cao jin <caoj.fnst@cn.fujitsu.com> wrote:
> >   
> > > From: Chen Fan <chen.fan.fnst@cn.fujitsu.com>
> > >
> > > When physical device has uncorrectable error hanppened, the vfio_pci
> > > driver will signal the uncorrectable error status register value to
> > > corresponding QEMU's vfio-pci device via the eventfd registered by this
> > > device, then, the vfio-pci's error eventfd handler will be invoked in
> > > event loop.
> > >
> > > Construct and pass the aer message to root port, root port will trigger an
> > > interrupt to signal guest, then, the guest driver will do the recovery.
> > >
> > > Note: Now only support non-fatal error's recovery, fatal error will
> > > still result in vm stop.  
> > 
> > Please update the entire commit log, don't just add a note that this
> > now only covers non-fatal errors.
> >   
> 
> One thing relate to vIOMMU. There is still a TODO task about forwarding
> IOMMU fault thru VFIO to Qemu, so Qemu vIOMMU has the chance to
> walk guest remapping structure to emulate virtual IOMMU fault. Likely
> it also requires eventfd mechanism.
> 
> Wondering whether making sense to reuse same eventfd for both AER
> and vIOMMU or using separate eventfd is also fine? Even go with the
> former option, I don't expect substantial change to this series. Major
> change is on interface definition - extensible to multiple types of 
> fault/error conditions instead of assuming AER only.
> 
> Thoughts?

We can't really convey any information through an eventfd, it's just a
signal, so I don't think we can use the same eventfd for both types of
errors.  Already here we're discussing the idea of using separate
eventfds for fatal vs non-fatal AERs.  IOMMU error processing seems
like yet another eventfd and likely some region or ioctl mechanism for
retrieving the error details since the IOMMU hardware is not directly
accessible.  Furthermore, such an event might logically be connected to
the vfio container rather than the device, so it might not even use the
same file descriptor.  Thanks,

Alex
