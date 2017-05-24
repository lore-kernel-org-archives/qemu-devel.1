Received: from eggs.gnu.org ([2001:4830:134:3::10]:57273)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dDLxl-00017V-05
	for qemu-devel@nongnu.org; Tue, 23 May 2017 22:23:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dDLxk-0007hm-6y
	for qemu-devel@nongnu.org; Tue, 23 May 2017 22:23:49 -0400
Date: Wed, 24 May 2017 10:23:38 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170524022338.GH12279@lemon.lan>
References: <20170419094356.19826-1-famz@redhat.com>
	<20170419094356.19826-11-famz@redhat.com>
	<20170511202702.GM24584@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170511202702.GM24584@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2 10/16] mirror: Do initial
 aio context move of target via BB interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>

On Thu, 05/11 16:27, Stefan Hajnoczi wrote:
> On Wed, Apr 19, 2017 at 05:43:50PM +0800, Fam Zheng wrote:
> > diff --git a/blockdev.c b/blockdev.c
> > index dfd1385..53f9874 100644
> > --- a/blockdev.c
> > +++ b/blockdev.c
> > @@ -3556,8 +3556,6 @@ void qmp_drive_mirror(DriveMirror *arg, Error **errp)
> >          goto out;
> >      }
> >  
> > -    bdrv_set_aio_context(target_bs, aio_context);
> > -
> >      blockdev_mirror_common(arg->has_job_id ? arg->job_id : NULL, bs, target_bs,
> >                             arg->has_replaces, arg->replaces, arg->sync,
> >                             backing_mode, arg->has_speed, arg->speed,
> > @@ -3608,8 +3606,6 @@ void qmp_blockdev_mirror(bool has_job_id, const char *job_id,
> >      aio_context = bdrv_get_aio_context(bs);
> >      aio_context_acquire(aio_context);
> >  
> > -    bdrv_set_aio_context(target_bs, aio_context);
> > -
> >      blockdev_mirror_common(has_job_id ? job_id : NULL, bs, target_bs,
> >                             has_replaces, replaces, sync, backing_mode,
> >                             has_speed, speed,
> 
> This patch post-pones bdrv_set_aio_context() until later on.  We now
> call bdrv_get_info() without holding target_bs's AioContext in
> mirror_start_job().
> 
> Please acquire the AioContext around target_bs accesses until we move it
> to our AioContext.

Good catch! Will fix.

Fam
