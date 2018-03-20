Received: from eggs.gnu.org ([2001:4830:134:3::10]:33719)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eyEEt-0006iW-GV
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 06:11:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eyEEs-0005HX-9s
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 06:11:31 -0400
Date: Tue, 20 Mar 2018 11:11:01 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180320101101.GA4865@localhost.localdomain>
References: <20180319093509.50881-1-haoqf@linux.vnet.ibm.com>
	<20180319093509.50881-2-haoqf@linux.vnet.ibm.com>
	<CAJSP0QVe4gXCvPdw15x3D_yp2v4mi8QqYujo5qgxyeGcCbGfpw@mail.gmail.com>
	<1cc764c9-7bc1-365e-8af4-fe5357677aed@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1cc764c9-7bc1-365e-8af4-fe5357677aed@de.ibm.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v1 1/1] iotests: fix test case
 185
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, QingFeng Hao <haoqf@linux.vnet.ibm.com>, qemu block <qemu-block@nongnu.org>, Fam Zheng <famz@redhat.com>, Cornelia Huck <cohuck@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>

Am 19.03.2018 um 18:53 hat Christian Borntraeger geschrieben:
> 
> 
> On 03/19/2018 05:10 PM, Stefan Hajnoczi wrote:
> > On Mon, Mar 19, 2018 at 9:35 AM, QingFeng Hao <haoqf@linux.vnet.ibm.com> wrote:
> >> Test case 185 failed since commit 4486e89c219 --- "vl: introduce vm_shutdown()".
> >> It's because of the newly introduced function vm_shutdown calls bdrv_drain_all,
> >> which is called later by bdrv_close_all. bdrv_drain_all resumes the jobs
> >> that doubles the speed and offset is doubled.
> >> Some jobs' status are changed as well.
> >>
> >> Thus, let's not call bdrv_drain_all in vm_shutdown.
> >>
> >> Signed-off-by: QingFeng Hao <haoqf@linux.vnet.ibm.com>
> >> ---
> >>  cpus.c | 5 +++--
> >>  1 file changed, 3 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/cpus.c b/cpus.c
> >> index 2e6701795b..ae2962508c 100644
> >> --- a/cpus.c
> >> +++ b/cpus.c
> >> @@ -1006,8 +1006,9 @@ static int do_vm_stop(RunState state, bool send_stop)
> >>              qapi_event_send_stop(&error_abort);
> >>          }
> >>      }
> >> -
> >> -    bdrv_drain_all();
> >> +    if (send_stop) {
> >> +        bdrv_drain_all();
> >> +    }
> > 
> > Thanks for looking into this bug!
> > 
> > This if statement breaks the contract of the function when send_stop
> > is false.  Drain ensures that pending I/O completes and that device
> > emulation finishes before this function returns.  This is important
> > for live migration, where there must be no more guest-related activity
> > after vm_stop().
> > 
> > This patch relies on the caller invoking bdrv_close_all() immediately
> > after do_vm_stop(), which is not documented and could lead to more
> > bugs in the future.
> > 
> > I suggest a different solution:
> > 
> > Test 185 relies on internal QEMU behavior which can change from time
> > to time.  Buffer sizes and block job iteration counts are
> > implementation details that are not part of qapi-schema.json or other
> > documented behavior.
> > 
> > In fact, the existing test case was already broken in IOThread mode
> > since iothread_stop_all() -> bdrv_set_aio_context() also includes a
> > bdrv_drain() with the side-effect of an extra blockjob iteration.
> > 
> > After 4486e89c219 ("vl: introduce vm_shutdown()") both IOThread and
> > non-IOThread mode perform the drain.  This has caused the test
> > failure.
> > 
> > Instead of modifying QEMU to keep the same arbitrary internal behavior
> > as before, please send a patch that updates tests/qemu-iotests/185.out
> > with the latest output.
> 
> Wouldnt it be better if the test actually masks out the values the are not
> really part of the "agreed upon" behaviour? Wouldnt block_job_offset from
> common.filter be what we want?

The test case has the following note:

# Note that the reference output intentionally includes the 'offset' field in
# BLOCK_JOB_CANCELLED events for all of the following block jobs. They are
# predictable and any change in the offsets would hint at a bug in the job
# throttling code.

Now the question is if this particular change is okay rather than
hinting at a bug and we should update the reference output or whether we
need to change qemu again.

I think the change isn't really bad, but we are doing more useless work
now than we used to do before, and we're exiting slower because we're
spawning additional I/O that we have to wait for. So the better state
was certainly the old one.

Kevin
