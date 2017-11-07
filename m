Received: from eggs.gnu.org ([2001:4830:134:3::10]:60017)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eC1Di-0001VN-E4
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 05:35:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eC1Dc-0000HR-Im
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 05:35:02 -0500
Date: Tue, 7 Nov 2017 11:34:46 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171107113446.6ac51e16.cohuck@redhat.com>
In-Reply-To: <CAKSfGUAvP+EB1J_4=-xAAdGuopHnHmjXC82BGx9tjjK=2_x_sg@mail.gmail.com>
References: <a0750de5-d3ce-3f15-ba12-ce383ded143d@redhat.com>
	<1e04415c-83d5-a6ac-f83f-d7a57b9b9868@redhat.com>
	<CAKSfGUAvP+EB1J_4=-xAAdGuopHnHmjXC82BGx9tjjK=2_x_sg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Crash with pcie-pci-bridge on qemu-system-s390x
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandr Bezzubikov <zuban32s@gmail.com>
Cc: Marcel Apfelbaum <marcel@redhat.com>, qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On Thu, 2 Nov 2017 17:59:58 +0300
Aleksandr Bezzubikov <zuban32s@gmail.com> wrote:

> 2017-11-02 17:42 GMT+03:00 Marcel Apfelbaum <marcel@redhat.com>:
> > On 02/11/2017 16:19, Thomas Huth wrote:  
> >>
> >>   Hi,
> >>  
> >
> > Hi Thomas,
> >  
> 
> Hi Thomas, Marcel,
> 
> >> seems like there's a new way to crash QEMU with the pcie-pci-bridge
> >> device (using QEMU master branch of today):  
> >>  > $ s390x-softmmu/qemu-system-s390x -nographic -S  
> >> QEMU 2.10.50 monitor - type 'help' for more information
> >> (qemu) device_add pcie-pci-bridge,id=x
> >> Segmentation fault (core dumped)
> >>  
> >
> > Thanks for noticing it.
> >  
> >> Does anybody have a clue what might be wrong here?
> >>  
> >
> > It was tested with X86 and I think aarch64.
> > I am not sure how it would work with or if we
> > really need it for s390.
> >
> > We need the device to start a PCI hierarchy by plugging
> > it to PCIe Root Port. If I understand correctly s390
> > does not use PCIe Root Ports and may not need it.
> >  
> 
> Personally I can see 2 issues here:
> 1) [Marcel's already mentioned it] It seems that s390x machines have
> only pure PCI hosts,
> that's why it's a bit weird to put pcie-pci-bridge into the host
> 2) The actual segfault cause is bridge parent bus not having a parent
> device (somehow).
> Maybe it's a consequence of point 1)

Yes. PCI on s390x is weird; we basically have no topology and just make
one up (of which the guest sees nothing at all).

> 
> > If the assumption is correct I suppose we should only
> > be compiled into the above archs.
> > If you agree, I can post a patch for this.

I think disabling this for s390x makes sense.
