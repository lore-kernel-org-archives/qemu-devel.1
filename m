Received: from eggs.gnu.org ([2001:4830:134:3::10]:53140)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cmFzw-0006Y4-8P
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 03:34:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cmFzs-0005QI-7S
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 03:34:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45578)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cmFzs-0005Q9-1p
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 03:34:00 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 20FA281F03
	for <qemu-devel@nongnu.org>; Fri, 10 Mar 2017 08:34:00 +0000 (UTC)
References: <1489119213-977-1-git-send-email-peterx@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <da6200fe-c0ac-00bb-d0b7-dbf3c5a8a21f@redhat.com>
Date: Fri, 10 Mar 2017 09:33:57 +0100
MIME-Version: 1.0
In-Reply-To: <1489119213-977-1-git-send-email-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] hostmem: fix reference to uninit mr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>



On 10/03/2017 05:13, Peter Xu wrote:
> Trying to get memory region size of an uninitialized memory region is
> probably not a good idea. Let's just do the alloc no matter what.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>

What is the effect of the bug?  The idea was to do the initialization
once only (memory_region_size ought to be 0 when the MR is
uninitialized; now it is ugly but it made more sense when MemoryRegion
was just a C struct and not a QOM object).

Paolo

> ---
>  backends/hostmem-file.c | 17 +++++++----------
>  1 file changed, 7 insertions(+), 10 deletions(-)
> 
> diff --git a/backends/hostmem-file.c b/backends/hostmem-file.c
> index 42efb2f..a61d1bd 100644
> --- a/backends/hostmem-file.c
> +++ b/backends/hostmem-file.c
> @@ -39,6 +39,7 @@ static void
>  file_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
>  {
>      HostMemoryBackendFile *fb = MEMORY_BACKEND_FILE(backend);
> +    gchar *path;
>  
>      if (!backend->size) {
>          error_setg(errp, "can't create backend with size 0");
> @@ -51,16 +52,12 @@ file_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
>  #ifndef CONFIG_LINUX
>      error_setg(errp, "-mem-path not supported on this host");
>  #else
> -    if (!memory_region_size(&backend->mr)) {
> -        gchar *path;
> -        backend->force_prealloc = mem_prealloc;
> -        path = object_get_canonical_path(OBJECT(backend));
> -        memory_region_init_ram_from_file(&backend->mr, OBJECT(backend),
> -                                 path,
> -                                 backend->size, fb->share,
> -                                 fb->mem_path, errp);
> -        g_free(path);
> -    }
> +    backend->force_prealloc = mem_prealloc;
> +    path = object_get_canonical_path(OBJECT(backend));
> +    memory_region_init_ram_from_file(&backend->mr, OBJECT(backend),
> +                                     path, backend->size, fb->share,
> +                                     fb->mem_path, errp);
> +    g_free(path);
>  #endif
>  }
>  
> 
