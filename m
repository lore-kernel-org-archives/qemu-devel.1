Received: from eggs.gnu.org ([2001:4830:134:3::10]:59711)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cRW1v-00066J-33
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 22:26:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cRW1q-0000mB-EK
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 22:26:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46088)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cRW1q-0000lI-57
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 22:26:18 -0500
Date: Thu, 12 Jan 2017 11:26:10 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170112032610.GI4450@pxdev.xzpeter.org>
References: <1484112575-13194-1-git-send-email-peterx@redhat.com>
	<1484112575-13194-3-git-send-email-peterx@redhat.com>
	<20170111110023.hg25ouwqf3mtrxr6@kamzik.brq.redhat.com>
	<20170111130934.q4rgy6g2ysjwvcay@kamzik.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170111130934.q4rgy6g2ysjwvcay@kamzik.brq.redhat.com>
Subject: Re: [Qemu-devel] [kvm-unit-tests PATCH v5 2/2] run_tests: allow run
 tests in parallel
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Jones <drjones@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, kvm@vger.kernel.org, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>

On Wed, Jan 11, 2017 at 02:09:34PM +0100, Andrew Jones wrote:
> On Wed, Jan 11, 2017 at 12:00:23PM +0100, Andrew Jones wrote:
> > On Wed, Jan 11, 2017 at 01:29:35PM +0800, Peter Xu wrote:
> > > run_task.sh is getting slow. This patch is trying to make it faster by
> > > running the tests concurrently.
> > > 
> > > We provide a new parameter "-j" for the run_tests.sh, which can be used
> > > to specify how many run queues we want for the tests. Default queue
> > > length is 1, which is the old behavior.
> > > 
> > > Quick test on my laptop (4 cores, 2 threads each) shows 3x speed boost:
> > > 
> > >    |-----------------+-----------|
> > >    | command         | time used |
> > >    |-----------------+-----------|
> > >    | run_test.sh     | 75s       |
> > >    | run_test.sh -j8 | 27s       |
> > >    |-----------------+-----------|
> > > 
> > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > > ---
> > >  run_tests.sh        | 12 ++++++++++--
> > >  scripts/common.bash | 16 +++++++++++++++-
> > >  2 files changed, 25 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/run_tests.sh b/run_tests.sh
> > > index b6a1059..477d4fb 100755
> > > --- a/run_tests.sh
> > > +++ b/run_tests.sh
> > > @@ -13,10 +13,11 @@ function usage()
> > >  {
> > >  cat <<EOF
> > >  
> > > -Usage: $0 [-g group] [-h] [-v]
> > > +Usage: $0 [-g group] [-h] [-v] [-j num_run_queues]
> > >  
> > >      -g: Only execute tests in the given group
> > >      -h: Output this help text
> > > +    -j: Execute tests in parallel
> > >      -v: Enables verbose mode
> > >  
> > >  Set the environment variable QEMU=/path/to/qemu-system-ARCH to
> > > @@ -28,7 +29,7 @@ EOF
> > >  RUNTIME_arch_run="./$TEST_DIR/run"
> > >  source scripts/runtime.bash
> > >  
> > > -while getopts "g:hv" opt; do
> > > +while getopts "g:hj:v" opt; do
> > >      case $opt in
> > >          g)
> > >              only_group=$OPTARG
> > > @@ -37,6 +38,13 @@ while getopts "g:hv" opt; do
> > >              usage
> > >              exit
> > >              ;;
> > > +        j)
> > > +            unittest_run_queues=$OPTARG
> > > +            if (( $unittest_run_queues <= 0 )); then
> > > +                echo "Invalid -j option: $unittest_run_queues"
> > > +                exit 1
> > 
> > We should probably use 'exit 2' here, and below in the *) case.

Will fix this one first, with another one line patch for the below one
(we can either take that new one, or squash it into this patch).

> > 
> > > +            fi
> > > +            ;;
> > >          v)
> > >              verbose="yes"
> > >              ;;
> > > diff --git a/scripts/common.bash b/scripts/common.bash
> > > index 2dd7360..ef103ee 100644
> > > --- a/scripts/common.bash
> > > +++ b/scripts/common.bash
> > > @@ -1,11 +1,19 @@
> > >  : ${unittest_log_dir:=logs}
> > > +: ${unittest_run_queues:=1}
> > >  
> > >  function run_task()
> > >  {
> > >  	local testname="$2"
> > >  
> > > +	while (( $(jobs | wc -l) == $unittest_run_queues )); do
> > > +		# wait for any background test to finish
> > > +		wait -n
> > > +	done
> > > +
> > >  	RUNTIME_log_file="${unittest_log_dir}/${testname}.log"
> > > -	"$@"
> > > +
> > > +	# start the testcase in the background
> > > +	"$@" &
> > 
> > If you check the logs before and after applying this patch series you'll
> > see a bunch of "stty: 'standard input': Inappropriate ioctl for device"
> > are now present. These messages come from the stty calls in run_qemu,
> > which we need to avoid the loss of terminal echo when QEMU aborts. We
> > can get rid of these new "inappropriate ioctl" messages by changing the
> > above line to
> > 
> >  "$@" <$(tty) &
> 
> Actually I just came up with a better solution for this. Since we don't
> need input to our unit tests, i.e. we never attempt to read from the
> serial port within them, then we can just use /dev/null for stdin. That
> allows us to leave your code above alone, and also remove the stty stuff
> in run_qemu. I'll send a patch.

Thanks, then I'll keep it as it is.

> 
> drew
> 
> > 
> > 
> > >  }
> > >  
> > >  function for_each_unittest()
> > > @@ -22,6 +30,8 @@ function for_each_unittest()
> > >  	local accel
> > >  	local timeout
> > >  
> > > +	trap "wait; exit 130" SIGINT
> > > +
> > >  	exec {fd}<"$unittests"
> > >  
> > >  	while read -u $fd line; do
> > > @@ -55,5 +65,9 @@ function for_each_unittest()
> > >  		fi
> > >  	done
> > >  	run_task "$cmd" "$testname" "$groups" "$smp" "$kernel" "$opts" "$arch" "$check" "$accel" "$timeout"
> > > +
> > > +	# wait until all task finish
> > 
> > Still not quite right :-)  s/task/tasks/

Sorry! Fixing up.

-- peterx
