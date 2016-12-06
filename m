Received: from eggs.gnu.org ([2001:4830:134:3::10]:39094)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cELSv-0001yv-NG
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 14:31:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cELSs-0001R8-Ca
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 14:31:49 -0500
Date: Tue, 6 Dec 2016 21:31:43 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20161206213023-mutt-send-email-mst@kernel.org>
References: <148104617887.7699.984921868108236415.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <148104617887.7699.984921868108236415.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] virtio: fix HW_COMPAT_2_6 macro for
 virtio-*-pci drivers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, Halil Pasic <pasic@linux.vnet.ibm.com>, Eduardo Habkost <ehabkost@redhat.com>, qemu-stable@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>

On Tue, Dec 06, 2016 at 06:50:47PM +0100, Greg Kurz wrote:
> Since commit "9a4c0e220d8a hw/virtio-pci: fix virtio behaviour", passing
> -device virtio-blk-pci.disable-modern=off has no effect on 2.6 machine
> types because the internal virtio-pci.disable-modern=on compat property
> always prevail.
> 
> This should ideally be fixed in the qdev properties core code, but it is
> too late in the QEMU 2.8 schedule. So this patch fixes the issue by setting
> the compat properties for every virtio-*-pci subtypes instead of the base
> virtio-pci type.
> 
> Signed-off-by: Greg Kurz <groug@kaod.org>

What's the rush? Either the issue is or isn't 2.8 material. If it is,
let's fix it in qdev core now. If it isn't no need for quick fixes,
just wait a bit and merge qdev core fix after 2.8 is out.


> ---
> 
> This fix is for both QEMU 2.8 and 2.7.1.
> 
> Generated with:
> 
> for i in $(git grep 'define TYPE_VIRTIO_.*_PCI' hw/virtio/virtio-pci.h | \
>            awk '{print $3 }'); do 
>     printf '{\\'"\n        .driver   = %s,"'\\'"\n        .property = \"disable-modern\","'\\'"\n        .value    = \"on\","'\\'"\n    },{"'\\'"\n        .driver   = %s,"'\\'"\n        .property = \"disable-legacy\","'\\'"\n        .value    = \"off\","'\\'"\n    }," $i $i
> done
> 
>  include/hw/compat.h |  116 ++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 114 insertions(+), 2 deletions(-)
> 
> diff --git a/include/hw/compat.h b/include/hw/compat.h
> index 0f06e113bee2..793ba3ddb393 100644
> --- a/include/hw/compat.h
> +++ b/include/hw/compat.h
> @@ -26,11 +26,123 @@
>          .property = "format_transport_address",\
>          .value    = "off",\
>      },{\
> -        .driver   = "virtio-pci",\
> +        .driver   = "virtio-scsi-pci",\
>          .property = "disable-modern",\
>          .value    = "on",\
>      },{\
> -        .driver   = "virtio-pci",\
> +        .driver   = "virtio-scsi-pci",\
> +        .property = "disable-legacy",\
> +        .value    = "off",\
> +    },{\
> +        .driver   = "virtio-blk-pci",\
> +        .property = "disable-modern",\
> +        .value    = "on",\
> +    },{\
> +        .driver   = "virtio-blk-pci",\
> +        .property = "disable-legacy",\
> +        .value    = "off",\
> +    },{\
> +        .driver   = "virtio-balloon-pci",\
> +        .property = "disable-modern",\
> +        .value    = "on",\
> +    },{\
> +        .driver   = "virtio-balloon-pci",\
> +        .property = "disable-legacy",\
> +        .value    = "off",\
> +    },{\
> +        .driver   = "virtio-serial-pci",\
> +        .property = "disable-modern",\
> +        .value    = "on",\
> +    },{\
> +        .driver   = "virtio-serial-pci",\
> +        .property = "disable-legacy",\
> +        .value    = "off",\
> +    },{\
> +        .driver   = "virtio-net-pci",\
> +        .property = "disable-modern",\
> +        .value    = "on",\
> +    },{\
> +        .driver   = "virtio-net-pci",\
> +        .property = "disable-legacy",\
> +        .value    = "off",\
> +    },{\
> +        .driver   = "virtio-9p-pci",\
> +        .property = "disable-modern",\
> +        .value    = "on",\
> +    },{\
> +        .driver   = "virtio-9p-pci",\
> +        .property = "disable-legacy",\
> +        .value    = "off",\
> +    },{\
> +        .driver   = "virtio-rng-pci",\
> +        .property = "disable-modern",\
> +        .value    = "on",\
> +    },{\
> +        .driver   = "virtio-rng-pci",\
> +        .property = "disable-legacy",\
> +        .value    = "off",\
> +    },{\
> +        .driver   = "virtio-input-pci",\
> +        .property = "disable-modern",\
> +        .value    = "on",\
> +    },{\
> +        .driver   = "virtio-input-pci",\
> +        .property = "disable-legacy",\
> +        .value    = "off",\
> +    },{\
> +        .driver   = "virtio-input-hid-pci",\
> +        .property = "disable-modern",\
> +        .value    = "on",\
> +    },{\
> +        .driver   = "virtio-input-hid-pci",\
> +        .property = "disable-legacy",\
> +        .value    = "off",\
> +    },{\
> +        .driver   = "virtio-keyboard-pci",\
> +        .property = "disable-modern",\
> +        .value    = "on",\
> +    },{\
> +        .driver   = "virtio-keyboard-pci",\
> +        .property = "disable-legacy",\
> +        .value    = "off",\
> +    },{\
> +        .driver   = "virtio-mouse-pci",\
> +        .property = "disable-modern",\
> +        .value    = "on",\
> +    },{\
> +        .driver   = "virtio-mouse-pci",\
> +        .property = "disable-legacy",\
> +        .value    = "off",\
> +    },{\
> +        .driver   = "virtio-tablet-pci",\
> +        .property = "disable-modern",\
> +        .value    = "on",\
> +    },{\
> +        .driver   = "virtio-tablet-pci",\
> +        .property = "disable-legacy",\
> +        .value    = "off",\
> +    },{\
> +        .driver   = "virtio-input-host-pci",\
> +        .property = "disable-modern",\
> +        .value    = "on",\
> +    },{\
> +        .driver   = "virtio-input-host-pci",\
> +        .property = "disable-legacy",\
> +        .value    = "off",\
> +    },{\
> +        .driver   = "virtio-gpu-pci",\
> +        .property = "disable-modern",\
> +        .value    = "on",\
> +    },{\
> +        .driver   = "virtio-gpu-pci",\
> +        .property = "disable-legacy",\
> +        .value    = "off",\
> +    },{\
> +        .driver   = "virtio-crypto-pci",\
> +        .property = "disable-modern",\
> +        .value    = "on",\
> +    },{\
> +        .driver   = "virtio-crypto-pci",\
>          .property = "disable-legacy",\
>          .value    = "off",\
>      },
