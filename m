Received: from eggs.gnu.org ([2001:4830:134:3::10]:37833)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imbrenda@linux.vnet.ibm.com>) id 1epF2w-000653-F2
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 10:14:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imbrenda@linux.vnet.ibm.com>) id 1epF2r-0002B5-GD
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 10:14:02 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40844
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imbrenda@linux.vnet.ibm.com>)
	id 1epF2r-00029r-9O
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 10:13:57 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w1NF4Bjq060842
	for <qemu-devel@nongnu.org>; Fri, 23 Feb 2018 10:13:56 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2gaka9x23t-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 23 Feb 2018 10:13:56 -0500
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <imbrenda@linux.vnet.ibm.com>;
	Fri, 23 Feb 2018 15:13:54 -0000
Date: Fri, 23 Feb 2018 16:13:51 +0100
From: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
In-Reply-To: <7258ca5e-322b-7ba1-2825-2f742d415d51@de.ibm.com>
References: <1519390265-15576-1-git-send-email-imbrenda@linux.vnet.ibm.com>
	<1519390265-15576-2-git-send-email-imbrenda@linux.vnet.ibm.com>
	<7258ca5e-322b-7ba1-2825-2f742d415d51@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20180223161351.2c91dc16@p-imbrenda.boeblingen.de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v3 1/3] s390x/sclp: proper support of
 larger send and receive masks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: cohuck@redhat.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org

On Fri, 23 Feb 2018 15:27:02 +0100
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

[...]

> > +/* copy up to dst_len bytes and fill the rest of dst with zeroes
> > */  
> 
> you just moved this function but shouldnt it be
> 
> 		src_len bytes and fill will zeroes until dst_len?

true, will fix


[...]

> > @@ -356,6 +369,34 @@ static void command_handler(SCLPEventFacility
> > *ef, SCCB *sccb, uint64_t code) }
> >  }
> > 
> > +static bool vmstate_event_facility_mask_length_needed(void *opaque)
> > +{
> > +    SCLPEventFacility *ef = opaque;
> > +
> > +    return ef->allow_all_mask_sizes;
> > +}
> > +
> > +static int vmstate_event_facility_mask_length_pre_load(void
> > *opaque) +{
> > +    SCLPEventFacility *ef = opaque;
> > +
> > +    ef->allow_all_mask_sizes = false;
> > +    return 0;
> > +}  
> 
> why do we need this? Shouldnt the value be set solely by the machine
> version?

will fix

> > +
> > +static const VMStateDescription vmstate_event_facility_mask_length
> > = {
> > +    .name = "vmstate-event-facility/mask_length",
> > +    .version_id = 0,
> > +    .minimum_version_id = 0,
> > +    .needed = vmstate_event_facility_mask_length_needed,
> > +    .pre_load = vmstate_event_facility_mask_length_pre_load,
> > +    .fields = (VMStateField[]) {
> > +        VMSTATE_BOOL(allow_all_mask_sizes, SCLPEventFacility),  
> 
> same here. Do we really need to migrate "allow_all_mask_sizes" ?
> Shouldnt that only depend on machine <= 2.11?

will fix

> > +        VMSTATE_UINT16(mask_length, SCLPEventFacility),
> > +        VMSTATE_END_OF_LIST()
> > +     }
> > +};
> > +
> >  static const VMStateDescription vmstate_event_facility = {
> >      .name = "vmstate-event-facility",
> >      .version_id = 0,
> > @@ -363,15 +404,39 @@ static const VMStateDescription
> > vmstate_event_facility = { .fields = (VMStateField[]) {
> >          VMSTATE_UINT32(receive_mask, SCLPEventFacility),
> >          VMSTATE_END_OF_LIST()
> > +     },
> > +    .subsections = (const VMStateDescription * []) {
> > +        &vmstate_event_facility_mask_length,
> > +        NULL
> >       }
> >  };
> > 
> > +static void sclp_event_set_allow_all_mask_sizes(Object *obj, bool
> > value,
> > +                                                       Error
> > **errp) +{
> > +    SCLPEventFacility *ef = (SCLPEventFacility *)obj;
> > +
> > +    ef->allow_all_mask_sizes = value;
> > +}
> > +
> > +static bool sclp_event_get_allow_all_mask_sizes(Object *obj, Error
> > **e) +{
> > +    SCLPEventFacility *ef = (SCLPEventFacility *)obj;
> > +
> > +    return ef->allow_all_mask_sizes;
> > +}
> > +
> >  static void init_event_facility(Object *obj)
> >  {
> >      SCLPEventFacility *event_facility = EVENT_FACILITY(obj);
> >      DeviceState *sdev = DEVICE(obj);
> >      Object *new;
> > 
> > +    event_facility->mask_length = 4;
> > +    event_facility->allow_all_mask_sizes = true;
> > +    object_property_add_bool(obj, "allow_all_mask_sizes",
> > +                             sclp_event_get_allow_all_mask_sizes,
> > +                             sclp_event_set_allow_all_mask_sizes,
> > NULL); /* Spawn a new bus for SCLP events */
> >      qbus_create_inplace(&event_facility->sbus,
> > sizeof(event_facility->sbus), TYPE_SCLP_EVENTS_BUS, sdev, NULL);
> > diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> > index 8b3053f..e9309fd 100644
> > --- a/hw/s390x/s390-virtio-ccw.c
> > +++ b/hw/s390x/s390-virtio-ccw.c
> > @@ -29,6 +29,7 @@
> >  #include "s390-pci-bus.h"
> >  #include "hw/s390x/storage-keys.h"
> >  #include "hw/s390x/storage-attributes.h"
> > +#include "hw/s390x/event-facility.h"
> >  #include "hw/compat.h"
> >  #include "ipl.h"
> >  #include "hw/s390x/s390-virtio-ccw.h"
> > @@ -671,7 +672,12 @@ bool css_migration_enabled(void)
> >      type_init(ccw_machine_register_##suffix)
> > 
> >  #define CCW_COMPAT_2_11 \
> > -        HW_COMPAT_2_11
> > +        HW_COMPAT_2_11 \
> > +        {\
> > +            .driver   = TYPE_SCLP_EVENT_FACILITY,\
> > +            .property = "allow_all_mask_sizes",\
> > +            .value    = "off",\
> > +        },
> > 
> >  #define CCW_COMPAT_2_10 \
> >          HW_COMPAT_2_10
> >   
> 
> Otherwise looks good.
