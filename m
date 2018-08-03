Received: from eggs.gnu.org ([2001:4830:134:3::10]:39871)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1flcMA-0000Ha-LS
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 11:51:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1flcM7-0006PI-FL
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 11:51:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34834 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1flcM7-0006P6-9B
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 11:51:07 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180730220831.390182-1-eblake@redhat.com>
Date: Fri, 03 Aug 2018 17:51:04 +0200
In-Reply-To: <20180730220831.390182-1-eblake@redhat.com> (Eric Blake's message
	of "Mon, 30 Jul 2018 17:08:31 -0500")
Message-ID: <874lgbih3r.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 for-3.0] tests/libqtest: Improve
 kill_qemu()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, thuth@redhat.com, mst@redhat.com, f4bug@amsat.org, armbru@redhat.com, alex.bennee@linaro.org, rth@twiddle.net

Eric Blake <eblake@redhat.com> writes:

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
> Furthermore, we are NOT detecting EINTR (while EINTR shouldn't be
> happening if we didn't install signal handlers, it's still better
> to always be robust), and also want to log unexpected non-zero status
> that was not accompanied by a core dump.
>
> Instead of using a raw assert, print the information in an
> easier to understand way:
>
> /i386/ahci/sanity: tests/libqtest.c:119: kill_qemu() detected QEMU death with core dump from signal 11 (Segmentation fault)
> Aborted (core dumped)
>
> (Of course, the really useful information would be why the QEMU
> process dumped core in the first place, but we don't have that
> by the time the test program has picked up the exit status.)
>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Eric Blake <eblake@redhat.com>
>
> ---
> v3: use TFR() instead of open-coding the retry loop [Thomas]
> ---
>  tests/libqtest.c | 37 ++++++++++++++++++++++++++++++++++---
>  1 file changed, 34 insertions(+), 3 deletions(-)
>
> diff --git a/tests/libqtest.c b/tests/libqtest.c
> index 098af6aec44..3aa3e4c2a46 100644
> --- a/tests/libqtest.c
> +++ b/tests/libqtest.c
> @@ -105,12 +105,43 @@ static void kill_qemu(QTestState *s)
>      if (s->qemu_pid != -1) {
>          int wstatus = 0;
>          pid_t pid;
> +        bool die = false;
>
>          kill(s->qemu_pid, SIGTERM);
> -        pid = waitpid(s->qemu_pid, &wstatus, 0);
> +        TFR(pid = waitpid(s->qemu_pid, &wstatus, 0));
>
> -        if (pid == s->qemu_pid && WIFSIGNALED(wstatus)) {
> -            assert(!WCOREDUMP(wstatus));
> +        assert(pid == s->qemu_pid);
> +        /*
> +         * We expect qemu to exit with status 0; anything else is
> +         * fishy and should be logged.  Abort except when death by
> +         * signal is not accompanied by a coredump (as that's the only
> +         * time it was likely that the user is trying to kill the
> +         * testsuite early).
> +         */
> +        if (wstatus) {
> +            die = true;
> +            if (WIFEXITED(wstatus)) {
> +                fprintf(stderr, "%s:%d: kill_qemu() tried to terminate QEMU "
> +                        "process but encountered exit status %d\n",
> +                        __FILE__, __LINE__, WEXITSTATUS(wstatus));
> +            } else if (WIFSIGNALED(wstatus)) {
> +                int sig = WTERMSIG(wstatus);
> +                const char *signame = strsignal(sig) ?: "unknown ???";
> +
> +                if (!WCOREDUMP(wstatus)) {
> +                    die = false;
> +                    fprintf(stderr, "%s:%d: kill_qemu() ignoring QEMU death "
> +                            "by signal %d (%s)\n",
> +                            __FILE__, __LINE__, sig, signame);
> +                } else {
> +                    fprintf(stderr, "%s:%d: kill_qemu() detected QEMU death "
> +                            "with core dump from signal %d (%s)\n",
> +                            __FILE__, __LINE__, sig, signame);
> +                }
> +            }
> +        }
> +        if (die) {
> +            abort();
>          }
>      }
>  }

In review of v2, we found that WCOREDUMP() depends on the user's
environment.  I doubt we should use it this way.

Why is suppressing the abort() when "the user is trying to kill the
testsuite early" important?
