Received: from eggs.gnu.org ([2001:4830:134:3::10]:34530)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePuYQ-0002Nc-Jq
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 13:17:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePuYM-00056e-Ci
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 13:17:50 -0500
Received: from mail-qk0-x235.google.com ([2607:f8b0:400d:c09::235]:43756)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePuYM-00056D-7u
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 13:17:46 -0500
Received: by mail-qk0-x235.google.com with SMTP id j207so11420795qke.10
	for <qemu-devel@nongnu.org>; Fri, 15 Dec 2017 10:17:46 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20171215150659.1811-1-marcandre.lureau@redhat.com>
	<20171215150659.1811-6-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <f4ebb05e-0814-8fec-8eea-ed97aa90a104@amsat.org>
Date: Fri, 15 Dec 2017 15:17:42 -0300
MIME-Version: 1.0
In-Reply-To: <20171215150659.1811-6-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 05/13] tests: fix check-qobject leak:
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org

On 12/15/2017 12:06 PM, Marc-André Lureau wrote:
> /public/qobject_is_equal_conversion: OK
> 
> =================================================================
> ==14396==ERROR: LeakSanitizer: detected memory leaks
> 
> Direct leak of 56 byte(s) in 1 object(s) allocated from:
>     #0 0x7f07682c5850 in malloc (/lib64/libasan.so.4+0xde850)
>     #1 0x7f0767d12f0c in g_malloc ../glib/gmem.c:94
>     #2 0x7f0767d131cf in g_malloc_n ../glib/gmem.c:331
>     #3 0x562bd767371f in do_test_equality /home/elmarco/src/qq/tests/check-qobject.c:49
>     #4 0x562bd7674a35 in qobject_is_equal_dict_test /home/elmarco/src/qq/tests/check-qobject.c:267
>     #5 0x7f0767d37b04 in test_case_run ../glib/gtestutils.c:2237
>     #6 0x7f0767d37ec4 in g_test_run_suite_internal ../glib/gtestutils.c:2321
>     #7 0x7f0767d37f6d in g_test_run_suite_internal ../glib/gtestutils.c:2333
>     #8 0x7f0767d38184 in g_test_run_suite ../glib/gtestutils.c:2408
>     #9 0x7f0767d36e0d in g_test_run ../glib/gtestutils.c:1674
>     #10 0x562bd7674e75 in main /home/elmarco/src/qq/tests/check-qobject.c:327
>     #11 0x7f0766009039 in __libc_start_main (/lib64/libc.so.6+0x21039)
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  tests/check-qobject.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tests/check-qobject.c b/tests/check-qobject.c
> index 03e9175113..710f9e6b0a 100644
> --- a/tests/check-qobject.c
> +++ b/tests/check-qobject.c
> @@ -59,6 +59,8 @@ static void do_test_equality(bool expected, int _, ...)
>              g_assert(qobject_is_equal(args[i], args[j]) == expected);
>          }
>      }
> +
> +    g_free(args);
>  }
>  
>  #define check_equal(...) \
> 
