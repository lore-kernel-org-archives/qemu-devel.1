Received: from eggs.gnu.org ([2001:4830:134:3::10]:52188)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fBBiG-0003da-3d
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 00:07:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fBBiB-0002Qi-NV
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 00:07:24 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:41837)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fBBiB-0002QU-IU
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 00:07:19 -0400
Received: by mail-qt0-x244.google.com with SMTP id d3-v6so25185118qth.8
	for <qemu-devel@nongnu.org>; Tue, 24 Apr 2018 21:07:19 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180424152405.10304-1-alex.bennee@linaro.org>
	<20180424152405.10304-15-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <ddb69b10-1bef-722c-3832-1c56b53a74a8@amsat.org>
Date: Wed, 25 Apr 2018 01:07:14 -0300
MIME-Version: 1.0
In-Reply-To: <20180424152405.10304-15-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 14/46] tests/tcg/multiarch: enable
 additional linux-test tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, peter.maydell@linaro.org, cota@braap.org, famz@redhat.com, berrange@redhat.com, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de
Cc: qemu-devel@nongnu.org

On 04/24/2018 12:23 PM, Alex Bennée wrote:
> Un-comment the remaining tests.
> 
> I removed the itimer value tests because I'm fairly sure a re-arming
> timer will always have a different value in it when you grab it.
> 
> I've also fixed up the clone thread flags as QEMU will only allow a
> clone to use flags which match glibc.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> 
> ---
> v3
>   - make clone flags match CLONE_THREAD_FLAGS
> ---
>  tests/tcg/multiarch/linux-test.c | 31 +++++++++++++++++--------------
>  1 file changed, 17 insertions(+), 14 deletions(-)
> 
> diff --git a/tests/tcg/multiarch/linux-test.c b/tests/tcg/multiarch/linux-test.c
> index 4457bd04ba..754edf9910 100644
> --- a/tests/tcg/multiarch/linux-test.c
> +++ b/tests/tcg/multiarch/linux-test.c
> @@ -16,6 +16,7 @@
>   *  You should have received a copy of the GNU General Public License
>   *  along with this program; if not, see <http://www.gnu.org/licenses/>.
>   */
> +#define _GNU_SOURCE
>  #include <stdarg.h>
>  #include <stdlib.h>
>  #include <stdio.h>
> @@ -39,6 +40,7 @@
>  #include <dirent.h>
>  #include <setjmp.h>
>  #include <sys/shm.h>
> +#include <sched.h>
>  
>  #define TESTPATH "/tmp/linux-test.tmp"
>  #define TESTPORT 7654
> @@ -58,8 +60,8 @@ static void error1(const char *filename, int line, const char *fmt, ...)
>  static int __chk_error(const char *filename, int line, int ret)
>  {
>      if (ret < 0) {
> -        error1(filename, line, "%m (ret=%d, errno=%d)",
> -               ret, errno);
> +        error1(filename, line, "%m (ret=%d, errno=%d/%s)",
> +               ret, errno, strerror(errno));
>      }
>      return ret;
>  }
> @@ -320,7 +322,6 @@ static void test_socket(void)
>      chk_error(close(server_fd));
>  }
>  
> -#if 0
>  #define WCOUNT_MAX 512
>  
>  static void test_pipe(void)
> @@ -355,7 +356,7 @@ static void test_pipe(void)
>              }
>              if (FD_ISSET(fds[1], &wfds)) {
>                  ch = 'a';
> -                chk_error(write(fds[0], &ch, 1));
> +                chk_error(write(fds[1], &ch, 1));
>                  wcount++;
>              }
>          }
> @@ -387,6 +388,9 @@ static int thread2_func(void *arg)
>      return 0;
>  }
>  
> +/* For test_clone we must match the clone flags used by glibc, see
> + * CLONE_THREAD_FLAGS in the QEMU source code.
> + */
>  void test_clone(void)
>  {
>      uint8_t *stack1, *stack2;
> @@ -394,11 +398,15 @@ void test_clone(void)
>  
>      stack1 = malloc(STACK_SIZE);
>      pid1 = chk_error(clone(thread1_func, stack1 + STACK_SIZE,
> -                           CLONE_VM | CLONE_FS | CLONE_FILES | SIGCHLD, "hello1"));
> +                           CLONE_VM | CLONE_FS | CLONE_FILES |
> +                           CLONE_SIGHAND | CLONE_THREAD | CLONE_SYSVSEM,
> +                            "hello1"));
>  
>      stack2 = malloc(STACK_SIZE);
>      pid2 = chk_error(clone(thread2_func, stack2 + STACK_SIZE,
> -                           CLONE_VM | CLONE_FS | CLONE_FILES | SIGCHLD, "hello2"));
> +                           CLONE_VM | CLONE_FS | CLONE_FILES |
> +                           CLONE_SIGHAND | CLONE_THREAD | CLONE_SYSVSEM,
> +                           "hello2"));
>  
>      while (waitpid(pid1, &status1, 0) != pid1);
>      free(stack1);
> @@ -408,7 +416,6 @@ void test_clone(void)
>          thread2_res != 6)
>          error("clone");
>  }
> -#endif
>  
>  /***********************************/
>  
> @@ -449,12 +456,10 @@ static void test_signal(void)
>      it.it_value.tv_usec = 10 * 1000;
>      chk_error(setitimer(ITIMER_REAL, &it, NULL));
>      chk_error(getitimer(ITIMER_REAL, &oit));
> -    if (oit.it_value.tv_sec != it.it_value.tv_sec ||
> -        oit.it_value.tv_usec != it.it_value.tv_usec)
> -        error("itimer");
>  
>      while (alarm_count < 5) {
>          usleep(10 * 1000);
> +        getitimer(ITIMER_REAL, &oit);
>      }
>  
>      it.it_interval.tv_sec = 0;
> @@ -463,9 +468,6 @@ static void test_signal(void)
>      it.it_value.tv_usec = 0;
>      memset(&oit, 0xff, sizeof(oit));
>      chk_error(setitimer(ITIMER_REAL, &it, &oit));
> -    if (oit.it_value.tv_sec != 0 ||
> -        oit.it_value.tv_usec != 10 * 1000)
> -        error("setitimer");
>  
>      /* SIGSEGV test */
>      act.sa_sigaction = sig_segv;
> @@ -503,10 +505,11 @@ static void test_shm(void)
>  int main(int argc, char **argv)
>  {
>      test_file();
> +    test_pipe();
>      test_fork();
>      test_time();
>      test_socket();
> -    //    test_clone();
> +    test_clone();
>      test_signal();
>      test_shm();
>      return 0;
> 
