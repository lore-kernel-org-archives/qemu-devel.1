Received: from eggs.gnu.org ([2001:4830:134:3::10]:55876)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fqC94-0004yb-68
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 02:52:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fqC93-0004q0-Ay
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 02:52:34 -0400
Date: Thu, 16 Aug 2018 08:52:21 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180816065221.GB5511@localhost.localdomain>
References: <20180807043349.27196-1-jsnow@redhat.com>
	<20180807043349.27196-17-jsnow@redhat.com>
	<20180809151242.GD4320@localhost.localdomain>
	<60ef1ca4-2b17-3600-972a-ecf004fd989c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60ef1ca4-2b17-3600-972a-ecf004fd989c@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 16/21] block/commit: refactor commit to use
 job callbacks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Jeff Cody <jcody@redhat.com>, Max Reitz <mreitz@redhat.com>, jtc@redhat.com, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Eric Blake <eblake@redhat.com>

Am 15.08.2018 um 23:17 hat John Snow geschrieben:
> On 08/09/2018 11:12 AM, Kevin Wolf wrote:
> > Am 07.08.2018 um 06:33 hat John Snow geschrieben:
> >> Use the component callbacks; prepare, commit, abort, and clean.
> >>
> >> NB: prepare is only called when the job has not yet failed;
> >> and abort can be called after prepare.
> >>
> >> complete -> prepare -> abort -> clean
> >> complete -> abort -> clean
> > 
> > I always found this confusing. After converting all jobs to use the
> > infrastructure, do you think that this design is helpful? You seem to be
> > calling *_common function from commit and abort, with an almost empty
> > prepare, which looks like a hint that maybe we should reorganise things.
> > 
> 
> After rewriting things a bit, I think it would be nicer to call prepare
> regardless of circumstances. The callbacks will be nicer for it.
> 
> When I wrote it the first time, the thought process was something like:
> 
> "Well, we won't need to prepare anything if we've already failed, we
> just need to speed along to abort."
> 
> I wasn't considering so carefully the common cleanup case that needs to
> occur post-finalization which appears to actually happen in a good
> number of jobs.

Maybe let's see how things turn out when we actually make some more jobs
transactionable. For now, it seems that the *_common function can go
away at least for commit; and we didn't even try to properly split the
completion of the other two jobs.

> >> Signed-off-by: John Snow <jsnow@redhat.com>
> >> ---
> >>  block/commit.c | 94 +++++++++++++++++++++++++++++++++++++---------------------
> >>  1 file changed, 61 insertions(+), 33 deletions(-)
> >>
> >> diff --git a/block/commit.c b/block/commit.c
> >> index 1a4a56795f..6673a0544e 100644
> >> --- a/block/commit.c
> >> +++ b/block/commit.c
> >> @@ -35,7 +35,9 @@ typedef struct CommitBlockJob {
> >>      BlockJob common;
> >>      BlockDriverState *commit_top_bs;
> >>      BlockBackend *top;
> >> +    BlockDriverState *top_bs;
> >>      BlockBackend *base;
> >> +    BlockDriverState *base_bs;
> >>      BlockdevOnError on_error;
> >>      int base_flags;
> >>      char *backing_file_str;
> > 
> > More state. :-(
> > 
> > Can we at least move the new fields to the end of the struct with a
> > comment that they are only valid after .exit()?
> > 
> 
> Sure ... admittedly this is just a crutch because I was not precisely
> sure exactly when these might change out from underneath me. If there
> are some clever ways to avoid needing the state, feel free to suggest them.

I did, in the reply to my own mail. Everything that would need the state
can actually live in .abort, so it can be local.

> >> +}
> >> +
> >> +static void commit_commit(Job *job)
> >> +{
> >> +    commit_exit_common(job);
> >> +}
> > 
> > (I think I've answered this question now, by effectively proposing to do
> > away with .commit, but I'll leave it there anyway.)
> > 
> > Is there any reason for the split between .prepare and .commit as it is
> > or is this mostly arbitrary? Probably the latter because commit isn't
> > even transactionable?
> > 
> 
> Just historical, yeah -- we only had commit and abort for a while, and
> prepare didn't join the party until we wanted finalize and it became
> apparent we needed a way to check the return code and still be able to
> fail the transaction in time to be able to do a final commit or still
> abort very, very late in the process.
> 
> Probably there's no real meaningful reason that prepare and commit need
> to be separate callbacks.
> 
> It is possible that:
> 
> prepare --> [abort] --> clean
> 
> would be entirely sufficient for all current cases.

I think jobs that actually support transactions (i.e. backup currently)
do in fact need commit. The other ones might not.

Kevin
