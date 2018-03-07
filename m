Received: from eggs.gnu.org ([2001:4830:134:3::10]:51708)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imbrenda@linux.vnet.ibm.com>) id 1etcMh-0001Bn-PR
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 11:56:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imbrenda@linux.vnet.ibm.com>) id 1etcMd-0002OD-Sy
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 11:56:31 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52062
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imbrenda@linux.vnet.ibm.com>)
	id 1etcMd-0002Nm-NL
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 11:56:27 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w27Gu9Ti113392
	for <qemu-devel@nongnu.org>; Wed, 7 Mar 2018 11:56:26 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2gjhff7pg2-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 07 Mar 2018 11:56:24 -0500
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <imbrenda@linux.vnet.ibm.com>;
	Wed, 7 Mar 2018 16:54:38 -0000
Date: Wed, 7 Mar 2018 17:54:35 +0100
From: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
In-Reply-To: <20180307165548.29f7ec07.cohuck@redhat.com>
References: <1520435434-24471-1-git-send-email-imbrenda@linux.vnet.ibm.com>
	<20180307165548.29f7ec07.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20180307175435.6ed74568@p-imbrenda.boeblingen.de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v5 1/1] s390x/sclp: extend SCLP event masks
 to 64 bits
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, borntraeger@de.ibm.com

On Wed, 7 Mar 2018 16:55:48 +0100
Cornelia Huck <cohuck@redhat.com> wrote:

> On Wed,  7 Mar 2018 16:10:34 +0100
> Claudio Imbrenda <imbrenda@linux.vnet.ibm.com> wrote:
> 
> > Extend the SCLP event masks to 64 bits.
> > 
> > Notice that using any of the new bits results in a state that
> > cannot be migrated to an older version.
> > 
> > Signed-off-by: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
> > ---
> >  hw/s390x/event-facility.c         | 49
> > ++++++++++++++++++++++++++++++++-------
> > include/hw/s390x/event-facility.h |  2 +- 2 files changed, 41
> > insertions(+), 10 deletions(-) 
> 
> > @@ -376,6 +387,21 @@ static bool
> > vmstate_event_facility_mask_length_needed(void *opaque) return
> > ef->allow_all_mask_sizes; }
> >  
> > +static const VMStateDescription vmstate_event_facility_mask64 = {
> > +    .name = "vmstate-event-facility/mask64",  
> 
> Should that really be called 'mask64' - you're just transferring the
> missing part of the mask here, aren't you?
> 
> > +    .version_id = 0,
> > +    .minimum_version_id = 0,
> > +    .needed = vmstate_event_facility_mask64_needed,
> > +    .fields = (VMStateField[]) {
> > +#ifdef HOST_WORDS_BIGENDIAN
> > +        VMSTATE_UINT32(receive_mask_pieces[1], SCLPEventFacility),
> > +#else
> > +        VMSTATE_UINT32(receive_mask_pieces[0], SCLPEventFacility),
> > +#endif  
> 
> That #ifdef is kind of ugly, and a bit confusing, I think.
> 
> What about doing something like
> 
> /* we need to save 32 bit chunks for compatibility */
> #ifdef HOST_WORDS_BIGENDIAN
> #define RECV_MASK_LOWER 0
> #define RECV_MASK_UPPER 1
> #else /* little endian host */
> #define RECV_MASK_LOWER 1
> #define RECV_MASK_UPPER 0
> #endif
> 
> and transfer receive_mask_pieces[RECV_MASK_UPPER] here...

yes, this is better, I'll respin

> > +        VMSTATE_END_OF_LIST()
> > +     }
> > +};
> > +
> >  static const VMStateDescription vmstate_event_facility_mask_length
> > = { .name = "vmstate-event-facility/mask_length",
> >      .version_id = 0,
> > @@ -392,10 +418,15 @@ static const VMStateDescription
> > vmstate_event_facility = { .version_id = 0,
> >      .minimum_version_id = 0,
> >      .fields = (VMStateField[]) {
> > -        VMSTATE_UINT32(receive_mask, SCLPEventFacility),
> > +#ifdef HOST_WORDS_BIGENDIAN
> > +        VMSTATE_UINT32(receive_mask_pieces[0], SCLPEventFacility),
> > +#else
> > +        VMSTATE_UINT32(receive_mask_pieces[1], SCLPEventFacility),
> > +#endif  
> 
> ...and receive_mask_pieces[REV_MASK_LOWER] here?
> 
> (And I guess 64bit receive masks should be enough for everybody? IOW,
> we don't expect a similar dance in the near future?)

well, by then we'll need proper bitfields, so everything will need to
be rewritten anyway :)

> >          VMSTATE_END_OF_LIST()
> >       },
> >      .subsections = (const VMStateDescription * []) {
> > +        &vmstate_event_facility_mask64,
> >          &vmstate_event_facility_mask_length,
> >          NULL
> >       }  
> 
