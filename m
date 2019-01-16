Received: from eggs.gnu.org ([209.51.188.92]:58289)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gjhdm-0008N8-9O
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 04:37:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gjhdi-0000Up-8u
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 04:37:40 -0500
Date: Wed, 16 Jan 2019 10:37:22 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190116103722.4039e53b.cohuck@redhat.com>
In-Reply-To: <e897906c-9e69-16e2-9039-1e55fbac576e@linux.ibm.com>
References: <20190114103110.10909-1-david@redhat.com>
	<20190114103110.10909-5-david@redhat.com>
	<e897906c-9e69-16e2-9039-1e55fbac576e@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 4/6] s390x/pci: Ignore the unplug call
 if we already have a release_timer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Collin Walling <walling@linux.ibm.com>
Cc: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, Richard Henderson <rth@twiddle.net>

On Tue, 15 Jan 2019 17:53:17 -0500
Collin Walling <walling@linux.ibm.com> wrote:

> On 1/14/19 5:31 AM, David Hildenbrand wrote:
> > ... otherwise two successive calls to qdev_unplug() (e.g. by an impatient
> > user) will effectively overwrite pbdev->release_timer, resulting in a
> > memory leak. We are already processing the unplug.
> >   
> 
> Does QEMU not have a way to detect if a device is already in the process 
> of being unplugged? Seems like not having that kind of protection could 
> cause many problems.

There's also that unplug_request callback, which the next patch will
start to use. That pluggery for s390x pci is really a mess :(

> 
> Perhaps that effort would be arduous.
> 
> > If there is already a release_timer, the unplug will be performed after
> > the timeout.
> > 
> > Can be easily triggered by
> > (hmp) device_add virtio-mouse-pci,id=test
> > (hmp) stop
> > (hmp) device_del test
> > (hmp) device_del test
> > 
> > Signed-off-by: David Hildenbrand <david@redhat.com>
> > ---
> >   hw/s390x/s390-pci-bus.c | 3 +++
> >   1 file changed, 3 insertions(+)
> > 
> > diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
> > index 59325cae3b..34a9cb2a80 100644
> > --- a/hw/s390x/s390-pci-bus.c
> > +++ b/hw/s390x/s390-pci-bus.c
> > @@ -972,6 +972,9 @@ static void s390_pcihost_unplug(HotplugHandler *hotplug_dev, DeviceState *dev,
> >       case ZPCI_FS_STANDBY:
> >           break;
> >       default:
> > +        if (pbdev->release_timer) {
> > +            return;
> > +        }
> >           s390_pci_generate_plug_event(HP_EVENT_DECONFIGURE_REQUEST,
> >                                        pbdev->fh, pbdev->fid);
> >           pbdev->release_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
> >   
> 
> Looks good to me.
> 
> Reviewed-by: Collin Walling <walling@linux.ibm.com>
> 
