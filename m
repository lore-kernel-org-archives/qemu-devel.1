Received: from eggs.gnu.org ([2001:4830:134:3::10]:38358)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cK5FT-0001Rr-JK
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 10:25:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cK5FP-0007yM-Ai
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 10:25:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36712)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cK5FP-0007y6-1Z
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 10:25:35 -0500
References: <20161222151828.28292-1-leif.lindholm@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ed47e562-0824-e676-4c82-de88b78bc55a@redhat.com>
Date: Thu, 22 Dec 2016 16:25:31 +0100
MIME-Version: 1.0
In-Reply-To: <20161222151828.28292-1-leif.lindholm@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] smbios: filter based on CONFIG_SMBIOS
 rather than TARGET
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Leif Lindholm <leif.lindholm@linaro.org>, qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Peter Maydell <peter.maydell@linaro.org>



On 22/12/2016 16:18, Leif Lindholm wrote:
> -smbios command line options were accepted but silently ignored on
> TARGET_ARM, due to a test for TARGET_I386 in arch_init.c.
> 
> Copy the mechanism of hw/pci/pci-stub.c to implement an smbios-stub
> instead, enabled for all targets without CONFIG_SMBIOS.
> 
> Signed-off-by: Leif Lindholm <leif.lindholm@linaro.org>
> ---
> 
> Not sure if Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> is semantically correct in this instance, but if it is, please
> add it.
> 
>  arch_init.c                |  8 --------
>  hw/Makefile.objs           |  2 +-
>  hw/smbios/Makefile.objs    |  3 +++
>  hw/smbios/smbios-stub.c    | 31 +++++++++++++++++++++++++++++++
>  hw/smbios/smbios.c         |  2 +-
>  include/hw/smbios/smbios.h |  2 +-
>  vl.c                       |  2 +-
>  7 files changed, 38 insertions(+), 12 deletions(-)
>  create mode 100644 hw/smbios/smbios-stub.c
> 
> diff --git a/arch_init.c b/arch_init.c
> index 5cc58b2..34e7694 100644
> --- a/arch_init.c
> +++ b/arch_init.c
> @@ -28,7 +28,6 @@
>  #include "sysemu/arch_init.h"
>  #include "hw/pci/pci.h"
>  #include "hw/audio/audio.h"
> -#include "hw/smbios/smbios.h"
>  #include "qemu/config-file.h"
>  #include "qemu/error-report.h"
>  #include "qmp-commands.h"
> @@ -248,13 +247,6 @@ void do_acpitable_option(const QemuOpts *opts)
>  #endif
>  }
>  
> -void do_smbios_option(QemuOpts *opts)
> -{
> -#ifdef TARGET_I386
> -    smbios_entry_add(opts);
> -#endif
> -}
> -
>  int kvm_available(void)
>  {
>  #ifdef CONFIG_KVM
> diff --git a/hw/Makefile.objs b/hw/Makefile.objs
> index 0ffd281..2a73ae5 100644
> --- a/hw/Makefile.objs
> +++ b/hw/Makefile.objs
> @@ -33,7 +33,7 @@ devices-dirs-$(CONFIG_VIRTIO) += virtio/
>  devices-dirs-$(CONFIG_SOFTMMU) += watchdog/
>  devices-dirs-$(CONFIG_SOFTMMU) += xen/
>  devices-dirs-$(CONFIG_MEM_HOTPLUG) += mem/
> -devices-dirs-$(CONFIG_SMBIOS) += smbios/
> +devices-dirs-$(CONFIG_SOFTMMU) += smbios/
>  devices-dirs-y += core/
>  common-obj-y += $(devices-dirs-y)
>  obj-y += $(devices-dirs-y)
> diff --git a/hw/smbios/Makefile.objs b/hw/smbios/Makefile.objs
> index c3d3753..ee0712b 100644
> --- a/hw/smbios/Makefile.objs
> +++ b/hw/smbios/Makefile.objs
> @@ -1,2 +1,5 @@
>  common-obj-$(CONFIG_SMBIOS) += smbios.o
>  common-obj-$(call land,$(CONFIG_SMBIOS),$(CONFIG_IPMI)) += smbios_type_38.o
> +
> +common-obj-$(call lnot,$(CONFIG_SMBIOS)) += smbios-stub.o
> +common-obj-$(CONFIG_ALL) += smbios-stub.o
> diff --git a/hw/smbios/smbios-stub.c b/hw/smbios/smbios-stub.c
> new file mode 100644
> index 0000000..3087394
> --- /dev/null
> +++ b/hw/smbios/smbios-stub.c
> @@ -0,0 +1,31 @@
> +/*
> + * SMBIOS stubs for platforms that don't support SMBIOS.
> + *
> + * Copyright (c) 2010 Isaku Yamahata <yamahata at valinux co jp>
> + *                    VA Linux Systems Japan K.K.
> + * Copyright (c) 2016 Leif Lindholm <leif.lindholm@linaro.org>
> + *                    Linaro Ltd.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License along
> + * with this program; if not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/qmp/qerror.h"
> +#include "qmp-commands.h"
> +#include "hw/smbios/smbios.h"
> +
> +void smbios_entry_add(QemuOpts *opts, Error **errp)
> +{
> +    error_setg(errp, QERR_UNSUPPORTED);
> +}
> diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
> index 3a96ced..1a5437a 100644
> --- a/hw/smbios/smbios.c
> +++ b/hw/smbios/smbios.c
> @@ -882,7 +882,7 @@ static void save_opt(const char **dest, QemuOpts *opts, const char *name)
>      }
>  }
>  
> -void smbios_entry_add(QemuOpts *opts)
> +void smbios_entry_add(QemuOpts *opts, Error **errp)
>  {
>      const char *val;
>  
> diff --git a/include/hw/smbios/smbios.h b/include/hw/smbios/smbios.h
> index 1cd53cc..31e8d5f 100644
> --- a/include/hw/smbios/smbios.h
> +++ b/include/hw/smbios/smbios.h
> @@ -257,7 +257,7 @@ struct smbios_type_127 {
>      struct smbios_structure_header header;
>  } QEMU_PACKED;
>  
> -void smbios_entry_add(QemuOpts *opts);
> +void smbios_entry_add(QemuOpts *opts, Error **errp);
>  void smbios_set_cpuid(uint32_t version, uint32_t features);
>  void smbios_set_defaults(const char *manufacturer, const char *product,
>                           const char *version, bool legacy_mode,
> diff --git a/vl.c b/vl.c
> index d77dd86..d2a0d75 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -3711,7 +3711,7 @@ int main(int argc, char **argv, char **envp)
>                  if (!opts) {
>                      exit(1);
>                  }
> -                do_smbios_option(opts);
> +                smbios_entry_add(opts, &error_abort);

This should be error_fatal.  Will fix and apply.

Paolo

>                  break;
>              case QEMU_OPTION_fwcfg:
>                  opts = qemu_opts_parse_noisily(qemu_find_opts("fw_cfg"),
> 
