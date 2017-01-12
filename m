Received: from eggs.gnu.org ([2001:4830:134:3::10]:50348)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cRev3-0007qA-DR
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 07:55:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cRev0-00016R-CD
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 07:55:53 -0500
Received: from mail-wj0-x244.google.com ([2a00:1450:400c:c01::244]:35039)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cRev0-00015n-3e
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 07:55:50 -0500
Received: by mail-wj0-x244.google.com with SMTP id ey1so1774680wjd.2
	for <qemu-devel@nongnu.org>; Thu, 12 Jan 2017 04:55:49 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <1484192182-13760-1-git-send-email-peterx@redhat.com>
	<1484192182-13760-3-git-send-email-peterx@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5269cdb1-ae12-31af-0e7d-7c8d2b9c6848@redhat.com>
Date: Thu, 12 Jan 2017 13:55:48 +0100
MIME-Version: 1.0
In-Reply-To: <1484192182-13760-3-git-send-email-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [kvm-unit-tests PATCH v6 2/3] run_tests: put logs
 into per-test file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, kvm@vger.kernel.org
Cc: Andrew Jones <drjones@redhat.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>



On 12/01/2017 04:36, Peter Xu wrote:
> We were using test.log before to keep all the test logs. This patch
> creates one log file per test case under logs/ directory with name
> "TESTNAME.log". Meanwhile, we will keep the last time log into
> logs.old/.
> 
> Renaming scripts/functions.bash into scripts/common.bash to store some
> more global variables.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  .gitignore                              |  3 ++-
>  Makefile                                |  5 ++---
>  run_tests.sh                            | 19 ++++++++++++-------
>  scripts/{functions.bash => common.bash} | 13 +++++++++++--
>  scripts/mkstandalone.sh                 |  2 +-
>  5 files changed, 28 insertions(+), 14 deletions(-)
>  rename scripts/{functions.bash => common.bash} (75%)
> 
> diff --git a/.gitignore b/.gitignore
> index 3155418..2213b9b 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -12,7 +12,8 @@ cscope.*
>  /lib/asm
>  /config.mak
>  /*-run
> -/test.log
>  /msr.out
>  /tests
>  /build-head
> +/logs/
> +/logs.old/
> diff --git a/Makefile b/Makefile
> index a32333b..844bacc 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -94,9 +94,8 @@ libfdt_clean:
>  	$(LIBFDT_objdir)/.*.d
>  
>  distclean: clean libfdt_clean
> -	$(RM) lib/asm config.mak $(TEST_DIR)-run test.log msr.out cscope.* \
> -	      build-head
> -	$(RM) -r tests
> +	$(RM) lib/asm config.mak $(TEST_DIR)-run msr.out cscope.* build-head
> +	$(RM) -r tests logs logs.old
>  
>  cscope: cscope_dirs = lib lib/libfdt lib/linux $(TEST_DIR) $(ARCH_LIBDIRS) lib/asm-generic
>  cscope:
> diff --git a/run_tests.sh b/run_tests.sh
> index 2cfa365..afd3d95 100755
> --- a/run_tests.sh
> +++ b/run_tests.sh
> @@ -7,7 +7,7 @@ if [ ! -f config.mak ]; then
>      exit 1
>  fi
>  source config.mak
> -source scripts/functions.bash
> +source scripts/common.bash
>  
>  function usage()
>  {
> @@ -46,17 +46,22 @@ while getopts "g:hv" opt; do
>      esac
>  done
>  
> -RUNTIME_log_stderr () { cat >> test.log; }
> +# RUNTIME_log_file will be configured later
> +RUNTIME_log_stderr () { cat >> $RUNTIME_log_file; }
>  RUNTIME_log_stdout () {
>      if [ "$PRETTY_PRINT_STACKS" = "yes" ]; then
> -        ./scripts/pretty_print_stacks.py $1 >> test.log
> +        ./scripts/pretty_print_stacks.py $1 >> $RUNTIME_log_file
>      else
> -        cat >> test.log
> +        cat >> $RUNTIME_log_file
>      fi
>  }
>  
> -
>  config=$TEST_DIR/unittests.cfg
> -rm -f test.log
> -printf "BUILD_HEAD=$(cat build-head)\n\n" > test.log
> +
> +rm -rf $unittest_log_dir.old
> +[ -d $unittest_log_dir ] && mv $unittest_log_dir $unittest_log_dir.old
> +mkdir $unittest_log_dir || exit 2
> +
> +echo "BUILD_HEAD=$(cat build-head)" > $unittest_log_dir/SUMMARY
> +
>  for_each_unittest $config run
> diff --git a/scripts/functions.bash b/scripts/common.bash
> similarity index 75%
> rename from scripts/functions.bash
> rename to scripts/common.bash
> index ee9143c..2dd7360 100644
> --- a/scripts/functions.bash
> +++ b/scripts/common.bash
> @@ -1,3 +1,12 @@
> +: ${unittest_log_dir:=logs}
> +
> +function run_task()
> +{
> +	local testname="$2"
> +
> +	RUNTIME_log_file="${unittest_log_dir}/${testname}.log"
> +	"$@"
> +}

This should go in run_tests.sh since that's the only place that uses
unittest_log_dir.  (The last line then becomes 'run "$@"' and the
for_each_unittest call must be adjusted).  Done and queued.

Paolo

>  function for_each_unittest()
>  {
> @@ -17,7 +26,7 @@ function for_each_unittest()
>  
>  	while read -u $fd line; do
>  		if [[ "$line" =~ ^\[(.*)\]$ ]]; then
> -			"$cmd" "$testname" "$groups" "$smp" "$kernel" "$opts" "$arch" "$check" "$accel" "$timeout"
> +			run_task "$cmd" "$testname" "$groups" "$smp" "$kernel" "$opts" "$arch" "$check" "$accel" "$timeout"
>  			testname=${BASH_REMATCH[1]}
>  			smp=1
>  			kernel=""
> @@ -45,6 +54,6 @@ function for_each_unittest()
>  			timeout=${BASH_REMATCH[1]}
>  		fi
>  	done
> -	"$cmd" "$testname" "$groups" "$smp" "$kernel" "$opts" "$arch" "$check" "$accel" "$timeout"
> +	run_task "$cmd" "$testname" "$groups" "$smp" "$kernel" "$opts" "$arch" "$check" "$accel" "$timeout"
>  	exec {fd}<&-
>  }
> diff --git a/scripts/mkstandalone.sh b/scripts/mkstandalone.sh
> index d2bae19..3c1938e 100755
> --- a/scripts/mkstandalone.sh
> +++ b/scripts/mkstandalone.sh
> @@ -5,7 +5,7 @@ if [ ! -f config.mak ]; then
>  	exit 1
>  fi
>  source config.mak
> -source scripts/functions.bash
> +source scripts/common.bash
>  
>  escape ()
>  {
> 
