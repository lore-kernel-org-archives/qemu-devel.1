Received: from eggs.gnu.org ([2001:4830:134:3::10]:59453)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eWYs8-00072y-84
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 21:33:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eWYs3-0007Od-Ct
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 21:33:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52484)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eWYs3-0007O0-5c
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 21:33:35 -0500
Date: Wed, 3 Jan 2018 10:33:22 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180103023322.GB2557@xz-mi>
References: <20170801160419.14180-1-marcandre.lureau@redhat.com>
	<b3ccb2a7-efe3-2b0b-62ee-a3ab126e0205@virtuozzo.com>
	<20171228021931.GB22514@xz-mi>
	<223c3177-fae6-c218-1165-dc01e73c2e14@virtuozzo.com>
	<20180102151938.GC2560@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180102151938.GC2560@work-vm>
Subject: Re: [Qemu-devel] [PATCH] migration: fix small leaks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>

On Tue, Jan 02, 2018 at 03:19:38PM +0000, Dr. David Alan Gilbert wrote:
> * Vladimir Sementsov-Ogievskiy (vsementsov@virtuozzo.com) wrote:
> > 28.12.2017 05:19, Peter Xu wrote:
> > > On Wed, Dec 27, 2017 at 03:25:23PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> > > > Hi all!
> > > > 
> > > > Hmm, looks like leak is not fixed here: I've checked it while running iotest
> > > > 181, that
> > > > migration_instance_finalize is not called.
> > > > 
> > > > If I understand correct, to call it we need unref current_migration object
> > > > somewhere.
> > > > 
> > > > Or, may be I'm missing something..
> > > I think you are right.
> > > 
> > > It does not matter much though since we don't dynamically allocate
> > > migration object (there is only one and it lives forever).  Do you
> > > want to post a patch?  I guess the safest place to unref it is at the
> > > end of main() to make sure no one will be using it any more.
> > > 
> > > (Hmm, the incoming migration state is still static)
> > > 
> > > Thanks,
> > 
> > Ok, I'll send a patch.
> 
> Be very very careful that it doesn't crash in cases like quit in the main thread
> while a migration is still running.

Agree.

> 
> I have no problem with this object living forever and letting it just
> die with exit().

Yes.  But if better, I am thinking whether we should always make sure
migration is completed/failed/cancelled before that point.  If we quit
QEMU with a working migration stream, logically we should stop it
before leaving, as part of QEMU's cleanup path.

-- 
Peter Xu
