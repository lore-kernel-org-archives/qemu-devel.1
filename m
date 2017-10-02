Received: from eggs.gnu.org ([2001:4830:134:3::10]:40868)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1dz1Ku-0006tT-Oe
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 10:04:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1dz1Km-0005Mj-TG
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 10:04:44 -0400
Date: Mon, 2 Oct 2017 10:04:22 -0400
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20171002140422.GB4501@localhost.localdomain>
References: <20170930195345.23338-1-eblake@redhat.com>
	<20170930201121.24157-1-eblake@redhat.com>
	<20171001030357.GF4313@localhost.localdomain>
	<834de435-020b-9400-b640-af82968433dd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <834de435-020b-9400-b640-af82968433dd@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 4/4] iotests: Add test 197 for
 covering copy-on-read
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
List-ID: <qemu-devel.nongnu.org>

On Mon, Oct 02, 2017 at 08:55:50AM -0500, Eric Blake wrote:
> On 09/30/2017 10:03 PM, Jeff Cody wrote:
> > On Sat, Sep 30, 2017 at 03:11:21PM -0500, Eric Blake wrote:
> >> Add a test for qcow2 copy-on-read behavior, including exposure
> >> for the just-fixed bugs.
> >>
> >> The copy-on-read behavior is always to a qcow2 image, but the
> >> test is careful to allow running with most image protocol/format
> >> combos as the backing file being copied from (luks being the
> >> exception, as it is harder to pass the right secret to all the
> >> right places).  In fact, for './check nbd', this appears to be
> >> the first time we've had a qcow2 image wrapping NBD, requiring
> >> an additional line in _filter_img_create to match the similar
> >> line in _filter_img_info.
> >>
> >> Signed-off-by: Eric Blake <eblake@redhat.com>
> >>
> 
> >> +_cleanup()
> >> +{
> >> +    _cleanup_test_img
> >> +    rm -f "$BLKDBG_CONF"
> >> +}
> >> +trap "_cleanup; exit \$status" 0 1 2 3 15
> > 
> > 
> > Note to myself to add this to my iotests series.
> 
> Yep, and I even thought about that, since I've been pointing it out on
> other patches, but forgot to mention it when composing the email ;)
> 
> 
> >> +$QEMU_IO -c "open -C \
> >> + -o driver=blkdebug,config=$BLKDBG_CONF,image.driver=qcow2 $TEST_WRAP" \
> > 
> > Hmm, this will lead to issues if $TEST_WRAP has spaces, right?
> 
> Probably :(  Although I didn't actually test that setup
> 
> But I don't know what other options we have to work around it. As long
> as we are executing in the correct directory, I guess we can open both
> BLKDBG_CONF and TEST_WRAP relative to ./ rather than as an absolute
> path, and that should be sufficient to avoid spaces.  But I don't know
> how easy that is to achieve, or if _filter_qemu_io will handle it correctly.
> 
> Maybe I take the wimpy way out and skip the test if $PWD contains spaces
> or other problematic characters?
> 

My thought is if the operation is destructive (writes, creates, deletes) a
file, we want to make sure we do not ruin someone's day by destroying a file
(e.g. "/home/jcody/qemu work", and having /home/jcody/qemu overwritten).

Spaces in pathnames for iotests don't work currently, however.  So maybe the
proper thing to do, is for me to add to my iotests series a check for spaces
in TEST_DIR, and just refuse to run any tests at all (with an informative
reason why).  And if it is ever fixed so that tests run (and run safely)
with spaces, we can remove that restriction.

Jeff
