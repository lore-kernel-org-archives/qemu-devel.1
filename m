Received: from eggs.gnu.org ([2001:4830:134:3::10]:50835)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gSePV-0000en-Od
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 03:44:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gSeID-0006zl-7Q
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 03:37:00 -0500
Date: Fri, 30 Nov 2018 09:36:40 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20181130093640.0310c621.cohuck@redhat.com>
In-Reply-To: <555d039d-16ef-f279-fd48-f0d422f7905a@linux.ibm.com>
References: <1542904555-1136-1-git-send-email-pmorel@linux.ibm.com>
	<1542904555-1136-7-git-send-email-pmorel@linux.ibm.com>
	<555d039d-16ef-f279-fd48-f0d422f7905a@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 6/6] s390x/vfio: ap: Implementing AP
 Queue Interrupt Control
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Tony Krowiak <akrowiak@linux.ibm.com>
Cc: Pierre Morel <pmorel@linux.ibm.com>, borntraeger@de.ibm.com, agraf@suse.de, rth@twiddle.net, david@redhat.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, peter.maydell@linaro.org, pbonzini@redhat.com, mst@redhat.com, eric.auger@redhat.com, pasic@linux.ibm.com

On Thu, 29 Nov 2018 16:53:28 -0500
Tony Krowiak <akrowiak@linux.ibm.com> wrote:

> On 11/22/18 11:35 AM, Pierre Morel wrote:

> > +static uint32_t ap_pqap_clear_irq(VFIODevice *vdev, APQueue *apq)
> > +{
> > +    struct vfio_ap_aqic param;
> > +    uint32_t retval;
> > +
> > +    param.apqn = apq->apqn;
> > +    param.isc = apq->isc;
> > +    param.argsz = sizeof(param);
> > +
> > +    retval = ioctl(vdev->fd, VFIO_AP_CLEAR_IRQ, &param);
> > +    switch (retval) {
> > +    case 0:    /* Fall through and return the instruction status */  
> 
> Unnecessary comment, we can see the code is going to fall through and
> return status. Sorry, I know its a nit.

FWIW, some static code checking tools look for annotations like
/* Fallthrough */ as an indication that a fallthrough is actually
intended and not a coding error.
