Received: from eggs.gnu.org ([209.51.188.92]:59335)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h0xDM-0007xJ-Kf
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 18:41:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h0wxs-0000NY-F9
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 18:25:45 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36083)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1h0wxs-0000Mu-8Y
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 18:25:44 -0500
Received: by mail-wm1-f67.google.com with SMTP id j125so795764wmj.1
	for <qemu-devel@nongnu.org>; Mon, 04 Mar 2019 15:25:44 -0800 (PST)
References: <20190304184923.24215-1-marcel.apfelbaum@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <f5680a0f-b0e9-6ca1-b4ca-9399444286d8@redhat.com>
Date: Tue, 5 Mar 2019 00:25:41 +0100
MIME-Version: 1.0
In-Reply-To: <20190304184923.24215-1-marcel.apfelbaum@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH V2] migration/rdma: clang compilation fix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-devel@nongnu.org
Cc: dgilbert@redhat.com

On 3/4/19 7:49 PM, Marcel Apfelbaum wrote:
> Configuring QEMU with:
>         ../configure --cc=clang --enable-rdma
> 
> Leads to compilation error:
> 
>   CC      migration/rdma.o
>   CC      migration/block.o
>   qemu/migration/rdma.c:3615:58: error: taking address of packed member 'rkey' of class or structure
>       'RDMARegisterResult' may result in an unaligned pointer value [-Werror,-Waddress-of-packed-member]
>                             (uintptr_t)host_addr, NULL, &reg_result->rkey,
>                                                          ^~~~~~~~~~~~~~~~
> Fix it by using a temp local variable.
> 
> Signed-off-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> ---
> 
> v1 -> v2: 
>  - Use a temp local variable (Dave)

Way cleaner than your v1 :)

> 
>  migration/rdma.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/migration/rdma.c b/migration/rdma.c
> index 54a3c11540..e39ee77558 100644
> --- a/migration/rdma.c
> +++ b/migration/rdma.c
> @@ -3611,13 +3611,16 @@ static int qemu_rdma_registration_handle(QEMUFile *f, void *opaque)
>                  }
>                  chunk_start = ram_chunk_start(block, chunk);
>                  chunk_end = ram_chunk_end(block, chunk + reg->chunks);
> +                /* avoid "-Waddress-of-packed-member" warning */

No sure the comment is helpful.

> +                uint32_t tmp_rkey = 0;

Probably no need to zero-initialize.

Anyway:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

>                  if (qemu_rdma_register_and_get_keys(rdma, block,
> -                            (uintptr_t)host_addr, NULL, &reg_result->rkey,
> +                            (uintptr_t)host_addr, NULL, &tmp_rkey,
>                              chunk, chunk_start, chunk_end)) {
>                      error_report("cannot get rkey");
>                      ret = -EINVAL;
>                      goto out;
>                  }
> +                reg_result->rkey = tmp_rkey;
>  
>                  reg_result->host_addr = (uintptr_t)block->local_host_addr;
>  
> 
