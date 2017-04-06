Received: from eggs.gnu.org ([2001:4830:134:3::10]:49491)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cw78I-0004Zn-JU
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 09:07:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cw78D-00073U-Kz
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 09:07:26 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36745
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1cw78D-00072r-F8
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 09:07:21 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v36CwYFq050510
	for <qemu-devel@nongnu.org>; Thu, 6 Apr 2017 09:07:20 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0b-001b2d01.pphosted.com with ESMTP id 29ndvrjcvq-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 06 Apr 2017 09:07:20 -0400
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Thu, 6 Apr 2017 14:07:13 +0100
Date: Thu, 6 Apr 2017 15:07:08 +0200
From: Cornelia Huck <cornelia.huck@de.ibm.com>
In-Reply-To: <865405dc-f785-c458-3de7-dfc49dfca15f@redhat.com>
References: <20170406111646.12624-1-cornelia.huck@de.ibm.com>
	<20170406111646.12624-4-cornelia.huck@de.ibm.com>
	<865405dc-f785-c458-3de7-dfc49dfca15f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20170406150708.7c49380d.cornelia.huck@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10 03/10] s390x/pci: make printf
 always compile in debug output
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, borntraeger@de.ibm.com, Danil Antonov <g.danil.anto@gmail.com>, agraf@suse.de

On Thu, 6 Apr 2017 14:15:45 +0200
Thomas Huth <thuth@redhat.com> wrote:

> On 06.04.2017 13:16, Cornelia Huck wrote:
> > From: Danil Antonov <g.danil.anto@gmail.com>
> > 
> > Wrapped printf calls inside debug macros (DPRINTF) in `if` statement.
> > This will ensure that printf function will always compile even if debug
> > output is turned off and, in turn, will prevent bitrot of the format
> > strings.
> > 
> > Signed-off-by: Danil Antonov <g.danil.anto@gmail.com>
> > Message-Id: <CA+KKJYBi31Bs7DtVdzZdwG2t+u5+FGiAhQpd3pqJzUX1O8Cprg@mail.gmail.com>
> > Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> > ---
> >  hw/s390x/s390-pci-bus.c  | 16 ++++++++++------
> >  hw/s390x/s390-pci-inst.c | 16 ++++++++++------
> >  2 files changed, 20 insertions(+), 12 deletions(-)
> > 
> > diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
> > index 69b0291e8a..0f62363434 100644
> > --- a/hw/s390x/s390-pci-bus.c
> > +++ b/hw/s390x/s390-pci-bus.c
> > @@ -24,14 +24,18 @@
> >  #include "qemu/error-report.h"
> >  
> >  /* #define DEBUG_S390PCI_BUS */
> 
> This comment is now somewhat misleading. If you uncomment this "#define
> DEBUG_S390PCI_BUS" (without adding a "1" at the end), you end up with
> some empty "if ()" statements now, i.e. compilation failures. So I'd
> like to suggest to simply remove the above line.

Yeah, makes sense, and also matches what is done in the s390x/kvm patch.
I'll merge that in.

> 
> > -#ifdef DEBUG_S390PCI_BUS
> > -#define DPRINTF(fmt, ...) \
> > -    do { fprintf(stderr, "S390pci-bus: " fmt, ## __VA_ARGS__); } while (0)
> > -#else
> > -#define DPRINTF(fmt, ...) \
> > -    do { } while (0)
> > +
> > +#ifndef DEBUG_S390PCI_BUS
> > +#define DEBUG_S390PCI_BUS  0
> >  #endif
> >  
> > +#define DPRINTF(fmt, ...)                                         \
> > +    do {                                                          \
> > +        if (DEBUG_S390PCI_BUS) {                                  \
> > +            fprintf(stderr, "S390pci-bus: " fmt, ## __VA_ARGS__); \
> > +        }                                                         \
> > +    } while (0)
> > +
