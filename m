Received: from eggs.gnu.org ([2001:4830:134:3::10]:38754)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eeRaa-0001tI-VW
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 15:24:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eeRaZ-0002GE-SM
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 15:24:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40520)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1eeRaZ-0002G1-Je
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 15:24:07 -0500
Date: Wed, 24 Jan 2018 22:23:55 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180124222343-mutt-send-email-mst@kernel.org>
References: <20180117081325.11924-1-haozhong.zhang@intel.com>
	<20180117081325.11924-3-haozhong.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180117081325.11924-3-haozhong.zhang@intel.com>
Subject: Re: [Qemu-devel] [PATCH v3 2/3] hostmem: add more information in
 error messages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Haozhong Zhang <haozhong.zhang@intel.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, dgilbert@redhat.com, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Stefan Hajnoczi <stefanha@redhat.com>, Dan Williams <dan.j.williams@intel.com>

On Wed, Jan 17, 2018 at 04:13:24PM +0800, Haozhong Zhang wrote:
> When there are multiple memory backends in use, including the object type
> name, ID and the property name in the error message can help users to
> locate the error.
> 
> Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
> Suggested-by: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  backends/hostmem-file.c |  9 ++++++---
>  backends/hostmem.c      | 11 +++++++----
>  2 files changed, 13 insertions(+), 7 deletions(-)
> 
> diff --git a/backends/hostmem-file.c b/backends/hostmem-file.c
> index e319ec1ad8..ed7d145365 100644
> --- a/backends/hostmem-file.c
> +++ b/backends/hostmem-file.c
> @@ -79,7 +79,8 @@ static void set_mem_path(Object *o, const char *str, Error **errp)
>      HostMemoryBackendFile *fb = MEMORY_BACKEND_FILE(o);
>  
>      if (host_memory_backend_mr_inited(backend)) {
> -        error_setg(errp, "cannot change property value");
> +        error_setg(errp, "cannot change property 'mem-path' of %s '%s'",
> +                   object_get_typename(o), backend->id);
>          return;
>      }
>      g_free(fb->mem_path);
> @@ -99,7 +100,8 @@ static void file_memory_backend_set_share(Object *o, bool value, Error **errp)
>      HostMemoryBackendFile *fb = MEMORY_BACKEND_FILE(o);
>  
>      if (host_memory_backend_mr_inited(backend)) {
> -        error_setg(errp, "cannot change property value");
> +        error_setg(errp, "cannot change property 'share' of %s '%s'",
> +                   object_get_typename(o), backend->id);
>          return;
>      }
>      fb->share = value;
> @@ -136,7 +138,8 @@ static void file_memory_backend_set_align(Object *o, Visitor *v,
>      uint64_t val;
>  
>      if (host_memory_backend_mr_inited(backend)) {
> -        error_setg(&local_err, "cannot change property value");
> +        error_setg(&local_err, "cannot change property '%s' of %s '%s'",
> +                   name, object_get_typename(o), backend->id);
>          goto out;
>      }
>  
> diff --git a/backends/hostmem.c b/backends/hostmem.c
> index ee2c2d5bfd..6853d19bc5 100644
> --- a/backends/hostmem.c
> +++ b/backends/hostmem.c
> @@ -46,7 +46,8 @@ host_memory_backend_set_size(Object *obj, Visitor *v, const char *name,
>      uint64_t value;
>  
>      if (host_memory_backend_mr_inited(backend)) {
> -        error_setg(&local_err, "cannot change property value");
> +        error_setg(&local_err, "cannot change property %s of %s '%s'",
> +                   name, object_get_typename(obj), backend->id);
>          goto out;
>      }
>  
> @@ -55,8 +56,9 @@ host_memory_backend_set_size(Object *obj, Visitor *v, const char *name,
>          goto out;
>      }
>      if (!value) {
> -        error_setg(&local_err, "Property '%s.%s' doesn't take value '%"
> -                   PRIu64 "'", object_get_typename(obj), name, value);
> +        error_setg(&local_err,
> +                   "property '%s' of %s '%s' doesn't take value '%" PRIu64 "'",
> +                   name, object_get_typename(obj), backend->id, value);
>          goto out;
>      }
>      backend->size = value;
> @@ -363,7 +365,8 @@ static void set_id(Object *o, const char *str, Error **errp)
>      HostMemoryBackend *backend = MEMORY_BACKEND(o);
>  
>      if (backend->id) {
> -        error_setg(errp, "cannot change property value");
> +        error_setg(errp, "cannot change property 'id' of %s '%s'",
> +                   object_get_typename(o), backend->id);
>          return;
>      }
>      backend->id = g_strdup(str);
> -- 
> 2.14.1
