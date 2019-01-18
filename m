Received: from eggs.gnu.org ([209.51.188.92]:36585)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gkSIM-0001Hv-ER
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 06:26:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gkSIH-0007II-0Z
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 06:26:42 -0500
Received: from mga06.intel.com ([134.134.136.31]:47096)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1gkSIG-0006rc-JI
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 06:26:36 -0500
From: Yang Zhong <yang.zhong@intel.com>
Date: Fri, 18 Jan 2019 19:23:53 +0800
Message-Id: <20190118112410.3010-27-yang.zhong@intel.com>
In-Reply-To: <20190118112410.3010-1-yang.zhong@intel.com>
References: <20190118112410.3010-1-yang.zhong@intel.com>
Subject: [Qemu-devel] [RFC PATCH v3 26/43] build: switch to Kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, thuth@redhat.com, peter.maydell@linaro.org, sameo@linux.intel.com, ehabkost@redhat.com, yang.zhong@intel.com

From: Paolo Bonzini <pbonzini@redhat.com>

The make_device_config.sh script is replaced by minikconf, which
is modified to support the same command line as its predecessor.

The roots of the parsing are default-configs/*.mak, Kconfig.host and
hw/Kconfig.  One difference with make_device_config.sh is that all symbols
have to be defined in a Kconfig file, including those coming from the
configure script.  This is the reason for the Kconfig.host file introduced
in the previous patch. Whenever a file in default-configs/*.mak used
$(...) to refer to a config-host.mak symbol, this is replaced by a
Kconfig dependency.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Yang Zhong <yang.zhong@intel.com>
Acked-by: Thomas Huth <thuth@redhat.com>
---
 Kconfig.host                     |  3 ++-
 Makefile                         | 14 +++++++++++--
 Makefile.target                  |  7 ++++++-
 default-configs/i386-softmmu.mak |  3 ---
 hw/display/Kconfig               |  2 ++
 hw/i386/Kconfig                  |  6 ++++++
 hw/intc/Kconfig                  |  8 ++++++++
 hw/misc/Kconfig                  |  2 ++
 hw/tpm/Kconfig                   |  1 +
 rules.mak                        |  2 +-
 scripts/make_device_config.sh    | 30 ---------------------------
 scripts/minikconf.py             | 35 +++++++++++++++++++++++++++++---
 12 files changed, 72 insertions(+), 41 deletions(-)
 delete mode 100644 scripts/make_device_config.sh

diff --git a/Kconfig.host b/Kconfig.host
index 2136a4c3ec..d7f503d0ca 100644
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
index a9ac16d94e..01e7c60a0d 100644
--- a/Makefile
+++ b/Makefile
@@ -326,9 +326,19 @@ endif
 
 -include $(SUBDIR_DEVICES_MAK_DEP)
 
-%/config-devices.mak: default-configs/%.mak $(SRC_PATH)/scripts/make_device_config.sh
+# This has to be kept in sync with Kconfig.host.
+MINIKCONF_ARGS = \
+    CONFIG_KVM=$(CONFIG_KVM) \
+    CONFIG_SPICE=$(CONFIG_SPICE) \
+    CONFIG_TPM=$(CONFIG_TPM) \
+    CONFIG_XEN=$(CONFIG_XEN) \
+    CONFIG_OPENGL=$(CONFIG_OPENGL)
+
+MINIKCONF = $(SHELL) $(SRC_PATH)/scripts/minikconf.sh
+
+%/config-devices.mak: default-configs/%-softmmu.mak Kconfig.host hw/Kconfig
 	$(call quiet-command, \
-            $(SHELL) $(SRC_PATH)/scripts/make_device_config.sh $< $*-config-devices.mak.d $@ > $@.tmp,"GEN","$@.tmp")
+            $(MINIKCONF) $@ $*-config-devices.mak.d $^ $(MINIKCONF_ARGS) > $@.tmp, "  GEN   $@.tmp")
 	$(call quiet-command, if test -f $@; then \
 	  if cmp -s $@.old $@; then \
 	    mv $@.tmp $@; \
diff --git a/Makefile.target b/Makefile.target
index 44ec4b630c..5aa8596a96 100644
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
@@ -187,7 +190,9 @@ all-obj-$(CONFIG_USER_ONLY) += $(crypto-aes-obj-y)
 all-obj-$(CONFIG_SOFTMMU) += $(crypto-obj-y)
 all-obj-$(CONFIG_SOFTMMU) += $(io-obj-y)
 
+ifdef CONFIG_SOFTMMU
 $(QEMU_PROG_BUILD): config-devices.mak
+endif
 
 COMMON_LDADDS = ../libqemuutil.a
 
diff --git a/default-configs/i386-softmmu.mak b/default-configs/i386-softmmu.mak
index 8db7867015..f71284516c 100644
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
diff --git a/hw/display/Kconfig b/hw/display/Kconfig
index d5c022c886..132aeffdbe 100644
--- a/hw/display/Kconfig
+++ b/hw/display/Kconfig
@@ -51,6 +51,7 @@ config FRAMEBUFFER
 
 config MILKYMIST_TMU2
     bool
+    depends on OPENGL
 
 config SM501
     bool
@@ -66,6 +67,7 @@ config VGA
 
 config QXL
     bool
+    depends on SPICE
 
 config VIRTIO_GPU
     bool
diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
index 2dbe2b5d3e..427bda3717 100644
--- a/hw/i386/Kconfig
+++ b/hw/i386/Kconfig
@@ -3,12 +3,18 @@ config KVM
 
 config I440FX
     bool
+    select QXL if SPICE
+    select TPM_TIS if TPM
+    select XEN_I386 if XEN
 
 config ISAPC
     bool
 
 config Q35
     bool
+    select QXL if SPICE
+    select TPM_TIS if TPM
+    select XEN_I386 if XEN
 
 config VTD
     bool
diff --git a/hw/intc/Kconfig b/hw/intc/Kconfig
index 69adbd135f..226ef3ae2e 100644
--- a/hw/intc/Kconfig
+++ b/hw/intc/Kconfig
@@ -21,9 +21,13 @@ config APIC
 
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
@@ -33,6 +37,8 @@ config XICS_SPAPR
 
 config XICS_KVM
     bool
+    default y
+    depends on XICS && KVM
 
 config ALLWINNER_A10_PIC
     bool
@@ -42,6 +48,8 @@ config S390_FLIC
 
 config S390_FLIC_KVM
     bool
+    default y
+    depends on S390_FLIC && KVM
 
 config OMPIC
     bool
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index c006b046d4..cc8dbed24e 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -48,6 +48,8 @@ config MACIO
 
 config IVSHMEM_DEVICE
     bool
+    default y
+    depends on PCI
 
 config ECCMEMCTL
     bool
diff --git a/hw/tpm/Kconfig b/hw/tpm/Kconfig
index 2eee8eb865..da4bb5b6c7 100644
--- a/hw/tpm/Kconfig
+++ b/hw/tpm/Kconfig
@@ -3,6 +3,7 @@ config TPM
 
 config TPM_TIS
     bool
+    depends on TPM
 
 config TPM_CRB
     bool
diff --git a/rules.mak b/rules.mak
index 86e033d815..62cf02e92b 100644
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
index 354af317b3..0000000000
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
diff --git a/scripts/minikconf.py b/scripts/minikconf.py
index 48800591e2..b0b4f76733 100644
--- a/scripts/minikconf.py
+++ b/scripts/minikconf.py
@@ -12,6 +12,7 @@
 
 import os
 import sys
+import re
 
 __all__ = [ 'KconfigParserError', 'KconfigData', 'KconfigParser' ]
 
@@ -329,6 +330,12 @@ class KconfigParser:
         self.get_token()
         self.parse_config()
 
+    def do_assignment(self, var, val):
+        if not var.startswith("CONFIG_"):
+            raise Error('assigned variable should start with CONFIG_')
+        var = self.data.do_var(var[7:])
+        self.data.do_assignment(var, val)
+
     # file management -----
 
     def error_path(self):
@@ -617,6 +624,28 @@ class KconfigParser:
         return None
 
 if __name__ == '__main__':
-    fname = len(sys.argv) > 1 and sys.argv[1] or 'Kconfig.test'
-    data = KconfigParser.parse(open(fname, 'r'))
-    print data.compute_config()
+    argv = sys.argv
+    if len(argv) == 1:
+        print >>sys.stderr, "%s: at least one argument is required" % argv[0]
+        os.exit(1)
+
+    data = KconfigData()
+    parser = KconfigParser(data)
+    for arg in argv[3:]:
+        m = re.match(r'^(CONFIG_[A-Z0-9_]+)=([yn]?)$', arg)
+        if m is not None:
+            name, value = m.groups()
+            parser.do_assignment(name, value == 'y')
+        else:
+            fp = open(arg, 'r')
+            parser.parse_file(fp)
+            fp.close()
+
+    config = data.compute_config()
+    for key in sorted(config.keys()):
+        print 'CONFIG_%s=%s'% (key, (config[key] and 'y' or 'n'))
+
+    deps = open(argv[2], 'w')
+    for fname in data.previously_included:
+        print >>deps, '%s: %s' % (argv[1], fname)
+    deps.close()
-- 
2.17.1
