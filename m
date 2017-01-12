Received: from eggs.gnu.org ([2001:4830:134:3::10]:60826)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1cRdlv-0003VH-78
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 06:42:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1cRdls-0004eO-2X
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 06:42:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51844)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <drjones@redhat.com>) id 1cRdlr-0004dp-Pj
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 06:42:19 -0500
Date: Thu, 12 Jan 2017 12:42:15 +0100
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20170112114215.52xvpv22udjgrmkx@hawk.localdomain>
References: <1484192182-13760-1-git-send-email-peterx@redhat.com>
	<1484192182-13760-4-git-send-email-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1484192182-13760-4-git-send-email-peterx@redhat.com>
Subject: Re: [Qemu-devel] [kvm-unit-tests PATCH v6 3/3] run_tests: allow run
 tests in parallel
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

On Thu, Jan 12, 2017 at 11:36:22AM +0800, Peter Xu wrote:
> run_task.sh is getting slow. This patch is trying to make it faster by
> running the tests concurrently.
> 
> We provide a new parameter "-j" for the run_tests.sh, which can be used
> to specify how many run queues we want for the tests. Default queue
> length is 1, which is the old behavior.
> 
> Quick test on my laptop (4 cores, 2 threads each) shows 3x speed boost:
> 
>    |-----------------+-----------|
>    | command         | time used |
>    |-----------------+-----------|
>    | run_test.sh     | 75s       |
>    | run_test.sh -j8 | 27s       |
>    |-----------------+-----------|
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  run_tests.sh        | 12 ++++++++++--
>  scripts/common.bash | 16 +++++++++++++++-
>  2 files changed, 25 insertions(+), 3 deletions(-)
> 
> diff --git a/run_tests.sh b/run_tests.sh
> index afd3d95..4d57ff9 100755
> --- a/run_tests.sh
> +++ b/run_tests.sh
> @@ -13,10 +13,11 @@ function usage()
>  {
>  cat <<EOF
>  
> -Usage: $0 [-g group] [-h] [-v]
> +Usage: $0 [-g group] [-h] [-v] [-j num_run_queues]
>  
>      -g: Only execute tests in the given group
>      -h: Output this help text
> +    -j: Execute tests in parallel
>      -v: Enables verbose mode
>  
>  Set the environment variable QEMU=/path/to/qemu-system-ARCH to
> @@ -28,7 +29,7 @@ EOF
>  RUNTIME_arch_run="./$TEST_DIR/run"
>  source scripts/runtime.bash
>  
> -while getopts "g:hv" opt; do
> +while getopts "g:hj:v" opt; do
>      case $opt in
>          g)
>              only_group=$OPTARG
> @@ -37,6 +38,13 @@ while getopts "g:hv" opt; do
>              usage
>              exit
>              ;;
> +        j)
> +            unittest_run_queues=$OPTARG
> +            if (( $unittest_run_queues <= 0 )); then
> +                echo "Invalid -j option: $unittest_run_queues"
> +                exit 2
> +            fi
> +            ;;
>          v)
>              verbose="yes"
>              ;;
> diff --git a/scripts/common.bash b/scripts/common.bash
> index 2dd7360..9bd560f 100644
> --- a/scripts/common.bash
> +++ b/scripts/common.bash
> @@ -1,11 +1,19 @@
>  : ${unittest_log_dir:=logs}
> +: ${unittest_run_queues:=1}
>  
>  function run_task()
>  {
>  	local testname="$2"
>  
> +	while (( $(jobs | wc -l) == $unittest_run_queues )); do
> +		# wait for any background test to finish
> +		wait -n
> +	done
> +
>  	RUNTIME_log_file="${unittest_log_dir}/${testname}.log"
> -	"$@"
> +
> +	# start the testcase in the background
> +	"$@" &
>  }
>  
>  function for_each_unittest()
> @@ -22,6 +30,8 @@ function for_each_unittest()
>  	local accel
>  	local timeout
>  
> +	trap "wait; exit 130" SIGINT
> +
>  	exec {fd}<"$unittests"
>  
>  	while read -u $fd line; do
> @@ -55,5 +65,9 @@ function for_each_unittest()
>  		fi
>  	done
>  	run_task "$cmd" "$testname" "$groups" "$smp" "$kernel" "$opts" "$arch" "$check" "$accel" "$timeout"
> +
> +	# wait until all tasks finish
> +	wait
> +
>  	exec {fd}<&-
>  }
> -- 
> 2.7.4
> 
>

Reviewed-by: Andrew Jones <drjones@redhat.com> 
