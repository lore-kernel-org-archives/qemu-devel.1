Received: from eggs.gnu.org ([2001:4830:134:3::10]:40523)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fhaBC-0000a9-3p
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 08:43:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fhaBB-0001YS-73
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 08:43:10 -0400
Date: Mon, 23 Jul 2018 14:42:54 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180723144254.663f457f@redhat.com>
In-Reply-To: <20180704124923.32483-3-drjones@redhat.com>
References: <20180704124923.32483-1-drjones@redhat.com>
	<20180704124923.32483-3-drjones@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 2/6] device_tree: add qemu_fdt_add_path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Jones <drjones@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, eric.auger@redhat.com, wei@redhat.com, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Alexander Graf <agraf@suse.de>

On Wed,  4 Jul 2018 14:49:19 +0200
Andrew Jones <drjones@redhat.com> wrote:

> qemu_fdt_add_path works like qemu_fdt_add_subnode, except it
> also recursively adds any missing parent nodes.

Probably add here why new helper is need?

> 
> Cc: Peter Crosthwaite <crosthwaite.peter@gmail.com>
> Cc: Alexander Graf <agraf@suse.de>
> Signed-off-by: Andrew Jones <drjones@redhat.com>
> ---
>  device_tree.c                | 24 ++++++++++++++++++++++++
>  include/sysemu/device_tree.h |  1 +
>  2 files changed, 25 insertions(+)
> 
> diff --git a/device_tree.c b/device_tree.c
> index 6d9c9726f66c..ad570a4dbe3a 100644
> --- a/device_tree.c
> +++ b/device_tree.c
> @@ -520,6 +520,30 @@ int qemu_fdt_add_subnode(void *fdt, const char *name)
>      return retval;
>  }
>  
> +int qemu_fdt_add_path(void *fdt, const char *path)
> +{
> +    char *parent;
> +    int offset;
> +
> +    offset = fdt_path_offset(fdt, path);
> +    if (offset < 0 && offset != -FDT_ERR_NOTFOUND) {
> +        error_report("%s Couldn't find node %s: %s", __func__, path,
> +                     fdt_strerror(offset));
> +        exit(1);
> +    }
> +
> +    if (offset != -FDT_ERR_NOTFOUND) {
> +        return offset;
> +    }
> +
> +    parent = g_strdup(path);
> +    strrchr(parent, '/')[0] = '\0';
> +    qemu_fdt_add_path(fdt, parent);
can it be implemented without recursion?

> +    g_free(parent);
> +
> +    return qemu_fdt_add_subnode(fdt, path);
> +}
> +
>  void qemu_fdt_dumpdtb(void *fdt, int size)
>  {
>      const char *dumpdtb = qemu_opt_get(qemu_get_machine_opts(), "dumpdtb");
> diff --git a/include/sysemu/device_tree.h b/include/sysemu/device_tree.h
> index c16fd69bc0b1..d62fc873a3ea 100644
> --- a/include/sysemu/device_tree.h
> +++ b/include/sysemu/device_tree.h
> @@ -101,6 +101,7 @@ uint32_t qemu_fdt_get_phandle(void *fdt, const char *path);
>  uint32_t qemu_fdt_alloc_phandle(void *fdt);
>  int qemu_fdt_nop_node(void *fdt, const char *node_path);
>  int qemu_fdt_add_subnode(void *fdt, const char *name);

/**
 * qemu_fdt_add_path: ....
 ...
*/

It would be nice to have a doc comment here

> +int qemu_fdt_add_path(void *fdt, const char *path);
>  
>  #define qemu_fdt_setprop_cells(fdt, node_path, property, ...)                 \
>      do {                                                                      \
