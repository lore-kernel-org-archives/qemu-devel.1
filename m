Received: from eggs.gnu.org ([2001:4830:134:3::10]:60660)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dmbYz-000053-QL
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 04:07:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dmbYu-0004pe-Rk
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 04:07:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35228)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dmbYu-0004pM-Ie
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 04:07:52 -0400
Date: Tue, 29 Aug 2017 10:07:46 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170829100746.66c47fd8.cohuck@redhat.com>
In-Reply-To: <498a00ca-ea1a-ae09-0772-4a25c729841e@linux.vnet.ibm.com>
References: <1503907487-2764-1-git-send-email-zyimin@linux.vnet.ibm.com>
	<1503907487-2764-5-git-send-email-zyimin@linux.vnet.ibm.com>
	<20170828175722.0b54b59a.cohuck@redhat.com>
	<498a00ca-ea1a-ae09-0772-4a25c729841e@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 4/4] s390x/pci: add iommu replay callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, borntraeger@de.ibm.com, pasic@linux.vnet.ibm.com, pmorel@linux.vnet.ibm.com, agraf@suse.de, richard.henderson@linaro.org

[Restored cc:s. Please remember to do reply-all.]

On Tue, 29 Aug 2017 12:46:51 +0800
Yi Min Zhao <zyimin@linux.vnet.ibm.com> wrote:

> =E5=9C=A8 2017/8/28 =E4=B8=8B=E5=8D=8811:57, Cornelia Huck =E5=86=99=E9=
=81=93:
> > On Mon, 28 Aug 2017 10:04:47 +0200
> > Yi Min Zhao <zyimin@linux.vnet.ibm.com> wrote:
> >
> >> Let's introduce iommu replay callback for s390 pci iommu memory region.
> >> Currently we don't need any dma mapping replay. So let it return
> >> directly. This implementation will avoid meaningless loops calling
> >> translation callback.
> >>
> >> Reviewed-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
> >> Reviewed-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> >> Signed-off-by: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
> >> ---
> >>   hw/s390x/s390-pci-bus.c | 8 ++++++++
> >>   1 file changed, 8 insertions(+)
> >>
> >> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
> >> index 9e1f7ff5c5..359509ccea 100644
> >> --- a/hw/s390x/s390-pci-bus.c
> >> +++ b/hw/s390x/s390-pci-bus.c
> >> @@ -407,6 +407,13 @@ static IOMMUTLBEntry s390_translate_iommu(IOMMUMe=
moryRegion *mr, hwaddr addr,
> >>       return ret;
> >>   }
> >>  =20
> >> +static void s390_pci_iommu_replay(IOMMUMemoryRegion *iommu,
> >> +                                  IOMMUNotifier *notifier)
> >> +{
> >> +    /* we don't need iommu replay currently */
> > This really needs to be heavier on the _why_. My guess is that anything
> > which would require replay goes through the rpcit instruction?
> My understanding is:
> Our arch is different from others. Each pci device has its own iommu, not
> like other archs' implementation. So currently there must be no existing
> mappings belonging to any newly plugged pci device whose iommu doesn't
> have any mapping at the time.

So please put that explanation into the function. (Also, "currently"?
Are we expecting it to change?)

> In addition, it's also due to vfio blocking migration. If vfio-pci suppor=
ts
> migration in future, we could implement iommu replay by that time.

That's not an argument: This is the base zpci support, it should not
depend on the supported devices and what they do. (What's the status of
virtio-pci, btw? Does it work with your patches applied, or is there
still more to be done?)
