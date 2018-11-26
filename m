Received: from eggs.gnu.org ([2001:4830:134:3::10]:45222)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gRKAO-000721-FR
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 11:55:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gRKAL-0004wI-4G
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 11:55:24 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38240)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gRKAK-0004vy-Te
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 11:55:21 -0500
Received: by mail-wm1-f65.google.com with SMTP id k198so19341150wmd.3
	for <qemu-devel@nongnu.org>; Mon, 26 Nov 2018 08:55:20 -0800 (PST)
References: <1543238443-4993-1-git-send-email-pbonzini@redhat.com>
	<1543238443-4993-5-git-send-email-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <34a61aee-0368-08e0-f205-3520db81c88a@redhat.com>
Date: Mon, 26 Nov 2018 17:55:06 +0100
MIME-Version: 1.0
In-Reply-To: <1543238443-4993-5-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 4/5] vhost-net: compile it on all targets
 that have virtio-net.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

On 26/11/18 14:20, Paolo Bonzini wrote:
> This shows a preexisting bug: if a KVM target did not have virtio-net enabled,
> it would fail with undefined symbols when vhost was enabled.  This must now
> be fixed, lest targets that have no virtio-net fail to compile.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  configure              | 11 ++++-------
>  hw/net/Makefile.objs   |  4 ++--
>  include/exec/poison.h  |  1 -
>  tests/Makefile.include |  5 +----
>  4 files changed, 7 insertions(+), 14 deletions(-)
> 
> diff --git a/configure b/configure
> index cda17ef..b3b4464 100755
> --- a/configure
> +++ b/configure
> @@ -6512,7 +6512,10 @@ fi
>  if test "$vhost_scsi" = "yes" ; then
>    echo "CONFIG_VHOST_SCSI=y" >> $config_host_mak
>  fi
> -if test "$vhost_net" = "yes" -a "$vhost_user" = "yes"; then
> +if test "$vhost_net" = "yes" ; then
> +  echo "CONFIG_VHOST_NET=y" >> $config_host_mak
> +fi
> +if test "$vhost_net_user" = "yes" ; then
>    echo "CONFIG_VHOST_NET_USER=y" >> $config_host_mak
>  fi
>  if test "$vhost_crypto" = "yes" ; then
> @@ -7275,12 +7278,6 @@ if supported_xen_target $target; then
>  fi
>  if supported_kvm_target $target; then
>      echo "CONFIG_KVM=y" >> $config_target_mak
> -    if test "$vhost_net" = "yes" ; then
> -        echo "CONFIG_VHOST_NET=y" >> $config_target_mak
> -        if test "$vhost_user" = "yes" ; then
> -            echo "CONFIG_VHOST_USER_NET_TEST_$target_name=y" >> $config_host_mak
> -        fi
> -    fi
>  fi
>  if supported_hax_target $target; then
>      echo "CONFIG_HAX=y" >> $config_target_mak
> diff --git a/hw/net/Makefile.objs b/hw/net/Makefile.objs
> index c2705e6..2d7ee0a 100644
> --- a/hw/net/Makefile.objs
> +++ b/hw/net/Makefile.objs
> @@ -37,8 +37,8 @@ obj-$(CONFIG_PSERIES) += spapr_llan.o
>  obj-$(CONFIG_XILINX_ETHLITE) += xilinx_ethlite.o
>  
>  obj-$(CONFIG_VIRTIO_NET) += virtio-net.o
> -obj-$(CONFIG_VHOST_NET) += vhost_net.o
> -common-obj-$(call lnot,$(CONFIG_VHOST_NET)) += vhost_net-stub.o
> +common-obj-$(call land,$(CONFIG_VIRTIO_NET),$(CONFIG_VHOST_NET)) += vhost_net.o
> +common-obj-$(call lnot,$(call land,$(CONFIG_VIRTIO_NET),$(CONFIG_VHOST_NET))) += vhost_net-stub.o
>  common-obj-$(CONFIG_ALL) += vhost_net-stub.o
>  
>  obj-$(CONFIG_ETSEC) += fsl_etsec/etsec.o fsl_etsec/registers.o \
> diff --git a/include/exec/poison.h b/include/exec/poison.h
> index 32d5378..b158632 100644
> --- a/include/exec/poison.h
> +++ b/include/exec/poison.h
> @@ -85,7 +85,6 @@
>  #pragma GCC poison CONFIG_XTENSA_DIS
>  
>  #pragma GCC poison CONFIG_LINUX_USER
> -#pragma GCC poison CONFIG_VHOST_NET
>  #pragma GCC poison CONFIG_KVM
>  #pragma GCC poison CONFIG_SOFTMMU
>  
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index fb0b449..03a64ce 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -204,10 +204,7 @@ check-qtest-i386-$(CONFIG_USB_XHCI_NEC) += tests/usb-hcd-xhci-test$(EXESUF)
>  check-qtest-i386-y += tests/cpu-plug-test$(EXESUF)
>  check-qtest-i386-y += tests/q35-test$(EXESUF)
>  check-qtest-i386-y += tests/vmgenid-test$(EXESUF)
> -check-qtest-i386-$(CONFIG_VHOST_USER_NET_TEST_i386) += tests/vhost-user-test$(EXESUF)
> -ifeq ($(CONFIG_VHOST_USER_NET_TEST_i386),)
> -check-qtest-x86_64-$(CONFIG_VHOST_USER_NET_TEST_x86_64) += tests/vhost-user-test$(EXESUF)
> -endif
> +check-qtest-i386-$(CONFIG_VHOST_NET_USER) += tests/vhost-user-test$(EXESUF)
>  check-qtest-i386-$(CONFIG_TPM_CRB) += tests/tpm-crb-swtpm-test$(EXESUF)
>  check-qtest-i386-$(CONFIG_TPM_CRB) += tests/tpm-crb-test$(EXESUF)
>  check-qtest-i386-$(CONFIG_TPM_TIS) += tests/tpm-tis-swtpm-test$(EXESUF)
> 
