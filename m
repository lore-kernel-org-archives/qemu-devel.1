Received: from eggs.gnu.org ([2001:4830:134:3::10]:43558)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imbrenda@linux.vnet.ibm.com>) id 1etEBl-0003g3-WD
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 10:07:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imbrenda@linux.vnet.ibm.com>) id 1etEBi-0004jK-Hp
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 10:07:37 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36296
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imbrenda@linux.vnet.ibm.com>)
	id 1etEBi-0004iu-BH
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 10:07:34 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w26F3mKP144275
	for <qemu-devel@nongnu.org>; Tue, 6 Mar 2018 10:07:33 -0500
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2ghudaxrwd-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 06 Mar 2018 10:07:33 -0500
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <imbrenda@linux.vnet.ibm.com>;
	Tue, 6 Mar 2018 15:07:31 -0000
Date: Tue, 6 Mar 2018 16:07:26 +0100
From: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
In-Reply-To: <20180305162710.70f680ff.cohuck@redhat.com>
References: <1519407778-23095-1-git-send-email-imbrenda@linux.vnet.ibm.com>
	<1519407778-23095-4-git-send-email-imbrenda@linux.vnet.ibm.com>
	<90dab7d2-be2a-4ab6-ed08-4ce8cac5664f@de.ibm.com>
	<20180305162710.70f680ff.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20180306160726.756d29c0@p-imbrenda.boeblingen.de.ibm.com>
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
To: Cornelia Huck <cohuck@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org

On Mon, 5 Mar 2018 16:27:10 +0100
Cornelia Huck <cohuck@redhat.com> wrote:

