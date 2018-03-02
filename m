Received: from eggs.gnu.org ([2001:4830:134:3::10]:45653)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1erm2G-0001zr-Fi
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 09:51:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1erm2D-0005U5-DS
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 09:51:48 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40162 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1erm2D-0005PN-8M
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 09:51:45 -0500
References: <20180228180215.25470-1-wei@redhat.com>
	<20180228180215.25470-2-wei@redhat.com>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <e83a34b4-46d2-e526-8cae-253824bb7545@redhat.com>
Date: Fri, 2 Mar 2018 15:51:29 +0100
MIME-Version: 1.0
In-Reply-To: <20180228180215.25470-2-wei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH V7 1/4] rules: Move cross compilation auto
 detection functions to rules.mak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Huang <wei@redhat.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, drjones@redhat.com, dgilbert@redhat.com, quintela@redhat.com

On 28/02/2018 19:02, Wei Huang wrote:
> This patch moves the auto detection functions for cross compilation from
> roms/Makefile to rules.mak. So the functions can be shared among Makefiles
> in QEMU.
> 
> Signed-off-by: Wei Huang <wei@redhat.com>
> Reviewed-by: Andrew Jones <drjones@redhat.com>
> ---
>  roms/Makefile | 24 +++++++-----------------
>  rules.mak     | 15 +++++++++++++++
>  2 files changed, 22 insertions(+), 17 deletions(-)
> 
> diff --git a/roms/Makefile b/roms/Makefile
> index b5e5a69e91..e972c65333 100644
> --- a/roms/Makefile
> +++ b/roms/Makefile
> @@ -21,23 +21,6 @@ pxe-rom-virtio   efi-rom-virtio   : DID := 1000
>  pxe-rom-vmxnet3  efi-rom-vmxnet3  : VID := 15ad
>  pxe-rom-vmxnet3  efi-rom-vmxnet3  : DID := 07b0
>  
> -#
> -# cross compiler auto detection
> -#
> -path := $(subst :, ,$(PATH))
> -system := $(shell uname -s | tr "A-Z" "a-z")
> -
> -# first find cross binutils in path
> -find-cross-ld = $(firstword $(wildcard $(patsubst %,%/$(1)-*$(system)*-ld,$(path))))
> -# then check we have cross gcc too
> -find-cross-gcc = $(firstword $(wildcard $(patsubst %ld,%gcc,$(call find-cross-ld,$(1)))))
> -# finally strip off path + toolname so we get the prefix
> -find-cross-prefix = $(subst gcc,,$(notdir $(call find-cross-gcc,$(1))))
> -
> -powerpc64_cross_prefix := $(call find-cross-prefix,powerpc64)
> -powerpc_cross_prefix := $(call find-cross-prefix,powerpc)
> -x86_64_cross_prefix := $(call find-cross-prefix,x86_64)
> -
>  # tag our seabios builds
>  SEABIOS_EXTRAVERSION="-prebuilt.qemu-project.org"
>  
> @@ -66,6 +49,13 @@ default:
>  	@echo "  skiboot        -- update skiboot.lid"
>  	@echo "  u-boot.e500    -- update u-boot.e500"
>  
> +SRC_PATH=..
> +include $(SRC_PATH)/rules.mak

Did you check it works for not in-tree build?

Something like:

   cd qemu
   mkdir build
   cd build
   ../configure
   make
   ...

for instance in po/Makefile, we have:

  # Set SRC_PATH for in-tree builds without configuration.
  SRC_PATH=..
...
  -include ../config-host.mak
  include $(SRC_PATH)/rules.mak

and config-host.mak defines the absolute path of SRC_PATH

Thanks,
Laurent
