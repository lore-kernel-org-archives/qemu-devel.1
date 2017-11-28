Received: from eggs.gnu.org ([2001:4830:134:3::10]:46054)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eJh8W-0000Jb-Er
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 09:45:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eJh8T-0007U2-6d
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 09:45:24 -0500
Date: Tue, 28 Nov 2017 15:45:14 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171128154514.026098dc.cohuck@redhat.com>
In-Reply-To: <13a85f8e-28c2-4780-76ad-361913a93d1b@de.ibm.com>
References: <20171121111825.17916-1-pasic@linux.vnet.ibm.com>
	<20171124171510.2343ccdf.cohuck@redhat.com>
	<8c18df3e-92a0-f88f-6d24-e1df051c8138@linux.vnet.ibm.com>
	<20171127135624.28052dc5.cohuck@redhat.com>
	<57f95f61-b9d9-1341-78c7-259006cb5945@linux.vnet.ibm.com>
	<20171127141929.1d692aad.cohuck@redhat.com>
	<39cb6a69-7f32-80d4-214d-26e1e81a9fd7@linux.vnet.ibm.com>
	<2933e058-0217-9696-2c52-613da8ba7a1c@linux.vnet.ibm.com>
	<20171127175607.75bd999e.cohuck@redhat.com>
	<c49e91f1-0f8a-8f6c-9784-21aa4623e2cf@linux.vnet.ibm.com>
	<20171128112233.0a1c8c04.cohuck@redhat.com>
	<377c7bcb-403b-ed66-a9fd-07793c27ea5c@linux.vnet.ibm.com>
	<20171128131448.551e16b7.cohuck@redhat.com>
	<1d81d1c1-6f82-0261-51b4-1820a10431e6@de.ibm.com>
	<99906104-4746-6474-554e-ac85bd20106d@linux.vnet.ibm.com>
	<71ccf8b6-faa6-f4ac-3571-24bb59a0c498@de.ibm.com>
	<20171128150107.4cc88a86.cohuck@redhat.com>
	<13a85f8e-28c2-4780-76ad-361913a93d1b@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 1/1] s390x/css: unresrict cssids
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Halil Pasic <pasic@linux.vnet.ibm.com>, Boris Fiuczynski <fiuczy@linux.vnet.ibm.com>, Shalini Chellathurai Saroja <shalini@linux.vnet.ibm.com>, qemu-s390x@nongnu.org, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, qemu-devel@nongnu.org

On Tue, 28 Nov 2017 15:17:49 +0100
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> On 11/28/2017 03:01 PM, Cornelia Huck wrote:
> > On Tue, 28 Nov 2017 14:25:08 +0100
> > Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> >> What I want now is to enable vfio-ccw for libvirt and Linux guests and for that
> >> we need to lift the restriction of having vfio not in FE.  
> > 
> > This, however, worries me. I don't really consider vfio-ccw ready for
> > prime time yet. We still need to figure out path handling at the very
> > least. And I'm still not sure that our non-handling of halt/clear won't
> > cause major issues with e.g. a storage server error recovery.
> > 
> > Can we flag vfio-ccw as experimental or such in libvirt?  
> 
> We should have flagged vfio-ccw experimental in QEMU then.
> e.g. by using x-vfio-ccw or whatever.I dont think we can do that
> after the facts.

Yes, we should have done that... can't fix that now, unfortunately.

> 
> I am not that deep into vfio-ccw, but I was under the impression that
> the missing features should not affect the vfio interface that is
> created by libvirt. After all this should just be a "-device vfio-ccw,....."
> statement and some setup steps beforehand (unbind + setup of vfio-ccw)

The halt/clear stuff is highly unlikely to influence the configuration
interface. I'm still not too clear about path handling, though. Will we
need different modes (hypervisor managed vs. full passthrough? probably
only passthrough)? What about pgid handling - do we need some kind of
pgid manager? (Keep in mind that you get to set the pgid once. This has
implications for e.g. reserve/release.)

Also, what about devices other than ECKD DASD? Has there been any
testing? Tapes should be interesting; the other interesting ccw devices
are QDIO-based and I'm not sure we want to spend anything on supporting
those.

The interface is probably fine, but I'd like to get an idea about the
path stuff (is the attachment spec that contains the pgid stuff
publicly available, btw.?)

> 
> If your concern is the serviceability I think it would be valid for a RHEL
> KVM to disable vfio-ccw in the kernel. Maybe we could even provide a config
> for QEMU?

It's fine just to turn off vfio-ccw in the kernel.

> PS: I learned from the PCI and CCW experience that I do not want
> to upstream kernel/qemu code unless I have a working libvirt code that
> shows that the thing will work.

Yes, I understand the wish to verify the interface, and I think it's a
good idea. What I'm worried about is that this might be the precursor
to a push to support it, and I don't think vfio-ccw is ready for that
yet.
