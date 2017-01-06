Received: from eggs.gnu.org ([2001:4830:134:3::10]:58419)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1cPVhG-0000X5-BG
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 09:40:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1cPVhF-0008Fe-B8
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 09:40:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34800)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <drjones@redhat.com>) id 1cPVhF-0008Eq-2A
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 09:40:45 -0500
Date: Fri, 6 Jan 2017 15:40:41 +0100
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20170106144041.3ruyijfgwlpqpfei@kamzik.brq.redhat.com>
References: <1483673581-7843-1-git-send-email-peterx@redhat.com>
	<1483673581-7843-3-git-send-email-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1483673581-7843-3-git-send-email-peterx@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [kvm-unit-tests PATCH v3 2/2] run_tests: allow run
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

On Fri, Jan 06, 2017 at 11:33:01AM +0800, Peter Xu wrote:
> run_task.sh is getting slow. This patch is trying to make it faster by
> running the tests concurrently.
>=20
> We provide a new parameter "-j" for the run_tests.sh, which can be used
> to specify how many run queues we want for the tests. Default queue
> length is 1, which is the old behavior.
>=20
> Quick test on my laptop (4 cores, 2 threads each) shows 3x speed boost:
>=20
>    |-----------------+-----------|
>    | command         | time used |
>    |-----------------+-----------|
>    | run_test.sh     | 75s       |
>    | run_test.sh -j8 | 27s       |
>    |-----------------+-----------|
>=20
> Suggested-by: Radim Kr=C4=8Dm=C3=A1=C5=99 <rkrcmar@redhat.com>

Radim suggested how to implement this, but not the idea of implementing
it. The suggested-by tag is for ideas, not the code, and the idea (which
is a good one) was yours, not Radim's. So the above tag should be removed=
.
It's hard to credit Radim for his help here. Adding a signed-off-by to
indicate co-authorship is probably the best you can do. Of course he's
the maintainer and will add that when he merges anyway though...

> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  run_tests.sh           | 12 ++++++++++--
>  scripts/functions.bash | 17 ++++++++++++++++-
>  scripts/global.bash    | 11 +++++++++++
>  3 files changed, 37 insertions(+), 3 deletions(-)
>=20
> diff --git a/run_tests.sh b/run_tests.sh
> index e1bb3a6..a4fc895 100755
> --- a/run_tests.sh
> +++ b/run_tests.sh
> @@ -14,10 +14,11 @@ function usage()
>  {
>  cat <<EOF
> =20
> -Usage: $0 [-g group] [-h] [-v]
> +Usage: $0 [-g group] [-h] [-v] [-j N]

s/N/num_run_queues/

> =20
>      -g: Only execute tests in the given group
>      -h: Output this help text
> +    -j: Execute tests in parallel
>      -v: Enables verbose mode
> =20
>  Set the environment variable QEMU=3D/path/to/qemu-system-ARCH to
> @@ -29,7 +30,7 @@ EOF
>  RUNTIME_arch_run=3D"./$TEST_DIR/run"
>  source scripts/runtime.bash
> =20
> -while getopts "g:hv" opt; do
> +while getopts "g:hj:v" opt; do
>      case $opt in
>          g)
>              only_group=3D$OPTARG
> @@ -38,6 +39,13 @@ while getopts "g:hv" opt; do
>              usage
>              exit
>              ;;
> +        j)
> +            ut_run_queues=3D$OPTARG
> +            if ! is_number "$ut_run_queues"; then
> +                echo "Invalid -j option: $ut_run_queues"
> +                exit 1
> +            fi

Instead of adding is_number() and just checking for numeric
input, I'd check the input is > 0. A string input resolves
as zero when treated as a number, so it'll fail too.

> +            ;;
>          v)
>              verbose=3D"yes"
>              ;;
> diff --git a/scripts/functions.bash b/scripts/functions.bash
> index d1d2e1c..c6281f4 100644
> --- a/scripts/functions.bash
> +++ b/scripts/functions.bash
> @@ -1,9 +1,18 @@
> +source scripts/global.bash
> +
>  function run_task()
>  {
>  	local testname=3D"$2"
> =20
> +	while [[ "$(jobs | wc -l)" =3D=3D $ut_run_queues ]]; do

Bash arithmetic expressions should use (( ... )) instead
of [[ ... ]]

> +		# wait for any background test to finish
> +		wait -n
> +	done
> +
>  	RUNTIME_log_file=3D"${ut_log_dir}/${testname}.log"
> -	"$@"
> +
> +	# start the testcase in the background
> +	"$@" &
>  }
> =20
>  function for_each_unittest()
> @@ -20,6 +29,8 @@ function for_each_unittest()
>  	local accel
>  	local timeout
> =20
> +	trap "wait; exit 130" SIGINT
> +
>  	exec {fd}<"$unittests"
> =20
>  	while read -u $fd line; do
> @@ -53,5 +64,9 @@ function for_each_unittest()
>  		fi
>  	done
>  	run_task "$cmd" "$testname" "$groups" "$smp" "$kernel" "$opts" "$arch=
" "$check" "$accel" "$timeout"
> +
> +	# wait all task finish
> +	wait
> +
>  	exec {fd}<&-
>  }
> diff --git a/scripts/global.bash b/scripts/global.bash
> index 77b0b29..52095bd 100644
> --- a/scripts/global.bash
> +++ b/scripts/global.bash
> @@ -1,2 +1,13 @@
>  : ${ut_log_dir:=3Dlogs}
>  : ${ut_log_summary:=3D${ut_log_dir}/SUMMARY}
> +: ${ut_run_queues:=3D1}
> +
> +function ut_in_parallel()
> +{
> +    [[ $ut_run_queues !=3D 1 ]]
> +}

I don't see any users of ut_in_parallel. Anyway I'd drop it
and open code the condition, with ((...)), when needed.

> +
> +function is_number()
> +{
> +    [[ "$1" =3D~ ^[0-9]+$ ]]
> +}
> --=20
> 2.7.4
>=20
>=20

Thanks,
drew
