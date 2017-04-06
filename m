Received: from eggs.gnu.org ([2001:4830:134:3::10]:40019)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1cvw1l-0000iU-7A
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 21:15:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1cvw1g-000408-6a
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 21:15:57 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57263)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bjsdjshi@linux.vnet.ibm.com>)
	id 1cvw1f-0003zx-SI
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 21:15:52 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v3619EZ2093261
	for <qemu-devel@nongnu.org>; Wed, 5 Apr 2017 21:15:50 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
	by mx0a-001b2d01.pphosted.com with ESMTP id 29n9g74rq5-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 05 Apr 2017 21:15:50 -0400
Received: from localhost
	by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bjsdjshi@linux.vnet.ibm.com>;
	Wed, 5 Apr 2017 21:15:48 -0400
Date: Thu, 6 Apr 2017 09:15:42 +0800
From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
References: <20170405091909.36357-1-bjsdjshi@linux.vnet.ibm.com>
	<20170405091909.36357-2-bjsdjshi@linux.vnet.ibm.com>
	<0910cdba-6e7b-169f-784a-a0e064f2c71d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0910cdba-6e7b-169f-784a-a0e064f2c71d@redhat.com>
Message-Id: <20170406011542.GI22108@bjsdjshi@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v4 1/1] block: pass the right options for
 BlockDriver.bdrv_open()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, qemu-block@nongnu.org, kwolf@redhat.com, qemu-devel@nongnu.org, cornelia.huck@de.ibm.com, borntraeger@de.ibm.com

* Max Reitz <mreitz@redhat.com> [2017-04-05 15:54:14 +0200]:

> On 05.04.2017 11:19, Dong Jia Shi wrote:
> > raw_open() expects the caller always passing in the right actual
> > @options parameter. But when trying to applying snapshot on a RBD
> > image, bdrv_snapshot_goto() calls raw_open() (by calling the
> > bdrv_open callback on the BlockDriver) with a NULL @options, and
> > that will result in a Segmentation fault.
> > 
> > For the other non-raw format drivers, it also makes sense to passing
> > in the actual options, althought they don't trigger the problem so
> > far.
> > 
> > Let's prepare a @options by adding the "file" key-value pair to a
> > copy of the actual options that were given for the node (i.e.
> > bs->options), and pass it to the callback.
> > 
> > BlockDriver.bdrv_open() expects bs->file to be NULL and just
> > overwrites it with the result from bdrv_open_child(). That means we
> > should actually make sure it's NULL because otherwise the child BDS
> > will have a reference count that is 1 too high. So we unconditionally
> > invoke bdrv_unref_child() before calling BlockDriver.bdrv_open(), and
> > we wrap everything in bdrv_ref()/bdrv_unref() so the BDS isn't
> > deleted in the meantime.
> > 
> > Suggested-by: Max Reitz <mreitz@redhat.com>
> > Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
> > ---
> >  block/snapshot.c | 26 +++++++++++++++++++++++---
> >  1 file changed, 23 insertions(+), 3 deletions(-)
> 
> Thank you, I've applied the patch to my block branch (for inclusion in 2.9):
> 
> https://github.com/XanClic/qemu/commits/block
Thank you!

> 
> Max
> 




-- 
Dong Jia Shi
