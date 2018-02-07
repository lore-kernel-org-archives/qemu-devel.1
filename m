Received: from eggs.gnu.org ([2001:4830:134:3::10]:35607)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ejNWL-0003ni-ED
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 06:04:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ejNWG-00032A-M9
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 06:04:09 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:44438)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ejNWG-00031a-GP
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 06:04:04 -0500
Received: by mail-wr0-f196.google.com with SMTP id v31so526208wrc.11
	for <qemu-devel@nongnu.org>; Wed, 07 Feb 2018 03:04:04 -0800 (PST)
References: <20180206203048.11096-1-rkagan@virtuozzo.com>
	<20180206203048.11096-22-rkagan@virtuozzo.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f7e37a67-b1fc-c4cf-a7d1-a958b3b84f5c@redhat.com>
Date: Wed, 7 Feb 2018 12:04:01 +0100
MIME-Version: 1.0
In-Reply-To: <20180206203048.11096-22-rkagan@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 21/34] vmbus: build configuration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Roman Kagan <rkagan@virtuozzo.com>, qemu-devel@nongnu.org
Cc: Ben Warren <ben@skyportsystems.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Krish Sadhukhan <krish.sadhukhan@oracle.com>, "Marcos E. Matsunaga" <Marcos.Matsunaga@oracle.com>, Jan Dakinevich <jan.dakinevich@virtuozzo.com>, Vadim Rozenfeld <vrozenfe@redhat.com>, "Denis V. Lunev" <den@openvz.org>, si-wei liu <si-wei.liu@oracle.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, Cathy Avery <cavery@redhat.com>

On 06/02/2018 21:30, Roman Kagan wrote:
> From: Evgeny Yakovlev <eyakovlev@virtuozzo.com>
> 
> Add option to configure and makefiles to enable building vmbus support
> (default to "on" on Linux and "off" otherwise).

Maybe default to on if KVM is supported?  Could it just be

CONFIG_VMBUS=$(CONFIG_KVM)

in default-configs/ instead of having a configure option?

> Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>

Missing Evgeny's SoB.

Paolo

> ---
>  configure        | 11 +++++++++++
>  hw/Makefile.objs |  1 +
>  2 files changed, 12 insertions(+)
> 
> diff --git a/configure b/configure
> index 302fdc92ff..5a0ca5dc4a 100755
> --- a/configure
> +++ b/configure
> @@ -436,6 +436,7 @@ jemalloc="no"
>  replication="yes"
>  vxhs=""
>  libxml2=""
> +vmbus="no"
>  
>  supported_cpu="no"
>  supported_os="no"
> @@ -804,6 +805,7 @@ Linux)
>    vhost_net="yes"
>    vhost_scsi="yes"
>    vhost_vsock="yes"
> +  vmbus="yes"
>    QEMU_INCLUDES="-I\$(SRC_PATH)/linux-headers -I$(pwd)/linux-headers $QEMU_INCLUDES"
>    supported_os="yes"
>  ;;
> @@ -1341,6 +1343,10 @@ for opt do
>    ;;
>    --disable-git-update) git_update=no
>    ;;
> +  --disable-vmbus) vmbus="no"
> +  ;;
> +  --enable-vmbus) vmbus="yes"
> +  ;;
>    *)
>        echo "ERROR: unknown option $opt"
>        echo "Try '$0 --help' for more information"
> @@ -1592,6 +1598,7 @@ disabled with --disable-FEATURE, default is enabled if available:
>    crypto-afalg    Linux AF_ALG crypto backend driver
>    vhost-user      vhost-user support
>    capstone        capstone disassembler support
> +  vmbus           Hyper-V VMBus devices support
>  
>  NOTE: The object files are built at the place where configure is launched
>  EOF
> @@ -5657,6 +5664,7 @@ echo "avx2 optimization $avx2_opt"
>  echo "replication support $replication"
>  echo "VxHS block device $vxhs"
>  echo "capstone          $capstone"
> +echo "vmbus support     $vmbus"
>  
>  if test "$sdl_too_old" = "yes"; then
>  echo "-> Your SDL version is too old - please upgrade to have SDL support"
> @@ -6347,6 +6355,9 @@ fi
>  if test "$have_static_assert" = "yes" ; then
>    echo "CONFIG_STATIC_ASSERT=y" >> $config_host_mak
>  fi
> +if test "$vmbus" = "yes" ; then
> +  echo "CONFIG_VMBUS=y" >> $config_host_mak
> +fi
>  
>  if test "$have_utmpx" = "yes" ; then
>    echo "HAVE_UTMPX=y" >> $config_host_mak
> diff --git a/hw/Makefile.objs b/hw/Makefile.objs
> index cf4cb2010b..c12fc0cc22 100644
> --- a/hw/Makefile.objs
> +++ b/hw/Makefile.objs
> @@ -34,6 +34,7 @@ devices-dirs-$(CONFIG_SOFTMMU) += watchdog/
>  devices-dirs-$(CONFIG_SOFTMMU) += xen/
>  devices-dirs-$(CONFIG_MEM_HOTPLUG) += mem/
>  devices-dirs-$(CONFIG_SOFTMMU) += smbios/
> +devices-dirs-$(CONFIG_VMBUS) += vmbus/
>  devices-dirs-y += core/
>  common-obj-y += $(devices-dirs-y)
>  obj-y += $(devices-dirs-y)
> 
