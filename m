Received: from eggs.gnu.org ([2001:4830:134:3::10]:42029)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eHfgN-0004N7-9R
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 19:48:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eHfgI-0005lz-DR
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 19:47:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58868)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1eHfgI-0005ld-6s
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 19:47:54 -0500
Date: Thu, 23 Nov 2017 08:47:47 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20171123004747.GB1624@lemon>
References: <151129128964.22232.12085565834223304351@sif>
	<255b996e-cfe4-2499-c6aa-8122461eb1dc@de.ibm.com>
	<fe97da57-87c3-40a0-92b9-f1868ab09080@de.ibm.com>
	<151132098079.31225.2285990377569459449@sif>
	<6739de79-67e2-1fc7-3f6a-774e7d2bc08f@de.ibm.com>
	<20171122095541.GA8572@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171122095541.GA8572@localhost.localdomain>
Subject: Re: [Qemu-devel] [ANNOUNCE] QEMU 2.11.0-rc2 is now available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Kevin Wolf <kwolf@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, QingFeng Hao <haoqf@linux.vnet.ibm.com>, Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>

On Wed, 11/22 04:55, Jeff Cody wrote:
> On Wed, Nov 22, 2017 at 09:09:02AM +0100, Christian Borntraeger wrote:
> > 
> > 
> > On 11/22/2017 04:23 AM, Michael Roth wrote:
> > > Quoting Christian Borntraeger (2017-11-21 15:38:32)
> > >> forgot to cc qemu-devel....
> > >>
> > >> On 11/21/2017 10:37 PM, Christian Borntraeger wrote:
> > >>> a quick heads up . Rc2 now triggers
> > >>> +qemu-img: block/block-backend.c:2088: blk_root_drained_end: Assertion `blk->quiesce_counter' failed.
> > >>> for several qemu iotests. 
> > >>>
> > >>> I have not looked into any details.
> > > 
> > > It looks to be due to:
> > > 
> > > 4afeffc8572f40d8844b946a30c00b10da4442b1
> > > blockjob: do not allow coroutine double entry or entry-after-completion
> > 
> > Yes, I can confirm that reverting this patch gets rid of this assertion, but
> > I see things like
> > 
> > --- /home/cborntra/REPOS/qemu/tests/qemu-iotests/020.out	2017-11-21 20:19:34.785519323 +0100
> > +++ /home/cborntra/REPOS/qemu/build/tests/qemu-iotests/020.out.bad	2017-11-22 09:04:50.127612500 +0100
> > @@ -537,7 +537,8 @@
> >  wrote 65536/65536 bytes at offset 4295098368
> >  64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> >  No errors were found on the image.
> > -Image committed.
> > +qemu_aio_coroutine_enter: Co-routine was already scheduled in 'co_aio_sleep_ns'
> > +./common.rc: line 61: 88002 Aborted                 (core dumped) ( exec "$QEMU_IMG_PROG" $QEMU_IMG_OPTIONS "$@" )
> > 
> 
> That is from the subsequent patches in the series - you will want to revert
> the whole series to test, as the introduced aborts catch the illegal
> entries that the reverted patch sidestepped.
> 
> The series patches are:
> 
> 4afeffc
> 6133b39
> a233969
> d975301
> 
> Of course, these new aborts prevent improper behavior, so we may want to
> figure out why this is getting hit.
> 
> Unfortunately, I am traveling at the moment (waiting to board my flight), so
> will have limited connectivity.

I'll take a look at this today and the bottom line is we revert the series until
a proper fix is found.

Fa
