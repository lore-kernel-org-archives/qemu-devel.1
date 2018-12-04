Received: from eggs.gnu.org ([2001:4830:134:3::10]:52454)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gUAUJ-0002UV-HU
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 08:11:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gUAUG-0004sQ-E2
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 08:11:43 -0500
Date: Tue, 4 Dec 2018 14:11:30 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20181204141130.06496b9b.cohuck@redhat.com>
In-Reply-To: <20181204133810.66e8cfe5@oc2783563651>
References: <20181122165432.4437-1-cohuck@redhat.com>
	<20181204133810.66e8cfe5@oc2783563651>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/3] vfio-ccw: support hsch/csch (kernel
 part)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: Eric Farman <farman@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>

On Tue, 4 Dec 2018 13:38:10 +0100
Halil Pasic <pasic@linux.ibm.com> wrote:

> On Thu, 22 Nov 2018 17:54:29 +0100
> Cornelia Huck <cohuck@redhat.com> wrote:
> 
> > [This is the Linux kernel part, git tree is available at
> > https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/vfio-ccw.git vfio-ccw-caps
> > 
> > The companion QEMU patches are available at
> > https://github.com/cohuck/qemu vfio-ccw-caps]
> > 
> > Currently, vfio-ccw only relays START SUBCHANNEL requests to the real
> > device. This tends to work well for the most common 'good path' scenarios;
> > however, as we emulate {HALT,CLEAR} SUBCHANNEL in QEMU, things like
> > clearing pending requests at the device is currently not supported.
> > This may be a problem for e.g. error recovery.  
> 
> I'm wondering: what about MODIFY SUBCHANNEL? Do we plan to add MSCH
> as well or is it supposed to remain 'userspace emulated'? AFAIR MSCH
> may have an effect on error recovery as well.

I think that would require a deeper change, as we have the requirement
to enable the subchannel before handing it to userspace. IOW, the guest
does not cause the subchannel to be enabled/disabled, but the host does.

Parameters (like for channel measurements) are a different game. It is
something we should look into, but it will need a different region.

> BTW I would like to have the concurrency discussion sorted out before
> I proceed with my review, because reviewing the stuff without a fair idea
> of what exactly are we trying to achieve would yield poor results.

I'm not sure what is unclear about what we're trying to achieve (enable
the guest to issue halt/clear on real hardware)?

But yes, we need to sort out that concurrency thing; I'm currently
unsure if the core should do some things as well or if it's more of a
vendor-driver thing.
