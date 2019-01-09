Received: from eggs.gnu.org ([209.51.188.92]:52382)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ghC4U-0003TV-4m
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 06:30:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ghC4S-0005QE-L9
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 06:30:53 -0500
Date: Wed, 9 Jan 2019 12:30:37 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190109123037.7f51888f.cohuck@redhat.com>
In-Reply-To: <d4599c55-2d71-e1e9-ec7a-cffbc7d06abe@redhat.com>
References: <1546963310-17024-1-git-send-email-akrowiak@linux.ibm.com>
	<5a7e9130-30d1-84ad-0737-5023b718b99c@redhat.com>
	<54bc1f9c-e997-cb1b-77cb-0dce478fafdc@linux.ibm.com>
	<d4599c55-2d71-e1e9-ec7a-cffbc7d06abe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] s390x/vfio-ap: Implement hot plug/unplug
 of vfio-ap device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: Tony Krowiak <akrowiak@linux.ibm.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, borntraeger@de.ibm.com, pmorel@linux.ibm.com, alifm@linux.ibm.com, mjrosato@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.vnet.ibm.com, alex.williamson@redhat.com, peter.maydell@linaro.org, rth@twiddle.net, fiuczy@linux.ibm.com

On Tue, 8 Jan 2019 23:13:39 +0100
David Hildenbrand <david@redhat.com> wrote:

> On 08.01.19 20:52, Tony Krowiak wrote:
> > On 1/8/19 11:09 AM, David Hildenbrand wrote:  
> >> On 08.01.19 17:01, Tony Krowiak wrote:  
> >>> Introduces hot plug/unplug support for the vfio-ap device. Note that only one
> >>> vfio-ap device can be attached to the ap-bus, so a vfio-ap device can only be
> >>> hot plugged if the '-device vfio-ap,sysfsdev=$path_to_mdev' option is not
> >>> specified on the QEMU command line.
> >>>
> >>> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
> >>> Reviewed-by: Pierre Morel<pmorel@linux.ibm.com>
> >>> Tested-by: Pierre Morel<pmorel@linux.ibm.com>
> >>> ---
> >>>   hw/s390x/ap-bridge.c | 12 +++++++++++-
> >>>   hw/vfio/ap.c         |  2 +-
> >>>   2 files changed, 12 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/hw/s390x/ap-bridge.c b/hw/s390x/ap-bridge.c
> >>> index 3795d30dd7c9..25a03412fcb9 100644
> >>> --- a/hw/s390x/ap-bridge.c
> >>> +++ b/hw/s390x/ap-bridge.c
> >>> @@ -39,6 +39,7 @@ static const TypeInfo ap_bus_info = {
> >>>   void s390_init_ap(void)
> >>>   {
> >>>       DeviceState *dev;
> >>> +    BusState *bus;
> >>>   
> >>>       /* If no AP instructions then no need for AP bridge */
> >>>       if (!s390_has_feat(S390_FEAT_AP)) {
> >>> @@ -52,13 +53,18 @@ void s390_init_ap(void)
> >>>       qdev_init_nofail(dev);
> >>>   
> >>>       /* Create bus on bridge device */
> >>> -    qbus_create(TYPE_AP_BUS, dev, TYPE_AP_BUS);
> >>> +    bus = qbus_create(TYPE_AP_BUS, dev, TYPE_AP_BUS);
> >>> +
> >>> +    /* Enable hotplugging */
> >>> +    qbus_set_hotplug_handler(bus, dev, &error_abort);
> >>>    }
> >>>   
> >>>   static void ap_bridge_class_init(ObjectClass *oc, void *data)
> >>>   {
> >>>       DeviceClass *dc = DEVICE_CLASS(oc);
> >>> +    HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(oc);
> >>>   
> >>> +    hc->unplug = qdev_simple_device_unplug_cb;  
> >>
> >> confused, why is there no plug action?  
> > 
> > You will find this is the case for several devices that are hot
> > pluggable.  
> 
> Usually missing hotplug handlers are an indication of legacy code ;)
> 
> > The plug callback is invoked after the device is
> > attached to the bus and after the device is realized. Not having
> > a hot plug callback does not preclude hot plugging of a device.  
> 
> The hotplug handler is there to
> 
> 1. Assign resources (e.g. ids etc)
> 2. Notify the system (e.g. hotplug interrupt)
> 
> In legacy code (e.g. PCI) such stuff is usually still located in the
> realize function (where it doesn't belong anymore but factoring out is
> hard ...)
> 
> Looking at hw/vfio/ap.c:realize(), there isn't really anything in there.
> 
> So I assume that
> 
> 1. No resources have to be assigned (for vfio-ap, I guess the IDs and
> such are implicit)

That's my understanding as well. The interesting stuff will be
configured on kernel level before the device is even handed to QEMU for
consumption.

(Would be nice to hint at that in the patch description.)

> 2. No notification will happen. How will the guest know that a new AP
> adapter is available?

My understanding is that hotplugging the matrix device will make the
guest go from "no adapters/domains are available" to "some
adapters/domains are available" (and unplug will do the reverse). I.e.,
no hot(un)plugging of individual queues (which would need to be done on
the kernel level, and is tricky IIRC.)

I'm not sure what the architectured options for notifying the guest are
(I dimly recall some kind of "AP configuration has changed event").

IIRC, the Linux guest driver scans for new queues periodically. Does it
even do that if no queues are available to start with?

> 
> > I presume the purpose of the callback is to provide an opportunity
> > to do perform any additional processing that may be required to prepare
> > the device for use. In the case of the vfio-ap device, there is nothing
> > to do once the device is plugged.  
> 
> When removing the device, is it really a forced removal? ("simply rip it
> out without telling the guest")

I hope that severing the connection between QEMU and the host kernel
for AP takes care of cleanup. It's all a bit confusing :(
