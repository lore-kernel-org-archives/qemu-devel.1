Received: from eggs.gnu.org ([2001:4830:134:3::10]:46817)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fhYYe-0007Lk-6c
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 06:59:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fhYYZ-00043v-Va
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 06:59:16 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:38268)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fhYYZ-000435-Mh
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 06:59:11 -0400
Received: by mail-wr1-x441.google.com with SMTP id v14-v6so249781wro.5
	for <qemu-devel@nongnu.org>; Mon, 23 Jul 2018 03:59:11 -0700 (PDT)
References: <20180720153932.8507-1-peter.maydell@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180720153932.8507-1-peter.maydell@linaro.org>
Date: Mon, 23 Jul 2018 11:59:09 +0100
Message-ID: <87muuitdz6.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, patches@linaro.org


Peter Maydell <peter.maydell@linaro.org> writes:

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
> and it doesn't identify what signal the process took.
>
> Instead of using a raw assert, print the information in an
> easier to understand way:
>
> /i386/ahci/sanity: libqtest.c: kill_qemu() tried to terminate QEMU proces=
s but it dumped core with signal 11
> ahci-test: tests/libqtest.c:118: kill_qemu: Assertion `0' failed.
> Aborted (core dumped)
>
> (Of course, the really useful information would be why the QEMU
> process dumped core in the first place, but we don't have that
> by the time the test program has picked up the exit status.)
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
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
>          pid =3D waitpid(s->qemu_pid, &wstatus, 0);
>
>          if (pid =3D=3D s->qemu_pid && WIFSIGNALED(wstatus)) {
> -            assert(!WCOREDUMP(wstatus));
> +            if (WCOREDUMP(wstatus)) {
> +                fprintf(stderr,
> +                        "libqtest.c: kill_qemu() tried to terminate QEMU=
 "
> +                        "process but it dumped core with signal %d\n",
> +                        WTERMSIG(wstatus));
> +                assert(0);
> +            }

I had something similar but I added a:

+            if (WCOREDUMP(wstatus)) {
+                   fprintf(stderr, "Child QEMU (%s) dumped core\n", getenv=
("QTEST_QEMU_BINARY"));
+                   abort();
+            }

So I could tell which QEMU was the one that was crashing. As you are
asserting you can drop the filename/function stuff or use __file__ and
__func__ instead. Anyway it is an improvement on what we have now so:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>


>          }
>      }
>  }


--
Alex Benn=C3=A9e
