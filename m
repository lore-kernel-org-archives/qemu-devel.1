Received: from eggs.gnu.org ([209.51.188.92]:58169)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gmyOu-0007fY-RR
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 05:07:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gmyOq-0001xt-5e
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 05:07:52 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:52901)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gmyOp-0001wx-P6
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 05:07:48 -0500
Received: by mail-wm1-x343.google.com with SMTP id m1so6163325wml.2
	for <qemu-devel@nongnu.org>; Fri, 25 Jan 2019 02:07:47 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 25 Jan 2019 11:06:52 +0100
Message-Id: <1548410831-19553-34-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1548410831-19553-1-git-send-email-pbonzini@redhat.com>
References: <1548410831-19553-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 33/52] build: switch to Kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: yang.zhong@intel.com, thuth@redhat.com

The make_device_config.sh script is replaced by minikconf, which
is modified to support the same command line as its predecessor.

The roots of the parsing are default-configs/*.mak, Kconfig.host and
hw/Kconfig.  One difference with make_device_config.sh is that all symbols
have to be defined in a Kconfig file, including those coming from the
configure script.  This is the reason for the Kconfig.host file introduced
in the previous patch. Whenever a file in default-configs/*.mak used
$(...) to refer to a config-host.mak symbol, this is replaced by a
Kconfig dependency; this part must be done already in this patch
for bisectability.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Yang Zhong <yang.zhong@intel.com>
Acked-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20190123065618.3520-28-yang.zhong@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Kconfig.host                      |  3 ++-
 Makefile                          | 19 ++++++++++++++++---
 Makefile.target                   |  7 ++++++-
 configure                         |  3 +++
 default-configs/arm-softmmu.mak   |  2 --
 default-configs/i386-softmmu.mak  |  5 +----
 default-configs/lm32-softmmu.mak  |  1 -
 default-configs/pci.mak           |  1 -
 default-configs/ppc-softmmu.mak   |  1 -
 default-configs/ppc64-softmmu.mak |  6 ------
 default-configs/s390x-softmmu.mak |  4 +---
 default-configs/virtio.mak        |  3 ---
 hw/9pfs/Kconfig                   |  1 +
 hw/block/Kconfig                  |  1 +
 hw/display/Kconfig                |  4 ++++
 hw/i386/Kconfig                   |  6 +++++-
 hw/input/Kconfig                  |  5 +++++
 hw/intc/Kconfig                   | 12 ++++++++++++
 hw/misc/Kconfig                   |  2 ++
 hw/ppc/Kconfig                    |  4 ++++
 hw/scsi/Kconfig                   |  6 ++++++
 hw/tpm/Kconfig                    |  2 ++
 hw/vfio/Kconfig                   | 11 +++++++++++
 rules.mak                         |  2 +-
 scripts/make_device_config.sh     | 30 ------------------------------
 25 files changed, 83 insertions(+), 58 deletions(-)
 delete mode 100644 scripts/make_device_config.sh

diff --git a/Kconfig.host b/Kconfig.host
index f43f418..3772627 100644
--- a/Kconfig.host
+++ b/Kconfig.host
@@ -1,5 +1,6 @@
 # These are "proxy" symbols used to pass config-host.mak values
-# down to Kconfig.
+# down to Kconfig.  See also MINIKCONF_ARGS in the Makefile:
+# these two need to be kept in sync.
 
 config KVM
     bool
diff --git a/Makefile b/Makefile
index de898ea..70b9aec 100644
--- a/Makefile
+++ b/Makefile
@@ -326,9 +326,22 @@ endif
 
 -include $(SUBDIR_DEVICES_MAK_DEP)
 
-%/config-devices.mak: default-configs/%.mak $(SRC_PATH)/scripts/make_device_config.sh
-	$(call quiet-command, \
-            $(SHELL) $(SRC_PATH)/scripts/make_device_config.sh $< $*-config-devices.mak.d $@ > $@.tmp,"GEN","$@.tmp")
+# This has to be kept in sync with Kconfig.host.
+MINIKCONF_ARGS = \
+    $@ $*-config.devices.mak.d $< $(MINIKCONF_INPUTS) \
+    CONFIG_KVM=$(CONFIG_KVM) \
+    CONFIG_SPICE=$(CONFIG_SPICE) \
+    CONFIG_TPM=$(CONFIG_TPM) \
+    CONFIG_XEN=$(CONFIG_XEN) \
+    CONFIG_OPENGL=$(CONFIG_OPENGL) \
+    CONFIG_VHOST_USER=$(CONFIG_VHOST_USER) \
+    CONFIG_LINUX=$(CONFIG_LINUX)
+
+MINIKCONF_INPUTS = $(SRC_PATH)/Kconfig.host $(SRC_PATH)/hw/Kconfig
+MINIKCONF = $(PYTHON) $(SRC_PATH)/scripts/minikconf.py \
+
+%/config-devices.mak: default-configs/%.mak $(MINIKCONF_INPUTS)
+	$(call quiet-command, $(MINIKCONF) $(MINIKCONF_ARGS) > $@.tmp, "GEN", "$@.tmp")
 	$(call quiet-command, if test -f $@; then \
 	  if cmp -s $@.old $@; then \
 	    mv $@.tmp $@; \
diff --git a/Makefile.target b/Makefile.target
index 39f72e8..f31692c 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -4,9 +4,12 @@ BUILD_DIR?=$(CURDIR)/..
 
 include ../config-host.mak
 include config-target.mak
-include config-devices.mak
 include $(SRC_PATH)/rules.mak
 
+ifdef CONFIG_SOFTMMU
+include config-devices.mak
+endif
+
 $(call set-vpath, $(SRC_PATH):$(BUILD_DIR))
 ifdef CONFIG_LINUX
 QEMU_CFLAGS += -I../linux-headers
@@ -190,7 +193,9 @@ all-obj-$(CONFIG_SOFTMMU) += $(crypto-obj-y)
 all-obj-$(CONFIG_SOFTMMU) += $(io-obj-y)
 all-obj-$(CONFIG_SOFTMMU) += $(slirp-obj-y)
 
+ifdef CONFIG_SOFTMMU
 $(QEMU_PROG_BUILD): config-devices.mak
+endif
 
 COMMON_LDADDS = ../libqemuutil.a
 
diff --git a/configure b/configure
index 8f312ac..dae1b67 100755
--- a/configure
+++ b/configure
@@ -7377,12 +7377,15 @@ if supported_xen_target $target; then
 fi
 if supported_kvm_target $target; then
     echo "CONFIG_KVM=y" >> $config_target_mak
+    echo "$target/config-devices.mak: CONFIG_KVM=y" >> $config_host_mak
     if test "$vhost_net" = "yes" ; then
         echo "CONFIG_VHOST_NET=y" >> $config_target_mak
         if test "$vhost_user" = "yes" ; then
             echo "CONFIG_VHOST_USER_NET_TEST_$target_name=y" >> $config_host_mak
         fi
     fi
+else
+    echo "$target/config-devices.mak: CONFIG_KVM=n" >> $config_host_mak
 fi
 if supported_hax_target $target; then
     echo "CONFIG_HAX=y" >> $config_target_mak
diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
index 4f0ecba..b0995a0 100644
--- a/default-configs/arm-softmmu.mak
+++ b/default-configs/arm-softmmu.mak
@@ -51,7 +51,6 @@ CONFIG_ARM_V7M=y
 CONFIG_NETDUINO2=y
 
 CONFIG_ARM_GIC=y
-CONFIG_ARM_GIC_KVM=$(CONFIG_KVM)
 CONFIG_ARM_TIMER=y
 CONFIG_ARM_MPTIMER=y
 CONFIG_A9_GTIMER=y
@@ -123,7 +122,6 @@ CONFIG_VERSATILE_PCI=y
 CONFIG_VERSATILE_I2C=y
 
 CONFIG_PCI_EXPRESS_GENERIC_BRIDGE=y
-CONFIG_VFIO=$(CONFIG_LINUX)
 CONFIG_VFIO_PLATFORM=y
 CONFIG_VFIO_XGMAC=y
 CONFIG_VFIO_AMD_XGBE=y
diff --git a/default-configs/i386-softmmu.mak b/default-configs/i386-softmmu.mak
index 15b6287..412c8c5 100644
--- a/default-configs/i386-softmmu.mak
+++ b/default-configs/i386-softmmu.mak
@@ -4,7 +4,6 @@ include pci.mak
 include sound.mak
 include usb.mak
 include hyperv.mak
-CONFIG_QXL=$(CONFIG_SPICE)
 CONFIG_VGA_ISA=y
 CONFIG_VGA_CIRRUS=y
 CONFIG_VMWARE_VGA=y
@@ -37,8 +36,6 @@ CONFIG_HPET=y
 CONFIG_APPLESMC=y
 CONFIG_I8259=y
 CONFIG_PFLASH_CFI01=y
-CONFIG_TPM_TIS=$(CONFIG_TPM)
-CONFIG_TPM_CRB=$(CONFIG_TPM)
 CONFIG_MC146818RTC=y
 CONFIG_PCI_PIIX=y
 CONFIG_WDT_IB700=y
@@ -66,9 +63,9 @@ CONFIG_ACPI_SMBUS=y
 CONFIG_SMBUS_EEPROM=y
 CONFIG_FW_CFG_DMA=y
 CONFIG_I2C=y
-CONFIG_SEV=$(CONFIG_KVM)
 CONFIG_VTD=y
 CONFIG_AMD_IOMMU=y
 CONFIG_PAM=y
+CONFIG_PC=y
 CONFIG_I440FX=y
 CONFIG_Q35=y
diff --git a/default-configs/lm32-softmmu.mak b/default-configs/lm32-softmmu.mak
index 4889348..ef0f4ba 100644
--- a/default-configs/lm32-softmmu.mak
+++ b/default-configs/lm32-softmmu.mak
@@ -2,7 +2,6 @@
 
 CONFIG_LM32=y
 CONFIG_MILKYMIST=y
-CONFIG_MILKYMIST_TMU2=$(CONFIG_OPENGL)
 CONFIG_FRAMEBUFFER=y
 CONFIG_PTIMER=y
 CONFIG_PFLASH_CFI01=y
diff --git a/default-configs/pci.mak b/default-configs/pci.mak
index 0552190..3d4c71d 100644
--- a/default-configs/pci.mak
+++ b/default-configs/pci.mak
@@ -47,6 +47,5 @@ CONFIG_VGA_PCI=y
 CONFIG_BOCHS_DISPLAY=y
 CONFIG_IVSHMEM_DEVICE=$(CONFIG_IVSHMEM)
 CONFIG_ROCKER=y
-CONFIG_VFIO=$(CONFIG_LINUX)
 CONFIG_VFIO_PCI=y
 CONFIG_EDID=y
diff --git a/default-configs/ppc-softmmu.mak b/default-configs/ppc-softmmu.mak
index 52acb7c..90118cb 100644
--- a/default-configs/ppc-softmmu.mak
+++ b/default-configs/ppc-softmmu.mak
@@ -18,7 +18,6 @@ CONFIG_I8259=y
 CONFIG_XILINX=y
 CONFIG_XILINX_ETHLITE=y
 CONFIG_E500=y
-CONFIG_OPENPIC_KVM=$(call land,$(CONFIG_E500),$(CONFIG_KVM))
 CONFIG_PLATFORM_BUS=y
 CONFIG_ETSEC=y
 CONFIG_PPC405=y
diff --git a/default-configs/ppc64-softmmu.mak b/default-configs/ppc64-softmmu.mak
index ccd7b17..a0a9151 100644
--- a/default-configs/ppc64-softmmu.mak
+++ b/default-configs/ppc64-softmmu.mak
@@ -13,12 +13,6 @@ CONFIG_ISA_IPMI_BT=y
 # For pSeries
 CONFIG_PSERIES=y
 CONFIG_VIRTIO_VGA=y
-CONFIG_XICS=$(CONFIG_PSERIES)
-CONFIG_XICS_SPAPR=$(CONFIG_PSERIES)
-CONFIG_XICS_KVM=$(call land,$(CONFIG_PSERIES),$(CONFIG_KVM))
-CONFIG_XIVE=$(CONFIG_PSERIES)
-CONFIG_XIVE_SPAPR=$(CONFIG_PSERIES)
-CONFIG_VFIO_SPAPR=$(CONFIG_PSERIES)
 CONFIG_MEM_DEVICE=y
 CONFIG_DIMM=y
 CONFIG_SPAPR_RNG=y
diff --git a/default-configs/s390x-softmmu.mak b/default-configs/s390x-softmmu.mak
index 6f2c6ce..2794ffb 100644
--- a/default-configs/s390x-softmmu.mak
+++ b/default-configs/s390x-softmmu.mak
@@ -1,12 +1,10 @@
 CONFIG_PCI=y
-CONFIG_VIRTIO_PCI=$(CONFIG_PCI)
+CONFIG_VIRTIO_PCI=y
 include virtio.mak
 CONFIG_SCLPCONSOLE=y
 CONFIG_TERMINAL3270=y
 CONFIG_S390_FLIC=y
-CONFIG_S390_FLIC_KVM=$(CONFIG_KVM)
 CONFIG_WDT_DIAG288=y
 CONFIG_S390_CCW_VIRTIO=y
-CONFIG_VFIO=$(CONFIG_LINUX)
 CONFIG_VFIO_CCW=y
 CONFIG_VFIO_AP=y
diff --git a/default-configs/virtio.mak b/default-configs/virtio.mak
index ecb4420..51599ed 100644
--- a/default-configs/virtio.mak
+++ b/default-configs/virtio.mak
@@ -1,5 +1,3 @@
-CONFIG_VHOST_USER_SCSI=$(call land,$(CONFIG_VHOST_USER),$(CONFIG_LINUX))
-CONFIG_VHOST_USER_BLK=$(call land,$(CONFIG_VHOST_USER),$(CONFIG_LINUX))
 CONFIG_VIRTIO=y
 CONFIG_VIRTIO_9P=$(CONFIG_VIRTFS)
 CONFIG_VIRTIO_BALLOON=y
@@ -12,4 +10,3 @@ CONFIG_VIRTIO_RNG=y
 CONFIG_SCSI=y
 CONFIG_VIRTIO_SCSI=y
 CONFIG_VIRTIO_SERIAL=y
-CONFIG_VIRTIO_INPUT_HOST=$(CONFIG_LINUX)
diff --git a/hw/9pfs/Kconfig b/hw/9pfs/Kconfig
index be8e5b3..84d2366 100644
--- a/hw/9pfs/Kconfig
+++ b/hw/9pfs/Kconfig
@@ -2,3 +2,4 @@ config VIRTFS
 
 config VIRTIO_9P
     bool
+    default y if VIRTFS
diff --git a/hw/block/Kconfig b/hw/block/Kconfig
index 9d418bc..1780569 100644
--- a/hw/block/Kconfig
+++ b/hw/block/Kconfig
@@ -27,3 +27,4 @@ config VIRTIO_BLK
 
 config VHOST_USER_BLK
     bool
+    default y if VHOST_USER && LINUX
diff --git a/hw/display/Kconfig b/hw/display/Kconfig
index d5c022c..429056b 100644
--- a/hw/display/Kconfig
+++ b/hw/display/Kconfig
@@ -51,6 +51,8 @@ config FRAMEBUFFER
 
 config MILKYMIST_TMU2
     bool
+    default y
+    depends on OPENGL
 
 config SM501
     bool
@@ -66,6 +68,8 @@ config VGA
 
 config QXL
     bool
+    default y if PC
+    depends on SPICE && PCI
 
 config VIRTIO_GPU
     bool
diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
index 2dbe2b5..9a0e559 100644
--- a/hw/i386/Kconfig
+++ b/hw/i386/Kconfig
@@ -1,4 +1,8 @@
-config KVM
+config SEV
+    bool
+    default y if PC && KVM
+
+config PC
     bool
 
 config I440FX
diff --git a/hw/input/Kconfig b/hw/input/Kconfig
index 91bae47..98a18a1 100644
--- a/hw/input/Kconfig
+++ b/hw/input/Kconfig
@@ -19,5 +19,10 @@ config TSC2005
 config VIRTIO_INPUT
     bool
 
+config VIRTIO_INPUT_HOST
+    bool
+    default y if LINUX
+    depends on LINUX
+
 config TSC210X
     bool
diff --git a/hw/intc/Kconfig b/hw/intc/Kconfig
index 69adbd1..6eea14e 100644
--- a/hw/intc/Kconfig
+++ b/hw/intc/Kconfig
@@ -21,18 +21,28 @@ config APIC
 
 config ARM_GIC_KVM
     bool
+    default y
+    depends on ARM_GIC && KVM
 
 config OPENPIC_KVM
     bool
+    default y
+    depends on OPENPIC && KVM
 
 config XICS
     bool
+    default y
+    depends on PSERIES
 
 config XICS_SPAPR
     bool
+    default y
+    depends on PSERIES
 
 config XICS_KVM
     bool
+    default y
+    depends on XICS && KVM
 
 config ALLWINNER_A10_PIC
     bool
@@ -42,6 +52,8 @@ config S390_FLIC
 
 config S390_FLIC_KVM
     bool
+    default y
+    depends on S390_FLIC && KVM
 
 config OMPIC
     bool
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index c006b04..cc8dbed 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -48,6 +48,8 @@ config MACIO
 
 config IVSHMEM_DEVICE
     bool
+    default y
+    depends on PCI
 
 config ECCMEMCTL
     bool
diff --git a/hw/ppc/Kconfig b/hw/ppc/Kconfig
index 9da9d7d..b0095e1 100644
--- a/hw/ppc/Kconfig
+++ b/hw/ppc/Kconfig
@@ -45,12 +45,16 @@ config MAC_PMU
 
 config XIVE
     bool
+    default y
+    depends on PSERIES
 
 config MACIO_GPIO
     bool
 
 config XIVE_SPAPR
     bool
+    default y
+    depends on PSERIES
 
 config CUDA
     bool
diff --git a/hw/scsi/Kconfig b/hw/scsi/Kconfig
index eb78478..834413b 100644
--- a/hw/scsi/Kconfig
+++ b/hw/scsi/Kconfig
@@ -19,8 +19,14 @@ config ESP
 config ESP_PCI
     bool
 
+config SPAPR_VSCSI
+    bool
+    default y
+    depends on PSERIES
+
 config VIRTIO_SCSI
     bool
 
 config VHOST_USER_SCSI
     bool
+    default y if VHOST_USER && LINUX
diff --git a/hw/tpm/Kconfig b/hw/tpm/Kconfig
index 2eee8eb..db57388 100644
--- a/hw/tpm/Kconfig
+++ b/hw/tpm/Kconfig
@@ -3,6 +3,8 @@ config TPM
 
 config TPM_TIS
     bool
+    default y if PC
+    depends on TPM
 
 config TPM_CRB
     bool
diff --git a/hw/vfio/Kconfig b/hw/vfio/Kconfig
index 31d8dfc..f896779 100644
--- a/hw/vfio/Kconfig
+++ b/hw/vfio/Kconfig
@@ -1,17 +1,26 @@
 config VFIO
     bool
+    depends on LINUX
 
 config VFIO_PCI
     bool
+    select VFIO
+    depends on LINUX
 
 config VFIO_SPAPR
     bool
+    default y
+    depends on VFIO && LINUX && PSERIES
 
 config VFIO_CCW
     bool
+    select VFIO
+    depends on LINUX
 
 config VFIO_PLATFORM
     bool
+    select VFIO
+    depends on LINUX
 
 config VFIO_XGMAC
     bool
@@ -21,3 +30,5 @@ config VFIO_AMD_XGBE
 
 config VFIO_AP
     bool
+    select VFIO
+    depends on LINUX
diff --git a/rules.mak b/rules.mak
index 86e033d..62cf02e 100644
--- a/rules.mak
+++ b/rules.mak
@@ -144,7 +144,7 @@ cc-option = $(if $(shell $(CC) $1 $2 -S -o /dev/null -xc /dev/null \
 cc-c-option = $(if $(shell $(CC) $1 $2 -c -o /dev/null -xc /dev/null \
                 >/dev/null 2>&1 && echo OK), $2, $3)
 
-VPATH_SUFFIXES = %.c %.h %.S %.cc %.cpp %.m %.mak %.texi %.sh %.rc
+VPATH_SUFFIXES = %.c %.h %.S %.cc %.cpp %.m %.mak %.texi %.sh %.rc Kconfig%
 set-vpath = $(if $1,$(foreach PATTERN,$(VPATH_SUFFIXES),$(eval vpath $(PATTERN) $1)))
 
 # install-prog list, dir
diff --git a/scripts/make_device_config.sh b/scripts/make_device_config.sh
deleted file mode 100644
index 354af31..0000000
--- a/scripts/make_device_config.sh
+++ /dev/null
@@ -1,30 +0,0 @@
-#! /bin/sh
-# Writes a target device config file to stdout, from a default and from
-# include directives therein.  Also emits Makefile dependencies.
-#
-# Usage: make_device_config.sh SRC DEPFILE-NAME DEPFILE-TARGET > DEST
-
-src=$1
-dep=$2
-target=$3
-src_dir=$(dirname $src)
-all_includes=
-
-process_includes () {
-  cat $1 | grep '^include' | \
-  while read include file ; do
-    all_includes="$all_includes $src_dir/$file"
-    process_includes $src_dir/$file
-  done
-}
-
-f=$src
-while [ -n "$f" ] ; do
-  f=$(cat $f | tr -d '\r' | awk '/^include / {printf "'$src_dir'/%s ", $2}')
-  [ $? = 0 ] || exit 1
-  all_includes="$all_includes $f"
-done
-process_includes $src
-
-cat $src $all_includes | grep -v '^include'
-echo "$target: $all_includes" > $dep
-- 
1.8.3.1
