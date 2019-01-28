Received: from eggs.gnu.org ([209.51.188.92]:36010)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1go9Sj-0003kt-H7
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 11:08:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1go9Sf-0005DT-Dy
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 11:08:40 -0500
Date: Mon, 28 Jan 2019 17:08:19 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190128170819.4998232d.cohuck@redhat.com>
In-Reply-To: <1548689366-31916-1-git-send-email-thuth@redhat.com>
References: <3f01a301-d639-dbe7-f522-42a50e2d443e@redhat.com>
	<1548689366-31916-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH] s390x: express dependencies
 with Kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, yang.zhong@intel.com, pbonzini@redhat.com, qemu-s390x@nongnu.org

On Mon, 28 Jan 2019 16:29:26 +0100
Thomas Huth <thuth@redhat.com> wrote:

> Instead of hard-coding all config switches in the config file
> default-configs/s390x-softmmu.mak, let's use the new Kconfig files
> to express the necessary dependencies: The S390_CCW_VIRTIO config switch
> for the "s390-ccw-virtio" machine now selects all non-optional devices.
> 
> And since we already have the VIRTIO_PCI and VIRTIO_MMIO config switches
> for the other two virtio transports, this patch also introduces a new
> config switch VIRTIO_CCW for the third, s390x-specific virtio transport,
> so that all three virtio transports are now handled in the same way.

I haven't found time to look at the Kconfig patches, so take the
following with a generous amount of salt.

> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  This goes on top of the curren Kconfig series:
> 
>  Based-on: 1548410831-19553-1-git-send-email-pbonzini@redhat.com
> 
>  default-configs/s390x-softmmu.mak | 12 ++++++++----
>  hw/s390x/Kconfig                  |  4 ++++
>  hw/s390x/Makefile.objs            |  2 +-
>  hw/virtio/Kconfig                 |  4 ++++
>  4 files changed, 17 insertions(+), 5 deletions(-)
> 
> diff --git a/default-configs/s390x-softmmu.mak b/default-configs/s390x-softmmu.mak
> index 2be5059..08b1683 100644
> --- a/default-configs/s390x-softmmu.mak
> +++ b/default-configs/s390x-softmmu.mak
> @@ -1,9 +1,13 @@
> -CONFIG_PCI=y
> +# Default configuration for s390x-softmmu
> +
> +# Optional devices:
> +#
>  CONFIG_VIRTIO_PCI=y
> -CONFIG_SCLPCONSOLE=y
>  CONFIG_TERMINAL3270=y
> -CONFIG_S390_FLIC=y
>  CONFIG_WDT_DIAG288=y
> -CONFIG_S390_CCW_VIRTIO=y
>  CONFIG_VFIO_CCW=y
>  CONFIG_VFIO_AP=y

This looks sensible.

> +
> +# Boards:
> +#
> +CONFIG_S390_CCW_VIRTIO=y
> diff --git a/hw/s390x/Kconfig b/hw/s390x/Kconfig
> index 303db7f..9a36c39 100644
> --- a/hw/s390x/Kconfig
> +++ b/hw/s390x/Kconfig
> @@ -1,2 +1,6 @@
>  config S390_CCW_VIRTIO
>      bool
> +    select PCI
> +    select S390_FLIC
> +    select SCLPCONSOLE
> +    select VIRTIO_CCW

This also makes sense. (I assume CONFIG_PCI, CONFIG_S390_FLIC, and
CONFIG_SCLPCONSOLE are already defined in the base patch series.)

> diff --git a/hw/s390x/Makefile.objs b/hw/s390x/Makefile.objs
> index a884aae..0dc798a 100644
> --- a/hw/s390x/Makefile.objs
> +++ b/hw/s390x/Makefile.objs
> @@ -8,7 +8,7 @@ obj-y += ipl.o
>  obj-y += css.o
>  obj-y += s390-virtio-ccw.o
>  obj-y += 3270-ccw.o

Should this depend on TERMINAL3270 (at least in the future)?

> -obj-y += virtio-ccw.o
> +obj-$(CONFIG_VIRTIO_CCW) += virtio-ccw.o
>  obj-$(CONFIG_VIRTIO_SERIAL) += virtio-ccw-serial.o

Hm. Should the individual device types depend both on VIRTIO_<device>
and on VIRTIO_CCW? Making VIRTIO_<device> depend on VIRTIO_PCI ||
VIRTIO_CCW || VIRTIO_MMIO is probably not enough, as we could be trying
to build virtio-ccw devices if only VIRTIO_PCI is set (or virtio-pci
devices if only VIRTIO_CCW is set, for that matter.)

Or maybe I simply need to read the patches and find the answer there :)

>  obj-$(CONFIG_VIRTIO_BALLOON) += virtio-ccw-balloon.o
>  obj-$(CONFIG_VIRTIO_SCSI) += virtio-ccw-scsi.o
> diff --git a/hw/virtio/Kconfig b/hw/virtio/Kconfig
> index 74f4573..e0452de 100644
> --- a/hw/virtio/Kconfig
> +++ b/hw/virtio/Kconfig
> @@ -16,6 +16,10 @@ config VIRTIO_MMIO
>      bool
>      select VIRTIO
>  
> +config VIRTIO_CCW
> +    bool
> +    select VIRTIO
> +
>  config VIRTIO_BALLOON
>      bool
>      default y
