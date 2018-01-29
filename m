Received: from eggs.gnu.org ([2001:4830:134:3::10]:50999)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1egDXA-0002B9-FK
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 12:48:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1egDX4-0000N4-DR
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 12:47:56 -0500
Date: Mon, 29 Jan 2018 18:46:58 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180129174658.GO6141@localhost.localdomain>
References: <20180127020515.27137-1-jsnow@redhat.com>
	<20180127020515.27137-2-jsnow@redhat.com>
	<20180129165929.GK6141@localhost.localdomain>
	<e20c83f9-4ccb-63ca-2f12-4182d3564589@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e20c83f9-4ccb-63ca-2f12-4182d3564589@redhat.com>
Subject: Re: [Qemu-devel] [RFC v3 01/14] blockjobs: add manual property
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

Am 29.01.2018 um 18:34 hat John Snow geschrieben:
> On 01/29/2018 11:59 AM, Kevin Wolf wrote:
> > Am 27.01.2018 um 03:05 hat John Snow geschrieben:
> >> This property will be used to opt-in to the new BlockJobs workflow
> >> that allows a tighter, more explicit control over transitions from
> >> one runstate to another.
> >>
> >> Signed-off-by: John Snow <jsnow@redhat.com>
> > 
> >> diff --git a/include/block/blockjob.h b/include/block/blockjob.h
> >> index 00403d9482..b94d0c9fa6 100644
> >> --- a/include/block/blockjob.h
> >> +++ b/include/block/blockjob.h
> >> @@ -141,6 +141,11 @@ typedef struct BlockJob {
> >>       */
> >>      QEMUTimer sleep_timer;
> >>  
> >> +    /* Set to true when management API has requested 2.12+ job lifetime
> >> +     * management semantics.
> >> +     */
> >> +    bool manual;
> > 
> > Wouldn't it make more sense to describe what "2.12+ job lifetime
> > management semantics" actually are? Maybe then it would be easy to find
> > a more specific name, too, like manual_completion.
> > 
> 
> Sure. At the time I wrote it, I wasn't sure what they were. Maybe I'll
> find out after the review; but I'll make a note to document it here.
> 
> > In fact, I wonder if the opposite flag wouldn't be nicer, i.e. having a
> > bool auto_completion (or finalization or whatever that extra step was
> > called in the final draft), defaulting to true.
> > 
> 
> I could do that, if you feel it'd be more readable. In terms of style I
> tend to prefer new additions default to false as that feels more
> permanently reliable, but it's only a preference.

Yeah, that is one way to look at it. The other one is that options
should generally be positive, i.e. true enables a feature rather than
disabling it. If I look at the interface without its history, the
feature (the extra thing on top of the basic state machine) that is
enabled or disabled is automatic completion.

This is why my preference would be the other way round, but it's still
only a preference. :-)

After reading a few more patches, it also seems to me that you are
looking a bit differently at the whole state machine than I am. So you
seem to assume two different state machines depending on whether manual
is set, whereas I assume all jobs share the same state machine and only
some transitions are optionally manual or automatic.

Kevin
