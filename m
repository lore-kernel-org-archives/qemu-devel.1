Received: from eggs.gnu.org ([2001:4830:134:3::10]:53466)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fUTpc-0004zN-LT
	for qemu-devel@nongnu.org; Sun, 17 Jun 2018 05:18:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fUTpZ-0008KS-Ft
	for qemu-devel@nongnu.org; Sun, 17 Jun 2018 05:18:44 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:34747)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fUTpZ-0008It-6L
	for qemu-devel@nongnu.org; Sun, 17 Jun 2018 05:18:41 -0400
Received: by mail-wm0-x241.google.com with SMTP id l15-v6so11469894wmc.1
	for <qemu-devel@nongnu.org>; Sun, 17 Jun 2018 02:18:39 -0700 (PDT)
References: <20180615194705.28019-1-alex.bennee@linaro.org>
	<20180615194705.28019-13-alex.bennee@linaro.org>
	<02569193-5865-e408-86bf-7137b76b6792@amsat.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <02569193-5865-e408-86bf-7137b76b6792@amsat.org>
Date: Sun, 17 Jun 2018 10:18:36 +0100
Message-ID: <87wouxepoz.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v7 12/54] tests/tcg/multiarch: don't hard
 code paths/ports for linux-test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: cota@braap.org, famz@redhat.com, berrange@redhat.com, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de, peter.maydell@linaro.org, qemu-devel@nongnu.org


Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:

> Hi Alex,
>
> On 06/15/2018 04:46 PM, Alex Benn=C3=A9e wrote:
>> The fixed path and ports get in the way of running our tests and
>> builds in parallel. Instead of using TESTPATH we use mkdtemp() and
>> instead of a fixed port we allow the kernel to assign one and query it
>> afterwards.
>>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>  tests/tcg/multiarch/linux-test.c | 37 ++++++++++++++++----------------
>>  1 file changed, 19 insertions(+), 18 deletions(-)
>>
>> diff --git a/tests/tcg/multiarch/linux-test.c b/tests/tcg/multiarch/linu=
x-test.c
>> index 6f2c531474..3f73b96420 100644
>> --- a/tests/tcg/multiarch/linux-test.c
>> +++ b/tests/tcg/multiarch/linux-test.c
>> @@ -41,8 +41,6 @@
>>  #include <setjmp.h>
>>  #include <sys/shm.h>
>>
>> -#define TESTPATH "/tmp/linux-test.tmp"
>> -#define TESTPORT 7654
>>  #define STACK_SIZE 16384
>>
>>  static void error1(const char *filename, int line, const char *fmt, ...)
>> @@ -85,19 +83,15 @@ static void test_file(void)
>>      struct iovec vecs[2];
>>      DIR *dir;
>>      struct dirent *de;
>> +    char template[] =3D "/tmp/linux-test-XXXXXX";
>
> Since /tmp doesn't always fit, can this be:
>
>        char *tmpbase =3D getenv("TMPDIR");
>        char *template =3D g_strdup_printf("%s/qemu-test-XXXXXX",
>                                         tmpbase ? tmpbase : "/tmp");

It depends if we want to honour TMPDIR, is /tmp not likely to be there?

Either way we can't use glib functions for these tests to keep the
compilation simple.

