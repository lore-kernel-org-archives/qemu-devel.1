Received: from eggs.gnu.org ([2001:4830:134:3::10]:56909)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1d3LyT-0002pk-0a
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 08:23:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1d3LyP-00084A-0u
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 08:23:12 -0400
Date: Wed, 26 Apr 2017 14:22:46 +0200
From: Kashyap Chamarthy <kchamart@redhat.com>
Message-ID: <20170426122246.v2px6y33k4dpiiqb@eukaryote>
References: <20170225193155.447462-1-vsementsov@virtuozzo.com>
	<20170225193155.447462-3-vsementsov@virtuozzo.com>
	<20170307100204.GC5871@noname.str.redhat.com>
	<ec621d28-d6bd-a125-fa1c-5e9a09b04c22@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec621d28-d6bd-a125-fa1c-5e9a09b04c22@virtuozzo.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 2/4] qmp-cont: invalidate on
 RUN_STATE_PRELAUNCH
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: Kevin Wolf <kwolf@redhat.com>, peter.maydell@linaro.org, famz@redhat.com, lirans@il.ibm.com, qemu-block@nongnu.org, quintela@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com, stefanha@redhat.com, den@openvz.org, amit.shah@redhat.com, pbonzini@redhat.com, mreitz@redhat.com, dgilbert@redhat.com

On Tue, Mar 07, 2017 at 01:11:23PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> 07.03.2017 13:02, Kevin Wolf wrote:
> > Am 25.02.2017 um 20:31 hat Vladimir Sementsov-Ogievskiy geschrieben:
> > > We must invalidate on RUN_STATE_PRELAUNCH too, as it is available
> > > through qmp_system_reset from RUN_STATE_POSTMIGRATE. Otherwise, we will
> > > come to
> > > 
> > > qemu-kvm: block/io.c:1406: bdrv_co_do_pwritev:
> > >         Assertion `!(bs->open_flags & 0x0800)' failed.
> > > 
> > > on the first write after vm start.
> > > 
> > > Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> > Wouldn't it make more sense to invalidate in qmp_system_reset() where
> > the migration states are left?
> > 
> > Or maybe BDRV_O_INACTIVE could even be tied directly to runstates? Not
> > sure how realistic this one is, but if we start adding invalidate_cache
> > calls all over the place, maybe that's a sign that we need to look for a
> > more central place.
> 
> I've proposed it in cover letter) These bugs and my fixes are just show that
> something should be rethought.. I don't claim that these fixes are true way,
> they are just the simplest.

Hi Vladimir,

I wonder if you have a new version of your patch ("qmp-cont: invalidate
on RUN_STATE_PRELAUNCH").

Hailiang Zhang tells me on this the below thread that your patch fixes
the issue:

  http://lists.nongnu.org/archive/html/qemu-devel/2017-04/msg03925.html
  -- [QEMU-2.8] Source QEMU crashes with: "bdrv_co_pwritev: Assertion
  `!(bs->open_flags & BDRV_O_INACTIVE)' failed"

-- 
/kashyap
