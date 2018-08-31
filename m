Received: from eggs.gnu.org ([2001:4830:134:3::10]:55866)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fvn9f-0006s0-K4
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 13:24:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fvn2M-00005P-Lc
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 13:16:49 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56434 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fvn2M-0008WR-G1
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 13:16:46 -0400
References: <1528877995-5043-1-git-send-email-dimastep@yandex-team.ru>
	<1528877995-5043-2-git-send-email-dimastep@yandex-team.ru>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <482dc9cb-c5d5-f5b6-bb9f-9518af5a44f0@redhat.com>
Date: Fri, 31 Aug 2018 19:16:41 +0200
MIME-Version: 1.0
In-Reply-To: <1528877995-5043-2-git-send-email-dimastep@yandex-team.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/2] memfd: fix possible usage of the
 uninitialized file descriptor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dima Stepanov <dimastep@yandex-team.ru>, qemu-devel@nongnu.org
Cc: wrfsh@yandex-team.ru, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>

On 2018-06-13 10:19, Dima Stepanov wrote:
> The qemu_memfd_alloc_check() routine allocates the fd variable on stack.
> This variable is initialized inside the qemu_memfd_alloc() function.
> There are several cases when *fd will be left unintialized which can
> lead to the unexpected close() in the qemu_memfd_free() call.
> 
> Set file descriptor to -1 before calling the qemu_memfd_alloc routine.
> 
> Signed-off-by: Dima Stepanov <dimastep@yandex-team.ru>
> ---
>  util/memfd.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/util/memfd.c b/util/memfd.c
> index d248a53..6287946 100644
> --- a/util/memfd.c
> +++ b/util/memfd.c
> @@ -187,6 +187,7 @@ bool qemu_memfd_alloc_check(void)
>          int fd;

(in case you respin: You could also write "int fd = -1;" in above line)

>          void *ptr;
>  
> +        fd = -1;
>          ptr = qemu_memfd_alloc("test", 4096, 0, &fd, NULL);
>          memfd_check = ptr ? MEMFD_OK : MEMFD_KO;
>          qemu_memfd_free(ptr, 4096, fd);
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>

(FWIW: GCC complains with -O3 about this uninitialized variable, too, so
the build breaks with -Werror here - just noticed this today)
