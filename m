Received: from eggs.gnu.org ([2001:4830:134:3::10]:35947)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkrcmar@redhat.com>) id 1cO93w-0007CN-UG
	for qemu-devel@nongnu.org; Mon, 02 Jan 2017 15:18:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkrcmar@redhat.com>) id 1cO93t-0000Lk-Q2
	for qemu-devel@nongnu.org; Mon, 02 Jan 2017 15:18:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46374)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkrcmar@redhat.com>) id 1cO93t-0000LK-Jk
	for qemu-devel@nongnu.org; Mon, 02 Jan 2017 15:18:29 -0500
Date: Mon, 2 Jan 2017 21:18:24 +0100
From: Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Message-ID: <20170102201824.GA2892@potion>
References: <1483266886-25050-1-git-send-email-peterx@redhat.com>
	<1483266886-25050-3-git-send-email-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1483266886-25050-3-git-send-email-peterx@redhat.com>
Subject: Re: [Qemu-devel] [kvm-unit-tests PATCH 2/2] run_tests: allow run
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
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, Andrew Jones <drjones@redhat.com>

2017-01-01 18:34+0800, Peter Xu:
> run_task.sh is getting slow. This patch is trying to make it faster by
> running the tests concurrently.
> 
> First of all, we provide a new parameter "-j" for the run_tests.sh,
> which can be used to specify how many run queues we want for the tests.
> When "-j" is not provided, we'll keep the old behavior.
> 
> When the tests are running concurrently, we will use seperate log file
> for each test case (currently located in logs/ dir, with name
> test.TESTNAME.log), to avoid test logs messing up with each other.
> 
> A quick test on my laptop (x86 with 4 cores and 2 threads, so 8
> processors) shows 3x improvement on overall test time:
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
> diff --git a/scripts/functions.bash b/scripts/functions.bash
> @@ -1,7 +1,18 @@
> +source scripts/global.bash
> +source scripts/task.bash
> +
>  function run_task()
>  {
> -	RUNTIME_log_file=$ut_default_log_file
> -	"$@"
> +	local testname="$2"
> +
> +	if ut_in_parallel; then
> +		RUNTIME_log_file="${ut_log_dir}/test.${testname}.log"

No need for the "test." prefix.

I would do this change regardless of ut_in_parallel.  Having output of
all tests in one file just wasted time when most usecases were to find a
specific failed test.

> +		# run in background
> +		task_enqueue "$@"

Couldn't the queue be much simpler ...

> +	else
> +		RUNTIME_log_file=$ut_default_log_file
> +		"$@"
> +	fi
>  }
>  
>  function for_each_unittest()
> @@ -51,5 +62,10 @@ function for_each_unittest()
>  		fi
>  	done

... like this:

  while [ "`jobs | wc -l`" -gt $ut_run_queues ]; do
    wait
  done
  run_task "$cmd" "$testname" "$groups" "$smp" "$kernel" "$opts" "$arch" "$check" "$accel" "$timeout" &

?

(default $ut_run_queues would be 1)

>  run_task "$cmd" "$testname" "$groups" "$smp" "$kernel" "$opts" "$arch" "$check" "$accel" "$timeout"
> +
> +	if ut_in_parallel; then
> +		task_wait_all
> +	fi
> +
>  	exec {fd}<&-
>  }
