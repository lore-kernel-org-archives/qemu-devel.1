Received: from eggs.gnu.org ([209.51.188.92]:48897)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1guKDN-0003hB-8i
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 11:50:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1guKDG-0005nX-JF
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 11:50:16 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:36743)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1guKDG-0004sI-7y
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 11:50:14 -0500
Received: by mail-ot1-x344.google.com with SMTP id v62so2773467otb.3
	for <qemu-devel@nongnu.org>; Thu, 14 Feb 2019 08:49:23 -0800 (PST)
MIME-Version: 1.0
References: <20190205173306.20483-1-eric.auger@redhat.com>
	<20190205173306.20483-4-eric.auger@redhat.com>
In-Reply-To: <20190205173306.20483-4-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 Feb 2019 16:49:11 +0000
Message-ID: <CAFEAcA9JZG+SrzRfgSF9u+H6xPC9WT7=hO786bdn98EQGZfczw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v6 03/18] hw/arm/boot: introduce
 fdt_add_memory_node helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Auger <eric.auger@redhat.com>
Cc: Eric Auger <eric.auger.pro@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>, Igor Mammedov <imammedo@redhat.com>, David Hildenbrand <david@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Andrew Jones <drjones@redhat.com>

On Tue, 5 Feb 2019 at 17:33, Eric Auger <eric.auger@redhat.com> wrote:
>
> From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
>
> We introduce an helper to create a memory node.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
>  hw/arm/boot.c | 54 ++++++++++++++++++++++++++++++++-------------------
>  1 file changed, 34 insertions(+), 20 deletions(-)
>
> diff --git a/hw/arm/boot.c b/hw/arm/boot.c
> index 05762d0fc1..2ef367e15b 100644
> --- a/hw/arm/boot.c
> +++ b/hw/arm/boot.c
> @@ -423,6 +423,36 @@ static void set_kernel_args_old(const struct arm_boot_info *info,
>      }
>  }
>
> +static int fdt_add_memory_node(void *fdt, uint32_t acells, hwaddr mem_base,
> +                               uint32_t scells, hwaddr mem_len,
> +                               int numa_node_id)
> +{
> +    char *nodename = NULL;

You set nodename immediately below, so no need for the NULL initialization here.

> +    int ret;
> +
> +    nodename = g_strdup_printf("/memory@%" PRIx64, mem_base);
> +    qemu_fdt_add_subnode(fdt, nodename);
> +    qemu_fdt_setprop_string(fdt, nodename, "device_type", "memory");
> +    ret = qemu_fdt_setprop_sized_cells(fdt, nodename, "reg", acells, mem_base,
> +                                       scells, mem_len);
> +    if (ret < 0) {
> +        fprintf(stderr, "couldn't set %s/reg\n", nodename);
> +        goto out;
> +    }

I think error handling (ie whether we print messages or not) ought to be
done by the calling function, rather than here.

> +    if (numa_node_id < 0) {

What is this for? My original theory was that this was an error
case that should probably be an assert(), but we seem to use it
in one of the callers below. A brief comment at the top of the
function documenting its API would assist here. If this is
"only set the NUMA ID if it is specified" then I think writing it as
  if (numa_node_id >= 0) {
     set the id;
  }

is clearer than making it look like an error-exit check.

> +        goto out;
> +    }
> +
> +    ret = qemu_fdt_setprop_cell(fdt, nodename, "numa-node-id", numa_node_id);
> +    if (ret < 0) {
> +        fprintf(stderr, "couldn't set %s/numa-node-id\n", nodename);
> +    }
> +
> +out:
> +    g_free(nodename);
> +    return ret;
> +}
> +
>  static void fdt_add_psci_node(void *fdt)
>  {
>      uint32_t cpu_suspend_fn;
> @@ -502,7 +532,6 @@ int arm_load_dtb(hwaddr addr, const struct arm_boot_info *binfo,
>      void *fdt = NULL;
>      int size, rc, n = 0;
>      uint32_t acells, scells;
> -    char *nodename;
>      unsigned int i;
>      hwaddr mem_base, mem_len;
>      char **node_path;
> @@ -576,35 +605,20 @@ int arm_load_dtb(hwaddr addr, const struct arm_boot_info *binfo,
>          mem_base = binfo->loader_start;
>          for (i = 0; i < nb_numa_nodes; i++) {
>              mem_len = numa_info[i].node_mem;
> -            nodename = g_strdup_printf("/memory@%" PRIx64, mem_base);
> -            qemu_fdt_add_subnode(fdt, nodename);
> -            qemu_fdt_setprop_string(fdt, nodename, "device_type", "memory");
> -            rc = qemu_fdt_setprop_sized_cells(fdt, nodename, "reg",
> -                                              acells, mem_base,
> -                                              scells, mem_len);
> +            rc = fdt_add_memory_node(fdt, acells, mem_base,
> +                                     scells, mem_len, i);
>              if (rc < 0) {
> -                fprintf(stderr, "couldn't set %s/reg for node %d\n", nodename,
> -                        i);
>                  goto fail;
>              }
>
> -            qemu_fdt_setprop_cell(fdt, nodename, "numa-node-id", i);
>              mem_base += mem_len;
> -            g_free(nodename);
>          }
>      } else {
> -        nodename = g_strdup_printf("/memory@%" PRIx64, binfo->loader_start);
> -        qemu_fdt_add_subnode(fdt, nodename);
> -        qemu_fdt_setprop_string(fdt, nodename, "device_type", "memory");
> -
> -        rc = qemu_fdt_setprop_sized_cells(fdt, nodename, "reg",
> -                                          acells, binfo->loader_start,
> -                                          scells, binfo->ram_size);
> +        rc = fdt_add_memory_node(fdt, acells, binfo->loader_start,
> +                                 scells, binfo->ram_size, -1);
>          if (rc < 0) {
> -            fprintf(stderr, "couldn't set %s reg\n", nodename);
>              goto fail;
>          }
> -        g_free(nodename);
>      }
>
>      rc = fdt_path_offset(fdt, "/chosen");
> --
> 2.20.1
>

thanks
-- PMM
