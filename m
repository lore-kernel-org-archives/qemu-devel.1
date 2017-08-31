Received: from eggs.gnu.org ([2001:4830:134:3::10]:38208)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dnRZb-0004hR-RX
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 11:40:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dnRZX-0007H7-6L
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 11:40:03 -0400
Date: Thu, 31 Aug 2017 16:39:49 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170831153949.GA19001@stefanha-x1.localdomain>
References: <cover.1504111803.git.jcody@redhat.com>
	<aba8a2b58f34b56281e63e5e9404eb0aab016836.1504111803.git.jcody@redhat.com>
	<1646044f-3c57-c415-f261-463c74ea45b8@redhat.com>
	<2690a268-b5be-7974-e8ef-c5a2f09c72a5@redhat.com>
	<c8f38ba5-5170-d3c8-99ca-24030f900e53@redhat.com>
	<494b96d5-d2a2-957e-3169-7fb2461b59de@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <494b96d5-d2a2-957e-3169-7fb2461b59de@redhat.com>
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
To: John Snow <jsnow@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org, kwolf@redhat.com, armbru@redhat.com, qemu-block@nongnu.org

On Wed, Aug 30, 2017 at 06:40:29PM -0400, John Snow wrote:
> 
> 
> On 08/30/2017 06:35 PM, Eric Blake wrote:
> > On 08/30/2017 05:28 PM, John Snow wrote:
> > 
> >> I'm a little iffy on this patch; I know that ./check can take care of
> >> our temp files for us now, but because each python test is itself a
> >> little mini-harness, I'm a little leery of moving the teardown to setup
> >> and trying to pre-clean the confetti before the test begins.
> >>
> >> What's the benefit? We still have to clean up these files per-test, but
> >> now it's slightly more error-prone and in a weird place.
> >>
> >> If we want to try to preserve the most-recent-failure-files, perhaps we
> >> can define a setting in the python test-runner that allows us to
> >> globally skip file cleanup.
> > 
> > On the other hand, since each test is a mini-harness, globally skipping
> > cleanup will make a two-part test fail on the second because of garbage
> > left behind by the first.
> > 
> 
> subtext was to have per-subtest files.
> 
> > Patch 5 adds a comment with another possible solution: teach the python
> > mini-harness to either clean all files in the directory, or to relocate
> > the directory according to test name, so that each mini-test starts with
> > a fresh location, and cleanup is then handled by the harness rather than
> > spaghetti pre-cleanup.  But any solution is better than our current
> > situation of nothing, so that's why I'm still okay with this patch as-is
> > as offering more (even if not perfect) than before.
> > 
> 
> I guess where I am unsure is really if this is better than what we
> currently do, which is to (try) to clean up after each test as best as
> we can. I don't see it as too different from trying to clean up before
> each test.
> 
> It does give us the ability to leave behind a little detritus after a
> failed run, but it's so imperfect that I wonder if it's worth shifting
> this code around to change not much.

An alternative is to define iotests.QMPTestCase.setUp() so it clears out
iotests.test_dir.  Unfortunately this still requires touching up all
setUp() methods so that they call super(TheClass, self).setUp().

At least there would be no need to delete specific files by name (e.g.
blind_remove(my_img)).

Stefan
