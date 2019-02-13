Received: from eggs.gnu.org ([209.51.188.92]:51975)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.weiyang@gmail.com>) id 1gtugO-0001Zl-Ib
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 08:34:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.weiyang@gmail.com>) id 1gtugK-0002f4-P2
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 08:34:34 -0500
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543]:43717)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.weiyang@gmail.com>)
	id 1gtugG-0002X1-6Z
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 08:34:31 -0500
Received: by mail-ed1-x543.google.com with SMTP id f9so1913345eds.10
	for <qemu-devel@nongnu.org>; Wed, 13 Feb 2019 05:34:24 -0800 (PST)
Date: Wed, 13 Feb 2019 13:34:22 +0000
From: Wei Yang <richard.weiyang@gmail.com>
Message-ID: <20190213133422.22mjfia3btnwfhak@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20190213071401.11544-1-stefanha@redhat.com>
	<20190213123858.24620-1-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190213123858.24620-1-imammedo@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] hostmem: simplify ifdef-s in
 file_backend_memory_alloc()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Haozhong Zhang <haozhong.zhang@intel.com>, Wei Yang <richardw.yang@linux.intel.com>, Eduardo Habkost <ehabkost@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Zhang Yi <yi.z.zhang@linux.intel.com>

On Wed, Feb 13, 2019 at 07:38:58AM -0500, Igor Mammedov wrote:
>cleanup file_backend_memory_alloc() by using one CONFIG_POSIX ifdef
>instead of several ones within the function to make it simpler to follow.
>
>Signed-off-by: Igor Mammedov <imammedo@redhat.com>
>Suggested-by: Wei Yang <richardw.yang@linux.intel.com>

Reviewed-by: Wei Yang <richardw.yang@linux.intel.com>

>---
>Cc: Haozhong Zhang <haozhong.zhang@intel.com>
>Cc: Zhang Yi <yi.z.zhang@linux.intel.com>
>Cc: Eduardo Habkost <ehabkost@redhat.com>
>Cc: Stefan Hajnoczi <stefanha@redhat.com>
>CC: Wei Yang <richardw.yang@linux.intel.com>
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
>2.18.1
>

-- 
Wei Yang
Help you, Help me
