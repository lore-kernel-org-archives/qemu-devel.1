Received: from eggs.gnu.org ([2001:4830:134:3::10]:33138)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gQApr-00072n-VO
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 07:45:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gQApo-0006Zo-Jz
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 07:45:27 -0500
Date: Fri, 23 Nov 2018 13:45:17 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20181123134517.0b21c263.cohuck@redhat.com>
In-Reply-To: <853a8421-af17-5130-51b7-3242cc10b989@linux.ibm.com>
References: <20181122165432.4437-1-cohuck@redhat.com>
	<20181122165432.4437-2-cohuck@redhat.com>
	<853a8421-af17-5130-51b7-3242cc10b989@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/3] vfio-ccw: add capabilities chain
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pierre Morel <pmorel@linux.ibm.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>

On Fri, 23 Nov 2018 13:28:25 +0100
Pierre Morel <pmorel@linux.ibm.com> wrote:

> On 22/11/2018 17:54, Cornelia Huck wrote:
> > Allow to extend the regions used by vfio-ccw. The first user will be
> > handling of halt and clear subchannel.
> > 
> > Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> > ---
> >   drivers/s390/cio/vfio_ccw_ops.c     | 182 ++++++++++++++++++++++++----
> >   drivers/s390/cio/vfio_ccw_private.h |  38 ++++++
> >   include/uapi/linux/vfio.h           |   1 +
> >   3 files changed, 195 insertions(+), 26 deletions(-)
> >   
> 
> Halt and clear have no parameters (the sub-channel ID is obviously the 
> one of the mediated device).
> 
> Isn't adding a new sub-region for the purpose of handling halt and clear 
> superfluous?
> 
> What is the reason not to use simple ioctls ?

Should it turn out that we missed something and need an enhanced
interface, we can simply stop providing this subregion and add a new
subregion, without breaking existing userspace. We can't do that with
ioctls.

And moreover, this is only the first user of this infrastructure.
There's also that path handling series that Dong Jia had posted early
this year -- that would be an obvious user as well.
