Received: from eggs.gnu.org ([2001:4830:134:3::10]:37822)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imbrenda@linux.vnet.ibm.com>) id 1eonC6-0005Ct-Kd
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 04:29:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imbrenda@linux.vnet.ibm.com>) id 1eonC3-0001bk-GE
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 04:29:38 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53718
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imbrenda@linux.vnet.ibm.com>)
	id 1eonC3-0001bP-AT
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 04:29:35 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w1M9OHqY045633
	for <qemu-devel@nongnu.org>; Thu, 22 Feb 2018 04:29:34 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2g9rbfevwq-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 22 Feb 2018 04:29:34 -0500
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <imbrenda@linux.vnet.ibm.com>;
	Thu, 22 Feb 2018 09:29:32 -0000
Date: Thu, 22 Feb 2018 10:29:29 +0100
From: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
In-Reply-To: <20180221183012.1c3a8b27.cohuck@redhat.com>
References: <1519152302-19079-1-git-send-email-imbrenda@linux.vnet.ibm.com>
	<1519152302-19079-3-git-send-email-imbrenda@linux.vnet.ibm.com>
	<20180221162005.77390824.cohuck@redhat.com>
	<20180221174257.1763f43e@p-imbrenda.boeblingen.de.ibm.com>
	<20180221183012.1c3a8b27.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20180222102929.73da3a53@p-imbrenda.boeblingen.de.ibm.com>
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

On Wed, 21 Feb 2018 18:30:12 +0100
Cornelia Huck <cohuck@redhat.com> wrote:

> On Wed, 21 Feb 2018 17:42:57 +0100
> Claudio Imbrenda <imbrenda@linux.vnet.ibm.com> wrote:
> 
> > On Wed, 21 Feb 2018 16:20:05 +0100
> > Cornelia Huck <cohuck@redhat.com> wrote:
> >   
> > > On Tue, 20 Feb 2018 19:45:01 +0100
> > > Claudio Imbrenda <imbrenda@linux.vnet.ibm.com> wrote:  
> 
> > > > diff --git a/include/hw/s390x/event-facility.h
> > > > b/include/hw/s390x/event-facility.h index 5119b9b..0a8b47a
> > > > 100644 --- a/include/hw/s390x/event-facility.h
> > > > +++ b/include/hw/s390x/event-facility.h
> > > > @@ -28,12 +28,14 @@
> > > >  #define SCLP_EVENT_SIGNAL_QUIESCE               0x1d
> > > >  
> > > >  /* SCLP event masks */
> > > > -#define SCLP_EVENT_MASK_SIGNAL_QUIESCE          0x00000008
> > > > -#define SCLP_EVENT_MASK_MSG_ASCII               0x00000040
> > > > -#define SCLP_EVENT_MASK_CONFIG_MGT_DATA         0x10000000
> > > > -#define SCLP_EVENT_MASK_OP_CMD                  0x80000000
> > > > -#define SCLP_EVENT_MASK_MSG                     0x40000000
> > > > -#define SCLP_EVENT_MASK_PMSGCMD                 0x00800000
> > > > +#define SCLPEVMSK(T)  (1ULL << (sizeof(sccb_mask_t) * 8 -
> > > > (T)))      
> > > 
> > > SCLP_EVMASK() would be a bit more readable, I think.    
> > 
> > I know, but then it looks ugly when trying to fit everything in 80
> > columns.   
> 
> I'd rather go slightly over 80 in that case (as long as you don't
> cross 90).

will do

> >   
> > > > +
> > > > +#define SCLP_EVENT_MASK_OP_CMD
> > > > SCLPEVMSK(SCLP_EVENT_OPRTNS_COMMAND) +#define
> > > > SCLP_EVENT_MASK_MSG             SCLPEVMSK(SCLP_EVENT_MESSAGE)
> > > > +#define SCLP_EVENT_MASK_CONFIG_MGT_DATA
> > > > SCLPEVMSK(SCLP_EVENT_CONFIG_MGT_DATA) +#define
> > > > SCLP_EVENT_MASK_PMSGCMD         SCLPEVMSK(SCLP_EVENT_PMSGCMD)
> > > > +#define SCLP_EVENT_MASK_MSG_ASCII
> > > > SCLPEVMSK(SCLP_EVENT_ASCII_CONSOLE_DATA) +#define
> > > > SCLP_EVENT_MASK_SIGNAL_QUIESCE
> > > > SCLPEVMSK(SCLP_EVENT_SIGNAL_QUIESCE) #define
> > > > SCLP_UNCONDITIONAL_READ                 0x00 #define
> > > > SCLP_SELECTIVE_READ                     0x01      
> > >     
> >   
> 
