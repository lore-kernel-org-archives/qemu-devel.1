Received: from eggs.gnu.org ([2001:4830:134:3::10]:40890)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fqIxz-0008Cb-Nk
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 10:09:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fqIxy-000070-J0
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 10:09:35 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:36624)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1fqIxu-0008SF-QL
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 10:09:32 -0400
Received: by mail-wr1-x444.google.com with SMTP id h9-v6so4298990wro.3
	for <qemu-devel@nongnu.org>; Thu, 16 Aug 2018 07:09:29 -0700 (PDT)
MIME-Version: 1.0
References: <20180810132800.38549-1-eblake@redhat.com>
In-Reply-To: <20180810132800.38549-1-eblake@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 16 Aug 2018 16:09:17 +0200
Message-ID: <CAJ+F1CJm3Zm=vN6uiaunXoUSa6Axq4z_i+nO0KxCGJqgq9c0TQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4] tests/libqtest: Improve kill_qemu()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Fam Zheng <famz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Markus Armbruster <armbru@redhat.com>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Richard Henderson <rth@twiddle.net>

On Fri, Aug 10, 2018 at 3:28 PM Eric Blake <eblake@redhat.com> wrote:
>
> In kill_qemu() we have an assert that checks that the QEMU process
> didn't dump core:
>             assert(!WCOREDUMP(wstatus));
>
> Unfortunately the WCOREDUMP macro here means the resulting message
> is not very easy to comprehend on at least some systems:
>
> ahci-test: tests/libqtest.c:113: kill_qemu: Assertion `!(((__extension__ =
(((union { __typeof(wstatus) __in; int __i; }) { .__in =3D (wstatus) }).__i=
))) & 0x80)' failed.
>
> and it doesn't identify what signal the process took. What's more,
> WCOREDUMP is not reliable - in some cases, setrlimit() coupled with
> kernel dump settings can result in the flag not being set.  It's
> better to log ALL death by signal, instead of caring whether a core
> dump was attempted (although once we know a signal happened, also
> mentioning if a core dump is present can be helpful).
>
> Furthermore, we are NOT detecting EINTR (while EINTR shouldn't be
> happening if we didn't install signal handlers, it's still better
> to always be robust).

A nice thing about this patch is that "make check" will now return an
error when compiled with --enable-sanitizers and there are leaks
(instead of just reporting warnings).

With the few leak fixes pending merge, x86-64 ASAN make check is
clean: I wish we can enable it in our CI, to avoid regressions.

That I know of, there is at least patchew (make docker), travis, and
Peter has his own set of integration tools/build iirc.

Travis looks overloaded to me.

May I suggest to replace docker-test-clang@ubuntu by
docker-test-debug@ubuntu in patchew? (test-debug uses clang, with some
default sanitizers)

The 2 patches missing upstream for a clean x86-64 run are:
- megasas: fix sglist leak
- tests: fix bdrv-drain leak

thanks

>
> Finally, even non-signal death with a non-zero status is suspicious,
> since qemu's SIGINT handler is supposed to result in exit(0).
>
> Instead of using a raw assert, print the information in an
> easier to understand way:
>
> /i386/ahci/sanity: tests/libqtest.c:119: kill_qemu() detected QEMU death =
from signal 11 (Segmentation fault) (core dumped)
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
> v4: don't special-case death without WCOREDUMP [Markus]
> v3: use TFR() instead of open-coding the retry loop [Thomas]
> ---
>  tests/libqtest.c | 24 +++++++++++++++++++++---
>  1 file changed, 21 insertions(+), 3 deletions(-)
>
> diff --git a/tests/libqtest.c b/tests/libqtest.c
> index 098af6aec44..57cf89015e0 100644
> --- a/tests/libqtest.c
> +++ b/tests/libqtest.c
> @@ -107,10 +107,28 @@ static void kill_qemu(QTestState *s)
>          pid_t pid;
>
>          kill(s->qemu_pid, SIGTERM);
> -        pid =3D waitpid(s->qemu_pid, &wstatus, 0);
> +        TFR(pid =3D waitpid(s->qemu_pid, &wstatus, 0));
>
> -        if (pid =3D=3D s->qemu_pid && WIFSIGNALED(wstatus)) {
> -            assert(!WCOREDUMP(wstatus));
> +        assert(pid =3D=3D s->qemu_pid);
> +        /*
> +         * We expect qemu to exit with status 0; anything else is
> +         * fishy and should be logged with as much detail as possible.
> +         */
> +        if (wstatus) {
> +            if (WIFEXITED(wstatus)) {
> +                fprintf(stderr, "%s:%d: kill_qemu() tried to terminate Q=
EMU "
> +                        "process but encountered exit status %d\n",
> +                        __FILE__, __LINE__, WEXITSTATUS(wstatus));
> +            } else if (WIFSIGNALED(wstatus)) {
> +                int sig =3D WTERMSIG(wstatus);
> +                const char *signame =3D strsignal(sig) ?: "unknown ???";
> +                const char *dump =3D WCOREDUMP(wstatus) ? " (dumped core=
)" : "";
> +
> +                fprintf(stderr, "%s:%d: kill_qemu() detected QEMU death =
"
> +                        "from signal %d (%s)%s\n",
> +                        __FILE__, __LINE__, sig, signame, dump);
> +            }
> +            abort();
>          }
>      }
>  }
> --
> 2.14.4
>
>


--=20
Marc-Andr=C3=A9 Lureau