> On Fri, 2 Mar 2018 10:44:46 +0100
> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> 
> > On 02/23/2018 06:42 PM, Claudio Imbrenda wrote:  
> > > Extend the SCLP event masks to 64 bits.
> > > 
> > > Notice that using any of the new bits results in a state that
> > > cannot be migrated to an older version.
> > > 
> > > Signed-off-by: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
> > > ---
> > >  hw/s390x/event-facility.c         | 56
> > > ++++++++++++++++++++++++++++++---------
> > > include/hw/s390x/event-facility.h |  2 +- 2 files changed, 45
> > > insertions(+), 13 deletions(-)
> > > 
> > > diff --git a/hw/s390x/event-facility.c b/hw/s390x/event-facility.c
> > > index e04ed9f..c3e39ee 100644
> > > --- a/hw/s390x/event-facility.c
> > > +++ b/hw/s390x/event-facility.c
> > > @@ -30,7 +30,7 @@ struct SCLPEventFacility {
> > >      SysBusDevice parent_obj;
> > >      SCLPEventsBus sbus;
> > >      /* guest's receive mask */
> > > -    sccb_mask_t receive_mask;
> > > +    uint32_t receive_mask_pieces[2];    
> > 
> > 
> > Before the change, we basically use be32_to_cpu to transfer the
> > byte field into a cpu endianess value. In the end it is actually a
> > bitfield, but for compat we need to keep he reversal. So it will be
> > hard to get this fixed without some kind of ugliness.  
> 
> Could we also use a compat mask callback/handler for older machines
> and switch to 64 bit handlers for the default case? Probably would be
> even more ugly, though.

it would make the code here slightly more straightforward (no pieces, no
accessor functions) at the expense of a lot of ugliness in the VMState
(we'd need all of pre_save, pre_load, post_load).

basically we'd need both the 32-bit and 64-bit internal variables, and
we'd need to keep them in sync when loading/storing the VMState. 

> > 
> > Does it make sense to make the sccb_mask_t a union of an uint64_t
> > and the pieces?
> > 
> > 
> >   
> > >      /*
> > >       * when false, we keep the same broken, backwards compatible
> > > behaviour as
> > >       * before, allowing only masks of size exactly 4; when true,
> > > we implement @@ -42,6 +42,18 @@ struct SCLPEventFacility {
> > >      uint16_t mask_length;
> > >  };
> > > 
> > > +static inline sccb_mask_t make_receive_mask(SCLPEventFacility
> > > *ef) +{
> > > +    return ((sccb_mask_t)ef->receive_mask_pieces[0]) << 32 |
> > > +                         ef->receive_mask_pieces[1];
> > > +}
> > > +
> > > +static inline void store_receive_mask(SCLPEventFacility *ef,
> > > sccb_mask_t val) +{
> > > +    ef->receive_mask_pieces[1] = val;
> > > +    ef->receive_mask_pieces[0] = val >> 32;
> > > +}
> > > +
> > >  /* return true if any child has event pending set */
> > >  static bool event_pending(SCLPEventFacility *ef)
> > >  {
> > > @@ -54,7 +66,7 @@ static bool event_pending(SCLPEventFacility *ef)
> > >          event = DO_UPCAST(SCLPEvent, qdev, qdev);
> > >          event_class = SCLP_EVENT_GET_CLASS(event);
> > >          if (event->event_pending &&
> > > -            event_class->get_send_mask() & ef->receive_mask) {
> > > +            event_class->get_send_mask() &
> > > make_receive_mask(ef)) { return true;
> > >          }
> > >      }
> > > @@ -252,7 +264,7 @@ static void read_event_data(SCLPEventFacility
> > > *ef, SCCB *sccb) goto out;
> > >      }
> > > 
> > > -    sclp_cp_receive_mask = ef->receive_mask;
> > > +    sclp_cp_receive_mask = make_receive_mask(ef);
> > > 
> > >      /* get active selection mask */
> > >      switch (sccb->h.function_code) {
> > > @@ -262,7 +274,7 @@ static void read_event_data(SCLPEventFacility
> > > *ef, SCCB *sccb) case SCLP_SELECTIVE_READ:
> > >          copy_mask((uint8_t *)&sclp_active_selection_mask,
> > > (uint8_t *)&red->mask, sizeof(sclp_active_selection_mask),
> > > ef->mask_length);
> > > -        sclp_active_selection_mask =
> > > be32_to_cpu(sclp_active_selection_mask);
> > > +        sclp_active_selection_mask =
> > > be64_to_cpu(sclp_active_selection_mask); if
> > > (!sclp_cp_receive_mask || (sclp_active_selection_mask &
> > > ~sclp_cp_receive_mask)) { sccb->h.response_code =
> > > @@ -294,21 +306,22 @@ static void
> > > write_event_mask(SCLPEventFacility *ef, SCCB *sccb) }
> > > 
> > >      /*
> > > -     * Note: We currently only support masks up to 4 byte length;
> > > -     *       the remainder is filled up with zeroes. Linux uses
> > > -     *       a 4 byte mask length.
> > > +     * Note: We currently only support masks up to 8 byte length;
> > > +     *       the remainder is filled up with zeroes. Older Linux
> > > +     *       kernels use a 4 byte mask length, newer ones can
> > > use both
> > > +     *       8 or 4 depending on what is available on the host.
> > >       */  
> 
> I.e., handle the 4 or 8 byte values here. But probably would be too
> ugly to live.

I agree, let's avoid

> > > 
> > >      /* keep track of the guest's capability masks */
> > >      copy_mask((uint8_t *)&tmp_mask, WEM_CP_RECEIVE_MASK(we_mask,
> > > mask_length), sizeof(tmp_mask), mask_length);
> > > -    ef->receive_mask = be32_to_cpu(tmp_mask);
> > > +    store_receive_mask(ef, be64_to_cpu(tmp_mask));
> > > 
> > >      /* return the SCLP's capability masks to the guest */
> > > -    tmp_mask = cpu_to_be32(get_host_receive_mask(ef));
> > > +    tmp_mask = cpu_to_be64(get_host_receive_mask(ef));
> > >      copy_mask(WEM_RECEIVE_MASK(we_mask, mask_length), (uint8_t
> > > *)&tmp_mask, mask_length, sizeof(tmp_mask));
> > > -    tmp_mask = cpu_to_be32(get_host_send_mask(ef));
> > > +    tmp_mask = cpu_to_be64(get_host_send_mask(ef));
> > >      copy_mask(WEM_SEND_MASK(we_mask, mask_length), (uint8_t
> > > *)&tmp_mask, mask_length, sizeof(tmp_mask));
> > > 
> > > @@ -369,6 +382,13 @@ static void
> > > command_handler(SCLPEventFacility *ef, SCCB *sccb, uint64_t
> > > code) } }
> > > 
> > > +static bool vmstate_event_facility_mask64_needed(void *opaque)
> > > +{
> > > +    SCLPEventFacility *ef = opaque;
> > > +
> > > +    return ef->receive_mask_pieces[1] != 0;
> > > +}
> > > +
> > >  static bool vmstate_event_facility_mask_length_needed(void
> > > *opaque) {
> > >      SCLPEventFacility *ef = opaque;
> > > @@ -376,6 +396,17 @@ static bool
> > > vmstate_event_facility_mask_length_needed(void *opaque) return
> > > ef->allow_all_mask_sizes; }
> > > 
> > > +static const VMStateDescription vmstate_event_facility_mask64 = {
> > > +    .name = "vmstate-event-facility/mask64",
> > > +    .version_id = 0,
> > > +    .minimum_version_id = 0,
> > > +    .needed = vmstate_event_facility_mask64_needed,
> > > +    .fields = (VMStateField[]) {
> > > +        VMSTATE_UINT32(receive_mask_pieces[1],
> > > SCLPEventFacility),
> > > +        VMSTATE_END_OF_LIST()
> > > +     }
> > > +};
> > > +
> > >  static const VMStateDescription
> > > vmstate_event_facility_mask_length = { .name =
> > > "vmstate-event-facility/mask_length", .version_id = 0,
> > > @@ -392,10 +423,11 @@ static const VMStateDescription
> > > vmstate_event_facility = { .version_id = 0,
> > >      .minimum_version_id = 0,
> > >      .fields = (VMStateField[]) {
> > > -        VMSTATE_UINT32(receive_mask, SCLPEventFacility),
> > > +        VMSTATE_UINT32(receive_mask_pieces[0],
> > > SCLPEventFacility), VMSTATE_END_OF_LIST()
> > >       },
> > >      .subsections = (const VMStateDescription * []) {
> > > +        &vmstate_event_facility_mask64,
> > >          &vmstate_event_facility_mask_length,
> > >          NULL
> > >       }
> > > @@ -447,7 +479,7 @@ static void reset_event_facility(DeviceState
> > > *dev) {
> > >      SCLPEventFacility *sdev = EVENT_FACILITY(dev);
> > > 
> > > -    sdev->receive_mask = 0;
> > > +    store_receive_mask(sdev, 0);
> > >  }
> > > 
> > >  static void init_event_facility_class(ObjectClass *klass, void
> > > *data) diff --git a/include/hw/s390x/event-facility.h
> > > b/include/hw/s390x/event-facility.h index 0e2b761..06ba4ea 100644
> > > --- a/include/hw/s390x/event-facility.h
> > > +++ b/include/hw/s390x/event-facility.h
> > > @@ -73,7 +73,7 @@ typedef struct WriteEventMask {
> > >  #define WEM_RECEIVE_MASK(wem, mask_len) ((wem)->masks + 2 *
> > > (mask_len)) #define WEM_SEND_MASK(wem, mask_len) ((wem)->masks +
> > > 3 * (mask_len))
> > > 
> > > -typedef uint32_t sccb_mask_t;
> > > +typedef uint64_t sccb_mask_t;
> > > 
> > >  typedef struct EventBufferHeader {
> > >      uint16_t length;
> > >     
> >   
> 
