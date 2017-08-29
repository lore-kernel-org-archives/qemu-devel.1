Received: from eggs.gnu.org ([2001:4830:134:3::10]:40524)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dmtzz-0003IE-BX
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 23:49:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dmtzu-0001Cj-FK
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 23:49:03 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:33586)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dmtzu-0001CX-AA
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 23:48:58 -0400
Received: by mail-qk0-x243.google.com with SMTP id k126so1085980qkb.0
	for <qemu-devel@nongnu.org>; Tue, 29 Aug 2017 20:48:58 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170829212053.6003-1-ehabkost@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <b4dee2f8-9be8-4a3b-2942-b80a6c7f1b11@amsat.org>
Date: Tue, 29 Aug 2017 20:30:56 -0300
MIME-Version: 1.0
In-Reply-To: <20170829212053.6003-1-ehabkost@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] oslib-posix: Print errors before aborting
 on qemu_alloc_stack()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On 08/29/2017 06:20 PM, Eduardo Habkost wrote:
> If QEMU is running on a system that's out of memory and mmap()
> fails, QEMU aborts with no error message at all, making it hard
> to debug the reason for the failure.
> 
> Add perror() calls that will print error information before
> aborting.
> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>   util/oslib-posix.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/util/oslib-posix.c b/util/oslib-posix.c
> index cacf0ef..80086c5 100644
> --- a/util/oslib-posix.c
> +++ b/util/oslib-posix.c
> @@ -530,6 +530,7 @@ void *qemu_alloc_stack(size_t *sz)
>       ptr = mmap(NULL, *sz, PROT_READ | PROT_WRITE,
>                  MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
>       if (ptr == MAP_FAILED) {
> +        perror("failed to allocate memory for stack");
>           abort();
>       }
>   
> @@ -544,6 +545,7 @@ void *qemu_alloc_stack(size_t *sz)
>       guardpage = ptr;
>   #endif
>       if (mprotect(guardpage, pagesz, PROT_NONE) != 0) {
> +        perror("failed to set up stack guard page");
>           abort();
>       }
>   
> 
