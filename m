Received: from eggs.gnu.org ([209.51.188.92]:38263)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1gwqWc-0004Bw-Tw
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 10:44:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1gwqWZ-0007tj-5i
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 10:44:38 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35628)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1gwqWW-0007lw-Jf
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 10:44:33 -0500
Received: by mail-wr1-f65.google.com with SMTP id t18so31199624wrx.2
	for <qemu-devel@nongnu.org>; Thu, 21 Feb 2019 07:44:21 -0800 (PST)
Date: Thu, 21 Feb 2019 16:44:17 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
Message-ID: <20190221154417.h3i5m5pwxbiiufae@steredhat>
References: <1549562254-41157-1-git-send-email-pbonzini@redhat.com>
	<1549562254-41157-7-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1549562254-41157-7-git-send-email-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 06/51] build: switch to Kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Yang Zhong <yang.zhong@intel.com>, thuth@redhat.com, philmd@redhat.com

On Thu, Feb 07, 2019 at 06:56:49PM +0100, Paolo Bonzini wrote:
> The make_device_config.sh script is replaced by minikconf, which
> is modified to support the same command line as its predecessor.
> 
> The roots of the parsing are default-configs/*.mak, Kconfig.host and
> hw/Kconfig.  One difference with make_device_config.sh is that all symbols
> have to be defined in a Kconfig file, including those coming from the
> configure script.  This is the reason for the Kconfig.host file introduced
> in the previous patch. Whenever a file in default-configs/*.mak used
> $(...) to refer to a config-host.mak symbol, this is replaced by a
> Kconfig dependency; this part must be done already in this patch
> for bisectability.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Yang Zhong <yang.zhong@intel.com>
> Acked-by: Thomas Huth <thuth@redhat.com>
> Message-Id: <20190123065618.3520-28-yang.zhong@intel.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  Kconfig.host                      |  6 +++++-
>  Makefile                          | 24 +++++++++++++++++++-----
>  Makefile.target                   |  7 ++++++-
>  configure                         |  6 ++++++
>  default-configs/arm-softmmu.mak   |  2 --
>  default-configs/i386-softmmu.mak  |  5 +----
>  default-configs/lm32-softmmu.mak  |  1 -
>  default-configs/pci.mak           |  1 -
>  default-configs/ppc-softmmu.mak   |  1 -
>  default-configs/ppc64-softmmu.mak |  5 -----
>  default-configs/s390x-softmmu.mak |  4 +---
>  default-configs/virtio.mak        |  3 ---
>  hw/9pfs/Kconfig                   |  2 ++
>  hw/block/Kconfig                  |  2 ++
>  hw/display/Kconfig                |  3 +++
>  hw/i386/Kconfig                   |  7 +++++++
>  hw/input/Kconfig                  |  5 +++++
>  hw/intc/Kconfig                   | 12 ++++++++++++
>  hw/misc/Kconfig                   |  2 ++
>  hw/ppc/Kconfig                    |  4 ++++
>  hw/scsi/Kconfig                   |  7 +++++++
>  hw/tpm/Kconfig                    |  1 +
>  hw/vfio/Kconfig                   |  9 +++++++++
>  rules.mak                         |  2 +-
>  scripts/make_device_config.sh     | 30 ------------------------------
>  25 files changed, 93 insertions(+), 58 deletions(-)
>  delete mode 100644 scripts/make_device_config.sh
> 
> diff --git a/Kconfig.host b/Kconfig.host
> index ff5457d..e3d486c 100644
> --- a/Kconfig.host
> +++ b/Kconfig.host
> @@ -1,5 +1,6 @@
>  # These are "proxy" symbols used to pass config-host.mak values
> -# down to Kconfig.
> +# down to Kconfig.  See also MINIKCONF_ARGS in the Makefile:
> +# these two need to be kept in sync.
>  
>  config KVM
>      bool
> @@ -10,6 +11,9 @@ config LINUX
>  config OPENGL
>      bool
>  
> +config X11
> +    bool
> +
>  config SPICE
>      bool
>  
> diff --git a/Makefile b/Makefile
> index 3658310..959ab9e 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -313,8 +313,8 @@ DOCS=
>  endif
>  
>  SUBDIR_MAKEFLAGS=$(if $(V),,--no-print-directory --quiet) BUILD_DIR=$(BUILD_DIR)
> -SUBDIR_DEVICES_MAK=$(patsubst %, %/config-devices.mak, $(TARGET_DIRS))
> -SUBDIR_DEVICES_MAK_DEP=$(patsubst %, %-config-devices.mak.d, $(TARGET_DIRS))
> +SUBDIR_DEVICES_MAK=$(patsubst %, %/config-devices.mak, $(filter %-softmmu, $(TARGET_DIRS)))
> +SUBDIR_DEVICES_MAK_DEP=$(patsubst %, %.d, $(SUBDIR_DEVICES_MAK))
>  
>  ifeq ($(SUBDIR_DEVICES_MAK),)
>  config-all-devices.mak:
> @@ -329,9 +329,23 @@ endif
>  
>  -include $(SUBDIR_DEVICES_MAK_DEP)
>  
> -%/config-devices.mak: default-configs/%.mak $(SRC_PATH)/scripts/make_device_config.sh
> -	$(call quiet-command, \
> -            $(SHELL) $(SRC_PATH)/scripts/make_device_config.sh $< $*-config-devices.mak.d $@ > $@.tmp,"GEN","$@.tmp")
> +# This has to be kept in sync with Kconfig.host.
> +MINIKCONF_ARGS = \
> +    $@ $*-config.devices.mak.d $< $(MINIKCONF_INPUTS) \
> +    CONFIG_KVM=$(CONFIG_KVM) \
> +    CONFIG_SPICE=$(CONFIG_SPICE) \
> +    CONFIG_TPM=$(CONFIG_TPM) \
> +    CONFIG_XEN=$(CONFIG_XEN) \
> +    CONFIG_OPENGL=$(CONFIG_OPENGL) \
> +    CONFIG_X11=$(CONFIG_X11) \
> +    CONFIG_VHOST_USER=$(CONFIG_VHOST_USER) \
> +    CONFIG_LINUX=$(CONFIG_LINUX)
> +
Hi Paolo,
I'm playing with Kconfig but with a simple configuration
(./configure --target-list=x86_64-softmmu --disable-docs) the build fails:
/usr/bin/ld: ../hw/xen/xen-legacy-backend.o: in function `xen_be_register_common':
/home/stefano/repos/qemu-kconfig/hw/xen/xen-legacy-backend.c:757: undefined reference to `xen_9pfs_ops'
collect2: error: ld returned 1 exit status

Analyzing the Makefile.objs files maybe we should pass the CONFIG_VIRTFS from
config-host.mak down to Kconfig.
I tried this simple patch and it seems to fix the issue:

diff --git a/Makefile b/Makefile
index df0732a050..bad583b01c 100644
--- a/Makefile
+++ b/Makefile
@@ -336,6 +336,7 @@ MINIKCONF_ARGS = \
     CONFIG_XEN=$(CONFIG_XEN) \
     CONFIG_OPENGL=$(CONFIG_OPENGL) \
     CONFIG_VHOST_USER=$(CONFIG_VHOST_USER) \
+    CONFIG_VIRTFS=$(CONFIG_VIRTFS) \
     CONFIG_LINUX=$(CONFIG_LINUX)

I'm not sure if we need to add "config VIRTFS" entry in the
Kconfig.host, because it is already defined in hw/9pfs/Kconfig.

Thanks,
Stefano
