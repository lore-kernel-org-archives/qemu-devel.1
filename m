Received: from eggs.gnu.org ([2001:4830:134:3::10]:35603)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1diou5-0003zB-4z
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 17:34:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1diou0-0000kC-59
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 17:34:05 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:33345)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1diou0-0000k4-1x
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 17:34:00 -0400
Received: by mail-qt0-x244.google.com with SMTP id 57so523635qtu.0
	for <qemu-devel@nongnu.org>; Fri, 18 Aug 2017 14:33:59 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170818211542.5380-1-eblake@redhat.com>
	<20170818211542.5380-4-eblake@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <d9426d9a-d309-94f4-dafa-2192515356a1@amsat.org>
Date: Fri, 18 Aug 2017 18:33:57 -0300
MIME-Version: 1.0
In-Reply-To: <20170818211542.5380-4-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v5 03/13] libqtest: Remove dead
 qtest_instances variable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com

On 08/18/2017 06:15 PM, Eric Blake wrote:
> Prior to commit 063c23d9, we were tracking a list of parallel
> qtest objects, in order to safely clean up a SIGABRT handler
> only after the last connection quits.  But when we switched to
> more of glib's infrastructure, the list became dead code that
> is never assigned to.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>   tests/libqtest.c | 6 +-----
>   1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/tests/libqtest.c b/tests/libqtest.c
> index b9a1f180e1..3f956f09fc 100644
> --- a/tests/libqtest.c
> +++ b/tests/libqtest.c
> @@ -42,7 +42,6 @@ struct QTestState
>   };
> 
>   static GHookList abrt_hooks;
> -static GList *qtest_instances;
>   static struct sigaction sigact_old;
> 
>   #define g_assert_no_errno(ret) do { \
> @@ -240,13 +239,10 @@ QTestState *qtest_init(const char *extra_args)
> 
>   void qtest_quit(QTestState *s)
>   {
> -    qtest_instances = g_list_remove(qtest_instances, s);
>       g_hook_destroy_link(&abrt_hooks, g_hook_find_data(&abrt_hooks, TRUE, s));
> 
>       /* Uninstall SIGABRT handler on last instance */
> -    if (!qtest_instances) {
> -        cleanup_sigabrt_handler();
> -    }
> +    cleanup_sigabrt_handler();
> 
>       kill_qemu(s);
>       close(s->fd);
> 
