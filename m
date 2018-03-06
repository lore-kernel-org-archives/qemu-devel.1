Received: from eggs.gnu.org ([2001:4830:134:3::10]:39948)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1etLpg-0007GB-Ie
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 18:17:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1etLpb-0000GT-J8
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 18:17:20 -0500
Received: from mail-wr0-x22d.google.com ([2a00:1450:400c:c0c::22d]:44019)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1etLpb-0000EN-9X
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 18:17:15 -0500
Received: by mail-wr0-x22d.google.com with SMTP id u49so301266wrc.10
	for <qemu-devel@nongnu.org>; Tue, 06 Mar 2018 15:17:15 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180306170959.3921-1-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <e6e225ad-541b-823e-1776-56ccc2a7df67@amsat.org>
Date: Tue, 6 Mar 2018 20:17:12 -0300
MIME-Version: 1.0
In-Reply-To: <20180306170959.3921-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] migration: fix minor finalize leak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>

On 03/06/2018 02:09 PM, Marc-André Lureau wrote:
> Spotted thanks to ASAN:
> QTEST_QEMU_BINARY=x86_64-softmmu/qemu-system-x86_64 tests/migration-test -p /x86_64/migration/bad_dest
> 
> ==30302==ERROR: LeakSanitizer: detected memory leaks
> 
> Direct leak of 48 byte(s) in 1 object(s) allocated from:
>     #0 0x7f60efba1a38 in __interceptor_calloc (/lib64/libasan.so.4+0xdea38)
>     #1 0x7f60eef3cf75 in g_malloc0 ../glib/gmem.c:124
>     #2 0x55ca9094702c in error_copy /home/elmarco/src/qemu/util/error.c:203
>     #3 0x55ca9037a30f in migrate_set_error /home/elmarco/src/qemu/migration/migration.c:1139
>     #4 0x55ca9037a462 in migrate_fd_error /home/elmarco/src/qemu/migration/migration.c:1150
>     #5 0x55ca9038162b in migrate_fd_connect /home/elmarco/src/qemu/migration/migration.c:2411
>     #6 0x55ca90386e41 in migration_channel_connect /home/elmarco/src/qemu/migration/channel.c:81
>     #7 0x55ca9038335e in socket_outgoing_migration /home/elmarco/src/qemu/migration/socket.c:85
>     #8 0x55ca9083dd3a in qio_task_complete /home/elmarco/src/qemu/io/task.c:142
>     #9 0x55ca9083d6cc in gio_task_thread_result /home/elmarco/src/qemu/io/task.c:88
>     #10 0x7f60eef37317 in g_idle_dispatch ../glib/gmain.c:5552
>     #11 0x7f60eef3490b in g_main_dispatch ../glib/gmain.c:3182
>     #12 0x7f60eef357ac in g_main_context_dispatch ../glib/gmain.c:3847
>     #13 0x55ca90927231 in glib_pollfds_poll /home/elmarco/src/qemu/util/main-loop.c:214
>     #14 0x55ca90927420 in os_host_main_loop_wait /home/elmarco/src/qemu/util/main-loop.c:261
>     #15 0x55ca909275fa in main_loop_wait /home/elmarco/src/qemu/util/main-loop.c:515
>     #16 0x55ca8fc1c2a4 in main_loop /home/elmarco/src/qemu/vl.c:1942
>     #17 0x55ca8fc2eb3a in main /home/elmarco/src/qemu/vl.c:4724
>     #18 0x7f60e4082009 in __libc_start_main (/lib64/libc.so.6+0x21009)
> 
> Indirect leak of 45 byte(s) in 1 object(s) allocated from:
>     #0 0x7f60efba1850 in malloc (/lib64/libasan.so.4+0xde850)
>     #1 0x7f60eef3cf0c in g_malloc ../glib/gmem.c:94
>     #2 0x7f60eef3d1cf in g_malloc_n ../glib/gmem.c:331
>     #3 0x7f60eef596eb in g_strdup ../glib/gstrfuncs.c:363
>     #4 0x55ca90947085 in error_copy /home/elmarco/src/qemu/util/error.c:204
>     #5 0x55ca9037a30f in migrate_set_error /home/elmarco/src/qemu/migration/migration.c:1139
>     #6 0x55ca9037a462 in migrate_fd_error /home/elmarco/src/qemu/migration/migration.c:1150
>     #7 0x55ca9038162b in migrate_fd_connect /home/elmarco/src/qemu/migration/migration.c:2411
>     #8 0x55ca90386e41 in migration_channel_connect /home/elmarco/src/qemu/migration/channel.c:81
>     #9 0x55ca9038335e in socket_outgoing_migration /home/elmarco/src/qemu/migration/socket.c:85
>     #10 0x55ca9083dd3a in qio_task_complete /home/elmarco/src/qemu/io/task.c:142
>     #11 0x55ca9083d6cc in gio_task_thread_result /home/elmarco/src/qemu/io/task.c:88
>     #12 0x7f60eef37317 in g_idle_dispatch ../glib/gmain.c:5552
>     #13 0x7f60eef3490b in g_main_dispatch ../glib/gmain.c:3182
>     #14 0x7f60eef357ac in g_main_context_dispatch ../glib/gmain.c:3847
>     #15 0x55ca90927231 in glib_pollfds_poll /home/elmarco/src/qemu/util/main-loop.c:214
>     #16 0x55ca90927420 in os_host_main_loop_wait /home/elmarco/src/qemu/util/main-loop.c:261
>     #17 0x55ca909275fa in main_loop_wait /home/elmarco/src/qemu/util/main-loop.c:515
>     #18 0x55ca8fc1c2a4 in main_loop /home/elmarco/src/qemu/vl.c:1942
>     #19 0x55ca8fc2eb3a in main /home/elmarco/src/qemu/vl.c:4724
>     #20 0x7f60e4082009 in __libc_start_main (/lib64/libc.so.6+0x21009)
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  migration/migration.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index e345d0cc7e..62c243d2d4 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -2541,6 +2541,7 @@ static void migration_instance_finalize(Object *obj)
>      g_free(params->tls_hostname);
>      g_free(params->tls_creds);
>      qemu_sem_destroy(&ms->pause_sem);
> +    error_free(ms->error);
>  }
>  
>  static void migration_instance_init(Object *obj)
> 
