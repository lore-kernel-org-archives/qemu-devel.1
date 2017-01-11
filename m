Received: from eggs.gnu.org ([2001:4830:134:3::10]:50364)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1cRFYu-0004nw-Ti
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 04:51:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1cRFYr-0001gS-3g
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 04:51:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54570)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <drjones@redhat.com>) id 1cRFYq-0001g9-RE
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 04:51:17 -0500
Date: Wed, 11 Jan 2017 10:51:12 +0100
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20170111095112.opwd5sy6et4qdcrl@kamzik.brq.redhat.com>
References: <1484112575-13194-1-git-send-email-peterx@redhat.com>
	<1484112575-13194-2-git-send-email-peterx@redhat.com>
	<20170111090607.crlxskbvhx6seyvl@kamzik.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170111090607.crlxskbvhx6seyvl@kamzik.brq.redhat.com>
Subject: Re: [Qemu-devel] [kvm-unit-tests PATCH v5 1/2] run_tests: put logs
 into per-test file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>

On Wed, Jan 11, 2017 at 10:06:07AM +0100, Andrew Jones wrote:
> On Wed, Jan 11, 2017 at 01:29:34PM +0800, Peter Xu wrote:
> > We were using test.log before to keep all the test logs. This patch
> > creates one log file per test case under logs/ directory with name
> > "TESTNAME.log". Meanwhile, we will keep the last time log into
> > logs.old/.
> > 
> > Renaming scripts/functions.bash into scripts/common.bash to store some
> > more global variables.
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  .gitignore                              |  3 ++-
> >  Makefile                                |  5 ++---
> >  run_tests.sh                            | 18 +++++++++++-------
> >  scripts/{functions.bash => common.bash} | 13 +++++++++++--
> >  scripts/mkstandalone.sh                 |  2 +-
> >  5 files changed, 27 insertions(+), 14 deletions(-)
> >  rename scripts/{functions.bash => common.bash} (75%)
> > 
> > diff --git a/.gitignore b/.gitignore
> > index 3155418..2213b9b 100644
> > --- a/.gitignore
> > +++ b/.gitignore
> > @@ -12,7 +12,8 @@ cscope.*
> >  /lib/asm
> >  /config.mak
> >  /*-run
> > -/test.log
> >  /msr.out
> >  /tests
> >  /build-head
> > +/logs/
> > +/logs.old/
> 
> We should send a cleanup patch fixing the other dirs too someday,
> patches, /lib/asm, and /tests
> 
> > diff --git a/Makefile b/Makefile
> > index a32333b..844bacc 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -94,9 +94,8 @@ libfdt_clean:
> >  	$(LIBFDT_objdir)/.*.d
> >  
> >  distclean: clean libfdt_clean
> > -	$(RM) lib/asm config.mak $(TEST_DIR)-run test.log msr.out cscope.* \
> > -	      build-head
> > -	$(RM) -r tests
> > +	$(RM) lib/asm config.mak $(TEST_DIR)-run msr.out cscope.* build-head
> > +	$(RM) -r tests logs logs.old
> >  
> >  cscope: cscope_dirs = lib lib/libfdt lib/linux $(TEST_DIR) $(ARCH_LIBDIRS) lib/asm-generic
> >  cscope:
> > diff --git a/run_tests.sh b/run_tests.sh
> > index 254129d..b6a1059 100755
> > --- a/run_tests.sh
> > +++ b/run_tests.sh
> > @@ -7,7 +7,7 @@ if [ ! -f config.mak ]; then
> >      exit 1
> >  fi
> >  source config.mak
> > -source scripts/functions.bash
> > +source scripts/common.bash
> >  
> >  function usage()
> >  {
> > @@ -46,17 +46,21 @@ while getopts "g:hv" opt; do
> >      esac
> >  done
> >  
> > -RUNTIME_log_stderr () { cat >> test.log; }
> > +# RUNTIME_log_file will be configured later
> > +RUNTIME_log_stderr () { cat >> $RUNTIME_log_file; }
> >  RUNTIME_log_stdout () {
> >      if [ "$PRETTY_PRINT_STACKS" = "yes" ]; then
> > -        ./scripts/pretty_print_stacks.py $1 >> test.log
> > +        ./scripts/pretty_print_stacks.py $1 >> $RUNTIME_log_file
> >      else
> > -        cat >> test.log
> > +        cat >> $RUNTIME_log_file
> >      fi
> >  }
> >  
> > -
> >  config=$TEST_DIR/unittests.cfg
> > -rm -f test.log
> > -printf "BUILD_HEAD=$(cat build-head)\n\n" > test.log
> > +
> > +rm -rf $unittest_log_dir.old
> > +mv $unittest_log_dir $unittest_log_dir.old

Actually this mv can fail, but we definitely wouldn't want to error-out
like v4 did, we want to ignore it. The error is that /logs doesn't exist,
as it won't the first time run_tests.sh is run. So, we need to redirect
stderr to /dev/null on this mv to avoid the message
"mv: cannot stat 'logs': No such file or directory"
on that first run.

Thanks,
drew

> > +mkdir $unittest_log_dir
> > +echo "BUILD_HEAD=$(cat build-head)" > $unittest_log_dir/SUMMARY
> > +
> >  for_each_unittest $config run
> > diff --git a/scripts/functions.bash b/scripts/common.bash
> > similarity index 75%
> > rename from scripts/functions.bash
> > rename to scripts/common.bash
> > index ee9143c..2dd7360 100644
> > --- a/scripts/functions.bash
> > +++ b/scripts/common.bash
> > @@ -1,3 +1,12 @@
> > +: ${unittest_log_dir:=logs}
> > +
> > +function run_task()
> > +{
> > +	local testname="$2"
> > +
> > +	RUNTIME_log_file="${unittest_log_dir}/${testname}.log"
> > +	"$@"
> > +}
> >  
> >  function for_each_unittest()
> >  {
> > @@ -17,7 +26,7 @@ function for_each_unittest()
> >  
> >  	while read -u $fd line; do
> >  		if [[ "$line" =~ ^\[(.*)\]$ ]]; then
> > -			"$cmd" "$testname" "$groups" "$smp" "$kernel" "$opts" "$arch" "$check" "$accel" "$timeout"
> > +			run_task "$cmd" "$testname" "$groups" "$smp" "$kernel" "$opts" "$arch" "$check" "$accel" "$timeout"
> >  			testname=${BASH_REMATCH[1]}
> >  			smp=1
> >  			kernel=""
> > @@ -45,6 +54,6 @@ function for_each_unittest()
> >  			timeout=${BASH_REMATCH[1]}
> >  		fi
> >  	done
> > -	"$cmd" "$testname" "$groups" "$smp" "$kernel" "$opts" "$arch" "$check" "$accel" "$timeout"
> > +	run_task "$cmd" "$testname" "$groups" "$smp" "$kernel" "$opts" "$arch" "$check" "$accel" "$timeout"
> >  	exec {fd}<&-
> >  }
> > diff --git a/scripts/mkstandalone.sh b/scripts/mkstandalone.sh
> > index d2bae19..3c1938e 100755
> > --- a/scripts/mkstandalone.sh
> > +++ b/scripts/mkstandalone.sh
> > @@ -5,7 +5,7 @@ if [ ! -f config.mak ]; then
> >  	exit 1
> >  fi
> >  source config.mak
> > -source scripts/functions.bash
> > +source scripts/common.bash
> >  
> >  escape ()
> >  {
> > -- 
> > 2.7.4
> > 
> >
> 
> Reviewed-by: Andrew Jones <drjones@redhat.com>
> --
> To unsubscribe from this list: send the line "unsubscribe kvm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
