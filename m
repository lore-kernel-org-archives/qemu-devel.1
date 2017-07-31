Received: from eggs.gnu.org ([2001:4830:134:3::10]:57751)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1dc9pC-0006vC-7R
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 08:29:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1dc9pA-0008Ok-Sz
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 08:29:30 -0400
Date: Mon, 31 Jul 2017 08:29:15 -0400
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20170731122915.GF6240@localhost.localdomain>
References: <cover.1501477080.git.jcody@redhat.com>
	<157a4bba4b5821c08110b6e2465813a4e5925e6a.1501477080.git.jcody@redhat.com>
	<8f268bae-1ec2-20af-299e-b87b342165c7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f268bae-1ec2-20af-299e-b87b342165c7@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.11 2/3] qemu-iotests: remove file
 cleanup from bash tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com, stefanha@redhat.com, jsnow@redhat.com

On Mon, Jul 31, 2017 at 07:20:03AM -0500, Eric Blake wrote:
> On 07/31/2017 12:04 AM, Jeff Cody wrote:
> > All files for a given test are now self-contained in a subdirectory,
> > and therefore the "./check" script can do all file-related cleanup
> > without any help.
> > 
> > This removes file cleanups from the bash tests.  The only cleanup left
> > is whatever is needed to kill any spawned processes; e.g. _cleanup_qemu.
> > 
> > Signed-off-by: Jeff Cody <jcody@redhat.com>
> > ---
> 
> >  tests/qemu-iotests/189     |  6 ------
> >  148 files changed, 18 insertions(+), 938 deletions(-)
> 
> Fun diffstat!
> 
> My test 190 is on Kevin's queue, presumably for 2.10; that will also
> need this cleanup.
> https://lists.gnu.org/archive/html/qemu-devel/2017-07/msg08567.html
> 
> > +++ b/tests/qemu-iotests/048
> > @@ -27,14 +27,6 @@ echo "QA output created by $seq"
> >  
> >  status=1        # failure is the default!
> >  
> > -_cleanup()
> > -{
> > -    echo "Cleanup"
> 
> Interesting outlier for being verbose about cleanup.
> 
> > -    _cleanup_test_img
> > -    rm "${TEST_IMG_FILE2}"
> > -}
> > -trap "_cleanup; exit \$status" 0 1 2 3 15
> > -
> >  _compare()
> >  {
> >      $QEMU_IMG compare $QEMU_IMG_EXTRA_ARGS "$@" "$TEST_IMG" "${TEST_IMG2}"
> > diff --git a/tests/qemu-iotests/048.out b/tests/qemu-iotests/048.out
> > index 0bcf663..3318eed 100644
> > --- a/tests/qemu-iotests/048.out
> > +++ b/tests/qemu-iotests/048.out
> > @@ -39,4 +39,3 @@ wrote 512/512 bytes at offset 512
> >  512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> >  Content mismatch at offset 512!
> >  1
> > -Cleanup
> 
> And evidence that you tested your change.
> 
> > +++ b/tests/qemu-iotests/058
> > @@ -79,7 +79,6 @@ _cleanup()
> >  {
> >      _cleanup_nbd
> >      _cleanup_test_img
> > -    rm -f "$converted_image"
> >  }
> >  trap "_cleanup; exit \$status" 0 1 2 3 15
> 
> I understand keeping _cleanup_nbd in this exit trap; but should we
> remove the _cleanup_test_img so that the temporary files can be left
> behind after 3/3?

Yes, thanks.

> 
> > +++ b/tests/qemu-iotests/085
> > @@ -37,18 +37,7 @@ snapshot_virt1="snapshot-v1.qcow2"
> >  
> >  SNAPSHOTS=10
> >  
> > -_cleanup()
> > -{
> > -    _cleanup_qemu
> > -    for i in $(seq 1 ${SNAPSHOTS})
> > -    do
> > -        rm -f "${TEST_DIR}/${i}-${snapshot_virt0}"
> > -        rm -f "${TEST_DIR}/${i}-${snapshot_virt1}"
> > -    done
> > -    rm -f "${TEST_IMG}" "${TEST_IMG}.1" "${TEST_IMG}.2" "${TEST_IMG}.base"
> > -
> > -}
> > -trap "_cleanup; exit \$status" 0 1 2 3 15
> > +trap "_cleanup_qemu; exit \$status" 0 1 2 3 15
> 
> Nice what the subdirectory lets you skip.
> 
> 
> > +++ b/tests/qemu-iotests/091
> > @@ -31,14 +31,6 @@ status=1    # failure is the default!
> >  
> >  MIG_FIFO="${TEST_DIR}/migrate"
> >  
> > -_cleanup()
> > -{
> > -    rm -f "${MIG_FIFO}"
> > -    _cleanup_qemu
> > -    _cleanup_test_img
> > -}
> > -trap "_cleanup; exit \$status" 0 1 2 3 15
> 
> Isn't _cleanup_qemu important here (especially given that you preserved
> it elsewhere)?

Yep, thanks - I missed that one.

> 
> > +++ b/tests/qemu-iotests/104
> > @@ -27,8 +27,6 @@ echo "QA output created by $seq"
> >  here=`pwd`
> >  status=1	# failure is the default!
> >  
> > -trap "exit \$status" 0 1 2 3 15
> > -
> 
> Unusual to install a trap like that.  Good riddance!
> 
> > +++ b/tests/qemu-iotests/182
> > @@ -28,11 +28,7 @@ here="$PWD"
> >  tmp=/tmp/$$
> >  status=1	# failure is the default!
> >  
> > -_cleanup()
> > -{
> > -    _cleanup_test_img
> > -}
> > -trap "_cleanup; exit \$status" 0 1 2 3 15
> > +trap "_cleanup_qemu; exit \$status" 0 1 2 3 15
> 
> Umm, why is _cleanup_qemu added?
> 

That's a good question!  Obviously that needs to go, thanks.

> Overall, looks nice. Given my comments, it will need a v2, preferably
> rebased on top of Kevin's branch (if that hasn't landed yet)
> 

Good idea.  I did the series on top of Kevin's qemu-iotest clenup series,
but I'll just rebase to his branch for v2.
