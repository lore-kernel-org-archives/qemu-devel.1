Received: from eggs.gnu.org ([2001:4830:134:3::10]:40640)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ess1O-0001S6-L3
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 10:27:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ess1L-0006yM-5k
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 10:27:26 -0500
Date: Mon, 5 Mar 2018 16:27:10 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180305162710.70f680ff.cohuck@redhat.com>
In-Reply-To: <90dab7d2-be2a-4ab6-ed08-4ce8cac5664f@de.ibm.com>
References: <1519407778-23095-1-git-send-email-imbrenda@linux.vnet.ibm.com>
	<1519407778-23095-4-git-send-email-imbrenda@linux.vnet.ibm.com>
	<90dab7d2-be2a-4ab6-ed08-4ce8cac5664f@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v4 3/3] s390x/sclp: extend
 SCLP event masks to 64 bits
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org

On Fri, 2 Mar 2018 10:44:46 +0100
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> On 02/23/2018 06:42 PM, Claudio Imbrenda wrote:
> > Extend the SCLP event masks to 64 bits.
> > 
> > Notice that using any of the new bits results in a state that cannot be
> > migrated to an older version.
> > 
> > Signed-off-by: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
> > ---
> >  hw/s390x/event-facility.c         | 56 ++++++++++++++++++++++++++++++---------
> >  include/hw/s390x/event-facility.h |  2 +-
> >  2 files changed, 45 insertions(+), 13 deletions(-)
> > 
> > diff --git a/hw/s390x/event-facility.c b/hw/s390x/event-facility.c
> > index e04ed9f..c3e39ee 100644
> > --- a/hw/s390x/event-facility.c
> > +++ b/hw/s390x/event-facility.c
> > @@ -30,7 +30,7 @@ struct SCLPEventFacility {
> >      SysBusDevice parent_obj;
> >      SCLPEventsBus sbus;
> >      /* guest's receive mask */
> > -    sccb_mask_t receive_mask;
> > +    uint32_t receive_mask_pieces[2];  
> 
> 
> Before the change, we basically use be32_to_cpu to transfer the byte field into a cpu
> endianess value. In the end it is actually a bitfield, but for compat we need to keep
> he reversal. So it will be hard to get this fixed without some kind of ugliness.

Could we also use a compat mask callback/handler for older machines and
switch to 64 bit handlers for the default case? Probably would be even
more ugly, though.

> 
> Does it make sense to make the sccb_mask_t a union of an uint64_t and the pieces?
> 
> 
> 
> >      /*
> >       * when false, we keep the same broken, backwards compatible behaviour as
> >       * before, allowing only masks of size exactly 4; when true, we implement
> > @@ -42,6 +42,18 @@ struct SCLPEventFacility {
> >      uint16_t mask_length;
> >  };
> > 
> > +static inline sccb_mask_t make_receive_mask(SCLPEventFacility *ef)
> > +{
> > +    return ((sccb_mask_t)ef->receive_mask_pieces[0]) << 32 |
> > +                         ef->receive_mask_pieces[1];
> > +}
> > +
> > +static inline void store_receive_mask(SCLPEventFacility *ef, sccb_mask_t val)
> > +{
> > +    ef->receive_mask_pieces[1] = val;
> > +    ef->receive_mask_pieces[0] = val >> 32;
> > +}
> > +
> >  /* return true if any child has event pending set */
> >  static bool event_pending(SCLPEventFacility *ef)
> >  {
> > @@ -54,7 +66,7 @@ static bool event_pending(SCLPEventFacility *ef)
> >          event = DO_UPCAST(SCLPEvent, qdev, qdev);
> >          event_class = SCLP_EVENT_GET_CLASS(event);
> >          if (event->event_pending &&
> > -            event_class->get_send_mask() & ef->receive_mask) {
> > +            event_class->get_send_mask() & make_receive_mask(ef)) {
> >              return true;
> >          }
> >      }
> > @@ -252,7 +264,7 @@ static void read_event_data(SCLPEventFacility *ef, SCCB *sccb)
> >          goto out;
> >      }
> > 
> > -    sclp_cp_receive_mask = ef->receive_mask;
> > +    sclp_cp_receive_mask = make_receive_mask(ef);
> > 
> >      /* get active selection mask */
> >      switch (sccb->h.function_code) {
> > @@ -262,7 +274,7 @@ static void read_event_data(SCLPEventFacility *ef, SCCB *sccb)
> >      case SCLP_SELECTIVE_READ:
> >          copy_mask((uint8_t *)&sclp_active_selection_mask, (uint8_t *)&red->mask,
> >                    sizeof(sclp_active_selection_mask), ef->mask_length);
> > -        sclp_active_selection_mask = be32_to_cpu(sclp_active_selection_mask);
> > +        sclp_active_selection_mask = be64_to_cpu(sclp_active_selection_mask);
> >          if (!sclp_cp_receive_mask ||
> >              (sclp_active_selection_mask & ~sclp_cp_receive_mask)) {
> >              sccb->h.response_code =
> > @@ -294,21 +306,22 @@ static void write_event_mask(SCLPEventFacility *ef, SCCB *sccb)
> >      }
> > 
> >      /*
> > -     * Note: We currently only support masks up to 4 byte length;
> > -     *       the remainder is filled up with zeroes. Linux uses
> > -     *       a 4 byte mask length.
> > +     * Note: We currently only support masks up to 8 byte length;
> > +     *       the remainder is filled up with zeroes. Older Linux
> > +     *       kernels use a 4 byte mask length, newer ones can use both
> > +     *       8 or 4 depending on what is available on the host.
> >       */

I.e., handle the 4 or 8 byte values here. But probably would be too
ugly to live.

> > 
> >      /* keep track of the guest's capability masks */
> >      copy_mask((uint8_t *)&tmp_mask, WEM_CP_RECEIVE_MASK(we_mask, mask_length),
> >                sizeof(tmp_mask), mask_length);
> > -    ef->receive_mask = be32_to_cpu(tmp_mask);
> > +    store_receive_mask(ef, be64_to_cpu(tmp_mask));
> > 
> >      /* return the SCLP's capability masks to the guest */
> > -    tmp_mask = cpu_to_be32(get_host_receive_mask(ef));
> > +    tmp_mask = cpu_to_be64(get_host_receive_mask(ef));
> >      copy_mask(WEM_RECEIVE_MASK(we_mask, mask_length), (uint8_t *)&tmp_mask,
> >                mask_length, sizeof(tmp_mask));
> > -    tmp_mask = cpu_to_be32(get_host_send_mask(ef));
> > +    tmp_mask = cpu_to_be64(get_host_send_mask(ef));
> >      copy_mask(WEM_SEND_MASK(we_mask, mask_length), (uint8_t *)&tmp_mask,
> >                mask_length, sizeof(tmp_mask));
> > 
> > @@ -369,6 +382,13 @@ static void command_handler(SCLPEventFacility *ef, SCCB *sccb, uint64_t code)
> >      }
> >  }
> > 
> > +static bool vmstate_event_facility_mask64_needed(void *opaque)
> > +{
> > +    SCLPEventFacility *ef = opaque;
> > +
> > +    return ef->receive_mask_pieces[1] != 0;
> > +}
> > +
> >  static bool vmstate_event_facility_mask_length_needed(void *opaque)
> >  {
> >      SCLPEventFacility *ef = opaque;
> > @@ -376,6 +396,17 @@ static bool vmstate_event_facility_mask_length_needed(void *opaque)
> >      return ef->allow_all_mask_sizes;
> >  }
> > 
> > +static const VMStateDescription vmstate_event_facility_mask64 = {
> > +    .name = "vmstate-event-facility/mask64",
> > +    .version_id = 0,
> > +    .minimum_version_id = 0,
> > +    .needed = vmstate_event_facility_mask64_needed,
> > +    .fields = (VMStateField[]) {
> > +        VMSTATE_UINT32(receive_mask_pieces[1], SCLPEventFacility),
> > +        VMSTATE_END_OF_LIST()
> > +     }
> > +};
> > +
> >  static const VMStateDescription vmstate_event_facility_mask_length = {
> >      .name = "vmstate-event-facility/mask_length",
> >      .version_id = 0,
> > @@ -392,10 +423,11 @@ static const VMStateDescription vmstate_event_facility = {
> >      .version_id = 0,
> >      .minimum_version_id = 0,
> >      .fields = (VMStateField[]) {
> > -        VMSTATE_UINT32(receive_mask, SCLPEventFacility),
> > +        VMSTATE_UINT32(receive_mask_pieces[0], SCLPEventFacility),
> >          VMSTATE_END_OF_LIST()
> >       },
> >      .subsections = (const VMStateDescription * []) {
> > +        &vmstate_event_facility_mask64,
> >          &vmstate_event_facility_mask_length,
> >          NULL
> >       }
> > @@ -447,7 +479,7 @@ static void reset_event_facility(DeviceState *dev)
> >  {
> >      SCLPEventFacility *sdev = EVENT_FACILITY(dev);
> > 
> > -    sdev->receive_mask = 0;
> > +    store_receive_mask(sdev, 0);
> >  }
> > 
> >  static void init_event_facility_class(ObjectClass *klass, void *data)
> > diff --git a/include/hw/s390x/event-facility.h b/include/hw/s390x/event-facility.h
> > index 0e2b761..06ba4ea 100644
> > --- a/include/hw/s390x/event-facility.h
> > +++ b/include/hw/s390x/event-facility.h
> > @@ -73,7 +73,7 @@ typedef struct WriteEventMask {
> >  #define WEM_RECEIVE_MASK(wem, mask_len) ((wem)->masks + 2 * (mask_len))
> >  #define WEM_SEND_MASK(wem, mask_len) ((wem)->masks + 3 * (mask_len))
> > 
> > -typedef uint32_t sccb_mask_t;
> > +typedef uint64_t sccb_mask_t;
> > 
> >  typedef struct EventBufferHeader {
> >      uint16_t length;
> >   
> 
