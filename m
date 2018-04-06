Received: from eggs.gnu.org ([2001:4830:134:3::10]:34649)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1f4NlX-000181-Vf
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 05:34:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1f4NlU-00042k-RW
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 05:34:40 -0400
Date: Fri, 6 Apr 2018 11:34:24 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180406113424.05b82448.cohuck@redhat.com>
In-Reply-To: <ad080c45-9bbe-43e3-1482-b291dd249a75@redhat.com>
References: <1522940844-12336-1-git-send-email-mihajlov@linux.vnet.ibm.com>
	<1522940844-12336-2-git-send-email-mihajlov@linux.vnet.ibm.com>
	<ad080c45-9bbe-43e3-1482-b291dd249a75@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/3] s390: Refactor IPL parameter block
 generation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>, borntraeger@de.ibm.com, agraf@suse.de, rth@twiddle.net, david@redhat.com, qemu-devel@nongnu.org, qemu-s390x@nongnu.org

On Fri, 6 Apr 2018 09:52:35 +0200
Thomas Huth <thuth@redhat.com> wrote:

> On 05.04.2018 17:07, Viktor Mihajlovski wrote:
> > Splitting out the the CCW device extraction allows reuse.
> > 
> > Signed-off-by: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
> > ---
> >  hw/s390x/ipl.c | 81 ++++++++++++++++++++++++++++++++++++----------------------
> >  1 file changed, 51 insertions(+), 30 deletions(-)
> > 
> > diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
> > index fdeaec3..58e33c5 100644
> > --- a/hw/s390x/ipl.c
> > +++ b/hw/s390x/ipl.c
> > @@ -279,44 +279,52 @@ static void s390_ipl_set_boot_menu(S390IPLState *ipl)
> >      *timeout = cpu_to_be32(splash_time);
> >  }
> >  
> > +static CcwDevice *s390_get_ccw_device(DeviceState *dev_st)
> > +{
> > +    CcwDevice *ccw_dev = NULL;
> > +
> > +    if (dev_st) {
> > +        VirtioCcwDevice *virtio_ccw_dev = (VirtioCcwDevice *)
> > +            object_dynamic_cast(OBJECT(qdev_get_parent_bus(dev_st)->parent),
> > +                                TYPE_VIRTIO_CCW_DEVICE);
> > +        if (virtio_ccw_dev) {
> > +            ccw_dev = CCW_DEVICE(virtio_ccw_dev);
> > +        } else {
> > +            SCSIDevice *sd = (SCSIDevice *)
> > +                object_dynamic_cast(OBJECT(dev_st),
> > +                                    TYPE_SCSI_DEVICE);
> > +            if (sd) {
> > +                SCSIBus *bus = scsi_bus_from_device(sd);
> > +                VirtIOSCSI *vdev = container_of(bus, VirtIOSCSI, bus);
> > +                VirtIOSCSICcw *scsi_ccw = container_of(vdev, VirtIOSCSICcw,
> > +                                                       vdev);
> > +
> > +                ccw_dev = (CcwDevice *)object_dynamic_cast(OBJECT(scsi_ccw),
> > +                                                           TYPE_CCW_DEVICE);
> > +            }
> > +        }
> > +    }
> > +    return ccw_dev;
> > +}
> > +
> >  static bool s390_gen_initial_iplb(S390IPLState *ipl)
> >  {
> >      DeviceState *dev_st;
> > +    CcwDevice *ccw_dev = NULL;
> >  
> >      dev_st = get_boot_device(0);
> >      if (dev_st) {
> > -        VirtioCcwDevice *virtio_ccw_dev = (VirtioCcwDevice *)
> > -            object_dynamic_cast(OBJECT(qdev_get_parent_bus(dev_st)->parent),
> > -                TYPE_VIRTIO_CCW_DEVICE);
> > +        ccw_dev = s390_get_ccw_device(dev_st);
> > +    }
> > +
> > +    /*
> > +     * Currently allow IPL only from CCW devices.
> > +     */
> > +    if (ccw_dev) {
> >          SCSIDevice *sd = (SCSIDevice *) object_dynamic_cast(OBJECT(dev_st),
> >                                                              TYPE_SCSI_DEVICE);  
> 
> The SCSIDevice dynamic cast now has to be done twice ... but I guess
> that's ok (we're only doing this for the boot device, so it this should
> not be time-critical, right?).

Agreed, that does not matter.

> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>
