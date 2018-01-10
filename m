Received: from eggs.gnu.org ([2001:4830:134:3::10]:55554)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1eZMhU-0001V8-QY
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 15:10:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1eZMhT-0007FD-Qj
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 15:10:16 -0500
Date: Wed, 10 Jan 2018 13:09:56 -0700
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20180110130956.06baae69@t450s.home>
In-Reply-To: <20180110091846.10699-3-famz@redhat.com>
References: <20180110091846.10699-1-famz@redhat.com>
	<20180110091846.10699-3-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 2/9] util: Introduce vfio helpers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>, Keith Busch <keith.busch@intel.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Karl Rister <krister@redhat.com>

On Wed, 10 Jan 2018 17:18:39 +0800
Fam Zheng <famz@redhat.com> wrote:

> This is a library to manage the host vfio interface, which could be used
> to implement userspace device driver code in QEMU such as NVMe or net
> controllers.
> 
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  include/qemu/vfio-helpers.h |  30 ++
>  util/Makefile.objs          |   1 +
>  util/trace-events           |  11 +
>  util/vfio-helpers.c         | 723 ++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 765 insertions(+)
>  create mode 100644 include/qemu/vfio-helpers.h
>  create mode 100644 util/vfio-helpers.c
> 
> diff --git a/include/qemu/vfio-helpers.h b/include/qemu/vfio-helpers.h
> new file mode 100644
> index 0000000000..6bdba3b66e
> --- /dev/null
> +++ b/include/qemu/vfio-helpers.h
...
> +/**
> + * Map a PCI bar area.
> + */
> +void *qemu_vfio_pci_map_bar(QEMUVFIOState *s, int index, Error **errp)
> +{
> +    void *p;
> +    assert_bar_index_valid(s, index);
> +    p = mmap(NULL, MIN(8192, s->bar_region_info[index].size),
> +             PROT_READ | PROT_WRITE, MAP_SHARED,
> +             s->device, s->bar_region_info[index].offset);
> +    if (p == MAP_FAILED) {
> +        error_setg_errno(errp, errno, "Failed to map BAR region");
> +        p = NULL;
> +    }
> +    return p;
> +}
> +
> +/**
> + * Unmap a PCI bar area.
> + */
> +void qemu_vfio_pci_unmap_bar(QEMUVFIOState *s, int index, void *bar)
> +{
> +    if (bar) {
> +        munmap(bar, MIN(8192, s->bar_region_info[index].size));
> +    }
> +}

What's up with this 8KB thing?  Is it perhaps a hack to avoid
un-mmap'able MSI-X sections of the BAR, which would make this general
purpose library very specific to devices which only operate in the lower
8KB of their MMIO space.  Maybe the interface should have an offset and
size so that the NVMe driver could implement that dependency.  We could
also be testing if the region supports mmap, but I suppose trying and
failing is just as good.  Thanks,

Alex
