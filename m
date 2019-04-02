Received: from eggs.gnu.org ([209.51.188.92]:45804)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hBJgh-0006ze-IQ
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 09:42:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hBJgg-0006WL-Lb
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 09:42:51 -0400
Date: Tue, 2 Apr 2019 15:42:42 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190402154242.789ebfde.cohuck@redhat.com>
In-Reply-To: <559babc4-5b67-37c7-eced-c350fc28baf6@linux.ibm.com>
References: <20190301093949.27955-1-cohuck@redhat.com>
	<20190301093949.27955-3-cohuck@redhat.com>
	<559babc4-5b67-37c7-eced-c350fc28baf6@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 2/2] vfio-ccw: support async command
 subregion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Farman <farman@linux.ibm.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Alex Williamson <alex.williamson@redhat.com>

On Thu, 21 Mar 2019 21:38:16 -0400
Eric Farman <farman@linux.ibm.com> wrote:

> On 3/1/19 4:39 AM, Cornelia Huck wrote:
> > A vfio-ccw device may provide an async command subregion for
> > issuing halt/clear subchannel requests. If it is present, use
> > it for sending halt/clear request to the device; if not, fall
> > back to emulation (as done today).
> > 
> > Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> > ---
> >   hw/s390x/css.c              |  27 +++++++--
> >   hw/vfio/ccw.c               | 109 +++++++++++++++++++++++++++++++++++-
> >   include/hw/s390x/s390-ccw.h |   3 +
> >   3 files changed, 133 insertions(+), 6 deletions(-)

> > @@ -307,6 +398,20 @@ static void vfio_ccw_get_region(VFIOCCWDevice *vcdev, Error **errp)
> >       vcdev->io_region_offset = info->offset;
> >       vcdev->io_region = g_malloc0(info->size);
> >   
> > +    /* check for the optional async command region */
> > +    ret = vfio_get_dev_region_info(vdev, VFIO_REGION_TYPE_CCW,
> > +                                   VFIO_REGION_SUBTYPE_CCW_ASYNC_CMD, &info);
> > +    if (!ret) {
> > +        vcdev->async_cmd_region_size = info->size;
> > +        if (sizeof(*vcdev->async_cmd_region) != vcdev->async_cmd_region_size) {
> > +            error_setg(errp, "vfio: Unexpected size of the async cmd region");
> > +            g_free(info);
> > +            return;
> > +        }
> > +        vcdev->async_cmd_region_offset = info->offset;
> > +        vcdev->async_cmd_region = g_malloc0(info->size);  
> 
> Probably need to g_free() this in vfio_ccw_put_region()

Ah yes, thanks. Will add.

> 
> > +    }
> > +
> >       g_free(info);
> >   }
> >   
