Received: from eggs.gnu.org ([2001:4830:134:3::10]:52566)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1d3PA7-0007pD-VZ
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 11:47:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1d3PA3-0006Mj-4C
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 11:47:28 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47832)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1d3PA2-0006MF-R3
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 11:47:23 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v3QFiKlH094157
	for <qemu-devel@nongnu.org>; Wed, 26 Apr 2017 11:47:21 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2a2ebyk41d-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 26 Apr 2017 11:47:21 -0400
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Wed, 26 Apr 2017 16:47:18 +0100
Date: Wed, 26 Apr 2017 17:47:05 +0200
From: Cornelia Huck <cornelia.huck@de.ibm.com>
In-Reply-To: <e917804b-95d8-dbba-03f8-4ec31c438705@redhat.com>
References: <20170426144645.12476-1-farman@linux.vnet.ibm.com>
	<20170426144645.12476-5-farman@linux.vnet.ibm.com>
	<e917804b-95d8-dbba-03f8-4ec31c438705@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20170426174705.79e1ce24.cornelia.huck@de.ibm.com>
Subject: Re: [Qemu-devel] [RFC PATCH v1 4/5] pc-bios/s390-ccw: Break up
 virtio-scsi read into multiples
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Eric Farman <farman@linux.vnet.ibm.com>, qemu-devel@nongnu.org, "Michael
	S . Tsirkin" <mst@redhat.com>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>

On Wed, 26 Apr 2017 10:17:36 -0500
Eric Blake <eblake@redhat.com> wrote:

> On 04/26/2017 09:46 AM, Eric Farman wrote:
> > A virtio-scsi request that goes through the host sd driver and
> > exceeds the maximum transfer size is automatically broken up
> > for us. But the equivalent request going to the sg driver
> > presumes that any length requirements have already been honored.
> > Let's use the max_sectors field from the device and break up
> > all virtio-scsi requests (both sd and sg) to avoid problem from
> > the host drivers.
> > 
> > Signed-off-by: Eric Farman <farman@linux.vnet.ibm.com>
> > ---
> >  pc-bios/s390-ccw/s390-ccw.h    |  4 ++++
> >  pc-bios/s390-ccw/virtio-scsi.c | 19 ++++++++++++++-----
> >  2 files changed, 18 insertions(+), 5 deletions(-)
> > 
> > diff --git a/pc-bios/s390-ccw/s390-ccw.h b/pc-bios/s390-ccw/s390-ccw.h
> > index ded67bc..e1f3751 100644
> > --- a/pc-bios/s390-ccw/s390-ccw.h
> > +++ b/pc-bios/s390-ccw/s390-ccw.h
> > @@ -42,6 +42,10 @@ typedef unsigned long long __u64;
> >  #ifndef NULL
> >  #define NULL    0
> >  #endif
> > +#ifndef MIN
> > +#define MIN(a, b) (((a) < (b)) ? (a) : (b));
> > +#endif
> 
> osdep.h defines MIN() for ALL files, so this hunk is spurious.
> 

This is a separate binary, which does not include the normal qemu
headers, though.
