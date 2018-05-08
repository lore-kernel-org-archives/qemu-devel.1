Received: from eggs.gnu.org ([2001:4830:134:3::10]:33315)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fG361-0004i3-Cd
	for qemu-devel@nongnu.org; Tue, 08 May 2018 09:56:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fG35y-0002M4-4X
	for qemu-devel@nongnu.org; Tue, 08 May 2018 09:56:01 -0400
Date: Tue, 8 May 2018 15:55:51 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180508155551.7cea014f.cohuck@redhat.com>
In-Reply-To: <2a6f6a2a-ddaf-27ae-de04-581dcc67fdd0@linux.ibm.com>
References: <20180507155130.21085-1-cohuck@redhat.com>
	<2a6f6a2a-ddaf-27ae-de04-581dcc67fdd0@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/2] s390x: reset handling for ccw devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Thomas Huth <thuth@redhat.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org

On Tue, 8 May 2018 15:29:50 +0200
Halil Pasic <pasic@linux.ibm.com> wrote:

> On 05/07/2018 05:51 PM, Cornelia Huck wrote:
> > On Friday, Thomas noticed some problems with 3270 devices. One result
> > was "s390x/css: disabled subchannels cannot be status pending", but
> > a reboot did not cure the previous broken status. Turns out that 3270
> > devices are missing a reset handler.
> > 
> > This series cleans up reset handling a bit and makes sure that the base
> > ccw device class provides a subchannel reset handler. I'm currently
> > not sure what we should do with vfio-ccw, so the behaviour there is
> > left unchanged.  
> 
> Had a look, and LGTM (will tag separately) modulo what follows here. I'm
> a bit concerned about vfio-ccw not being made compliant to this new
> he reset of CCWDeviceClass is taking care of resetting the subchannel data
> structures. This feels like introducing a common abstraction
> to me, but then some things bother me.

We are having a common abstraction that can be overwritten by any
specialized implementation - and this is what vfio-ccw is doing,
therefore nothing changes for it.

> In particular the the pim, the lpm and the pam set in css_reset_sch
> seems to suit only devices that use the virtual chp. That
> is it ain't suits any CCWDevice instance.

Yes, we need to revisit this code and split out what makes sense and
what doesn't. For now, we only have virtual devices and vfio-ccw, so
we're fine. It even might make sense to keep them separate in the
future, as having a virtual device and one only mirroring some state in
QEMU sound like they want to be handled differently.

> 
> Do you plan to tackle vfio-ccw reset?

It's on my to-do list (which is sadly quite crowded...)

> 
> > 
> > Cornelia Huck (2):
> >    virtio-ccw: common reset handler
> >    s390x/ccw: make sure all ccw devices are properly reset
> > 
> >   hw/s390x/ccw-device.c |  8 ++++++++
> >   hw/s390x/virtio-ccw.c | 20 ++++++--------------
> >   hw/s390x/virtio-ccw.h |  1 +
> >   3 files changed, 15 insertions(+), 14 deletions(-)
> >   
> 
