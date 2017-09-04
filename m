Received: from eggs.gnu.org ([2001:4830:134:3::10]:37525)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1dosaH-0001HJ-Sn
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 10:42:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1dosaC-0007fE-IL
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 10:42:41 -0400
Date: Mon, 4 Sep 2017 10:42:17 -0400
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20170904144217.GR4770@localhost.localdomain>
References: <cover.1504111803.git.jcody@redhat.com>
	<aba8a2b58f34b56281e63e5e9404eb0aab016836.1504111803.git.jcody@redhat.com>
	<1646044f-3c57-c415-f261-463c74ea45b8@redhat.com>
	<2690a268-b5be-7974-e8ef-c5a2f09c72a5@redhat.com>
	<c8f38ba5-5170-d3c8-99ca-24030f900e53@redhat.com>
	<494b96d5-d2a2-957e-3169-7fb2461b59de@redhat.com>
	<20170831153949.GA19001@stefanha-x1.localdomain>
	<20170831154759.GN4770@localhost.localdomain>
	<20170904095124.GB21280@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170904095124.GB21280@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [PATCH v3 4/5] qemu-iotests: make python tests
 attempt to leave intermediate files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: John Snow <jsnow@redhat.com>, Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, kwolf@redhat.com, armbru@redhat.com, qemu-block@nongnu.org

On Mon, Sep 04, 2017 at 10:51:24AM +0100, Stefan Hajnoczi wrote:
> On Thu, Aug 31, 2017 at 11:47:59AM -0400, Jeff Cody wrote:
> > On Thu, Aug 31, 2017 at 04:39:49PM +0100, Stefan Hajnoczi wrote:
> > > On Wed, Aug 30, 2017 at 06:40:29PM -0400, John Snow wrote:
> > > > 
> > > > 
> > > > On 08/30/2017 06:35 PM, Eric Blake wrote:
> > > > > On 08/30/2017 05:28 PM, John Snow wrote:
> > > > > 
> > > > >> I'm a little iffy on this patch; I know that ./check can take care of
> > > > >> our temp files for us now, but because each python test is itself a
> > > > >> little mini-harness, I'm a little leery of moving the teardown to setup
> > > > >> and trying to pre-clean the confetti before the test begins.
> > > > >>
> > > > >> What's the benefit? We still have to clean up these files per-test, but
> > > > >> now it's slightly more error-prone and in a weird place.
> > > > >>
> > > > >> If we want to try to preserve the most-recent-failure-files, perhaps we
> > > > >> can define a setting in the python test-runner that allows us to
> > > > >> globally skip file cleanup.
> > > > > 
> > > > > On the other hand, since each test is a mini-harness, globally skipping
> > > > > cleanup will make a two-part test fail on the second because of garbage
> > > > > left behind by the first.
> > > > > 
> > > > 
> > > > subtext was to have per-subtest files.
> > > > 
> > > > > Patch 5 adds a comment with another possible solution: teach the python
> > > > > mini-harness to either clean all files in the directory, or to relocate
> > > > > the directory according to test name, so that each mini-test starts with
> > > > > a fresh location, and cleanup is then handled by the harness rather than
> > > > > spaghetti pre-cleanup.  But any solution is better than our current
> > > > > situation of nothing, so that's why I'm still okay with this patch as-is
> > > > > as offering more (even if not perfect) than before.
> > > > > 
> > > > 
> > > > I guess where I am unsure is really if this is better than what we
> > > > currently do, which is to (try) to clean up after each test as best as
> > > > we can. I don't see it as too different from trying to clean up before
> > > > each test.
> > > > 
> > > > It does give us the ability to leave behind a little detritus after a
> > > > failed run, but it's so imperfect that I wonder if it's worth shifting
> > > > this code around to change not much.
> > > 
> > > An alternative is to define iotests.QMPTestCase.setUp() so it clears out
> > > iotests.test_dir.  Unfortunately this still requires touching up all
> > > setUp() methods so that they call super(TheClass, self).setUp().
> > > 
> > > At least there would be no need to delete specific files by name (e.g.
> > > blind_remove(my_img)).
> > > 
> > 
> > One reason to only remove specific files used in the test, is that it
> > increases the chance that intermediate files will be left behind in case of
> > test failure of a different test case.
> > 
> > I think the real long-term solution is to run each unittest test case in its
> > own subdirectory, so that no intermediate file removal is necessary, and
> > each test case is self-contained.
> 
> That could be achieved in the same way:
> 
> Modify iotests.QMPTestCase.setUp() to create a new directory and chdir()
> into it.  This still requires touching up all existing setUp() methods
> to call their superclass.
>

Good idea!  I'll send out a v4 to just implement it this way; if I am going
to touch all the python tests anyway, might as well go all the way.

Thanks,
Jeff
