Received: from eggs.gnu.org ([2001:4830:134:3::10]:53139)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f7zqw-0007WP-5K
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 04:51:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f7zqr-0004It-T0
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 04:51:09 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:46226)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1f7zqr-0004Hu-IA
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 04:51:05 -0400
Received: by mail-wr0-x244.google.com with SMTP id d1so23609062wrj.13
	for <qemu-devel@nongnu.org>; Mon, 16 Apr 2018 01:51:05 -0700 (PDT)
References: <20180410193919.28026-1-alex.bennee@linaro.org>
	<20180410193919.28026-11-alex.bennee@linaro.org>
	<4bc22552-25b4-2a04-dc73-dc17201a2251@amsat.org>
	<3b680ef4-3304-99d5-75ef-c4d5d570bb3a@amsat.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <3b680ef4-3304-99d5-75ef-c4d5d570bb3a@amsat.org>
Date: Mon, 16 Apr 2018 09:51:02 +0100
Message-ID: <87fu3vbkll.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 10/24] tests/tcg/multiarch: Build fix
 for linux-test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org, famz@redhat.com, cota@braap.org


Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:

> On 04/15/2018 09:07 PM, Philippe Mathieu-Daud=C3=A9 wrote:
>> Hi Fam, Alex,
>>=20
>> On 04/10/2018 04:39 PM, Alex Benn=C3=A9e wrote:
>>> From: Fam Zheng <famz@redhat.com>
>>>
>>> To keep the compiler happy, and to fit in our buildsys flags:
>>>
>>> - Make local functions "static"
>>> - #ifdef out unused functions
>>> - drop cutils/osdep dependencies
>>>
>>> Signed-off-by: Fam Zheng <famz@redhat.com>
>>> [AJB: drop cutils/osdep dependencies]
>>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>> ---
>>>  tests/tcg/multiarch/linux-test.c | 68 +++++++++++++-------------------=
--------
>>>  1 file changed, 21 insertions(+), 47 deletions(-)
>>>
>>> diff --git a/tests/tcg/multiarch/linux-test.c b/tests/tcg/multiarch/lin=
ux-test.c
>>> index 5070d31446..4457bd04ba 100644
>>> --- a/tests/tcg/multiarch/linux-test.c
>>> +++ b/tests/tcg/multiarch/linux-test.c
>>> @@ -16,7 +16,6 @@
>>>   *  You should have received a copy of the GNU General Public License
>>>   *  along with this program; if not, see <http://www.gnu.org/licenses/=
>.
>>>   */
>>> -#define _GNU_SOURCE
>>>  #include <stdarg.h>
>>>  #include <stdlib.h>
>>>  #include <stdio.h>
>>> @@ -31,6 +30,7 @@
>>>  #include <utime.h>
>>>  #include <time.h>
>>>  #include <sys/time.h>
>>> +#include <sys/resource.h>
>>>  #include <sys/uio.h>
>>>  #include <sys/socket.h>
>>>  #include <netinet/in.h>
>>> @@ -39,13 +39,12 @@
>>>  #include <dirent.h>
>>>  #include <setjmp.h>
>>>  #include <sys/shm.h>
>>> -#include "qemu/cutils.h"
>>>=20=20
>>>  #define TESTPATH "/tmp/linux-test.tmp"
>>>  #define TESTPORT 7654
>>>  #define STACK_SIZE 16384
>>>=20=20
>>> -void error1(const char *filename, int line, const char *fmt, ...)
>>> +static void error1(const char *filename, int line, const char *fmt, ..=
.)
>>>  {
>>>      va_list ap;
>>>      va_start(ap, fmt);
>>> @@ -56,7 +55,7 @@ void error1(const char *filename, int line, const cha=
r *fmt, ...)
>>>      exit(1);
>>>  }
>>>=20=20
>>> -int __chk_error(const char *filename, int line, int ret)
>>> +static int __chk_error(const char *filename, int line, int ret)
>>>  {
>>>      if (ret < 0) {
>>>          error1(filename, line, "%m (ret=3D%d, errno=3D%d)",
>>> @@ -73,7 +72,7 @@ int __chk_error(const char *filename, int line, int r=
et)
>>>=20=20
>>>  #define FILE_BUF_SIZE 300
>>>=20=20
>>> -void test_file(void)
>>> +static void test_file(void)
>>>  {
>>>      int fd, i, len, ret;
>>>      uint8_t buf[FILE_BUF_SIZE];
>>> @@ -210,7 +209,7 @@ void test_file(void)
>>>      chk_error(rmdir(TESTPATH));
>>>  }
>>>=20=20
>>> -void test_fork(void)
>>> +static void test_fork(void)
>>>  {
>>>      int pid, status;
>>>=20=20
>>> @@ -224,7 +223,7 @@ void test_fork(void)
>>>          error("waitpid status=3D0x%x", status);
>>>  }
>>>=20=20
>>> -void test_time(void)
>>> +static void test_time(void)
>>>  {
>>>      struct timeval tv, tv2;
>>>      struct timespec ts, rem;
>>> @@ -251,34 +250,7 @@ void test_time(void)
>>>          error("getrusage");
>>>  }
>>>=20=20
>>> -void pstrcpy(char *buf, int buf_size, const char *str)
>>> -{
>>> -    int c;
>>> -    char *q =3D buf;
>>> -
>>> -    if (buf_size <=3D 0)
>>> -        return;
>>> -
>>> -    for(;;) {
>>> -        c =3D *str++;
>>> -        if (c =3D=3D 0 || q >=3D buf + buf_size - 1)
>>> -            break;
>>> -        *q++ =3D c;
>>> -    }
>>> -    *q =3D '\0';
>>> -}
>>> -
>>> -/* strcat and truncate. */
>>> -char *pstrcat(char *buf, int buf_size, const char *s)
>>> -{
>>> -    int len;
>>> -    len =3D strlen(buf);
>>> -    if (len < buf_size)
>>> -        pstrcpy(buf + len, buf_size - len, s);
>>> -    return buf;
>>> -}
>>> -
>>> -int server_socket(void)
>>> +static int server_socket(void)
>>>  {
>>>      int val, fd;
>>>      struct sockaddr_in sockaddr;
>>> @@ -298,7 +270,7 @@ int server_socket(void)
>>>=20=20
>>>  }
>>>=20=20
>>> -int client_socket(void)
>>> +static int client_socket(void)
>>>  {
>>>      int fd;
>>>      struct sockaddr_in sockaddr;
>>> @@ -312,9 +284,9 @@ int client_socket(void)
>>>      return fd;
>>>  }
>>>=20=20
>>> -const char socket_msg[] =3D "hello socket\n";
>>> +static const char socket_msg[] =3D "hello socket\n";
>>>=20=20
>>> -void test_socket(void)
>>> +static void test_socket(void)
>>>  {
>>>      int server_fd, client_fd, fd, pid, ret, val;
>>>      struct sockaddr_in sockaddr;
>>> @@ -348,9 +320,10 @@ void test_socket(void)
>>>      chk_error(close(server_fd));
>>>  }
>>>=20=20
>>> +#if 0
>>=20
>> Why keep this now dead code?
>
> You can use: #ifdef LINUX_TEST_CLONE
>
> But this my be even better to move this chunk as a stand-alone test in a
> new file, linux-clone-test.c and add a make rule to only include it in
> the TEST_SRCS var when the host is able to run it.

There is certainly some cleaning up to the tests to do. I'll put it in a
separate patch though.

>
>>=20
>>>  #define WCOUNT_MAX 512
>>>=20=20
>>> -void test_pipe(void)
>>> +static void test_pipe(void)
>>>  {
>>>      fd_set rfds, wfds;
>>>      int fds[2], fd_max, ret;
>>> @@ -391,10 +364,10 @@ void test_pipe(void)
>>>      chk_error(close(fds[1]));
>>>  }
>>>=20=20
>>> -int thread1_res;
>>> -int thread2_res;
>>> +static int thread1_res;
>>> +static int thread2_res;
>>>=20=20
>>> -int thread1_func(void *arg)
>>> +static int thread1_func(void *arg)
>>>  {
>>>      int i;
>>>      for(i=3D0;i<5;i++) {
>>> @@ -404,7 +377,7 @@ int thread1_func(void *arg)
>>>      return 0;
>>>  }
>>>=20=20
>>> -int thread2_func(void *arg)
>>> +static int thread2_func(void *arg)
>>>  {
>>>      int i;
>>>      for(i=3D0;i<6;i++) {
>>> @@ -435,27 +408,28 @@ void test_clone(void)
>>>          thread2_res !=3D 6)
>>>          error("clone");
>>>  }
>>> +#endif
>>>=20=20
>>>  /***********************************/
>>>=20=20
>>>  volatile int alarm_count;
>>>  jmp_buf jmp_env;
>>>=20=20
>>> -void sig_alarm(int sig)
>>> +static void sig_alarm(int sig)
>>>  {
>>>      if (sig !=3D SIGALRM)
>>>          error("signal");
>>>      alarm_count++;
>>>  }
>>>=20=20
>>> -void sig_segv(int sig, siginfo_t *info, void *puc)
>>> +static void sig_segv(int sig, siginfo_t *info, void *puc)
>>>  {
>>>      if (sig !=3D SIGSEGV)
>>>          error("signal");
>>>      longjmp(jmp_env, 1);
>>>  }
>>>=20=20
>>> -void test_signal(void)
>>> +static void test_signal(void)
>>>  {
>>>      struct sigaction act;
>>>      struct itimerval it, oit;
>>> @@ -510,7 +484,7 @@ void test_signal(void)
>>>=20=20
>>>  #define SHM_SIZE 32768
>>>=20=20
>>> -void test_shm(void)
>>> +static void test_shm(void)
>>>  {
>>>      void *ptr;
>>>      int shmid;
>>>


--=20
Alex Benn=C3=A9e
