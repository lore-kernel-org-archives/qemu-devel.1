Received: from eggs.gnu.org ([209.51.188.92]:54094)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1guBQK-0004rp-15
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 02:27:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1guBQG-0002S6-J9
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 02:27:06 -0500
Received: from mga12.intel.com ([192.55.52.136]:57172)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
	id 1guBQE-0002Gz-GV
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 02:27:04 -0500
Date: Thu, 14 Feb 2019 15:26:29 +0800
From: Wei Yang <richardw.yang@linux.intel.com>
Message-ID: <20190214072629.GA18896@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <20190214031004.32522-1-stefanha@redhat.com>
	<20190214031004.32522-2-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190214031004.32522-2-stefanha@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 1/2] hostmem: simplify ifdef-s in
 file_backend_memory_alloc()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Wei Yang <richardw.yang@linux.intel.com>

Maybe change the title 

   s/hotmem/hostmem-file/

would be more proper.

I missed this in previous review.

On Thu, Feb 14, 2019 at 11:10:03AM +0800, Stefan Hajnoczi wrote:
>From: Igor Mammedov <imammedo@redhat.com>
>
>cleanup file_backend_memory_alloc() by using one CONFIG_POSIX ifdef
>instead of several ones within the function to make it simpler to follow.
>
>Signed-off-by: Igor Mammedov <imammedo@redhat.com>
>Suggested-by: Wei Yang <richardw.yang@linux.intel.com>
>Reviewed-by: Wei Yang <richardw.yang@linux.intel.com>
>Message-Id: <20190213123858.24620-1-imammedo@redhat.com>
>Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>---
> backends/hostmem-file.c | 9 ++++-----
> 1 file changed, 4 insertions(+), 5 deletions(-)
>
>diff --git a/backends/hostmem-file.c b/backends/hostmem-file.c
>index ba601ce940..ce54788048 100644
>--- a/backends/hostmem-file.c
>+++ b/backends/hostmem-file.c
>@@ -41,10 +41,12 @@ struct HostMemoryBackendFile {
> static void
> file_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
> {
>+#ifndef CONFIG_POSIX
>+    error_setg(errp, "backend '%s' not supported on this host",
>+               object_get_typename(OBJECT(backend)));
>+#else
>     HostMemoryBackendFile *fb = MEMORY_BACKEND_FILE(backend);
>-#ifdef CONFIG_POSIX
>     gchar *name;
>-#endif
> 
>     if (!backend->size) {
>         error_setg(errp, "can't create backend with size 0");
>@@ -54,9 +56,6 @@ file_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
>         error_setg(errp, "mem-path property not set");
>         return;
>     }
>-#ifndef CONFIG_POSIX
>-    error_setg(errp, "-mem-path not supported on this host");
>-#else
>     backend->force_prealloc = mem_prealloc;
>     name = host_memory_backend_get_name(backend);
>     memory_region_init_ram_from_file(&backend->mr, OBJECT(backend),
>-- 
>2.20.1

-- 
Wei Yang
Help you, Help me
