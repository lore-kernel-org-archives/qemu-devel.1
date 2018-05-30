Received: from eggs.gnu.org ([2001:4830:134:3::10]:50578)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1fO1Cj-0003yS-Pb
	for qemu-devel@nongnu.org; Wed, 30 May 2018 09:31:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1fO1Ci-0007h3-G7
	for qemu-devel@nongnu.org; Wed, 30 May 2018 09:31:53 -0400
Date: Wed, 30 May 2018 09:31:40 -0400
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20180530133140.GH9904@localhost.localdomain>
References: <20180529203910.7615-1-kwolf@redhat.com>
	<20180530014316.GA9904@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180530014316.GA9904@localhost.localdomain>
Subject: Re: [Qemu-devel] [PATCH v2 00/16] block: Make blockdev-create a job
 and stable API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, mreitz@redhat.com, jsnow@redhat.com, eblake@redhat.com, pkrempa@redhat.com, qemu-devel@nongnu.org

On Tue, May 29, 2018 at 09:43:16PM -0400, Jeff Cody wrote:
> On Tue, May 29, 2018 at 10:38:54PM +0200, Kevin Wolf wrote:
> > This changes the x-blockdev-create QMP command so that it doesn't block
> > the monitor and the main loop any more, but starts a background job that
> > performs the image creation.
> > 
> 
> I'm sure modifying the drivers is fodder for a future series, since this
> series lays the groundwork.  But from testing, some image formats (e.g.
> qcow2) still block the main loop and monitor when doing blockdev-create
> (preallocation:full, and a larger image size is particularly noticeable).
> 

If it helps to reproduce what I'm seeing, here is the QAPI command I am
using when testing:

    {
    "execute": "blockdev-create",
        "arguments": {
            "job-id": "jobtest1",
            "options": {
                "driver": "qcow2",
                "file": {
                    "driver": "file",
                    "filename": "/home/jcody/deleteme.qcow2"
                },
                "preallocation": "full",
                "size": 5120000000
            }
        }
    }


> > The basic job as implemented here is all that is necessary to make image
> > creation asynchronous and to provide a QMP interface that can be marked
> > stable, but it still lacks a few features that jobs usually provide: The
> > job will ignore pause commands and it doesn't publish progress yet (so
> > both current-progress and total-progress stay at 0). These features can
> > be added later without breaking compatibility.
> > 
> > At the end of the series, the interface is declared stable and the x-
> > prefix is removed.
> > 
> > v2:
> > - Made job->error == NULL iff job->ret == 0 [Max]
> > - Fixed a comment in qmp_blockdev_create() and added a TODO comment for
> >   AioContext locking at least [Max]
> > - Many small changes in the tests [Max, Jeff]
> > 
> > Kevin Wolf (16):
> >   vdi: Fix vdi_co_do_create() return value
> >   vhdx: Fix vhdx_co_create() return value
> >   job: Add error message for failing jobs
> >   block/create: Make x-blockdev-create a job
> >   qemu-iotests: Add VM.get_qmp_events_filtered()
> >   qemu-iotests: Add VM.qmp_log()
> >   qemu-iotests: Add iotests.img_info_log()
> >   qemu-iotests: Add VM.run_job()
> >   qemu-iotests: iotests.py helper for non-file protocols
> >   qemu-iotests: Rewrite 206 for blockdev-create job
> >   qemu-iotests: Rewrite 207 for blockdev-create job
> >   qemu-iotests: Rewrite 210 for blockdev-create job
> >   qemu-iotests: Rewrite 211 for blockdev-create job
> >   qemu-iotests: Rewrite 212 for blockdev-create job
> >   qemu-iotests: Rewrite 213 for blockdev-create job
> >   block/create: Mark blockdev-create stable
> > 
> >  qapi/block-core.json          |  18 +-
> >  qapi/job.json                 |   4 +-
> >  include/qemu/job.h            |   7 +-
> >  block/backup.c                |   2 +-
> >  block/commit.c                |   2 +-
> >  block/create.c                |  67 +++--
> >  block/mirror.c                |   2 +-
> >  block/stream.c                |   2 +-
> >  block/vdi.c                   |   1 +
> >  block/vhdx.c                  |   2 +-
> >  job-qmp.c                     |   9 +-
> >  job.c                         |  16 +-
> >  tests/test-bdrv-drain.c       |   2 +-
> >  tests/test-blockjob-txn.c     |   2 +-
> >  tests/test-blockjob.c         |   2 +-
> >  tests/qemu-iotests/206        | 680 ++++++++++++++++--------------------------
> >  tests/qemu-iotests/206.out    | 253 +++++++++-------
> >  tests/qemu-iotests/207        | 440 ++++++++++++---------------
> >  tests/qemu-iotests/207.out    | 107 +++----
> >  tests/qemu-iotests/210        | 393 ++++++++++--------------
> >  tests/qemu-iotests/210.out    | 197 ++++++++----
> >  tests/qemu-iotests/211        | 381 ++++++++++-------------
> >  tests/qemu-iotests/211.out    | 133 +++++----
> >  tests/qemu-iotests/212        | 483 +++++++++++-------------------
> >  tests/qemu-iotests/212.out    | 191 +++++++-----
> >  tests/qemu-iotests/213        | 520 ++++++++++++--------------------
> >  tests/qemu-iotests/213.out    | 208 ++++++++-----
> >  tests/qemu-iotests/iotests.py |  78 +++++
> >  28 files changed, 1979 insertions(+), 2223 deletions(-)
> > 
> > -- 
> > 2.13.6
> > 
