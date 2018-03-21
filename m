Received: from eggs.gnu.org ([2001:4830:134:3::10]:37889)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eyex8-0008Qf-Nh
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 10:42:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eyex5-0002ke-Lh
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 10:42:58 -0400
Received: from mail-wr0-x22b.google.com ([2a00:1450:400c:c0c::22b]:33534)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eyex5-0002jk-F3
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 10:42:55 -0400
Received: by mail-wr0-x22b.google.com with SMTP id z73so5455372wrb.0
	for <qemu-devel@nongnu.org>; Wed, 21 Mar 2018 07:42:55 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180321113644.21899-1-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <b024eb17-2f2c-75d4-5ff6-ba33a143b7c6@amsat.org>
Date: Wed, 21 Mar 2018 15:42:52 +0100
MIME-Version: 1.0
In-Reply-To: <20180321113644.21899-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] migration: fix pfd leak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, peterx@redhat.com

On 03/21/2018 12:36 PM, Marc-André Lureau wrote:
> Fix leak spotted by ASAN:
> 
> Direct leak of 16 byte(s) in 1 object(s) allocated from:
>     #0 0x7fe1abb80a38 in __interceptor_calloc (/lib64/libasan.so.4+0xdea38)
>     #1 0x7fe1aaf1bf75 in g_malloc0 ../glib/gmem.c:124
>     #2 0x7fe1aaf1c249 in g_malloc0_n ../glib/gmem.c:355
>     #3 0x55f4841cfaa9 in postcopy_ram_fault_thread /home/elmarco/src/qemu/migration/postcopy-ram.c:596
>     #4 0x55f48479447b in qemu_thread_start /home/elmarco/src/qemu/util/qemu-thread-posix.c:504
>     #5 0x7fe1a043550a in start_thread (/lib64/libpthread.so.0+0x750a)
> 
> Regression introduced with commit 00fa4fc85b00f1a8a810068d158a7a66e88658eb.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  migration/postcopy-ram.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> index efd77939af..4a0b33b373 100644
> --- a/migration/postcopy-ram.c
> +++ b/migration/postcopy-ram.c
> @@ -754,6 +754,7 @@ static void *postcopy_ram_fault_thread(void *opaque)
>          }
>      }
>      trace_postcopy_ram_fault_thread_exit();
> +    g_free(pfd);
>      return NULL;
>  }
>  
> 
