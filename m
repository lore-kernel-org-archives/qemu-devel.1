Received: from eggs.gnu.org ([2001:4830:134:3::10]:49261)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dpJiq-00048x-Fv
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 15:41:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dpJil-0006mg-E3
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 15:41:20 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:33902)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dpJil-0006mZ-98
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 15:41:15 -0400
Received: by mail-qk0-x244.google.com with SMTP id d70so2718823qkc.1
	for <qemu-devel@nongnu.org>; Tue, 05 Sep 2017 12:41:15 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170905180602.28698-1-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <3eee420b-18de-9cd3-20d1-59cc8fe5814a@amsat.org>
Date: Tue, 5 Sep 2017 16:41:09 -0300
MIME-Version: 1.0
In-Reply-To: <20170905180602.28698-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3] vhost-user: disable the *broken*
 subprocess tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, "Daniel P . Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org

not vhost-user-test, but this still failed:

ERROR:tests/rcutorture.c:388:gtest_stress: assertion failed (n_mberror 
== 0): (1 == 0)
GTester: last random seed: R02S8905ef6a0d8ed82670297d559c40e919
make: *** [check-tests/rcutorture] Error 1

CONFIG="--enable-debug --enable-debug-tcg --enable-trace-backends=log"

https://travis-ci.org/philmd/qemu/jobs/272168998

On 09/05/2017 03:06 PM, Philippe Mathieu-Daudé wrote:
> tests/vhost-user-test keeps failing on build-system since Aug 15:
> 
>    ERROR:tests/vhost-user-test.c:835:test_flags_mismatch: child process (/i386/vhost-user/flags-mismatch/subprocess [4836]) failed unexpectedly
> ...
>    ERROR:tests/vhost-user-test.c:807:test_connect_fail: child process (/x86_64/vhost-user/connect-fail/subprocess [58910]) failed unexpectedly
> 
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Suggested-by: Daniel P. Berrange <berrange@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
> v3: only disable tests using glib subprocess,
>      migrate/multiqueue/guest-mem are still tested.
> 
> v2: remove unuseful warning
> 
>   tests/vhost-user-test.c | 17 ++++++++++-------
>   1 file changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/tests/vhost-user-test.c b/tests/vhost-user-test.c
> index d4da09f147..4b98018478 100644
> --- a/tests/vhost-user-test.c
> +++ b/tests/vhost-user-test.c
> @@ -31,6 +31,8 @@
>   #include <linux/virtio_net.h>
>   #include <sys/vfs.h>
>   
> +#define VHOST_USER_NET_TESTS_WORKING 0 /* broken as of 2.10.0 */
> +
>   /* GLIB version compatibility flags */
>   #if !GLIB_CHECK_VERSION(2, 26, 0)
>   #define G_TIME_SPAN_SECOND              (G_GINT64_CONSTANT(1000000))
> @@ -472,11 +474,6 @@ static void test_server_listen(TestServer *server)
>       test_server_create_chr(server, ",server,nowait");
>   }
>   
> -static inline void test_server_connect(TestServer *server)
> -{
> -    test_server_create_chr(server, ",reconnect=1");
> -}
> -
>   #define GET_QEMU_CMD(s)                                         \
>       g_strdup_printf(QEMU_CMD, 512, 512, (root), (s)->chr_name,  \
>                       (s)->socket_path, "", (s)->chr_name)
> @@ -722,7 +719,12 @@ static void wait_for_rings_started(TestServer *s, size_t count)
>       g_mutex_unlock(&s->data_mutex);
>   }
>   
> -#ifdef CONFIG_HAS_GLIB_SUBPROCESS_TESTS
> +#if VHOST_USER_NET_TESTS_WORKING && defined(CONFIG_HAS_GLIB_SUBPROCESS_TESTS)
> +static inline void test_server_connect(TestServer *server)
> +{
> +    test_server_create_chr(server, ",reconnect=1");
> +}
> +
>   static gboolean
>   reconnect_cb(gpointer user_data)
>   {
> @@ -962,7 +964,8 @@ int main(int argc, char **argv)
>       qtest_add_data_func("/vhost-user/read-guest-mem", server, read_guest_mem);
>       qtest_add_func("/vhost-user/migrate", test_migrate);
>       qtest_add_func("/vhost-user/multiqueue", test_multiqueue);
> -#ifdef CONFIG_HAS_GLIB_SUBPROCESS_TESTS
> +
> +#if VHOST_USER_NET_TESTS_WORKING && defined(CONFIG_HAS_GLIB_SUBPROCESS_TESTS)
>       qtest_add_func("/vhost-user/reconnect/subprocess",
>                      test_reconnect_subprocess);
>       qtest_add_func("/vhost-user/reconnect", test_reconnect);
> 
