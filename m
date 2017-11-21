Received: from eggs.gnu.org ([2001:4830:134:3::10]:46832)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1eHBuV-0004wp-TN
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 12:00:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1eHBuM-0003gO-WD
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 12:00:35 -0500
Date: Tue, 21 Nov 2017 11:59:56 -0500
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20171121165956.GN5399@localhost.localdomain>
References: <cover.1511278397.git.jcody@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1511278397.git.jcody@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 for-2.11 0/4] Fix segfault in blockjob
 race condition
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, mreitz@redhat.com, stefanha@redhat.com, famz@redhat.com, pbonzini@redhat.com, kwolf@redhat.com

On Tue, Nov 21, 2017 at 10:38:49AM -0500, Jeff Cody wrote:
> Changes from v2 -> v3:
> -----------------------
> 
> Patch 1: Updated commit message to include why immediate cancel is
>          ok to remove (Thanks Paolo)
> 
>          Dropped useless hunk (Thanks Stefan)
> 
> 
> Patch 2: Use correct atomic primitives, and document implicit
>          assumptions (Thanks Stefan, Paolo)
> 
>         Fix spelling in commit message (Thanks Eric)
> 
> Patch 3/4: Unchanged.
> 
> 
> Changes from v1 -> v2:
> -----------------------
> 
> Patch 1: Updated docs in blockjob_int.h (Thanks Stefan)
> 
> Patch 2/3: Squashed, and used const char * to hold the __func__ name of
>            the original scheduler (Thanks Paolo)
> 
> Patch 4: Unchanged.
> 
> Patch 5: Dropped qcow format for the test, it was so slow the test times
>          out, and it doesn't add any new dimension to the test.
> 
> 
> # git-backport-diff -r qemu/master.. -u github/bz1508708
> 
> 001/4:[0003] [FC] 'blockjob: do not allow coroutine double entry or entry-after-completion'
> 002/4:[down] 'coroutine: abort if we try to schedule or enter a pending coroutine'
> 003/4:[----] [--] 'qemu-iotests: add option in common.qemu for mismatch only'
> 004/4:[0002] [FC] 'qemu-iotest: add test for blockjob coroutine race condition'
> 
> 
> This series fixes a race condition segfault when using iothreads with
> blockjobs.
> 
> The qemu iotest in this series is a reproducer, as is the reproducer
> script attached in this bug report:
> 
> https://bugzilla.redhat.com/show_bug.cgi?id=1508708
> 
> There are two additional patches to try and catch this sort of scenario
> with an abort, before a segfault or memory corruption occurs.
> 
> 
> Jeff Cody (4):
>   blockjob: do not allow coroutine double entry or
>     entry-after-completion
>   coroutine: abort if we try to schedule or enter a pending coroutine
>   qemu-iotests: add option in common.qemu for mismatch only
>   qemu-iotest: add test for blockjob coroutine race condition
> 
>  blockjob.c                     |  7 ++-
>  include/block/blockjob_int.h   |  3 +-
>  include/qemu/coroutine_int.h   |  6 +++
>  tests/qemu-iotests/200         | 99 ++++++++++++++++++++++++++++++++++++++++++
>  tests/qemu-iotests/200.out     | 14 ++++++
>  tests/qemu-iotests/common.qemu |  8 +++-
>  tests/qemu-iotests/group       |  1 +
>  util/async.c                   | 13 ++++++
>  util/qemu-coroutine-sleep.c    | 12 +++++
>  util/qemu-coroutine.c          | 13 ++++++
>  10 files changed, 172 insertions(+), 4 deletions(-)
>  create mode 100755 tests/qemu-iotests/200
>  create mode 100644 tests/qemu-iotests/200.out
> 
> -- 
> 2.9.5
> 


Thanks,

Made the change suggested by Stefan and Paolo.

Applied to my block branch:

git://github.com/codyprime/qemu-kvm-jtc block

-Jeff
