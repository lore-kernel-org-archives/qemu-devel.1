Received: from eggs.gnu.org ([2001:4830:134:3::10]:56812)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cgCfR-00042r-9J
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 10:47:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cgCfH-0006JT-RQ
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 10:47:48 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39873)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1cgCfH-0006J5-HA
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 10:47:43 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1LFcYUc051929
	for <qemu-devel@nongnu.org>; Tue, 21 Feb 2017 10:47:42 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28rpx1w7e4-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 21 Feb 2017 10:47:41 -0500
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Tue, 21 Feb 2017 15:47:38 -0000
Date: Tue, 21 Feb 2017 16:47:33 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
In-Reply-To: <20170221085824.GN562@bjsdjshi@linux.vnet.ibm.com>
References: <20170217082939.33208-1-bjsdjshi@linux.vnet.ibm.com>
	<20170217082939.33208-16-bjsdjshi@linux.vnet.ibm.com>
	<20170220195901.252083fe.cornelia.huck@de.ibm.com>
	<20170221085824.GN562@bjsdjshi@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20170221164733.105ed0f7.cornelia.huck@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH RFC v3 15/15] vfio: ccw: introduce support
 for ccw0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, qemu-devel@nongnu.org, renxiaof@linux.vnet.ibm.com, borntraeger@de.ibm.com, agraf@suse.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, wkywang@linux.vnet.ibm.com

On Tue, 21 Feb 2017 16:58:24 +0800
Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> wrote:

> * Cornelia Huck <cornelia.huck@de.ibm.com> [2017-02-20 19:59:01 +0100]:
> 
> > On Fri, 17 Feb 2017 09:29:39 +0100
> > Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> wrote:
> > 
> > > Although Linux does not use format-0 channel command words (CCW0)
> > > these are a non-optional part of the platform spec, and for the sake
> > > of platform compliance, and possibly some non-Linux guests, we have
> > > to support CCW0.
> > > 
> > > Making the kernel execute a format 0 channel program is too much hassle
> > > because we would need to allocate and use memory which can be addressed
> > > by 24 bit physical addresses (because of CCW0.cda). So we implement CCW0
> > > support by translating the channel program into an equivalent CCW1
> > > program instead.
> > > 
> > > Signed-off-by: Kai Yue Wang <wkywang@linux.vnet.ibm.com>
> > > Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
> > > ---
> > >  arch/s390/Kconfig              |  7 +++++
> > >  drivers/s390/cio/vfio_ccw_cp.c | 58 ++++++++++++++++++++++++++++++++++++++++--
> > >  2 files changed, 63 insertions(+), 2 deletions(-)

> > > +#ifdef CONFIG_VFIO_CCW_CCW0
> > > +static long copy_ccw_from_iova(struct channel_program *cp,
> > > +			       struct ccw1 *to, u64 iova,
> > > +			       unsigned long len)
> > > +{
> > > +	struct ccw0 ccw0;
> > > +	struct ccw1 *pccw1;
> > > +	int ret;
> > > +	int i;
> > > +
> > > +	ret = copy_from_iova(cp->mdev, to, iova, len * sizeof(struct ccw1));
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	if (!cp->orb.cmd.fmt) {
> > > +		pccw1 = to;
> > > +		for (i = 0; i < len; i++) {
> > > +			ccw0 = *(struct ccw0 *)pccw1;
> > > +			pccw1->cmd_code = ccw0.cmd_code;
> > > +			pccw1->flags = ccw0.flags;
> > > +			pccw1->count = ccw0.count;
> > > +			pccw1->cda = ccw0.cda;
> > > +			pccw1++;
> > > +		}
> > 
> > IIRC there are one or two very subtle differences between what format-0
> > and what format-1 ccws allow (see the ccw interpretation in qemu --
> > probably easier than combing through the PoP). We should either check
> > this or add a comment why we don't.
> > 
> Cool! Thanks for pointing out this!
> 
> Transfer in Channel, 15-73, PoP:
> --------------------8<-----------------------------
> The contents of the second half of the format-0 CCW,
> bit positions 32-63, are ignored. Similarly, the con-
> tents of bit positions 0-3 of the format-0 CCW are
> ignored.
> 
> Bit positions 0-3 and 8-32 of the format-1 CCW must
> contain zeros; otherwise, a program-check condition
> is generated.
> -------------------->8-----------------------------
> 
> I will fix according to the above description.

Yes. It's a bit unfortunate that we have to inspect the ccws, but it
probably can't be helped if we want to be architecture compliant.

> 
> I also checked the code in qemu. It seems that it is not compliant with
> the second paragraph above. Could I send out a separated patch to fix
> that?

Please do, bugfixes are welcome :)

> 
> > > +	}
> > > +
> > > +	return ret;
> > > +}