>
>> +    char *tmpdir =3D mkdtemp(template);
>
>        g_free(template);
>
>>
>> -    /* clean up, just in case */
>> -    unlink(TESTPATH "/file1");
>> -    unlink(TESTPATH "/file2");
>> -    unlink(TESTPATH "/file3");
>> -    rmdir(TESTPATH);
>> +    chk_error(strlen(tmpdir));
>>
>>      if (getcwd(cur_dir, sizeof(cur_dir)) =3D=3D NULL)
>>          error("getcwd");
>>
>> -    chk_error(mkdir(TESTPATH, 0755));
>> -
>> -    chk_error(chdir(TESTPATH));
>> +    chk_error(chdir(tmpdir));
>>
>>      /* open/read/write/close/readv/writev/lseek */
>>
>> @@ -163,7 +157,7 @@ static void test_file(void)
>>          st.st_mtime !=3D 1000)
>>          error("stat time");
>>
>> -    chk_error(stat(TESTPATH, &st));
>> +    chk_error(stat(tmpdir, &st));
>>      if (!S_ISDIR(st.st_mode))
>>          error("stat mode");
>>
>> @@ -185,7 +179,7 @@ static void test_file(void)
>>          error("stat mode");
>>
>>      /* getdents */
>> -    dir =3D opendir(TESTPATH);
>> +    dir =3D opendir(tmpdir);
>>      if (!dir)
>>          error("opendir");
>>      len =3D 0;
>> @@ -207,7 +201,7 @@ static void test_file(void)
>>      chk_error(unlink("file3"));
>>      chk_error(unlink("file2"));
>>      chk_error(chdir(cur_dir));
>> -    chk_error(rmdir(TESTPATH));
>> +    chk_error(rmdir(tmpdir));
>>  }
>>
>>  static void test_fork(void)
>> @@ -264,7 +258,7 @@ static int server_socket(void)
>>      chk_error(setsockopt(fd, SOL_SOCKET, SO_REUSEADDR, &val, sizeof(val=
)));
>>
>>      sockaddr.sin_family =3D AF_INET;
>> -    sockaddr.sin_port =3D htons(TESTPORT);
>> +    sockaddr.sin_port =3D htons(0); /* choose random ephemeral port) */
>>      sockaddr.sin_addr.s_addr =3D 0;
>>      chk_error(bind(fd, (struct sockaddr *)&sockaddr, sizeof(sockaddr)));
>>      chk_error(listen(fd, 0));
>> @@ -272,7 +266,7 @@ static int server_socket(void)
>>
>>  }
>>
>> -static int client_socket(void)
>> +static int client_socket(uint16_t port)
>>  {
>>      int fd;
>>      struct sockaddr_in sockaddr;
>> @@ -280,7 +274,7 @@ static int client_socket(void)
>>      /* server socket */
>>      fd =3D chk_error(socket(PF_INET, SOCK_STREAM, 0));
>>      sockaddr.sin_family =3D AF_INET;
>> -    sockaddr.sin_port =3D htons(TESTPORT);
>> +    sockaddr.sin_port =3D htons(port);
>>      inet_aton("127.0.0.1", &sockaddr.sin_addr);
>>      chk_error(connect(fd, (struct sockaddr *)&sockaddr, sizeof(sockaddr=
)));
>>      return fd;
>> @@ -292,10 +286,17 @@ static void test_socket(void)
>>  {
>>      int server_fd, client_fd, fd, pid, ret, val;
>>      struct sockaddr_in sockaddr;
>> -    socklen_t len;
>> +    struct sockaddr_in server_addr;
>> +    socklen_t len, socklen;
>> +    uint16_t server_port;
>>      char buf[512];
>>
>>      server_fd =3D server_socket();
>> +    /* find out what port we got */
>> +    socklen =3D sizeof(server_addr);
>> +    ret =3D getsockname(server_fd, &server_addr, &socklen);
>> +    chk_error(ret);
>> +    server_port =3D ntohs(server_addr.sin_port);
>>
>>      /* test a few socket options */
>>      len =3D sizeof(val);
>> @@ -305,7 +306,7 @@ static void test_socket(void)
>>
>>      pid =3D chk_error(fork());
>>      if (pid =3D=3D 0) {
>> -        client_fd =3D client_socket();
>> +        client_fd =3D client_socket(server_port);
>>          send(client_fd, socket_msg, sizeof(socket_msg), 0);
>>          close(client_fd);
>>          exit(0);
>>


--
Alex Benn=C3=A9e
