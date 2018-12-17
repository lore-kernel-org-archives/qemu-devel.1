Received: from eggs.gnu.org ([2001:4830:134:3::10]:34029)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gYqJL-0007oJ-Gc
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 05:39:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gYqJI-0002yF-9r
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 05:39:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51908)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gYqJI-0002wX-2L
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 05:39:40 -0500
References: <20181217035816.21777-1-richard.henderson@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <e6ac1cea-5500-c479-389d-da99b0ac9ae5@redhat.com>
Date: Mon, 17 Dec 2018 11:39:34 +0100
MIME-Version: 1.0
In-Reply-To: <20181217035816.21777-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] tests: Exit boot-serial-test loop if child
 dies
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>

On 2018-12-17 04:58, Richard Henderson wrote:
> There's no point in waiting 5 full minutes when there will be
> no more output.

Sounds like a very good idea, indeed.

As a follow up patch, we should likely use this in the other tests that
use TCG, too (i.e. in boot_sector_test() in tests/boot-sector.c).

>  Compute timeout based on elapsed wall clock
> time instead of N * delays, as the delay is a minimum sleep time.
>=20
> Cc: Thomas Huth <thuth@redhat.com>
> Cc: Laurent Vivier <lvivier@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  tests/libqtest.h         |  8 +++++
>  tests/boot-serial-test.c | 16 +++++++--
>  tests/libqtest.c         | 70 +++++++++++++++++++++++++---------------
>  3 files changed, 65 insertions(+), 29 deletions(-)
>=20
> diff --git a/tests/libqtest.h b/tests/libqtest.h
> index 96a6c01352..9758c51be6 100644
> --- a/tests/libqtest.h
> +++ b/tests/libqtest.h
> @@ -1011,4 +1011,12 @@ bool qmp_rsp_is_err(QDict *rsp);
>   */
>  void qmp_assert_error_class(QDict *rsp, const char *class);
> =20
> +/**
> + * qtest_probe_child:
> + * @s: QTestState instance to operate on.
> + *
> + * Returns: true if the child is still alive.
> + */
> +bool qtest_probe_child(QTestState *s);
> +
>  #endif
> diff --git a/tests/boot-serial-test.c b/tests/boot-serial-test.c
> index 8ec6aed35d..54b9347325 100644
> --- a/tests/boot-serial-test.c
> +++ b/tests/boot-serial-test.c
> @@ -130,11 +130,12 @@ static testdef_t tests[] =3D {
> =20
>  static bool check_guest_output(const testdef_t *test, int fd)
>  {
> -    int i, nbr =3D 0, pos =3D 0, ccnt;
> +    int nbr =3D 0, pos =3D 0, ccnt;
> +    time_t now, start =3D time(NULL);
>      char ch;
> =20
> -    /* Poll serial output... Wait at most 360 seconds */
> -    for (i =3D 0; i < 36000; ++i) {
> +    /* Poll serial output... */
> +    while (1) {
>          ccnt =3D 0;
>          while (ccnt++ < 512 && (nbr =3D read(fd, &ch, 1)) =3D=3D 1) {
>              if (ch =3D=3D test->expect[pos]) {
> @@ -148,6 +149,15 @@ static bool check_guest_output(const testdef_t *te=
st, int fd)
>              }
>          }
>          g_assert(nbr >=3D 0);
> +        /* Wait only if the child is still alive.  */
> +        if (!qtest_probe_child(global_qtest)) {
> +            break;
> +        }
> +        /* Wait at most 360 seconds.  */
> +        now =3D time(NULL);
> +        if (now - start >=3D 360) {
> +            break;
> +        }
>          g_usleep(10000);
>      }
> =20
> diff --git a/tests/libqtest.c b/tests/libqtest.c
> index 43be078518..1d75d3c936 100644
> --- a/tests/libqtest.c
> +++ b/tests/libqtest.c
> @@ -39,10 +39,11 @@ struct QTestState
>  {
>      int fd;
>      int qmp_fd;
> +    pid_t qemu_pid;  /* our child QEMU process */
> +    int wstatus;
> +    bool big_endian;
>      bool irq_level[MAX_IRQ];
>      GString *rx;
> -    pid_t qemu_pid;  /* our child QEMU process */
> -    bool big_endian;
>  };
> =20
>  static GHookList abrt_hooks;
> @@ -96,36 +97,52 @@ static int socket_accept(int sock)
>      return ret;
>  }
> =20
> +bool qtest_probe_child(QTestState *s)
> +{
> +    pid_t pid =3D s->qemu_pid;
> +
> +    if (pid !=3D -1) {
> +        pid =3D waitpid(pid, &s->wstatus, WNOHANG);
> +        if (pid =3D=3D 0) {
> +            return true;
> +        }
> +        s->qemu_pid =3D -1;
> +    }
> +    return false;
> +}
> +
>  static void kill_qemu(QTestState *s)
>  {
> -    if (s->qemu_pid !=3D -1) {
> -        int wstatus =3D 0;
> -        pid_t pid;
> -
> -        kill(s->qemu_pid, SIGTERM);
> -        TFR(pid =3D waitpid(s->qemu_pid, &wstatus, 0));
> +    pid_t pid =3D s->qemu_pid;
> +    int wstatus;
> =20
> +    /* Skip wait if qtest_probe_child already reaped.  */
> +    if (pid !=3D -1) {
> +        kill(pid, SIGTERM);
> +        TFR(pid =3D waitpid(s->qemu_pid, &s->wstatus, 0));
>          assert(pid =3D=3D s->qemu_pid);
> -        /*
> -         * We expect qemu to exit with status 0; anything else is
> -         * fishy and should be logged with as much detail as possible.
> -         */
> -        if (wstatus) {
> -            if (WIFEXITED(wstatus)) {
> -                fprintf(stderr, "%s:%d: kill_qemu() tried to terminate=
 QEMU "
> -                        "process but encountered exit status %d\n",
> -                        __FILE__, __LINE__, WEXITSTATUS(wstatus));
> -            } else if (WIFSIGNALED(wstatus)) {
> -                int sig =3D WTERMSIG(wstatus);
> -                const char *signame =3D strsignal(sig) ?: "unknown ???=
";
> -                const char *dump =3D WCOREDUMP(wstatus) ? " (core dump=
ed)" : "";
> +    }
> =20
> -                fprintf(stderr, "%s:%d: kill_qemu() detected QEMU deat=
h "
> -                        "from signal %d (%s)%s\n",
> -                        __FILE__, __LINE__, sig, signame, dump);
> -            }
> -            abort();
> +    /*
> +     * We expect qemu to exit with status 0; anything else is
> +     * fishy and should be logged with as much detail as possible.
> +     */
> +    wstatus =3D s->wstatus;
> +    if (wstatus) {
> +        if (WIFEXITED(wstatus)) {
> +            fprintf(stderr, "%s:%d: kill_qemu() tried to terminate QEM=
U "
> +                    "process but encountered exit status %d\n",

The string is not 100% accurate now anymore - we might not have tried to
kill QEMU here since it exited earlier already. It's not that important,
but in case you respin, you could maybe adjust this text a little bit.

> +                    __FILE__, __LINE__, WEXITSTATUS(wstatus));
> +        } else if (WIFSIGNALED(wstatus)) {
> +            int sig =3D WTERMSIG(wstatus);
> +            const char *signame =3D strsignal(sig) ?: "unknown ???";
> +            const char *dump =3D WCOREDUMP(wstatus) ? " (core dumped)"=
 : "";
> +
> +            fprintf(stderr, "%s:%d: kill_qemu() detected QEMU death "
> +                    "from signal %d (%s)%s\n",
> +                    __FILE__, __LINE__, sig, signame, dump);
>          }
> +        abort();
>      }
>  }
> =20
> @@ -228,6 +245,7 @@ QTestState *qtest_init_without_qmp_handshake(const =
char *extra_args)
> =20
>      g_test_message("starting QEMU: %s", command);
> =20
> +    s->wstatus =3D 0;
>      s->qemu_pid =3D fork();
>      if (s->qemu_pid =3D=3D 0) {
>          setenv("QEMU_AUDIO_DRV", "none", true);
>=20

Patch looks fine to me, I'm going to queue this for the next qtests pull
request (unless you want to respin because of the error string or other
reasons).

Reviewed-by: Thomas Huth <thuth@redhat.com>
