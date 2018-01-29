Received: from eggs.gnu.org ([2001:4830:134:3::10]:56416)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1egFY7-0000M4-LG
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 14:57:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1egFY6-0003hN-II
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 14:57:03 -0500
Date: Mon, 29 Jan 2018 20:56:39 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180129195639.GS6141@localhost.localdomain>
References: <20180127020515.27137-1-jsnow@redhat.com>
	<20180127020515.27137-4-jsnow@redhat.com>
	<20180129171755.GM6141@localhost.localdomain>
	<bd2109b3-3a49-2adb-cdc6-715dba7a31f8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd2109b3-3a49-2adb-cdc6-715dba7a31f8@redhat.com>
Subject: Re: [Qemu-devel] [RFC v3 03/14] blockjobs: add state transition
 table
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: pkrempa@redhat.com, jtc@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org

Am 29.01.2018 um 20:07 hat John Snow geschrieben:
> 
> 
> On 01/29/2018 12:17 PM, Kevin Wolf wrote:
> > Am 27.01.2018 um 03:05 hat John Snow geschrieben:
> >> The state transition table has mostly been implied. We're about to make
> >> it a bit more complex, so let's make the STM explicit instead.
> >>
> >> Perform state transitions with a function that for now just asserts the
> >> transition is appropriate.
> >>
> >> undefined: May only transition to 'created'.
> >> created: May only transition to 'running'.
> >>          It cannot transition to pause directly, but if a created job
> >>          is requested to pause prior to starting, it will transition
> >>          synchronously to 'running' and then to 'paused'.
> >> running: May transition either to 'paused' or 'ready'.
> >> paused: May transition to either 'running' or 'ready', but only in
> >>         terms of returning to that prior state.
> >>         p->r->y is not possible, but this is not encapsulated by the
> >>         STM table.
> > 
> > Do you mean y->p->r->y here? If not, I don't understand.
> 
> Whoops, Yes, I mean to say that Y->P->R is not possible.
> 
> That is, a paused state can only return to where it came from, but the
> STM doesn't show this restriction. Really, this hints at there being
> *two* paused states, but I didn't want to go through the trouble of
> adding a new one.

Hm, yes... It would probably be cleaner to have two states. If a client
queries the state and just sees PAUSED, it doesn't know whether the bulk
phase has already finished.

> > 
> >> ready: May transition to paused.
> 
> I swear my script used to add blank lines for me here. *shrug*
> 
> >> Signed-off-by: John Snow <jsnow@redhat.com>
> >> ---
> >>  blockjob.c | 39 ++++++++++++++++++++++++++++++++++-----
> >>  1 file changed, 34 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/blockjob.c b/blockjob.c
> >> index 6eb783a354..d084a1e318 100644
> >> --- a/blockjob.c
> >> +++ b/blockjob.c
> >> @@ -42,6 +42,35 @@
> >>   * block_job_enter. */
> >>  static QemuMutex block_job_mutex;
> >>  
> >> +/* BlockJob State Transition Table */
> >> +bool BlockJobSTT[BLOCK_JOB_STATUS__MAX][BLOCK_JOB_STATUS__MAX] = {
> >> +                                          /* U, C, R, P, Y */
> >> +    /* U: */ [BLOCK_JOB_STATUS_UNDEFINED] = {0, 1, 0, 0, 0},
> >> +    /* C: */ [BLOCK_JOB_STATUS_CREATED]   = {0, 0, 1, 0, 0},
> >> +    /* R: */ [BLOCK_JOB_STATUS_RUNNING]   = {0, 0, 0, 1, 1},
> >> +    /* P: */ [BLOCK_JOB_STATUS_PAUSED]    = {0, 0, 1, 0, 1},
> >> +    /* Y: */ [BLOCK_JOB_STATUS_READY]     = {0, 0, 0, 1, 0},
> >> +};
> >> +
> >> +static void block_job_state_transition(BlockJob *job, BlockJobStatus s1)
> >> +{
> >> +    BlockJobStatus s0 = job->status;
> >> +    if (s0 == s1) {
> >> +        return;
> >> +    }
> >> +    assert(s1 >= 0 && s1 <= BLOCK_JOB_STATUS__MAX);
> >> +    assert(BlockJobSTT[s0][s1]);
> >> +    switch (s1) {
> >> +    case BLOCK_JOB_STATUS_WAITING:
> >> +    case BLOCK_JOB_STATUS_PENDING:
> >> +    case BLOCK_JOB_STATUS_CONCLUDED:
> >> +        assert(job->manual);
> >> +    default:
> >> +        break;
> >> +    }
> > 
> > This doesn't compile because the constants don't exist yet.
> > 
> 
> *cough* oops.
> 
> > Apart from that, I think the assertion is misguided, too. Which states a
> > job goes through shouldn't depend on whether the client wants to
> > complete the job manually or have it completed automatically. The
> > difference should only be which state transitions are automatic.
> > > In other words, WAITING/PENDING/CONCLUDED may never be visible in
> > query-block-job for automatically completed jobs, but the jobs should
> > still (synchronously) go through all of these states.
> > 
> 
> Hmm. OK, I can look at doing it in this way. I will probably also have
> it omit the events in this case too, though.

Actually, while there is probably no use for the events, I don't think
they would hurt if omitting them isn't completely trivial. Clients
always need to be prepared to see new unknown events.

Kevin
