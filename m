Received: from eggs.gnu.org ([209.51.188.92]:58545)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gjo3N-0004ae-Hn
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 11:28:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gjo3K-00039S-BV
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 11:28:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:3451)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gjo3C-000372-FY
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 11:28:26 -0500
References: <20190115141108.934-1-yang.zhong@intel.com>
	<20190115141108.934-21-yang.zhong@intel.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <1f588c8c-7900-42ba-6b9e-c69987748d00@redhat.com>
Date: Wed, 16 Jan 2019 17:28:14 +0100
MIME-Version: 1.0
In-Reply-To: <20190115141108.934-21-yang.zhong@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH v2 20/37] build: switch to Kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yang Zhong <yang.zhong@intel.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, sameo@linux.intel.com, pbonzini@redhat.com, ehabkost@redhat.com

On 2019-01-15 15:10, Yang Zhong wrote:
> From: Paolo Bonzini <pbonzini@redhat.com>
> 
> The make_device_config.sh script is replaced by minikconf, which
> is modified to support the same command line as its predecessor.
> 
> The roots of the parsing are default-configs/*.mak, Kconfig.host and
> hw/Kconfig.  One difference with make_device_config.sh is that all symbols
> have to be defined in a Kconfig file, including those coming from the
> configure script.  This is the reason for the Kconfig.host file introduced
> in the previous patch. Whenever a file in default-configs/*.mak used
> $(...) to refer to a config-host.mak symbol, this is replaced by a
> Kconfig dependency.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Yang Zhong <yang.zhong@intel.com>
> ---
>  Kconfig.host                     |  3 ++-
>  Makefile                         | 14 +++++++++++--
>  Makefile.target                  |  7 ++++++-
>  default-configs/i386-softmmu.mak |  3 ---
>  hw/display/Kconfig               |  2 ++
>  hw/i386/Kconfig                  |  6 ++++++
>  hw/intc/Kconfig                  |  8 ++++++++
>  hw/misc/Kconfig                  |  2 ++
>  hw/tpm/Kconfig                   |  1 +
>  rules.mak                        |  2 +-
>  scripts/make_device_config.sh    | 30 ---------------------------
>  scripts/minikconf.py             | 35 +++++++++++++++++++++++++++++---
>  12 files changed, 72 insertions(+), 41 deletions(-)
>  delete mode 100644 scripts/make_device_config.sh
> 
> diff --git a/Kconfig.host b/Kconfig.host
> index 2136a4c3ec..d7f503d0ca 100644
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
> diff --git a/Makefile b/Makefile
> index a9ac16d94e..01e7c60a0d 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -326,9 +326,19 @@ endif
>  
>  -include $(SUBDIR_DEVICES_MAK_DEP)
>  
> -%/config-devices.mak: default-configs/%.mak $(SRC_PATH)/scripts/make_device_config.sh
> +# This has to be kept in sync with Kconfig.host.
> +MINIKCONF_ARGS = \
> +    CONFIG_KVM=$(CONFIG_KVM) \
> +    CONFIG_SPICE=$(CONFIG_SPICE) \
> +    CONFIG_TPM=$(CONFIG_TPM) \
> +    CONFIG_XEN=$(CONFIG_XEN) \
> +    CONFIG_OPENGL=$(CONFIG_OPENGL)
> +
> +MINIKCONF = $(SHELL) $(SRC_PATH)/scripts/minikconf.sh
> +
> +%/config-devices.mak: default-configs/%-softmmu.mak Kconfig.host hw/Kconfig
>  	$(call quiet-command, \
> -            $(SHELL) $(SRC_PATH)/scripts/make_device_config.sh $< $*-config-devices.mak.d $@ > $@.tmp,"GEN","$@.tmp")
> +            $(MINIKCONF) $@ $*-config-devices.mak.d $^ $(MINIKCONF_ARGS) > $@.tmp, "  GEN   $@.tmp")

Looks like CONFIG_KVM now shows up in all config-devices.mak files ...
that won't work when the target CPU does not match the host CPU, I think
we need some additional logic here...?

 Thomas
