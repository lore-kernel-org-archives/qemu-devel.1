Received: from eggs.gnu.org ([2001:4830:134:3::10]:59383)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imbrenda@linux.vnet.ibm.com>) id 1eoXUJ-0002vp-13
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 11:43:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imbrenda@linux.vnet.ibm.com>) id 1eoXUE-0000bB-T1
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 11:43:23 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57936)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imbrenda@linux.vnet.ibm.com>)
	id 1eoXUE-0000aj-Al
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 11:43:18 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w1LGgT08058046
	for <qemu-devel@nongnu.org>; Wed, 21 Feb 2018 11:43:16 -0500
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2g9b1q4v5e-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 21 Feb 2018 11:43:13 -0500
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <imbrenda@linux.vnet.ibm.com>;
	Wed, 21 Feb 2018 16:43:01 -0000
Date: Wed, 21 Feb 2018 17:42:57 +0100
From: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
In-Reply-To: <20180221162005.77390824.cohuck@redhat.com>
References: <1519152302-19079-1-git-send-email-imbrenda@linux.vnet.ibm.com>
	<1519152302-19079-3-git-send-email-imbrenda@linux.vnet.ibm.com>
	<20180221162005.77390824.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20180221174257.1763f43e@p-imbrenda.boeblingen.de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v1 2/3] s390x/sclp: clean up sclp masks
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

On Wed, 21 Feb 2018 16:20:05 +0100
Cornelia Huck <cohuck@redhat.com> wrote:

> On Tue, 20 Feb 2018 19:45:01 +0100
> Claudio Imbrenda <imbrenda@linux.vnet.ibm.com> wrote:
> 
> > Clean up SCLP masks: introduce an sccb_mask_t to be used for SCLP
> > event masks instead of just unsigned int or uint32_t. This will
> > allow later to extend the mask with more ease.  
> 
> Looks mostly sane.
> 
> > 
> > Signed-off-by: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
> > ---
> >  hw/char/sclpconsole-lm.c          |  4 ++--
> >  hw/char/sclpconsole.c             |  4 ++--
> >  hw/s390x/event-facility.c         | 18 +++++++++---------
> >  hw/s390x/sclpcpu.c                |  4 ++--
> >  hw/s390x/sclpquiesce.c            |  4 ++--
> >  include/hw/s390x/event-facility.h | 22 +++++++++++++---------
> >  6 files changed, 30 insertions(+), 26 deletions(-)
> > 
> > diff --git a/hw/char/sclpconsole-lm.c b/hw/char/sclpconsole-lm.c
> > index c500bda..cc4d70a 100644
> > --- a/hw/char/sclpconsole-lm.c
> > +++ b/hw/char/sclpconsole-lm.c  
> 
> > diff --git a/hw/s390x/event-facility.c b/hw/s390x/event-facility.c
> > index 2414614..f6f28fd 100644
> > --- a/hw/s390x/event-facility.c
> > +++ b/hw/s390x/event-facility.c
> > @@ -30,7 +30,7 @@ struct SCLPEventFacility {
> >      SysBusDevice parent_obj;
> >      SCLPEventsBus sbus;
> >      /* guest' receive mask */  
> 
> Let's make this "guest's", as you're touching the line right below.

will do

> > -    unsigned int receive_mask;
> > +    sccb_mask_t receive_mask;
> >      /*
> >       * when false, we keep the same broken, backwards compatible
> > behaviour as
> >       * before; when true, we implement the architecture correctly.
> > Needed for  
> 
> (...)
> 
> > @@ -241,8 +241,8 @@ static void copy_mask(uint8_t *dst, uint8_t
> > *src, uint16_t dst_len, 
> >  static void read_event_data(SCLPEventFacility *ef, SCCB *sccb)
> >  {
> > -    unsigned int sclp_active_selection_mask;
> > -    unsigned int sclp_cp_receive_mask;
> > +    sccb_mask_t sclp_active_selection_mask = 0;  
> 
> Why do you need to initialize this now?

right, copy_mask zeroes the unused space at the end of the destination,
it can be removed

> > +    sccb_mask_t sclp_cp_receive_mask;
> >  
> >      ReadEventData *red = (ReadEventData *) sccb;
> >  
> > @@ -284,7 +284,7 @@ static void write_event_mask(SCLPEventFacility
> > *ef, SCCB *sccb) {
> >      WriteEventMask *we_mask = (WriteEventMask *) sccb;
> >      uint16_t mask_length = be16_to_cpu(we_mask->mask_length);
> > -    uint32_t tmp_mask;
> > +    sccb_mask_t tmp_mask = 0;  
> 
> Same here.

this is different, but it can still be avoided; I'll fix both.

> >  
> >      if (!mask_length || (mask_length > SCLP_EVENT_MASK_LEN_MAX) ||
> >          ((mask_length != 4) && !ef->allow_all_mask_sizes)) {  
> 
> (...)
> 
> > diff --git a/include/hw/s390x/event-facility.h
> > b/include/hw/s390x/event-facility.h index 5119b9b..0a8b47a 100644
> > --- a/include/hw/s390x/event-facility.h
> > +++ b/include/hw/s390x/event-facility.h
> > @@ -28,12 +28,14 @@
> >  #define SCLP_EVENT_SIGNAL_QUIESCE               0x1d
> >  
> >  /* SCLP event masks */
> > -#define SCLP_EVENT_MASK_SIGNAL_QUIESCE          0x00000008
> > -#define SCLP_EVENT_MASK_MSG_ASCII               0x00000040
> > -#define SCLP_EVENT_MASK_CONFIG_MGT_DATA         0x10000000
> > -#define SCLP_EVENT_MASK_OP_CMD                  0x80000000
> > -#define SCLP_EVENT_MASK_MSG                     0x40000000
> > -#define SCLP_EVENT_MASK_PMSGCMD                 0x00800000
> > +#define SCLPEVMSK(T)  (1ULL << (sizeof(sccb_mask_t) * 8 - (T)))  
> 
> SCLP_EVMASK() would be a bit more readable, I think.

I know, but then it looks ugly when trying to fit everything in 80
columns. 

> > +
> > +#define SCLP_EVENT_MASK_OP_CMD
> > SCLPEVMSK(SCLP_EVENT_OPRTNS_COMMAND) +#define
> > SCLP_EVENT_MASK_MSG             SCLPEVMSK(SCLP_EVENT_MESSAGE)
> > +#define SCLP_EVENT_MASK_CONFIG_MGT_DATA
> > SCLPEVMSK(SCLP_EVENT_CONFIG_MGT_DATA) +#define
> > SCLP_EVENT_MASK_PMSGCMD         SCLPEVMSK(SCLP_EVENT_PMSGCMD)
> > +#define SCLP_EVENT_MASK_MSG_ASCII
> > SCLPEVMSK(SCLP_EVENT_ASCII_CONSOLE_DATA) +#define
> > SCLP_EVENT_MASK_SIGNAL_QUIESCE
> > SCLPEVMSK(SCLP_EVENT_SIGNAL_QUIESCE) #define
> > SCLP_UNCONDITIONAL_READ                 0x00 #define
> > SCLP_SELECTIVE_READ                     0x01  
> 
