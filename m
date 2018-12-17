Received: from eggs.gnu.org ([2001:4830:134:3::10]:37274)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gYqcD-0002Y7-CA
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 05:59:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gYqVy-00052H-L9
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 05:52:50 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36870)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gYqVw-0004zr-Lx
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 05:52:46 -0500
Received: by mail-wr1-f67.google.com with SMTP id s12so11323297wrt.4
	for <qemu-devel@nongnu.org>; Mon, 17 Dec 2018 02:52:42 -0800 (PST)
References: <20181217035816.21777-1-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <fb23fabe-4f49-0ef1-2f0d-9e509665e7ec@redhat.com>
Date: Mon, 17 Dec 2018 11:52:40 +0100
MIME-Version: 1.0
In-Reply-To: <20181217035816.21777-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>

On 12/17/18 4:58 AM, Richard Henderson wrote:
> There's no point in waiting 5 full minutes when there will be
> no more output.  Compute timeout based on elapsed wall clock
> time instead of N * delays, as the delay is a minimum sleep time.
> 
> Cc: Thomas Huth <thuth@redhat.com>
> Cc: Laurent Vivier <lvivier@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  tests/libqtest.h         |  8 +++++
>  tests/boot-serial-test.c | 16 +++++++--
>  tests/libqtest.c         | 70 +++++++++++++++++++++++++---------------
>  3 files changed, 65 insertions(+), 29 deletions(-)
> 
> diff --git a/tests/libqtest.h b/tests/libqtest.h
> index 96a6c01352..9758c51be6 100644
> --- a/tests/libqtest.h
> +++ b/tests/libqtest.h
> @@ -1011,4 +1011,12 @@ bool qmp_rsp_is_err(QDict *rsp);
>   */
>  void qmp_assert_error_class(QDict *rsp, const char *class);
>  
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
> @@ -130,11 +130,12 @@ static testdef_t tests[] = {
>  
>  static bool check_guest_output(const testdef_t *test, int fd)
>  {
> -    int i, nbr = 0, pos = 0, ccnt;
> +    int nbr = 0, pos = 0, ccnt;
> +    time_t now, start = time(NULL);
>      char ch;
>  
> -    /* Poll serial output... Wait at most 360 seconds */
> -    for (i = 0; i < 36000; ++i) {
> +    /* Poll serial output... */
> +    while (1) {
>          ccnt = 0;
>          while (ccnt++ < 512 && (nbr = read(fd, &ch, 1)) == 1) {
>              if (ch == test->expect[pos]) {
> @@ -148,6 +149,15 @@ static bool check_guest_output(const testdef_t *test, int fd)
>              }
>          }
>          g_assert(nbr >= 0);
> +        /* Wait only if the child is still alive.  */
> +        if (!qtest_probe_child(global_qtest)) {
> +            break;
> +        }
> +        /* Wait at most 360 seconds.  */
> +        now = time(NULL);
> +        if (now - start >= 360) {
> +            break;
> +        }
>          g_usleep(10000);
>      }
>  
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
>  
>  static GHookList abrt_hooks;
> @@ -96,36 +97,52 @@ static int socket_accept(int sock)
>      return ret;
>  }
>  
> +bool qtest_probe_child(QTestState *s)
> +{
> +    pid_t pid = s->qemu_pid;
> +
> +    if (pid != -1) {
> +        pid = waitpid(pid, &s->wstatus, WNOHANG);
> +        if (pid == 0) {
> +            return true;
> +        }
> +        s->qemu_pid = -1;
> +    }
> +    return false;
> +}
> +
>  static void kill_qemu(QTestState *s)
>  {
> -    if (s->qemu_pid != -1) {
> -        int wstatus = 0;
> -        pid_t pid;
> -
> -        kill(s->qemu_pid, SIGTERM);
> -        TFR(pid = waitpid(s->qemu_pid, &wstatus, 0));
> +    pid_t pid = s->qemu_pid;
> +    int wstatus;
>  
> +    /* Skip wait if qtest_probe_child already reaped.  */
> +    if (pid != -1) {
> +        kill(pid, SIGTERM);
> +        TFR(pid = waitpid(s->qemu_pid, &s->wstatus, 0));
>          assert(pid == s->qemu_pid);
> -        /*
> -         * We expect qemu to exit with status 0; anything else is
> -         * fishy and should be logged with as much detail as possible.
> -         */
> -        if (wstatus) {
> -            if (WIFEXITED(wstatus)) {
> -                fprintf(stderr, "%s:%d: kill_qemu() tried to terminate QEMU "
> -                        "process but encountered exit status %d\n",
> -                        __FILE__, __LINE__, WEXITSTATUS(wstatus));
> -            } else if (WIFSIGNALED(wstatus)) {
> -                int sig = WTERMSIG(wstatus);
> -                const char *signame = strsignal(sig) ?: "unknown ???";
> -                const char *dump = WCOREDUMP(wstatus) ? " (core dumped)" : "";
> +    }
>  
> -                fprintf(stderr, "%s:%d: kill_qemu() detected QEMU death "
> -                        "from signal %d (%s)%s\n",
> -                        __FILE__, __LINE__, sig, signame, dump);
> -            }
> -            abort();
> +    /*
> +     * We expect qemu to exit with status 0; anything else is
> +     * fishy and should be logged with as much detail as possible.
> +     */
> +    wstatus = s->wstatus;
> +    if (wstatus) {
> +        if (WIFEXITED(wstatus)) {
> +            fprintf(stderr, "%s:%d: kill_qemu() tried to terminate QEMU "
> +                    "process but encountered exit status %d\n",
> +                    __FILE__, __LINE__, WEXITSTATUS(wstatus));
> +        } else if (WIFSIGNALED(wstatus)) {
> +            int sig = WTERMSIG(wstatus);
> +            const char *signame = strsignal(sig) ?: "unknown ???";
> +            const char *dump = WCOREDUMP(wstatus) ? " (core dumped)" : "";
> +
> +            fprintf(stderr, "%s:%d: kill_qemu() detected QEMU death "
> +                    "from signal %d (%s)%s\n",
> +                    __FILE__, __LINE__, sig, signame, dump);
>          }
> +        abort();
>      }
>  }
>  
> @@ -228,6 +245,7 @@ QTestState *qtest_init_without_qmp_handshake(const char *extra_args)
>  
>      g_test_message("starting QEMU: %s", command);
>  
> +    s->wstatus = 0;
>      s->qemu_pid = fork();
>      if (s->qemu_pid == 0) {
>          setenv("QEMU_AUDIO_DRV", "none", true);
> 
