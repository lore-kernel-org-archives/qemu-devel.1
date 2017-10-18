Received: from eggs.gnu.org ([2001:4830:134:3::10]:55177)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1e4fIi-0000eQ-TV
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 23:45:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1e4fIh-0007LU-Vq
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 23:45:48 -0400
Date: Tue, 17 Oct 2017 23:45:36 -0400
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20171018034536.GB17962@localhost.localdomain>
References: <cover.1508257445.git.jcody@redhat.com>
	<f2da69a9931eb356c7fbc9e91a72af03210d72a5.1508257445.git.jcody@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2da69a9931eb356c7fbc9e91a72af03210d72a5.1508257445.git.jcody@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 10/10] qemu-iotests: add support for
 running multi-threaded iotests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, jsnow@redhat.com, stefanha@redhat.com, kwolf@redhat.com, eblake@redhat.com

On Tue, Oct 17, 2017 at 12:31:55PM -0400, Jeff Cody wrote:
> This adds support for running qemu-iotests in an arbitrary number
> of sub-processes, so that tests can be run in parallel.
> 
> This necessarily changes the output format, although it should still
> be familiar.  If you run in a single thread, the output format will
> largely be the same as before this patch.
> 
> To run in more than one process, use the '-j num' option, e.g.:
>   ./check -qcow2 -j 5
> 
> Some caveats:
> 
>     * Some output format options, such as timestamps, are currently
>       not compatible with multiple jobs.  If you select multiple
>       jobs, timestamps will be disabled.
> 
>     * Some tests may be more prone to failure with multiple jobs.
>       This isn't a flaw of multiple jobs per se, but rather of
>       fragile tests.  Some tests (181, 183) are very sensitive in
>       timing, and high cpu loads can cause them to fail.  It may be
>       worth adding support for 'single-thread only' tests in subsequent
>       patches, that complete designated single-thread jobs at the end.
> 
>     * Running protocol tests multi-threaded may fail, as multiple
>       tests may try to bind the same address.
> 
> If '-j' is not specified, the default is a single iotest being run
> at a time.
> 
> Signed-off-by: Jeff Cody <jcody@redhat.com>
> ---
>  tests/qemu-iotests/check      | 427 +++++++++++++++++++++++++++++-------------
>  tests/qemu-iotests/common.rc  |   2 +-
>  tests/qemu-iotests/iotests.py |   4 +-
>  3 files changed, 297 insertions(+), 136 deletions(-)
> 
> diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
> index a66f7b0..363617e 100755
> --- a/tests/qemu-iotests/check
> +++ b/tests/qemu-iotests/check

[...]

> +
> +# Even if interrupted, we want to wait until
> +# all tests have completed, so we can properly clean
> +# up after them via _check_results
> +function _wait_to_finish()
> +{
> +    while [ $jobs_running -gt 0 ]
> +    do
> +        i=0
> +        while [ $jobs_running -gt 0 ]
> +        do
> +            job=${job_slots[$i]}
> +            if [ $job -gt 0 ]
> +            then
> +                if [ -z "$(ps -o pid -h -p $job)" ]
> +                then
> +                    _check_results ${job_seq[$i]}
> +                    job_slots[$i]=0
> +                    job_seq[$i]=-1
> +                    let jobs_running--
> +                fi
> +            fi
> +            let i++
> +            let i=`expr $i % $MAX_JOBS`
> +            sleep 0.1
> +        done
> +    done

Oops.  That double while loop, while harmless, is spurious.  When I do a v6,
I'll remove the outer one when addressing any other review comments.

 
