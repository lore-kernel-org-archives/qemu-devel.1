Received: from eggs.gnu.org ([2001:4830:134:3::10]:57219)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1e4oqK-0002NC-Hm
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 09:57:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1e4oqE-0003Lu-65
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 09:57:08 -0400
Date: Wed, 18 Oct 2017 09:56:52 -0400
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20171018135652.GC17962@localhost.localdomain>
References: <cover.1508257445.git.jcody@redhat.com>
	<4b9a7c197c0ed492d1efa4950c8221a1ca7652c9.1508257445.git.jcody@redhat.com>
	<facfb6c9-908b-a12c-7db8-1e1b3eb620a1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <facfb6c9-908b-a12c-7db8-1e1b3eb620a1@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 04/10] qemu-iotests: remove file cleanup
 from bash tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, jsnow@redhat.com, stefanha@redhat.com, kwolf@redhat.com

On Wed, Oct 18, 2017 at 08:46:46AM -0500, Eric Blake wrote:
> On 10/17/2017 11:31 AM, Jeff Cody wrote:
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
> >  tests/qemu-iotests/197     |  7 -------
> 
> Looks like you have rebased to the current state of the tree.  There may
> be a couple more attempting to sneak in before things get merged, but I
> trust you'll stay on top of that.
> 
> >  156 files changed, 32 insertions(+), 1023 deletions(-)
> 
> Fun diffstat, but took me a while to scan through for any mistakes.
> 
> > +++ b/tests/qemu-iotests/007
> > @@ -27,13 +27,6 @@ echo "QA output created by $seq"
> >  here=`pwd`
> >  status=1	# failure is the default!
> >  
> > -_cleanup()
> > -{
> > -	_cleanup_test_img
> > -	true
> > -}
> > -trap "_cleanup; exit \$status" 0 1 2 3 15
> 
> Interesting use of 'true' (why? Since the only call to _cleanup changes
> exit status to $status anyways, it does not matter what state $? was
> left in after _cleanup)!  Not a problem to see it disappear.
> 
> > +++ b/tests/qemu-iotests/028
> > @@ -30,14 +30,6 @@ echo "QA output created by $seq"
> >  here=`pwd`
> >  status=1	# failure is the default!
> >  
> > -_cleanup()
> > -{
> > -    _cleanup_qemu
> > -    rm -f "${TEST_IMG}.copy"
> > -    _cleanup_test_img
> > -}
> > -trap "_cleanup; exit \$status" 0 1 2 3 15
> 
> Is this removal of _cleanup_qemu correct, or does it belong in a
> different patch in the series? [1]
> 

Nice catch.  I think I had missed that instance before, and then squashed
the change into the wrong patch.  It should be in patch 6.


> > +++ b/tests/qemu-iotests/058
> > @@ -29,23 +29,22 @@ echo "QA output created by $seq"
> >  here=`pwd`
> >  status=1	# failure is the default!
> >  
> > +# get standard environment, filters and checks
> > +. ./common.rc
> > +. ./common.filter
> > +. ./common.pattern
> > +
> > +_supported_fmt qcow2
> > +_supported_proto file
> > +_supported_os Linux
> > +_require_command QEMU_NBD
> > +# Internal snapshots are (currently) impossible with refcount_bits=1
> > +_unsupported_imgopts 'refcount_bits=1[^0-9]'
> > +
> 
> Code motion...
> 
> >  nbd_unix_socket=$TEST_DIR/test_qemu_nbd_socket
> >  nbd_snapshot_img="nbd:unix:$nbd_unix_socket"
> >  rm -f "${TEST_DIR}/qemu-nbd.pid"
> >  
> > -_cleanup_nbd()
> > -{
> > -    local NBD_SNAPSHOT_PID
> > -    if [ -f "${TEST_DIR}/qemu-nbd.pid" ]; then
> > -        read NBD_SNAPSHOT_PID < "${TEST_DIR}/qemu-nbd.pid"
> > -        rm -f "${TEST_DIR}/qemu-nbd.pid"
> > -        if [ -n "$NBD_SNAPSHOT_PID" ]; then
> > -            kill "$NBD_SNAPSHOT_PID"
> > -        fi
> > -    fi
> > -    rm -f "$nbd_unix_socket"
> > -}
> 
> ...and dropping redundant code that used to be overridden by the common
> includes but now would take priority...
> 
> > -
> >  _wait_for_nbd()
> >  {
> >      for ((i = 0; i < 300; i++))
> > @@ -64,6 +63,7 @@ converted_image=$TEST_IMG.converted
> >  _export_nbd_snapshot()
> >  {
> >      _cleanup_nbd
> > +    rm -f "$nbd_unix_socket"
> >      $QEMU_NBD -v -t -k "$nbd_unix_socket" "$TEST_IMG" -l $1 &
> >      _wait_for_nbd
> >  }
> > @@ -71,30 +71,11 @@ _export_nbd_snapshot()
> >  _export_nbd_snapshot1()
> >  {
> >      _cleanup_nbd
> > +    rm -f "$nbd_unix_socket"
> 
> ...tweaks to account for the change in common ordering,
> 
> >      $QEMU_NBD -v -t -k "$nbd_unix_socket" "$TEST_IMG" -l snapshot.name=$1 &
> >      _wait_for_nbd
> >  }
> >  
> > -_cleanup()
> > -{
> > -    _cleanup_nbd
> > -    _cleanup_test_img
> > -    rm -f "$converted_image"
> > -}
> > -trap "_cleanup; exit \$status" 0 1 2 3 15
> > -
> > -# get standard environment, filters and checks
> > -. ./common.rc
> > -. ./common.filter
> > -. ./common.pattern
> > -
> > -_supported_fmt qcow2
> > -_supported_proto file
> > -_supported_os Linux
> > -_require_command QEMU_NBD
> > -# Internal snapshots are (currently) impossible with refcount_bits=1
> > -_unsupported_imgopts 'refcount_bits=1[^0-9]'
> > -
> 
> ...and back to code motion.  This file is different enough from the
> usual patterns of cleanups in the rest of the series; should some of
> this rearrangement be split into a separate patch?  But only if you have
> to respin; if we have nothing else preventing v5 from going in, I don't
> think we need the review churn.
> 

I'll do that.  We'll need a v6, there have been a couple other things you've
pointed out, and I've found a couple small bugs as well.

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
> [1] Evidence that the change to 28 may be broken.
> 
> > +++ b/tests/qemu-iotests/191
> > @@ -31,10 +31,6 @@ MIG_SOCKET="${TEST_DIR}/migrate"
> >  
> >  _cleanup()
> >  {
> > -    rm -f "${TEST_IMG}.mid"
> > -    rm -f "${TEST_IMG}.ovl2"
> > -    rm -f "${TEST_IMG}.ovl3"
> > -    _cleanup_test_img
> >      _cleanup_qemu
> >  }
> >  trap "_cleanup; exit \$status" 0 1 2 3 15
> 
> Elsewhere, you removed the _cleanup function entirely, and changed the
> trap to directly call _cleanup_qemu.  Worth doing here?
>

Yes, I think so.

> It looks like only 28 was broken, and that fix is an obvious pattern, as
> well as any other minor tweaks you want to make based on my comments.
> With that correction,
> Reviewed-by: Eric Blake <eblake@redhat.com>
> 

Thanks!
