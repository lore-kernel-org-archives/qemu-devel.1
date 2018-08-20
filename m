Received: from eggs.gnu.org ([2001:4830:134:3::10]:34077)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1frlaH-0000R1-Hy
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 10:55:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1frlaD-0005qX-CP
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 10:55:09 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51946 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1frlaD-0005qD-6F
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 10:55:05 -0400
Date: Mon, 20 Aug 2018 08:55:03 -0600
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20180820085503.296a8a62@t450s.home>
In-Reply-To: <CAFEAcA-jyx-=BeHWM4PVner4oZBYttY0piXBq2VMv7RseMpHZA@mail.gmail.com>
References: <153452552631.13804.12031418293966530953.stgit@gimli.home>
	<153452572774.13804.6638165053676391508.stgit@gimli.home>
	<CAFEAcA-jyx-=BeHWM4PVner4oZBYttY0piXBq2VMv7RseMpHZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 4/4] vfio/ccw/pci: Allow devices to opt-in
 for ballooning
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Mon, 20 Aug 2018 15:23:35 +0100
Peter Maydell <peter.maydell@linaro.org> wrote:

> On 17 August 2018 at 18:08, Alex Williamson <alex.williamson@redhat.com> wrote:
> > If a vfio assigned device makes use of a physical IOMMU, then memory
> > ballooning is necessarily inhibited due to the page pinning, lack of
> > page level granularity at the IOMMU, and sufficient notifiers to both
> > remove the page on balloon inflation and add it back on deflation.
> > However, not all devices are backed by a physical IOMMU.  In the case
> > of mediated devices, if a vendor driver is well synchronized with the
> > guest driver, such that only pages actively used by the guest driver
> > are pinned by the host mdev vendor driver, then there should be no
> > overlap between pages available for the balloon driver and pages
> > actively in use by the device.  Under these conditions, ballooning
> > should be safe.
> >
> > vfio-ccw devices are always mediated devices and always operate under
> > the constraints above.  Therefore we can consider all vfio-ccw devices
> > as balloon compatible.
> >
> > The situation is far from straightforward with vfio-pci.  These
> > devices can be physical devices with physical IOMMU backing or
> > mediated devices where it is unknown whether a physical IOMMU is in
> > use or whether the vendor driver is well synchronized to the working
> > set of the guest driver.  The safest approach is therefore to assume
> > all vfio-pci devices are incompatible with ballooning, but allow user
> > opt-in should they have further insight into mediated devices.
> >
> > Signed-off-by: Alex Williamson <alex.williamson@redhat.com>  
> 
> > @@ -2869,6 +2870,27 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
> >          }
> >      }
> >
> > +    /*
> > +     * Mediated devices *might* operate compatibly with memory ballooning, but
> > +     * we cannot know for certain, it depends on whether the mdev vendor driver
> > +     * stays in sync with the active working set of the guest driver.  Prevent
> > +     * the x-balloon-allowed option unless this is minimally an mdev device.
> > +     */
> > +    tmp = g_strdup_printf("%s/subsystem", vdev->vbasedev.sysfsdev);
> > +    subsys = realpath(tmp, NULL);
> > +    g_free(tmp);
> > +    is_mdev = (strcmp(subsys, "/sys/bus/mdev") == 0);
> > +    free(subsys);  
> 
> Hi -- Coverity points out that we aren't checking the return
> value from realpath() here. It returns NULL on failure, in
> which case we'll pass NULL into strcmp() and segfault.
> (CID 1395101).

Thanks, patch posted.  The fix is trivial, you're welcome to pull it in
directly, otherwise I'll send a pull request if qemu-trivial doesn't
get to it first.  Thanks,

Alex
