Received: from eggs.gnu.org ([2001:4830:134:3::10]:54382)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imbrenda@linux.vnet.ibm.com>) id 1etsNr-0005sN-Rv
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 05:02:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imbrenda@linux.vnet.ibm.com>) id 1etsNm-0006tc-6U
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 05:02:47 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55164
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imbrenda@linux.vnet.ibm.com>)
	id 1etsNm-0006tW-0T
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 05:02:42 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w28A1CWv073593
	for <qemu-devel@nongnu.org>; Thu, 8 Mar 2018 05:02:41 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2gk2p5s0g9-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 08 Mar 2018 05:02:40 -0500
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <imbrenda@linux.vnet.ibm.com>;
	Thu, 8 Mar 2018 10:02:39 -0000
Date: Thu, 8 Mar 2018 11:02:34 +0100
From: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
In-Reply-To: <5fc4c07c-0f64-06b2-9310-8f6c09147c06@de.ibm.com>
References: <1520435434-24471-1-git-send-email-imbrenda@linux.vnet.ibm.com>
	<5fc4c07c-0f64-06b2-9310-8f6c09147c06@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20180308110234.5522ec43@p-imbrenda.boeblingen.de.ibm.com>
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
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: cohuck@redhat.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org

On Thu, 8 Mar 2018 08:41:47 +0100
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> On 03/07/2018 04:10 PM, Claudio Imbrenda wrote:
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
> > 
> > diff --git a/hw/s390x/event-facility.c b/hw/s390x/event-facility.c
> > index e04ed9f..c166e0a 100644
> > --- a/hw/s390x/event-facility.c
> > +++ b/hw/s390x/event-facility.c
> > @@ -30,7 +30,10 @@ struct SCLPEventFacility {
> >      SysBusDevice parent_obj;
> >      SCLPEventsBus sbus;
> >      /* guest's receive mask */
> > -    sccb_mask_t receive_mask;
> > +    union {
> > +        uint32_t receive_mask_pieces[2];
> > +        sccb_mask_t receive_mask;
> > +    };  
> 
> Would it work to make sccb_mask_t a union instead?

yes, but then a lot of other code should be changed: we use sccb_mask_t
as scalar everywhere.

also, we only need the pieces when migrating the state, never during
normal operation
