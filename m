Received: from eggs.gnu.org ([2001:4830:134:3::10]:60076)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fhGH3-0004WQ-J6
	for qemu-devel@nongnu.org; Sun, 22 Jul 2018 11:27:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fhGGz-0004ED-DW
	for qemu-devel@nongnu.org; Sun, 22 Jul 2018 11:27:53 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37826 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fhGGz-00047T-7S
	for qemu-devel@nongnu.org; Sun, 22 Jul 2018 11:27:49 -0400
Date: Sun, 22 Jul 2018 18:27:43 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180722182730-mutt-send-email-mst@kernel.org>
References: <20180720153932.8507-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180720153932.8507-1-peter.maydell@linaro.org>
Subject: Re: [Qemu-devel] [PATCH for-3.0 ?] tests/libqtest: Improve
 kill_qemu() assert
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, patches@linaro.org

On Fri, Jul 20, 2018 at 04:39:32PM +0100, Peter Maydell wrote:
> In kill_qemu() we have an assert that checks that the QEMU process
> didn't dump core:
>             assert(!WCOREDUMP(wstatus));
> 
> Unfortunately the WCOREDUMP macro here means the resulting message
> is not very easy to comprehend on at least some systems:
> 
> ahci-test: tests/libqtest.c:113: kill_qemu: Assertion `!(((__extension__ (((union { __typeof(wstatus) __in; int __i; }) { .__in = (wstatus) }).__i))) & 0x80)' failed.
> 
> and it doesn't identify what signal the process took.
> 
> Instead of using a raw assert, print the information in an
> easier to understand way:
> 
> /i386/ahci/sanity: libqtest.c: kill_qemu() tried to terminate QEMU process but it dumped core with signal 11
> ahci-test: tests/libqtest.c:118: kill_qemu: Assertion `0' failed.
> Aborted (core dumped)
> 
> (Of course, the really useful information would be why the QEMU
> process dumped core in the first place, but we don't have that
> by the time the test program has picked up the exit status.)
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

Up to you whether to apply in 3.0.

> ---
> In particular, the travis test config that enables gprof
> seems to (a) run into this every so often and (b) have the
> really unhelpful assertion text quoted above:
>  https://travis-ci.org/qemu/qemu/jobs/406192798
> 
> Maybe for 3.0 since it's only test code.
> 
>  tests/libqtest.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/libqtest.c b/tests/libqtest.c
> index 098af6aec44..99341e1b47d 100644
> --- a/tests/libqtest.c
> +++ b/tests/libqtest.c
> @@ -110,7 +110,13 @@ static void kill_qemu(QTestState *s)
>          pid = waitpid(s->qemu_pid, &wstatus, 0);
>  
>          if (pid == s->qemu_pid && WIFSIGNALED(wstatus)) {
> -            assert(!WCOREDUMP(wstatus));
> +            if (WCOREDUMP(wstatus)) {
> +                fprintf(stderr,
> +                        "libqtest.c: kill_qemu() tried to terminate QEMU "
> +                        "process but it dumped core with signal %d\n",
> +                        WTERMSIG(wstatus));
> +                assert(0);
> +            }
>          }
>      }
>  }
> -- 
> 2.17.1
