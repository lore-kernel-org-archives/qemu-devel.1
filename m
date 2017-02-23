Received: from eggs.gnu.org ([2001:4830:134:3::10]:33307)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cgjFs-0001yx-PI
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 21:35:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cgjFo-0006Po-R8
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 21:35:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37742)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cgjFo-0006Pg-EW
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 21:35:36 -0500
Date: Thu, 23 Feb 2017 10:35:29 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170223023529.GA4015@pxdev.xzpeter.org>
References: <1487742565-2513-1-git-send-email-peterx@redhat.com>
	<CAHyh4xjJ+U8XGAHP4TqzZJqmrZBeeHGA3_Kmg5YrMdy3VbCLJQ@mail.gmail.com>
	<CAHyh4xjELha5V5n+dLwmQsoJ=kfahiZsamo7WEEfMtRgXvRsbw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHyh4xjELha5V5n+dLwmQsoJ=kfahiZsamo7WEEfMtRgXvRsbw@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH] intel_iommu: make sure its init before PCI
 dev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jintack Lim <jintack@cs.columbia.edu>
Cc: QEMU Devel Mailing List <qemu-devel@nongnu.org>, Alex Williamson <alex.williamson@redhat.com>, yi.l.liu@intel.com, "\\ Michael S . Tsirkin \\" <mst@redhat.com>

On Wed, Feb 22, 2017 at 08:37:32AM -0500, Jintack Lim wrote:
> On Wed, Feb 22, 2017 at 6:42 AM, Jintack Lim <jintack@cs.columbia.edu>
> wrote:
> 
> >
> >
> > On Wed, Feb 22, 2017 at 12:49 AM, Peter Xu <peterx@redhat.com> wrote:
> >
> >> Intel vIOMMU devices are created with "-device" parameter, while here
> >> actually we need to make sure this device will be created before some
> >> other PCI devices (like vfio-pci devices) so that we know iommu_fn will
> >> be setup correctly before realizations of those PCI devices.
> >>
> >> Here we do explicit check to make sure intel-iommu device will be inited
> >> before all the rest of the PCI devices. This is done by checking against
> >> the devices dangled under current root PCIe bus and we should see
> >> nothing there besides integrated ICH9 ones.
> >>
> >> If the user violated this rule, we abort the program.
> >>
> >
> > Hi Peter,
> >
> > After applying this patch, qemu gave the following error and was
> > terminated, but I believe I passed parameters in a right order?
> >
> 
> FYI, I've applied this patch to your vtd-vfio-enablement-v7 branch.

I think the problem is that I was always testing with "-nodefaults",
while that's not your case... And without "-nodefaults" we'll have
these two devices created before all the rest:

00:01.0 VGA compatible controller: Device 1234:1111 (rev 02)
00:02.0 Ethernet controller: Intel Corporation 82540EM Gigabit Ethernet Controller (rev 03)

So Intel vIOMMU complaint. :(

Thanks for the report! I'll think of something better and prepare
another version.

-- peterx
