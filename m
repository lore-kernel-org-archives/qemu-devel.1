Received: from eggs.gnu.org ([2001:4830:134:3::10]:36843)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1clCGY-0004s4-KD
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 05:22:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1clCGX-0001xn-NL
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 05:22:50 -0500
Date: Tue, 7 Mar 2017 11:22:40 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170307102240.GE5871@noname.str.redhat.com>
References: <20170225193155.447462-1-vsementsov@virtuozzo.com>
	<20170225193155.447462-3-vsementsov@virtuozzo.com>
	<20170307100204.GC5871@noname.str.redhat.com>
	<ec621d28-d6bd-a125-fa1c-5e9a09b04c22@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec621d28-d6bd-a125-fa1c-5e9a09b04c22@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH 2/4] qmp-cont: invalidate on
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
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, pbonzini@redhat.com, armbru@redhat.com, eblake@redhat.com, famz@redhat.com, stefanha@redhat.com, amit.shah@redhat.com, quintela@redhat.com, mreitz@redhat.com, peter.maydell@linaro.org, dgilbert@redhat.com, den@openvz.org, jsnow@redhat.com, lirans@il.ibm.com

Am 07.03.2017 um 11:11 hat Vladimir Sementsov-Ogievskiy geschrieben:
> 07.03.2017 13:02, Kevin Wolf wrote:
> >Am 25.02.2017 um 20:31 hat Vladimir Sementsov-Ogievskiy geschrieben:
> >>We must invalidate on RUN_STATE_PRELAUNCH too, as it is available
> >>through qmp_system_reset from RUN_STATE_POSTMIGRATE. Otherwise, we will
> >>come to
> >>
> >>qemu-kvm: block/io.c:1406: bdrv_co_do_pwritev:
> >>        Assertion `!(bs->open_flags & 0x0800)' failed.
> >>
> >>on the first write after vm start.
> >>
> >>Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> >Wouldn't it make more sense to invalidate in qmp_system_reset() where
> >the migration states are left?
> >
> >Or maybe BDRV_O_INACTIVE could even be tied directly to runstates? Not
> >sure how realistic this one is, but if we start adding invalidate_cache
> >calls all over the place, maybe that's a sign that we need to look for a
> >more central place.
> 
> I've proposed it in cover letter) These bugs and my fixes are just
> show that something should be rethought.. I don't claim that these
> fixes are true way, they are just the simplest.

Ah, sorry, I read the cover letter a while ago, but not again before
reading the patches now. You're right that it's something that needs to
be addressed in some way. Your patches may be simple, but I think there
is no hope to ever get it completely correct with that approach because
there are so many cases (basically each QMP command is one case).

The cover letter seems to propose that INACTIVE could be a runstate. I
don't think that's quite right, because we already have many runstates
that would qualify as inactive in this sense, but that still need to be
separate. But possibly we can have a mapping from runstates to the
inactive flag.

One (implementation) problem with directly coupling inactive with
runstates is that runstate_set() can't fail at the moment, but
bdrv_inactivate/invalidate_cache() can.

Kevin
