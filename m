Received: from eggs.gnu.org ([209.51.188.92]:43923)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1gn7es-0001Ug-OO
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 15:00:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1gn7er-0005dX-Sy
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 15:00:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:65270)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1gn7er-0005ae-Js
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 15:00:57 -0500
Date: Fri, 25 Jan 2019 13:00:54 -0700
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20190125130054.5814333c@x1.home>
In-Reply-To: <1548410831-19553-48-git-send-email-pbonzini@redhat.com>
References: <1548410831-19553-1-git-send-email-pbonzini@redhat.com>
	<1548410831-19553-48-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 47/52] vfio: express vfio dependencies with
 Kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, yang.zhong@intel.com, thuth@redhat.com

On Fri, 25 Jan 2019 11:07:06 +0100
Paolo Bonzini <pbonzini@redhat.com> wrote:

> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  hw/vfio/Kconfig | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/vfio/Kconfig b/hw/vfio/Kconfig
> index f896779..ebda9fd 100644
> --- a/hw/vfio/Kconfig
> +++ b/hw/vfio/Kconfig
> @@ -7,28 +7,30 @@ config VFIO_PCI
>      select VFIO
>      depends on LINUX
>  
> -config VFIO_SPAPR
> -    bool
> -    default y
> -    depends on VFIO && LINUX && PSERIES


I can't say I really understand what happened with this through the
course of the series.  In patch 27 spapr.o became obj-y, VFIO_SPAPR
came about in patch 32, tweaked in patch 33, then removed in 47.  I was
really hoping the Makefile was going to reflect this as a config option
so we could follow-up with some patches to stub or ifdef out the
dependencies.  The remainder here seems to set the right precedent and
we can add VFIO_SPAPR back later and wire it through the Makefile.

Unfortunately with the full series applied I'm not able to make either
allnoconfig or defconfig:

$ make allnoconfig
  GEN     x86_64-softmmu/config-devices.mak.tmp
  GEN     x86_64-softmmu/config-devices.mak
  GEN     config-all-devices.mak
	CHK version_gen.h
	CHK version_gen.h
rm */config-devices.mak config-all-devices.mak
make MINIKCONF="python -B /home/alwillia/Work/qemu.git/scripts/minikconf.py  --" config-all-devices.mak
make[1]: Entering directory '/home/alwillia/Work/qemu.git'
  GEN     x86_64-softmmu/config-devices.mak.tmp
/home/alwillia/Work/qemu.git/scripts/minikconf.py: invalid option --
	CHK version_gen.h
make[1]: *** No rule to make target 'x86_64-softmmu/config-devices.mak', needed by 'config-all-devices.mak'.  Stop.
make[1]: Leaving directory '/home/alwillia/Work/qemu.git'
make: *** [Makefile:346: allnoconfig] Error 2

Something wrong with this expansion from patch 34 I guess:

.PHONY: allnoconfig defconfig
allnoconfig defconfig:
        rm */config-devices.mak config-all-devices.mak
        $(MAKE) MINIKCONF="$(MINIKCONF) --$<" config-all-devices.mak

Thanks,
Alex

> -
>  config VFIO_CCW
>      bool
> +    default y
>      select VFIO
> -    depends on LINUX
> +    depends on LINUX && S390_CCW_VIRTIO
>  
>  config VFIO_PLATFORM
>      bool
> +    default y
>      select VFIO
> -    depends on LINUX
> +    depends on LINUX && PLATFORM_BUS
>  
>  config VFIO_XGMAC
>      bool
> +    default y
> +    depends on VFIO_PLATFORM
>  
>  config VFIO_AMD_XGBE
>      bool
> +    default y
> +    depends on VFIO_PLATFORM
>  
>  config VFIO_AP
>      bool
> +    default y
>      select VFIO
> -    depends on LINUX
> +    depends on LINUX && S390_CCW_VIRTIO
