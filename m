Received: from eggs.gnu.org ([209.51.188.92]:34537)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1h1A4F-0002Tf-Ff
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 08:25:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1h1A4E-0000AF-OE
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 08:25:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43768)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1h1A4E-00008z-H7
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 08:25:10 -0500
Date: Tue, 5 Mar 2019 13:25:06 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190305132505.GC9811@work-vm>
References: <20190304184923.24215-1-marcel.apfelbaum@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190304184923.24215-1-marcel.apfelbaum@gmail.com>
Subject: Re: [Qemu-devel] [PATCH V2] migration/rdma: clang compilation fix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: qemu-devel@nongnu.org, eblake@redhat.com

* Marcel Apfelbaum (marcel.apfelbaum@gmail.com) wrote:
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

Queued

> ---
> 
> v1 -> v2: 
>  - Use a temp local variable (Dave)
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
> +                uint32_t tmp_rkey = 0;
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
> -- 
> 2.17.1
> 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
