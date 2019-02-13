Received: from eggs.gnu.org ([209.51.188.92]:44387)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gtvtX-0003sW-Cl
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 09:52:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gtvtT-0008NC-0d
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 09:52:13 -0500
Date: Wed, 13 Feb 2019 15:52:04 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190213155204.7bd5fa23.cohuck@redhat.com>
In-Reply-To: <97cdb9a7-bd44-153d-72a3-30cf01a67d13@linux.ibm.com>
References: <1548768562-20007-1-git-send-email-jjherne@linux.ibm.com>
	<1548768562-20007-2-git-send-email-jjherne@linux.ibm.com>
	<20190204112630.75eac242.cohuck@redhat.com>
	<97cdb9a7-bd44-153d-72a3-30cf01a67d13@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 01/15] s390 vfio-ccw: Add bootindex
 property and IPLB data
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Jason J. Herne" <jjherne@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, pasic@linux.ibm.com, alifm@linux.ibm.com, borntraeger@de.ibm.com, Thomas Huth <thuth@redhat.com>

On Wed, 13 Feb 2019 08:41:43 -0500
"Jason J. Herne" <jjherne@linux.ibm.com> wrote:

> On 2/4/19 5:26 AM, Cornelia Huck wrote:
> > On Tue, 29 Jan 2019 08:29:08 -0500
> > "Jason J. Herne" <jjherne@linux.ibm.com> wrote:

> >> @@ -311,8 +312,12 @@ static CcwDevice *s390_get_ccw_device(DeviceState *dev_st)
> >>           VirtioCcwDevice *virtio_ccw_dev = (VirtioCcwDevice *)
> >>               object_dynamic_cast(OBJECT(qdev_get_parent_bus(dev_st)->parent),
> >>                                   TYPE_VIRTIO_CCW_DEVICE);
> >> +        VFIOCCWDevice *vfio_ccw_dev = (VFIOCCWDevice *)
> >> +            object_dynamic_cast(OBJECT(dev_st), TYPE_VFIO_CCW);
> >>           if (virtio_ccw_dev) {
> >>               ccw_dev = CCW_DEVICE(virtio_ccw_dev);
> >> +        } else if (vfio_ccw_dev) {
> >> +            ccw_dev = CCW_DEVICE(vfio_ccw_dev);
> >>           } else {
> >>               SCSIDevice *sd = (SCSIDevice *)
> >>                   object_dynamic_cast(OBJECT(dev_st),
> >> @@ -347,6 +352,8 @@ static bool s390_gen_initial_iplb(S390IPLState *ipl)
> >>       if (ccw_dev) {
> >>           SCSIDevice *sd = (SCSIDevice *) object_dynamic_cast(OBJECT(dev_st),
> >>                                                               TYPE_SCSI_DEVICE);
> >> +        VFIOCCWDevice *vc = (VFIOCCWDevice *)
> >> +            object_dynamic_cast(OBJECT(dev_st), TYPE_VFIO_CCW);
> >>   
> >>           if (sd) {
> >>               ipl->iplb.len = cpu_to_be32(S390_IPLB_MIN_QEMU_SCSI_LEN);
> >> @@ -358,6 +365,13 @@ static bool s390_gen_initial_iplb(S390IPLState *ipl)
> >>               ipl->iplb.scsi.channel = cpu_to_be16(sd->channel);
> >>               ipl->iplb.scsi.devno = cpu_to_be16(ccw_dev->sch->devno);
> >>               ipl->iplb.scsi.ssid = ccw_dev->sch->ssid & 3;
> >> +        } else if (vc) {
> >> +            CcwDevice *ccw_dev = CCW_DEVICE(vc);
> >> +
> >> +            ipl->iplb.len = cpu_to_be32(S390_IPLB_MIN_CCW_LEN);
> >> +            ipl->iplb.pbt = S390_IPL_TYPE_CCW;
> >> +            ipl->iplb.ccw.devno = cpu_to_be16(ccw_dev->sch->devno);
> >> +            ipl->iplb.ccw.ssid = ccw_dev->sch->ssid & 3;
> >>           } else {
> >>               VirtIONet *vn = (VirtIONet *) object_dynamic_cast(OBJECT(dev_st),
> >>                                                                 TYPE_VIRTIO_NET);  
> > 
> > Hm, I think that this find-out-the-boot-type-and-set-up-the-right-thing
> > mechanism is getting a bit unwieldy. Basically, we
> > 
> > - call s390_get_ccw_device() to find out the device type via a bunch of
> >    casts and return a pointer to a CcwDevice if it's a supported type
> > - do a bunch of casts here *again* to find out what we have and fill
> >    out the iplb, while we really only need to do grab a non-CcwDevice
> >    for the scsi case
> > 
> > Should maybe s390_get_ccw_device() give us an ipl type in addition to
> > the pointer to the CcwDevice, so we can use a switch/case statement to
> > fill out the iplb here?  
> 
> I think this idea makes sense. s390_ipl_reset_request also calls s390_get_ccw_device but 
> does not care bout the device type, so how about a separate function instead of 
> integrating it with s390_get_ccw_device? Maybe s390_get_ccw_device_type?

If I understand it correctly, we always want to be able to grab a
CcwDevice if supported and for generating the iplb, we also need to
know the actual type of the device. We basically need to follow the
same procedure for both; so it probably makes most sense to have one
function that provides both (the reset code can simply disregard the
type).

> Is there any easy way to grab the type or are we just hiding the ugly casting inside our 
> helper function?

I'm not aware of an alternative to the casting, so the helper function
would just hide the ugliness, I guess...
