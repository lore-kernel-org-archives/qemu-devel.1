Received: from eggs.gnu.org ([2001:4830:134:3::10]:58495)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1dQfMa-0004Xw-E6
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 15:44:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1dQfMX-0006sR-6l
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 15:44:28 -0400
Date: Thu, 29 Jun 2017 13:44:18 -0600
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20170629134418.7b1faea4@w520.home>
In-Reply-To: <804c9b1a-6803-e920-9d3d-60fc33dd2fea@redhat.com>
References: <1498695900-1648-1-git-send-email-mdroth@linux.vnet.ibm.com>
	<804c9b1a-6803-e920-9d3d-60fc33dd2fea@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 0/5] hotplug: fix premature rebinding
 of VFIO devices to host
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laine Stump <laine@redhat.com>
Cc: libvir-list@redhat.com, Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, aik@ozlabs.ru, abologna@redhat.com, pkrempa@redhat.com, berrange@redhat.com, mprivozn@redhat.com, sbhat@linux.vnet.ibm.com

On Thu, 29 Jun 2017 14:50:15 -0400
Laine Stump <laine@redhat.com> wrote:

> On 06/28/2017 08:24 PM, Michael Roth wrote:
> > Hi everyone. Hoping to get some feedback on this approach, or some
> > alternatives proposed below, to the following issue:
> > 
> > Currently libvirt immediately attempts to rebind a managed device back to the
> > host driver when it receives a DEVICE_DELETED event from QEMU. This is
> > problematic for 2 reasons:
> > 
> > 1) If multiple devices from a group are attached to a guest, this can move
> >    the group into a "non-viable" state where some devices are assigned to
> >    the host and some to the guest.  
> 
> Since we don't support hotplug with managed='yes' of individual (or
> multiple) functions of a multifunction host device, I don't know that
> it's very useful to support hot *un*plug of it - it would only be useful
> if the multi-function device were present in the guest when it was
> started, and then was hot-unplugged later. And this is all a lot of
> extra complexity, though, so it would be useful to know what are the
> scenarios where it would actually be used (i.e. is this a legitimate
> need, or just an interesting exercise?)

This doesn't make sense to me, since when do we not support hotplug
with managed='yes' and how is it prevented?  Also, let's just not talk
about multifunction, a multifunction device does not imply a shared
group, nor does a shared group imply multifunction.  So is it hotplug
of a device which is in a shared group that is not supported, and if so
how?  I think libvirt tries to do the hot-add, but it hits the
non-viable group when it gives it to QEMU.  On hot-remove, I'm pretty
sure libvirt just lets the host crash into the ground by re-binding the
device to the host driver.  If we don't want to support it, that's one
thing, but the current model is more just neglectful than unsupported.


> > 2) When QEMU emits the DEVICE_DELETED event, there's still a "finalize" phase
> >    where additional cleanup occurs. In most cases libvirt can ignore this
> >    cleanup, but in the case of VFIO devices this is where closing of a VFIO
> >    group FD occurs, and failing to wait before rebinding the device to the
> >    host driver can result in unexpected behavior. In the case of powernv
> >    hosts at least, this can lead to a host driver crashing due to the default
> >    DMA windows not having been fully-restored yet. The window between this is
> >    and the initial DEVICE_DELETED seems to be ~6 seconds in practice. We've
> >    seen host dumps with Mellanox CX4 VFs being rebound to host driver during
> >    this period (on powernv hosts).  
> 
> I agree with Dan that the situation described here should be considered
> a qemu bug - according to my understanding (from back at the time
> DEVICE_DELETED was added to qemu (I think at libvirt's request) qemu
> should never emit the DEVICE_DELETED event until *everything* related to
> the device is finished - that was the whole point of adding the event in
> the first palce. Covering up this bug with a bunch of extra libvirt
> complexity is just creating the potential for even more bugs in the more
> complex code.

Agree, but ISTR not everyone thinks that way.  I don't remember the
opposing viewpoint though.  Thanks,

Alex
