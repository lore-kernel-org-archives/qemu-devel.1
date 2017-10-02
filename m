Received: from eggs.gnu.org ([2001:4830:134:3::10]:39103)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dz2cO-0000Fu-58
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 11:27:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dz2bm-00084s-7h
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 11:26:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51083)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dz2bk-00083y-VS
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 11:26:14 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  2 Oct 2017 17:25:48 +0200
Message-Id: <20171002152552.27999-29-armbru@redhat.com>
In-Reply-To: <20171002152552.27999-1-armbru@redhat.com>
References: <20171002152552.27999-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC PATCH 28/32] vl: QAPIfy command line option
 definition
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com, marcandre.lureau@redhat.com, eblake@redhat.com
List-ID: <qemu-devel.nongnu.org>

Move options definition from qemu-options.hx to the QAPI schema.

Schema deficiencies:

* TODO rework doc strings into QAPIDoc format
* TODO generate (parts of) 'help' from 'data'?
* FIXME many 'str' option arguments (marked FIXME/TODO) need to be QAPIfi=
ed,
  anything that can't be QAPIfied needs to be replaced & deprecated
* FIXME conditionals (marked #if in qapi/options.json)
* TODO move the non-miscellaneous options next to their subsystem's
* schema definitions

qemu-doc breakage:

* FIXME need to include options part of
  docs/interop/qemu-qmp-qapi.texi into qemu-doc
* FIXME several references in qemu-doc

vl.c TODOs:

* Drop conditionals hackery once we have schema conditionals
* Read and write .json config files
* How can we port -set from QemuOpts to QAPI?

The next few commits QAPIfy a few easy 'str' option arguments, to
demonstrate how.  Many more remain, and some of them are going to be
harder.

QAPIfication switches from the QemuOpts parser to keyval_parse(),
which isn't 100% backward compatible.  We need to decide how far to
push reproducing QemuOpts parsing quirks.

QemuOpts also serves as configuration repository.  QAPIfication gets
rid of that.  Code relying on the configuration repository features
will need updates.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 .gitignore             |    2 -
 Makefile               |   18 +-
 include/qemu-common.h  |    2 +-
 os-posix.c             |   26 +-
 os-win32.c             |    3 +-
 qapi-schema.json       |    1 +
 qapi/options.json      | 4574 ++++++++++++++++++++++++++++++++++++++++++=
++++++
 qemu-doc.texi          |    4 +-
 qemu-options-wrapper.h |   41 -
 qemu-options.h         |   36 -
 qemu-options.hx        | 4256 ------------------------------------------=
--
 scripts/qapi.py        |   15 +-
 vl.c                   |  694 ++++----
 13 files changed, 4961 insertions(+), 4711 deletions(-)
 create mode 100644 qapi/options.json
 delete mode 100644 qemu-options-wrapper.h
 delete mode 100644 qemu-options.h
 delete mode 100644 qemu-options.hx

diff --git a/.gitignore b/.gitignore
index 84a57060ad..8a79affa46 100644
--- a/.gitignore
+++ b/.gitignore
@@ -39,8 +39,6 @@
 /qemu-doc.txt
 /qemu-img
 /qemu-nbd
-/qemu-options.def
-/qemu-options.texi
 /qemu-img-cmds.texi
 /qemu-img-cmds.h
 /qemu-io
diff --git a/Makefile b/Makefile
index 5e858f7295..fcce2dd5f9 100644
--- a/Makefile
+++ b/Makefile
@@ -51,7 +51,7 @@ endif
=20
 include $(SRC_PATH)/rules.mak
=20
-GENERATED_FILES =3D qemu-version.h config-host.h qemu-options.def
+GENERATED_FILES =3D qemu-version.h config-host.h
 GENERATED_FILES +=3D builtin-qapi-types.h builtin-qapi-types.c
 GENERATED_FILES +=3D builtin-qapi-visit.h builtin-qapi-visit.c
 GENERATED_FILES +=3D qmp-commands.h qapi-types.h qapi-visit.h qapi-event=
.h
@@ -314,8 +314,6 @@ qemu-version.h: FORCE
=20
 config-host.h: config-host.h-timestamp
 config-host.h-timestamp: config-host.mak
-qemu-options.def: $(SRC_PATH)/qemu-options.hx $(SRC_PATH)/scripts/hxtool
-	$(call quiet-command,sh $(SRC_PATH)/scripts/hxtool -h < $< > $@,"GEN","=
$@")
=20
 SUBDIR_RULES=3D$(patsubst %,subdir-%, $(TARGET_DIRS))
 SOFTMMU_SUBDIR_RULES=3D$(filter %-softmmu,$(SUBDIR_RULES))
@@ -422,6 +420,7 @@ qapi-modules =3D $(SRC_PATH)/qapi-schema.json $(SRC_P=
ATH)/qapi/common.json \
                $(SRC_PATH)/qapi/introspect.json \
                $(SRC_PATH)/qapi/migration.json \
                $(SRC_PATH)/qapi/net.json \
+               $(SRC_PATH)/qapi/options.json \
                $(SRC_PATH)/qapi/rocker.json \
                $(SRC_PATH)/qapi/run-state.json \
                $(SRC_PATH)/qapi/sockets.json \
@@ -529,7 +528,6 @@ module_block.h: $(SRC_PATH)/scripts/modules/module_bl=
ock.py config-host.mak
 clean:
 # avoid old build problems by removing potentially incorrect old files
 	rm -f config.mak op-i386.h opc-i386.h gen-op-i386.h op-arm.h opc-arm.h =
gen-op-arm.h
-	rm -f qemu-options.def
 	rm -f *.msi
 	find . \( -name '*.so' -o -name '*.dll' -o -name '*.mo' -o -name '*.[od=
a]' \) -type f -exec rm {} +
 	rm -f $(filter-out %.tlb,$(TOOLS)) $(HELPERS-y) qemu-ga TAGS cscope.* *=
.pod *~ */*~
@@ -544,7 +542,6 @@ clean:
 	rm -rf qga/qapi-generated
 	for d in $(ALL_SUBDIRS); do \
 	if test -d $$d; then $(MAKE) -C $$d $@ || exit 1; fi; \
-	rm -f $$d/qemu-options.def; \
         done
 	rm -f $(SUBDIR_DEVICES_MAK) config-all-devices.mak
=20
@@ -556,7 +553,7 @@ qemu-%.tar.bz2:
 	$(SRC_PATH)/scripts/make-release "$(SRC_PATH)" "$(patsubst qemu-%.tar.b=
z2,%,$@)"
=20
 distclean: clean
-	rm -f config-host.mak config-host.h* config-host.ld $(DOCS) qemu-option=
s.texi qemu-img-cmds.texi qemu-monitor.texi qemu-monitor-info.texi
+	rm -f config-host.mak config-host.h* config-host.ld $(DOCS) qemu-img-cm=
ds.texi qemu-monitor.texi qemu-monitor-info.texi
 	rm -f config-all-devices.mak config-all-disas.mak config.status
 	rm -f po/*.mo tests/qemu-iotests/common.env
 	rm -f roms/seabios/config.mak roms/vgabios/config.mak
@@ -715,7 +712,7 @@ ui/console-gl.o: $(SRC_PATH)/ui/console-gl.c \
=20
 # documentation
 MAKEINFO=3Dmakeinfo
-MAKEINFOINCLUDES=3D -I docs -I $(<D) -I $(@D)
+MAKEINFOINCLUDES=3D -I docs -I $(<D) -I $(@D) -I $(SRC_PATH)
 MAKEINFOFLAGS=3D--no-split --number-sections $(MAKEINFOINCLUDES)
 TEXI2PODFLAGS=3D$(MAKEINFOINCLUDES) "-DVERSION=3D$(VERSION)"
 TEXI2PDFFLAGS=3D$(if $(V),,--quiet) -I $(SRC_PATH) $(MAKEINFOINCLUDES)
@@ -737,9 +734,6 @@ docs/version.texi: $(SRC_PATH)/VERSION
 %.pdf: %.texi docs/version.texi
 	$(call quiet-command,texi2pdf $(TEXI2PDFFLAGS) $< -o $@,"GEN","$@")
=20
-qemu-options.texi: $(SRC_PATH)/qemu-options.hx $(SRC_PATH)/scripts/hxtoo=
l
-	$(call quiet-command,sh $(SRC_PATH)/scripts/hxtool -t < $< > $@,"GEN","=
$@")
-
 qemu-monitor.texi: $(SRC_PATH)/hmp-commands.hx $(SRC_PATH)/scripts/hxtoo=
l
 	$(call quiet-command,sh $(SRC_PATH)/scripts/hxtool -t < $< > $@,"GEN","=
$@")
=20
@@ -757,7 +751,7 @@ docs/interop/qemu-qmp-qapi.texi: $(qapi-modules)
 docs/interop/qemu-ga-qapi.texi: $(SRC_PATH)/qga/qapi-schema.json
 	$(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi2texi.py $< > $@=
,"GEN","$@")
=20
-qemu.1: qemu-doc.texi qemu-options.texi qemu-monitor.texi qemu-monitor-i=
nfo.texi
+qemu.1: qemu-doc.texi docs/interop/qemu-qmp-ref.texi  qemu-monitor.texi =
qemu-monitor-info.texi
 qemu.1: qemu-option-trace.texi
 qemu-img.1: qemu-img.texi qemu-option-trace.texi qemu-img-cmds.texi
 fsdev/virtfs-proxy-helper.1: fsdev/virtfs-proxy-helper.texi
@@ -771,7 +765,7 @@ pdf: qemu-doc.pdf docs/interop/qemu-qmp-ref.pdf docs/=
interop/qemu-ga-ref.pdf
 txt: qemu-doc.txt docs/interop/qemu-qmp-ref.txt docs/interop/qemu-ga-ref=
.txt
=20
 qemu-doc.html qemu-doc.info qemu-doc.pdf qemu-doc.txt: \
-	qemu-img.texi qemu-nbd.texi qemu-options.texi qemu-option-trace.texi \
+	qemu-img.texi qemu-nbd.texi docs/interop/qemu-qmp-ref.texi  qemu-option=
-trace.texi \
 	qemu-monitor.texi qemu-img-cmds.texi qemu-ga.texi \
 	qemu-monitor-info.texi docs/qemu-block-drivers.texi
=20
diff --git a/include/qemu-common.h b/include/qemu-common.h
index 0456c79df4..871f622d6a 100644
--- a/include/qemu-common.h
+++ b/include/qemu-common.h
@@ -139,7 +139,7 @@ char *qemu_find_file(int type, const char *name);
 /* OS specific functions */
 void os_setup_early_signal_handling(void);
 char *os_find_datadir(void);
-void os_parse_cmd_args(int index, const char *optarg);
+void os_parse_cmd_args(const QAPIOption *opt);
=20
 #include "qemu/module.h"
=20
diff --git a/os-posix.c b/os-posix.c
index b9c2343b1e..4c134c9dc5 100644
--- a/os-posix.c
+++ b/os-posix.c
@@ -32,7 +32,6 @@
 /* Needed early for CONFIG_BSD etc. */
 #include "sysemu/sysemu.h"
 #include "net/slirp.h"
-#include "qemu-options.h"
 #include "qemu/error-report.h"
 #include "qemu/log.h"
 #include "qemu/cutils.h"
@@ -131,35 +130,38 @@ void os_set_proc_name(const char *s)
  * Parse OS specific command line options.
  * return 0 if option handled, -1 otherwise
  */
-void os_parse_cmd_args(int index, const char *optarg)
+void os_parse_cmd_args(const QAPIOption *opt)
 {
-    switch (index) {
+    switch (opt->type) {
 #ifdef CONFIG_SLIRP
-    case QEMU_OPTION_smb:
+    case QAPI_OPTION_KIND_SMB:
         error_report("The -smb option is deprecated. "
                      "Please use '-netdev user,smb=3D...' instead.");
-        if (net_slirp_smb(optarg) < 0)
+        if (net_slirp_smb(opt->u.smb.data) < 0) {
             exit(1);
+        }
         break;
 #endif
-    case QEMU_OPTION_runas:
-        user_pwd =3D getpwnam(optarg);
+    case QAPI_OPTION_KIND_RUNAS:
+        user_pwd =3D getpwnam(opt->u.runas.data);
         if (!user_pwd) {
-            fprintf(stderr, "User \"%s\" doesn't exist\n", optarg);
+            fprintf(stderr, "User \"%s\" doesn't exist\n", opt->u.runas.=
data);
             exit(1);
         }
         break;
-    case QEMU_OPTION_chroot:
-        chroot_dir =3D optarg;
+    case QAPI_OPTION_KIND_CHROOT:
+        chroot_dir =3D opt->u.chroot.data;
         break;
-    case QEMU_OPTION_daemonize:
+    case QAPI_OPTION_KIND_DAEMONIZE:
         daemonize =3D 1;
         break;
 #if defined(CONFIG_LINUX)
-    case QEMU_OPTION_enablefips:
+    case QAPI_OPTION_KIND_ENABLE_FIPS:
         fips_set_state(true);
         break;
 #endif
+    default:
+        ;
     }
 }
=20
diff --git a/os-win32.c b/os-win32.c
index 586a7c7d49..7b01cf821f 100644
--- a/os-win32.c
+++ b/os-win32.c
@@ -26,7 +26,6 @@
 #include <windows.h>
 #include <mmsystem.h>
 #include "sysemu/sysemu.h"
-#include "qemu-options.h"
=20
 /***********************************************************/
 /* Functions missing in mingw */
@@ -93,7 +92,7 @@ void os_set_line_buffering(void)
  * Parse OS specific command line options.
  * return 0 if option handled, -1 otherwise
  */
-void os_parse_cmd_args(int index, const char *optarg)
+void os_parse_cmd_args(const QEMUOption *opt)
 {
     return;
 }
diff --git a/qapi-schema.json b/qapi-schema.json
index a6ef550fd5..a2a096d172 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -96,6 +96,7 @@
 { 'include': 'qapi/transaction.json' }
 { 'include': 'qapi/trace.json' }
 { 'include': 'qapi/introspect.json' }
+{ 'include': 'qapi/options.json' }
=20
 ##
 # =3D Miscellanea
diff --git a/qapi/options.json b/qapi/options.json
new file mode 100644
index 0000000000..5a8fdc04ad
--- /dev/null
+++ b/qapi/options.json
@@ -0,0 +1,4574 @@
+# -*- Mode: Python -*-
+#
+# Copyright (C) 2017 Red Hat, Inc.
+#
+# Authors:
+#  Markus Armbruster <armbru@redhat.com>
+#
+# This work is licensed under the terms of the GNU GPL, version 2 or lat=
er.
+# See the COPYING file in the top-level directory.
+
+#
+# TODO rework doc strings into QAPIDoc format
+# TODO generate (parts of) 'help' from 'data'?
+# FIXME many 'str' option arguments (marked FIXME) need to be QAPIfied
+#       anything that can't be QAPIfied needs to be replaced & deprecate=
d
+# FIXME conditionals (marked #if)
+#
+
+##
+# =3D Miscellaneous command line options
+#
+# TODO move the non-miscellaneous options next to their subsystem's
+# schema definitions
+##
+
+##
+# =3D=3D Standard options
+##
+
+##
+# @--help:
+# Display help and exit
+##
+{ 'option': '--help', 'short': 'h',
+  'help': '-h or -help     display this help and exit' }
+
+##
+# @--version:
+# Display version information and exit
+##
+{ 'option': '--version',
+  'help': '-version        display version information and exit' }
+
+##
+# @--machine:
+# !texinfo
+# -machine [type=3D]@var{name}[,prop=3D@var{value}[,...]]@*
+# Select the emulated machine by @var{name}. Use @code{-machine help} to=
 list
+# available machines.
+#
+# For architectures which aim to support live migration compatibility
+# across releases, each release will introduce a new versioned machine
+# type. For example, the 2.8.0 release introduced machine types
+# ``pc-i440fx-2.8'' and ``pc-q35-2.8'' for the x86_64/i686 architectures=
.
+#
+# To allow live migration of guests from QEMU version 2.8.0, to QEMU
+# version 2.9.0, the 2.9.0 version must support the ``pc-i440fx-2.8''
+# and ``pc-q35-2.8'' machines too. To allow users live migrating VMs
+# to skip multiple intermediate releases when upgrading, new releases
+# of QEMU will support machine types from many previous versions.
+#
+# Supported machine properties are:
+# @table @option
+# @item accel=3D@var{accels1}[:@var{accels2}[:...]]
+# This is used to enable an accelerator. Depending on the target archite=
cture,
+# kvm, xen, hax or tcg can be available. By default, tcg is used. If the=
re is
+# more than one accelerator specified, the next one is used if the previ=
ous one
+# fails to initialize.
+# @item kernel_irqchip=3Don|off
+# Controls in-kernel irqchip support for the chosen accelerator when ava=
ilable.
+# @item gfx_passthru=3Don|off
+# Enables IGD GFX passthrough support for the chosen machine when availa=
ble.
+# @item vmport=3Don|off|auto
+# Enables emulation of VMWare IO port, for vmmouse etc. auto says to sel=
ect the
+# value based on accel. For accel=3Dxen the default is off otherwise the=
 default
+# is on.
+# @item kvm_shadow_mem=3Dsize
+# Defines the size of the KVM shadow MMU.
+# @item dump-guest-core=3Don|off
+# Include guest memory in a core dump. The default is on.
+# @item mem-merge=3Don|off
+# Enables or disables memory merge support. This feature, when supported=
 by
+# the host, de-duplicates identical memory pages among VMs instances
+# (enabled by default).
+# @item aes-key-wrap=3Don|off
+# Enables or disables AES key wrapping support on s390-ccw hosts. This f=
eature
+# controls whether AES wrapping keys will be created to allow
+# execution of AES cryptographic functions.  The default is on.
+# @item dea-key-wrap=3Don|off
+# Enables or disables DEA key wrapping support on s390-ccw hosts. This f=
eature
+# controls whether DEA wrapping keys will be created to allow
+# execution of DEA cryptographic functions.  The default is on.
+# @item nvdimm=3Don|off
+# Enables or disables NVDIMM support. The default is off.
+# @item s390-squash-mcss=3Don|off
+# Enables or disables squashing subchannels into the default css.
+# The default is off.
+# @item enforce-config-section=3Don|off
+# If @option{enforce-config-section} is set to @var{on}, force migration
+# code to send configuration section even if the machine-type sets the
+# @option{migration.send-configuration} property to @var{off}.
+# NOTE: this parameter is deprecated. Please use @option{-global}
+# @option{migration.send-configuration}=3D@var{on|off} instead.
+# @end table
+# !end texinfo
+##
+{ 'option': '--machine', 'short': 'M',
+  'data': 'str',                # FIXME QAPIfy qemu_machine_opts, machin=
e_parse(), machine_set_property()
+  'help': [
+"-machine [type=3D]name[,prop[=3Dvalue][,...]]",
+"                selects emulated machine ('-machine help' for list)",
+"                property accel=3Daccel1[:accel2[:...]] selects accelera=
tor",
+"                supported accelerators are kvm, xen, hax or tcg (defaul=
t: tcg)",
+"                kernel_irqchip=3Don|off|split controls accelerated irqc=
hip support (default=3Doff)",
+"                vmport=3Don|off|auto controls emulation of vmport (defa=
ult: auto)",
+"                kvm_shadow_mem=3Dsize of KVM shadow MMU in bytes",
+"                dump-guest-core=3Don|off include guest memory in a core=
 dump (default=3Don)",
+"                mem-merge=3Don|off controls memory merge support (defau=
lt: on)",
+"                igd-passthru=3Don|off controls IGD GFX passthrough supp=
ort (default=3Doff)",
+"                aes-key-wrap=3Don|off controls support for AES key wrap=
ping (default=3Don)",
+"                dea-key-wrap=3Don|off controls support for DEA key wrap=
ping (default=3Don)",
+"                suppress-vmdesc=3Don|off disables self-describing migra=
tion (default=3Doff)",
+"                nvdimm=3Don|off controls NVDIMM support (default=3Doff)=
",
+"                enforce-config-section=3Don|off enforce configuration s=
ection migration (default=3Doff)",
+"                s390-squash-mcss=3Don|off controls support for squashin=
g into default css (default=3Doff)"] }
+
+##
+# @--cpu:
+# !texinfo
+# -cpu @var{model}@*
+# Select CPU model (@code{-cpu help} for list and additional feature sel=
ection)
+# !end texinfo
+##
+{ 'option': '--cpu',
+  'data': 'str',                # TODO enum
+  'help': "-cpu cpu        select CPU ('-cpu help' for list)" }
+
+##
+# @--accel:
+# !texinfo
+# -accel @var{name}[,prop=3D@var{value}[,...]]@*
+# This is used to enable an accelerator. Depending on the target archite=
cture,
+# kvm, xen, hax or tcg can be available. By default, tcg is used. If the=
re is
+# more than one accelerator specified, the next one is used if the previ=
ous one
+# fails to initialize.
+# @table @option
+# @item thread=3Dsingle|multi
+# Controls number of TCG threads. When the TCG is multi-threaded there w=
ill be one
+# thread per vCPU therefor taking advantage of additional host cores. Th=
e default
+# is to enable multi-threading where both the back-end and front-ends su=
pport it and
+# no incompatible TCG features have been enabled (e.g. icount/replay).
+# @end table
+# !end texinfo
+##
+{ 'option': '--accel',
+  'data': 'str',                # FIXME enum
+  'help': [
+"-accel [accel=3D]accelerator[,thread=3Dsingle|multi]",
+"                select accelerator (kvm, xen, hax or tcg; use 'help' fo=
r a list)",
+"                thread=3Dsingle|multi (enable multi-threaded TCG)"] }
+
+##
+# @--smp:
+# !texinfo
+# -smp [cpus=3D]@var{n}[,cores=3D@var{cores}][,threads=3D@var{threads}][=
,sockets=3D@var{sockets}][,maxcpus=3D@var{maxcpus}]@*
+# Simulate an SMP system with @var{n} CPUs. On the PC target, up to 255
+# CPUs are supported. On Sparc32 target, Linux limits the number of usab=
le CPUs
+# to 4.
+# For the PC target, the number of @var{cores} per socket, the number
+# of @var{threads} per cores and the total number of @var{sockets} can b=
e
+# specified. Missing values will be computed. If any on the three values=
 is
+# given, the total number of CPUs @var{n} can be omitted. @var{maxcpus}
+# specifies the maximum number of hotpluggable CPUs.
+# !end texinfo
+##
+{ 'option': '--smp',
+  'data': 'str',                # FIXME QAPIfy qemu_smp_opts
+  'help': [
+"-smp [cpus=3D]n[,maxcpus=3Dcpus][,cores=3Dcores][,threads=3Dthreads][,s=
ockets=3Dsockets]",
+"                set the number of CPUs to 'n' [default=3D1]",
+"                maxcpus=3D maximum number of total cpus, including",
+"                offline CPUs for hotplug, etc",
+"                cores=3D number of CPU cores on one socket",
+"                threads=3D number of threads on one CPU core",
+"                sockets=3D number of discrete sockets in the system"] }
+
+##
+# @--numa:
+# !texinfo
+# -numa node[,mem=3D@var{size}][,cpus=3D@var{firstcpu}[-@var{lastcpu}]][=
,nodeid=3D@var{node}]@*
+# -numa node[,memdev=3D@var{id}][,cpus=3D@var{firstcpu}[-@var{lastcpu}]]=
[,nodeid=3D@var{node}]@*
+# -numa dist,src=3D@var{source},dst=3D@var{destination},val=3D@var{dista=
nce}@*
+# -numa cpu,node-id=3D@var{node}[,socket-id=3D@var{x}][,core-id=3D@var{y=
}][,thread-id=3D@var{z}]@*
+# Define a NUMA node and assign RAM and VCPUs to it.
+# Set the NUMA distance from a source node to a destination node.
+#
+# Legacy VCPU assignment uses @samp{cpus} option where
+# @var{firstcpu} and @var{lastcpu} are CPU indexes. Each
+# @samp{cpus} option represent a contiguous range of CPU indexes
+# (or a single VCPU if @var{lastcpu} is omitted). A non-contiguous
+# set of VCPUs can be represented by providing multiple @samp{cpus}
+# options. If @samp{cpus} is omitted on all nodes, VCPUs are automatical=
ly
+# split between them.
+#
+# For example, the following option assigns VCPUs 0, 1, 2 and 5 to
+# a NUMA node:
+# @example
+# -numa node,cpus=3D0-2,cpus=3D5
+# @end example
+#
+# @samp{cpu} option is a new alternative to @samp{cpus} option
+# which uses @samp{socket-id|core-id|thread-id} properties to assign
+# CPU objects to a @var{node} using topology layout properties of CPU.
+# The set of properties is machine specific, and depends on used
+# machine type/@samp{smp} options. It could be queried with
+# @samp{hotpluggable-cpus} monitor command.
+# @samp{node-id} property specifies @var{node} to which CPU object
+# will be assigned, it's required for @var{node} to be declared
+# with @samp{node} option before it's used with @samp{cpu} option.
+#
+# For example:
+# @example
+# -M pc \
+# -smp 1,sockets=3D2,maxcpus=3D2 \
+# -numa node,nodeid=3D0 -numa node,nodeid=3D1 \
+# -numa cpu,node-id=3D0,socket-id=3D0 -numa cpu,node-id=3D1,socket-id=3D=
1
+# @end example
+#
+# @samp{mem} assigns a given RAM amount to a node. @samp{memdev}
+# assigns RAM from a given memory backend device to a node. If
+# @samp{mem} and @samp{memdev} are omitted in all nodes, RAM is
+# split equally between them.
+#
+# @samp{mem} and @samp{memdev} are mutually exclusive. Furthermore,
+# if one node uses @samp{memdev}, all of them have to use it.
+#
+# @var{source} and @var{destination} are NUMA node IDs.
+# @var{distance} is the NUMA distance from @var{source} to @var{destinat=
ion}.
+# The distance from a node to itself is always 10. If any pair of nodes =
is
+# given a distance, then all pairs must be given distances. Although, wh=
en
+# distances are only given in one direction for each pair of nodes, then
+# the distances in the opposite directions are assumed to be the same. I=
f,
+# however, an asymmetrical pair of distances is given for even one node
+# pair, then all node pairs must be provided distance values for both
+# directions, even when they are symmetrical. When a node is unreachable
+# from another node, set the pair's distance to 255.
+#
+# Note that the -@option{numa} option doesn't allocate any of the
+# specified resources, it just assigns existing resources to NUMA
+# nodes. This means that one still has to use the @option{-m},
+# @option{-smp} options to allocate RAM and VCPUs respectively.
+# !end texinfo
+##
+{ 'option': '--numa',
+  'data': 'str',                # FIXME QAPIfy qemu_numa_opts: NumaOptio=
ns
+  'help': [
+"-numa node[,mem=3Dsize][,cpus=3Dfirstcpu[-lastcpu]][,nodeid=3Dnode]",
+"-numa node[,memdev=3Did][,cpus=3Dfirstcpu[-lastcpu]][,nodeid=3Dnode]",
+"-numa dist,src=3Dsource,dst=3Ddestination,val=3Ddistance"] }
+
+##
+# @--add-fd:
+# !texinfo
+# -add-fd fd=3D@var{fd},set=3D@var{set}[,opaque=3D@var{opaque}]@*
+#
+# Add a file descriptor to an fd set.  Valid options are:
+#
+# @table @option
+# @item fd=3D@var{fd}
+# This option defines the file descriptor of which a duplicate is added =
to fd set.
+# The file descriptor cannot be stdin, stdout, or stderr.
+# @item set=3D@var{set}
+# This option defines the ID of the fd set to add the file descriptor to=
.
+# @item opaque=3D@var{opaque}
+# This option defines a free-form string that can be used to describe @v=
ar{fd}.
+# @end table
+#
+# You can open an image using pre-opened file descriptors from an fd set=
:
+# @example
+# qemu-system-i386
+# -add-fd fd=3D3,set=3D2,opaque=3D"rdwr:/path/to/file"
+# -add-fd fd=3D4,set=3D2,opaque=3D"rdonly:/path/to/file"
+# -drive file=3D/dev/fdset/2,index=3D0,media=3Ddisk
+# @end example
+# !end texinfo
+##
+{ 'option': '--add-fd',
+  'data': 'str',                # FIXME QAPIfy qemu_add_fd_opts
+  'help': [
+"-add-fd fd=3Dfd,set=3Dset[,opaque=3Dopaque]",
+"                Add 'fd' to fd 'set'"] }
+
+##
+# @--set:
+# !texinfo
+# -set @var{group}.@var{id}.@var{arg}=3D@var{value}@*
+# Set parameter @var{arg} for item @var{id} of type @var{group}
+# !end texinfo
+##
+{ 'option': '--set',
+  'data': 'str',                # note: ad hoc syntax
+  'help': [
+"-set group.id.arg=3Dvalue",
+"                set <arg> parameter for item <id> of type <group>",
+"                i.e. -set drive.$id.file=3D/path/to/image"] }
+
+##
+# @--global:
+# !texinfo
+# -global @var{driver}.@var{prop}=3D@var{value}@*
+# -global driver=3D@var{driver},property=3D@var{property},value=3D@var{v=
alue}@*
+# Set default value of @var{driver}'s property @var{prop} to @var{value}=
, e.g.:
+#
+# @example
+# qemu-system-i386 -global ide-hd.physical_block_size=3D4096 disk-image.=
img
+# @end example
+#
+# In particular, you can use this to set driver properties for devices w=
hich are
+# created automatically by the machine model. To create a device which i=
s not
+# created automatically and set properties on it, use -@option{device}.
+#
+# -global @var{driver}.@var{prop}=3D@var{value} is shorthand for -global
+# driver=3D@var{driver},property=3D@var{prop},value=3D@var{value}.  The
+# longhand syntax works even when @var{driver} contains a dot.
+# !end texinfo
+##
+{ 'option': '--global',
+  'data': 'str',                # note: ad hoc syntax
+  'help': [
+"-global driver.property=3Dvalue",
+"-global driver=3Ddriver,property=3Dproperty,value=3Dvalue",
+"                set a global default for a driver property"] }
+
+##
+# @--boot:
+# !texinfo
+# -boot [order=3D@var{drives}][,once=3D@var{drives}][,menu=3Don|off][,sp=
lash=3D@var{sp_name}][,splash-time=3D@var{sp_time}][,reboot-timeout=3D@va=
r{rb_timeout}][,strict=3Don|off]@*
+# Specify boot order @var{drives} as a string of drive letters. Valid
+# drive letters depend on the target architecture. The x86 PC uses: a, b
+# (floppy 1 and 2), c (first hard disk), d (first CD-ROM), n-p (Etherboo=
t
+# from network adapter 1-4), hard disk boot is the default. To apply a
+# particular boot order only on the first startup, specify it via
+# @option{once}. Note that the @option{order} or @option{once} parameter
+# should not be used together with the @option{bootindex} property of
+# devices, since the firmware implementations normally do not support bo=
th
+# at the same time.
+#
+# Interactive boot menus/prompts can be enabled via @option{menu=3Don} a=
s far
+# as firmware/BIOS supports them. The default is non-interactive boot.
+#
+# A splash picture could be passed to bios, enabling user to show it as =
logo,
+# when option splash=3D@var{sp_name} is given and menu=3Don, If firmware=
/BIOS
+# supports them. Currently Seabios for X86 system support it.
+# limitation: The splash file could be a jpeg file or a BMP file in 24 B=
PP
+# format(true color). The resolution should be supported by the SVGA mod=
e, so
+# the recommended is 320x240, 640x480, 800x640.
+#
+# A timeout could be passed to bios, guest will pause for @var{rb_timeou=
t} ms
+# when boot failed, then reboot. If @var{rb_timeout} is '-1', guest will=
 not
+# reboot, qemu passes '-1' to bios by default. Currently Seabios for X86
+# system support it.
+#
+# Do strict boot via @option{strict=3Don} as far as firmware/BIOS
+# supports it. This only effects when boot priority is changed by
+# bootindex options. The default is non-strict boot.
+#
+# @example
+# # try to boot from network first, then from hard disk
+# qemu-system-i386 -boot order=3Dnc
+# # boot from CD-ROM first, switch back to default order after reboot
+# qemu-system-i386 -boot once=3Dd
+# # boot with a splash picture for 5 seconds.
+# qemu-system-i386 -boot menu=3Don,splash=3D/root/boot.bmp,splash-time=3D=
5000
+# @end example
+#
+# Note: The legacy format '-boot @var{drives}' is still supported but it=
s
+# use is discouraged as it may be removed from future versions.
+# !end texinfo
+##
+{ 'option': '--boot',
+  'data': 'str',                # FIXME QAPIfy qemu_boot_opts
+  'help': [
+"-boot [order=3Ddrives][,once=3Ddrives][,menu=3Don|off]",
+"      [,splash=3Dsp_name][,splash-time=3Dsp_time][,reboot-timeout=3Drb_=
time][,strict=3Don|off]",
+"                'drives': floppy (a), hard disk (c), CD-ROM (d), networ=
k (n)",
+"                'sp_name': the file's name that would be passed to bios=
 as logo picture, if menu=3Don",
+"                'sp_time': the period that splash picture last if menu=3D=
on, unit is ms",
+"                'rb_timeout': the timeout before guest reboot when boot=
 failed, unit is ms"] }
+
+##
+# @--mem:
+# !texinfo
+# -m [size=3D]@var{megs}[,slots=3Dn,maxmem=3Dsize]@*
+# Sets guest startup RAM size to @var{megs} megabytes. Default is 128 Mi=
B.
+# Optionally, a suffix of ``M'' or ``G'' can be used to signify a value =
in
+# megabytes or gigabytes respectively. Optional pair @var{slots}, @var{m=
axmem}
+# could be used to set amount of hotpluggable memory slots and maximum a=
mount of
+# memory. Note that @var{maxmem} must be aligned to the page size.
+#
+# For example, the following command-line sets the guest startup RAM siz=
e to
+# 1GB, creates 3 slots to hotplug additional memory and sets the maximum
+# memory the guest can reach to 4GB:
+#
+# @example
+# qemu-system-x86_64 -m 1G,slots=3D3,maxmem=3D4G
+# @end example
+#
+# If @var{slots} and @var{maxmem} are not specified, memory hotplug won'=
t
+# be enabled and the guest startup RAM will never increase.
+# !end texinfo
+##
+{ 'option': '--mem', 'short': 'm',
+  'data': 'str',                # FIXME QAPIfy qemu_mem_opts
+  'help': [
+"-m [size=3D]megs[,slots=3Dn,maxmem=3Dsize]",
+"                configure guest RAM",
+"                size: initial amount of guest memory",
+"                slots: number of hotplug slots (default: none)",
+"                maxmem: maximum amount of guest memory (default: none)"=
,
+"NOTE: Some architectures might enforce a specific granularity"] }
+
+##
+# @--mem-path:
+# !texinfo
+# -mem-path @var{path}@*
+# Allocate guest RAM from a temporarily created file in @var{path}.
+# !end texinfo
+##
+{ 'option': '--mem-path',
+  'data': 'str',
+  'help': "-mem-path FILE  provide backing storage for guest RAM" }
+
+##
+# @--mem-prealloc:
+# !texinfo
+# -mem-prealloc@*
+# Preallocate memory when using -mem-path.
+# !end texinfo
+##
+{ 'option': '--mem-prealloc',
+  'help': "-mem-prealloc   preallocate guest memory (use with -mem-path)=
" }
+
+##
+# @--keyboard-layout:
+# !texinfo
+# -k @var{language}@*
+# Use keyboard layout @var{language} (for example @code{fr} for
+# French). This option is only needed where it is not easy to get raw PC
+# keycodes (e.g. on Macs, with some X11 servers or with a VNC or curses
+# display). You don't normally need to use it on PC/Linux or PC/Windows
+# hosts.
+#
+# The available layouts are:
+# @example
+# ar  de-ch  es  fo     fr-ca  hu  ja  mk     no  pt-br  sv
+# da  en-gb  et  fr     fr-ch  is  lt  nl     pl  ru     th
+# de  en-us  fi  fr-be  hr     it  lv  nl-be  pt  sl     tr
+# @end example
+#
+# The default is @code{en-us}.
+# !end texinfo
+##
+{ 'option': '--keyboard-layout', 'short': 'k',
+  'data': 'str',                # FIXME enum?
+  'help': "-k language     use keyboard layout (for example 'fr' for Fre=
nch)" }
+
+##
+# @--audio-help:
+# !texinfo
+# -audio-help@*
+# Will show the audio subsystem help: list of drivers, tunable
+# parameters.
+# !end texinfo
+##
+{ 'option': '--audio-help',
+  'help': "-audio-help     print list of audio drivers and their options=
" }
+
+##
+# @--soundhw:
+# !texinfo
+# -soundhw @var{card1}[,@var{card2},...] or -soundhw all@*
+# Enable audio and selected sound hardware. Use 'help' to print all
+# available sound hardware.
+#
+# @example
+# qemu-system-i386 -soundhw sb16,adlib disk.img
+# qemu-system-i386 -soundhw es1370 disk.img
+# qemu-system-i386 -soundhw ac97 disk.img
+# qemu-system-i386 -soundhw hda disk.img
+# qemu-system-i386 -soundhw all disk.img
+# qemu-system-i386 -soundhw help
+# @end example
+#
+# Note that Linux's i810_audio OSS kernel (for AC97) module might
+# require manually specifying clocking.
+#
+# @example
+# modprobe i810_audio clocking=3D48000
+# @end example
+# !end texinfo
+##
+{ 'option': '--soundhw',
+  'data': 'str',                # FIXME QAPIfy select_soundhw()
+  'help': [
+"-soundhw c1,... enable audio support",
+"                and only specified sound cards (comma separated list)",
+"                use '-soundhw help' to get the list of supported cards"=
,
+"                use '-soundhw all' to enable all of them"] }
+
+##
+# @--balloon:
+# !texinfo
+# -balloon none@*
+# Disable balloon device.
+# -balloon virtio[,addr=3D@var{addr}]@*
+# Enable virtio balloon device (default), optionally with PCI address
+# @var{addr}.
+# !end texinfo
+##
+{ 'option': '--balloon',
+  'data': 'str',                # FIXME QAPIfy balloon_parse()
+  'help': [
+"-balloon none   disable balloon device",
+"-balloon virtio[,addr=3Dstr]",
+"                enable virtio balloon device (default)"] }
+
+##
+# @--device:
+# !texinfo
+# -device @var{driver}[,@var{prop}[=3D@var{value}][,...]]@*
+# Add device @var{driver}.  @var{prop}=3D@var{value} sets driver
+# properties.  Valid properties depend on the driver.  To get help on
+# possible drivers and properties, use @code{-device help} and
+# @code{-device @var{driver},help}.
+#
+# Some drivers are:
+# -device ipmi-bmc-sim,id=3D@var{id}[,slave_addr=3D@var{val}][,sdrfile=3D=
@var{file}][,furareasize=3D@var{val}][,furdatafile=3D@var{file}]@*
+#
+# Add an IPMI BMC.  This is a simulation of a hardware management
+# interface processor that normally sits on a system.  It provides
+# a watchdog and the ability to reset and power control the system.
+# You need to connect this to an IPMI interface to make it useful
+#
+# The IPMI slave address to use for the BMC.  The default is 0x20.
+# This address is the BMC's address on the I2C network of management
+# controllers.  If you don't know what this means, it is safe to ignore
+# it.
+#
+# @table @option
+# @item bmc=3D@var{id}
+# The BMC to connect to, one of ipmi-bmc-sim or ipmi-bmc-extern above.
+# @item slave_addr=3D@var{val}
+# Define slave address to use for the BMC.  The default is 0x20.
+# @item sdrfile=3D@var{file}
+# file containing raw Sensor Data Records (SDR) data. The default is non=
e.
+# @item fruareasize=3D@var{val}
+# size of a Field Replaceable Unit (FRU) area.  The default is 1024.
+# @item frudatafile=3D@var{file}
+# file containing raw Field Replaceable Unit (FRU) inventory data. The d=
efault is none.
+# @end table
+#
+# -device ipmi-bmc-extern,id=3D@var{id},chardev=3D@var{id}[,slave_addr=3D=
@var{val}]@*
+#
+# Add a connection to an external IPMI BMC simulator.  Instead of
+# locally emulating the BMC like the above item, instead connect
+# to an external entity that provides the IPMI services.
+#
+# A connection is made to an external BMC simulator.  If you do this, it
+# is strongly recommended that you use the "reconnect=3D" chardev option
+# to reconnect to the simulator if the connection is lost.  Note that if
+# this is not used carefully, it can be a security issue, as the
+# interface has the ability to send resets, NMIs, and power off the VM.
+# It's best if QEMU makes a connection to an external simulator running
+# on a secure port on localhost, so neither the simulator nor QEMU is
+# exposed to any outside network.
+#
+# See the "lanserv/README.vm" file in the OpenIPMI library for more
+# details on the external interface.
+#
+# -device isa-ipmi-kcs,bmc=3D@var{id}[,ioport=3D@var{val}][,irq=3D@var{v=
al}]@*
+#
+# Add a KCS IPMI interafce on the ISA bus.  This also adds a
+# corresponding ACPI and SMBIOS entries, if appropriate.
+#
+# @table @option
+# @item bmc=3D@var{id}
+# The BMC to connect to, one of ipmi-bmc-sim or ipmi-bmc-extern above.
+# @item ioport=3D@var{val}
+# Define the I/O address of the interface.  The default is 0xca0 for KCS=
.
+# @item irq=3D@var{val}
+# Define the interrupt to use.  The default is 5.  To disable interrupts=
,
+# set this to 0.
+# @end table
+#
+# -device isa-ipmi-bt,bmc=3D@var{id}[,ioport=3D@var{val}][,irq=3D@var{va=
l}]@*
+#
+# Like the KCS interface, but defines a BT interface.  The default port =
is
+# 0xe4 and the default interrupt is 5.
+# !end texinfo
+##
+{ 'option': '--device',
+  'data': 'str',                # FIXME QAPIfy qemu_device_opts: device_=
add
+  'help': [
+"-device driver[,prop[=3Dvalue][,...]]",
+"                add device (based on driver)",
+"                prop=3Dvalue,... sets driver properties",
+"                use '-device help' to print all possible drivers",
+"                use '-device driver,help' to print all possible propert=
ies"] }
+
+##
+# @--name:
+# !texinfo
+# -name @var{name}@*
+# Sets the @var{name} of the guest.
+# This name will be displayed in the SDL window caption.
+# The @var{name} will also be used for the VNC server.
+# Also optionally set the top visible process name in Linux.
+# Naming of individual threads can also be enabled on Linux to aid debug=
ging.
+# !end texinfo
+##
+# FIXME document the additional parameters
+{ 'option': '--name',
+  'data': 'str',                # FIXME QAPIfy qemu_name_opts
+  'help': [
+"-name string1[,process=3Dstring2][,debug-threads=3Don|off]",
+"                set the name of the guest",
+"                string1 sets the window title and string2 the process n=
ame (on Linux)",
+"                When debug-threads is enabled, individual threads are g=
iven a separate name (on Linux)",
+"                NOTE: The thread names are for debugging and not a stab=
le API."] }
+
+##
+# @--uuid:
+# !texinfo
+# -uuid @var{uuid}@*
+# Set system UUID.
+# !end texinfo
+##
+{ 'option': '--uuid',
+  'data': 'str',                # FIXME uuid?
+  'help': [
+"-uuid %08x-%04x-%04x-%04x-%012x",
+"                specify machine UUID"] }
+
+##
+# =3D=3D Block device options
+##
+
+##
+# @--fda:
+# !texinfo
+# -fda @var{file}@*
+# -fdb @var{file}@*
+# Use @var{file} as floppy disk 0/1 image (FIXME @@pxref@{disk_images@})=
.
+# !end texinfo
+##
+{ 'option': '--fda',
+  'data': 'str',
+  'help': "-fda/-fdb file  use 'file' as floppy disk 0/1 image" }
+# FIXME
+
+##
+# @--fdb:
+##
+{ 'option': '--fdb',
+  'data': 'str',
+  'help': null }                # FIXME
+
+##
+# @--hda:
+# !texinfo
+# -hda @var{file}@*
+# -hdb @var{file}@*
+# -hdc @var{file}@*
+# -hdd @var{file}@*
+# Use @var{file} as hard disk 0, 1, 2 or 3 image (FIXME @@pxref@{disk_im=
ages@}).
+# !end texinfo
+##
+{ 'option': '--hda',
+  'data': 'str',
+  'help': "-hda/-hdb file  use 'file' as IDE hard disk 0/1 image" }
+# FIXME
+
+##
+# @--hdb:
+##
+{ 'option': '--hdb',
+  'data': 'str',
+  'help': null }                # FIXME
+
+##
+# @--hdc:
+##
+{ 'option': '--hdc',
+  'data': 'str',
+  'help': "-hdc/-hdd file  use 'file' as IDE hard disk 2/3 image" }
+# FIXME
+
+##
+# @--hdd:
+##
+{ 'option': '--hdd',
+  'data': 'str',
+  'help': null }                # FIXME
+
+##
+# @--cdrom:
+# !texinfo
+# -cdrom @var{file}@*
+# Use @var{file} as CD-ROM image (you cannot use @option{-hdc} and
+# @option{-cdrom} at the same time). You can use the host CD-ROM by
+# using @file{/dev/cdrom} as filename (FIXME @@pxref@{host_drives@}).
+# !end texinfo
+##
+{ 'option': '--cdrom',
+  'data': 'str',
+  'help': "-cdrom file     use 'file' as IDE cdrom image (cdrom is ide1 =
master)" }
+
+##
+# @--blockdev:
+# !texinfo
+# -blockdev @var{option}[,@var{option}[,@var{option}[,...]]]@*
+#
+# Define a new block driver node. Some of the options apply to all block=
 drivers,
+# other options are only accepted for a specific block driver. See below=
 for a
+# list of generic options and options for the most common block drivers.
+#
+# Options that expect a reference to another node (e.g. @code{file}) can=
 be
+# given in two ways. Either you specify the node name of an already exis=
ting node
+# (file=3D@var{node-name}), or you define a new node inline, adding opti=
ons
+# for the referenced node after a dot (file.filename=3D@var{path},file.a=
io=3Dnative).
+#
+# A block driver node created with @option{-blockdev} can be used for a =
guest
+# device by specifying its node name for the @code{drive} property in a
+# @option{-device} argument that defines a block device.
+#
+# @table @option
+# @item Valid options for any block driver node:
+#
+# @table @code
+# @item driver
+# Specifies the block driver to use for the given node.
+# @item node-name
+# This defines the name of the block driver node by which it will be ref=
erenced
+# later. The name must be unique, i.e. it must not match the name of a d=
ifferent
+# block driver node, or (if you use @option{-drive} as well) the ID of a=
 drive.
+#
+# If no node name is specified, it is automatically generated. The gener=
ated node
+# name is not intended to be predictable and changes between QEMU invoca=
tions.
+# For the top level, an explicit node name must be specified.
+# @item read-only
+# Open the node read-only. Guest write attempts will fail.
+# @item cache.direct
+# The host page cache can be avoided with @option{cache.direct=3Don}. Th=
is will
+# attempt to do disk IO directly to the guest's memory. QEMU may still p=
erform an
+# internal copy of the data.
+# @item cache.no-flush
+# In case you don't care about data integrity over host failures, you ca=
n use
+# @option{cache.no-flush=3Don}. This option tells QEMU that it never nee=
ds to write
+# any data to the disk but can instead keep things in cache. If anything=
 goes
+# wrong, like your host losing power, the disk storage getting disconnec=
ted
+# accidentally, etc. your image will most probably be rendered unusable.
+# @item discard=3D@var{discard}
+# @var{discard} is one of "ignore" (or "off") or "unmap" (or "on") and c=
ontrols
+# whether @code{discard} (also known as @code{trim} or @code{unmap}) req=
uests are
+# ignored or passed to the filesystem. Some machine types may not suppor=
t
+# discard requests.
+# @item detect-zeroes=3D@var{detect-zeroes}
+# @var{detect-zeroes} is "off", "on" or "unmap" and enables the automati=
c
+# conversion of plain zero writes by the OS to driver specific optimized
+# zero write commands. You may even choose "unmap" if @var{discard} is s=
et
+# to "unmap" to allow a zero write to be converted to an @code{unmap} op=
eration.
+# @end table
+#
+# @item Driver-specific options for @code{file}
+#
+# This is the protocol-level block driver for accessing regular files.
+#
+# @table @code
+# @item filename
+# The path to the image file in the local filesystem
+# @item aio
+# Specifies the AIO backend (threads/native, default: threads)
+# @end table
+# Example:
+# @example
+# -blockdev driver=3Dfile,node-name=3Ddisk,filename=3Ddisk.img
+# @end example
+#
+# @item Driver-specific options for @code{raw}
+#
+# This is the image format block driver for raw images. It is usually
+# stacked on top of a protocol level block driver such as @code{file}.
+#
+# @table @code
+# @item file
+# Reference to or definition of the data source block driver node
+# (e.g. a @code{file} driver node)
+# @end table
+# Example 1:
+# @example
+# -blockdev driver=3Dfile,node-name=3Ddisk_file,filename=3Ddisk.img
+# -blockdev driver=3Draw,node-name=3Ddisk,file=3Ddisk_file
+# @end example
+# Example 2:
+# @example
+# -blockdev driver=3Draw,node-name=3Ddisk,file.driver=3Dfile,file.filena=
me=3Ddisk.img
+# @end example
+#
+# @item Driver-specific options for @code{qcow2}
+#
+# This is the image format block driver for qcow2 images. It is usually
+# stacked on top of a protocol level block driver such as @code{file}.
+#
+# @table @code
+# @item file
+# Reference to or definition of the data source block driver node
+# (e.g. a @code{file} driver node)
+#
+# @item backing
+# Reference to or definition of the backing file block device (default i=
s taken
+# from the image file). It is allowed to pass an empty string here in or=
der to
+# disable the default backing file.
+#
+# @item lazy-refcounts
+# Whether to enable the lazy refcounts feature (on/off; default is taken=
 from the
+# image file)
+#
+# @item cache-size
+# The maximum total size of the L2 table and refcount block caches in by=
tes
+# (default: 1048576 bytes or 8 clusters, whichever is larger)
+#
+# @item l2-cache-size
+# The maximum size of the L2 table cache in bytes
+# (default: 4/5 of the total cache size)
+#
+# @item refcount-cache-size
+# The maximum size of the refcount block cache in bytes
+# (default: 1/5 of the total cache size)
+#
+# @item cache-clean-interval
+# Clean unused entries in the L2 and refcount caches. The interval is in=
 seconds.
+# The default value is 0 and it disables this feature.
+#
+# @item pass-discard-request
+# Whether discard requests to the qcow2 device should be forwarded to th=
e data
+# source (on/off; default: on if discard=3Dunmap is specified, off other=
wise)
+#
+# @item pass-discard-snapshot
+# Whether discard requests for the data source should be issued when a s=
napshot
+# operation (e.g. deleting a snapshot) frees clusters in the qcow2 file =
(on/off;
+# default: on)
+#
+# @item pass-discard-other
+# Whether discard requests for the data source should be issued on other
+# occasions where a cluster gets freed (on/off; default: off)
+#
+# @item overlap-check
+# Which overlap checks to perform for writes to the image
+# (none/constant/cached/all; default: cached). For details or finer
+# granularity control refer to the QAPI documentation of @code{blockdev-=
add}.
+# @end table
+#
+# Example 1:
+# @example
+# -blockdev driver=3Dfile,node-name=3Dmy_file,filename=3D/tmp/disk.qcow2
+# -blockdev driver=3Dqcow2,node-name=3Dhda,file=3Dmy_file,overlap-check=3D=
none,cache-size=3D16777216
+# @end example
+# Example 2:
+# @example
+# -blockdev driver=3Dqcow2,node-name=3Ddisk,file.driver=3Dhttp,file.file=
name=3Dhttp://example.com/image.qcow2
+# @end example
+#
+# @item Driver-specific options for other drivers
+# Please refer to the QAPI documentation of the @code{blockdev-add} QMP =
command.
+#
+# @end table
+# !end texinfo
+##
+{ 'option': '--blockdev',
+  'data': 'str',                # FIXME BlockdevOptions
+  'help': [
+"-blockdev [driver=3D]driver[,node-name=3DN][,discard=3Dignore|unmap]",
+"          [,cache.direct=3Don|off][,cache.no-flush=3Don|off]",
+"          [,read-only=3Don|off][,detect-zeroes=3Don|off|unmap]",
+"          [,driver specific parameters...]",
+"                configure a block backend"] }
+
+##
+# @--drive:
+# !texinfo
+# -drive @var{option}[,@var{option}[,@var{option}[,...]]]@*
+#
+# Define a new drive. This includes creating a block driver node (the ba=
ckend) as
+# well as a guest device, and is mostly a shortcut for defining the corr=
esponding
+# @option{-blockdev} and @option{-device} options.
+#
+# @option{-drive} accepts all options that are accepted by @option{-bloc=
kdev}. In
+# addition, it knows the following options:
+#
+# @table @option
+# @item file=3D@var{file}
+# This option defines which disk image (FIXME @@pxref@{disk_images@}) to=
 use with
+# this drive. If the filename contains comma, you must double it
+# (for instance, "file=3Dmy,,file" to use file "my,file").
+#
+# Special files such as iSCSI devices can be specified using protocol
+# specific URLs. See the section for "Device URL Syntax" for more inform=
ation.
+# @item if=3D@var{interface}
+# This option defines on which type on interface the drive is connected.
+# Available types are: ide, scsi, sd, mtd, floppy, pflash, virtio, none.
+# @item bus=3D@var{bus},unit=3D@var{unit}
+# These options define where is connected the drive by defining the bus =
number and
+# the unit id.
+# @item index=3D@var{index}
+# This option defines where is connected the drive by using an index in =
the list
+# of available connectors of a given interface type.
+# @item media=3D@var{media}
+# This option defines the type of the media: disk or cdrom.
+# @item cyls=3D@var{c},heads=3D@var{h},secs=3D@var{s}[,trans=3D@var{t}]
+# These options have the same definition as they have in @option{-hdachs=
}.
+# These parameters are deprecated, use the corresponding parameters
+# of @code{-device} instead.
+# @item snapshot=3D@var{snapshot}
+# @var{snapshot} is "on" or "off" and controls snapshot mode for the giv=
en drive
+# (see @option{-snapshot}).
+# @item cache=3D@var{cache}
+# @var{cache} is "none", "writeback", "unsafe", "directsync" or "writeth=
rough"
+# and controls how the host cache is used to access block data. This is =
a
+# shortcut that sets the @option{cache.direct} and @option{cache.no-flus=
h}
+# options (as in @option{-blockdev}), and additionally @option{cache.wri=
teback},
+# which provides a default for the @option{write-cache} option of block =
guest
+# devices (as in @option{-device}). The modes correspond to the followin=
g
+# settings:
+#
+# @c Our texi2pod.pl script doesn't support @multitable, so fall back to=
 using
+# @c plain ASCII art (well, UTF-8 art really). This looks okay both in t=
he manpage
+# @c and the HTML output.
+# @example
+#              | cache.writeback   cache.direct   cache.no-flush
+# -------------+------------------------------------------------
+# writeback    | on                off            off
+# none         | on                on             off
+# writethrough | off               off            off
+# directsync   | off               on             off
+# unsafe       | on                off            on
+# @end example
+#
+# The default mode is @option{cache=3Dwriteback}.
+#
+# @item aio=3D@var{aio}
+# @var{aio} is "threads", or "native" and selects between pthread based =
disk I/O and native Linux AIO.
+# @item format=3D@var{format}
+# Specify which disk @var{format} will be used rather than detecting
+# the format.  Can be used to specify format=3Draw to avoid interpreting
+# an untrusted format header.
+# @item serial=3D@var{serial}
+# This option specifies the serial number to assign to the device. This
+# parameter is deprecated, use the corresponding parameter of @code{-dev=
ice}
+# instead.
+# @item addr=3D@var{addr}
+# Specify the controller's PCI address (if=3Dvirtio only). This paramete=
r is
+# deprecated, use the corresponding parameter of @code{-device} instead.
+# @item werror=3D@var{action},rerror=3D@var{action}
+# Specify which @var{action} to take on write and read errors. Valid act=
ions are:
+# "ignore" (ignore the error and try to continue), "stop" (pause QEMU),
+# "report" (report the error to the guest), "enospc" (pause QEMU only if=
 the
+# host disk is full; report the error to the guest otherwise).
+# The default setting is @option{werror=3Denospc} and @option{rerror=3Dr=
eport}.
+# @item copy-on-read=3D@var{copy-on-read}
+# @var{copy-on-read} is "on" or "off" and enables whether to copy read b=
acking
+# file sectors into the image file.
+# @item bps=3D@var{b},bps_rd=3D@var{r},bps_wr=3D@var{w}
+# Specify bandwidth throttling limits in bytes per second, either for al=
l request
+# types or for reads or writes only.  Small values can lead to timeouts =
or hangs
+# inside the guest.  A safe minimum for disks is 2 MB/s.
+# @item bps_max=3D@var{bm},bps_rd_max=3D@var{rm},bps_wr_max=3D@var{wm}
+# Specify bursts in bytes per second, either for all request types or fo=
r reads
+# or writes only.  Bursts allow the guest I/O to spike above the limit
+# temporarily.
+# @item iops=3D@var{i},iops_rd=3D@var{r},iops_wr=3D@var{w}
+# Specify request rate limits in requests per second, either for all req=
uest
+# types or for reads or writes only.
+# @item iops_max=3D@var{bm},iops_rd_max=3D@var{rm},iops_wr_max=3D@var{wm=
}
+# Specify bursts in requests per second, either for all request types or=
 for reads
+# or writes only.  Bursts allow the guest I/O to spike above the limit
+# temporarily.
+# @item iops_size=3D@var{is}
+# Let every @var{is} bytes of a request count as a new request for iops
+# throttling purposes.  Use this option to prevent guests from circumven=
ting iops
+# limits by sending fewer but larger requests.
+# @item group=3D@var{g}
+# Join a throttling quota group with given name @var{g}.  All drives tha=
t are
+# members of the same group are accounted for together.  Use this option=
 to
+# prevent guests from circumventing throttling limits by using many smal=
l disks
+# instead of a single larger disk.
+# @end table
+#
+# By default, the @option{cache.writeback=3Don} mode is used. It will re=
port data
+# writes as completed as soon as the data is present in the host page ca=
che.
+# This is safe as long as your guest OS makes sure to correctly flush di=
sk caches
+# where needed. If your guest OS does not handle volatile disk write cac=
hes
+# correctly and your host crashes or loses power, then the guest may exp=
erience
+# data corruption.
+#
+# For such guests, you should consider using @option{cache.writeback=3Do=
ff}. This
+# means that the host page cache will be used to read and write data, bu=
t write
+# notification will be sent to the guest only after QEMU has made sure t=
o flush
+# each write to the disk. Be aware that this has a major impact on perfo=
rmance.
+#
+# When using the @option{-snapshot} option, unsafe caching is always use=
d.
+#
+# Copy-on-read avoids accessing the same backing file sectors repeatedly=
 and is
+# useful when the backing file is over a slow network.  By default copy-=
on-read
+# is off.
+#
+# Instead of @option{-cdrom} you can use:
+# @example
+# qemu-system-i386 -drive file=3Dfile,index=3D2,media=3Dcdrom
+# @end example
+#
+# Instead of @option{-hda}, @option{-hdb}, @option{-hdc}, @option{-hdd},=
 you can
+# use:
+# @example
+# qemu-system-i386 -drive file=3Dfile,index=3D0,media=3Ddisk
+# qemu-system-i386 -drive file=3Dfile,index=3D1,media=3Ddisk
+# qemu-system-i386 -drive file=3Dfile,index=3D2,media=3Ddisk
+# qemu-system-i386 -drive file=3Dfile,index=3D3,media=3Ddisk
+# @end example
+#
+# You can open an image using pre-opened file descriptors from an fd set=
:
+# @example
+# qemu-system-i386
+# -add-fd fd=3D3,set=3D2,opaque=3D"rdwr:/path/to/file"
+# -add-fd fd=3D4,set=3D2,opaque=3D"rdonly:/path/to/file"
+# -drive file=3D/dev/fdset/2,index=3D0,media=3Ddisk
+# @end example
+#
+# You can connect a CDROM to the slave of ide0:
+# @example
+# qemu-system-i386 -drive file=3Dfile,if=3Dide,index=3D1,media=3Dcdrom
+# @end example
+#
+# If you don't specify the "file=3D" argument, you define an empty drive=
:
+# @example
+# qemu-system-i386 -drive if=3Dide,index=3D1,media=3Dcdrom
+# @end example
+#
+# Instead of @option{-fda}, @option{-fdb}, you can use:
+# @example
+# qemu-system-i386 -drive file=3Dfile,index=3D0,if=3Dfloppy
+# qemu-system-i386 -drive file=3Dfile,index=3D1,if=3Dfloppy
+# @end example
+#
+# By default, @var{interface} is "ide" and @var{index} is automatically
+# incremented:
+# @example
+# qemu-system-i386 -drive file=3Da -drive file=3Db"
+# @end example
+# is interpreted like:
+# @example
+# qemu-system-i386 -hda a -hdb b
+# @end example
+# !end texinfo
+##
+{ 'option': '--drive',
+  'data': 'str',                # FIXME
+  'help': [
+"-drive [file=3Dfile][,if=3Dtype][,bus=3Dn][,unit=3Dm][,media=3Dd][,inde=
x=3Di]",
+"       [,cyls=3Dc,heads=3Dh,secs=3Ds[,trans=3Dt]][,snapshot=3Don|off]",
+"       [,cache=3Dwritethrough|writeback|none|directsync|unsafe][,format=
=3Df]",
+"       [,serial=3Ds][,addr=3DA][,rerror=3Dignore|stop|report]",
+"       [,werror=3Dignore|stop|report|enospc][,id=3Dname][,aio=3Dthreads=
|native]",
+"       [,readonly=3Don|off][,copy-on-read=3Don|off]",
+"       [,discard=3Dignore|unmap][,detect-zeroes=3Don|off|unmap]",
+"       [[,bps=3Db]|[[,bps_rd=3Dr][,bps_wr=3Dw]]]",
+"       [[,iops=3Di]|[[,iops_rd=3Dr][,iops_wr=3Dw]]]",
+"       [[,bps_max=3Dbm]|[[,bps_rd_max=3Drm][,bps_wr_max=3Dwm]]]",
+"       [[,iops_max=3Dim]|[[,iops_rd_max=3Dirm][,iops_wr_max=3Diwm]]]",
+"       [[,iops_size=3Dis]]",
+"       [[,group=3Dg]]",
+"                use 'file' as a drive image"] }
+
+##
+# @--mtdblock:
+# !texinfo
+# -mtdblock @var{file}@*
+# Use @var{file} as on-board Flash memory image.
+# !end texinfo
+##
+{ 'option': '--mtdblock',
+  'data': 'str',
+  'help': "-mtdblock file  use 'file' as on-board Flash memory image" }
+
+##
+# @--sd:
+# !texinfo
+# -sd @var{file}@*
+# Use @var{file} as SecureDigital card image.
+# !end texinfo
+##
+{ 'option': '--sd',
+  'data': 'str',
+  'help': "-sd file        use 'file' as SecureDigital card image" }
+
+##
+# @--pflash:
+# !texinfo
+# -pflash @var{file}@*
+# Use @var{file} as a parallel flash image.
+# !end texinfo
+##
+{ 'option': '--pflash',
+  'data': 'str',
+  'help': "-pflash file    use 'file' as a parallel flash image" }
+
+##
+# @--snapshot:
+# !texinfo
+
+# -snapshot@*
+# Write to temporary files instead of disk image files. In this case,
+# the raw disk image you use is not written back. You can however force
+# the write back by pressing @key{C-a s} (FIXME @@pxref@{disk_images@}).
+# !end texinfo
+##
+{ 'option': '--snapshot',
+  'help': "-snapshot       write to temporary files instead of disk imag=
e files" }
+
+##
+# @--hdachs:
+# !texinfo
+# -hdachs @var{c},@var{h},@var{s},[,@var{t}]@*
+# Force hard disk 0 physical geometry (1 <=3D @var{c} <=3D 16383, 1 <=3D
+# @var{h} <=3D 16, 1 <=3D @var{s} <=3D 63) and optionally force the BIOS
+# translation mode (@var{t}=3Dnone, lba or auto). Usually QEMU can guess
+# all those parameters. This option is deprecated, please use
+# @code{-device ide-hd,cyls=3Dc,heads=3Dh,secs=3Ds,...} instead.
+# !end texinfo
+##
+# TODO deprecate
+{ 'option': '--hdachs',
+  'data': 'str',                # note: ad hoc syntax
+  'help': [
+"-hdachs c,h,s[,t]",
+"                force hard disk 0 physical geometry and the optional BI=
OS",
+"                translation (t=3Dnone or lba) (usually QEMU can guess t=
hem)"] }
+
+##
+# @--fsdev:
+# !texinfo
+#
+# -fsdev @var{fsdriver},id=3D@var{id},path=3D@var{path},[security_model=3D=
@var{security_model}][,writeout=3D@var{writeout}][,readonly][,socket=3D@v=
ar{socket}|sock_fd=3D@var{sock_fd}][,fmode=3D@var{fmode}][,dmode=3D@var{d=
mode}]@*
+# Define a new file system device. Valid options are:
+# @table @option
+# @item @var{fsdriver}
+# This option specifies the fs driver backend to use.
+# Currently "local", "handle" and "proxy" file system drivers are suppor=
ted.
+# @item id=3D@var{id}
+# Specifies identifier for this device
+# @item path=3D@var{path}
+# Specifies the export path for the file system device. Files under
+# this path will be available to the 9p client on the guest.
+# @item security_model=3D@var{security_model}
+# Specifies the security model to be used for this export path.
+# Supported security models are "passthrough", "mapped-xattr", "mapped-f=
ile" and "none".
+# In "passthrough" security model, files are stored using the same
+# credentials as they are created on the guest. This requires QEMU
+# to run as root. In "mapped-xattr" security model, some of the file
+# attributes like uid, gid, mode bits and link target are stored as
+# file attributes. For "mapped-file" these attributes are stored in the
+# hidden .virtfs_metadata directory. Directories exported by this securi=
ty model cannot
+# interact with other unix tools. "none" security model is same as
+# passthrough except the sever won't report failures if it fails to
+# set file attributes like ownership. Security model is mandatory
+# only for local fsdriver. Other fsdrivers (like handle, proxy) don't ta=
ke
+# security model as a parameter.
+# @item writeout=3D@var{writeout}
+# This is an optional argument. The only supported value is "immediate".
+# This means that host page cache will be used to read and write data bu=
t
+# write notification will be sent to the guest only when the data has be=
en
+# reported as written by the storage subsystem.
+# @item readonly
+# Enables exporting 9p share as a readonly mount for guests. By default
+# read-write access is given.
+# @item socket=3D@var{socket}
+# Enables proxy filesystem driver to use passed socket file for communic=
ating
+# with virtfs-proxy-helper
+# @item sock_fd=3D@var{sock_fd}
+# Enables proxy filesystem driver to use passed socket descriptor for
+# communicating with virtfs-proxy-helper. Usually a helper like libvirt
+# will create socketpair and pass one of the fds as sock_fd
+# @item fmode=3D@var{fmode}
+# Specifies the default mode for newly created files on the host. Works =
only
+# with security models "mapped-xattr" and "mapped-file".
+# @item dmode=3D@var{dmode}
+# Specifies the default mode for newly created directories on the host. =
Works
+# only with security models "mapped-xattr" and "mapped-file".
+# @end table
+#
+# -fsdev option is used along with -device driver "virtio-9p-pci".
+# -device virtio-9p-pci,fsdev=3D@var{id},mount_tag=3D@var{mount_tag}@*
+# Options for virtio-9p-pci driver are:
+# @table @option
+# @item fsdev=3D@var{id}
+# Specifies the id value specified along with -fsdev option
+# @item mount_tag=3D@var{mount_tag}
+# Specifies the tag name to be used by the guest to mount this export po=
int
+# @end table
+# !end texinfo
+##
+{ 'option': '--fsdev',
+  'data': 'str',                # FIXME QAPIfy qemu_fsdev_opts
+  'help': [
+"-fsdev fsdriver,id=3Did[,path=3Dpath,][security_model=3D{mapped-xattr|m=
apped-file|passthrough|none}]",
+" [,writeout=3Dimmediate][,readonly][,socket=3Dsocket|sock_fd=3Dsock_fd]=
[,fmode=3Dfmode][,dmode=3Ddmode]",
+" [[,throttling.bps-total=3Db]|[[,throttling.bps-read=3Dr][,throttling.b=
ps-write=3Dw]]]",
+" [[,throttling.iops-total=3Di]|[[,throttling.iops-read=3Dr][,throttling=
.iops-write=3Dw]]]",
+" [[,throttling.bps-total-max=3Dbm]|[[,throttling.bps-read-max=3Drm][,th=
rottling.bps-write-max=3Dwm]]]",
+" [[,throttling.iops-total-max=3Dim]|[[,throttling.iops-read-max=3Dirm][=
,throttling.iops-write-max=3Diwm]]]",
+" [[,throttling.iops-size=3Dis]]"] }
+
+##
+# @--virtfs:
+# !texinfo
+#
+# -virtfs @var{fsdriver}[,path=3D@var{path}],mount_tag=3D@var{mount_tag}=
[,security_model=3D@var{security_model}][,writeout=3D@var{writeout}][,rea=
donly][,socket=3D@var{socket}|sock_fd=3D@var{sock_fd}][,fmode=3D@var{fmod=
e}][,dmode=3D@var{dmode}]@*
+#
+# The general form of a Virtual File system pass-through options are:
+# @table @option
+# @item @var{fsdriver}
+# This option specifies the fs driver backend to use.
+# Currently "local", "handle" and "proxy" file system drivers are suppor=
ted.
+# @item id=3D@var{id}
+# Specifies identifier for this device
+# @item path=3D@var{path}
+# Specifies the export path for the file system device. Files under
+# this path will be available to the 9p client on the guest.
+# @item security_model=3D@var{security_model}
+# Specifies the security model to be used for this export path.
+# Supported security models are "passthrough", "mapped-xattr", "mapped-f=
ile" and "none".
+# In "passthrough" security model, files are stored using the same
+# credentials as they are created on the guest. This requires QEMU
+# to run as root. In "mapped-xattr" security model, some of the file
+# attributes like uid, gid, mode bits and link target are stored as
+# file attributes. For "mapped-file" these attributes are stored in the
+# hidden .virtfs_metadata directory. Directories exported by this securi=
ty model cannot
+# interact with other unix tools. "none" security model is same as
+# passthrough except the sever won't report failures if it fails to
+# set file attributes like ownership. Security model is mandatory only
+# for local fsdriver. Other fsdrivers (like handle, proxy) don't take se=
curity
+# model as a parameter.
+# @item writeout=3D@var{writeout}
+# This is an optional argument. The only supported value is "immediate".
+# This means that host page cache will be used to read and write data bu=
t
+# write notification will be sent to the guest only when the data has be=
en
+# reported as written by the storage subsystem.
+# @item readonly
+# Enables exporting 9p share as a readonly mount for guests. By default
+# read-write access is given.
+# @item socket=3D@var{socket}
+# Enables proxy filesystem driver to use passed socket file for
+# communicating with virtfs-proxy-helper. Usually a helper like libvirt
+# will create socketpair and pass one of the fds as sock_fd
+# @item sock_fd
+# Enables proxy filesystem driver to use passed 'sock_fd' as the socket
+# descriptor for interfacing with virtfs-proxy-helper
+# @item fmode=3D@var{fmode}
+# Specifies the default mode for newly created files on the host. Works =
only
+# with security models "mapped-xattr" and "mapped-file".
+# @item dmode=3D@var{dmode}
+# Specifies the default mode for newly created directories on the host. =
Works
+# only with security models "mapped-xattr" and "mapped-file".
+# @end table
+# !end texinfo
+##
+{ 'option': '--virtfs',
+  'data': 'str',                # FIXME QAPIfy qemu_virtfs_opts
+  'help': [
+"-virtfs local,path=3Dpath,mount_tag=3Dtag,security_model=3D[mapped-xatt=
r|mapped-file|passthrough|none]",
+"        [,id=3Did][,writeout=3Dimmediate][,readonly][,socket=3Dsocket|s=
ock_fd=3Dsock_fd][,fmode=3Dfmode][,dmode=3Ddmode]"] }
+
+##
+# @--virtfs_synth:
+# !texinfo
+# -virtfs_synth@*
+# Create synthetic file system image
+# !end texinfo
+##
+{ 'option': '--virtfs_synth',
+  'help': "-virtfs_synth Create synthetic file system image" }
+
+##
+# @--iscsi:
+# Configure iSCSI session parameters.
+##
+{ 'option': '--iscsi',
+  'data': 'str',                # FIXME QAPIfy qemu_iscsi_opts
+  'help': [
+"-iscsi [user=3Duser][,password=3Dpassword]",
+"       [,header-digest=3DCRC32C|CR32C-NONE|NONE-CRC32C|NONE",
+"       [,initiator-name=3Dinitiator-iqn][,id=3Dtarget-iqn]",
+"       [,timeout=3Dtimeout]",
+"                iSCSI session parameters"] }
+
+##
+# =3D=3D USB options
+##
+
+##
+# @--usb:
+# !texinfo
+# -usb@*
+# Enable the USB driver (if it is not used by default yet).
+# !end texinfo
+##
+{ 'option': '--usb',
+  'help': "-usb            enable the USB driver (if it is not used by d=
efault yet)" }
+
+##
+# @--usbdevice:
+# !texinfo
+#
+# -usbdevice @var{devname}@*
+# Add the USB device @var{devname}. Note that this option is deprecated,
+# please use @code{-device usb-...} instead. FIXME @@xref@{usb_devices@}=
.
+#
+# @table @option
+#
+# @item mouse
+# Virtual Mouse. This will override the PS/2 mouse emulation when activa=
ted.
+#
+# @item tablet
+# Pointer device that uses absolute coordinates (like a touchscreen). Th=
is
+# means QEMU is able to report the mouse position without having to grab=
 the
+# mouse. Also overrides the PS/2 mouse emulation when activated.
+#
+# @item disk:[format=3D@var{format}]:@var{file}
+# Mass storage device based on file. The optional @var{format} argument
+# will be used rather than detecting the format. Can be used to specify
+# @code{format=3Draw} to avoid interpreting an untrusted format header.
+#
+# @item host:@var{bus}.@var{addr}
+# Pass through the host device identified by @var{bus}.@var{addr} (Linux=
 only).
+#
+# @item host:@var{vendor_id}:@var{product_id}
+# Pass through the host device identified by @var{vendor_id}:@var{produc=
t_id}
+# (Linux only).
+#
+# @item serial:[vendorid=3D@var{vendor_id}][,productid=3D@var{product_id=
}]:@var{dev}
+# Serial converter to host character device @var{dev}, see @code{-serial=
} for the
+# available devices.
+#
+# @item braille
+# Braille device.  This will use BrlAPI to display the braille output on=
 a real
+# or fake device.
+#
+# @item net:@var{options}
+# Network adapter that supports CDC ethernet and RNDIS protocols.
+#
+# @end table
+# !end texinfo
+##
+{ 'option': '--usbdevice',
+  'data': 'str',                # FIXME QAPIfy usb_parse()
+  'help': "-usbdevice name add the host or guest USB device 'name'" }
+
+##
+# =3D=3D Display options
+##
+
+##
+# @--display:
+# !texinfo
+# -display @var{type}@*
+# Select type of display to use. This option is a replacement for the
+# old style -sdl/-curses/... options. Valid values for @var{type} are
+# @table @option
+# @item sdl
+# Display video output via SDL (usually in a separate graphics
+# window; see the SDL documentation for other possibilities).
+# @item curses
+# Display video output via curses. For graphics device models which
+# support a text mode, QEMU can display this output using a
+# curses/ncurses interface. Nothing is displayed when the graphics
+# device is in graphical mode or if the graphics device does not support
+# a text mode. Generally only the VGA device models support text mode.
+# @item none
+# Do not display video output. The guest will still see an emulated
+# graphics card, but its output will not be displayed to the QEMU
+# user. This option differs from the -nographic option in that it
+# only affects what is done with video output; -nographic also changes
+# the destination of the serial and parallel port data.
+# @item gtk
+# Display video output in a GTK window. This interface provides drop-dow=
n
+# menus and other UI elements to configure and control the VM during
+# runtime.
+# @item vnc
+# Start a VNC server on display <arg>
+# @end table
+# !end texinfo
+##
+{ 'option': '--display',
+  'data': 'str',                # FIXME QAPIfy select_display()
+  'help': [
+"-display sdl[,frame=3Don|off][,alt_grab=3Don|off][,ctrl_grab=3Don|off]"=
,
+"            [,window_close=3Don|off][,gl=3Don|off]",
+"-display gtk[,grab_on_hover=3Don|off][,gl=3Don|off]|",
+"-display vnc=3D<display>[,<optargs>]",
+"-display curses",
+"-display none",
+"                select display type",
+"The default display is equivalent to",
+"        '-display FIXME'"] }
+
+##
+# @--nographic:
+# !texinfo
+# -nographic@*
+# Normally, if QEMU is compiled with graphical window support, it displa=
ys
+# output such as guest graphics, guest console, and the QEMU monitor in =
a
+# window. With this option, you can totally disable graphical output so
+# that QEMU is a simple command line application. The emulated serial po=
rt
+# is redirected on the console and muxed with the monitor (unless
+# redirected elsewhere explicitly). Therefore, you can still use QEMU to
+# debug a Linux kernel with a serial console. Use @key{C-a h} for help o=
n
+# switching between the console and monitor.
+# !end texinfo
+##
+# TODO deprecate
+{ 'option': '--nographic',
+  'help': "-nographic      disable graphical output and redirect serial =
I/Os to console" }
+
+##
+# @--curses:
+# !texinfo
+# -curses@*
+# Normally, if QEMU is compiled with graphical window support, it displa=
ys
+# output such as guest graphics, guest console, and the QEMU monitor in =
a
+# window. With this option, QEMU can display the VGA output when in text
+# mode using a curses/ncurses interface. Nothing is displayed in graphic=
al
+# mode.
+# !end texinfo
+##
+{ 'option': '--curses',
+  'help': "-curses         shorthand for -display curses" }
+
+##
+# @--no-frame:
+# !texinfo
+# -no-frame@*
+# Do not use decorations for SDL windows and start them using the whole
+# available screen space. This makes the using QEMU in a dedicated deskt=
op
+# workspace more convenient.
+# !end texinfo
+##
+{ 'option': '--no-frame',
+  'help': "-no-frame       open SDL window without a frame and window de=
corations" }
+
+##
+# @--alt-grab:
+# !texinfo
+# -alt-grab@*
+# Use Ctrl-Alt-Shift to grab mouse (instead of Ctrl-Alt). Note that this=
 also
+# affects the special keys (for fullscreen, monitor-mode switching, etc)=
.
+# !end texinfo
+##
+{ 'option': '--alt-grab',
+  'help': "-alt-grab       use Ctrl-Alt-Shift to grab mouse (instead of =
Ctrl-Alt)" }
+
+##
+# @--ctrl-grab:
+# !texinfo
+# -ctrl-grab@*
+# Use Right-Ctrl to grab mouse (instead of Ctrl-Alt). Note that this als=
o
+# affects the special keys (for fullscreen, monitor-mode switching, etc)=
.
+# !end texinfo
+##
+{ 'option': '--ctrl-grab',
+  'help': "-ctrl-grab      use Right-Ctrl to grab mouse (instead of Ctrl=
-Alt)" }
+
+##
+# @--no-quit:
+# !texinfo
+# -no-quit@*
+# Disable SDL window close capability.
+# !end texinfo
+##
+{ 'option': '--no-quit',
+  'help': "-no-quit        disable SDL window close capability" }
+
+##
+# @--sdl:
+# !texinfo
+# -sdl@*
+# Enable SDL.
+# !end texinfo
+##
+{ 'option': '--sdl',
+  'help': "-sdl            shorthand for -display sdl" }
+
+##
+# @--spice:
+# !texinfo
+# -spice @var{option}[,@var{option}[,...]]@*
+# Enable the spice remote desktop protocol. Valid options are
+#
+# @table @option
+#
+# @item port=3D<nr>
+# Set the TCP port spice is listening on for plaintext channels.
+#
+# @item addr=3D<addr>
+# Set the IP address spice is listening on.  Default is any address.
+#
+# @item ipv4
+# @itemx ipv6
+# @itemx unix
+# Force using the specified IP version.
+#
+# @item password=3D<secret>
+# Set the password you need to authenticate.
+#
+# @item sasl
+# Require that the client use SASL to authenticate with the spice.
+# The exact choice of authentication method used is controlled from the
+# system / user's SASL configuration file for the 'qemu' service. This
+# is typically found in /etc/sasl2/qemu.conf. If running QEMU as an
+# unprivileged user, an environment variable SASL_CONF_PATH can be used
+# to make it search alternate locations for the service config.
+# While some SASL auth methods can also provide data encryption (eg GSSA=
PI),
+# it is recommended that SASL always be combined with the 'tls' and
+# 'x509' settings to enable use of SSL and server certificates. This
+# ensures a data encryption preventing compromise of authentication
+# credentials.
+#
+# @item disable-ticketing
+# Allow client connects without authentication.
+#
+# @item disable-copy-paste
+# Disable copy paste between the client and the guest.
+#
+# @item disable-agent-file-xfer
+# Disable spice-vdagent based file-xfer between the client and the guest=
.
+#
+# @item tls-port=3D<nr>
+# Set the TCP port spice is listening on for encrypted channels.
+#
+# @item x509-dir=3D<dir>
+# Set the x509 file directory. Expects same filenames as -vnc $display,x=
509=3D$dir
+#
+# @item x509-key-file=3D<file>
+# @itemx x509-key-password=3D<file>
+# @itemx x509-cert-file=3D<file>
+# @itemx x509-cacert-file=3D<file>
+# @itemx x509-dh-key-file=3D<file>
+# The x509 file names can also be configured individually.
+#
+# @item tls-ciphers=3D<list>
+# Specify which ciphers to use.
+#
+# @item tls-channel=3D[main|display|cursor|inputs|record|playback]
+# @itemx plaintext-channel=3D[main|display|cursor|inputs|record|playback=
]
+# Force specific channel to be used with or without TLS encryption.  The
+# options can be specified multiple times to configure multiple
+# channels.  The special name "default" can be used to set the default
+# mode.  For channels which are not explicitly forced into one mode the
+# spice client is allowed to pick tls/plaintext as he pleases.
+#
+# @item image-compression=3D[auto_glz|auto_lz|quic|glz|lz|off]
+# Configure image compression (lossless).
+# Default is auto_glz.
+#
+# @item jpeg-wan-compression=3D[auto|never|always]
+# @itemx zlib-glz-wan-compression=3D[auto|never|always]
+# Configure wan image compression (lossy for slow links).
+# Default is auto.
+#
+# @item streaming-video=3D[off|all|filter]
+# Configure video stream detection.  Default is off.
+#
+# @item agent-mouse=3D[on|off]
+# Enable/disable passing mouse events via vdagent.  Default is on.
+#
+# @item playback-compression=3D[on|off]
+# Enable/disable audio stream compression (using celt 0.5.1).  Default i=
s on.
+#
+# @item seamless-migration=3D[on|off]
+# Enable/disable spice seamless migration. Default is off.
+#
+# @item gl=3D[on|off]
+# Enable/disable OpenGL context. Default is off.
+#
+# @item rendernode=3D<file>
+# DRM render node for OpenGL rendering. If not specified, it will pick
+# the first available. (Since 2.9)
+#
+# @end table
+# !end texinfo
+##
+{ 'option': '--spice',
+  'data': 'str',                # FIXME QAPIfy qemu_spice_opts
+  'help': [
+"-spice [port=3Dport][,tls-port=3Dsecured-port][,x509-dir=3D<dir>]",
+"       [,x509-key-file=3D<file>][,x509-key-password=3D<file>]",
+"       [,x509-cert-file=3D<file>][,x509-cacert-file=3D<file>]",
+"       [,x509-dh-key-file=3D<file>][,addr=3Daddr][,ipv4|ipv6|unix]",
+"       [,tls-ciphers=3D<list>]",
+"       [,tls-channel=3D[main|display|cursor|inputs|record|playback]]",
+"       [,plaintext-channel=3D[main|display|cursor|inputs|record|playbac=
k]]",
+"       [,sasl][,password=3D<secret>][,disable-ticketing]",
+"       [,image-compression=3D[auto_glz|auto_lz|quic|glz|lz|off]]",
+"       [,jpeg-wan-compression=3D[auto|never|always]]",
+"       [,zlib-glz-wan-compression=3D[auto|never|always]]",
+"       [,streaming-video=3D[off|all|filter]][,disable-copy-paste]",
+"       [,disable-agent-file-xfer][,agent-mouse=3D[on|off]]",
+"       [,playback-compression=3D[on|off]][,seamless-migration=3D[on|off=
]]",
+"       [,gl=3D[on|off]][,rendernode=3D<file>]",
+"   enable spice",
+"   at least one of {port, tls-port} is mandatory"] }
+
+##
+# @--portrait:
+# !texinfo
+# -portrait@*
+# Rotate graphical output 90 deg left (only PXA LCD).
+# !end texinfo
+##
+{ 'option': '--portrait',
+  'help': "-portrait       rotate graphical output 90 deg left (only PXA=
 LCD)" }
+
+##
+# @--rotate:
+# !texinfo
+# -rotate @var{deg}@*
+# Rotate graphical output some deg left (only PXA LCD).
+# !end texinfo
+##
+{ 'option': '--rotate',
+  'data': 'str',                # FIXME int or enum
+  'help': "-rotate <deg>   rotate graphical output some deg left (only P=
XA LCD)" }
+
+##
+# @--vga:
+# !texinfo
+# -vga @var{type}@*
+# Select type of VGA card to emulate. Valid values for @var{type} are
+# @table @option
+# @item cirrus
+# Cirrus Logic GD5446 Video card. All Windows versions starting from
+# Windows 95 should recognize and use this graphic card. For optimal
+# performances, use 16 bit color depth in the guest and the host OS.
+# (This card was the default before QEMU 2.2)
+# @item std
+# Standard VGA card with Bochs VBE extensions.  If your guest OS
+# supports the VESA 2.0 VBE extensions (e.g. Windows XP) and if you want
+# to use high resolution modes (>=3D 1280x1024x16) then you should use
+# this option. (This card is the default since QEMU 2.2)
+# @item vmware
+# VMWare SVGA-II compatible adapter. Use it if you have sufficiently
+# recent XFree86/XOrg server or Windows guest with a driver for this
+# card.
+# @item qxl
+# QXL paravirtual graphic card.  It is VGA compatible (including VESA
+# 2.0 VBE support).  Works best with qxl guest drivers installed though.
+# Recommended choice when using the spice protocol.
+# @item tcx
+# (sun4m only) Sun TCX framebuffer. This is the default framebuffer for
+# sun4m machines and offers both 8-bit and 24-bit colour depths at a
+# fixed resolution of 1024x768.
+# @item cg3
+# (sun4m only) Sun cgthree framebuffer. This is a simple 8-bit framebuff=
er
+# for sun4m machines available in both 1024x768 (OpenBIOS) and 1152x900 =
(OBP)
+# resolutions aimed at people wishing to run older Solaris versions.
+# @item virtio
+# Virtio VGA card.
+# @item none
+# Disable VGA card.
+# @end table
+# !end texinfo
+##
+# TODO either document retrace=3D..., or kill it
+{ 'option': '--vga',
+  'data': 'str',                # FIXME QAPIfy select_vgahw()
+  'help': [
+"-vga [std|cirrus|vmware|qxl|xenfb|tcx|cg3|virtio|none]",
+"                select video card type"] }
+
+##
+# @--full-screen:
+# !texinfo
+# -full-screen@*
+# Start in full screen.
+# !end texinfo
+##
+{ 'option': '--full-screen',
+  'help': "-full-screen    start in full screen" }
+
+##
+# @--graphical-resolution:
+# !texinfo
+# -g @var{width}x@var{height}[x@var{depth}]@*
+# Set the initial graphical resolution and depth (PPC, SPARC only).
+# !end texinfo
+##
+{ 'option': '--graphical-resolution', 'short': 'g',
+  'data': 'str',                # FIXME QAPIfy case QAPI_OPTION_KIND_GRA=
PHICAL_RESOLUTION
+  'help': "-g WxH[xDEPTH]  Set the initial graphical resolution and dept=
h" }
+
+##
+# @--vnc:
+# !texinfo
+# -vnc @var{display}[,@var{option}[,@var{option}[,...]]]@*
+# Normally, if QEMU is compiled with graphical window support, it displa=
ys
+# output such as guest graphics, guest console, and the QEMU monitor in =
a
+# window. With this option, you can have QEMU listen on VNC display
+# @var{display} and redirect the VGA display over the VNC session. It is
+# very useful to enable the usb tablet device when using this option
+# (option @option{-device usb-tablet}). When using the VNC display, you
+# must use the @option{-k} parameter to set the keyboard layout if you a=
re
+# not using en-us. Valid syntax for the @var{display} is
+#
+# @table @option
+#
+# @item to=3D@var{L}
+#
+# With this option, QEMU will try next available VNC @var{display}s, unt=
il the
+# number @var{L}, if the origianlly defined "-vnc @var{display}" is not
+# available, e.g. port 5900+@var{display} is already used by another
+# application. By default, to=3D0.
+#
+# @item @var{host}:@var{d}
+#
+# TCP connections will only be allowed from @var{host} on display @var{d=
}.
+# By convention the TCP port is 5900+@var{d}. Optionally, @var{host} can
+# be omitted in which case the server will accept connections from any h=
ost.
+#
+# @item unix:@var{path}
+#
+# Connections will be allowed over UNIX domain sockets where @var{path} =
is the
+# location of a unix socket to listen for connections on.
+#
+# @item none
+#
+# VNC is initialized but not started. The monitor @code{change} command
+# can be used to later start the VNC server.
+#
+# @end table
+#
+# Following the @var{display} value there may be one or more @var{option=
} flags
+# separated by commas. Valid options are
+#
+# @table @option
+#
+# @item reverse
+#
+# Connect to a listening VNC client via a ``reverse'' connection. The
+# client is specified by the @var{display}. For reverse network
+# connections (@var{host}:@var{d},@code{reverse}), the @var{d} argument
+# is a TCP port number, not a display number.
+#
+# @item websocket
+#
+# Opens an additional TCP listening port dedicated to VNC Websocket conn=
ections.
+# If a bare @var{websocket} option is given, the Websocket port is
+# 5700+@var{display}. An alternative port can be specified with the
+# syntax @code{websocket}=3D@var{port}.
+#
+# If @var{host} is specified connections will only be allowed from this =
host.
+# It is possible to control the websocket listen address independently, =
using
+# the syntax @code{websocket}=3D@var{host}:@var{port}.
+#
+# If no TLS credentials are provided, the websocket connection runs in
+# unencrypted mode. If TLS credentials are provided, the websocket conne=
ction
+# requires encrypted client connections.
+#
+# @item password
+#
+# Require that password based authentication is used for client connecti=
ons.
+#
+# The password must be set separately using the @code{set_password} comm=
and in
+# the FIXME @@ref@{pcsys_monitor@}. The syntax to change your password i=
s:
+# @code{set_password <protocol> <password>} where <protocol> could be ei=
ther
+# "vnc" or "spice".
+#
+# If you would like to change <protocol> password expiration, you should=
 use
+# @code{expire_password <protocol> <expiration-time>} where expiration t=
ime could
+# be one of the following options: now, never, +seconds or UNIX time of
+# expiration, e.g. +60 to make password expire in 60 seconds, or 1335196=
800
+# to make password expire on "Mon Apr 23 12:00:00 EDT 2012" (UNIX time f=
or this
+# date and time).
+#
+# You can also use keywords "now" or "never" for the expiration time to
+# allow <protocol> password to expire immediately or never expire.
+#
+# @item tls-creds=3D@var{ID}
+#
+# Provides the ID of a set of TLS credentials to use to secure the
+# VNC server. They will apply to both the normal VNC server socket
+# and the websocket socket (if enabled). Setting TLS credentials
+# will cause the VNC server socket to enable the VeNCrypt auth
+# mechanism.  The credentials should have been previously created
+# using the @option{-object tls-creds} argument.
+#
+# The @option{tls-creds} parameter obsoletes the @option{tls},
+# @option{x509}, and @option{x509verify} options, and as such
+# it is not permitted to set both new and old type options at
+# the same time.
+#
+# @item tls
+#
+# Require that client use TLS when communicating with the VNC server. Th=
is
+# uses anonymous TLS credentials so is susceptible to a man-in-the-middl=
e
+# attack. It is recommended that this option be combined with either the
+# @option{x509} or @option{x509verify} options.
+#
+# This option is now deprecated in favor of using the @option{tls-creds}
+# argument.
+#
+# @item x509=3D@var{/path/to/certificate/dir}
+#
+# Valid if @option{tls} is specified. Require that x509 credentials are =
used
+# for negotiating the TLS session. The server will send its x509 certifi=
cate
+# to the client. It is recommended that a password be set on the VNC ser=
ver
+# to provide authentication of the client when this is used. The path fo=
llowing
+# this option specifies where the x509 certificates are to be loaded fro=
m.
+# See the FIXME @@ref@{vnc_security@} section for details on generating =
certificates.
+#
+# This option is now deprecated in favour of using the @option{tls-creds=
}
+# argument.
+#
+# @item x509verify=3D@var{/path/to/certificate/dir}
+#
+# Valid if @option{tls} is specified. Require that x509 credentials are =
used
+# for negotiating the TLS session. The server will send its x509 certifi=
cate
+# to the client, and request that the client send its own x509 certifica=
te.
+# The server will validate the client's certificate against the CA certi=
ficate,
+# and reject clients when validation fails. If the certificate authority=
 is
+# trusted, this is a sufficient authentication mechanism. You may still =
wish
+# to set a password on the VNC server as a second authentication layer. =
The
+# path following this option specifies where the x509 certificates are t=
o
+# be loaded from. See the FIXME @@ref@{vnc_security@} section for detail=
s on generating
+# certificates.
+#
+# This option is now deprecated in favour of using the @option{tls-creds=
}
+# argument.
+#
+# @item sasl
+#
+# Require that the client use SASL to authenticate with the VNC server.
+# The exact choice of authentication method used is controlled from the
+# system / user's SASL configuration file for the 'qemu' service. This
+# is typically found in /etc/sasl2/qemu.conf. If running QEMU as an
+# unprivileged user, an environment variable SASL_CONF_PATH can be used
+# to make it search alternate locations for the service config.
+# While some SASL auth methods can also provide data encryption (eg GSSA=
PI),
+# it is recommended that SASL always be combined with the 'tls' and
+# 'x509' settings to enable use of SSL and server certificates. This
+# ensures a data encryption preventing compromise of authentication
+# credentials. See the FIXME @@ref@{vnc_security@} section for details o=
n using
+# SASL authentication.
+#
+# @item acl
+#
+# Turn on access control lists for checking of the x509 client certifica=
te
+# and SASL party. For x509 certs, the ACL check is made against the
+# certificate's distinguished name. This is something that looks like
+# @code{C=3DGB,O=3DACME,L=3DBoston,CN=3Dbob}. For SASL party, the ACL ch=
eck is
+# made against the username, which depending on the SASL plugin, may
+# include a realm component, eg @code{bob} or @code{bob@@EXAMPLE.COM}.
+# When the @option{acl} flag is set, the initial access list will be
+# empty, with a @code{deny} policy. Thus no one will be allowed to
+# use the VNC server until the ACLs have been loaded. This can be
+# achieved using the @code{acl} monitor command.
+#
+# @item lossy
+#
+# Enable lossy compression methods (gradient, JPEG, ...). If this
+# option is set, VNC client may receive lossy framebuffer updates
+# depending on its encoding settings. Enabling this option can save
+# a lot of bandwidth at the expense of quality.
+#
+# @item non-adaptive
+#
+# Disable adaptive encodings. Adaptive encodings are enabled by default.
+# An adaptive encoding will try to detect frequently updated screen regi=
ons,
+# and send updates in these regions using a lossy encoding (like JPEG).
+# This can be really helpful to save bandwidth when playing videos. Disa=
bling
+# adaptive encodings restores the original static behavior of encodings
+# like Tight.
+#
+# @item share=3D[allow-exclusive|force-shared|ignore]
+#
+# Set display sharing policy.  'allow-exclusive' allows clients to ask
+# for exclusive access.  As suggested by the rfb spec this is
+# implemented by dropping other connections.  Connecting multiple
+# clients in parallel requires all clients asking for a shared session
+# (vncviewer: -shared switch).  This is the default.  'force-shared'
+# disables exclusive client access.  Useful for shared desktop sessions,
+# where you don't want someone forgetting specify -shared disconnect
+# everybody else.  'ignore' completely ignores the shared flag and
+# allows everybody connect unconditionally.  Doesn't conform to the rfb
+# spec but is traditional QEMU behavior.
+#
+# @item key-delay-ms
+#
+# Set keyboard delay, for key down and key up events, in milliseconds.
+# Default is 10.  Keyboards are low-bandwidth devices, so this slowdown
+# can help the device and guest to keep up and not lose events in case
+# events are arriving in bulk.  Possible causes for the latter are flaky
+# network connections, or scripts for automated testing.
+#
+# @end table
+# !end texinfo
+##
+{ 'option': '--vnc',
+  'data': 'str',                # FIXME QAPIfy qemu_vnc_opts, vnc_parse(=
)
+  'help': "-vnc <display>  shorthand for -display vnc=3D<display>" }
+
+##
+# =3D=3D i386 target only
+# TODO make conditional
+##
+
+##
+# @--win2k-hack:
+# !texinfo
+# -win2k-hack@*
+# Use it when installing Windows 2000 to avoid a disk full bug. After
+# Windows 2000 is installed, you no longer need this option (this option
+# slows down the IDE transfers).
+# !end texinfo
+##
+{ 'option': '--win2k-hack',
+  'help': "-win2k-hack     use it when installing Windows 2000 to avoid =
a disk full bug" }
+
+##
+# @--rtc-td-hack:
+##
+# TODO deprecate
+{ 'option': '--rtc-td-hack',
+  'help': null }
+
+##
+# @--no-fd-bootchk:
+# !texinfo
+# -no-fd-bootchk@*
+# Disable boot signature checking for floppy disks in BIOS. May
+# be needed to boot from old floppy disks.
+# !end texinfo
+##
+{ 'option': '--no-fd-bootchk',
+  'help': "-no-fd-bootchk  disable boot signature checking for floppy di=
sks" }
+
+##
+# @--no-acpi:
+# !texinfo
+# -no-acpi@*
+# Disable ACPI (Advanced Configuration and Power Interface) support. Use
+# it if your guest OS complains about ACPI problems (PC target machine
+# only).
+# !end texinfo
+##
+{ 'option': '--no-acpi',
+  'help': "-no-acpi        disable ACPI" }
+
+##
+# @--no-hpet:
+# !texinfo
+# -no-hpet@*
+# Disable HPET support.
+# !end texinfo
+##
+{ 'option': '--no-hpet',
+  'help': "-no-hpet        disable HPET" }
+
+##
+# @--acpitable:
+# !texinfo
+# -acpitable [sig=3D@var{str}][,rev=3D@var{n}][,oem_id=3D@var{str}][,oem=
_table_id=3D@var{str}][,oem_rev=3D@var{n}] [,asl_compiler_id=3D@var{str}]=
[,asl_compiler_rev=3D@var{n}][,data=3D@var{file1}[:@var{file2}]...]@*
+# Add ACPI table with specified header fields and context from specified=
 files.
+# For file=3D, take whole ACPI table from the specified files, including=
 all
+# ACPI headers (possible overridden by other options).
+# For data=3D, only data
+# portion of the table is used, all header information is specified in t=
he
+# command line.
+# If a SLIC table is supplied to QEMU, then the SLIC's oem_id and oem_ta=
ble_id
+# fields will override the same in the RSDT and the FADT (a.k.a. FACP), =
in order
+# to ensure the field matches required by the Microsoft SLIC spec and th=
e ACPI
+# spec.
+# !end texinfo
+##
+{ 'option': '--acpitable',
+  'data': 'str',                # FIXME QAPIfy qemu_acpi_opts: AcpiTable=
Options
+  'help': [
+"-acpitable [sig=3Dstr][,rev=3Dn][,oem_id=3Dstr][,oem_table_id=3Dstr][,o=
em_rev=3Dn][,asl_compiler_id=3Dstr][,asl_compiler_rev=3Dn][,{data|file}=3D=
file1[:file2]...]",
+"                ACPI table description"] }
+
+##
+# @--smbios:
+# !texinfo
+# -smbios file=3D@var{binary}@*
+# Load SMBIOS entry from binary file.
+#
+# -smbios type=3D0[,vendor=3D@var{str}][,version=3D@var{str}][,date=3D@v=
ar{str}][,release=3D@var{%d.%d}][,uefi=3Don|off]@*
+# Specify SMBIOS type 0 fields
+#
+# -smbios type=3D1[,manufacturer=3D@var{str}][,product=3D@var{str}][,ver=
sion=3D@var{str}][,serial=3D@var{str}][,uuid=3D@var{uuid}][,sku=3D@var{st=
r}][,family=3D@var{str}]@*
+# Specify SMBIOS type 1 fields
+#
+# -smbios type=3D2[,manufacturer=3D@var{str}][,product=3D@var{str}][,ver=
sion=3D@var{str}][,serial=3D@var{str}][,asset=3D@var{str}][,location=3D@v=
ar{str}][,family=3D@var{str}]@*
+# Specify SMBIOS type 2 fields
+#
+# -smbios type=3D3[,manufacturer=3D@var{str}][,version=3D@var{str}][,ser=
ial=3D@var{str}][,asset=3D@var{str}][,sku=3D@var{str}]@*
+# Specify SMBIOS type 3 fields
+#
+# -smbios type=3D4[,sock_pfx=3D@var{str}][,manufacturer=3D@var{str}][,ve=
rsion=3D@var{str}][,serial=3D@var{str}][,asset=3D@var{str}][,part=3D@var{=
str}]@*
+# Specify SMBIOS type 4 fields
+#
+# -smbios type=3D17[,loc_pfx=3D@var{str}][,bank=3D@var{str}][,manufactur=
er=3D@var{str}][,serial=3D@var{str}][,asset=3D@var{str}][,part=3D@var{str=
}][,speed=3D@var{%d}]@*
+# Specify SMBIOS type 17 fields
+# !end texinfo
+##
+{ 'option': '--smbios',
+  'data': 'str',                # FIXME QAPIfy qemu_smbios_opts
+  'help': [
+"-smbios file=3Dbinary",
+"                load SMBIOS entry from binary file",
+"-smbios type=3D0[,vendor=3Dstr][,version=3Dstr][,date=3Dstr][,release=3D=
%d.%d]",
+"              [,uefi=3Don|off]",
+"                specify SMBIOS type 0 fields",
+"-smbios type=3D1[,manufacturer=3Dstr][,product=3Dstr][,version=3Dstr][,=
serial=3Dstr]",
+"              [,uuid=3Duuid][,sku=3Dstr][,family=3Dstr]",
+"                specify SMBIOS type 1 fields",
+"-smbios type=3D2[,manufacturer=3Dstr][,product=3Dstr][,version=3Dstr][,=
serial=3Dstr]",
+"              [,asset=3Dstr][,location=3Dstr]",
+"                specify SMBIOS type 2 fields",
+"-smbios type=3D3[,manufacturer=3Dstr][,version=3Dstr][,serial=3Dstr][,a=
sset=3Dstr]",
+"              [,sku=3Dstr]",
+"                specify SMBIOS type 3 fields",
+"-smbios type=3D4[,sock_pfx=3Dstr][,manufacturer=3Dstr][,version=3Dstr][=
,serial=3Dstr]",
+"              [,asset=3Dstr][,part=3Dstr]",
+"                specify SMBIOS type 4 fields",
+"-smbios type=3D17[,loc_pfx=3Dstr][,bank=3Dstr][,manufacturer=3Dstr][,se=
rial=3Dstr]",
+"               [,asset=3Dstr][,part=3Dstr][,speed=3D%d]",
+"                specify SMBIOS type 17 fields"] }
+
+##
+# =3D=3D Network options
+##
+
+##
+# @--tftp:
+##
+# TODO deprecate
+{ 'option': '--tftp',
+  'data': 'str',
+  'help': null }
+
+##
+# @--bootp:
+##
+# TODO deprecate
+{ 'option': '--bootp',
+  'data': 'str',
+  'help': null }
+
+##
+# @--redir:
+##
+# TODO deprecate
+{ 'option': '--redir',
+  'data': 'str',                # FIXME QAPIfy slirp_hostfwd()
+  'help': null }
+
+##
+# @--smb:
+##
+# TODO deprecate
+{ 'option': '--smb',
+  'data': 'str',
+  'help': null }
+
+##
+# @--netdev:
+##
+{ 'option': '--netdev',
+  'data': 'str',                # FIXME QAPIfy qemu_netdev_opts
+  'help': [
+#ifdef CONFIG_SLIRP
+"-netdev user,id=3Dstr[,ipv4[=3Don|off]][,net=3Daddr[/mask]][,host=3Dadd=
r]",
+"         [,ipv6[=3Don|off]][,ipv6-net=3Daddr[/int]][,ipv6-host=3Daddr]"=
,
+"         [,restrict=3Don|off][,hostname=3Dhost][,dhcpstart=3Daddr]",
+"         [,dns=3Daddr][,ipv6-dns=3Daddr][,dnssearch=3Ddomain][,tftp=3Dd=
ir]",
+"         [,bootfile=3Df][,hostfwd=3Drule][,guestfwd=3Drule]",
+#ifndef _WIN32
+#"         [,smb=3Ddir[,smbserver=3Daddr]]",
+#endif
+"                configure a user mode network backend with ID 'str',",
+"                its DHCP server and optional services",
+#endif
+#ifdef _WIN32
+#"-netdev tap,id=3Dstr,ifname=3Dname",
+#"                configure a host TAP network backend with ID 'str'",
+#else
+"-netdev tap,id=3Dstr[,fd=3Dh][,fds=3Dx:y:...:z][,ifname=3Dname][,script=
=3Dfile][,downscript=3Ddfile]",
+"         [,br=3Dbridge][,helper=3Dhelper][,sndbuf=3Dnbytes][,vnet_hdr=3D=
on|off][,vhost=3Don|off]",
+"         [,vhostfd=3Dh][,vhostfds=3Dx:y:...:z][,vhostforce=3Don|off][,q=
ueues=3Dn]",
+"         [,poll-us=3Dn]",
+"                configure a host TAP network backend with ID 'str'",
+"                connected to a bridge (default=3DFIXME)",
+"                use network scripts 'file' (default=3DFIXME)",
+"                to configure it and 'dfile' (default=3DFIXME)",
+"                to deconfigure it",
+"                use '[down]script=3Dno' to disable script execution",
+"                use network helper 'helper' (default=3DFIXME) to",
+"                configure it",
+"                use 'fd=3Dh' to connect to an already opened TAP interf=
ace",
+"                use 'fds=3Dx:y:...:z' to connect to already opened mult=
iqueue capable TAP interfaces",
+"                use 'sndbuf=3Dnbytes' to limit the size of the send buf=
fer (the",
+"                default is disabled 'sndbuf=3D0' to enable flow control=
 set 'sndbuf=3D1048576')",
+"                use vnet_hdr=3Doff to avoid enabling the IFF_VNET_HDR t=
ap flag",
+"                use vnet_hdr=3Don to make the lack of IFF_VNET_HDR supp=
ort an error condition",
+"                use vhost=3Don to enable experimental in kernel acceler=
ator",
+"                    (only has effect for virtio guests which use MSIX)"=
,
+"                use vhostforce=3Don to force vhost on for non-MSIX virt=
io guests",
+"                use 'vhostfd=3Dh' to connect to an already opened vhost=
 net device",
+"                use 'vhostfds=3Dx:y:...:z to connect to multiple alread=
y opened vhost net devices",
+"                use 'queues=3Dn' to specify the number of queues to be =
created for multiqueue TAP",
+"                use 'poll-us=3Dn' to speciy the maximum number of micro=
seconds that could be",
+"                spent on busy polling for vhost net",
+"-netdev bridge,id=3Dstr[,br=3Dbridge][,helper=3Dhelper]",
+"                configure a host TAP network backend with ID 'str' that=
 is",
+"                connected to a bridge (default=3DFIXME)",
+"                using the program 'helper (default=3DFIXME)",
+#endif
+#ifdef __linux__
+"-netdev l2tpv3,id=3Dstr,src=3Dsrcaddr,dst=3Ddstaddr[,srcport=3Dsrcport]=
[,dstport=3Ddstport]",
+"         [,rxsession=3Drxsession],txsession=3Dtxsession[,ipv6=3Don/off]=
[,udp=3Don/off]",
+"         [,cookie64=3Don/off][,counter][,pincounter][,txcookie=3Dtxcook=
ie]",
+"         [,rxcookie=3Drxcookie][,offset=3Doffset]",
+"                configure a network backend with ID 'str' connected to"=
,
+"                an Ethernet over L2TPv3 pseudowire.",
+"                Linux kernel 3.3+ as well as most routers can talk",
+"                L2TPv3. This transport allows connecting a VM to a VM,"=
,
+"                VM to a router and even VM to Host. It is a nearly-univ=
ersal",
+"                standard (RFC3391). Note - this implementation uses sta=
tic",
+"                pre-configured tunnels (same as the Linux kernel).",
+"                use 'src=3D' to specify source address",
+"                use 'dst=3D' to specify destination address",
+"                use 'udp=3Don' to specify udp encapsulation",
+"                use 'srcport=3D' to specify source udp port",
+"                use 'dstport=3D' to specify destination udp port",
+"                use 'ipv6=3Don' to force v6",
+"                L2TPv3 uses cookies to prevent misconfiguration as",
+"                well as a weak security measure",
+"                use 'rxcookie=3D0x012345678' to specify a rxcookie",
+"                use 'txcookie=3D0x012345678' to specify a txcookie",
+"                use 'cookie64=3Don' to set cookie size to 64 bit, other=
wise 32",
+"                use 'counter=3Doff' to force a 'cut-down' L2TPv3 with n=
o counter",
+"                use 'pincounter=3Don' to work around broken counter han=
dling in peer",
+"                use 'offset=3DX' to add an extra offset between header =
and data",
+#endif
+"-netdev socket,id=3Dstr[,fd=3Dh][,listen=3D[host]:port][,connect=3Dhost=
:port]",
+"                configure a network backend to connect to another netwo=
rk",
+"                using a socket connection",
+"-netdev socket,id=3Dstr[,fd=3Dh][,mcast=3Dmaddr:port[,localaddr=3Daddr]=
]",
+"                configure a network backend to connect to a multicast m=
addr and port",
+"                use 'localaddr=3Daddr' to specify the host address to s=
end packets from",
+"-netdev socket,id=3Dstr[,fd=3Dh][,udp=3Dhost:port][,localaddr=3Dhost:po=
rt]",
+"                configure a network backend to connect to another netwo=
rk",
+"                using an UDP tunnel",
+#ifdef CONFIG_VDE
+"-netdev vde,id=3Dstr[,sock=3Dsocketpath][,port=3Dn][,group=3Dgroupname]=
[,mode=3Doctalmode]",
+"                configure a network backend to connect to port 'n' of a=
 vde switch",
+"                running on host and listening for incoming connections =
on 'socketpath'.",
+"                Use group 'groupname' and mode 'octalmode' to change de=
fault",
+"                ownership and permissions for communication port.",
+#endif
+#ifdef CONFIG_NETMAP
+"-netdev netmap,id=3Dstr,ifname=3Dname[,devname=3Dnmname]",
+"                attach to the existing netmap-enabled network interface=
 'name', or to a",
+"                VALE port (created on the fly) called 'name' ('nmname' =
is name of the ",
+"                netmap device, defaults to '/dev/netmap')",
+#endif
+"-netdev vhost-user,id=3Dstr,chardev=3Ddev[,vhostforce=3Don|off]",
+"                configure a vhost-user network, backed by a chardev 'de=
v'",
+"-netdev hubport,id=3Dstr,hubid=3Dn",
+"                configure a hub port on QEMU VLAN 'n'"] }
+
+##
+# @--net:
+# !texinfo
+# -net nic[,vlan=3D@var{n}][,macaddr=3D@var{mac}][,model=3D@var{type}] [=
,name=3D@var{name}][,addr=3D@var{addr}][,vectors=3D@var{v}]@*
+# Create a new Network Interface Card and connect it to VLAN @var{n} (@v=
ar{n}
+# =3D 0 is the default). The NIC is an e1000 by default on the PC
+# target. Optionally, the MAC address can be changed to @var{mac}, the
+# device address set to @var{addr} (PCI cards only),
+# and a @var{name} can be assigned for use in monitor commands.
+# Optionally, for PCI cards, you can specify the number @var{v} of MSI-X=
 vectors
+# that the card should have; this option currently only affects virtio c=
ards; set
+# @var{v} =3D 0 to disable MSI-X. If no @option{-net} option is specifie=
d, a single
+# NIC is created.  QEMU can emulate several different models of network =
card.
+# Valid values for @var{type} are
+# @code{virtio}, @code{i82551}, @code{i82557b}, @code{i82559er},
+# @code{ne2k_pci}, @code{ne2k_isa}, @code{pcnet}, @code{rtl8139},
+# @code{e1000}, @code{smc91c111}, @code{lance} and @code{mcf_fec}.
+# Not all devices are supported on all targets.  Use @code{-net nic,mode=
l=3Dhelp}
+# for a list of available devices for your target.
+#
+# -netdev user,id=3D@var{id}[,@var{option}][,@var{option}][,...]@*
+# -net user[,@var{option}][,@var{option}][,...]@*
+# Use the user mode network stack which requires no administrator
+# privilege to run. Valid options are:
+#
+# @table @option
+# @item vlan=3D@var{n}
+# Connect user mode stack to VLAN @var{n} (@var{n} =3D 0 is the default)=
.
+#
+# @item id=3D@var{id}
+# @itemx name=3D@var{name}
+# Assign symbolic name for use in monitor commands.
+#
+# @option{ipv4} and @option{ipv6} specify that either IPv4 or IPv6 must
+# be enabled.  If neither is specified both protocols are enabled.
+#
+# @item net=3D@var{addr}[/@var{mask}]
+# Set IP network address the guest will see. Optionally specify the netm=
ask,
+# either in the form a.b.c.d or as number of valid top-most bits. Defaul=
t is
+# 10.0.2.0/24.
+#
+# @item host=3D@var{addr}
+# Specify the guest-visible address of the host. Default is the 2nd IP i=
n the
+# guest network, i.e. x.x.x.2.
+#
+# @item ipv6-net=3D@var{addr}[/@var{int}]
+# Set IPv6 network address the guest will see (default is fec0::/64). Th=
e
+# network prefix is given in the usual hexadecimal IPv6 address
+# notation. The prefix size is optional, and is given as the number of
+# valid top-most bits (default is 64).
+#
+# @item ipv6-host=3D@var{addr}
+# Specify the guest-visible IPv6 address of the host. Default is the 2nd=
 IPv6 in
+# the guest network, i.e. xxxx::2.
+#
+# @item restrict=3Don|off
+# If this option is enabled, the guest will be isolated, i.e. it will no=
t be
+# able to contact the host and no guest IP packets will be routed over t=
he host
+# to the outside. This option does not affect any explicitly set forward=
ing rules.
+#
+# @item hostname=3D@var{name}
+# Specifies the client hostname reported by the built-in DHCP server.
+#
+# @item dhcpstart=3D@var{addr}
+# Specify the first of the 16 IPs the built-in DHCP server can assign. D=
efault
+# is the 15th to 31st IP in the guest network, i.e. x.x.x.15 to x.x.x.31=
.
+#
+# @item dns=3D@var{addr}
+# Specify the guest-visible address of the virtual nameserver. The addre=
ss must
+# be different from the host address. Default is the 3rd IP in the guest=
 network,
+# i.e. x.x.x.3.
+#
+# @item ipv6-dns=3D@var{addr}
+# Specify the guest-visible address of the IPv6 virtual nameserver. The =
address
+# must be different from the host address. Default is the 3rd IP in the =
guest
+# network, i.e. xxxx::3.
+#
+# @item dnssearch=3D@var{domain}
+# Provides an entry for the domain-search list sent by the built-in
+# DHCP server. More than one domain suffix can be transmitted by specify=
ing
+# this option multiple times. If supported, this will cause the guest to
+# automatically try to append the given domain suffix(es) in case a doma=
in name
+# can not be resolved.
+#
+# Example:
+# @example
+# qemu -net user,dnssearch=3Dmgmt.example.org,dnssearch=3Dexample.org [.=
..]
+# @end example
+#
+# @item tftp=3D@var{dir}
+# When using the user mode network stack, activate a built-in TFTP
+# server. The files in @var{dir} will be exposed as the root of a TFTP s=
erver.
+# The TFTP client on the guest must be configured in binary mode (use th=
e command
+# @code{bin} of the Unix TFTP client).
+#
+# @item bootfile=3D@var{file}
+# When using the user mode network stack, broadcast @var{file} as the BO=
OTP
+# filename. In conjunction with @option{tftp}, this can be used to netwo=
rk boot
+# a guest from a local directory.
+#
+# Example (using pxelinux):
+# @example
+# qemu-system-i386 -hda linux.img -boot n -net user,tftp=3D/path/to/tftp=
/files,bootfile=3D/pxelinux.0
+# @end example
+#
+# @item smb=3D@var{dir}[,smbserver=3D@var{addr}]
+# When using the user mode network stack, activate a built-in SMB
+# server so that Windows OSes can access to the host files in @file{@var=
{dir}}
+# transparently. The IP address of the SMB server can be set to @var{add=
r}. By
+# default the 4th IP in the guest network is used, i.e. x.x.x.4.
+#
+# In the guest Windows OS, the line:
+# @example
+# 10.0.2.4 smbserver
+# @end example
+# must be added in the file @file{C:\WINDOWS\LMHOSTS} (for windows 9x/Me=
)
+# or @file{C:\WINNT\SYSTEM32\DRIVERS\ETC\LMHOSTS} (Windows NT/2000).
+#
+# Then @file{@var{dir}} can be accessed in @file{\\smbserver\qemu}.
+#
+# Note that a SAMBA server must be installed on the host OS.
+# QEMU was tested successfully with smbd versions from Red Hat 9,
+# Fedora Core 3 and OpenSUSE 11.x.
+#
+# @item hostfwd=3D[tcp|udp]:[@var{hostaddr}]:@var{hostport}-[@var{guesta=
ddr}]:@var{guestport}
+# Redirect incoming TCP or UDP connections to the host port @var{hostpor=
t} to
+# the guest IP address @var{guestaddr} on guest port @var{guestport}. If
+# @var{guestaddr} is not specified, its value is x.x.x.15 (default first=
 address
+# given by the built-in DHCP server). By specifying @var{hostaddr}, the =
rule can
+# be bound to a specific host interface. If no connection type is set, T=
CP is
+# used. This option can be given multiple times.
+#
+# For example, to redirect host X11 connection from screen 1 to guest
+# screen 0, use the following:
+#
+# @example
+# # on the host
+# qemu-system-i386 -net user,hostfwd=3Dtcp:127.0.0.1:6001-:6000 [...]
+# # this host xterm should open in the guest X11 server
+# xterm -display :1
+# @end example
+#
+# To redirect telnet connections from host port 5555 to telnet port on
+# the guest, use the following:
+#
+# @example
+# # on the host
+# qemu-system-i386 -net user,hostfwd=3Dtcp::5555-:23 [...]
+# telnet localhost 5555
+# @end example
+#
+# Then when you use on the host @code{telnet localhost 5555}, you
+# connect to the guest telnet server.
+#
+# @item guestfwd=3D[tcp]:@var{server}:@var{port}-@var{dev}
+# @itemx guestfwd=3D[tcp]:@var{server}:@var{port}-@var{cmd:command}
+# Forward guest TCP connections to the IP address @var{server} on port @=
var{port}
+# to the character device @var{dev} or to a program executed by @var{cmd=
:command}
+# which gets spawned for each connection. This option can be given multi=
ple times.
+#
+# You can either use a chardev directly and have that one used throughou=
t QEMU's
+# lifetime, like in the following example:
+#
+# @example
+# # open 10.10.1.1:4321 on bootup, connect 10.0.2.100:1234 to it wheneve=
r
+# # the guest accesses it
+# qemu -net user,guestfwd=3Dtcp:10.0.2.100:1234-tcp:10.10.1.1:4321 [...]
+# @end example
+#
+# Or you can execute a command on every TCP connection established by th=
e guest,
+# so that QEMU behaves similar to an inetd process for that virtual serv=
er:
+#
+# @example
+# # call "netcat 10.10.1.1 4321" on every TCP connection to 10.0.2.100:1=
234
+# # and connect the TCP stream to its stdin/stdout
+# qemu -net 'user,guestfwd=3Dtcp:10.0.2.100:1234-cmd:netcat 10.10.1.1 43=
21'
+# @end example
+#
+# @end table
+#
+# Note: Legacy stand-alone options -tftp, -bootp, -smb and -redir are st=
ill
+# processed and applied to -net user. Mixing them with the new configura=
tion
+# syntax gives undefined results. Their use for new applications is disc=
ouraged
+# as they will be removed from future versions.
+#
+# -netdev tap,id=3D@var{id}[,fd=3D@var{h}][,ifname=3D@var{name}][,script=
=3D@var{file}][,downscript=3D@var{dfile}][,br=3D@var{bridge}][,helper=3D@=
var{helper}]@*
+# -net tap[,vlan=3D@var{n}][,name=3D@var{name}][,fd=3D@var{h}][,ifname=3D=
@var{name}][,script=3D@var{file}][,downscript=3D@var{dfile}][,br=3D@var{b=
ridge}][,helper=3D@var{helper}]@*
+# Connect the host TAP network interface @var{name} to VLAN @var{n}.
+#
+# Use the network script @var{file} to configure it and the network scri=
pt
+# @var{dfile} to deconfigure it. If @var{name} is not provided, the OS
+# automatically provides one. The default network configure script is
+# @file{/etc/qemu-ifup} and the default network deconfigure script is
+# @file{/etc/qemu-ifdown}. Use @option{script=3Dno} or @option{downscrip=
t=3Dno}
+# to disable script execution.
+#
+# If running QEMU as an unprivileged user, use the network helper
+# @var{helper} to configure the TAP interface and attach it to the bridg=
e.
+# The default network helper executable is @file{/path/to/qemu-bridge-he=
lper}
+# and the default bridge device is @file{br0}.
+#
+# @option{fd}=3D@var{h} can be used to specify the handle of an already
+# opened host TAP interface.
+#
+# Examples:
+#
+# @example
+# #launch a QEMU instance with the default network script
+# qemu-system-i386 linux.img -net nic -net tap
+# @end example
+#
+# @example
+# #launch a QEMU instance with two NICs, each one connected
+# #to a TAP device
+# qemu-system-i386 linux.img \
+#                  -net nic,vlan=3D0 -net tap,vlan=3D0,ifname=3Dtap0 \
+#                  -net nic,vlan=3D1 -net tap,vlan=3D1,ifname=3Dtap1
+# @end example
+#
+# @example
+# #launch a QEMU instance with the default network helper to
+# #connect a TAP device to bridge br0
+# qemu-system-i386 linux.img \
+#                  -net nic -net tap,"helper=3D/path/to/qemu-bridge-help=
er"
+# @end example
+#
+# -netdev bridge,id=3D@var{id}[,br=3D@var{bridge}][,helper=3D@var{helper=
}]@*
+# -net bridge[,vlan=3D@var{n}][,name=3D@var{name}][,br=3D@var{bridge}][,=
helper=3D@var{helper}]@*
+# Connect a host TAP network interface to a host bridge device.
+#
+# Use the network helper @var{helper} to configure the TAP interface and
+# attach it to the bridge. The default network helper executable is
+# @file{/path/to/qemu-bridge-helper} and the default bridge
+# device is @file{br0}.
+#
+# Examples:
+#
+# @example
+# #launch a QEMU instance with the default network helper to
+# #connect a TAP device to bridge br0
+# qemu-system-i386 linux.img -net bridge -net nic,model=3Dvirtio
+# @end example
+#
+# @example
+# #launch a QEMU instance with the default network helper to
+# #connect a TAP device to bridge qemubr0
+# qemu-system-i386 linux.img -net bridge,br=3Dqemubr0 -net nic,model=3Dv=
irtio
+# @end example
+#
+# -netdev socket,id=3D@var{id}[,fd=3D@var{h}][,listen=3D[@var{host}]:@va=
r{port}][,connect=3D@var{host}:@var{port}]@*
+# -net socket[,vlan=3D@var{n}][,name=3D@var{name}][,fd=3D@var{h}] [,list=
en=3D[@var{host}]:@var{port}][,connect=3D@var{host}:@var{port}]@*
+#
+# Connect the VLAN @var{n} to a remote VLAN in another QEMU virtual
+# machine using a TCP socket connection. If @option{listen} is
+# specified, QEMU waits for incoming connections on @var{port}
+# (@var{host} is optional). @option{connect} is used to connect to
+# another QEMU instance using the @option{listen} option. @option{fd}=3D=
@var{h}
+# specifies an already opened TCP socket.
+#
+# Example:
+# @example
+# # launch a first QEMU instance
+# qemu-system-i386 linux.img \
+#                  -net nic,macaddr=3D52:54:00:12:34:56 \
+#                  -net socket,listen=3D:1234
+# # connect the VLAN 0 of this instance to the VLAN 0
+# # of the first instance
+# qemu-system-i386 linux.img \
+#                  -net nic,macaddr=3D52:54:00:12:34:57 \
+#                  -net socket,connect=3D127.0.0.1:1234
+# @end example
+#
+# -netdev socket,id=3D@var{id}[,fd=3D@var{h}][,mcast=3D@var{maddr}:@var{=
port}[,localaddr=3D@var{addr}]]@*
+# -net socket[,vlan=3D@var{n}][,name=3D@var{name}][,fd=3D@var{h}][,mcast=
=3D@var{maddr}:@var{port}[,localaddr=3D@var{addr}]]@*
+#
+# Create a VLAN @var{n} shared with another QEMU virtual
+# machines using a UDP multicast socket, effectively making a bus for
+# every QEMU with same multicast address @var{maddr} and @var{port}.
+# NOTES:
+# @enumerate
+# @item
+# Several QEMU can be running on different hosts and share same bus (ass=
uming
+# correct multicast setup for these hosts).
+# @item
+# mcast support is compatible with User Mode Linux (argument @option{eth=
@var{N}=3Dmcast}), see
+# @url{http://user-mode-linux.sf.net}.
+# @item
+# Use @option{fd=3Dh} to specify an already opened UDP multicast socket.
+# @end enumerate
+#
+# Example:
+# @example
+# # launch one QEMU instance
+# qemu-system-i386 linux.img \
+#                  -net nic,macaddr=3D52:54:00:12:34:56 \
+#                  -net socket,mcast=3D230.0.0.1:1234
+# # launch another QEMU instance on same "bus"
+# qemu-system-i386 linux.img \
+#                  -net nic,macaddr=3D52:54:00:12:34:57 \
+#                  -net socket,mcast=3D230.0.0.1:1234
+# # launch yet another QEMU instance on same "bus"
+# qemu-system-i386 linux.img \
+#                  -net nic,macaddr=3D52:54:00:12:34:58 \
+#                  -net socket,mcast=3D230.0.0.1:1234
+# @end example
+#
+# Example (User Mode Linux compat.):
+# @example
+# # launch QEMU instance (note mcast address selected
+# # is UML's default)
+# qemu-system-i386 linux.img \
+#                  -net nic,macaddr=3D52:54:00:12:34:56 \
+#                  -net socket,mcast=3D239.192.168.1:1102
+# # launch UML
+# /path/to/linux ubd0=3D/path/to/root_fs eth0=3Dmcast
+# @end example
+#
+# Example (send packets from host's 1.2.3.4):
+# @example
+# qemu-system-i386 linux.img \
+#                  -net nic,macaddr=3D52:54:00:12:34:56 \
+#                  -net socket,mcast=3D239.192.168.1:1102,localaddr=3D1.=
2.3.4
+# @end example
+#
+# -netdev l2tpv3,id=3D@var{id},src=3D@var{srcaddr},dst=3D@var{dstaddr}[,=
srcport=3D@var{srcport}][,dstport=3D@var{dstport}],txsession=3D@var{txses=
sion}[,rxsession=3D@var{rxsession}][,ipv6][,udp][,cookie64][,counter][,pi=
ncounter][,txcookie=3D@var{txcookie}][,rxcookie=3D@var{rxcookie}][,offset=
=3D@var{offset}]@*
+# -net l2tpv3[,vlan=3D@var{n}][,name=3D@var{name}],src=3D@var{srcaddr},d=
st=3D@var{dstaddr}[,srcport=3D@var{srcport}][,dstport=3D@var{dstport}],tx=
session=3D@var{txsession}[,rxsession=3D@var{rxsession}][,ipv6][,udp][,coo=
kie64][,counter][,pincounter][,txcookie=3D@var{txcookie}][,rxcookie=3D@va=
r{rxcookie}][,offset=3D@var{offset}]@*
+# Connect VLAN @var{n} to L2TPv3 pseudowire. L2TPv3 (RFC3391) is a popul=
ar
+# protocol to transport Ethernet (and other Layer 2) data frames between
+# two systems. It is present in routers, firewalls and the Linux kernel
+# (from version 3.3 onwards).
+#
+# This transport allows a VM to communicate to another VM, router or fir=
ewall directly.
+#
+# @table @option
+# @item src=3D@var{srcaddr}
+#     source address (mandatory)
+# @item dst=3D@var{dstaddr}
+#     destination address (mandatory)
+# @item udp
+#     select udp encapsulation (default is ip).
+# @item srcport=3D@var{srcport}
+#     source udp port.
+# @item dstport=3D@var{dstport}
+#     destination udp port.
+# @item ipv6
+#     force v6, otherwise defaults to v4.
+# @item rxcookie=3D@var{rxcookie}
+# @itemx txcookie=3D@var{txcookie}
+#     Cookies are a weak form of security in the l2tpv3 specification.
+# Their function is mostly to prevent misconfiguration. By default they =
are 32
+# bit.
+# @item cookie64
+#     Set cookie size to 64 bit instead of the default 32
+# @item counter=3Doff
+#     Force a 'cut-down' L2TPv3 with no counter as in
+# draft-mkonstan-l2tpext-keyed-ipv6-tunnel-00
+# @item pincounter=3Don
+#     Work around broken counter handling in peer. This may also help on
+# networks which have packet reorder.
+# @item offset=3D@var{offset}
+#     Add an extra offset between header and data
+# @end table
+#
+# For example, to attach a VM running on host 4.3.2.1 via L2TPv3 to the =
bridge br-lan
+# on the remote Linux host 1.2.3.4:
+# @example
+# # Setup tunnel on linux host using raw ip as encapsulation
+# # on 1.2.3.4
+# ip l2tp add tunnel remote 4.3.2.1 local 1.2.3.4 tunnel_id 1 peer_tunne=
l_id 1 \
+#     encap udp udp_sport 16384 udp_dport 16384
+# ip l2tp add session tunnel_id 1 name vmtunnel0 session_id \
+#     0xFFFFFFFF peer_session_id 0xFFFFFFFF
+# ifconfig vmtunnel0 mtu 1500
+# ifconfig vmtunnel0 up
+# brctl addif br-lan vmtunnel0
+#
+#
+# # on 4.3.2.1
+# # launch QEMU instance - if your network has reorder or is very lossy =
add ,pincounter
+#
+# qemu-system-i386 linux.img -net nic -net l2tpv3,src=3D4.2.3.1,dst=3D1.=
2.3.4,udp,srcport=3D16384,dstport=3D16384,rxsession=3D0xffffffff,txsessio=
n=3D0xffffffff,counter
+#
+#
+# @end example
+#
+# -netdev vde,id=3D@var{id}[,sock=3D@var{socketpath}][,port=3D@var{n}][,=
group=3D@var{groupname}][,mode=3D@var{octalmode}]@*
+# -net vde[,vlan=3D@var{n}][,name=3D@var{name}][,sock=3D@var{socketpath}=
] [,port=3D@var{n}][,group=3D@var{groupname}][,mode=3D@var{octalmode}]@*
+# Connect VLAN @var{n} to PORT @var{n} of a vde switch running on host a=
nd
+# listening for incoming connections on @var{socketpath}. Use GROUP @var=
{groupname}
+# and MODE @var{octalmode} to change default ownership and permissions f=
or
+# communication port. This option is only available if QEMU has been com=
piled
+# with vde support enabled.
+#
+# Example:
+# @example
+# # launch vde switch
+# vde_switch -F -sock /tmp/myswitch
+# # launch QEMU instance
+# qemu-system-i386 linux.img -net nic -net vde,sock=3D/tmp/myswitch
+# @end example
+#
+# -netdev hubport,id=3D@var{id},hubid=3D@var{hubid}@*
+#
+# Create a hub port on QEMU "vlan" @var{hubid}.
+#
+# The hubport netdev lets you connect a NIC to a QEMU "vlan" instead of =
a single
+# netdev.  @code{-net} and @code{-device} with parameter @option{vlan} c=
reate the
+# required hub automatically.
+#
+# -netdev vhost-user,chardev=3D@var{id}[,vhostforce=3Don|off][,queues=3D=
n]@*
+#
+# Establish a vhost-user netdev, backed by a chardev @var{id}. The chard=
ev should
+# be a unix domain socket backed one. The vhost-user uses a specifically=
 defined
+# protocol to pass vhost ioctl replacement messages to an application on=
 the other
+# end of the socket. On non-MSIX guests, the feature can be forced with
+# @var{vhostforce}. Use 'queues=3D@var{n}' to specify the number of queu=
es to
+# be created for multiqueue vhost-user.
+#
+# Example:
+# @example
+# qemu -m 512 -object memory-backend-file,id=3Dmem,size=3D512M,mem-path=3D=
/hugetlbfs,share=3Don \
+#      -numa node,memdev=3Dmem \
+#      -chardev socket,id=3Dchr0,path=3D/path/to/socket \
+#      -netdev type=3Dvhost-user,id=3Dnet0,chardev=3Dchr0 \
+#      -device virtio-net-pci,netdev=3Dnet0
+# @end example
+#
+# -net dump[,vlan=3D@var{n}][,file=3D@var{file}][,len=3D@var{len}]@*
+# Dump network traffic on VLAN @var{n} to file @var{file} (@file{qemu-vl=
an0.pcap} by default).
+# At most @var{len} bytes (64k by default) per packet are stored. The fi=
le format is
+# libpcap, so it can be analyzed with tools such as tcpdump or Wireshark=
.
+# Note: For devices created with '-netdev', use '-object filter-dump,...=
' instead.
+#
+# -net none@*
+# Indicate that no network devices should be configured. It is used to
+# override the default configuration (@option{-net nic -net user}) which
+# is activated if no @option{-net} options are provided.
+# !end texinfo
+##
+{ 'option': '--net',
+  'data': 'str',                # FIXME QAPIfy
+  'help': [
+"-net nic[,vlan=3Dn][,macaddr=3Dmac][,model=3Dtype][,name=3Dstr][,addr=3D=
str][,vectors=3Dv]",
+"                old way to create a new NIC and connect it to VLAN 'n'"=
,
+"                (use the '-device devtype,netdev=3Dstr' option if possi=
ble instead)",
+"-net dump[,vlan=3Dn][,file=3Df][,len=3Dn]",
+"                dump traffic on vlan 'n' to file 'f' (max n bytes per p=
acket)",
+"-net none       use it alone to have zero network devices. If no -net o=
ption",
+"                is provided, the default is '-net nic -net user'",
+"-net [user|tap|bridge|vde|netmap|socket][,vlan=3Dn][,option][,option][,=
...]",
+# FIXME conditionals ^^^
+"                old way to initialize a host network interface",
+"                (use the -netdev option if possible instead)" ] }
+
+##
+# =3D=3D Character device options
+##
+
+##
+# @--chardev:
+# !texinfo
+# The general form of a character device option is:
+# -chardev @var{backend} ,id=3D@var{id} [,mux=3Don|off] [,@var{options}]=
@*
+# Backend is one of:
+# @option{null},
+# @option{socket},
+# @option{udp},
+# @option{msmouse},
+# @option{vc},
+# @option{ringbuf},
+# @option{file},
+# @option{pipe},
+# @option{console},
+# @option{serial},
+# @option{pty},
+# @option{stdio},
+# @option{braille},
+# @option{tty},
+# @option{parallel},
+# @option{parport},
+# @option{spicevmc}.
+# @option{spiceport}.
+# The specific backend will determine the applicable options.
+#
+# Use @code{-chardev help} to print all available chardev backend types.
+#
+# All devices must have an id, which can be any string up to 127 charact=
ers long.
+# It is used to uniquely identify this device in other command line dire=
ctives.
+#
+# A character device may be used in multiplexing mode by multiple front-=
ends.
+# Specify @option{mux=3Don} to enable this mode.
+# A multiplexer is a "1:N" device, and here the "1" end is your specifie=
d chardev
+# backend, and the "N" end is the various parts of QEMU that can talk to=
 a chardev.
+# If you create a chardev with @option{id=3Dmyid} and @option{mux=3Don},=
 QEMU will
+# create a multiplexer with your specified ID, and you can then configur=
e multiple
+# front ends to use that chardev ID for their input/output. Up to four d=
ifferent
+# front ends can be connected to a single multiplexed chardev. (Without
+# multiplexing enabled, a chardev can only be used by a single front end=
.)
+# For instance you could use this to allow a single stdio chardev to be =
used by
+# two serial ports and the QEMU monitor:
+#
+# @example
+# -chardev stdio,mux=3Don,id=3Dchar0 \
+# -mon chardev=3Dchar0,mode=3Dreadline \
+# -serial chardev:char0 \
+# -serial chardev:char0
+# @end example
+#
+# You can have more than one multiplexer in a system configuration; for =
instance
+# you could have a TCP port multiplexed between UART 0 and UART 1, and s=
tdio
+# multiplexed between the QEMU monitor and a parallel port:
+#
+# @example
+# -chardev stdio,mux=3Don,id=3Dchar0 \
+# -mon chardev=3Dchar0,mode=3Dreadline \
+# -parallel chardev:char0 \
+# -chardev tcp,...,mux=3Don,id=3Dchar1 \
+# -serial chardev:char1 \
+# -serial chardev:char1
+# @end example
+#
+# When you're using a multiplexed character device, some escape sequence=
s are
+# interpreted in the input. FIXME @@xref@{mux_keys, Keys in the characte=
r backend
+# multiplexer@}.
+#
+# Note that some other command line options may implicitly create multip=
lexed
+# character backends; for instance @option{-serial mon:stdio} creates a
+# multiplexed stdio backend connected to the serial port and the QEMU mo=
nitor,
+# and @option{-nographic} also multiplexes the console and the monitor t=
o
+# stdio.
+#
+# There is currently no support for multiplexing in the other direction
+# (where a single QEMU front end takes input and output from multiple ch=
ardevs).
+#
+# Every backend supports the @option{logfile} option, which supplies the=
 path
+# to a file to record all data transmitted via the backend. The @option{=
logappend}
+# option controls whether the log file will be truncated or appended to =
when
+# opened.
+#
+# The available backends are:
+#
+# @table @option
+# @item -chardev null ,id=3D@var{id}
+# A void device. This device will not emit any data, and will drop any d=
ata it
+# receives. The null backend does not take any options.
+#
+# @item -chardev socket ,id=3D@var{id} [@var{TCP options} or @var{unix o=
ptions}] [,server] [,nowait] [,telnet] [,reconnect=3D@var{seconds}] [,tls=
-creds=3D@var{id}]
+#
+# Create a two-way stream socket, which can be either a TCP or a unix so=
cket. A
+# unix socket will be created if @option{path} is specified. Behaviour i=
s
+# undefined if TCP options are specified for a unix socket.
+#
+# @option{server} specifies that the socket shall be a listening socket.
+#
+# @option{nowait} specifies that QEMU should not block waiting for a cli=
ent to
+# connect to a listening socket.
+#
+# @option{telnet} specifies that traffic on the socket should interpret =
telnet
+# escape sequences.
+#
+# @option{reconnect} sets the timeout for reconnecting on non-server soc=
kets when
+# the remote end goes away.  qemu will delay this many seconds and then =
attempt
+# to reconnect.  Zero disables reconnecting, and is the default.
+#
+# @option{tls-creds} requests enablement of the TLS protocol for encrypt=
ion,
+# and specifies the id of the TLS credentials to use for the handshake. =
The
+# credentials must be previously created with the @option{-object tls-cr=
eds}
+# argument.
+#
+# TCP and unix socket options are given below:
+#
+# @table @option
+#
+# @item TCP options: port=3D@var{port} [,host=3D@var{host}] [,to=3D@var{=
to}] [,ipv4] [,ipv6] [,nodelay]
+#
+# @option{host} for a listening socket specifies the local address to be=
 bound.
+# For a connecting socket species the remote host to connect to. @option=
{host} is
+# optional for listening sockets. If not specified it defaults to @code{=
0.0.0.0}.
+#
+# @option{port} for a listening socket specifies the local port to be bo=
und. For a
+# connecting socket specifies the port on the remote host to connect to.
+# @option{port} can be given as either a port number or a service name.
+# @option{port} is required.
+#
+# @option{to} is only relevant to listening sockets. If it is specified,=
 and
+# @option{port} cannot be bound, QEMU will attempt to bind to subsequent=
 ports up
+# to and including @option{to} until it succeeds. @option{to} must be sp=
ecified
+# as a port number.
+#
+# @option{ipv4} and @option{ipv6} specify that either IPv4 or IPv6 must =
be used.
+# If neither is specified the socket may use either protocol.
+#
+# @option{nodelay} disables the Nagle algorithm.
+#
+# @item unix options: path=3D@var{path}
+#
+# @option{path} specifies the local path of the unix socket. @option{pat=
h} is
+# required.
+#
+# @end table
+#
+# @item -chardev udp ,id=3D@var{id} [,host=3D@var{host}] ,port=3D@var{po=
rt} [,localaddr=3D@var{localaddr}] [,localport=3D@var{localport}] [,ipv4]=
 [,ipv6]
+#
+# Sends all traffic from the guest to a remote host over UDP.
+#
+# @option{host} specifies the remote host to connect to. If not specifie=
d it
+# defaults to @code{localhost}.
+#
+# @option{port} specifies the port on the remote host to connect to. @op=
tion{port}
+# is required.
+#
+# @option{localaddr} specifies the local address to bind to. If not spec=
ified it
+# defaults to @code{0.0.0.0}.
+#
+# @option{localport} specifies the local port to bind to. If not specifi=
ed any
+# available local port will be used.
+#
+# @option{ipv4} and @option{ipv6} specify that either IPv4 or IPv6 must =
be used.
+# If neither is specified the device may use either protocol.
+#
+# @item -chardev msmouse ,id=3D@var{id}
+#
+# Forward QEMU's emulated msmouse events to the guest. @option{msmouse} =
does not
+# take any options.
+#
+# @item -chardev vc ,id=3D@var{id} [[,width=3D@var{width}] [,height=3D@v=
ar{height}]] [[,cols=3D@var{cols}] [,rows=3D@var{rows}]]
+#
+# Connect to a QEMU text console. @option{vc} may optionally be given a =
specific
+# size.
+#
+# @option{width} and @option{height} specify the width and height respec=
tively of
+# the console, in pixels.
+#
+# @option{cols} and @option{rows} specify that the console be sized to f=
it a text
+# console with the given dimensions.
+#
+# @item -chardev ringbuf ,id=3D@var{id} [,size=3D@var{size}]
+#
+# Create a ring buffer with fixed size @option{size}.
+# @var{size} must be a power of two and defaults to @code{64K}.
+#
+# @item -chardev file ,id=3D@var{id} ,path=3D@var{path}
+#
+# Log all traffic received from the guest to a file.
+#
+# @option{path} specifies the path of the file to be opened. This file w=
ill be
+# created if it does not already exist, and overwritten if it does. @opt=
ion{path}
+# is required.
+#
+# @item -chardev pipe ,id=3D@var{id} ,path=3D@var{path}
+#
+# Create a two-way connection to the guest. The behaviour differs slight=
ly between
+# Windows hosts and other hosts:
+#
+# On Windows, a single duplex pipe will be created at
+# @file{\\.pipe\@option{path}}.
+#
+# On other hosts, 2 pipes will be created called @file{@option{path}.in}=
 and
+# @file{@option{path}.out}. Data written to @file{@option{path}.in} will=
 be
+# received by the guest. Data written by the guest can be read from
+# @file{@option{path}.out}. QEMU will not create these fifos, and requir=
es them to
+# be present.
+#
+# @option{path} forms part of the pipe path as described above. @option{=
path} is
+# required.
+#
+# @item -chardev console ,id=3D@var{id}
+#
+# Send traffic from the guest to QEMU's standard output. @option{console=
} does not
+# take any options.
+#
+# @option{console} is only available on Windows hosts.
+#
+# @item -chardev serial ,id=3D@var{id} ,path=3D@option{path}
+#
+# Send traffic from the guest to a serial device on the host.
+#
+# On Unix hosts serial will actually accept any tty device,
+# not only serial lines.
+#
+# @option{path} specifies the name of the serial device to open.
+#
+# @item -chardev pty ,id=3D@var{id}
+#
+# Create a new pseudo-terminal on the host and connect to it. @option{pt=
y} does
+# not take any options.
+#
+# @option{pty} is not available on Windows hosts.
+#
+# @item -chardev stdio ,id=3D@var{id} [,signal=3Don|off]
+# Connect to standard input and standard output of the QEMU process.
+#
+# @option{signal} controls if signals are enabled on the terminal, that =
includes
+# exiting QEMU with the key sequence @key{Control-c}. This option is ena=
bled by
+# default, use @option{signal=3Doff} to disable it.
+#
+# @item -chardev braille ,id=3D@var{id}
+#
+# Connect to a local BrlAPI server. @option{braille} does not take any o=
ptions.
+#
+# @item -chardev tty ,id=3D@var{id} ,path=3D@var{path}
+#
+# @option{tty} is only available on Linux, Sun, FreeBSD, NetBSD, OpenBSD=
 and
+# DragonFlyBSD hosts.  It is an alias for @option{serial}.
+#
+# @option{path} specifies the path to the tty. @option{path} is required=
.
+#
+# @item -chardev parallel ,id=3D@var{id} ,path=3D@var{path}
+# @itemx -chardev parport ,id=3D@var{id} ,path=3D@var{path}
+#
+# @option{parallel} is only available on Linux, FreeBSD and DragonFlyBSD=
 hosts.
+#
+# Connect to a local parallel port.
+#
+# @option{path} specifies the path to the parallel port device. @option{=
path} is
+# required.
+#
+# @item -chardev spicevmc ,id=3D@var{id} ,debug=3D@var{debug}, name=3D@v=
ar{name}
+#
+# @option{spicevmc} is only available when spice support is built in.
+#
+# @option{debug} debug level for spicevmc
+#
+# @option{name} name of spice channel to connect to
+#
+# Connect to a spice virtual machine channel, such as vdiport.
+#
+# @item -chardev spiceport ,id=3D@var{id} ,debug=3D@var{debug}, name=3D@=
var{name}
+#
+# @option{spiceport} is only available when spice support is built in.
+#
+# @option{debug} debug level for spicevmc
+#
+# @option{name} name of spice port to connect to
+#
+# Connect to a spice port, allowing a Spice client to handle the traffic
+# identified by a name (preferably a fqdn).
+#
+# @end table
+# !end texinfo
+##
+{ 'option': '--chardev',
+  'data': 'str',                # FIXME QAPIfy qemu_chardev_opts: Charde=
vBackend
+  'help': [
+"-chardev help",
+"-chardev null,id=3Did[,mux=3Don|off][,logfile=3DPATH][,logappend=3Don|o=
ff]",
+"-chardev socket,id=3Did[,host=3Dhost],port=3Dport[,to=3Dto][,ipv4][,ipv=
6][,nodelay][,reconnect=3Dseconds]",
+"         [,server][,nowait][,telnet][,reconnect=3Dseconds][,mux=3Don|of=
f]",
+"         [,logfile=3DPATH][,logappend=3Don|off][,tls-creds=3DID] (tcp)"=
,
+"-chardev socket,id=3Did,path=3Dpath[,server][,nowait][,telnet][,reconne=
ct=3Dseconds]",
+"         [,mux=3Don|off][,logfile=3DPATH][,logappend=3Don|off] (unix)",
+"-chardev udp,id=3Did[,host=3Dhost],port=3Dport[,localaddr=3Dlocaladdr]"=
,
+"         [,localport=3Dlocalport][,ipv4][,ipv6][,mux=3Don|off]",
+"         [,logfile=3DPATH][,logappend=3Don|off]",
+"-chardev msmouse,id=3Did[,mux=3Don|off][,logfile=3DPATH][,logappend=3Do=
n|off]",
+"-chardev vc,id=3Did[[,width=3Dwidth][,height=3Dheight]][[,cols=3Dcols][=
,rows=3Drows]]",
+"         [,mux=3Don|off][,logfile=3DPATH][,logappend=3Don|off]",
+"-chardev ringbuf,id=3Did[,size=3Dsize][,logfile=3DPATH][,logappend=3Don=
|off]",
+"-chardev file,id=3Did,path=3Dpath[,mux=3Don|off][,logfile=3DPATH][,loga=
ppend=3Don|off]",
+"-chardev pipe,id=3Did,path=3Dpath[,mux=3Don|off][,logfile=3DPATH][,loga=
ppend=3Don|off]",
+#ifdef _WIN32
+#    "-chardev console,id=3Did[,mux=3Don|off][,logfile=3DPATH][,logappen=
d=3Don|off]",
+#    "-chardev serial,id=3Did,path=3Dpath[,mux=3Don|off][,logfile=3DPATH=
][,logappend=3Don|off]",
+#else
+"-chardev pty,id=3Did[,mux=3Don|off][,logfile=3DPATH][,logappend=3Don|of=
f]",
+"-chardev stdio,id=3Did[,mux=3Don|off][,signal=3Don|off][,logfile=3DPATH=
][,logappend=3Don|off]",
+#endif
+#ifdef CONFIG_BRLAPI
+"-chardev braille,id=3Did[,mux=3Don|off][,logfile=3DPATH][,logappend=3Do=
n|off]",
+#endif
+#if defined(__linux__) || defined(__sun__) || defined(__FreeBSD__) \
+#    || defined(__NetBSD__) || defined(__OpenBSD__) || defined(__DragonF=
ly__)
+"-chardev serial,id=3Did,path=3Dpath[,mux=3Don|off][,logfile=3DPATH][,lo=
gappend=3Don|off]",
+"-chardev tty,id=3Did,path=3Dpath[,mux=3Don|off][,logfile=3DPATH][,logap=
pend=3Don|off]",
+#endif
+#if defined(__linux__) || defined(__FreeBSD__) || defined(__DragonFly__)
+"-chardev parallel,id=3Did,path=3Dpath[,mux=3Don|off][,logfile=3DPATH][,=
logappend=3Don|off]",
+"-chardev parport,id=3Did,path=3Dpath[,mux=3Don|off][,logfile=3DPATH][,l=
ogappend=3Don|off]",
+#endif
+#if defined(CONFIG_SPICE)
+"-chardev spicevmc,id=3Did,name=3Dname[,debug=3Ddebug][,logfile=3DPATH][=
,logappend=3Don|off]",
+"-chardev spiceport,id=3Did,name=3Dname[,debug=3Ddebug][,logfile=3DPATH]=
[,logappend=3Don|off]"
+#endif
+] }
+
+##
+# =3D=3D Bluetooth(R) options
+##
+
+##
+# @--bt:
+# !texinfo
+# -bt hci[...]@*
+# Defines the function of the corresponding Bluetooth HCI.  -bt options
+# are matched with the HCIs present in the chosen machine type.  For
+# example when emulating a machine with only one HCI built into it, only
+# the first @code{-bt hci[...]} option is valid and defines the HCI's
+# logic.  The Transport Layer is decided by the machine type.  Currently
+# the machines @code{n800} and @code{n810} have one HCI and all other
+# machines have none.
+#
+# @anchor{bt-hcis}
+# The following three types are recognized:
+#
+# @table @option
+# @item -bt hci,null@*
+# (default) The corresponding Bluetooth HCI assumes no internal logic
+# and will not respond to any HCI commands or emit events.
+#
+# @item -bt hci,host[:@var{id}]@*
+# (@code{bluez} only) The corresponding HCI passes commands / events
+# to / from the physical HCI identified by the name @var{id} (default:
+# @code{hci0}) on the computer running QEMU.  Only available on @code{bl=
uez}
+# capable systems like Linux.
+#
+# @item -bt hci[,vlan=3D@var{n}]@*
+# Add a virtual, standard HCI that will participate in the Bluetooth
+# scatternet @var{n} (default @code{0}).  Similarly to @option{-net}
+# VLANs, devices inside a bluetooth network @var{n} can only communicate
+# with other devices in the same network (scatternet).
+# @end table
+#
+# -bt vhci[,vlan=3D@var{n}]@*
+# (Linux-host only) Create a HCI in scatternet @var{n} (default 0) attac=
hed
+# to the host bluetooth stack instead of to the emulated target.  This
+# allows the host and target machines to participate in a common scatter=
net
+# and communicate.  Requires the Linux @code{vhci} driver installed.  Ca=
n
+# be used as following:
+#
+# @example
+# qemu-system-i386 [...OPTIONS...] -bt hci,vlan=3D5 -bt vhci,vlan=3D5
+# @end example
+#
+# -bt device:@var{dev}[,vlan=3D@var{n}]@*
+# Emulate a bluetooth device @var{dev} and place it in network @var{n}
+# (default @code{0}).  QEMU can only emulate one type of bluetooth devic=
es
+# currently:
+#
+# @table @option
+# @item keyboard
+# Virtual wireless keyboard implementing the HIDP bluetooth profile.
+# @end table
+# !end texinfo
+##
+{ 'option': '--bt',
+  'data': 'str',                # FIXME QAPIfy bt_parse()
+  'help': [
+"-bt hci,null    dumb bluetooth HCI - doesn't respond to commands",
+"-bt hci,host[:id]",
+"                use host's HCI with the given name",
+"-bt hci[,vlan=3Dn]",
+"                emulate a standard HCI in virtual scatternet 'n'",
+"-bt vhci[,vlan=3Dn]",
+"                add host computer to virtual scatternet 'n' using VHCI"=
,
+"-bt device:dev[,vlan=3Dn]",
+"                emulate a bluetooth device 'dev' in scatternet 'n'"] }
+
+##
+# =3D=3D TPM device options
+##
+
+##
+# @--tpmdev:
+# !texinfo
+# The general form of a TPM device option is:
+# -tpmdev @var{backend} ,id=3D@var{id} [,@var{options}]\@
+#
+# The specific backend type will determine the applicable options.
+# The @code{-tpmdev} option creates the TPM backend and requires a
+# @code{-device} option that specifies the TPM frontend interface model.
+#
+# Use @code{-tpmdev help} to print all available TPM backend types.
+#
+# The available backends are:
+#
+# @table @option
+#
+# @item -tpmdev passthrough, id=3D@var{id}, path=3D@var{path}, cancel-pa=
th=3D@var{cancel-path}
+#
+# (Linux-host only) Enable access to the host's TPM using the passthroug=
h
+# driver.
+#
+# @option{path} specifies the path to the host's TPM device, i.e., on
+# a Linux host this would be @code{/dev/tpm0}.
+# @option{path} is optional and by default @code{/dev/tpm0} is used.
+#
+# @option{cancel-path} specifies the path to the host TPM device's sysfs
+# entry allowing for cancellation of an ongoing TPM command.
+# @option{cancel-path} is optional and by default QEMU will search for t=
he
+# sysfs entry to use.
+#
+# Some notes about using the host's TPM with the passthrough driver:
+#
+# The TPM device accessed by the passthrough driver must not be
+# used by any other application on the host.
+#
+# Since the host's firmware (BIOS/UEFI) has already initialized the TPM,
+# the VM's firmware (BIOS/UEFI) will not be able to initialize the
+# TPM again and may therefore not show a TPM-specific menu that would
+# otherwise allow the user to configure the TPM, e.g., allow the user to
+# enable/disable or activate/deactivate the TPM.
+# Further, if TPM ownership is released from within a VM then the host's=
 TPM
+# will get disabled and deactivated. To enable and activate the
+# TPM again afterwards, the host has to be rebooted and the user is
+# required to enter the firmware's menu to enable and activate the TPM.
+# If the TPM is left disabled and/or deactivated most TPM commands will =
fail.
+#
+# To create a passthrough TPM use the following two options:
+# @example
+# -tpmdev passthrough,id=3Dtpm0 -device tpm-tis,tpmdev=3Dtpm0
+# @end example
+# Note that the @code{-tpmdev} id is @code{tpm0} and is referenced by
+# @code{tpmdev=3Dtpm0} in the device option.
+#
+# @end table
+# !end texinfo
+##
+{ 'option': '--tpmdev',
+  'data': 'str',                # FIXME QAPIfy qemu_tpmdev_opts, tpm_pas=
sthrough_handle_device_opts()
+  'help': [
+"-tpmdev passthrough,id=3Did[,path=3Dpath][,cancel-path=3Dpath]",
+"                use path to provide path to a character device; default=
 is /dev/tpm0",
+"                use cancel-path to provide path to TPM's cancel sysfs e=
ntry; if",
+"                not provided it will be searched for in /sys/class/misc=
/tpm?/device"] }
+
+##
+# =3D=3D Linux/Multiboot boot specific
+#
+# When using these options, you can use a given Linux or Multiboot
+# kernel without installing it in the disk image. It can be useful
+# for easier testing of various kernels.
+##
+
+##
+# @--kernel:
+# !texinfo
+# -kernel @var{bzImage}@*
+# Use @var{bzImage} as kernel image. The kernel can be either a Linux ke=
rnel
+# or in multiboot format.
+# !end texinfo
+##
+{ 'option': '--kernel',
+  'data': 'str',
+  'help': "-kernel bzImage use 'bzImage' as kernel image" }
+
+##
+# @--append:
+# !texinfo
+# -append @var{cmdline}@*
+# Use @var{cmdline} as kernel command line
+# !end texinfo
+##
+{ 'option': '--append',
+  'data': 'str',
+  'help': "-append cmdline use 'cmdline' as kernel command line" }
+
+##
+# @--initrd:
+# !texinfo
+# -initrd @var{file}@*
+# Use @var{file} as initial ram disk.
+#
+# -initrd "@var{file1} arg=3Dfoo,@var{file2}"@*
+#
+# This syntax is only available with multiboot.
+#
+# Use @var{file1} and @var{file2} as modules and pass arg=3Dfoo as param=
eter to the
+# first module.
+# !end texinfo
+##
+{ 'option': '--initrd',
+  'data': 'str',
+  'help': "-initrd file    use 'file' as initial ram disk" }
+
+##
+# @--dtb:
+# !texinfo
+# -dtb @var{file}@*
+# Use @var{file} as a device tree binary (dtb) image and pass it to the =
kernel
+# on boot.
+# !end texinfo
+##
+{ 'option': '--dtb',
+  'data': 'str',
+  'help': "-dtb    file    use 'file' as device tree image" }
+
+##
+# =3D=3D Debug/Expert options
+##
+
+##
+# @--fw_cfg:
+# !texinfo
+#
+# -fw_cfg [name=3D]@var{name},file=3D@var{file}@*
+# Add named fw_cfg entry with contents from file @var{file}.
+#
+# -fw_cfg [name=3D]@var{name},string=3D@var{str}@*
+# Add named fw_cfg entry with contents from string @var{str}.
+#
+# The terminating NUL character of the contents of @var{str} will not be
+# included as part of the fw_cfg item data. To insert contents with
+# embedded NUL characters, you have to use the @var{file} parameter.
+#
+# The fw_cfg entries are passed by QEMU through to the guest.
+#
+# Example:
+# @example
+#     -fw_cfg name=3Dopt/com.mycompany/blob,file=3D./my_blob.bin
+# @end example
+# creates an fw_cfg entry named opt/com.mycompany/blob with contents
+# from ./my_blob.bin.
+# !end texinfo
+##
+{ 'option': '--fw_cfg',
+  'data': 'str',                # FIXME QAPIfy qemu_fw_cfg_opts
+  'help': [
+"-fw_cfg [name=3D]<name>,file=3D<file>",
+"                add named fw_cfg entry with contents from file",
+"-fw_cfg [name=3D]<name>,string=3D<str>",
+"                add named fw_cfg entry with contents from string"] }
+
+##
+# @--serial:
+# !texinfo
+# -serial @var{dev}@*
+# Redirect the virtual serial port to host character device
+# @var{dev}. The default device is @code{vc} in graphical mode and
+# @code{stdio} in non graphical mode.
+#
+# This option can be used several times to simulate up to 4 serial
+# ports.
+#
+# Use @code{-serial none} to disable all serial ports.
+#
+# Available character devices are:
+# @table @option
+# @item vc[:@var{W}x@var{H}]
+# Virtual console. Optionally, a width and height can be given in pixel =
with
+# @example
+# vc:800x600
+# @end example
+# It is also possible to specify width or height in characters:
+# @example
+# vc:80Cx24C
+# @end example
+# @item pty
+# [Linux only] Pseudo TTY (a new PTY is automatically allocated)
+# @item none
+# No device is allocated.
+# @item null
+# void device
+# @item chardev:@var{id}
+# Use a named character device defined with the @code{-chardev} option.
+# @item /dev/XXX
+# [Linux only] Use host tty, e.g. @file{/dev/ttyS0}. The host serial por=
t
+# parameters are set according to the emulated ones.
+# @item /dev/parport@var{N}
+# [Linux only, parallel port only] Use host parallel port
+# @var{N}. Currently SPP and EPP parallel port features can be used.
+# @item file:@var{filename}
+# Write output to @var{filename}. No character can be read.
+# @item stdio
+# [Unix only] standard input/output
+# @item pipe:@var{filename}
+# name pipe @var{filename}
+# @item COM@var{n}
+# [Windows only] Use host serial port @var{n}
+# @item udp:[@var{remote_host}]:@var{remote_port}[@@[@var{src_ip}]:@var{=
src_port}]
+# This implements UDP Net Console.
+# When @var{remote_host} or @var{src_ip} are not specified
+# they default to @code{0.0.0.0}.
+# When not using a specified @var{src_port} a random port is automatical=
ly chosen.
+#
+# If you just want a simple readonly console you can use @code{netcat} o=
r
+# @code{nc}, by starting QEMU with: @code{-serial udp::4555} and nc as:
+# @code{nc -u -l -p 4555}. Any time QEMU writes something to that port i=
t
+# will appear in the netconsole session.
+#
+# If you plan to send characters back via netconsole or you want to stop
+# and start QEMU a lot of times, you should have QEMU use the same
+# source port each time by using something like @code{-serial
+# udp::4555@@:4556} to QEMU. Another approach is to use a patched
+# version of netcat which can listen to a TCP port and send and receive
+# characters via udp.  If you have a patched version of netcat which
+# activates telnet remote echo and single char transfer, then you can
+# use the following options to set up a netcat redirector to allow
+# telnet on port 5555 to access the QEMU port.
+# @table @code
+# @item QEMU Options:
+# -serial udp::4555@@:4556
+# @item netcat options:
+# -u -P 4555 -L 0.0.0.0:4556 -t -p 5555 -I -T
+# @item telnet options:
+# localhost 5555
+# @end table
+#
+# @item tcp:[@var{host}]:@var{port}[,@var{server}][,nowait][,nodelay][,r=
econnect=3D@var{seconds}]
+# The TCP Net Console has two modes of operation.  It can send the seria=
l
+# I/O to a location or wait for a connection from a location.  By defaul=
t
+# the TCP Net Console is sent to @var{host} at the @var{port}.  If you u=
se
+# the @var{server} option QEMU will wait for a client socket application
+# to connect to the port before continuing, unless the @code{nowait}
+# option was specified.  The @code{nodelay} option disables the Nagle bu=
ffering
+# algorithm.  The @code{reconnect} option only applies if @var{noserver}=
 is
+# set, if the connection goes down it will attempt to reconnect at the
+# given interval.  If @var{host} is omitted, 0.0.0.0 is assumed. Only
+# one TCP connection at a time is accepted. You can use @code{telnet} to
+# connect to the corresponding character device.
+# @table @code
+# @item Example to send tcp console to 192.168.0.2 port 4444
+# -serial tcp:192.168.0.2:4444
+# @item Example to listen and wait on port 4444 for connection
+# -serial tcp::4444,server
+# @item Example to not wait and listen on ip 192.168.0.100 port 4444
+# -serial tcp:192.168.0.100:4444,server,nowait
+# @end table
+#
+# @item telnet:@var{host}:@var{port}[,server][,nowait][,nodelay]
+# The telnet protocol is used instead of raw tcp sockets.  The options
+# work the same as if you had specified @code{-serial tcp}.  The
+# difference is that the port acts like a telnet server or client using
+# telnet option negotiation.  This will also allow you to send the
+# MAGIC_SYSRQ sequence if you use a telnet that supports sending the bre=
ak
+# sequence.  Typically in unix telnet you do it with Control-] and then
+# type "send break" followed by pressing the enter key.
+#
+# @item unix:@var{path}[,server][,nowait][,reconnect=3D@var{seconds}]
+# A unix domain socket is used instead of a tcp socket.  The option work=
s the
+# same as if you had specified @code{-serial tcp} except the unix domain=
 socket
+# @var{path} is used for connections.
+#
+# @item mon:@var{dev_string}
+# This is a special option to allow the monitor to be multiplexed onto
+# another serial port.  The monitor is accessed with key sequence of
+# @key{Control-a} and then pressing @key{c}.
+# @var{dev_string} should be any one of the serial devices specified
+# above.  An example to multiplex the monitor onto a telnet server
+# listening on port 4444 would be:
+# @table @code
+# @item -serial mon:telnet::4444,server,nowait@*
+# @end table
+# When the monitor is multiplexed to stdio in this way, Ctrl+C will not =
terminate
+# QEMU any more but will be passed to the guest instead.
+#
+# @item braille
+# Braille device.  This will use BrlAPI to display the braille output on=
 a real
+# or fake device.
+#
+# @item msmouse
+# Three button serial mouse. Configure the guest to use Microsoft protoc=
ol.
+# @end table
+# !end texinfo
+##
+{ 'option': '--serial',
+  'data': 'str',                # FIXME QAPIfy serial_parse()
+  'help': "-serial dev     redirect the serial port to char device 'dev'=
" }
+
+##
+# @--parallel:
+# !texinfo
+# -parallel @var{dev}@*
+# Redirect the virtual parallel port to host device @var{dev} (same
+# devices as the serial port). On Linux hosts, @file{/dev/parportN} can
+# be used to use hardware devices connected on the corresponding host
+# parallel port.
+#
+# This option can be used several times to simulate up to 3 parallel
+# ports.
+#
+# Use @code{-parallel none} to disable all parallel ports.
+# !end texinfo
+##
+{ 'option': '--parallel',
+  'data': 'str',                # FIXME QAPIfy parallel_parse()
+  'help': "-parallel dev   redirect the parallel port to char device 'de=
v'" }
+
+##
+# @--monitor:
+# !texinfo
+# -monitor @var{dev}@*
+# Redirect the monitor to host device @var{dev} (same devices as the
+# serial port).
+# The default device is @code{vc} in graphical mode and @code{stdio} in
+# non graphical mode.
+# Use @code{-monitor none} to disable the default monitor.
+# !end texinfo
+##
+{ 'option': '--monitor',
+  'data': 'str',                # FIXME QAPIfy monitor_parse()
+  'help': "-monitor dev    redirect the monitor to char device 'dev'" }
+
+##
+# @--qmp:
+# !texinfo
+# -qmp @var{dev}@*
+# Like -monitor but opens in 'control' mode.
+# !end texinfo
+##
+{ 'option': '--qmp',
+  'data': 'str',                # FIXME QAPIfy monitor_parse()
+  'help': "-qmp dev        like -monitor but opens in 'control' mode" }
+
+##
+# @--qmp-pretty:
+# !texinfo
+# -qmp-pretty @var{dev}@*
+# Like -qmp but uses pretty JSON formatting.
+# !end texinfo
+##
+{ 'option': '--qmp-pretty',
+  'data': 'str',                # FIXME
+  'help': "-qmp-pretty dev like -qmp but uses pretty JSON formatting" }
+
+##
+# @--mon:
+# !texinfo
+# -mon [chardev=3D]name[,mode=3Dreadline|control]@*
+# Setup monitor on chardev @var{name}.
+# !end texinfo
+##
+{ 'option': '--mon',
+  'data': 'str',                # FIXME QAPIfy qemu_mon_opts
+  'help': "-mon [chardev=3D]name[,mode=3Dreadline|control]" }
+
+##
+# @--debugcon:
+# !texinfo
+# -debugcon @var{dev}@*
+# Redirect the debug console to host device @var{dev} (same devices as t=
he
+# serial port).  The debug console is an I/O port which is typically por=
t
+# 0xe9; writing to that I/O port sends output to this device.
+# The default device is @code{vc} in graphical mode and @code{stdio} in
+# non graphical mode.
+# !end texinfo
+##
+{ 'option': '--debugcon',
+  'data': 'str',                # FIXME QAPIfy debugcon_parse()
+  'help': "-debugcon dev   redirect the debug console to char device 'de=
v'" }
+
+##
+# @--pidfile:
+# !texinfo
+# -pidfile @var{file}@*
+# Store the QEMU process PID in @var{file}. It is useful if you launch Q=
EMU
+# from a script.
+# !end texinfo
+##
+{ 'option': '--pidfile',
+  'data': 'str',
+  'help': "-pidfile file   write PID to 'file'" }
+
+##
+# @--singlestep:
+# !texinfo
+# -singlestep@*
+# Run the emulation in single step mode.
+# !end texinfo
+##
+{ 'option': '--singlestep',
+  'help': "-singlestep     always run in singlestep mode" }
+
+##
+# @--stopped:
+# !texinfo
+# -S@*
+# Do not start CPU at startup (you must type 'c' in the monitor).
+# !end texinfo
+##
+{ 'option': '--stopped', 'short': 'S',
+  'help': "-S              freeze CPU at startup (use 'c' to start execu=
tion)" }
+
+##
+# @--realtime:
+# !texinfo
+# -realtime mlock=3Don|off@*
+# Run qemu with realtime features.
+# mlocking qemu and guest memory can be enabled via @option{mlock=3Don}
+# (enabled by default).
+# !end texinfo
+##
+{ 'option': '--realtime',
+  'data': 'str',                # FIXME QAPIfy qemu_realtime_opts
+  'help': [
+"-realtime [mlock=3Don|off]",
+"                run qemu with realtime features",
+"                mlock=3Don|off controls mlock support (default: on)"] }
+
+##
+# @--gdb:
+# !texinfo
+# -gdb @var{dev}@*
+# Wait for gdb connection on device @var{dev} (FIXME @@pxref@{gdb_usage@=
}). Typical
+# connections will likely be TCP-based, but also UDP, pseudo TTY, or eve=
n
+# stdio are reasonable use case. The latter is allowing to start QEMU fr=
om
+# within gdb and establish the connection via a pipe:
+# @example
+# (gdb) target remote | exec qemu-system-i386 -gdb stdio ...
+# @end example
+# !end texinfo
+##
+{ 'option': '--gdb',
+  'data': 'str',                # FIXME QAPIfy gdbserver_start()
+  'help': "-gdb dev        wait for gdb connection on 'dev'" }
+
+##
+# @--gdb-default:
+# !texinfo
+# -s@*
+# Shorthand for -gdb tcp::1234, i.e. open a gdbserver on TCP port 1234
+# (FIXME @@pxref@{gdb_usage@}).
+# !end texinfo
+##
+{ 'option': '--gdb-default', 'short': 's',
+  'help': "-s              shorthand for -gdb tcp::FIXME" }
+
+##
+# @--debug-enable:
+# !texinfo
+# -d @var{item1}[,...]@*
+# Enable logging of specified items. Use '-d help' for a list of log ite=
ms.
+# !end texinfo
+##
+{ 'option': '--debug-enable', 'short': 'd',
+  'data': 'str',                # FIXME QAPIfy qemu_str_to_log_mask()
+  'help': "-d item1,...    enable logging of specified items (use '-d he=
lp' for a list of log items)" }
+
+##
+# @--debug-log:
+# !texinfo
+# -D @var{logfile}@*
+# Output log in @var{logfile} instead of to stderr
+# !end texinfo
+##
+# TODO either document the %d feature, or kill it
+{ 'option': '--debug-log', 'short': 'D',
+  'data': 'str',
+  'help': "-D logfile      output log to logfile (default stderr)" }
+
+##
+# @--dfilter:
+# !texinfo
+# -dfilter @var{range1}[,...]@*
+# Filter debug output to that relevant to a range of target addresses. T=
he filter
+# spec can be either @var{start}+@var{size}, @var{start}-@var{size} or
+# @var{start}..@var{end} where @var{start} @var{end} and @var{size} are =
the
+# addresses and sizes required. For example:
+# @example
+#     -dfilter 0x8000..0x8fff,0xffffffc000080000+0x200,0xffffffc00006000=
0-0x1000
+# @end example
+# Will dump output for any code in the 0x1000 sized block starting at 0x=
8000 and
+# the 0x200 sized block starting at 0xffffffc000080000 and another 0x100=
0 sized
+# block starting at 0xffffffc00005f000.
+# !end texinfo
+##
+{ 'option': '--dfilter',
+  'data': 'str',                # FIXME QAPIfy qemu_set_dfilter_ranges()
+  'help': "-dfilter range,..  filter debug output to range of addresses =
(useful for -d cpu,exec,etc..)" }
+
+##
+# @--load-path:
+# !texinfo
+# -L  @var{path}@*
+# Set the directory for the BIOS, VGA BIOS and keymaps.
+#
+# To list all the data directories, use @code{-L help}.
+# !end texinfo
+##
+{ 'option': '--load-path', 'short': 'L',
+  'data': 'str',
+  'help': "-L path         set the directory for the BIOS, VGA BIOS and =
keymaps" }
+
+##
+# @--bios:
+# !texinfo
+# -bios @var{file}@*
+# Set the filename for the BIOS.
+# !end texinfo
+##
+{ 'option': '--bios',
+  'data': 'str',
+  'help': "-bios file      set the filename for the BIOS" }
+
+##
+# @--enable-kvm:
+# !texinfo
+# -enable-kvm@*
+# Enable KVM full virtualization support. This option is only available
+# if KVM support is enabled when compiling.
+# !end texinfo
+##
+{ 'option': '--enable-kvm',
+  'help': "-enable-kvm     enable KVM full virtualization support" }
+
+##
+# @--enable-hax:
+# !texinfo
+# -enable-hax@*
+# Enable HAX (Hardware-based Acceleration eXecution) support. This optio=
n
+# is only available if HAX support is enabled when compiling. HAX is onl=
y
+# applicable to MAC and Windows platform, and thus does not conflict wit=
h
+# KVM.
+# !end texinfo
+##
+{ 'option': '--enable-hax',
+  'help': "-enable-hax     enable HAX virtualization support" }
+
+##
+# @--xen-domid:
+# !texinfo
+# -xen-domid @var{id}@*
+# Specify xen guest domain @var{id} (XEN only).
+# !end texinfo
+##
+{ 'option': '--xen-domid',
+  'data': 'str',                # FIXME int32
+  'help': "-xen-domid id   specify xen guest domain id" }
+
+##
+# @--xen-create:
+# !texinfo
+# -xen-create@*
+# Create domain using xen hypercalls, bypassing xend.
+# Warning: should not be used when xend is in use (XEN only).
+# !end texinfo
+##
+{ 'option': '--xen-create',
+  'help': [
+"-xen-create     create domain using xen hypercalls, bypassing xend",
+"                warning: should not be used when xend is in use"] }
+
+##
+# @--xen-attach:
+# !texinfo
+# -xen-attach@*
+# Attach to existing xen domain.
+# xend will use this when starting QEMU (XEN only).
+# !end texinfo
+##
+{ 'option': '--xen-attach',
+  'help': [
+"-xen-attach     attach to existing xen domain",
+"                xend will use this when starting QEMU"] }
+
+##
+# @--xen-domid-restrict:
+# !texinfo
+# Restrict set of available xen operations to specified domain id (XEN o=
nly).
+# !end texinfo
+##
+{ 'option': '--xen-domid-restrict',
+  'help': [
+"-xen-domid-restrict     restrict set of available xen operations",
+"                        to specified domain id. (Does not affect",
+"                        xenpv machine type)."] }
+
+##
+# @--no-reboot:
+# !texinfo
+# -no-reboot@*
+# Exit instead of rebooting.
+# !end texinfo
+##
+{ 'option': '--no-reboot',
+  'help': "-no-reboot      exit instead of rebooting" }
+
+##
+# @--no-shutdown:
+# !texinfo
+# -no-shutdown@*
+# Don't exit QEMU on guest shutdown, but instead only stop the emulation=
.
+# This allows for instance switching to monitor to commit changes to the
+# disk image.
+# !end texinfo
+##
+{ 'option': '--no-shutdown',
+  'help': "-no-shutdown    stop before shutdown" }
+
+##
+# @--loadvm:
+# !texinfo
+# -loadvm @var{file}@*
+# Start right away with a saved state (@code{loadvm} in monitor)
+# !end texinfo
+##
+# FIXME @var{file} is bogus
+{ 'option': '--loadvm',
+  'data': 'str',
+  'help': [
+"-loadvm [tag|id]",
+"                start right away with a saved state (loadvm in monitor)=
"] }
+
+##
+# @--daemonize:
+# !texinfo
+# -daemonize@*
+# Daemonize the QEMU process after initialization.  QEMU will not detach=
 from
+# standard IO until it is ready to receive connections on any of its dev=
ices.
+# This option is a useful way for external programs to launch QEMU witho=
ut having
+# to cope with initialization race conditions.
+# !end texinfo
+##
+{ 'option': '--daemonize',
+  'help': "-daemonize      daemonize QEMU after initializing" }
+
+##
+# @--option-rom:
+# !texinfo
+# -option-rom @var{file}@*
+# Load the contents of @var{file} as an option ROM.
+# This option is useful to load things like EtherBoot.
+# !end texinfo
+##
+{ 'option': '--option-rom',
+  'data': 'str',                # FIXME QAPIfy qemu_option_rom_opts
+  'help': "-option-rom rom load a file, rom, into the option ROM space" =
}
+
+##
+# @--clock:
+##
+# TODO deprecate
+{ 'option': '--clock',
+  'data': 'str',                # FIXME
+  'help': null }
+
+##
+# @--localtime:
+##
+# TODO deprecate
+{ 'option': '--localtime',
+  'help': null }
+
+##
+# @--startdate:
+##
+# TODO deprecate
+{ 'option': '--startdate',
+  'data': 'str',                # FIXME QAPIfy configure_rtc_date_offset=
()
+  'help': null }
+
+##
+# @--rtc:
+# !texinfo
+#
+# -rtc [base=3Dutc|localtime|@var{date}][,clock=3Dhost|vm][,driftfix=3Dn=
one|slew]@*
+# Specify @option{base} as @code{utc} or @code{localtime} to let the RTC=
 start at the current
+# UTC or local time, respectively. @code{localtime} is required for corr=
ect date in
+# MS-DOS or Windows. To start at a specific point in time, provide @var{=
date} in the
+# format @code{2006-06-17T16:01:21} or @code{2006-06-17}. The default ba=
se is UTC.
+#
+# By default the RTC is driven by the host system time. This allows usin=
g of the
+# RTC as accurate reference clock inside the guest, specifically if the =
host
+# time is smoothly following an accurate external reference clock, e.g. =
via NTP.
+# If you want to isolate the guest time from the host, you can set @opti=
on{clock}
+# to @code{rt} instead.  To even prevent it from progressing during susp=
ension,
+# you can set it to @code{vm}.
+#
+# Enable @option{driftfix} (i386 targets only) if you experience time dr=
ift problems,
+# specifically with Windows' ACPI HAL. This option will try to figure ou=
t how
+# many timer interrupts were not processed by the Windows guest and will
+# re-inject them.
+# !end texinfo
+##
+{ 'option': '--rtc',
+  'data': 'str',                # FIXME QAPIfy qemu_rtc_opts
+  'help': [
+"-rtc [base=3Dutc|localtime|date][,clock=3Dhost|rt|vm][,driftfix=3Dnone|=
slew]",
+"                set the RTC base and clock, enable drift fix for clock =
ticks (x86 only)"] }
+
+##
+# @--icount:
+# !texinfo
+# -icount [shift=3D@var{N}|auto][,rr=3Drecord|replay,rrfile=3D@var{filen=
ame},rrsnapshot=3D@var{snapshot}]@*
+# Enable virtual instruction counter.  The virtual cpu will execute one
+# instruction every 2^@var{N} ns of virtual time.  If @code{auto} is spe=
cified
+# then the virtual cpu speed will be automatically adjusted to keep virt=
ual
+# time within a few seconds of real time.
+#
+# When the virtual cpu is sleeping, the virtual time will advance at def=
ault
+# speed unless @option{sleep=3Don|off} is specified.
+# With @option{sleep=3Don|off}, the virtual time will jump to the next t=
imer deadline
+# instantly whenever the virtual cpu goes to sleep mode and will not adv=
ance
+# if no timer is enabled. This behavior give deterministic execution tim=
es from
+# the guest point of view.
+#
+# Note that while this option can give deterministic behavior, it does n=
ot
+# provide cycle accurate emulation.  Modern CPUs contain superscalar out=
 of
+# order cores with complex cache hierarchies.  The number of instruction=
s
+# executed often has little or no correlation with actual performance.
+#
+# @option{align=3Don} will activate the delay algorithm which will try
+# to synchronise the host clock and the virtual clock. The goal is to
+# have a guest running at the real frequency imposed by the shift option=
.
+# Whenever the guest clock is behind the host clock and if
+# @option{align=3Don} is specified then we print a message to the user
+# to inform about the delay.
+# Currently this option does not work when @option{shift} is @code{auto}=
.
+# Note: The sync algorithm will work for those shift values for which
+# the guest clock runs ahead of the host clock. Typically this happens
+# when the shift value is high (how high depends on the host machine).
+#
+# When @option{rr} option is specified deterministic record/replay is en=
abled.
+# Replay log is written into @var{filename} file in record mode and
+# read from this file in replay mode.
+#
+# Option rrsnapshot is used to create new vm snapshot named @var{snapsho=
t}
+# at the start of execution recording. In replay mode this option is use=
d
+# to load the initial VM state.
+# !end texinfo
+##
+{ 'option': '--icount',
+  'data': 'str',                # FIXME QAPIfy qemu_icount_opts
+  'help': [
+"-icount [shift=3DN|auto][,align=3Don|off][,sleep=3Don|off,rr=3Drecord|r=
eplay,rrfile=3D<filename>,rrsnapshot=3D<snapshot>]",
+"                enable virtual instruction counter with 2^N clock ticks=
 per",
+"                instruction, enable aligning the host and virtual clock=
s",
+"                or disable real time cpu sleeping"] }
+
+##
+# @--watchdog:
+# !texinfo
+# -watchdog @var{model}@*
+# Create a virtual hardware watchdog device.  Once enabled (by a guest
+# action), the watchdog must be periodically polled by an agent inside
+# the guest or else the guest will be restarted. Choose a model for
+# which your guest has drivers.
+#
+# The @var{model} is the model of hardware watchdog to emulate. Use
+# @code{-watchdog help} to list available hardware models. Only one
+# watchdog can be enabled for a guest.
+#
+# The following models may be available:
+# @table @option
+# @item ib700
+# iBASE 700 is a very simple ISA watchdog with a single timer.
+# @item i6300esb
+# Intel 6300ESB I/O controller hub is a much more featureful PCI-based
+# dual-timer watchdog.
+# @item diag288
+# A virtual watchdog for s390x backed by the diagnose 288 hypercall
+# (currently KVM only).
+# @end table
+# !end texinfo
+##
+{ 'option': '--watchdog',
+  'data': 'str',                # FIXME QAPIfy select_watchdog()
+  'help': [
+"-watchdog model",
+"                enable virtual hardware watchdog [default=3Dnone]"] }
+
+##
+# @--watchdog-action:
+# !texinfo
+# -watchdog-action @var{action}@*
+#
+# The @var{action} controls what QEMU will do when the watchdog timer
+# expires.
+# The default is
+# @code{reset} (forcefully reset the guest).
+# Other possible actions are:
+# @code{shutdown} (attempt to gracefully shutdown the guest),
+# @code{poweroff} (forcefully poweroff the guest),
+# @code{inject-nmi} (inject a NMI into the guest),
+# @code{pause} (pause the guest),
+# @code{debug} (print a debug message and continue), or
+# @code{none} (do nothing).
+#
+# Note that the @code{shutdown} action requires that the guest responds
+# to ACPI signals, which it may not be able to do in the sort of
+# situations where the watchdog would have expired, and thus
+# @code{-watchdog-action shutdown} is not recommended for production use=
.
+#
+# Examples:
+#
+# @table @code
+# @item -watchdog i6300esb -watchdog-action pause@*
+# @itemx -watchdog ib700@*
+# @end table
+# !end texinfo
+##
+{ 'option': '--watchdog-action',
+  'data': 'str',                # FIXME enum
+  'help': [
+"-watchdog-action reset|shutdown|poweroff|inject-nmi|pause|debug|none",
+"                action when watchdog fires [default=3Dreset]"] }
+
+##
+# @--echr:
+# !texinfo
+#
+# -echr @var{numeric_ascii_value}@*
+# Change the escape character used for switching to the monitor when usi=
ng
+# monitor and serial sharing.  The default is @code{0x01} when using the
+# @code{-nographic} option.  @code{0x01} is equal to pressing
+# @code{Control-a}.  You can select a different character from the ascii
+# control keys where 1 through 26 map to Control-a through Control-z.  F=
or
+# instance you could use the either of the following to change the escap=
e
+# character to Control-t.
+# @table @code
+# @item -echr 0x14@*
+# @itemx -echr 20@*
+# @end table
+# !end texinfo
+##
+{ 'option': '--echr',
+  'data': 'str',                # FIXME int
+  'help': "-echr chr       set terminal escape character instead of ctrl=
-a" }
+
+##
+# @--virtioconsole:
+# !texinfo
+# -virtioconsole @var{c}@*
+# Set virtio console.
+#
+# This option is maintained for backward compatibility.
+#
+# Please use @code{-device virtconsole} for the new way of invocation.
+# !end texinfo
+##
+{ 'option': '--virtioconsole',
+  'data': 'str',                # FIXME QAPIfy virtcon_parse()
+  'help': [
+"-virtioconsole c",
+"                set virtio console"] }
+
+##
+# @--show-cursor:
+# !texinfo
+# -show-cursor@*
+# Show cursor.
+# !end texinfo
+##
+{ 'option': '--show-cursor',
+  'help': "-show-cursor    show cursor" }
+
+##
+# @--tb-size:
+# !texinfo
+# -tb-size @var{n}@*
+# Set TB size.
+# !end texinfo
+##
+{ 'option': '--tb-size',
+  'data': 'str',                # FIXME size
+  'help': "-tb-size n      set TB size" }
+
+##
+# @--incoming:
+# !texinfo
+# -incoming tcp:[@var{host}]:@var{port}[,to=3D@var{maxport}][,ipv4][,ipv=
6]@*
+# -incoming rdma:@var{host}:@var{port}[,ipv4][,ipv6]@*
+# Prepare for incoming migration, listen on a given tcp port.
+#
+# -incoming unix:@var{socketpath}@*
+# Prepare for incoming migration, listen on a given unix socket.
+#
+# -incoming fd:@var{fd}@*
+# Accept incoming migration from a given filedescriptor.
+#
+# -incoming exec:@var{cmdline}@*
+# Accept incoming migration as an output from specified external command=
.
+#
+# -incoming defer@*
+# Wait for the URI to be specified via migrate_incoming.  The monitor ca=
n
+# be used to change settings (such as migration parameters) prior to iss=
uing
+# the migrate_incoming to allow the migration to begin.
+# !end texinfo
+##
+{ 'option': '--incoming',
+  'data': 'str',                # FIXME QAPIfy qemu_start_incoming_migra=
tion()
+  'help': [
+"-incoming tcp:[host]:port[,to=3Dmaxport][,ipv4][,ipv6]",
+"-incoming rdma:host:port[,ipv4][,ipv6]",
+"-incoming unix:socketpath",
+"                prepare for incoming migration, listen on",
+"                specified protocol and socket address",
+"-incoming fd:fd",
+"-incoming exec:cmdline",
+"                accept incoming migration on given file descriptor",
+"                or from given external command",
+"-incoming defer",
+"                wait for the URI to be specified via migrate_incoming"]=
 }
+
+##
+# @--only-migratable:
+# !texinfo
+# -only-migratable@*
+# Only allow migratable devices. Devices will not be allowed to enter an
+# unmigratable state.
+# !end texinfo
+##
+{ 'option': '--only-migratable',
+  'help': "-only-migratable     allow only migratable devices" }
+
+##
+# @--nodefaults:
+# !texinfo
+# -nodefaults@*
+# Don't create default devices. Normally, QEMU sets the default devices =
like serial
+# port, parallel port, virtual console, monitor device, VGA adapter, flo=
ppy and
+# CD-ROM drive and others. The @code{-nodefaults} option will disable al=
l those
+# default devices.
+# !end texinfo
+##
+{ 'option': '--nodefaults',
+  'help': "-nodefaults     don't create default devices" }
+
+##
+# @--chroot:
+# !texinfo
+# -chroot @var{dir}@*
+# Immediately before starting guest execution, chroot to the specified
+# directory.  Especially useful in combination with -runas.
+# !end texinfo
+##
+{ 'option': '--chroot',
+  'data': 'str',
+  'help': "-chroot dir     chroot to dir just before starting the VM" }
+
+##
+# @--runas:
+# !texinfo
+# -runas @var{user}@*
+# Immediately before starting guest execution, drop root privileges, swi=
tching
+# to the specified user.
+# !end texinfo
+##
+{ 'option': '--runas',
+  'data': 'str',
+  'help': "-runas user     change to user id user just before starting t=
he VM" }
+
+##
+# @--prom-env:
+# !texinfo
+# -prom-env @var{variable}=3D@var{value}@*
+# Set OpenBIOS nvram @var{variable} to given @var{value} (PPC, SPARC onl=
y).
+# !end texinfo
+##
+{ 'option': '--prom-env',
+  'data': 'str',                # fine (we leave parsing it to OpenBIOS)
+  'help': [
+"-prom-env variable=3Dvalue",
+"                set OpenBIOS nvram variables"] }
+
+##
+# @--semihosting:
+# !texinfo
+# -semihosting@*
+# Enable semihosting mode (ARM, M68K, Xtensa, MIPS only).
+# !end texinfo
+##
+{ 'option': '--semihosting',
+  'help': "-semihosting    semihosting mode" }
+
+##
+# @--semihosting-config:
+# !texinfo
+# -semihosting-config [enable=3Don|off][,target=3Dnative|gdb|auto][,arg=3D=
str[,...]]@*
+# Enable and configure semihosting (ARM, M68K, Xtensa, MIPS only).
+# @table @option
+# @item target=3D@code{native|gdb|auto}
+# Defines where the semihosting calls will be addressed, to QEMU (@code{=
native})
+# or to GDB (@code{gdb}). The default is @code{auto}, which means @code{=
gdb}
+# during debug sessions and @code{native} otherwise.
+# @item arg=3D@var{str1},arg=3D@var{str2},...
+# Allows the user to pass input arguments, and can be used multiple time=
s to build
+# up a list. The old-style @code{-kernel}/@code{-append} method of passi=
ng a
+# command line is still supported for backward compatibility. If both th=
e
+# @code{--semihosting-config arg} and the @code{-kernel}/@code{-append} =
are
+# specified, the former is passed to semihosting as it always takes prec=
edence.
+# @end table
+# !end texinfo
+##
+{ 'option': '--semihosting-config',
+  'data': 'str',                # FIXME QAPIfy qemu_semihosting_config_o=
pts
+  'help': [
+"-semihosting-config [enable=3Don|off][,target=3Dnative|gdb|auto][,arg=3D=
str[,...]]",
+"                semihosting configuration"] }
+
+##
+# @--old-param:
+# !texinfo
+# -old-param@*
+# Old param mode (ARM only).
+# !end texinfo
+##
+{ 'option': '--old-param',
+  'help': "-old-param      old param mode" }
+
+##
+# @--sandbox:
+# !texinfo
+# -sandbox @var{arg}[,obsolete=3D@var{string}][,elevateprivileges=3D@var=
{string}][,spawn=3D@var{string}][,resourcecontrol=3D@var{string}]@*
+# Enable Seccomp mode 2 system call filter. 'on' will enable syscall fil=
tering and 'off' will
+# disable it.  The default is 'off'.
+# @table @option
+# @item obsolete=3D@var{string}
+# Enable Obsolete system calls
+# @item elevateprivileges=3D@var{string}
+# Disable set*uid|gid system calls
+# @item spawn=3D@var{string}
+# Disable *fork and execve
+# @item resourcecontrol=3D@var{string}
+# Disable process affinity and schedular priority
+# @end table
+# !end texinfo
+##
+{ 'option': '--sandbox',
+  'data': 'str',                # FIXME QAPIfy qemu_sandbox_opts
+  'help': [
+"-sandbox on[,obsolete=3Dallow|deny][,elevateprivileges=3Dallow|deny|chi=
ldren]",
+"          [,spawn=3Dallow|deny][,resourcecontrol=3Dallow|deny]",
+"                Enable seccomp mode 2 system call filter (default 'off'=
).",
+"                use 'obsolete' to allow obsolete system calls that are =
provided",
+"                    by the kernel, but typically no longer used by mode=
rn",
+"                    C library implementations.",
+"                use 'elevateprivileges' to allow or deny QEMU process t=
o elevate",
+"                    its privileges by blacklisting all set*uid|gid syst=
em calls.",
+"                    The value 'children' will deny set*uid|gid system c=
alls for",
+"                    main QEMU process but will allow forks and execves =
to run unprivileged",
+"                use 'spawn' to avoid QEMU to spawn new threads or proce=
sses by",
+"                     blacklisting *fork and execve",
+"                use 'resourcecontrol' to disable process affinity and s=
chedular priority"] }
+
+##
+# @--readconfig:
+# !texinfo
+# -readconfig @var{file}@*
+# Read device configuration from @var{file}. This approach is useful whe=
n you want to spawn
+# QEMU process with many command line options but you don't want to exce=
ed the command line
+# character limit.
+# !end texinfo
+##
+{ 'option': '--readconfig',
+  'data': 'str',                # FIXME
+  'help': "-readconfig <file>" }
+
+##
+# @--writeconfig:
+# !texinfo
+# -writeconfig @var{file}@*
+# Write device configuration to @var{file}. The @var{file} can be either=
 filename to save
+# command line and device configuration into file or dash @code{-}) char=
acter to print the
+# output to stdout. This can be later used as input file for @code{-read=
config} option.
+# !end texinfo
+##
+{ 'option': '--writeconfig',
+  'data': 'str',                # FIXME
+  'help': [
+"-writeconfig <file>",
+"                read/write config file"] }
+
+##
+# @--nodefconfig:
+# !texinfo
+# -nodefconfig@*
+# Normally QEMU loads configuration files from @var{sysconfdir} and @var=
{datadir} at startup.
+# The @code{-nodefconfig} option will prevent QEMU from loading any of t=
hose config files.
+# !end texinfo
+##
+{ 'option': '--nodefconfig',
+  'help': [
+"-nodefconfig",
+"                do not load default config files at startup"] }
+
+##
+# @--no-user-config:
+# !texinfo
+# -no-user-config@*
+# The @code{-no-user-config} option makes QEMU not load any of the user-=
provided
+# config files on @var{sysconfdir}, but won't make it skip the QEMU-prov=
ided config
+# files from @var{datadir}.
+# !end texinfo
+##
+{ 'option': '--no-user-config',
+  'help': [
+"-no-user-config",
+"                do not load user-provided config files at startup"] }
+
+##
+# @--trace:
+# !texinfo
+# HXCOMM This line is not accurate, as some sub-options are backend-spec=
ific but
+# HXCOMM HX does not support conditional compilation of text.
+# -trace [[enable=3D]@var{pattern}][,events=3D@var{file}][,file=3D@var{f=
ile}]@*
+# @include qemu-option-trace.texi
+# !end texinfo
+##
+{ 'option': '--trace',
+  'data': 'str',                # FIXME QAPIfy trace_opt_parse()
+  'help': [
+"-trace [[enable=3D]<pattern>][,events=3D<file>][,file=3D<file>]",
+"                specify tracing options"] }
+
+##
+# @--qtest:
+##
+{ 'option': '--qtest',
+  'data': 'str',                # FIXME QAPIfy qemu_chr_new()
+  'help': null }
+
+##
+# @--qtest-log:
+##
+{ 'option': '--qtest-log',
+  'data': 'str',
+  'help': null }
+
+##
+# @--enable-fips:
+# !texinfo
+# -enable-fips@*
+# Enable FIPS 140-2 compliance mode.
+# !end texinfo
+##
+{ 'option': '--enable-fips',
+  'help': "-enable-fips    enable FIPS 140-2 compliance" }
+
+##
+# @--no-kvm:
+##
+# TODO deprecate
+{ 'option': '--no-kvm',
+  'help': null }
+
+##
+# @--no-kvm-pit-reinjection:
+##
+# TODO deprecate
+{ 'option': '--no-kvm-pit-reinjection',
+  'help': null }
+
+##
+# @--no-kvm-pit:
+##
+# TODO deprecate
+{ 'option': '--no-kvm-pit',
+  'help': null }
+
+##
+# @--no-kvm-irqchip:
+##
+# TODO deprecate
+{ 'option': '--no-kvm-irqchip',
+  'help': null }
+
+##
+# @--tdf:
+##
+# TODO deprecate
+{ 'option': '--tdf',
+  'help': null }
+
+##
+# @--msg:
+# !texinfo
+# -msg timestamp[=3Don|off]@*
+# prepend a timestamp to each log message.(default:on)
+# !end texinfo
+##
+{ 'option': '--msg',
+  'data': 'str',                # FIXME QAPIfy qemu_msg_opts
+  'help': [
+"-msg timestamp[=3Don|off]",
+"                change the format of messages",
+"                on|off controls leading timestamps (default:on)"] }
+
+##
+# @--dump-vmstate:
+# !texinfo
+# -dump-vmstate @var{file}@*
+# Dump json-encoded vmstate information for current machine type to file
+# in @var{file}
+# !end texinfo
+##
+{ 'option': '--dump-vmstate',
+  'data': 'str',
+  'help': [
+"-dump-vmstate <file>",
+"                Output vmstate information in JSON format to file.",
+"                Use the scripts/vmstate-static-checker.py file to",
+"                check for possible regressions in migration code",
+"                by comparing two such vmstate dumps."] }
+
+##
+# =3D=3D Generic object creation
+##
+
+##
+# @--object:
+# !texinfo
+# -object @var{typename}[,@var{prop1}=3D@var{value1},...]@*
+# Create a new object of type @var{typename} setting properties
+# in the order they are specified.  Note that the 'id'
+# property must be set.  These objects are placed in the
+# '/objects' path.
+#
+# @table @option
+#
+# @item -object memory-backend-file,id=3D@var{id},size=3D@var{size},mem-=
path=3D@var{dir},share=3D@var{on|off},discard-data=3D@var{on|off}
+#
+# Creates a memory file backend object, which can be used to back
+# the guest RAM with huge pages. The @option{id} parameter is a
+# unique ID that will be used to reference this memory region
+# when configuring the @option{-numa} argument. The @option{size}
+# option provides the size of the memory region, and accepts
+# common suffixes, eg @option{500M}. The @option{mem-path} provides
+# the path to either a shared memory or huge page filesystem mount.
+# The @option{share} boolean option determines whether the memory
+# region is marked as private to QEMU, or shared. The latter allows
+# a co-operating external process to access the QEMU memory region.
+# Setting the @option{discard-data} boolean option to @var{on}
+# indicates that file contents can be destroyed when QEMU exits,
+# to avoid unnecessarily flushing data to the backing file.  Note
+# that @option{discard-data} is only an optimization, and QEMU
+# might not discard file contents if it aborts unexpectedly or is
+# terminated using SIGKILL.
+#
+# @item -object rng-random,id=3D@var{id},filename=3D@var{/dev/random}
+#
+# Creates a random number generator backend which obtains entropy from
+# a device on the host. The @option{id} parameter is a unique ID that
+# will be used to reference this entropy backend from the @option{virtio=
-rng}
+# device. The @option{filename} parameter specifies which file to obtain
+# entropy from and if omitted defaults to @option{/dev/random}.
+#
+# @item -object rng-egd,id=3D@var{id},chardev=3D@var{chardevid}
+#
+# Creates a random number generator backend which obtains entropy from
+# an external daemon running on the host. The @option{id} parameter is
+# a unique ID that will be used to reference this entropy backend from
+# the @option{virtio-rng} device. The @option{chardev} parameter is
+# the unique ID of a character device backend that provides the connecti=
on
+# to the RNG daemon.
+#
+# @item -object tls-creds-anon,id=3D@var{id},endpoint=3D@var{endpoint},d=
ir=3D@var{/path/to/cred/dir},verify-peer=3D@var{on|off}
+#
+# Creates a TLS anonymous credentials object, which can be used to provi=
de
+# TLS support on network backends. The @option{id} parameter is a unique
+# ID which network backends will use to access the credentials. The
+# @option{endpoint} is either @option{server} or @option{client} dependi=
ng
+# on whether the QEMU network backend that uses the credentials will be
+# acting as a client or as a server. If @option{verify-peer} is enabled
+# (the default) then once the handshake is completed, the peer credentia=
ls
+# will be verified, though this is a no-op for anonymous credentials.
+#
+# The @var{dir} parameter tells QEMU where to find the credential
+# files. For server endpoints, this directory may contain a file
+# @var{dh-params.pem} providing diffie-hellman parameters to use
+# for the TLS server. If the file is missing, QEMU will generate
+# a set of DH parameters at startup. This is a computationally
+# expensive operation that consumes random pool entropy, so it is
+# recommended that a persistent set of parameters be generated
+# upfront and saved.
+#
+# @item -object tls-creds-x509,id=3D@var{id},endpoint=3D@var{endpoint},d=
ir=3D@var{/path/to/cred/dir},verify-peer=3D@var{on|off},passwordid=3D@var=
{id}
+#
+# Creates a TLS anonymous credentials object, which can be used to provi=
de
+# TLS support on network backends. The @option{id} parameter is a unique
+# ID which network backends will use to access the credentials. The
+# @option{endpoint} is either @option{server} or @option{client} dependi=
ng
+# on whether the QEMU network backend that uses the credentials will be
+# acting as a client or as a server. If @option{verify-peer} is enabled
+# (the default) then once the handshake is completed, the peer credentia=
ls
+# will be verified. With x509 certificates, this implies that the client=
s
+# must be provided with valid client certificates too.
+#
+# The @var{dir} parameter tells QEMU where to find the credential
+# files. For server endpoints, this directory may contain a file
+# @var{dh-params.pem} providing diffie-hellman parameters to use
+# for the TLS server. If the file is missing, QEMU will generate
+# a set of DH parameters at startup. This is a computationally
+# expensive operation that consumes random pool entropy, so it is
+# recommended that a persistent set of parameters be generated
+# upfront and saved.
+#
+# For x509 certificate credentials the directory will contain further fi=
les
+# providing the x509 certificates. The certificates must be stored
+# in PEM format, in filenames @var{ca-cert.pem}, @var{ca-crl.pem} (optio=
nal),
+# @var{server-cert.pem} (only servers), @var{server-key.pem} (only serve=
rs),
+# @var{client-cert.pem} (only clients), and @var{client-key.pem} (only c=
lients).
+#
+# For the @var{server-key.pem} and @var{client-key.pem} files which
+# contain sensitive private keys, it is possible to use an encrypted
+# version by providing the @var{passwordid} parameter. This provides
+# the ID of a previously created @code{secret} object containing the
+# password for decryption.
+#
+# @item -object filter-buffer,id=3D@var{id},netdev=3D@var{netdevid},inte=
rval=3D@var{t}[,queue=3D@var{all|rx|tx}][,status=3D@var{on|off}]
+#
+# Interval @var{t} can't be 0, this filter batches the packet delivery: =
all
+# packets arriving in a given interval on netdev @var{netdevid} are dela=
yed
+# until the end of the interval. Interval is in microseconds.
+# @option{status} is optional that indicate whether the netfilter is
+# on (enabled) or off (disabled), the default status for netfilter will =
be 'on'.
+#
+# queue @var{all|rx|tx} is an option that can be applied to any netfilte=
r.
+#
+# @option{all}: the filter is attached both to the receive and the trans=
mit
+#               queue of the netdev (default).
+#
+# @option{rx}: the filter is attached to the receive queue of the netdev=
,
+#              where it will receive packets sent to the netdev.
+#
+# @option{tx}: the filter is attached to the transmit queue of the netde=
v,
+#              where it will receive packets sent by the netdev.
+#
+# @item -object filter-mirror,id=3D@var{id},netdev=3D@var{netdevid},outd=
ev=3D@var{chardevid},queue=3D@var{all|rx|tx}[,vnet_hdr_support]
+#
+# filter-mirror on netdev @var{netdevid},mirror net packet to chardev@va=
r{chardevid}, if it has the vnet_hdr_support flag, filter-mirror will mir=
ror packet with vnet_hdr_len.
+#
+# @item -object filter-redirector,id=3D@var{id},netdev=3D@var{netdevid},=
indev=3D@var{chardevid},outdev=3D@var{chardevid},queue=3D@var{all|rx|tx}[=
,vnet_hdr_support]
+#
+# filter-redirector on netdev @var{netdevid},redirect filter's net packe=
t to chardev
+# @var{chardevid},and redirect indev's packet to filter.if it has the vn=
et_hdr_support flag,
+# filter-redirector will redirect packet with vnet_hdr_len.
+# Create a filter-redirector we need to differ outdev id from indev id, =
id can not
+# be the same. we can just use indev or outdev, but at least one of inde=
v or outdev
+# need to be specified.
+#
+# @item -object filter-rewriter,id=3D@var{id},netdev=3D@var{netdevid},qu=
eue=3D@var{all|rx|tx},[vnet_hdr_support]
+#
+# Filter-rewriter is a part of COLO project.It will rewrite tcp packet t=
o
+# secondary from primary to keep secondary tcp connection,and rewrite
+# tcp packet to primary from secondary make tcp packet can be handled by
+# client.if it has the vnet_hdr_support flag, we can parse packet with v=
net header.
+#
+# usage:
+# colo secondary:
+# -object filter-redirector,id=3Df1,netdev=3Dhn0,queue=3Dtx,indev=3Dred0
+# -object filter-redirector,id=3Df2,netdev=3Dhn0,queue=3Drx,outdev=3Dred=
1
+# -object filter-rewriter,id=3Drew0,netdev=3Dhn0,queue=3Dall
+#
+# @item -object filter-dump,id=3D@var{id},netdev=3D@var{dev}[,file=3D@va=
r{filename}][,maxlen=3D@var{len}]
+#
+# Dump the network traffic on netdev @var{dev} to the file specified by
+# @var{filename}. At most @var{len} bytes (64k by default) per packet ar=
e stored.
+# The file format is libpcap, so it can be analyzed with tools such as t=
cpdump
+# or Wireshark.
+#
+# @item -object colo-compare,id=3D@var{id},primary_in=3D@var{chardevid},=
secondary_in=3D@var{chardevid},outdev=3D@var{chardevid}[,vnet_hdr_support=
]
+#
+# Colo-compare gets packet from primary_in@var{chardevid} and secondary_=
in@var{chardevid}, than compare primary packet with
+# secondary packet. If the packets are same, we will output primary
+# packet to outdev@var{chardevid}, else we will notify colo-frame
+# do checkpoint and send primary packet to outdev@var{chardevid}.
+# if it has the vnet_hdr_support flag, colo compare will send/recv packe=
t with vnet_hdr_len.
+#
+# we must use it with the help of filter-mirror and filter-redirector.
+#
+# @example
+#
+# primary:
+# -netdev tap,id=3Dhn0,vhost=3Doff,script=3D/etc/qemu-ifup,downscript=3D=
/etc/qemu-ifdown
+# -device e1000,id=3De0,netdev=3Dhn0,mac=3D52:a4:00:12:78:66
+# -chardev socket,id=3Dmirror0,host=3D3.3.3.3,port=3D9003,server,nowait
+# -chardev socket,id=3Dcompare1,host=3D3.3.3.3,port=3D9004,server,nowait
+# -chardev socket,id=3Dcompare0,host=3D3.3.3.3,port=3D9001,server,nowait
+# -chardev socket,id=3Dcompare0-0,host=3D3.3.3.3,port=3D9001
+# -chardev socket,id=3Dcompare_out,host=3D3.3.3.3,port=3D9005,server,now=
ait
+# -chardev socket,id=3Dcompare_out0,host=3D3.3.3.3,port=3D9005
+# -object filter-mirror,id=3Dm0,netdev=3Dhn0,queue=3Dtx,outdev=3Dmirror0
+# -object filter-redirector,netdev=3Dhn0,id=3Dredire0,queue=3Drx,indev=3D=
compare_out
+# -object filter-redirector,netdev=3Dhn0,id=3Dredire1,queue=3Drx,outdev=3D=
compare0
+# -object colo-compare,id=3Dcomp0,primary_in=3Dcompare0-0,secondary_in=3D=
compare1,outdev=3Dcompare_out0
+#
+# secondary:
+# -netdev tap,id=3Dhn0,vhost=3Doff,script=3D/etc/qemu-ifup,down script=3D=
/etc/qemu-ifdown
+# -device e1000,netdev=3Dhn0,mac=3D52:a4:00:12:78:66
+# -chardev socket,id=3Dred0,host=3D3.3.3.3,port=3D9003
+# -chardev socket,id=3Dred1,host=3D3.3.3.3,port=3D9004
+# -object filter-redirector,id=3Df1,netdev=3Dhn0,queue=3Dtx,indev=3Dred0
+# -object filter-redirector,id=3Df2,netdev=3Dhn0,queue=3Drx,outdev=3Dred=
1
+#
+# @end example
+#
+# If you want to know the detail of above command line, you can read
+# the colo-compare git log.
+#
+# @item -object cryptodev-backend-builtin,id=3D@var{id}[,queues=3D@var{q=
ueues}]
+#
+# Creates a cryptodev backend which executes crypto opreation from
+# the QEMU cipher APIS. The @var{id} parameter is
+# a unique ID that will be used to reference this cryptodev backend from
+# the @option{virtio-crypto} device. The @var{queues} parameter is optio=
nal,
+# which specify the queue number of cryptodev backend, the default of
+# @var{queues} is 1.
+#
+# @example
+#
+#  # qemu-system-x86_64 \
+#    [...] \
+#        -object cryptodev-backend-builtin,id=3Dcryptodev0 \
+#        -device virtio-crypto-pci,id=3Dcrypto0,cryptodev=3Dcryptodev0 \
+#    [...]
+# @end example
+#
+# @item -object secret,id=3D@var{id},data=3D@var{string},format=3D@var{r=
aw|base64}[,keyid=3D@var{secretid},iv=3D@var{string}]
+# @item -object secret,id=3D@var{id},file=3D@var{filename},format=3D@var=
{raw|base64}[,keyid=3D@var{secretid},iv=3D@var{string}]
+#
+# Defines a secret to store a password, encryption key, or some other se=
nsitive
+# data. The sensitive data can either be passed directly via the @var{da=
ta}
+# parameter, or indirectly via the @var{file} parameter. Using the @var{=
data}
+# parameter is insecure unless the sensitive data is encrypted.
+#
+# The sensitive data can be provided in raw format (the default), or bas=
e64.
+# When encoded as JSON, the raw format only supports valid UTF-8 charact=
ers,
+# so base64 is recommended for sending binary data. QEMU will convert fr=
om
+# which ever format is provided to the format it needs internally. eg, a=
n
+# RBD password can be provided in raw format, even though it will be bas=
e64
+# encoded when passed onto the RBD sever.
+#
+# For added protection, it is possible to encrypt the data associated wi=
th
+# a secret using the AES-256-CBC cipher. Use of encryption is indicated
+# by providing the @var{keyid} and @var{iv} parameters. The @var{keyid}
+# parameter provides the ID of a previously defined secret that contains
+# the AES-256 decryption key. This key should be 32-bytes long and be
+# base64 encoded. The @var{iv} parameter provides the random initializat=
ion
+# vector used for encryption of this particular secret and should be a
+# base64 encrypted string of the 16-byte IV.
+#
+# The simplest (insecure) usage is to provide the secret inline
+#
+# @example
+#
+#  # $QEMU -object secret,id=3Dsec0,data=3Dletmein,format=3Draw
+#
+# @end example
+#
+# The simplest secure usage is to provide the secret via a file
+#
+#  # printf "letmein" > mypasswd.txt
+#  # $QEMU -object secret,id=3Dsec0,file=3Dmypasswd.txt,format=3Draw
+#
+# For greater security, AES-256-CBC should be used. To illustrate usage,
+# consider the openssl command line tool which can encrypt the data. Not=
e
+# that when encrypting, the plaintext must be padded to the cipher block
+# size (32 bytes) using the standard PKCS#5/6 compatible padding algorit=
hm.
+#
+# First a master key needs to be created in base64 encoding:
+#
+# @example
+#  # openssl rand -base64 32 > key.b64
+#  # KEY=3D$(base64 -d key.b64 | hexdump  -v -e '/1 "%02X"')
+# @end example
+#
+# Each secret to be encrypted needs to have a random initialization vect=
or
+# generated. These do not need to be kept secret
+#
+# @example
+#  # openssl rand -base64 16 > iv.b64
+#  # IV=3D$(base64 -d iv.b64 | hexdump  -v -e '/1 "%02X"')
+# @end example
+#
+# The secret to be defined can now be encrypted, in this case we're
+# telling openssl to base64 encode the result, but it could be left
+# as raw bytes if desired.
+#
+# @example
+#  # SECRET=3D$(printf "letmein" |
+#             openssl enc -aes-256-cbc -a -K $KEY -iv $IV)
+# @end example
+#
+# When launching QEMU, create a master secret pointing to @code{key.b64}
+# and specify that to be used to decrypt the user password. Pass the
+# contents of @code{iv.b64} to the second secret
+#
+# @example
+#  # $QEMU \
+#      -object secret,id=3Dsecmaster0,format=3Dbase64,file=3Dkey.b64 \
+#      -object secret,id=3Dsec0,keyid=3Dsecmaster0,format=3Dbase64,\
+#          data=3D$SECRET,iv=3D$(<iv.b64)
+# @end example
+#
+# @end table
+# !end texinfo
+##
+{ 'option': '--object',
+  'data': 'str',                # FIXME QAPIfy qemu_object_opts: object_=
add
+  'help': [
+"-object TYPENAME[,PROP1=3DVALUE1,...]",
+"                create a new object of type TYPENAME setting properties=
",
+"                in the order they are specified.  Note that the 'id'",
+"                property must be set.  These objects are placed in the"=
,
+"                '/objects' path."] }
diff --git a/qemu-doc.texi b/qemu-doc.texi
index 848e49966a..57223e2dc3 100644
--- a/qemu-doc.texi
+++ b/qemu-doc.texi
@@ -241,7 +241,7 @@ Linux should boot and give you a prompt.
 @var{disk_image} is a raw hard disk image for IDE hard disk 0. Some
 targets do not need a disk image.
=20
-@include qemu-options.texi
+FIXME include options part of docs/interop/qemu-qmp-qapi.texi
=20
 @c man end
=20
@@ -968,7 +968,7 @@ useful yet as it was with the legacy @code{-usbdevice=
} option. So to
 configure an USB bluetooth device, you might need to use
 "@code{-usbdevice bt}[:@var{hci-type}]" instead. This configures a
 bluetooth dongle whose type is specified in the same format as with
-the @option{-bt hci} option, @pxref{bt-hcis,,allowed HCI types}.  If
+the @option{-bt hci} option, FIXME @@pxref@{bt-hcis,,allowed HCI types@}=
.  If
 no type is given, the HCI logic corresponds to @code{-bt hci,vlan=3D0}.
 This USB device implements the USB Transport Layer of HCI.  Example
 usage:
diff --git a/qemu-options-wrapper.h b/qemu-options-wrapper.h
deleted file mode 100644
index 13bfea0294..0000000000
--- a/qemu-options-wrapper.h
+++ /dev/null
@@ -1,41 +0,0 @@
-
-#if defined(QEMU_OPTIONS_GENERATE_ENUM)
-
-#define DEF(option, opt_arg, opt_enum, opt_help, arch_mask)     \
-    opt_enum,
-#define DEFHEADING(text)
-#define ARCHHEADING(text, arch_mask)
-
-#elif defined(QEMU_OPTIONS_GENERATE_HELP)
-
-#define DEF(option, opt_arg, opt_enum, opt_help, arch_mask)    \
-    if ((arch_mask) & arch_type)                               \
-        fputs(opt_help, stdout);
-
-#define ARCHHEADING(text, arch_mask) \
-    if ((arch_mask) & arch_type)    \
-        puts(stringify(text));
-
-#define DEFHEADING(text) ARCHHEADING(text, QEMU_ARCH_ALL)
-
-#elif defined(QEMU_OPTIONS_GENERATE_OPTIONS)
-
-#define DEF(option, opt_arg, opt_enum, opt_help, arch_mask)     \
-    { option, opt_arg, opt_enum, arch_mask },
-#define DEFHEADING(text)
-#define ARCHHEADING(text, arch_mask)
-
-#else
-#error "qemu-options-wrapper.h included with no option defined"
-#endif
-
-#include "qemu-options.def"
-
-#undef DEF
-#undef DEFHEADING
-#undef ARCHHEADING
-#undef GEN_DOCS
-
-#undef QEMU_OPTIONS_GENERATE_ENUM
-#undef QEMU_OPTIONS_GENERATE_HELP
-#undef QEMU_OPTIONS_GENERATE_OPTIONS
diff --git a/qemu-options.h b/qemu-options.h
deleted file mode 100644
index b4ee63cd60..0000000000
--- a/qemu-options.h
+++ /dev/null
@@ -1,36 +0,0 @@
-/*
- * qemu-options.h
- *
- * Defines needed for command line argument processing.
- *
- * Copyright (c) 2003-2008 Fabrice Bellard
- * Copyright (c) 2010 Jes Sorensen <Jes.Sorensen@redhat.com>
- *
- * Permission is hereby granted, free of charge, to any person obtaining=
 a copy
- * of this software and associated documentation files (the "Software"),=
 to deal
- * in the Software without restriction, including without limitation the=
 rights
- * to use, copy, modify, merge, publish, distribute, sublicense, and/or =
sell
- * copies of the Software, and to permit persons to whom the Software is
- * furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice shall be includ=
ed in
- * all copies or substantial portions of the Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHA=
LL
- * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR =
OTHER
- * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISI=
NG FROM,
- * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
- * THE SOFTWARE.
- */
-
-#ifndef QEMU_OPTIONS_H
-#define QEMU_OPTIONS_H
-
-enum {
-#define QEMU_OPTIONS_GENERATE_ENUM
-#include "qemu-options-wrapper.h"
-};
-
-#endif
diff --git a/qemu-options.hx b/qemu-options.hx
deleted file mode 100644
index 32afc11296..0000000000
--- a/qemu-options.hx
+++ /dev/null
@@ -1,4256 +0,0 @@
-HXCOMM Use DEFHEADING() to define headings in both help text and texi
-HXCOMM Text between STEXI and ETEXI are copied to texi version and
-HXCOMM discarded from C version
-HXCOMM DEF(option, HAS_ARG/0, opt_enum, opt_help, arch_mask) is used to
-HXCOMM construct option structures, enums and help message for specified
-HXCOMM architectures.
-HXCOMM HXCOMM can be used for comments, discarded from both texi and C
-
-DEFHEADING(Standard options:)
-STEXI
-@table @option
-ETEXI
-
-DEF("help", 0, QEMU_OPTION_h,
-    "-h or -help     display this help and exit\n", QEMU_ARCH_ALL)
-STEXI
-@item -h
-@findex -h
-Display help and exit
-ETEXI
-
-DEF("version", 0, QEMU_OPTION_version,
-    "-version        display version information and exit\n", QEMU_ARCH_=
ALL)
-STEXI
-@item -version
-@findex -version
-Display version information and exit
-ETEXI
-
-DEF("machine", HAS_ARG, QEMU_OPTION_machine, \
-    "-machine [type=3D]name[,prop[=3Dvalue][,...]]\n"
-    "                selects emulated machine ('-machine help' for list)=
\n"
-    "                property accel=3Daccel1[:accel2[:...]] selects acce=
lerator\n"
-    "                supported accelerators are kvm, xen, hax or tcg (de=
fault: tcg)\n"
-    "                kernel_irqchip=3Don|off|split controls accelerated =
irqchip support (default=3Doff)\n"
-    "                vmport=3Don|off|auto controls emulation of vmport (=
default: auto)\n"
-    "                kvm_shadow_mem=3Dsize of KVM shadow MMU in bytes\n"
-    "                dump-guest-core=3Don|off include guest memory in a =
core dump (default=3Don)\n"
-    "                mem-merge=3Don|off controls memory merge support (d=
efault: on)\n"
-    "                igd-passthru=3Don|off controls IGD GFX passthrough =
support (default=3Doff)\n"
-    "                aes-key-wrap=3Don|off controls support for AES key =
wrapping (default=3Don)\n"
-    "                dea-key-wrap=3Don|off controls support for DEA key =
wrapping (default=3Don)\n"
-    "                suppress-vmdesc=3Don|off disables self-describing m=
igration (default=3Doff)\n"
-    "                nvdimm=3Don|off controls NVDIMM support (default=3D=
off)\n"
-    "                enforce-config-section=3Don|off enforce configurati=
on section migration (default=3Doff)\n"
-    "                s390-squash-mcss=3Don|off controls support for squa=
shing into default css (default=3Doff)\n",
-    QEMU_ARCH_ALL)
-STEXI
-@item -machine [type=3D]@var{name}[,prop=3D@var{value}[,...]]
-@findex -machine
-Select the emulated machine by @var{name}. Use @code{-machine help} to l=
ist
-available machines.
-
-For architectures which aim to support live migration compatibility
-across releases, each release will introduce a new versioned machine
-type. For example, the 2.8.0 release introduced machine types
-``pc-i440fx-2.8'' and ``pc-q35-2.8'' for the x86_64/i686 architectures.
-
-To allow live migration of guests from QEMU version 2.8.0, to QEMU
-version 2.9.0, the 2.9.0 version must support the ``pc-i440fx-2.8''
-and ``pc-q35-2.8'' machines too. To allow users live migrating VMs
-to skip multiple intermediate releases when upgrading, new releases
-of QEMU will support machine types from many previous versions.
-
-Supported machine properties are:
-@table @option
-@item accel=3D@var{accels1}[:@var{accels2}[:...]]
-This is used to enable an accelerator. Depending on the target architect=
ure,
-kvm, xen, hax or tcg can be available. By default, tcg is used. If there=
 is
-more than one accelerator specified, the next one is used if the previou=
s one
-fails to initialize.
-@item kernel_irqchip=3Don|off
-Controls in-kernel irqchip support for the chosen accelerator when avail=
able.
-@item gfx_passthru=3Don|off
-Enables IGD GFX passthrough support for the chosen machine when availabl=
e.
-@item vmport=3Don|off|auto
-Enables emulation of VMWare IO port, for vmmouse etc. auto says to selec=
t the
-value based on accel. For accel=3Dxen the default is off otherwise the d=
efault
-is on.
-@item kvm_shadow_mem=3Dsize
-Defines the size of the KVM shadow MMU.
-@item dump-guest-core=3Don|off
-Include guest memory in a core dump. The default is on.
-@item mem-merge=3Don|off
-Enables or disables memory merge support. This feature, when supported b=
y
-the host, de-duplicates identical memory pages among VMs instances
-(enabled by default).
-@item aes-key-wrap=3Don|off
-Enables or disables AES key wrapping support on s390-ccw hosts. This fea=
ture
-controls whether AES wrapping keys will be created to allow
-execution of AES cryptographic functions.  The default is on.
-@item dea-key-wrap=3Don|off
-Enables or disables DEA key wrapping support on s390-ccw hosts. This fea=
ture
-controls whether DEA wrapping keys will be created to allow
-execution of DEA cryptographic functions.  The default is on.
-@item nvdimm=3Don|off
-Enables or disables NVDIMM support. The default is off.
-@item s390-squash-mcss=3Don|off
-Enables or disables squashing subchannels into the default css.
-The default is off.
-@item enforce-config-section=3Don|off
-If @option{enforce-config-section} is set to @var{on}, force migration
-code to send configuration section even if the machine-type sets the
-@option{migration.send-configuration} property to @var{off}.
-NOTE: this parameter is deprecated. Please use @option{-global}
-@option{migration.send-configuration}=3D@var{on|off} instead.
-@end table
-ETEXI
-
-HXCOMM Deprecated by -machine
-DEF("M", HAS_ARG, QEMU_OPTION_M, "", QEMU_ARCH_ALL)
-
-DEF("cpu", HAS_ARG, QEMU_OPTION_cpu,
-    "-cpu cpu        select CPU ('-cpu help' for list)\n", QEMU_ARCH_ALL=
)
-STEXI
-@item -cpu @var{model}
-@findex -cpu
-Select CPU model (@code{-cpu help} for list and additional feature selec=
tion)
-ETEXI
-
-DEF("accel", HAS_ARG, QEMU_OPTION_accel,
-    "-accel [accel=3D]accelerator[,thread=3Dsingle|multi]\n"
-    "                select accelerator (kvm, xen, hax or tcg; use 'help=
' for a list)\n"
-    "                thread=3Dsingle|multi (enable multi-threaded TCG)\n=
", QEMU_ARCH_ALL)
-STEXI
-@item -accel @var{name}[,prop=3D@var{value}[,...]]
-@findex -accel
-This is used to enable an accelerator. Depending on the target architect=
ure,
-kvm, xen, hax or tcg can be available. By default, tcg is used. If there=
 is
-more than one accelerator specified, the next one is used if the previou=
s one
-fails to initialize.
-@table @option
-@item thread=3Dsingle|multi
-Controls number of TCG threads. When the TCG is multi-threaded there wil=
l be one
-thread per vCPU therefor taking advantage of additional host cores. The =
default
-is to enable multi-threading where both the back-end and front-ends supp=
ort it and
-no incompatible TCG features have been enabled (e.g. icount/replay).
-@end table
-ETEXI
-
-DEF("smp", HAS_ARG, QEMU_OPTION_smp,
-    "-smp [cpus=3D]n[,maxcpus=3Dcpus][,cores=3Dcores][,threads=3Dthreads=
][,sockets=3Dsockets]\n"
-    "                set the number of CPUs to 'n' [default=3D1]\n"
-    "                maxcpus=3D maximum number of total cpus, including\=
n"
-    "                offline CPUs for hotplug, etc\n"
-    "                cores=3D number of CPU cores on one socket\n"
-    "                threads=3D number of threads on one CPU core\n"
-    "                sockets=3D number of discrete sockets in the system=
\n",
-        QEMU_ARCH_ALL)
-STEXI
-@item -smp [cpus=3D]@var{n}[,cores=3D@var{cores}][,threads=3D@var{thread=
s}][,sockets=3D@var{sockets}][,maxcpus=3D@var{maxcpus}]
-@findex -smp
-Simulate an SMP system with @var{n} CPUs. On the PC target, up to 255
-CPUs are supported. On Sparc32 target, Linux limits the number of usable=
 CPUs
-to 4.
-For the PC target, the number of @var{cores} per socket, the number
-of @var{threads} per cores and the total number of @var{sockets} can be
-specified. Missing values will be computed. If any on the three values i=
s
-given, the total number of CPUs @var{n} can be omitted. @var{maxcpus}
-specifies the maximum number of hotpluggable CPUs.
-ETEXI
-
-DEF("numa", HAS_ARG, QEMU_OPTION_numa,
-    "-numa node[,mem=3Dsize][,cpus=3Dfirstcpu[-lastcpu]][,nodeid=3Dnode]=
\n"
-    "-numa node[,memdev=3Did][,cpus=3Dfirstcpu[-lastcpu]][,nodeid=3Dnode=
]\n"
-    "-numa dist,src=3Dsource,dst=3Ddestination,val=3Ddistance\n", QEMU_A=
RCH_ALL)
-STEXI
-@item -numa node[,mem=3D@var{size}][,cpus=3D@var{firstcpu}[-@var{lastcpu=
}]][,nodeid=3D@var{node}]
-@itemx -numa node[,memdev=3D@var{id}][,cpus=3D@var{firstcpu}[-@var{lastc=
pu}]][,nodeid=3D@var{node}]
-@itemx -numa dist,src=3D@var{source},dst=3D@var{destination},val=3D@var{=
distance}
-@itemx -numa cpu,node-id=3D@var{node}[,socket-id=3D@var{x}][,core-id=3D@=
var{y}][,thread-id=3D@var{z}]
-@findex -numa
-Define a NUMA node and assign RAM and VCPUs to it.
-Set the NUMA distance from a source node to a destination node.
-
-Legacy VCPU assignment uses @samp{cpus} option where
-@var{firstcpu} and @var{lastcpu} are CPU indexes. Each
-@samp{cpus} option represent a contiguous range of CPU indexes
-(or a single VCPU if @var{lastcpu} is omitted). A non-contiguous
-set of VCPUs can be represented by providing multiple @samp{cpus}
-options. If @samp{cpus} is omitted on all nodes, VCPUs are automatically
-split between them.
-
-For example, the following option assigns VCPUs 0, 1, 2 and 5 to
-a NUMA node:
-@example
--numa node,cpus=3D0-2,cpus=3D5
-@end example
-
-@samp{cpu} option is a new alternative to @samp{cpus} option
-which uses @samp{socket-id|core-id|thread-id} properties to assign
-CPU objects to a @var{node} using topology layout properties of CPU.
-The set of properties is machine specific, and depends on used
-machine type/@samp{smp} options. It could be queried with
-@samp{hotpluggable-cpus} monitor command.
-@samp{node-id} property specifies @var{node} to which CPU object
-will be assigned, it's required for @var{node} to be declared
-with @samp{node} option before it's used with @samp{cpu} option.
-
-For example:
-@example
--M pc \
--smp 1,sockets=3D2,maxcpus=3D2 \
--numa node,nodeid=3D0 -numa node,nodeid=3D1 \
--numa cpu,node-id=3D0,socket-id=3D0 -numa cpu,node-id=3D1,socket-id=3D1
-@end example
-
-@samp{mem} assigns a given RAM amount to a node. @samp{memdev}
-assigns RAM from a given memory backend device to a node. If
-@samp{mem} and @samp{memdev} are omitted in all nodes, RAM is
-split equally between them.
-
-@samp{mem} and @samp{memdev} are mutually exclusive. Furthermore,
-if one node uses @samp{memdev}, all of them have to use it.
-
-@var{source} and @var{destination} are NUMA node IDs.
-@var{distance} is the NUMA distance from @var{source} to @var{destinatio=
n}.
-The distance from a node to itself is always 10. If any pair of nodes is
-given a distance, then all pairs must be given distances. Although, when
-distances are only given in one direction for each pair of nodes, then
-the distances in the opposite directions are assumed to be the same. If,
-however, an asymmetrical pair of distances is given for even one node
-pair, then all node pairs must be provided distance values for both
-directions, even when they are symmetrical. When a node is unreachable
-from another node, set the pair's distance to 255.
-
-Note that the -@option{numa} option doesn't allocate any of the
-specified resources, it just assigns existing resources to NUMA
-nodes. This means that one still has to use the @option{-m},
-@option{-smp} options to allocate RAM and VCPUs respectively.
-
-ETEXI
-
-DEF("add-fd", HAS_ARG, QEMU_OPTION_add_fd,
-    "-add-fd fd=3Dfd,set=3Dset[,opaque=3Dopaque]\n"
-    "                Add 'fd' to fd 'set'\n", QEMU_ARCH_ALL)
-STEXI
-@item -add-fd fd=3D@var{fd},set=3D@var{set}[,opaque=3D@var{opaque}]
-@findex -add-fd
-
-Add a file descriptor to an fd set.  Valid options are:
-
-@table @option
-@item fd=3D@var{fd}
-This option defines the file descriptor of which a duplicate is added to=
 fd set.
-The file descriptor cannot be stdin, stdout, or stderr.
-@item set=3D@var{set}
-This option defines the ID of the fd set to add the file descriptor to.
-@item opaque=3D@var{opaque}
-This option defines a free-form string that can be used to describe @var=
{fd}.
-@end table
-
-You can open an image using pre-opened file descriptors from an fd set:
-@example
-qemu-system-i386
--add-fd fd=3D3,set=3D2,opaque=3D"rdwr:/path/to/file"
--add-fd fd=3D4,set=3D2,opaque=3D"rdonly:/path/to/file"
--drive file=3D/dev/fdset/2,index=3D0,media=3Ddisk
-@end example
-ETEXI
-
-DEF("set", HAS_ARG, QEMU_OPTION_set,
-    "-set group.id.arg=3Dvalue\n"
-    "                set <arg> parameter for item <id> of type <group>\n=
"
-    "                i.e. -set drive.$id.file=3D/path/to/image\n", QEMU_=
ARCH_ALL)
-STEXI
-@item -set @var{group}.@var{id}.@var{arg}=3D@var{value}
-@findex -set
-Set parameter @var{arg} for item @var{id} of type @var{group}
-ETEXI
-
-DEF("global", HAS_ARG, QEMU_OPTION_global,
-    "-global driver.property=3Dvalue\n"
-    "-global driver=3Ddriver,property=3Dproperty,value=3Dvalue\n"
-    "                set a global default for a driver property\n",
-    QEMU_ARCH_ALL)
-STEXI
-@item -global @var{driver}.@var{prop}=3D@var{value}
-@itemx -global driver=3D@var{driver},property=3D@var{property},value=3D@=
var{value}
-@findex -global
-Set default value of @var{driver}'s property @var{prop} to @var{value}, =
e.g.:
-
-@example
-qemu-system-i386 -global ide-hd.physical_block_size=3D4096 disk-image.im=
g
-@end example
-
-In particular, you can use this to set driver properties for devices whi=
ch are
-created automatically by the machine model. To create a device which is =
not
-created automatically and set properties on it, use -@option{device}.
-
--global @var{driver}.@var{prop}=3D@var{value} is shorthand for -global
-driver=3D@var{driver},property=3D@var{prop},value=3D@var{value}.  The
-longhand syntax works even when @var{driver} contains a dot.
-ETEXI
-
-DEF("boot", HAS_ARG, QEMU_OPTION_boot,
-    "-boot [order=3Ddrives][,once=3Ddrives][,menu=3Don|off]\n"
-    "      [,splash=3Dsp_name][,splash-time=3Dsp_time][,reboot-timeout=3D=
rb_time][,strict=3Don|off]\n"
-    "                'drives': floppy (a), hard disk (c), CD-ROM (d), ne=
twork (n)\n"
-    "                'sp_name': the file's name that would be passed to =
bios as logo picture, if menu=3Don\n"
-    "                'sp_time': the period that splash picture last if m=
enu=3Don, unit is ms\n"
-    "                'rb_timeout': the timeout before guest reboot when =
boot failed, unit is ms\n",
-    QEMU_ARCH_ALL)
-STEXI
-@item -boot [order=3D@var{drives}][,once=3D@var{drives}][,menu=3Don|off]=
[,splash=3D@var{sp_name}][,splash-time=3D@var{sp_time}][,reboot-timeout=3D=
@var{rb_timeout}][,strict=3Don|off]
-@findex -boot
-Specify boot order @var{drives} as a string of drive letters. Valid
-drive letters depend on the target architecture. The x86 PC uses: a, b
-(floppy 1 and 2), c (first hard disk), d (first CD-ROM), n-p (Etherboot
-from network adapter 1-4), hard disk boot is the default. To apply a
-particular boot order only on the first startup, specify it via
-@option{once}. Note that the @option{order} or @option{once} parameter
-should not be used together with the @option{bootindex} property of
-devices, since the firmware implementations normally do not support both
-at the same time.
-
-Interactive boot menus/prompts can be enabled via @option{menu=3Don} as =
far
-as firmware/BIOS supports them. The default is non-interactive boot.
-
-A splash picture could be passed to bios, enabling user to show it as lo=
go,
-when option splash=3D@var{sp_name} is given and menu=3Don, If firmware/B=
IOS
-supports them. Currently Seabios for X86 system support it.
-limitation: The splash file could be a jpeg file or a BMP file in 24 BPP
-format(true color). The resolution should be supported by the SVGA mode,=
 so
-the recommended is 320x240, 640x480, 800x640.
-
-A timeout could be passed to bios, guest will pause for @var{rb_timeout}=
 ms
-when boot failed, then reboot. If @var{rb_timeout} is '-1', guest will n=
ot
-reboot, qemu passes '-1' to bios by default. Currently Seabios for X86
-system support it.
-
-Do strict boot via @option{strict=3Don} as far as firmware/BIOS
-supports it. This only effects when boot priority is changed by
-bootindex options. The default is non-strict boot.
-
-@example
-# try to boot from network first, then from hard disk
-qemu-system-i386 -boot order=3Dnc
-# boot from CD-ROM first, switch back to default order after reboot
-qemu-system-i386 -boot once=3Dd
-# boot with a splash picture for 5 seconds.
-qemu-system-i386 -boot menu=3Don,splash=3D/root/boot.bmp,splash-time=3D5=
000
-@end example
-
-Note: The legacy format '-boot @var{drives}' is still supported but its
-use is discouraged as it may be removed from future versions.
-ETEXI
-
-DEF("m", HAS_ARG, QEMU_OPTION_m,
-    "-m [size=3D]megs[,slots=3Dn,maxmem=3Dsize]\n"
-    "                configure guest RAM\n"
-    "                size: initial amount of guest memory\n"
-    "                slots: number of hotplug slots (default: none)\n"
-    "                maxmem: maximum amount of guest memory (default: no=
ne)\n"
-    "NOTE: Some architectures might enforce a specific granularity\n",
-    QEMU_ARCH_ALL)
-STEXI
-@item -m [size=3D]@var{megs}[,slots=3Dn,maxmem=3Dsize]
-@findex -m
-Sets guest startup RAM size to @var{megs} megabytes. Default is 128 MiB.
-Optionally, a suffix of ``M'' or ``G'' can be used to signify a value in
-megabytes or gigabytes respectively. Optional pair @var{slots}, @var{max=
mem}
-could be used to set amount of hotpluggable memory slots and maximum amo=
unt of
-memory. Note that @var{maxmem} must be aligned to the page size.
-
-For example, the following command-line sets the guest startup RAM size =
to
-1GB, creates 3 slots to hotplug additional memory and sets the maximum
-memory the guest can reach to 4GB:
-
-@example
-qemu-system-x86_64 -m 1G,slots=3D3,maxmem=3D4G
-@end example
-
-If @var{slots} and @var{maxmem} are not specified, memory hotplug won't
-be enabled and the guest startup RAM will never increase.
-ETEXI
-
-DEF("mem-path", HAS_ARG, QEMU_OPTION_mempath,
-    "-mem-path FILE  provide backing storage for guest RAM\n", QEMU_ARCH=
_ALL)
-STEXI
-@item -mem-path @var{path}
-@findex -mem-path
-Allocate guest RAM from a temporarily created file in @var{path}.
-ETEXI
-
-DEF("mem-prealloc", 0, QEMU_OPTION_mem_prealloc,
-    "-mem-prealloc   preallocate guest memory (use with -mem-path)\n",
-    QEMU_ARCH_ALL)
-STEXI
-@item -mem-prealloc
-@findex -mem-prealloc
-Preallocate memory when using -mem-path.
-ETEXI
-
-DEF("k", HAS_ARG, QEMU_OPTION_k,
-    "-k language     use keyboard layout (for example 'fr' for French)\n=
",
-    QEMU_ARCH_ALL)
-STEXI
-@item -k @var{language}
-@findex -k
-Use keyboard layout @var{language} (for example @code{fr} for
-French). This option is only needed where it is not easy to get raw PC
-keycodes (e.g. on Macs, with some X11 servers or with a VNC or curses
-display). You don't normally need to use it on PC/Linux or PC/Windows
-hosts.
-
-The available layouts are:
-@example
-ar  de-ch  es  fo     fr-ca  hu  ja  mk     no  pt-br  sv
-da  en-gb  et  fr     fr-ch  is  lt  nl     pl  ru     th
-de  en-us  fi  fr-be  hr     it  lv  nl-be  pt  sl     tr
-@end example
-
-The default is @code{en-us}.
-ETEXI
-
-
-DEF("audio-help", 0, QEMU_OPTION_audio_help,
-    "-audio-help     print list of audio drivers and their options\n",
-    QEMU_ARCH_ALL)
-STEXI
-@item -audio-help
-@findex -audio-help
-Will show the audio subsystem help: list of drivers, tunable
-parameters.
-ETEXI
-
-DEF("soundhw", HAS_ARG, QEMU_OPTION_soundhw,
-    "-soundhw c1,... enable audio support\n"
-    "                and only specified sound cards (comma separated lis=
t)\n"
-    "                use '-soundhw help' to get the list of supported ca=
rds\n"
-    "                use '-soundhw all' to enable all of them\n", QEMU_A=
RCH_ALL)
-STEXI
-@item -soundhw @var{card1}[,@var{card2},...] or -soundhw all
-@findex -soundhw
-Enable audio and selected sound hardware. Use 'help' to print all
-available sound hardware.
-
-@example
-qemu-system-i386 -soundhw sb16,adlib disk.img
-qemu-system-i386 -soundhw es1370 disk.img
-qemu-system-i386 -soundhw ac97 disk.img
-qemu-system-i386 -soundhw hda disk.img
-qemu-system-i386 -soundhw all disk.img
-qemu-system-i386 -soundhw help
-@end example
-
-Note that Linux's i810_audio OSS kernel (for AC97) module might
-require manually specifying clocking.
-
-@example
-modprobe i810_audio clocking=3D48000
-@end example
-ETEXI
-
-DEF("balloon", HAS_ARG, QEMU_OPTION_balloon,
-    "-balloon none   disable balloon device\n"
-    "-balloon virtio[,addr=3Dstr]\n"
-    "                enable virtio balloon device (default)\n", QEMU_ARC=
H_ALL)
-STEXI
-@item -balloon none
-@findex -balloon
-Disable balloon device.
-@item -balloon virtio[,addr=3D@var{addr}]
-Enable virtio balloon device (default), optionally with PCI address
-@var{addr}.
-ETEXI
-
-DEF("device", HAS_ARG, QEMU_OPTION_device,
-    "-device driver[,prop[=3Dvalue][,...]]\n"
-    "                add device (based on driver)\n"
-    "                prop=3Dvalue,... sets driver properties\n"
-    "                use '-device help' to print all possible drivers\n"
-    "                use '-device driver,help' to print all possible pro=
perties\n",
-    QEMU_ARCH_ALL)
-STEXI
-@item -device @var{driver}[,@var{prop}[=3D@var{value}][,...]]
-@findex -device
-Add device @var{driver}.  @var{prop}=3D@var{value} sets driver
-properties.  Valid properties depend on the driver.  To get help on
-possible drivers and properties, use @code{-device help} and
-@code{-device @var{driver},help}.
-
-Some drivers are:
-@item -device ipmi-bmc-sim,id=3D@var{id}[,slave_addr=3D@var{val}][,sdrfi=
le=3D@var{file}][,furareasize=3D@var{val}][,furdatafile=3D@var{file}]
-
-Add an IPMI BMC.  This is a simulation of a hardware management
-interface processor that normally sits on a system.  It provides
-a watchdog and the ability to reset and power control the system.
-You need to connect this to an IPMI interface to make it useful
-
-The IPMI slave address to use for the BMC.  The default is 0x20.
-This address is the BMC's address on the I2C network of management
-controllers.  If you don't know what this means, it is safe to ignore
-it.
-
-@table @option
-@item bmc=3D@var{id}
-The BMC to connect to, one of ipmi-bmc-sim or ipmi-bmc-extern above.
-@item slave_addr=3D@var{val}
-Define slave address to use for the BMC.  The default is 0x20.
-@item sdrfile=3D@var{file}
-file containing raw Sensor Data Records (SDR) data. The default is none.
-@item fruareasize=3D@var{val}
-size of a Field Replaceable Unit (FRU) area.  The default is 1024.
-@item frudatafile=3D@var{file}
-file containing raw Field Replaceable Unit (FRU) inventory data. The def=
ault is none.
-@end table
-
-@item -device ipmi-bmc-extern,id=3D@var{id},chardev=3D@var{id}[,slave_ad=
dr=3D@var{val}]
-
-Add a connection to an external IPMI BMC simulator.  Instead of
-locally emulating the BMC like the above item, instead connect
-to an external entity that provides the IPMI services.
-
-A connection is made to an external BMC simulator.  If you do this, it
-is strongly recommended that you use the "reconnect=3D" chardev option
-to reconnect to the simulator if the connection is lost.  Note that if
-this is not used carefully, it can be a security issue, as the
-interface has the ability to send resets, NMIs, and power off the VM.
-It's best if QEMU makes a connection to an external simulator running
-on a secure port on localhost, so neither the simulator nor QEMU is
-exposed to any outside network.
-
-See the "lanserv/README.vm" file in the OpenIPMI library for more
-details on the external interface.
-
-@item -device isa-ipmi-kcs,bmc=3D@var{id}[,ioport=3D@var{val}][,irq=3D@v=
ar{val}]
-
-Add a KCS IPMI interafce on the ISA bus.  This also adds a
-corresponding ACPI and SMBIOS entries, if appropriate.
-
-@table @option
-@item bmc=3D@var{id}
-The BMC to connect to, one of ipmi-bmc-sim or ipmi-bmc-extern above.
-@item ioport=3D@var{val}
-Define the I/O address of the interface.  The default is 0xca0 for KCS.
-@item irq=3D@var{val}
-Define the interrupt to use.  The default is 5.  To disable interrupts,
-set this to 0.
-@end table
-
-@item -device isa-ipmi-bt,bmc=3D@var{id}[,ioport=3D@var{val}][,irq=3D@va=
r{val}]
-
-Like the KCS interface, but defines a BT interface.  The default port is
-0xe4 and the default interrupt is 5.
-
-ETEXI
-
-DEF("name", HAS_ARG, QEMU_OPTION_name,
-    "-name string1[,process=3Dstring2][,debug-threads=3Don|off]\n"
-    "                set the name of the guest\n"
-    "                string1 sets the window title and string2 the proce=
ss name (on Linux)\n"
-    "                When debug-threads is enabled, individual threads a=
re given a separate name (on Linux)\n"
-    "                NOTE: The thread names are for debugging and not a =
stable API.\n",
-    QEMU_ARCH_ALL)
-STEXI
-@item -name @var{name}
-@findex -name
-Sets the @var{name} of the guest.
-This name will be displayed in the SDL window caption.
-The @var{name} will also be used for the VNC server.
-Also optionally set the top visible process name in Linux.
-Naming of individual threads can also be enabled on Linux to aid debuggi=
ng.
-ETEXI
-
-DEF("uuid", HAS_ARG, QEMU_OPTION_uuid,
-    "-uuid %08x-%04x-%04x-%04x-%012x\n"
-    "                specify machine UUID\n", QEMU_ARCH_ALL)
-STEXI
-@item -uuid @var{uuid}
-@findex -uuid
-Set system UUID.
-ETEXI
-
-STEXI
-@end table
-ETEXI
-DEFHEADING()
-
-DEFHEADING(Block device options:)
-STEXI
-@table @option
-ETEXI
-
-DEF("fda", HAS_ARG, QEMU_OPTION_fda,
-    "-fda/-fdb file  use 'file' as floppy disk 0/1 image\n", QEMU_ARCH_A=
LL)
-DEF("fdb", HAS_ARG, QEMU_OPTION_fdb, "", QEMU_ARCH_ALL)
-STEXI
-@item -fda @var{file}
-@itemx -fdb @var{file}
-@findex -fda
-@findex -fdb
-Use @var{file} as floppy disk 0/1 image (@pxref{disk_images}).
-ETEXI
-
-DEF("hda", HAS_ARG, QEMU_OPTION_hda,
-    "-hda/-hdb file  use 'file' as IDE hard disk 0/1 image\n", QEMU_ARCH=
_ALL)
-DEF("hdb", HAS_ARG, QEMU_OPTION_hdb, "", QEMU_ARCH_ALL)
-DEF("hdc", HAS_ARG, QEMU_OPTION_hdc,
-    "-hdc/-hdd file  use 'file' as IDE hard disk 2/3 image\n", QEMU_ARCH=
_ALL)
-DEF("hdd", HAS_ARG, QEMU_OPTION_hdd, "", QEMU_ARCH_ALL)
-STEXI
-@item -hda @var{file}
-@itemx -hdb @var{file}
-@itemx -hdc @var{file}
-@itemx -hdd @var{file}
-@findex -hda
-@findex -hdb
-@findex -hdc
-@findex -hdd
-Use @var{file} as hard disk 0, 1, 2 or 3 image (@pxref{disk_images}).
-ETEXI
-
-DEF("cdrom", HAS_ARG, QEMU_OPTION_cdrom,
-    "-cdrom file     use 'file' as IDE cdrom image (cdrom is ide1 master=
)\n",
-    QEMU_ARCH_ALL)
-STEXI
-@item -cdrom @var{file}
-@findex -cdrom
-Use @var{file} as CD-ROM image (you cannot use @option{-hdc} and
-@option{-cdrom} at the same time). You can use the host CD-ROM by
-using @file{/dev/cdrom} as filename (@pxref{host_drives}).
-ETEXI
-
-DEF("blockdev", HAS_ARG, QEMU_OPTION_blockdev,
-    "-blockdev [driver=3D]driver[,node-name=3DN][,discard=3Dignore|unmap=
]\n"
-    "          [,cache.direct=3Don|off][,cache.no-flush=3Don|off]\n"
-    "          [,read-only=3Don|off][,detect-zeroes=3Don|off|unmap]\n"
-    "          [,driver specific parameters...]\n"
-    "                configure a block backend\n", QEMU_ARCH_ALL)
-STEXI
-@item -blockdev @var{option}[,@var{option}[,@var{option}[,...]]]
-@findex -blockdev
-
-Define a new block driver node. Some of the options apply to all block d=
rivers,
-other options are only accepted for a specific block driver. See below f=
or a
-list of generic options and options for the most common block drivers.
-
-Options that expect a reference to another node (e.g. @code{file}) can b=
e
-given in two ways. Either you specify the node name of an already existi=
ng node
-(file=3D@var{node-name}), or you define a new node inline, adding option=
s
-for the referenced node after a dot (file.filename=3D@var{path},file.aio=
=3Dnative).
-
-A block driver node created with @option{-blockdev} can be used for a gu=
est
-device by specifying its node name for the @code{drive} property in a
-@option{-device} argument that defines a block device.
-
-@table @option
-@item Valid options for any block driver node:
-
-@table @code
-@item driver
-Specifies the block driver to use for the given node.
-@item node-name
-This defines the name of the block driver node by which it will be refer=
enced
-later. The name must be unique, i.e. it must not match the name of a dif=
ferent
-block driver node, or (if you use @option{-drive} as well) the ID of a d=
rive.
-
-If no node name is specified, it is automatically generated. The generat=
ed node
-name is not intended to be predictable and changes between QEMU invocati=
ons.
-For the top level, an explicit node name must be specified.
-@item read-only
-Open the node read-only. Guest write attempts will fail.
-@item cache.direct
-The host page cache can be avoided with @option{cache.direct=3Don}. This=
 will
-attempt to do disk IO directly to the guest's memory. QEMU may still per=
form an
-internal copy of the data.
-@item cache.no-flush
-In case you don't care about data integrity over host failures, you can =
use
-@option{cache.no-flush=3Don}. This option tells QEMU that it never needs=
 to write
-any data to the disk but can instead keep things in cache. If anything g=
oes
-wrong, like your host losing power, the disk storage getting disconnecte=
d
-accidentally, etc. your image will most probably be rendered unusable.
-@item discard=3D@var{discard}
-@var{discard} is one of "ignore" (or "off") or "unmap" (or "on") and con=
trols
-whether @code{discard} (also known as @code{trim} or @code{unmap}) reque=
sts are
-ignored or passed to the filesystem. Some machine types may not support
-discard requests.
-@item detect-zeroes=3D@var{detect-zeroes}
-@var{detect-zeroes} is "off", "on" or "unmap" and enables the automatic
-conversion of plain zero writes by the OS to driver specific optimized
-zero write commands. You may even choose "unmap" if @var{discard} is set
-to "unmap" to allow a zero write to be converted to an @code{unmap} oper=
ation.
-@end table
-
-@item Driver-specific options for @code{file}
-
-This is the protocol-level block driver for accessing regular files.
-
-@table @code
-@item filename
-The path to the image file in the local filesystem
-@item aio
-Specifies the AIO backend (threads/native, default: threads)
-@end table
-Example:
-@example
--blockdev driver=3Dfile,node-name=3Ddisk,filename=3Ddisk.img
-@end example
-
-@item Driver-specific options for @code{raw}
-
-This is the image format block driver for raw images. It is usually
-stacked on top of a protocol level block driver such as @code{file}.
-
-@table @code
-@item file
-Reference to or definition of the data source block driver node
-(e.g. a @code{file} driver node)
-@end table
-Example 1:
-@example
--blockdev driver=3Dfile,node-name=3Ddisk_file,filename=3Ddisk.img
--blockdev driver=3Draw,node-name=3Ddisk,file=3Ddisk_file
-@end example
-Example 2:
-@example
--blockdev driver=3Draw,node-name=3Ddisk,file.driver=3Dfile,file.filename=
=3Ddisk.img
-@end example
-
-@item Driver-specific options for @code{qcow2}
-
-This is the image format block driver for qcow2 images. It is usually
-stacked on top of a protocol level block driver such as @code{file}.
-
-@table @code
-@item file
-Reference to or definition of the data source block driver node
-(e.g. a @code{file} driver node)
-
-@item backing
-Reference to or definition of the backing file block device (default is =
taken
-from the image file). It is allowed to pass an empty string here in orde=
r to
-disable the default backing file.
-
-@item lazy-refcounts
-Whether to enable the lazy refcounts feature (on/off; default is taken f=
rom the
-image file)
-
-@item cache-size
-The maximum total size of the L2 table and refcount block caches in byte=
s
-(default: 1048576 bytes or 8 clusters, whichever is larger)
-
-@item l2-cache-size
-The maximum size of the L2 table cache in bytes
-(default: 4/5 of the total cache size)
-
-@item refcount-cache-size
-The maximum size of the refcount block cache in bytes
-(default: 1/5 of the total cache size)
-
-@item cache-clean-interval
-Clean unused entries in the L2 and refcount caches. The interval is in s=
econds.
-The default value is 0 and it disables this feature.
-
-@item pass-discard-request
-Whether discard requests to the qcow2 device should be forwarded to the =
data
-source (on/off; default: on if discard=3Dunmap is specified, off otherwi=
se)
-
-@item pass-discard-snapshot
-Whether discard requests for the data source should be issued when a sna=
pshot
-operation (e.g. deleting a snapshot) frees clusters in the qcow2 file (o=
n/off;
-default: on)
-
-@item pass-discard-other
-Whether discard requests for the data source should be issued on other
-occasions where a cluster gets freed (on/off; default: off)
-
-@item overlap-check
-Which overlap checks to perform for writes to the image
-(none/constant/cached/all; default: cached). For details or finer
-granularity control refer to the QAPI documentation of @code{blockdev-ad=
d}.
-@end table
-
-Example 1:
-@example
--blockdev driver=3Dfile,node-name=3Dmy_file,filename=3D/tmp/disk.qcow2
--blockdev driver=3Dqcow2,node-name=3Dhda,file=3Dmy_file,overlap-check=3D=
none,cache-size=3D16777216
-@end example
-Example 2:
-@example
--blockdev driver=3Dqcow2,node-name=3Ddisk,file.driver=3Dhttp,file.filena=
me=3Dhttp://example.com/image.qcow2
-@end example
-
-@item Driver-specific options for other drivers
-Please refer to the QAPI documentation of the @code{blockdev-add} QMP co=
mmand.
-
-@end table
-
-ETEXI
-
-DEF("drive", HAS_ARG, QEMU_OPTION_drive,
-    "-drive [file=3Dfile][,if=3Dtype][,bus=3Dn][,unit=3Dm][,media=3Dd][,=
index=3Di]\n"
-    "       [,cyls=3Dc,heads=3Dh,secs=3Ds[,trans=3Dt]][,snapshot=3Don|of=
f]\n"
-    "       [,cache=3Dwritethrough|writeback|none|directsync|unsafe][,fo=
rmat=3Df]\n"
-    "       [,serial=3Ds][,addr=3DA][,rerror=3Dignore|stop|report]\n"
-    "       [,werror=3Dignore|stop|report|enospc][,id=3Dname][,aio=3Dthr=
eads|native]\n"
-    "       [,readonly=3Don|off][,copy-on-read=3Don|off]\n"
-    "       [,discard=3Dignore|unmap][,detect-zeroes=3Don|off|unmap]\n"
-    "       [[,bps=3Db]|[[,bps_rd=3Dr][,bps_wr=3Dw]]]\n"
-    "       [[,iops=3Di]|[[,iops_rd=3Dr][,iops_wr=3Dw]]]\n"
-    "       [[,bps_max=3Dbm]|[[,bps_rd_max=3Drm][,bps_wr_max=3Dwm]]]\n"
-    "       [[,iops_max=3Dim]|[[,iops_rd_max=3Dirm][,iops_wr_max=3Diwm]]=
]\n"
-    "       [[,iops_size=3Dis]]\n"
-    "       [[,group=3Dg]]\n"
-    "                use 'file' as a drive image\n", QEMU_ARCH_ALL)
-STEXI
-@item -drive @var{option}[,@var{option}[,@var{option}[,...]]]
-@findex -drive
-
-Define a new drive. This includes creating a block driver node (the back=
end) as
-well as a guest device, and is mostly a shortcut for defining the corres=
ponding
-@option{-blockdev} and @option{-device} options.
-
-@option{-drive} accepts all options that are accepted by @option{-blockd=
ev}. In
-addition, it knows the following options:
-
-@table @option
-@item file=3D@var{file}
-This option defines which disk image (@pxref{disk_images}) to use with
-this drive. If the filename contains comma, you must double it
-(for instance, "file=3Dmy,,file" to use file "my,file").
-
-Special files such as iSCSI devices can be specified using protocol
-specific URLs. See the section for "Device URL Syntax" for more informat=
ion.
-@item if=3D@var{interface}
-This option defines on which type on interface the drive is connected.
-Available types are: ide, scsi, sd, mtd, floppy, pflash, virtio, none.
-@item bus=3D@var{bus},unit=3D@var{unit}
-These options define where is connected the drive by defining the bus nu=
mber and
-the unit id.
-@item index=3D@var{index}
-This option defines where is connected the drive by using an index in th=
e list
-of available connectors of a given interface type.
-@item media=3D@var{media}
-This option defines the type of the media: disk or cdrom.
-@item cyls=3D@var{c},heads=3D@var{h},secs=3D@var{s}[,trans=3D@var{t}]
-These options have the same definition as they have in @option{-hdachs}.
-These parameters are deprecated, use the corresponding parameters
-of @code{-device} instead.
-@item snapshot=3D@var{snapshot}
-@var{snapshot} is "on" or "off" and controls snapshot mode for the given=
 drive
-(see @option{-snapshot}).
-@item cache=3D@var{cache}
-@var{cache} is "none", "writeback", "unsafe", "directsync" or "writethro=
ugh"
-and controls how the host cache is used to access block data. This is a
-shortcut that sets the @option{cache.direct} and @option{cache.no-flush}
-options (as in @option{-blockdev}), and additionally @option{cache.write=
back},
-which provides a default for the @option{write-cache} option of block gu=
est
-devices (as in @option{-device}). The modes correspond to the following
-settings:
-
-@c Our texi2pod.pl script doesn't support @multitable, so fall back to u=
sing
-@c plain ASCII art (well, UTF-8 art really). This looks okay both in the=
 manpage
-@c and the HTML output.
-@example
-@             =E2=94=82 cache.writeback   cache.direct   cache.no-flush
-=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=BC=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80
-writeback    =E2=94=82 on                off            off
-none         =E2=94=82 on                on             off
-writethrough =E2=94=82 off               off            off
-directsync   =E2=94=82 off               on             off
-unsafe       =E2=94=82 on                off            on
-@end example
-
-The default mode is @option{cache=3Dwriteback}.
-
-@item aio=3D@var{aio}
-@var{aio} is "threads", or "native" and selects between pthread based di=
sk I/O and native Linux AIO.
-@item format=3D@var{format}
-Specify which disk @var{format} will be used rather than detecting
-the format.  Can be used to specify format=3Draw to avoid interpreting
-an untrusted format header.
-@item serial=3D@var{serial}
-This option specifies the serial number to assign to the device. This
-parameter is deprecated, use the corresponding parameter of @code{-devic=
e}
-instead.
-@item addr=3D@var{addr}
-Specify the controller's PCI address (if=3Dvirtio only). This parameter =
is
-deprecated, use the corresponding parameter of @code{-device} instead.
-@item werror=3D@var{action},rerror=3D@var{action}
-Specify which @var{action} to take on write and read errors. Valid actio=
ns are:
-"ignore" (ignore the error and try to continue), "stop" (pause QEMU),
-"report" (report the error to the guest), "enospc" (pause QEMU only if t=
he
-host disk is full; report the error to the guest otherwise).
-The default setting is @option{werror=3Denospc} and @option{rerror=3Drep=
ort}.
-@item copy-on-read=3D@var{copy-on-read}
-@var{copy-on-read} is "on" or "off" and enables whether to copy read bac=
king
-file sectors into the image file.
-@item bps=3D@var{b},bps_rd=3D@var{r},bps_wr=3D@var{w}
-Specify bandwidth throttling limits in bytes per second, either for all =
request
-types or for reads or writes only.  Small values can lead to timeouts or=
 hangs
-inside the guest.  A safe minimum for disks is 2 MB/s.
-@item bps_max=3D@var{bm},bps_rd_max=3D@var{rm},bps_wr_max=3D@var{wm}
-Specify bursts in bytes per second, either for all request types or for =
reads
-or writes only.  Bursts allow the guest I/O to spike above the limit
-temporarily.
-@item iops=3D@var{i},iops_rd=3D@var{r},iops_wr=3D@var{w}
-Specify request rate limits in requests per second, either for all reque=
st
-types or for reads or writes only.
-@item iops_max=3D@var{bm},iops_rd_max=3D@var{rm},iops_wr_max=3D@var{wm}
-Specify bursts in requests per second, either for all request types or f=
or reads
-or writes only.  Bursts allow the guest I/O to spike above the limit
-temporarily.
-@item iops_size=3D@var{is}
-Let every @var{is} bytes of a request count as a new request for iops
-throttling purposes.  Use this option to prevent guests from circumventi=
ng iops
-limits by sending fewer but larger requests.
-@item group=3D@var{g}
-Join a throttling quota group with given name @var{g}.  All drives that =
are
-members of the same group are accounted for together.  Use this option t=
o
-prevent guests from circumventing throttling limits by using many small =
disks
-instead of a single larger disk.
-@end table
-
-By default, the @option{cache.writeback=3Don} mode is used. It will repo=
rt data
-writes as completed as soon as the data is present in the host page cach=
e.
-This is safe as long as your guest OS makes sure to correctly flush disk=
 caches
-where needed. If your guest OS does not handle volatile disk write cache=
s
-correctly and your host crashes or loses power, then the guest may exper=
ience
-data corruption.
-
-For such guests, you should consider using @option{cache.writeback=3Doff=
}. This
-means that the host page cache will be used to read and write data, but =
write
-notification will be sent to the guest only after QEMU has made sure to =
flush
-each write to the disk. Be aware that this has a major impact on perform=
ance.
-
-When using the @option{-snapshot} option, unsafe caching is always used.
-
-Copy-on-read avoids accessing the same backing file sectors repeatedly a=
nd is
-useful when the backing file is over a slow network.  By default copy-on=
-read
-is off.
-
-Instead of @option{-cdrom} you can use:
-@example
-qemu-system-i386 -drive file=3Dfile,index=3D2,media=3Dcdrom
-@end example
-
-Instead of @option{-hda}, @option{-hdb}, @option{-hdc}, @option{-hdd}, y=
ou can
-use:
-@example
-qemu-system-i386 -drive file=3Dfile,index=3D0,media=3Ddisk
-qemu-system-i386 -drive file=3Dfile,index=3D1,media=3Ddisk
-qemu-system-i386 -drive file=3Dfile,index=3D2,media=3Ddisk
-qemu-system-i386 -drive file=3Dfile,index=3D3,media=3Ddisk
-@end example
-
-You can open an image using pre-opened file descriptors from an fd set:
-@example
-qemu-system-i386
--add-fd fd=3D3,set=3D2,opaque=3D"rdwr:/path/to/file"
--add-fd fd=3D4,set=3D2,opaque=3D"rdonly:/path/to/file"
--drive file=3D/dev/fdset/2,index=3D0,media=3Ddisk
-@end example
-
-You can connect a CDROM to the slave of ide0:
-@example
-qemu-system-i386 -drive file=3Dfile,if=3Dide,index=3D1,media=3Dcdrom
-@end example
-
-If you don't specify the "file=3D" argument, you define an empty drive:
-@example
-qemu-system-i386 -drive if=3Dide,index=3D1,media=3Dcdrom
-@end example
-
-Instead of @option{-fda}, @option{-fdb}, you can use:
-@example
-qemu-system-i386 -drive file=3Dfile,index=3D0,if=3Dfloppy
-qemu-system-i386 -drive file=3Dfile,index=3D1,if=3Dfloppy
-@end example
-
-By default, @var{interface} is "ide" and @var{index} is automatically
-incremented:
-@example
-qemu-system-i386 -drive file=3Da -drive file=3Db"
-@end example
-is interpreted like:
-@example
-qemu-system-i386 -hda a -hdb b
-@end example
-ETEXI
-
-DEF("mtdblock", HAS_ARG, QEMU_OPTION_mtdblock,
-    "-mtdblock file  use 'file' as on-board Flash memory image\n",
-    QEMU_ARCH_ALL)
-STEXI
-@item -mtdblock @var{file}
-@findex -mtdblock
-Use @var{file} as on-board Flash memory image.
-ETEXI
-
-DEF("sd", HAS_ARG, QEMU_OPTION_sd,
-    "-sd file        use 'file' as SecureDigital card image\n", QEMU_ARC=
H_ALL)
-STEXI
-@item -sd @var{file}
-@findex -sd
-Use @var{file} as SecureDigital card image.
-ETEXI
-
-DEF("pflash", HAS_ARG, QEMU_OPTION_pflash,
-    "-pflash file    use 'file' as a parallel flash image\n", QEMU_ARCH_=
ALL)
-STEXI
-@item -pflash @var{file}
-@findex -pflash
-Use @var{file} as a parallel flash image.
-ETEXI
-
-DEF("snapshot", 0, QEMU_OPTION_snapshot,
-    "-snapshot       write to temporary files instead of disk image file=
s\n",
-    QEMU_ARCH_ALL)
-STEXI
-@item -snapshot
-@findex -snapshot
-Write to temporary files instead of disk image files. In this case,
-the raw disk image you use is not written back. You can however force
-the write back by pressing @key{C-a s} (@pxref{disk_images}).
-ETEXI
-
-DEF("hdachs", HAS_ARG, QEMU_OPTION_hdachs, \
-    "-hdachs c,h,s[,t]\n" \
-    "                force hard disk 0 physical geometry and the optiona=
l BIOS\n" \
-    "                translation (t=3Dnone or lba) (usually QEMU can gue=
ss them)\n",
-    QEMU_ARCH_ALL)
-STEXI
-@item -hdachs @var{c},@var{h},@var{s},[,@var{t}]
-@findex -hdachs
-Force hard disk 0 physical geometry (1 <=3D @var{c} <=3D 16383, 1 <=3D
-@var{h} <=3D 16, 1 <=3D @var{s} <=3D 63) and optionally force the BIOS
-translation mode (@var{t}=3Dnone, lba or auto). Usually QEMU can guess
-all those parameters. This option is deprecated, please use
-@code{-device ide-hd,cyls=3Dc,heads=3Dh,secs=3Ds,...} instead.
-ETEXI
-
-DEF("fsdev", HAS_ARG, QEMU_OPTION_fsdev,
-    "-fsdev fsdriver,id=3Did[,path=3Dpath,][security_model=3D{mapped-xat=
tr|mapped-file|passthrough|none}]\n"
-    " [,writeout=3Dimmediate][,readonly][,socket=3Dsocket|sock_fd=3Dsock=
_fd][,fmode=3Dfmode][,dmode=3Ddmode]\n"
-    " [[,throttling.bps-total=3Db]|[[,throttling.bps-read=3Dr][,throttli=
ng.bps-write=3Dw]]]\n"
-    " [[,throttling.iops-total=3Di]|[[,throttling.iops-read=3Dr][,thrott=
ling.iops-write=3Dw]]]\n"
-    " [[,throttling.bps-total-max=3Dbm]|[[,throttling.bps-read-max=3Drm]=
[,throttling.bps-write-max=3Dwm]]]\n"
-    " [[,throttling.iops-total-max=3Dim]|[[,throttling.iops-read-max=3Di=
rm][,throttling.iops-write-max=3Diwm]]]\n"
-    " [[,throttling.iops-size=3Dis]]\n",
-    QEMU_ARCH_ALL)
-
-STEXI
-
-@item -fsdev @var{fsdriver},id=3D@var{id},path=3D@var{path},[security_mo=
del=3D@var{security_model}][,writeout=3D@var{writeout}][,readonly][,socke=
t=3D@var{socket}|sock_fd=3D@var{sock_fd}][,fmode=3D@var{fmode}][,dmode=3D=
@var{dmode}]
-@findex -fsdev
-Define a new file system device. Valid options are:
-@table @option
-@item @var{fsdriver}
-This option specifies the fs driver backend to use.
-Currently "local", "handle" and "proxy" file system drivers are supporte=
d.
-@item id=3D@var{id}
-Specifies identifier for this device
-@item path=3D@var{path}
-Specifies the export path for the file system device. Files under
-this path will be available to the 9p client on the guest.
-@item security_model=3D@var{security_model}
-Specifies the security model to be used for this export path.
-Supported security models are "passthrough", "mapped-xattr", "mapped-fil=
e" and "none".
-In "passthrough" security model, files are stored using the same
-credentials as they are created on the guest. This requires QEMU
-to run as root. In "mapped-xattr" security model, some of the file
-attributes like uid, gid, mode bits and link target are stored as
-file attributes. For "mapped-file" these attributes are stored in the
-hidden .virtfs_metadata directory. Directories exported by this security=
 model cannot
-interact with other unix tools. "none" security model is same as
-passthrough except the sever won't report failures if it fails to
-set file attributes like ownership. Security model is mandatory
-only for local fsdriver. Other fsdrivers (like handle, proxy) don't take
-security model as a parameter.
-@item writeout=3D@var{writeout}
-This is an optional argument. The only supported value is "immediate".
-This means that host page cache will be used to read and write data but
-write notification will be sent to the guest only when the data has been
-reported as written by the storage subsystem.
-@item readonly
-Enables exporting 9p share as a readonly mount for guests. By default
-read-write access is given.
-@item socket=3D@var{socket}
-Enables proxy filesystem driver to use passed socket file for communicat=
ing
-with virtfs-proxy-helper
-@item sock_fd=3D@var{sock_fd}
-Enables proxy filesystem driver to use passed socket descriptor for
-communicating with virtfs-proxy-helper. Usually a helper like libvirt
-will create socketpair and pass one of the fds as sock_fd
-@item fmode=3D@var{fmode}
-Specifies the default mode for newly created files on the host. Works on=
ly
-with security models "mapped-xattr" and "mapped-file".
-@item dmode=3D@var{dmode}
-Specifies the default mode for newly created directories on the host. Wo=
rks
-only with security models "mapped-xattr" and "mapped-file".
-@end table
-
--fsdev option is used along with -device driver "virtio-9p-pci".
-@item -device virtio-9p-pci,fsdev=3D@var{id},mount_tag=3D@var{mount_tag}
-Options for virtio-9p-pci driver are:
-@table @option
-@item fsdev=3D@var{id}
-Specifies the id value specified along with -fsdev option
-@item mount_tag=3D@var{mount_tag}
-Specifies the tag name to be used by the guest to mount this export poin=
t
-@end table
-
-ETEXI
-
-DEF("virtfs", HAS_ARG, QEMU_OPTION_virtfs,
-    "-virtfs local,path=3Dpath,mount_tag=3Dtag,security_model=3D[mapped-=
xattr|mapped-file|passthrough|none]\n"
-    "        [,id=3Did][,writeout=3Dimmediate][,readonly][,socket=3Dsock=
et|sock_fd=3Dsock_fd][,fmode=3Dfmode][,dmode=3Ddmode]\n",
-    QEMU_ARCH_ALL)
-
-STEXI
-
-@item -virtfs @var{fsdriver}[,path=3D@var{path}],mount_tag=3D@var{mount_=
tag}[,security_model=3D@var{security_model}][,writeout=3D@var{writeout}][=
,readonly][,socket=3D@var{socket}|sock_fd=3D@var{sock_fd}][,fmode=3D@var{=
fmode}][,dmode=3D@var{dmode}]
-@findex -virtfs
-
-The general form of a Virtual File system pass-through options are:
-@table @option
-@item @var{fsdriver}
-This option specifies the fs driver backend to use.
-Currently "local", "handle" and "proxy" file system drivers are supporte=
d.
-@item id=3D@var{id}
-Specifies identifier for this device
-@item path=3D@var{path}
-Specifies the export path for the file system device. Files under
-this path will be available to the 9p client on the guest.
-@item security_model=3D@var{security_model}
-Specifies the security model to be used for this export path.
-Supported security models are "passthrough", "mapped-xattr", "mapped-fil=
e" and "none".
-In "passthrough" security model, files are stored using the same
-credentials as they are created on the guest. This requires QEMU
-to run as root. In "mapped-xattr" security model, some of the file
-attributes like uid, gid, mode bits and link target are stored as
-file attributes. For "mapped-file" these attributes are stored in the
-hidden .virtfs_metadata directory. Directories exported by this security=
 model cannot
-interact with other unix tools. "none" security model is same as
-passthrough except the sever won't report failures if it fails to
-set file attributes like ownership. Security model is mandatory only
-for local fsdriver. Other fsdrivers (like handle, proxy) don't take secu=
rity
-model as a parameter.
-@item writeout=3D@var{writeout}
-This is an optional argument. The only supported value is "immediate".
-This means that host page cache will be used to read and write data but
-write notification will be sent to the guest only when the data has been
-reported as written by the storage subsystem.
-@item readonly
-Enables exporting 9p share as a readonly mount for guests. By default
-read-write access is given.
-@item socket=3D@var{socket}
-Enables proxy filesystem driver to use passed socket file for
-communicating with virtfs-proxy-helper. Usually a helper like libvirt
-will create socketpair and pass one of the fds as sock_fd
-@item sock_fd
-Enables proxy filesystem driver to use passed 'sock_fd' as the socket
-descriptor for interfacing with virtfs-proxy-helper
-@item fmode=3D@var{fmode}
-Specifies the default mode for newly created files on the host. Works on=
ly
-with security models "mapped-xattr" and "mapped-file".
-@item dmode=3D@var{dmode}
-Specifies the default mode for newly created directories on the host. Wo=
rks
-only with security models "mapped-xattr" and "mapped-file".
-@end table
-ETEXI
-
-DEF("virtfs_synth", 0, QEMU_OPTION_virtfs_synth,
-    "-virtfs_synth Create synthetic file system image\n",
-    QEMU_ARCH_ALL)
-STEXI
-@item -virtfs_synth
-@findex -virtfs_synth
-Create synthetic file system image
-ETEXI
-
-DEF("iscsi", HAS_ARG, QEMU_OPTION_iscsi,
-    "-iscsi [user=3Duser][,password=3Dpassword]\n"
-    "       [,header-digest=3DCRC32C|CR32C-NONE|NONE-CRC32C|NONE\n"
-    "       [,initiator-name=3Dinitiator-iqn][,id=3Dtarget-iqn]\n"
-    "       [,timeout=3Dtimeout]\n"
-    "                iSCSI session parameters\n", QEMU_ARCH_ALL)
-
-STEXI
-@item -iscsi
-@findex -iscsi
-Configure iSCSI session parameters.
-ETEXI
-
-STEXI
-@end table
-ETEXI
-DEFHEADING()
-
-DEFHEADING(USB options:)
-STEXI
-@table @option
-ETEXI
-
-DEF("usb", 0, QEMU_OPTION_usb,
-    "-usb            enable the USB driver (if it is not used by default=
 yet)\n",
-    QEMU_ARCH_ALL)
-STEXI
-@item -usb
-@findex -usb
-Enable the USB driver (if it is not used by default yet).
-ETEXI
-
-DEF("usbdevice", HAS_ARG, QEMU_OPTION_usbdevice,
-    "-usbdevice name add the host or guest USB device 'name'\n",
-    QEMU_ARCH_ALL)
-STEXI
-
-@item -usbdevice @var{devname}
-@findex -usbdevice
-Add the USB device @var{devname}. Note that this option is deprecated,
-please use @code{-device usb-...} instead. @xref{usb_devices}.
-
-@table @option
-
-@item mouse
-Virtual Mouse. This will override the PS/2 mouse emulation when activate=
d.
-
-@item tablet
-Pointer device that uses absolute coordinates (like a touchscreen). This
-means QEMU is able to report the mouse position without having to grab t=
he
-mouse. Also overrides the PS/2 mouse emulation when activated.
-
-@item disk:[format=3D@var{format}]:@var{file}
-Mass storage device based on file. The optional @var{format} argument
-will be used rather than detecting the format. Can be used to specify
-@code{format=3Draw} to avoid interpreting an untrusted format header.
-
-@item host:@var{bus}.@var{addr}
-Pass through the host device identified by @var{bus}.@var{addr} (Linux o=
nly).
-
-@item host:@var{vendor_id}:@var{product_id}
-Pass through the host device identified by @var{vendor_id}:@var{product_=
id}
-(Linux only).
-
-@item serial:[vendorid=3D@var{vendor_id}][,productid=3D@var{product_id}]=
:@var{dev}
-Serial converter to host character device @var{dev}, see @code{-serial} =
for the
-available devices.
-
-@item braille
-Braille device.  This will use BrlAPI to display the braille output on a=
 real
-or fake device.
-
-@item net:@var{options}
-Network adapter that supports CDC ethernet and RNDIS protocols.
-
-@end table
-ETEXI
-
-STEXI
-@end table
-ETEXI
-DEFHEADING()
-
-DEFHEADING(Display options:)
-STEXI
-@table @option
-ETEXI
-
-DEF("display", HAS_ARG, QEMU_OPTION_display,
-    "-display sdl[,frame=3Don|off][,alt_grab=3Don|off][,ctrl_grab=3Don|o=
ff]\n"
-    "            [,window_close=3Don|off][,gl=3Don|off]\n"
-    "-display gtk[,grab_on_hover=3Don|off][,gl=3Don|off]|\n"
-    "-display vnc=3D<display>[,<optargs>]\n"
-    "-display curses\n"
-    "-display none"
-    "                select display type\n"
-    "The default display is equivalent to\n"
-#if defined(CONFIG_GTK)
-            "\t\"-display gtk\"\n"
-#elif defined(CONFIG_SDL)
-            "\t\"-display sdl\"\n"
-#elif defined(CONFIG_COCOA)
-            "\t\"-display cocoa\"\n"
-#elif defined(CONFIG_VNC)
-            "\t\"-vnc localhost:0,to=3D99,id=3Ddefault\"\n"
-#else
-            "\t\"-display none\"\n"
-#endif
-    , QEMU_ARCH_ALL)
-STEXI
-@item -display @var{type}
-@findex -display
-Select type of display to use. This option is a replacement for the
-old style -sdl/-curses/... options. Valid values for @var{type} are
-@table @option
-@item sdl
-Display video output via SDL (usually in a separate graphics
-window; see the SDL documentation for other possibilities).
-@item curses
-Display video output via curses. For graphics device models which
-support a text mode, QEMU can display this output using a
-curses/ncurses interface. Nothing is displayed when the graphics
-device is in graphical mode or if the graphics device does not support
-a text mode. Generally only the VGA device models support text mode.
-@item none
-Do not display video output. The guest will still see an emulated
-graphics card, but its output will not be displayed to the QEMU
-user. This option differs from the -nographic option in that it
-only affects what is done with video output; -nographic also changes
-the destination of the serial and parallel port data.
-@item gtk
-Display video output in a GTK window. This interface provides drop-down
-menus and other UI elements to configure and control the VM during
-runtime.
-@item vnc
-Start a VNC server on display <arg>
-@end table
-ETEXI
-
-DEF("nographic", 0, QEMU_OPTION_nographic,
-    "-nographic      disable graphical output and redirect serial I/Os t=
o console\n",
-    QEMU_ARCH_ALL)
-STEXI
-@item -nographic
-@findex -nographic
-Normally, if QEMU is compiled with graphical window support, it displays
-output such as guest graphics, guest console, and the QEMU monitor in a
-window. With this option, you can totally disable graphical output so
-that QEMU is a simple command line application. The emulated serial port
-is redirected on the console and muxed with the monitor (unless
-redirected elsewhere explicitly). Therefore, you can still use QEMU to
-debug a Linux kernel with a serial console. Use @key{C-a h} for help on
-switching between the console and monitor.
-ETEXI
-
-DEF("curses", 0, QEMU_OPTION_curses,
-    "-curses         shorthand for -display curses\n",
-    QEMU_ARCH_ALL)
-STEXI
-@item -curses
-@findex -curses
-Normally, if QEMU is compiled with graphical window support, it displays
-output such as guest graphics, guest console, and the QEMU monitor in a
-window. With this option, QEMU can display the VGA output when in text
-mode using a curses/ncurses interface. Nothing is displayed in graphical
-mode.
-ETEXI
-
-DEF("no-frame", 0, QEMU_OPTION_no_frame,
-    "-no-frame       open SDL window without a frame and window decorati=
ons\n",
-    QEMU_ARCH_ALL)
-STEXI
-@item -no-frame
-@findex -no-frame
-Do not use decorations for SDL windows and start them using the whole
-available screen space. This makes the using QEMU in a dedicated desktop
-workspace more convenient.
-ETEXI
-
-DEF("alt-grab", 0, QEMU_OPTION_alt_grab,
-    "-alt-grab       use Ctrl-Alt-Shift to grab mouse (instead of Ctrl-A=
lt)\n",
-    QEMU_ARCH_ALL)
-STEXI
-@item -alt-grab
-@findex -alt-grab
-Use Ctrl-Alt-Shift to grab mouse (instead of Ctrl-Alt). Note that this a=
lso
-affects the special keys (for fullscreen, monitor-mode switching, etc).
-ETEXI
-
-DEF("ctrl-grab", 0, QEMU_OPTION_ctrl_grab,
-    "-ctrl-grab      use Right-Ctrl to grab mouse (instead of Ctrl-Alt)\=
n",
-    QEMU_ARCH_ALL)
-STEXI
-@item -ctrl-grab
-@findex -ctrl-grab
-Use Right-Ctrl to grab mouse (instead of Ctrl-Alt). Note that this also
-affects the special keys (for fullscreen, monitor-mode switching, etc).
-ETEXI
-
-DEF("no-quit", 0, QEMU_OPTION_no_quit,
-    "-no-quit        disable SDL window close capability\n", QEMU_ARCH_A=
LL)
-STEXI
-@item -no-quit
-@findex -no-quit
-Disable SDL window close capability.
-ETEXI
-
-DEF("sdl", 0, QEMU_OPTION_sdl,
-    "-sdl            shorthand for -display sdl\n", QEMU_ARCH_ALL)
-STEXI
-@item -sdl
-@findex -sdl
-Enable SDL.
-ETEXI
-
-DEF("spice", HAS_ARG, QEMU_OPTION_spice,
-    "-spice [port=3Dport][,tls-port=3Dsecured-port][,x509-dir=3D<dir>]\n=
"
-    "       [,x509-key-file=3D<file>][,x509-key-password=3D<file>]\n"
-    "       [,x509-cert-file=3D<file>][,x509-cacert-file=3D<file>]\n"
-    "       [,x509-dh-key-file=3D<file>][,addr=3Daddr][,ipv4|ipv6|unix]\=
n"
-    "       [,tls-ciphers=3D<list>]\n"
-    "       [,tls-channel=3D[main|display|cursor|inputs|record|playback]=
]\n"
-    "       [,plaintext-channel=3D[main|display|cursor|inputs|record|pla=
yback]]\n"
-    "       [,sasl][,password=3D<secret>][,disable-ticketing]\n"
-    "       [,image-compression=3D[auto_glz|auto_lz|quic|glz|lz|off]]\n"
-    "       [,jpeg-wan-compression=3D[auto|never|always]]\n"
-    "       [,zlib-glz-wan-compression=3D[auto|never|always]]\n"
-    "       [,streaming-video=3D[off|all|filter]][,disable-copy-paste]\n=
"
-    "       [,disable-agent-file-xfer][,agent-mouse=3D[on|off]]\n"
-    "       [,playback-compression=3D[on|off]][,seamless-migration=3D[on=
|off]]\n"
-    "       [,gl=3D[on|off]][,rendernode=3D<file>]\n"
-    "   enable spice\n"
-    "   at least one of {port, tls-port} is mandatory\n",
-    QEMU_ARCH_ALL)
-STEXI
-@item -spice @var{option}[,@var{option}[,...]]
-@findex -spice
-Enable the spice remote desktop protocol. Valid options are
-
-@table @option
-
-@item port=3D<nr>
-Set the TCP port spice is listening on for plaintext channels.
-
-@item addr=3D<addr>
-Set the IP address spice is listening on.  Default is any address.
-
-@item ipv4
-@itemx ipv6
-@itemx unix
-Force using the specified IP version.
-
-@item password=3D<secret>
-Set the password you need to authenticate.
-
-@item sasl
-Require that the client use SASL to authenticate with the spice.
-The exact choice of authentication method used is controlled from the
-system / user's SASL configuration file for the 'qemu' service. This
-is typically found in /etc/sasl2/qemu.conf. If running QEMU as an
-unprivileged user, an environment variable SASL_CONF_PATH can be used
-to make it search alternate locations for the service config.
-While some SASL auth methods can also provide data encryption (eg GSSAPI=
),
-it is recommended that SASL always be combined with the 'tls' and
-'x509' settings to enable use of SSL and server certificates. This
-ensures a data encryption preventing compromise of authentication
-credentials.
-
-@item disable-ticketing
-Allow client connects without authentication.
-
-@item disable-copy-paste
-Disable copy paste between the client and the guest.
-
-@item disable-agent-file-xfer
-Disable spice-vdagent based file-xfer between the client and the guest.
-
-@item tls-port=3D<nr>
-Set the TCP port spice is listening on for encrypted channels.
-
-@item x509-dir=3D<dir>
-Set the x509 file directory. Expects same filenames as -vnc $display,x50=
9=3D$dir
-
-@item x509-key-file=3D<file>
-@itemx x509-key-password=3D<file>
-@itemx x509-cert-file=3D<file>
-@itemx x509-cacert-file=3D<file>
-@itemx x509-dh-key-file=3D<file>
-The x509 file names can also be configured individually.
-
-@item tls-ciphers=3D<list>
-Specify which ciphers to use.
-
-@item tls-channel=3D[main|display|cursor|inputs|record|playback]
-@itemx plaintext-channel=3D[main|display|cursor|inputs|record|playback]
-Force specific channel to be used with or without TLS encryption.  The
-options can be specified multiple times to configure multiple
-channels.  The special name "default" can be used to set the default
-mode.  For channels which are not explicitly forced into one mode the
-spice client is allowed to pick tls/plaintext as he pleases.
-
-@item image-compression=3D[auto_glz|auto_lz|quic|glz|lz|off]
-Configure image compression (lossless).
-Default is auto_glz.
-
-@item jpeg-wan-compression=3D[auto|never|always]
-@itemx zlib-glz-wan-compression=3D[auto|never|always]
-Configure wan image compression (lossy for slow links).
-Default is auto.
-
-@item streaming-video=3D[off|all|filter]
-Configure video stream detection.  Default is off.
-
-@item agent-mouse=3D[on|off]
-Enable/disable passing mouse events via vdagent.  Default is on.
-
-@item playback-compression=3D[on|off]
-Enable/disable audio stream compression (using celt 0.5.1).  Default is =
on.
-
-@item seamless-migration=3D[on|off]
-Enable/disable spice seamless migration. Default is off.
-
-@item gl=3D[on|off]
-Enable/disable OpenGL context. Default is off.
-
-@item rendernode=3D<file>
-DRM render node for OpenGL rendering. If not specified, it will pick
-the first available. (Since 2.9)
-
-@end table
-ETEXI
-
-DEF("portrait", 0, QEMU_OPTION_portrait,
-    "-portrait       rotate graphical output 90 deg left (only PXA LCD)\=
n",
-    QEMU_ARCH_ALL)
-STEXI
-@item -portrait
-@findex -portrait
-Rotate graphical output 90 deg left (only PXA LCD).
-ETEXI
-
-DEF("rotate", HAS_ARG, QEMU_OPTION_rotate,
-    "-rotate <deg>   rotate graphical output some deg left (only PXA LCD=
)\n",
-    QEMU_ARCH_ALL)
-STEXI
-@item -rotate @var{deg}
-@findex -rotate
-Rotate graphical output some deg left (only PXA LCD).
-ETEXI
-
-DEF("vga", HAS_ARG, QEMU_OPTION_vga,
-    "-vga [std|cirrus|vmware|qxl|xenfb|tcx|cg3|virtio|none]\n"
-    "                select video card type\n", QEMU_ARCH_ALL)
-STEXI
-@item -vga @var{type}
-@findex -vga
-Select type of VGA card to emulate. Valid values for @var{type} are
-@table @option
-@item cirrus
-Cirrus Logic GD5446 Video card. All Windows versions starting from
-Windows 95 should recognize and use this graphic card. For optimal
-performances, use 16 bit color depth in the guest and the host OS.
-(This card was the default before QEMU 2.2)
-@item std
-Standard VGA card with Bochs VBE extensions.  If your guest OS
-supports the VESA 2.0 VBE extensions (e.g. Windows XP) and if you want
-to use high resolution modes (>=3D 1280x1024x16) then you should use
-this option. (This card is the default since QEMU 2.2)
-@item vmware
-VMWare SVGA-II compatible adapter. Use it if you have sufficiently
-recent XFree86/XOrg server or Windows guest with a driver for this
-card.
-@item qxl
-QXL paravirtual graphic card.  It is VGA compatible (including VESA
-2.0 VBE support).  Works best with qxl guest drivers installed though.
-Recommended choice when using the spice protocol.
-@item tcx
-(sun4m only) Sun TCX framebuffer. This is the default framebuffer for
-sun4m machines and offers both 8-bit and 24-bit colour depths at a
-fixed resolution of 1024x768.
-@item cg3
-(sun4m only) Sun cgthree framebuffer. This is a simple 8-bit framebuffer
-for sun4m machines available in both 1024x768 (OpenBIOS) and 1152x900 (O=
BP)
-resolutions aimed at people wishing to run older Solaris versions.
-@item virtio
-Virtio VGA card.
-@item none
-Disable VGA card.
-@end table
-ETEXI
-
-DEF("full-screen", 0, QEMU_OPTION_full_screen,
-    "-full-screen    start in full screen\n", QEMU_ARCH_ALL)
-STEXI
-@item -full-screen
-@findex -full-screen
-Start in full screen.
-ETEXI
-
-DEF("g", 1, QEMU_OPTION_g ,
-    "-g WxH[xDEPTH]  Set the initial graphical resolution and depth\n",
-    QEMU_ARCH_PPC | QEMU_ARCH_SPARC)
-STEXI
-@item -g @var{width}x@var{height}[x@var{depth}]
-@findex -g
-Set the initial graphical resolution and depth (PPC, SPARC only).
-ETEXI
-
-DEF("vnc", HAS_ARG, QEMU_OPTION_vnc ,
-    "-vnc <display>  shorthand for -display vnc=3D<display>\n", QEMU_ARC=
H_ALL)
-STEXI
-@item -vnc @var{display}[,@var{option}[,@var{option}[,...]]]
-@findex -vnc
-Normally, if QEMU is compiled with graphical window support, it displays
-output such as guest graphics, guest console, and the QEMU monitor in a
-window. With this option, you can have QEMU listen on VNC display
-@var{display} and redirect the VGA display over the VNC session. It is
-very useful to enable the usb tablet device when using this option
-(option @option{-device usb-tablet}). When using the VNC display, you
-must use the @option{-k} parameter to set the keyboard layout if you are
-not using en-us. Valid syntax for the @var{display} is
-
-@table @option
-
-@item to=3D@var{L}
-
-With this option, QEMU will try next available VNC @var{display}s, until=
 the
-number @var{L}, if the origianlly defined "-vnc @var{display}" is not
-available, e.g. port 5900+@var{display} is already used by another
-application. By default, to=3D0.
-
-@item @var{host}:@var{d}
-
-TCP connections will only be allowed from @var{host} on display @var{d}.
-By convention the TCP port is 5900+@var{d}. Optionally, @var{host} can
-be omitted in which case the server will accept connections from any hos=
t.
-
-@item unix:@var{path}
-
-Connections will be allowed over UNIX domain sockets where @var{path} is=
 the
-location of a unix socket to listen for connections on.
-
-@item none
-
-VNC is initialized but not started. The monitor @code{change} command
-can be used to later start the VNC server.
-
-@end table
-
-Following the @var{display} value there may be one or more @var{option} =
flags
-separated by commas. Valid options are
-
-@table @option
-
-@item reverse
-
-Connect to a listening VNC client via a ``reverse'' connection. The
-client is specified by the @var{display}. For reverse network
-connections (@var{host}:@var{d},@code{reverse}), the @var{d} argument
-is a TCP port number, not a display number.
-
-@item websocket
-
-Opens an additional TCP listening port dedicated to VNC Websocket connec=
tions.
-If a bare @var{websocket} option is given, the Websocket port is
-5700+@var{display}. An alternative port can be specified with the
-syntax @code{websocket}=3D@var{port}.
-
-If @var{host} is specified connections will only be allowed from this ho=
st.
-It is possible to control the websocket listen address independently, us=
ing
-the syntax @code{websocket}=3D@var{host}:@var{port}.
-
-If no TLS credentials are provided, the websocket connection runs in
-unencrypted mode. If TLS credentials are provided, the websocket connect=
ion
-requires encrypted client connections.
-
-@item password
-
-Require that password based authentication is used for client connection=
s.
-
-The password must be set separately using the @code{set_password} comman=
d in
-the @ref{pcsys_monitor}. The syntax to change your password is:
-@code{set_password <protocol> <password>} where <protocol> could be eith=
er
-"vnc" or "spice".
-
-If you would like to change <protocol> password expiration, you should u=
se
-@code{expire_password <protocol> <expiration-time>} where expiration tim=
e could
-be one of the following options: now, never, +seconds or UNIX time of
-expiration, e.g. +60 to make password expire in 60 seconds, or 133519680=
0
-to make password expire on "Mon Apr 23 12:00:00 EDT 2012" (UNIX time for=
 this
-date and time).
-
-You can also use keywords "now" or "never" for the expiration time to
-allow <protocol> password to expire immediately or never expire.
-
-@item tls-creds=3D@var{ID}
-
-Provides the ID of a set of TLS credentials to use to secure the
-VNC server. They will apply to both the normal VNC server socket
-and the websocket socket (if enabled). Setting TLS credentials
-will cause the VNC server socket to enable the VeNCrypt auth
-mechanism.  The credentials should have been previously created
-using the @option{-object tls-creds} argument.
-
-The @option{tls-creds} parameter obsoletes the @option{tls},
-@option{x509}, and @option{x509verify} options, and as such
-it is not permitted to set both new and old type options at
-the same time.
-
-@item tls
-
-Require that client use TLS when communicating with the VNC server. This
-uses anonymous TLS credentials so is susceptible to a man-in-the-middle
-attack. It is recommended that this option be combined with either the
-@option{x509} or @option{x509verify} options.
-
-This option is now deprecated in favor of using the @option{tls-creds}
-argument.
-
-@item x509=3D@var{/path/to/certificate/dir}
-
-Valid if @option{tls} is specified. Require that x509 credentials are us=
ed
-for negotiating the TLS session. The server will send its x509 certifica=
te
-to the client. It is recommended that a password be set on the VNC serve=
r
-to provide authentication of the client when this is used. The path foll=
owing
-this option specifies where the x509 certificates are to be loaded from.
-See the @ref{vnc_security} section for details on generating certificate=
s.
-
-This option is now deprecated in favour of using the @option{tls-creds}
-argument.
-
-@item x509verify=3D@var{/path/to/certificate/dir}
-
-Valid if @option{tls} is specified. Require that x509 credentials are us=
ed
-for negotiating the TLS session. The server will send its x509 certifica=
te
-to the client, and request that the client send its own x509 certificate=
.
-The server will validate the client's certificate against the CA certifi=
cate,
-and reject clients when validation fails. If the certificate authority i=
s
-trusted, this is a sufficient authentication mechanism. You may still wi=
sh
-to set a password on the VNC server as a second authentication layer. Th=
e
-path following this option specifies where the x509 certificates are to
-be loaded from. See the @ref{vnc_security} section for details on genera=
ting
-certificates.
-
-This option is now deprecated in favour of using the @option{tls-creds}
-argument.
-
-@item sasl
-
-Require that the client use SASL to authenticate with the VNC server.
-The exact choice of authentication method used is controlled from the
-system / user's SASL configuration file for the 'qemu' service. This
-is typically found in /etc/sasl2/qemu.conf. If running QEMU as an
-unprivileged user, an environment variable SASL_CONF_PATH can be used
-to make it search alternate locations for the service config.
-While some SASL auth methods can also provide data encryption (eg GSSAPI=
),
-it is recommended that SASL always be combined with the 'tls' and
-'x509' settings to enable use of SSL and server certificates. This
-ensures a data encryption preventing compromise of authentication
-credentials. See the @ref{vnc_security} section for details on using
-SASL authentication.
-
-@item acl
-
-Turn on access control lists for checking of the x509 client certificate
-and SASL party. For x509 certs, the ACL check is made against the
-certificate's distinguished name. This is something that looks like
-@code{C=3DGB,O=3DACME,L=3DBoston,CN=3Dbob}. For SASL party, the ACL chec=
k is
-made against the username, which depending on the SASL plugin, may
-include a realm component, eg @code{bob} or @code{bob@@EXAMPLE.COM}.
-When the @option{acl} flag is set, the initial access list will be
-empty, with a @code{deny} policy. Thus no one will be allowed to
-use the VNC server until the ACLs have been loaded. This can be
-achieved using the @code{acl} monitor command.
-
-@item lossy
-
-Enable lossy compression methods (gradient, JPEG, ...). If this
-option is set, VNC client may receive lossy framebuffer updates
-depending on its encoding settings. Enabling this option can save
-a lot of bandwidth at the expense of quality.
-
-@item non-adaptive
-
-Disable adaptive encodings. Adaptive encodings are enabled by default.
-An adaptive encoding will try to detect frequently updated screen region=
s,
-and send updates in these regions using a lossy encoding (like JPEG).
-This can be really helpful to save bandwidth when playing videos. Disabl=
ing
-adaptive encodings restores the original static behavior of encodings
-like Tight.
-
-@item share=3D[allow-exclusive|force-shared|ignore]
-
-Set display sharing policy.  'allow-exclusive' allows clients to ask
-for exclusive access.  As suggested by the rfb spec this is
-implemented by dropping other connections.  Connecting multiple
-clients in parallel requires all clients asking for a shared session
-(vncviewer: -shared switch).  This is the default.  'force-shared'
-disables exclusive client access.  Useful for shared desktop sessions,
-where you don't want someone forgetting specify -shared disconnect
-everybody else.  'ignore' completely ignores the shared flag and
-allows everybody connect unconditionally.  Doesn't conform to the rfb
-spec but is traditional QEMU behavior.
-
-@item key-delay-ms
-
-Set keyboard delay, for key down and key up events, in milliseconds.
-Default is 10.  Keyboards are low-bandwidth devices, so this slowdown
-can help the device and guest to keep up and not lose events in case
-events are arriving in bulk.  Possible causes for the latter are flaky
-network connections, or scripts for automated testing.
-
-@end table
-ETEXI
-
-STEXI
-@end table
-ETEXI
-ARCHHEADING(, QEMU_ARCH_I386)
-
-ARCHHEADING(i386 target only:, QEMU_ARCH_I386)
-STEXI
-@table @option
-ETEXI
-
-DEF("win2k-hack", 0, QEMU_OPTION_win2k_hack,
-    "-win2k-hack     use it when installing Windows 2000 to avoid a disk=
 full bug\n",
-    QEMU_ARCH_I386)
-STEXI
-@item -win2k-hack
-@findex -win2k-hack
-Use it when installing Windows 2000 to avoid a disk full bug. After
-Windows 2000 is installed, you no longer need this option (this option
-slows down the IDE transfers).
-ETEXI
-
-HXCOMM Deprecated by -rtc
-DEF("rtc-td-hack", 0, QEMU_OPTION_rtc_td_hack, "", QEMU_ARCH_I386)
-
-DEF("no-fd-bootchk", 0, QEMU_OPTION_no_fd_bootchk,
-    "-no-fd-bootchk  disable boot signature checking for floppy disks\n"=
,
-    QEMU_ARCH_I386)
-STEXI
-@item -no-fd-bootchk
-@findex -no-fd-bootchk
-Disable boot signature checking for floppy disks in BIOS. May
-be needed to boot from old floppy disks.
-ETEXI
-
-DEF("no-acpi", 0, QEMU_OPTION_no_acpi,
-           "-no-acpi        disable ACPI\n", QEMU_ARCH_I386 | QEMU_ARCH_=
ARM)
-STEXI
-@item -no-acpi
-@findex -no-acpi
-Disable ACPI (Advanced Configuration and Power Interface) support. Use
-it if your guest OS complains about ACPI problems (PC target machine
-only).
-ETEXI
-
-DEF("no-hpet", 0, QEMU_OPTION_no_hpet,
-    "-no-hpet        disable HPET\n", QEMU_ARCH_I386)
-STEXI
-@item -no-hpet
-@findex -no-hpet
-Disable HPET support.
-ETEXI
-
-DEF("acpitable", HAS_ARG, QEMU_OPTION_acpitable,
-    "-acpitable [sig=3Dstr][,rev=3Dn][,oem_id=3Dstr][,oem_table_id=3Dstr=
][,oem_rev=3Dn][,asl_compiler_id=3Dstr][,asl_compiler_rev=3Dn][,{data|fil=
e}=3Dfile1[:file2]...]\n"
-    "                ACPI table description\n", QEMU_ARCH_I386)
-STEXI
-@item -acpitable [sig=3D@var{str}][,rev=3D@var{n}][,oem_id=3D@var{str}][=
,oem_table_id=3D@var{str}][,oem_rev=3D@var{n}] [,asl_compiler_id=3D@var{s=
tr}][,asl_compiler_rev=3D@var{n}][,data=3D@var{file1}[:@var{file2}]...]
-@findex -acpitable
-Add ACPI table with specified header fields and context from specified f=
iles.
-For file=3D, take whole ACPI table from the specified files, including a=
ll
-ACPI headers (possible overridden by other options).
-For data=3D, only data
-portion of the table is used, all header information is specified in the
-command line.
-If a SLIC table is supplied to QEMU, then the SLIC's oem_id and oem_tabl=
e_id
-fields will override the same in the RSDT and the FADT (a.k.a. FACP), in=
 order
-to ensure the field matches required by the Microsoft SLIC spec and the =
ACPI
-spec.
-ETEXI
-
-DEF("smbios", HAS_ARG, QEMU_OPTION_smbios,
-    "-smbios file=3Dbinary\n"
-    "                load SMBIOS entry from binary file\n"
-    "-smbios type=3D0[,vendor=3Dstr][,version=3Dstr][,date=3Dstr][,relea=
se=3D%d.%d]\n"
-    "              [,uefi=3Don|off]\n"
-    "                specify SMBIOS type 0 fields\n"
-    "-smbios type=3D1[,manufacturer=3Dstr][,product=3Dstr][,version=3Dst=
r][,serial=3Dstr]\n"
-    "              [,uuid=3Duuid][,sku=3Dstr][,family=3Dstr]\n"
-    "                specify SMBIOS type 1 fields\n"
-    "-smbios type=3D2[,manufacturer=3Dstr][,product=3Dstr][,version=3Dst=
r][,serial=3Dstr]\n"
-    "              [,asset=3Dstr][,location=3Dstr]\n"
-    "                specify SMBIOS type 2 fields\n"
-    "-smbios type=3D3[,manufacturer=3Dstr][,version=3Dstr][,serial=3Dstr=
][,asset=3Dstr]\n"
-    "              [,sku=3Dstr]\n"
-    "                specify SMBIOS type 3 fields\n"
-    "-smbios type=3D4[,sock_pfx=3Dstr][,manufacturer=3Dstr][,version=3Ds=
tr][,serial=3Dstr]\n"
-    "              [,asset=3Dstr][,part=3Dstr]\n"
-    "                specify SMBIOS type 4 fields\n"
-    "-smbios type=3D17[,loc_pfx=3Dstr][,bank=3Dstr][,manufacturer=3Dstr]=
[,serial=3Dstr]\n"
-    "               [,asset=3Dstr][,part=3Dstr][,speed=3D%d]\n"
-    "                specify SMBIOS type 17 fields\n",
-    QEMU_ARCH_I386 | QEMU_ARCH_ARM)
-STEXI
-@item -smbios file=3D@var{binary}
-@findex -smbios
-Load SMBIOS entry from binary file.
-
-@item -smbios type=3D0[,vendor=3D@var{str}][,version=3D@var{str}][,date=3D=
@var{str}][,release=3D@var{%d.%d}][,uefi=3Don|off]
-Specify SMBIOS type 0 fields
-
-@item -smbios type=3D1[,manufacturer=3D@var{str}][,product=3D@var{str}][=
,version=3D@var{str}][,serial=3D@var{str}][,uuid=3D@var{uuid}][,sku=3D@va=
r{str}][,family=3D@var{str}]
-Specify SMBIOS type 1 fields
-
-@item -smbios type=3D2[,manufacturer=3D@var{str}][,product=3D@var{str}][=
,version=3D@var{str}][,serial=3D@var{str}][,asset=3D@var{str}][,location=3D=
@var{str}][,family=3D@var{str}]
-Specify SMBIOS type 2 fields
-
-@item -smbios type=3D3[,manufacturer=3D@var{str}][,version=3D@var{str}][=
,serial=3D@var{str}][,asset=3D@var{str}][,sku=3D@var{str}]
-Specify SMBIOS type 3 fields
-
-@item -smbios type=3D4[,sock_pfx=3D@var{str}][,manufacturer=3D@var{str}]=
[,version=3D@var{str}][,serial=3D@var{str}][,asset=3D@var{str}][,part=3D@=
var{str}]
-Specify SMBIOS type 4 fields
-
-@item -smbios type=3D17[,loc_pfx=3D@var{str}][,bank=3D@var{str}][,manufa=
cturer=3D@var{str}][,serial=3D@var{str}][,asset=3D@var{str}][,part=3D@var=
{str}][,speed=3D@var{%d}]
-Specify SMBIOS type 17 fields
-ETEXI
-
-STEXI
-@end table
-ETEXI
-DEFHEADING()
-
-DEFHEADING(Network options:)
-STEXI
-@table @option
-ETEXI
-
-HXCOMM Legacy slirp options (now moved to -net user):
-#ifdef CONFIG_SLIRP
-DEF("tftp", HAS_ARG, QEMU_OPTION_tftp, "", QEMU_ARCH_ALL)
-DEF("bootp", HAS_ARG, QEMU_OPTION_bootp, "", QEMU_ARCH_ALL)
-DEF("redir", HAS_ARG, QEMU_OPTION_redir, "", QEMU_ARCH_ALL)
-#ifndef _WIN32
-DEF("smb", HAS_ARG, QEMU_OPTION_smb, "", QEMU_ARCH_ALL)
-#endif
-#endif
-
-DEF("netdev", HAS_ARG, QEMU_OPTION_netdev,
-#ifdef CONFIG_SLIRP
-    "-netdev user,id=3Dstr[,ipv4[=3Don|off]][,net=3Daddr[/mask]][,host=3D=
addr]\n"
-    "         [,ipv6[=3Don|off]][,ipv6-net=3Daddr[/int]][,ipv6-host=3Dad=
dr]\n"
-    "         [,restrict=3Don|off][,hostname=3Dhost][,dhcpstart=3Daddr]\=
n"
-    "         [,dns=3Daddr][,ipv6-dns=3Daddr][,dnssearch=3Ddomain][,tftp=
=3Ddir]\n"
-    "         [,bootfile=3Df][,hostfwd=3Drule][,guestfwd=3Drule]"
-#ifndef _WIN32
-                                             "[,smb=3Ddir[,smbserver=3Da=
ddr]]\n"
-#endif
-    "                configure a user mode network backend with ID 'str'=
,\n"
-    "                its DHCP server and optional services\n"
-#endif
-#ifdef _WIN32
-    "-netdev tap,id=3Dstr,ifname=3Dname\n"
-    "                configure a host TAP network backend with ID 'str'\=
n"
-#else
-    "-netdev tap,id=3Dstr[,fd=3Dh][,fds=3Dx:y:...:z][,ifname=3Dname][,sc=
ript=3Dfile][,downscript=3Ddfile]\n"
-    "         [,br=3Dbridge][,helper=3Dhelper][,sndbuf=3Dnbytes][,vnet_h=
dr=3Don|off][,vhost=3Don|off]\n"
-    "         [,vhostfd=3Dh][,vhostfds=3Dx:y:...:z][,vhostforce=3Don|off=
][,queues=3Dn]\n"
-    "         [,poll-us=3Dn]\n"
-    "                configure a host TAP network backend with ID 'str'\=
n"
-    "                connected to a bridge (default=3D" DEFAULT_BRIDGE_I=
NTERFACE ")\n"
-    "                use network scripts 'file' (default=3D" DEFAULT_NET=
WORK_SCRIPT ")\n"
-    "                to configure it and 'dfile' (default=3D" DEFAULT_NE=
TWORK_DOWN_SCRIPT ")\n"
-    "                to deconfigure it\n"
-    "                use '[down]script=3Dno' to disable script execution=
\n"
-    "                use network helper 'helper' (default=3D" DEFAULT_BR=
IDGE_HELPER ") to\n"
-    "                configure it\n"
-    "                use 'fd=3Dh' to connect to an already opened TAP in=
terface\n"
-    "                use 'fds=3Dx:y:...:z' to connect to already opened =
multiqueue capable TAP interfaces\n"
-    "                use 'sndbuf=3Dnbytes' to limit the size of the send=
 buffer (the\n"
-    "                default is disabled 'sndbuf=3D0' to enable flow con=
trol set 'sndbuf=3D1048576')\n"
-    "                use vnet_hdr=3Doff to avoid enabling the IFF_VNET_H=
DR tap flag\n"
-    "                use vnet_hdr=3Don to make the lack of IFF_VNET_HDR =
support an error condition\n"
-    "                use vhost=3Don to enable experimental in kernel acc=
elerator\n"
-    "                    (only has effect for virtio guests which use MS=
IX)\n"
-    "                use vhostforce=3Don to force vhost on for non-MSIX =
virtio guests\n"
-    "                use 'vhostfd=3Dh' to connect to an already opened v=
host net device\n"
-    "                use 'vhostfds=3Dx:y:...:z to connect to multiple al=
ready opened vhost net devices\n"
-    "                use 'queues=3Dn' to specify the number of queues to=
 be created for multiqueue TAP\n"
-    "                use 'poll-us=3Dn' to speciy the maximum number of m=
icroseconds that could be\n"
-    "                spent on busy polling for vhost net\n"
-    "-netdev bridge,id=3Dstr[,br=3Dbridge][,helper=3Dhelper]\n"
-    "                configure a host TAP network backend with ID 'str' =
that is\n"
-    "                connected to a bridge (default=3D" DEFAULT_BRIDGE_I=
NTERFACE ")\n"
-    "                using the program 'helper (default=3D" DEFAULT_BRID=
GE_HELPER ")\n"
-#endif
-#ifdef __linux__
-    "-netdev l2tpv3,id=3Dstr,src=3Dsrcaddr,dst=3Ddstaddr[,srcport=3Dsrcp=
ort][,dstport=3Ddstport]\n"
-    "         [,rxsession=3Drxsession],txsession=3Dtxsession[,ipv6=3Don/=
off][,udp=3Don/off]\n"
-    "         [,cookie64=3Don/off][,counter][,pincounter][,txcookie=3Dtx=
cookie]\n"
-    "         [,rxcookie=3Drxcookie][,offset=3Doffset]\n"
-    "                configure a network backend with ID 'str' connected=
 to\n"
-    "                an Ethernet over L2TPv3 pseudowire.\n"
-    "                Linux kernel 3.3+ as well as most routers can talk\=
n"
-    "                L2TPv3. This transport allows connecting a VM to a =
VM,\n"
-    "                VM to a router and even VM to Host. It is a nearly-=
universal\n"
-    "                standard (RFC3391). Note - this implementation uses=
 static\n"
-    "                pre-configured tunnels (same as the Linux kernel).\=
n"
-    "                use 'src=3D' to specify source address\n"
-    "                use 'dst=3D' to specify destination address\n"
-    "                use 'udp=3Don' to specify udp encapsulation\n"
-    "                use 'srcport=3D' to specify source udp port\n"
-    "                use 'dstport=3D' to specify destination udp port\n"
-    "                use 'ipv6=3Don' to force v6\n"
-    "                L2TPv3 uses cookies to prevent misconfiguration as\=
n"
-    "                well as a weak security measure\n"
-    "                use 'rxcookie=3D0x012345678' to specify a rxcookie\=
n"
-    "                use 'txcookie=3D0x012345678' to specify a txcookie\=
n"
-    "                use 'cookie64=3Don' to set cookie size to 64 bit, o=
therwise 32\n"
-    "                use 'counter=3Doff' to force a 'cut-down' L2TPv3 wi=
th no counter\n"
-    "                use 'pincounter=3Don' to work around broken counter=
 handling in peer\n"
-    "                use 'offset=3DX' to add an extra offset between hea=
der and data\n"
-#endif
-    "-netdev socket,id=3Dstr[,fd=3Dh][,listen=3D[host]:port][,connect=3D=
host:port]\n"
-    "                configure a network backend to connect to another n=
etwork\n"
-    "                using a socket connection\n"
-    "-netdev socket,id=3Dstr[,fd=3Dh][,mcast=3Dmaddr:port[,localaddr=3Da=
ddr]]\n"
-    "                configure a network backend to connect to a multica=
st maddr and port\n"
-    "                use 'localaddr=3Daddr' to specify the host address =
to send packets from\n"
-    "-netdev socket,id=3Dstr[,fd=3Dh][,udp=3Dhost:port][,localaddr=3Dhos=
t:port]\n"
-    "                configure a network backend to connect to another n=
etwork\n"
-    "                using an UDP tunnel\n"
-#ifdef CONFIG_VDE
-    "-netdev vde,id=3Dstr[,sock=3Dsocketpath][,port=3Dn][,group=3Dgroupn=
ame][,mode=3Doctalmode]\n"
-    "                configure a network backend to connect to port 'n' =
of a vde switch\n"
-    "                running on host and listening for incoming connecti=
ons on 'socketpath'.\n"
-    "                Use group 'groupname' and mode 'octalmode' to chang=
e default\n"
-    "                ownership and permissions for communication port.\n=
"
-#endif
-#ifdef CONFIG_NETMAP
-    "-netdev netmap,id=3Dstr,ifname=3Dname[,devname=3Dnmname]\n"
-    "                attach to the existing netmap-enabled network inter=
face 'name', or to a\n"
-    "                VALE port (created on the fly) called 'name' ('nmna=
me' is name of the \n"
-    "                netmap device, defaults to '/dev/netmap')\n"
-#endif
-    "-netdev vhost-user,id=3Dstr,chardev=3Ddev[,vhostforce=3Don|off]\n"
-    "                configure a vhost-user network, backed by a chardev=
 'dev'\n"
-    "-netdev hubport,id=3Dstr,hubid=3Dn\n"
-    "                configure a hub port on QEMU VLAN 'n'\n", QEMU_ARCH=
_ALL)
-DEF("net", HAS_ARG, QEMU_OPTION_net,
-    "-net nic[,vlan=3Dn][,macaddr=3Dmac][,model=3Dtype][,name=3Dstr][,ad=
dr=3Dstr][,vectors=3Dv]\n"
-    "                old way to create a new NIC and connect it to VLAN =
'n'\n"
-    "                (use the '-device devtype,netdev=3Dstr' option if p=
ossible instead)\n"
-    "-net dump[,vlan=3Dn][,file=3Df][,len=3Dn]\n"
-    "                dump traffic on vlan 'n' to file 'f' (max n bytes p=
er packet)\n"
-    "-net none       use it alone to have zero network devices. If no -n=
et option\n"
-    "                is provided, the default is '-net nic -net user'\n"
-    "-net ["
-#ifdef CONFIG_SLIRP
-    "user|"
-#endif
-    "tap|"
-    "bridge|"
-#ifdef CONFIG_VDE
-    "vde|"
-#endif
-#ifdef CONFIG_NETMAP
-    "netmap|"
-#endif
-    "socket][,vlan=3Dn][,option][,option][,...]\n"
-    "                old way to initialize a host network interface\n"
-    "                (use the -netdev option if possible instead)\n", QE=
MU_ARCH_ALL)
-STEXI
-@item -net nic[,vlan=3D@var{n}][,macaddr=3D@var{mac}][,model=3D@var{type=
}] [,name=3D@var{name}][,addr=3D@var{addr}][,vectors=3D@var{v}]
-@findex -net
-Create a new Network Interface Card and connect it to VLAN @var{n} (@var=
{n}
-=3D 0 is the default). The NIC is an e1000 by default on the PC
-target. Optionally, the MAC address can be changed to @var{mac}, the
-device address set to @var{addr} (PCI cards only),
-and a @var{name} can be assigned for use in monitor commands.
-Optionally, for PCI cards, you can specify the number @var{v} of MSI-X v=
ectors
-that the card should have; this option currently only affects virtio car=
ds; set
-@var{v} =3D 0 to disable MSI-X. If no @option{-net} option is specified,=
 a single
-NIC is created.  QEMU can emulate several different models of network ca=
rd.
-Valid values for @var{type} are
-@code{virtio}, @code{i82551}, @code{i82557b}, @code{i82559er},
-@code{ne2k_pci}, @code{ne2k_isa}, @code{pcnet}, @code{rtl8139},
-@code{e1000}, @code{smc91c111}, @code{lance} and @code{mcf_fec}.
-Not all devices are supported on all targets.  Use @code{-net nic,model=3D=
help}
-for a list of available devices for your target.
-
-@item -netdev user,id=3D@var{id}[,@var{option}][,@var{option}][,...]
-@findex -netdev
-@item -net user[,@var{option}][,@var{option}][,...]
-Use the user mode network stack which requires no administrator
-privilege to run. Valid options are:
-
-@table @option
-@item vlan=3D@var{n}
-Connect user mode stack to VLAN @var{n} (@var{n} =3D 0 is the default).
-
-@item id=3D@var{id}
-@itemx name=3D@var{name}
-Assign symbolic name for use in monitor commands.
-
-@option{ipv4} and @option{ipv6} specify that either IPv4 or IPv6 must
-be enabled.  If neither is specified both protocols are enabled.
-
-@item net=3D@var{addr}[/@var{mask}]
-Set IP network address the guest will see. Optionally specify the netmas=
k,
-either in the form a.b.c.d or as number of valid top-most bits. Default =
is
-10.0.2.0/24.
-
-@item host=3D@var{addr}
-Specify the guest-visible address of the host. Default is the 2nd IP in =
the
-guest network, i.e. x.x.x.2.
-
-@item ipv6-net=3D@var{addr}[/@var{int}]
-Set IPv6 network address the guest will see (default is fec0::/64). The
-network prefix is given in the usual hexadecimal IPv6 address
-notation. The prefix size is optional, and is given as the number of
-valid top-most bits (default is 64).
-
-@item ipv6-host=3D@var{addr}
-Specify the guest-visible IPv6 address of the host. Default is the 2nd I=
Pv6 in
-the guest network, i.e. xxxx::2.
-
-@item restrict=3Don|off
-If this option is enabled, the guest will be isolated, i.e. it will not =
be
-able to contact the host and no guest IP packets will be routed over the=
 host
-to the outside. This option does not affect any explicitly set forwardin=
g rules.
-
-@item hostname=3D@var{name}
-Specifies the client hostname reported by the built-in DHCP server.
-
-@item dhcpstart=3D@var{addr}
-Specify the first of the 16 IPs the built-in DHCP server can assign. Def=
ault
-is the 15th to 31st IP in the guest network, i.e. x.x.x.15 to x.x.x.31.
-
-@item dns=3D@var{addr}
-Specify the guest-visible address of the virtual nameserver. The address=
 must
-be different from the host address. Default is the 3rd IP in the guest n=
etwork,
-i.e. x.x.x.3.
-
-@item ipv6-dns=3D@var{addr}
-Specify the guest-visible address of the IPv6 virtual nameserver. The ad=
dress
-must be different from the host address. Default is the 3rd IP in the gu=
est
-network, i.e. xxxx::3.
-
-@item dnssearch=3D@var{domain}
-Provides an entry for the domain-search list sent by the built-in
-DHCP server. More than one domain suffix can be transmitted by specifyin=
g
-this option multiple times. If supported, this will cause the guest to
-automatically try to append the given domain suffix(es) in case a domain=
 name
-can not be resolved.
-
-Example:
-@example
-qemu -net user,dnssearch=3Dmgmt.example.org,dnssearch=3Dexample.org [...=
]
-@end example
-
-@item tftp=3D@var{dir}
-When using the user mode network stack, activate a built-in TFTP
-server. The files in @var{dir} will be exposed as the root of a TFTP ser=
ver.
-The TFTP client on the guest must be configured in binary mode (use the =
command
-@code{bin} of the Unix TFTP client).
-
-@item bootfile=3D@var{file}
-When using the user mode network stack, broadcast @var{file} as the BOOT=
P
-filename. In conjunction with @option{tftp}, this can be used to network=
 boot
-a guest from a local directory.
-
-Example (using pxelinux):
-@example
-qemu-system-i386 -hda linux.img -boot n -net user,tftp=3D/path/to/tftp/f=
iles,bootfile=3D/pxelinux.0
-@end example
-
-@item smb=3D@var{dir}[,smbserver=3D@var{addr}]
-When using the user mode network stack, activate a built-in SMB
-server so that Windows OSes can access to the host files in @file{@var{d=
ir}}
-transparently. The IP address of the SMB server can be set to @var{addr}=
. By
-default the 4th IP in the guest network is used, i.e. x.x.x.4.
-
-In the guest Windows OS, the line:
-@example
-10.0.2.4 smbserver
-@end example
-must be added in the file @file{C:\WINDOWS\LMHOSTS} (for windows 9x/Me)
-or @file{C:\WINNT\SYSTEM32\DRIVERS\ETC\LMHOSTS} (Windows NT/2000).
-
-Then @file{@var{dir}} can be accessed in @file{\\smbserver\qemu}.
-
-Note that a SAMBA server must be installed on the host OS.
-QEMU was tested successfully with smbd versions from Red Hat 9,
-Fedora Core 3 and OpenSUSE 11.x.
-
-@item hostfwd=3D[tcp|udp]:[@var{hostaddr}]:@var{hostport}-[@var{guestadd=
r}]:@var{guestport}
-Redirect incoming TCP or UDP connections to the host port @var{hostport}=
 to
-the guest IP address @var{guestaddr} on guest port @var{guestport}. If
-@var{guestaddr} is not specified, its value is x.x.x.15 (default first a=
ddress
-given by the built-in DHCP server). By specifying @var{hostaddr}, the ru=
le can
-be bound to a specific host interface. If no connection type is set, TCP=
 is
-used. This option can be given multiple times.
-
-For example, to redirect host X11 connection from screen 1 to guest
-screen 0, use the following:
-
-@example
-# on the host
-qemu-system-i386 -net user,hostfwd=3Dtcp:127.0.0.1:6001-:6000 [...]
-# this host xterm should open in the guest X11 server
-xterm -display :1
-@end example
-
-To redirect telnet connections from host port 5555 to telnet port on
-the guest, use the following:
-
-@example
-# on the host
-qemu-system-i386 -net user,hostfwd=3Dtcp::5555-:23 [...]
-telnet localhost 5555
-@end example
-
-Then when you use on the host @code{telnet localhost 5555}, you
-connect to the guest telnet server.
-
-@item guestfwd=3D[tcp]:@var{server}:@var{port}-@var{dev}
-@itemx guestfwd=3D[tcp]:@var{server}:@var{port}-@var{cmd:command}
-Forward guest TCP connections to the IP address @var{server} on port @va=
r{port}
-to the character device @var{dev} or to a program executed by @var{cmd:c=
ommand}
-which gets spawned for each connection. This option can be given multipl=
e times.
-
-You can either use a chardev directly and have that one used throughout =
QEMU's
-lifetime, like in the following example:
-
-@example
-# open 10.10.1.1:4321 on bootup, connect 10.0.2.100:1234 to it whenever
-# the guest accesses it
-qemu -net user,guestfwd=3Dtcp:10.0.2.100:1234-tcp:10.10.1.1:4321 [...]
-@end example
-
-Or you can execute a command on every TCP connection established by the =
guest,
-so that QEMU behaves similar to an inetd process for that virtual server=
:
-
-@example
-# call "netcat 10.10.1.1 4321" on every TCP connection to 10.0.2.100:123=
4
-# and connect the TCP stream to its stdin/stdout
-qemu -net 'user,guestfwd=3Dtcp:10.0.2.100:1234-cmd:netcat 10.10.1.1 4321=
'
-@end example
-
-@end table
-
-Note: Legacy stand-alone options -tftp, -bootp, -smb and -redir are stil=
l
-processed and applied to -net user. Mixing them with the new configurati=
on
-syntax gives undefined results. Their use for new applications is discou=
raged
-as they will be removed from future versions.
-
-@item -netdev tap,id=3D@var{id}[,fd=3D@var{h}][,ifname=3D@var{name}][,sc=
ript=3D@var{file}][,downscript=3D@var{dfile}][,br=3D@var{bridge}][,helper=
=3D@var{helper}]
-@itemx -net tap[,vlan=3D@var{n}][,name=3D@var{name}][,fd=3D@var{h}][,ifn=
ame=3D@var{name}][,script=3D@var{file}][,downscript=3D@var{dfile}][,br=3D=
@var{bridge}][,helper=3D@var{helper}]
-Connect the host TAP network interface @var{name} to VLAN @var{n}.
-
-Use the network script @var{file} to configure it and the network script
-@var{dfile} to deconfigure it. If @var{name} is not provided, the OS
-automatically provides one. The default network configure script is
-@file{/etc/qemu-ifup} and the default network deconfigure script is
-@file{/etc/qemu-ifdown}. Use @option{script=3Dno} or @option{downscript=3D=
no}
-to disable script execution.
-
-If running QEMU as an unprivileged user, use the network helper
-@var{helper} to configure the TAP interface and attach it to the bridge.
-The default network helper executable is @file{/path/to/qemu-bridge-help=
er}
-and the default bridge device is @file{br0}.
-
-@option{fd}=3D@var{h} can be used to specify the handle of an already
-opened host TAP interface.
-
-Examples:
-
-@example
-#launch a QEMU instance with the default network script
-qemu-system-i386 linux.img -net nic -net tap
-@end example
-
-@example
-#launch a QEMU instance with two NICs, each one connected
-#to a TAP device
-qemu-system-i386 linux.img \
-                 -net nic,vlan=3D0 -net tap,vlan=3D0,ifname=3Dtap0 \
-                 -net nic,vlan=3D1 -net tap,vlan=3D1,ifname=3Dtap1
-@end example
-
-@example
-#launch a QEMU instance with the default network helper to
-#connect a TAP device to bridge br0
-qemu-system-i386 linux.img \
-                 -net nic -net tap,"helper=3D/path/to/qemu-bridge-helper=
"
-@end example
-
-@item -netdev bridge,id=3D@var{id}[,br=3D@var{bridge}][,helper=3D@var{he=
lper}]
-@itemx -net bridge[,vlan=3D@var{n}][,name=3D@var{name}][,br=3D@var{bridg=
e}][,helper=3D@var{helper}]
-Connect a host TAP network interface to a host bridge device.
-
-Use the network helper @var{helper} to configure the TAP interface and
-attach it to the bridge. The default network helper executable is
-@file{/path/to/qemu-bridge-helper} and the default bridge
-device is @file{br0}.
-
-Examples:
-
-@example
-#launch a QEMU instance with the default network helper to
-#connect a TAP device to bridge br0
-qemu-system-i386 linux.img -net bridge -net nic,model=3Dvirtio
-@end example
-
-@example
-#launch a QEMU instance with the default network helper to
-#connect a TAP device to bridge qemubr0
-qemu-system-i386 linux.img -net bridge,br=3Dqemubr0 -net nic,model=3Dvir=
tio
-@end example
-
-@item -netdev socket,id=3D@var{id}[,fd=3D@var{h}][,listen=3D[@var{host}]=
:@var{port}][,connect=3D@var{host}:@var{port}]
-@itemx -net socket[,vlan=3D@var{n}][,name=3D@var{name}][,fd=3D@var{h}] [=
,listen=3D[@var{host}]:@var{port}][,connect=3D@var{host}:@var{port}]
-
-Connect the VLAN @var{n} to a remote VLAN in another QEMU virtual
-machine using a TCP socket connection. If @option{listen} is
-specified, QEMU waits for incoming connections on @var{port}
-(@var{host} is optional). @option{connect} is used to connect to
-another QEMU instance using the @option{listen} option. @option{fd}=3D@v=
ar{h}
-specifies an already opened TCP socket.
-
-Example:
-@example
-# launch a first QEMU instance
-qemu-system-i386 linux.img \
-                 -net nic,macaddr=3D52:54:00:12:34:56 \
-                 -net socket,listen=3D:1234
-# connect the VLAN 0 of this instance to the VLAN 0
-# of the first instance
-qemu-system-i386 linux.img \
-                 -net nic,macaddr=3D52:54:00:12:34:57 \
-                 -net socket,connect=3D127.0.0.1:1234
-@end example
-
-@item -netdev socket,id=3D@var{id}[,fd=3D@var{h}][,mcast=3D@var{maddr}:@=
var{port}[,localaddr=3D@var{addr}]]
-@itemx -net socket[,vlan=3D@var{n}][,name=3D@var{name}][,fd=3D@var{h}][,=
mcast=3D@var{maddr}:@var{port}[,localaddr=3D@var{addr}]]
-
-Create a VLAN @var{n} shared with another QEMU virtual
-machines using a UDP multicast socket, effectively making a bus for
-every QEMU with same multicast address @var{maddr} and @var{port}.
-NOTES:
-@enumerate
-@item
-Several QEMU can be running on different hosts and share same bus (assum=
ing
-correct multicast setup for these hosts).
-@item
-mcast support is compatible with User Mode Linux (argument @option{eth@v=
ar{N}=3Dmcast}), see
-@url{http://user-mode-linux.sf.net}.
-@item
-Use @option{fd=3Dh} to specify an already opened UDP multicast socket.
-@end enumerate
-
-Example:
-@example
-# launch one QEMU instance
-qemu-system-i386 linux.img \
-                 -net nic,macaddr=3D52:54:00:12:34:56 \
-                 -net socket,mcast=3D230.0.0.1:1234
-# launch another QEMU instance on same "bus"
-qemu-system-i386 linux.img \
-                 -net nic,macaddr=3D52:54:00:12:34:57 \
-                 -net socket,mcast=3D230.0.0.1:1234
-# launch yet another QEMU instance on same "bus"
-qemu-system-i386 linux.img \
-                 -net nic,macaddr=3D52:54:00:12:34:58 \
-                 -net socket,mcast=3D230.0.0.1:1234
-@end example
-
-Example (User Mode Linux compat.):
-@example
-# launch QEMU instance (note mcast address selected
-# is UML's default)
-qemu-system-i386 linux.img \
-                 -net nic,macaddr=3D52:54:00:12:34:56 \
-                 -net socket,mcast=3D239.192.168.1:1102
-# launch UML
-/path/to/linux ubd0=3D/path/to/root_fs eth0=3Dmcast
-@end example
-
-Example (send packets from host's 1.2.3.4):
-@example
-qemu-system-i386 linux.img \
-                 -net nic,macaddr=3D52:54:00:12:34:56 \
-                 -net socket,mcast=3D239.192.168.1:1102,localaddr=3D1.2.=
3.4
-@end example
-
-@item -netdev l2tpv3,id=3D@var{id},src=3D@var{srcaddr},dst=3D@var{dstadd=
r}[,srcport=3D@var{srcport}][,dstport=3D@var{dstport}],txsession=3D@var{t=
xsession}[,rxsession=3D@var{rxsession}][,ipv6][,udp][,cookie64][,counter]=
[,pincounter][,txcookie=3D@var{txcookie}][,rxcookie=3D@var{rxcookie}][,of=
fset=3D@var{offset}]
-@itemx -net l2tpv3[,vlan=3D@var{n}][,name=3D@var{name}],src=3D@var{srcad=
dr},dst=3D@var{dstaddr}[,srcport=3D@var{srcport}][,dstport=3D@var{dstport=
}],txsession=3D@var{txsession}[,rxsession=3D@var{rxsession}][,ipv6][,udp]=
[,cookie64][,counter][,pincounter][,txcookie=3D@var{txcookie}][,rxcookie=3D=
@var{rxcookie}][,offset=3D@var{offset}]
-Connect VLAN @var{n} to L2TPv3 pseudowire. L2TPv3 (RFC3391) is a popular
-protocol to transport Ethernet (and other Layer 2) data frames between
-two systems. It is present in routers, firewalls and the Linux kernel
-(from version 3.3 onwards).
-
-This transport allows a VM to communicate to another VM, router or firew=
all directly.
-
-@table @option
-@item src=3D@var{srcaddr}
-    source address (mandatory)
-@item dst=3D@var{dstaddr}
-    destination address (mandatory)
-@item udp
-    select udp encapsulation (default is ip).
-@item srcport=3D@var{srcport}
-    source udp port.
-@item dstport=3D@var{dstport}
-    destination udp port.
-@item ipv6
-    force v6, otherwise defaults to v4.
-@item rxcookie=3D@var{rxcookie}
-@itemx txcookie=3D@var{txcookie}
-    Cookies are a weak form of security in the l2tpv3 specification.
-Their function is mostly to prevent misconfiguration. By default they ar=
e 32
-bit.
-@item cookie64
-    Set cookie size to 64 bit instead of the default 32
-@item counter=3Doff
-    Force a 'cut-down' L2TPv3 with no counter as in
-draft-mkonstan-l2tpext-keyed-ipv6-tunnel-00
-@item pincounter=3Don
-    Work around broken counter handling in peer. This may also help on
-networks which have packet reorder.
-@item offset=3D@var{offset}
-    Add an extra offset between header and data
-@end table
-
-For example, to attach a VM running on host 4.3.2.1 via L2TPv3 to the br=
idge br-lan
-on the remote Linux host 1.2.3.4:
-@example
-# Setup tunnel on linux host using raw ip as encapsulation
-# on 1.2.3.4
-ip l2tp add tunnel remote 4.3.2.1 local 1.2.3.4 tunnel_id 1 peer_tunnel_=
id 1 \
-    encap udp udp_sport 16384 udp_dport 16384
-ip l2tp add session tunnel_id 1 name vmtunnel0 session_id \
-    0xFFFFFFFF peer_session_id 0xFFFFFFFF
-ifconfig vmtunnel0 mtu 1500
-ifconfig vmtunnel0 up
-brctl addif br-lan vmtunnel0
-
-
-# on 4.3.2.1
-# launch QEMU instance - if your network has reorder or is very lossy ad=
d ,pincounter
-
-qemu-system-i386 linux.img -net nic -net l2tpv3,src=3D4.2.3.1,dst=3D1.2.=
3.4,udp,srcport=3D16384,dstport=3D16384,rxsession=3D0xffffffff,txsession=3D=
0xffffffff,counter
-
-
-@end example
-
-@item -netdev vde,id=3D@var{id}[,sock=3D@var{socketpath}][,port=3D@var{n=
}][,group=3D@var{groupname}][,mode=3D@var{octalmode}]
-@itemx -net vde[,vlan=3D@var{n}][,name=3D@var{name}][,sock=3D@var{socket=
path}] [,port=3D@var{n}][,group=3D@var{groupname}][,mode=3D@var{octalmode=
}]
-Connect VLAN @var{n} to PORT @var{n} of a vde switch running on host and
-listening for incoming connections on @var{socketpath}. Use GROUP @var{g=
roupname}
-and MODE @var{octalmode} to change default ownership and permissions for
-communication port. This option is only available if QEMU has been compi=
led
-with vde support enabled.
-
-Example:
-@example
-# launch vde switch
-vde_switch -F -sock /tmp/myswitch
-# launch QEMU instance
-qemu-system-i386 linux.img -net nic -net vde,sock=3D/tmp/myswitch
-@end example
-
-@item -netdev hubport,id=3D@var{id},hubid=3D@var{hubid}
-
-Create a hub port on QEMU "vlan" @var{hubid}.
-
-The hubport netdev lets you connect a NIC to a QEMU "vlan" instead of a =
single
-netdev.  @code{-net} and @code{-device} with parameter @option{vlan} cre=
ate the
-required hub automatically.
-
-@item -netdev vhost-user,chardev=3D@var{id}[,vhostforce=3Don|off][,queue=
s=3Dn]
-
-Establish a vhost-user netdev, backed by a chardev @var{id}. The chardev=
 should
-be a unix domain socket backed one. The vhost-user uses a specifically d=
efined
-protocol to pass vhost ioctl replacement messages to an application on t=
he other
-end of the socket. On non-MSIX guests, the feature can be forced with
-@var{vhostforce}. Use 'queues=3D@var{n}' to specify the number of queues=
 to
-be created for multiqueue vhost-user.
-
-Example:
-@example
-qemu -m 512 -object memory-backend-file,id=3Dmem,size=3D512M,mem-path=3D=
/hugetlbfs,share=3Don \
-     -numa node,memdev=3Dmem \
-     -chardev socket,id=3Dchr0,path=3D/path/to/socket \
-     -netdev type=3Dvhost-user,id=3Dnet0,chardev=3Dchr0 \
-     -device virtio-net-pci,netdev=3Dnet0
-@end example
-
-@item -net dump[,vlan=3D@var{n}][,file=3D@var{file}][,len=3D@var{len}]
-Dump network traffic on VLAN @var{n} to file @var{file} (@file{qemu-vlan=
0.pcap} by default).
-At most @var{len} bytes (64k by default) per packet are stored. The file=
 format is
-libpcap, so it can be analyzed with tools such as tcpdump or Wireshark.
-Note: For devices created with '-netdev', use '-object filter-dump,...' =
instead.
-
-@item -net none
-Indicate that no network devices should be configured. It is used to
-override the default configuration (@option{-net nic -net user}) which
-is activated if no @option{-net} options are provided.
-ETEXI
-
-STEXI
-@end table
-ETEXI
-DEFHEADING()
-
-DEFHEADING(Character device options:)
-
-DEF("chardev", HAS_ARG, QEMU_OPTION_chardev,
-    "-chardev help\n"
-    "-chardev null,id=3Did[,mux=3Don|off][,logfile=3DPATH][,logappend=3D=
on|off]\n"
-    "-chardev socket,id=3Did[,host=3Dhost],port=3Dport[,to=3Dto][,ipv4][=
,ipv6][,nodelay][,reconnect=3Dseconds]\n"
-    "         [,server][,nowait][,telnet][,reconnect=3Dseconds][,mux=3Do=
n|off]\n"
-    "         [,logfile=3DPATH][,logappend=3Don|off][,tls-creds=3DID] (t=
cp)\n"
-    "-chardev socket,id=3Did,path=3Dpath[,server][,nowait][,telnet][,rec=
onnect=3Dseconds]\n"
-    "         [,mux=3Don|off][,logfile=3DPATH][,logappend=3Don|off] (uni=
x)\n"
-    "-chardev udp,id=3Did[,host=3Dhost],port=3Dport[,localaddr=3Dlocalad=
dr]\n"
-    "         [,localport=3Dlocalport][,ipv4][,ipv6][,mux=3Don|off]\n"
-    "         [,logfile=3DPATH][,logappend=3Don|off]\n"
-    "-chardev msmouse,id=3Did[,mux=3Don|off][,logfile=3DPATH][,logappend=
=3Don|off]\n"
-    "-chardev vc,id=3Did[[,width=3Dwidth][,height=3Dheight]][[,cols=3Dco=
ls][,rows=3Drows]]\n"
-    "         [,mux=3Don|off][,logfile=3DPATH][,logappend=3Don|off]\n"
-    "-chardev ringbuf,id=3Did[,size=3Dsize][,logfile=3DPATH][,logappend=3D=
on|off]\n"
-    "-chardev file,id=3Did,path=3Dpath[,mux=3Don|off][,logfile=3DPATH][,=
logappend=3Don|off]\n"
-    "-chardev pipe,id=3Did,path=3Dpath[,mux=3Don|off][,logfile=3DPATH][,=
logappend=3Don|off]\n"
-#ifdef _WIN32
-    "-chardev console,id=3Did[,mux=3Don|off][,logfile=3DPATH][,logappend=
=3Don|off]\n"
-    "-chardev serial,id=3Did,path=3Dpath[,mux=3Don|off][,logfile=3DPATH]=
[,logappend=3Don|off]\n"
-#else
-    "-chardev pty,id=3Did[,mux=3Don|off][,logfile=3DPATH][,logappend=3Do=
n|off]\n"
-    "-chardev stdio,id=3Did[,mux=3Don|off][,signal=3Don|off][,logfile=3D=
PATH][,logappend=3Don|off]\n"
-#endif
-#ifdef CONFIG_BRLAPI
-    "-chardev braille,id=3Did[,mux=3Don|off][,logfile=3DPATH][,logappend=
=3Don|off]\n"
-#endif
-#if defined(__linux__) || defined(__sun__) || defined(__FreeBSD__) \
-        || defined(__NetBSD__) || defined(__OpenBSD__) || defined(__Drag=
onFly__)
-    "-chardev serial,id=3Did,path=3Dpath[,mux=3Don|off][,logfile=3DPATH]=
[,logappend=3Don|off]\n"
-    "-chardev tty,id=3Did,path=3Dpath[,mux=3Don|off][,logfile=3DPATH][,l=
ogappend=3Don|off]\n"
-#endif
-#if defined(__linux__) || defined(__FreeBSD__) || defined(__DragonFly__)
-    "-chardev parallel,id=3Did,path=3Dpath[,mux=3Don|off][,logfile=3DPAT=
H][,logappend=3Don|off]\n"
-    "-chardev parport,id=3Did,path=3Dpath[,mux=3Don|off][,logfile=3DPATH=
][,logappend=3Don|off]\n"
-#endif
-#if defined(CONFIG_SPICE)
-    "-chardev spicevmc,id=3Did,name=3Dname[,debug=3Ddebug][,logfile=3DPA=
TH][,logappend=3Don|off]\n"
-    "-chardev spiceport,id=3Did,name=3Dname[,debug=3Ddebug][,logfile=3DP=
ATH][,logappend=3Don|off]\n"
-#endif
-    , QEMU_ARCH_ALL
-)
-
-STEXI
-
-The general form of a character device option is:
-@table @option
-@item -chardev @var{backend} ,id=3D@var{id} [,mux=3Don|off] [,@var{optio=
ns}]
-@findex -chardev
-Backend is one of:
-@option{null},
-@option{socket},
-@option{udp},
-@option{msmouse},
-@option{vc},
-@option{ringbuf},
-@option{file},
-@option{pipe},
-@option{console},
-@option{serial},
-@option{pty},
-@option{stdio},
-@option{braille},
-@option{tty},
-@option{parallel},
-@option{parport},
-@option{spicevmc}.
-@option{spiceport}.
-The specific backend will determine the applicable options.
-
-Use @code{-chardev help} to print all available chardev backend types.
-
-All devices must have an id, which can be any string up to 127 character=
s long.
-It is used to uniquely identify this device in other command line direct=
ives.
-
-A character device may be used in multiplexing mode by multiple front-en=
ds.
-Specify @option{mux=3Don} to enable this mode.
-A multiplexer is a "1:N" device, and here the "1" end is your specified =
chardev
-backend, and the "N" end is the various parts of QEMU that can talk to a=
 chardev.
-If you create a chardev with @option{id=3Dmyid} and @option{mux=3Don}, Q=
EMU will
-create a multiplexer with your specified ID, and you can then configure =
multiple
-front ends to use that chardev ID for their input/output. Up to four dif=
ferent
-front ends can be connected to a single multiplexed chardev. (Without
-multiplexing enabled, a chardev can only be used by a single front end.)
-For instance you could use this to allow a single stdio chardev to be us=
ed by
-two serial ports and the QEMU monitor:
-
-@example
--chardev stdio,mux=3Don,id=3Dchar0 \
--mon chardev=3Dchar0,mode=3Dreadline \
--serial chardev:char0 \
--serial chardev:char0
-@end example
-
-You can have more than one multiplexer in a system configuration; for in=
stance
-you could have a TCP port multiplexed between UART 0 and UART 1, and std=
io
-multiplexed between the QEMU monitor and a parallel port:
-
-@example
--chardev stdio,mux=3Don,id=3Dchar0 \
--mon chardev=3Dchar0,mode=3Dreadline \
--parallel chardev:char0 \
--chardev tcp,...,mux=3Don,id=3Dchar1 \
--serial chardev:char1 \
--serial chardev:char1
-@end example
-
-When you're using a multiplexed character device, some escape sequences =
are
-interpreted in the input. @xref{mux_keys, Keys in the character backend
-multiplexer}.
-
-Note that some other command line options may implicitly create multiple=
xed
-character backends; for instance @option{-serial mon:stdio} creates a
-multiplexed stdio backend connected to the serial port and the QEMU moni=
tor,
-and @option{-nographic} also multiplexes the console and the monitor to
-stdio.
-
-There is currently no support for multiplexing in the other direction
-(where a single QEMU front end takes input and output from multiple char=
devs).
-
-Every backend supports the @option{logfile} option, which supplies the p=
ath
-to a file to record all data transmitted via the backend. The @option{lo=
gappend}
-option controls whether the log file will be truncated or appended to wh=
en
-opened.
-
-@end table
-
-The available backends are:
-
-@table @option
-@item -chardev null ,id=3D@var{id}
-A void device. This device will not emit any data, and will drop any dat=
a it
-receives. The null backend does not take any options.
-
-@item -chardev socket ,id=3D@var{id} [@var{TCP options} or @var{unix opt=
ions}] [,server] [,nowait] [,telnet] [,reconnect=3D@var{seconds}] [,tls-c=
reds=3D@var{id}]
-
-Create a two-way stream socket, which can be either a TCP or a unix sock=
et. A
-unix socket will be created if @option{path} is specified. Behaviour is
-undefined if TCP options are specified for a unix socket.
-
-@option{server} specifies that the socket shall be a listening socket.
-
-@option{nowait} specifies that QEMU should not block waiting for a clien=
t to
-connect to a listening socket.
-
-@option{telnet} specifies that traffic on the socket should interpret te=
lnet
-escape sequences.
-
-@option{reconnect} sets the timeout for reconnecting on non-server socke=
ts when
-the remote end goes away.  qemu will delay this many seconds and then at=
tempt
-to reconnect.  Zero disables reconnecting, and is the default.
-
-@option{tls-creds} requests enablement of the TLS protocol for encryptio=
n,
-and specifies the id of the TLS credentials to use for the handshake. Th=
e
-credentials must be previously created with the @option{-object tls-cred=
s}
-argument.
-
-TCP and unix socket options are given below:
-
-@table @option
-
-@item TCP options: port=3D@var{port} [,host=3D@var{host}] [,to=3D@var{to=
}] [,ipv4] [,ipv6] [,nodelay]
-
-@option{host} for a listening socket specifies the local address to be b=
ound.
-For a connecting socket species the remote host to connect to. @option{h=
ost} is
-optional for listening sockets. If not specified it defaults to @code{0.=
0.0.0}.
-
-@option{port} for a listening socket specifies the local port to be boun=
d. For a
-connecting socket specifies the port on the remote host to connect to.
-@option{port} can be given as either a port number or a service name.
-@option{port} is required.
-
-@option{to} is only relevant to listening sockets. If it is specified, a=
nd
-@option{port} cannot be bound, QEMU will attempt to bind to subsequent p=
orts up
-to and including @option{to} until it succeeds. @option{to} must be spec=
ified
-as a port number.
-
-@option{ipv4} and @option{ipv6} specify that either IPv4 or IPv6 must be=
 used.
-If neither is specified the socket may use either protocol.
-
-@option{nodelay} disables the Nagle algorithm.
-
-@item unix options: path=3D@var{path}
-
-@option{path} specifies the local path of the unix socket. @option{path}=
 is
-required.
-
-@end table
-
-@item -chardev udp ,id=3D@var{id} [,host=3D@var{host}] ,port=3D@var{port=
} [,localaddr=3D@var{localaddr}] [,localport=3D@var{localport}] [,ipv4] [=
,ipv6]
-
-Sends all traffic from the guest to a remote host over UDP.
-
-@option{host} specifies the remote host to connect to. If not specified =
it
-defaults to @code{localhost}.
-
-@option{port} specifies the port on the remote host to connect to. @opti=
on{port}
-is required.
-
-@option{localaddr} specifies the local address to bind to. If not specif=
ied it
-defaults to @code{0.0.0.0}.
-
-@option{localport} specifies the local port to bind to. If not specified=
 any
-available local port will be used.
-
-@option{ipv4} and @option{ipv6} specify that either IPv4 or IPv6 must be=
 used.
-If neither is specified the device may use either protocol.
-
-@item -chardev msmouse ,id=3D@var{id}
-
-Forward QEMU's emulated msmouse events to the guest. @option{msmouse} do=
es not
-take any options.
-
-@item -chardev vc ,id=3D@var{id} [[,width=3D@var{width}] [,height=3D@var=
{height}]] [[,cols=3D@var{cols}] [,rows=3D@var{rows}]]
-
-Connect to a QEMU text console. @option{vc} may optionally be given a sp=
ecific
-size.
-
-@option{width} and @option{height} specify the width and height respecti=
vely of
-the console, in pixels.
-
-@option{cols} and @option{rows} specify that the console be sized to fit=
 a text
-console with the given dimensions.
-
-@item -chardev ringbuf ,id=3D@var{id} [,size=3D@var{size}]
-
-Create a ring buffer with fixed size @option{size}.
-@var{size} must be a power of two and defaults to @code{64K}.
-
-@item -chardev file ,id=3D@var{id} ,path=3D@var{path}
-
-Log all traffic received from the guest to a file.
-
-@option{path} specifies the path of the file to be opened. This file wil=
l be
-created if it does not already exist, and overwritten if it does. @optio=
n{path}
-is required.
-
-@item -chardev pipe ,id=3D@var{id} ,path=3D@var{path}
-
-Create a two-way connection to the guest. The behaviour differs slightly=
 between
-Windows hosts and other hosts:
-
-On Windows, a single duplex pipe will be created at
-@file{\\.pipe\@option{path}}.
-
-On other hosts, 2 pipes will be created called @file{@option{path}.in} a=
nd
-@file{@option{path}.out}. Data written to @file{@option{path}.in} will b=
e
-received by the guest. Data written by the guest can be read from
-@file{@option{path}.out}. QEMU will not create these fifos, and requires=
 them to
-be present.
-
-@option{path} forms part of the pipe path as described above. @option{pa=
th} is
-required.
-
-@item -chardev console ,id=3D@var{id}
-
-Send traffic from the guest to QEMU's standard output. @option{console} =
does not
-take any options.
-
-@option{console} is only available on Windows hosts.
-
-@item -chardev serial ,id=3D@var{id} ,path=3D@option{path}
-
-Send traffic from the guest to a serial device on the host.
-
-On Unix hosts serial will actually accept any tty device,
-not only serial lines.
-
-@option{path} specifies the name of the serial device to open.
-
-@item -chardev pty ,id=3D@var{id}
-
-Create a new pseudo-terminal on the host and connect to it. @option{pty}=
 does
-not take any options.
-
-@option{pty} is not available on Windows hosts.
-
-@item -chardev stdio ,id=3D@var{id} [,signal=3Don|off]
-Connect to standard input and standard output of the QEMU process.
-
-@option{signal} controls if signals are enabled on the terminal, that in=
cludes
-exiting QEMU with the key sequence @key{Control-c}. This option is enabl=
ed by
-default, use @option{signal=3Doff} to disable it.
-
-@item -chardev braille ,id=3D@var{id}
-
-Connect to a local BrlAPI server. @option{braille} does not take any opt=
ions.
-
-@item -chardev tty ,id=3D@var{id} ,path=3D@var{path}
-
-@option{tty} is only available on Linux, Sun, FreeBSD, NetBSD, OpenBSD a=
nd
-DragonFlyBSD hosts.  It is an alias for @option{serial}.
-
-@option{path} specifies the path to the tty. @option{path} is required.
-
-@item -chardev parallel ,id=3D@var{id} ,path=3D@var{path}
-@itemx -chardev parport ,id=3D@var{id} ,path=3D@var{path}
-
-@option{parallel} is only available on Linux, FreeBSD and DragonFlyBSD h=
osts.
-
-Connect to a local parallel port.
-
-@option{path} specifies the path to the parallel port device. @option{pa=
th} is
-required.
-
-@item -chardev spicevmc ,id=3D@var{id} ,debug=3D@var{debug}, name=3D@var=
{name}
-
-@option{spicevmc} is only available when spice support is built in.
-
-@option{debug} debug level for spicevmc
-
-@option{name} name of spice channel to connect to
-
-Connect to a spice virtual machine channel, such as vdiport.
-
-@item -chardev spiceport ,id=3D@var{id} ,debug=3D@var{debug}, name=3D@va=
r{name}
-
-@option{spiceport} is only available when spice support is built in.
-
-@option{debug} debug level for spicevmc
-
-@option{name} name of spice port to connect to
-
-Connect to a spice port, allowing a Spice client to handle the traffic
-identified by a name (preferably a fqdn).
-ETEXI
-
-STEXI
-@end table
-ETEXI
-DEFHEADING()
-
-DEFHEADING(Bluetooth(R) options:)
-STEXI
-@table @option
-ETEXI
-
-DEF("bt", HAS_ARG, QEMU_OPTION_bt, \
-    "-bt hci,null    dumb bluetooth HCI - doesn't respond to commands\n"=
 \
-    "-bt hci,host[:id]\n" \
-    "                use host's HCI with the given name\n" \
-    "-bt hci[,vlan=3Dn]\n" \
-    "                emulate a standard HCI in virtual scatternet 'n'\n"=
 \
-    "-bt vhci[,vlan=3Dn]\n" \
-    "                add host computer to virtual scatternet 'n' using V=
HCI\n" \
-    "-bt device:dev[,vlan=3Dn]\n" \
-    "                emulate a bluetooth device 'dev' in scatternet 'n'\=
n",
-    QEMU_ARCH_ALL)
-STEXI
-@item -bt hci[...]
-@findex -bt
-Defines the function of the corresponding Bluetooth HCI.  -bt options
-are matched with the HCIs present in the chosen machine type.  For
-example when emulating a machine with only one HCI built into it, only
-the first @code{-bt hci[...]} option is valid and defines the HCI's
-logic.  The Transport Layer is decided by the machine type.  Currently
-the machines @code{n800} and @code{n810} have one HCI and all other
-machines have none.
-
-@anchor{bt-hcis}
-The following three types are recognized:
-
-@table @option
-@item -bt hci,null
-(default) The corresponding Bluetooth HCI assumes no internal logic
-and will not respond to any HCI commands or emit events.
-
-@item -bt hci,host[:@var{id}]
-(@code{bluez} only) The corresponding HCI passes commands / events
-to / from the physical HCI identified by the name @var{id} (default:
-@code{hci0}) on the computer running QEMU.  Only available on @code{blue=
z}
-capable systems like Linux.
-
-@item -bt hci[,vlan=3D@var{n}]
-Add a virtual, standard HCI that will participate in the Bluetooth
-scatternet @var{n} (default @code{0}).  Similarly to @option{-net}
-VLANs, devices inside a bluetooth network @var{n} can only communicate
-with other devices in the same network (scatternet).
-@end table
-
-@item -bt vhci[,vlan=3D@var{n}]
-(Linux-host only) Create a HCI in scatternet @var{n} (default 0) attache=
d
-to the host bluetooth stack instead of to the emulated target.  This
-allows the host and target machines to participate in a common scatterne=
t
-and communicate.  Requires the Linux @code{vhci} driver installed.  Can
-be used as following:
-
-@example
-qemu-system-i386 [...OPTIONS...] -bt hci,vlan=3D5 -bt vhci,vlan=3D5
-@end example
-
-@item -bt device:@var{dev}[,vlan=3D@var{n}]
-Emulate a bluetooth device @var{dev} and place it in network @var{n}
-(default @code{0}).  QEMU can only emulate one type of bluetooth devices
-currently:
-
-@table @option
-@item keyboard
-Virtual wireless keyboard implementing the HIDP bluetooth profile.
-@end table
-ETEXI
-
-STEXI
-@end table
-ETEXI
-DEFHEADING()
-
-#ifdef CONFIG_TPM
-DEFHEADING(TPM device options:)
-
-DEF("tpmdev", HAS_ARG, QEMU_OPTION_tpmdev, \
-    "-tpmdev passthrough,id=3Did[,path=3Dpath][,cancel-path=3Dpath]\n"
-    "                use path to provide path to a character device; def=
ault is /dev/tpm0\n"
-    "                use cancel-path to provide path to TPM's cancel sys=
fs entry; if\n"
-    "                not provided it will be searched for in /sys/class/=
misc/tpm?/device\n",
-    QEMU_ARCH_ALL)
-STEXI
-
-The general form of a TPM device option is:
-@table @option
-
-@item -tpmdev @var{backend} ,id=3D@var{id} [,@var{options}]
-@findex -tpmdev
-
-The specific backend type will determine the applicable options.
-The @code{-tpmdev} option creates the TPM backend and requires a
-@code{-device} option that specifies the TPM frontend interface model.
-
-Use @code{-tpmdev help} to print all available TPM backend types.
-
-@end table
-
-The available backends are:
-
-@table @option
-
-@item -tpmdev passthrough, id=3D@var{id}, path=3D@var{path}, cancel-path=
=3D@var{cancel-path}
-
-(Linux-host only) Enable access to the host's TPM using the passthrough
-driver.
-
-@option{path} specifies the path to the host's TPM device, i.e., on
-a Linux host this would be @code{/dev/tpm0}.
-@option{path} is optional and by default @code{/dev/tpm0} is used.
-
-@option{cancel-path} specifies the path to the host TPM device's sysfs
-entry allowing for cancellation of an ongoing TPM command.
-@option{cancel-path} is optional and by default QEMU will search for the
-sysfs entry to use.
-
-Some notes about using the host's TPM with the passthrough driver:
-
-The TPM device accessed by the passthrough driver must not be
-used by any other application on the host.
-
-Since the host's firmware (BIOS/UEFI) has already initialized the TPM,
-the VM's firmware (BIOS/UEFI) will not be able to initialize the
-TPM again and may therefore not show a TPM-specific menu that would
-otherwise allow the user to configure the TPM, e.g., allow the user to
-enable/disable or activate/deactivate the TPM.
-Further, if TPM ownership is released from within a VM then the host's T=
PM
-will get disabled and deactivated. To enable and activate the
-TPM again afterwards, the host has to be rebooted and the user is
-required to enter the firmware's menu to enable and activate the TPM.
-If the TPM is left disabled and/or deactivated most TPM commands will fa=
il.
-
-To create a passthrough TPM use the following two options:
-@example
--tpmdev passthrough,id=3Dtpm0 -device tpm-tis,tpmdev=3Dtpm0
-@end example
-Note that the @code{-tpmdev} id is @code{tpm0} and is referenced by
-@code{tpmdev=3Dtpm0} in the device option.
-
-ETEXI
-
-STEXI
-@end table
-ETEXI
-DEFHEADING()
-
-#endif
-
-DEFHEADING(Linux/Multiboot boot specific:)
-STEXI
-
-When using these options, you can use a given Linux or Multiboot
-kernel without installing it in the disk image. It can be useful
-for easier testing of various kernels.
-
-@table @option
-ETEXI
-
-DEF("kernel", HAS_ARG, QEMU_OPTION_kernel, \
-    "-kernel bzImage use 'bzImage' as kernel image\n", QEMU_ARCH_ALL)
-STEXI
-@item -kernel @var{bzImage}
-@findex -kernel
-Use @var{bzImage} as kernel image. The kernel can be either a Linux kern=
el
-or in multiboot format.
-ETEXI
-
-DEF("append", HAS_ARG, QEMU_OPTION_append, \
-    "-append cmdline use 'cmdline' as kernel command line\n", QEMU_ARCH_=
ALL)
-STEXI
-@item -append @var{cmdline}
-@findex -append
-Use @var{cmdline} as kernel command line
-ETEXI
-
-DEF("initrd", HAS_ARG, QEMU_OPTION_initrd, \
-           "-initrd file    use 'file' as initial ram disk\n", QEMU_ARCH=
_ALL)
-STEXI
-@item -initrd @var{file}
-@findex -initrd
-Use @var{file} as initial ram disk.
-
-@item -initrd "@var{file1} arg=3Dfoo,@var{file2}"
-
-This syntax is only available with multiboot.
-
-Use @var{file1} and @var{file2} as modules and pass arg=3Dfoo as paramet=
er to the
-first module.
-ETEXI
-
-DEF("dtb", HAS_ARG, QEMU_OPTION_dtb, \
-    "-dtb    file    use 'file' as device tree image\n", QEMU_ARCH_ALL)
-STEXI
-@item -dtb @var{file}
-@findex -dtb
-Use @var{file} as a device tree binary (dtb) image and pass it to the ke=
rnel
-on boot.
-ETEXI
-
-STEXI
-@end table
-ETEXI
-DEFHEADING()
-
-DEFHEADING(Debug/Expert options:)
-STEXI
-@table @option
-ETEXI
-
-DEF("fw_cfg", HAS_ARG, QEMU_OPTION_fwcfg,
-    "-fw_cfg [name=3D]<name>,file=3D<file>\n"
-    "                add named fw_cfg entry with contents from file\n"
-    "-fw_cfg [name=3D]<name>,string=3D<str>\n"
-    "                add named fw_cfg entry with contents from string\n"=
,
-    QEMU_ARCH_ALL)
-STEXI
-
-@item -fw_cfg [name=3D]@var{name},file=3D@var{file}
-@findex -fw_cfg
-Add named fw_cfg entry with contents from file @var{file}.
-
-@item -fw_cfg [name=3D]@var{name},string=3D@var{str}
-Add named fw_cfg entry with contents from string @var{str}.
-
-The terminating NUL character of the contents of @var{str} will not be
-included as part of the fw_cfg item data. To insert contents with
-embedded NUL characters, you have to use the @var{file} parameter.
-
-The fw_cfg entries are passed by QEMU through to the guest.
-
-Example:
-@example
-    -fw_cfg name=3Dopt/com.mycompany/blob,file=3D./my_blob.bin
-@end example
-creates an fw_cfg entry named opt/com.mycompany/blob with contents
-from ./my_blob.bin.
-
-ETEXI
-
-DEF("serial", HAS_ARG, QEMU_OPTION_serial, \
-    "-serial dev     redirect the serial port to char device 'dev'\n",
-    QEMU_ARCH_ALL)
-STEXI
-@item -serial @var{dev}
-@findex -serial
-Redirect the virtual serial port to host character device
-@var{dev}. The default device is @code{vc} in graphical mode and
-@code{stdio} in non graphical mode.
-
-This option can be used several times to simulate up to 4 serial
-ports.
-
-Use @code{-serial none} to disable all serial ports.
-
-Available character devices are:
-@table @option
-@item vc[:@var{W}x@var{H}]
-Virtual console. Optionally, a width and height can be given in pixel wi=
th
-@example
-vc:800x600
-@end example
-It is also possible to specify width or height in characters:
-@example
-vc:80Cx24C
-@end example
-@item pty
-[Linux only] Pseudo TTY (a new PTY is automatically allocated)
-@item none
-No device is allocated.
-@item null
-void device
-@item chardev:@var{id}
-Use a named character device defined with the @code{-chardev} option.
-@item /dev/XXX
-[Linux only] Use host tty, e.g. @file{/dev/ttyS0}. The host serial port
-parameters are set according to the emulated ones.
-@item /dev/parport@var{N}
-[Linux only, parallel port only] Use host parallel port
-@var{N}. Currently SPP and EPP parallel port features can be used.
-@item file:@var{filename}
-Write output to @var{filename}. No character can be read.
-@item stdio
-[Unix only] standard input/output
-@item pipe:@var{filename}
-name pipe @var{filename}
-@item COM@var{n}
-[Windows only] Use host serial port @var{n}
-@item udp:[@var{remote_host}]:@var{remote_port}[@@[@var{src_ip}]:@var{sr=
c_port}]
-This implements UDP Net Console.
-When @var{remote_host} or @var{src_ip} are not specified
-they default to @code{0.0.0.0}.
-When not using a specified @var{src_port} a random port is automatically=
 chosen.
-
-If you just want a simple readonly console you can use @code{netcat} or
-@code{nc}, by starting QEMU with: @code{-serial udp::4555} and nc as:
-@code{nc -u -l -p 4555}. Any time QEMU writes something to that port it
-will appear in the netconsole session.
-
-If you plan to send characters back via netconsole or you want to stop
-and start QEMU a lot of times, you should have QEMU use the same
-source port each time by using something like @code{-serial
-udp::4555@@:4556} to QEMU. Another approach is to use a patched
-version of netcat which can listen to a TCP port and send and receive
-characters via udp.  If you have a patched version of netcat which
-activates telnet remote echo and single char transfer, then you can
-use the following options to set up a netcat redirector to allow
-telnet on port 5555 to access the QEMU port.
-@table @code
-@item QEMU Options:
--serial udp::4555@@:4556
-@item netcat options:
--u -P 4555 -L 0.0.0.0:4556 -t -p 5555 -I -T
-@item telnet options:
-localhost 5555
-@end table
-
-@item tcp:[@var{host}]:@var{port}[,@var{server}][,nowait][,nodelay][,rec=
onnect=3D@var{seconds}]
-The TCP Net Console has two modes of operation.  It can send the serial
-I/O to a location or wait for a connection from a location.  By default
-the TCP Net Console is sent to @var{host} at the @var{port}.  If you use
-the @var{server} option QEMU will wait for a client socket application
-to connect to the port before continuing, unless the @code{nowait}
-option was specified.  The @code{nodelay} option disables the Nagle buff=
ering
-algorithm.  The @code{reconnect} option only applies if @var{noserver} i=
s
-set, if the connection goes down it will attempt to reconnect at the
-given interval.  If @var{host} is omitted, 0.0.0.0 is assumed. Only
-one TCP connection at a time is accepted. You can use @code{telnet} to
-connect to the corresponding character device.
-@table @code
-@item Example to send tcp console to 192.168.0.2 port 4444
--serial tcp:192.168.0.2:4444
-@item Example to listen and wait on port 4444 for connection
--serial tcp::4444,server
-@item Example to not wait and listen on ip 192.168.0.100 port 4444
--serial tcp:192.168.0.100:4444,server,nowait
-@end table
-
-@item telnet:@var{host}:@var{port}[,server][,nowait][,nodelay]
-The telnet protocol is used instead of raw tcp sockets.  The options
-work the same as if you had specified @code{-serial tcp}.  The
-difference is that the port acts like a telnet server or client using
-telnet option negotiation.  This will also allow you to send the
-MAGIC_SYSRQ sequence if you use a telnet that supports sending the break
-sequence.  Typically in unix telnet you do it with Control-] and then
-type "send break" followed by pressing the enter key.
-
-@item unix:@var{path}[,server][,nowait][,reconnect=3D@var{seconds}]
-A unix domain socket is used instead of a tcp socket.  The option works =
the
-same as if you had specified @code{-serial tcp} except the unix domain s=
ocket
-@var{path} is used for connections.
-
-@item mon:@var{dev_string}
-This is a special option to allow the monitor to be multiplexed onto
-another serial port.  The monitor is accessed with key sequence of
-@key{Control-a} and then pressing @key{c}.
-@var{dev_string} should be any one of the serial devices specified
-above.  An example to multiplex the monitor onto a telnet server
-listening on port 4444 would be:
-@table @code
-@item -serial mon:telnet::4444,server,nowait
-@end table
-When the monitor is multiplexed to stdio in this way, Ctrl+C will not te=
rminate
-QEMU any more but will be passed to the guest instead.
-
-@item braille
-Braille device.  This will use BrlAPI to display the braille output on a=
 real
-or fake device.
-
-@item msmouse
-Three button serial mouse. Configure the guest to use Microsoft protocol=
.
-@end table
-ETEXI
-
-DEF("parallel", HAS_ARG, QEMU_OPTION_parallel, \
-    "-parallel dev   redirect the parallel port to char device 'dev'\n",
-    QEMU_ARCH_ALL)
-STEXI
-@item -parallel @var{dev}
-@findex -parallel
-Redirect the virtual parallel port to host device @var{dev} (same
-devices as the serial port). On Linux hosts, @file{/dev/parportN} can
-be used to use hardware devices connected on the corresponding host
-parallel port.
-
-This option can be used several times to simulate up to 3 parallel
-ports.
-
-Use @code{-parallel none} to disable all parallel ports.
-ETEXI
-
-DEF("monitor", HAS_ARG, QEMU_OPTION_monitor, \
-    "-monitor dev    redirect the monitor to char device 'dev'\n",
-    QEMU_ARCH_ALL)
-STEXI
-@item -monitor @var{dev}
-@findex -monitor
-Redirect the monitor to host device @var{dev} (same devices as the
-serial port).
-The default device is @code{vc} in graphical mode and @code{stdio} in
-non graphical mode.
-Use @code{-monitor none} to disable the default monitor.
-ETEXI
-DEF("qmp", HAS_ARG, QEMU_OPTION_qmp, \
-    "-qmp dev        like -monitor but opens in 'control' mode\n",
-    QEMU_ARCH_ALL)
-STEXI
-@item -qmp @var{dev}
-@findex -qmp
-Like -monitor but opens in 'control' mode.
-ETEXI
-DEF("qmp-pretty", HAS_ARG, QEMU_OPTION_qmp_pretty, \
-    "-qmp-pretty dev like -qmp but uses pretty JSON formatting\n",
-    QEMU_ARCH_ALL)
-STEXI
-@item -qmp-pretty @var{dev}
-@findex -qmp-pretty
-Like -qmp but uses pretty JSON formatting.
-ETEXI
-
-DEF("mon", HAS_ARG, QEMU_OPTION_mon, \
-    "-mon [chardev=3D]name[,mode=3Dreadline|control]\n", QEMU_ARCH_ALL)
-STEXI
-@item -mon [chardev=3D]name[,mode=3Dreadline|control]
-@findex -mon
-Setup monitor on chardev @var{name}.
-ETEXI
-
-DEF("debugcon", HAS_ARG, QEMU_OPTION_debugcon, \
-    "-debugcon dev   redirect the debug console to char device 'dev'\n",
-    QEMU_ARCH_ALL)
-STEXI
-@item -debugcon @var{dev}
-@findex -debugcon
-Redirect the debug console to host device @var{dev} (same devices as the
-serial port).  The debug console is an I/O port which is typically port
-0xe9; writing to that I/O port sends output to this device.
-The default device is @code{vc} in graphical mode and @code{stdio} in
-non graphical mode.
-ETEXI
-
-DEF("pidfile", HAS_ARG, QEMU_OPTION_pidfile, \
-    "-pidfile file   write PID to 'file'\n", QEMU_ARCH_ALL)
-STEXI
-@item -pidfile @var{file}
-@findex -pidfile
-Store the QEMU process PID in @var{file}. It is useful if you launch QEM=
U
-from a script.
-ETEXI
-
-DEF("singlestep", 0, QEMU_OPTION_singlestep, \
-    "-singlestep     always run in singlestep mode\n", QEMU_ARCH_ALL)
-STEXI
-@item -singlestep
-@findex -singlestep
-Run the emulation in single step mode.
-ETEXI
-
-DEF("S", 0, QEMU_OPTION_S, \
-    "-S              freeze CPU at startup (use 'c' to start execution)\=
n",
-    QEMU_ARCH_ALL)
-STEXI
-@item -S
-@findex -S
-Do not start CPU at startup (you must type 'c' in the monitor).
-ETEXI
-
-DEF("realtime", HAS_ARG, QEMU_OPTION_realtime,
-    "-realtime [mlock=3Don|off]\n"
-    "                run qemu with realtime features\n"
-    "                mlock=3Don|off controls mlock support (default: on)=
\n",
-    QEMU_ARCH_ALL)
-STEXI
-@item -realtime mlock=3Don|off
-@findex -realtime
-Run qemu with realtime features.
-mlocking qemu and guest memory can be enabled via @option{mlock=3Don}
-(enabled by default).
-ETEXI
-
-DEF("gdb", HAS_ARG, QEMU_OPTION_gdb, \
-    "-gdb dev        wait for gdb connection on 'dev'\n", QEMU_ARCH_ALL)
-STEXI
-@item -gdb @var{dev}
-@findex -gdb
-Wait for gdb connection on device @var{dev} (@pxref{gdb_usage}). Typical
-connections will likely be TCP-based, but also UDP, pseudo TTY, or even
-stdio are reasonable use case. The latter is allowing to start QEMU from
-within gdb and establish the connection via a pipe:
-@example
-(gdb) target remote | exec qemu-system-i386 -gdb stdio ...
-@end example
-ETEXI
-
-DEF("s", 0, QEMU_OPTION_s, \
-    "-s              shorthand for -gdb tcp::" DEFAULT_GDBSTUB_PORT "\n"=
,
-    QEMU_ARCH_ALL)
-STEXI
-@item -s
-@findex -s
-Shorthand for -gdb tcp::1234, i.e. open a gdbserver on TCP port 1234
-(@pxref{gdb_usage}).
-ETEXI
-
-DEF("d", HAS_ARG, QEMU_OPTION_d, \
-    "-d item1,...    enable logging of specified items (use '-d help' fo=
r a list of log items)\n",
-    QEMU_ARCH_ALL)
-STEXI
-@item -d @var{item1}[,...]
-@findex -d
-Enable logging of specified items. Use '-d help' for a list of log items=
.
-ETEXI
-
-DEF("D", HAS_ARG, QEMU_OPTION_D, \
-    "-D logfile      output log to logfile (default stderr)\n",
-    QEMU_ARCH_ALL)
-STEXI
-@item -D @var{logfile}
-@findex -D
-Output log in @var{logfile} instead of to stderr
-ETEXI
-
-DEF("dfilter", HAS_ARG, QEMU_OPTION_DFILTER, \
-    "-dfilter range,..  filter debug output to range of addresses (usefu=
l for -d cpu,exec,etc..)\n",
-    QEMU_ARCH_ALL)
-STEXI
-@item -dfilter @var{range1}[,...]
-@findex -dfilter
-Filter debug output to that relevant to a range of target addresses. The=
 filter
-spec can be either @var{start}+@var{size}, @var{start}-@var{size} or
-@var{start}..@var{end} where @var{start} @var{end} and @var{size} are th=
e
-addresses and sizes required. For example:
-@example
-    -dfilter 0x8000..0x8fff,0xffffffc000080000+0x200,0xffffffc000060000-=
0x1000
-@end example
-Will dump output for any code in the 0x1000 sized block starting at 0x80=
00 and
-the 0x200 sized block starting at 0xffffffc000080000 and another 0x1000 =
sized
-block starting at 0xffffffc00005f000.
-ETEXI
-
-DEF("L", HAS_ARG, QEMU_OPTION_L, \
-    "-L path         set the directory for the BIOS, VGA BIOS and keymap=
s\n",
-    QEMU_ARCH_ALL)
-STEXI
-@item -L  @var{path}
-@findex -L
-Set the directory for the BIOS, VGA BIOS and keymaps.
-
-To list all the data directories, use @code{-L help}.
-ETEXI
-
-DEF("bios", HAS_ARG, QEMU_OPTION_bios, \
-    "-bios file      set the filename for the BIOS\n", QEMU_ARCH_ALL)
-STEXI
-@item -bios @var{file}
-@findex -bios
-Set the filename for the BIOS.
-ETEXI
-
-DEF("enable-kvm", 0, QEMU_OPTION_enable_kvm, \
-    "-enable-kvm     enable KVM full virtualization support\n", QEMU_ARC=
H_ALL)
-STEXI
-@item -enable-kvm
-@findex -enable-kvm
-Enable KVM full virtualization support. This option is only available
-if KVM support is enabled when compiling.
-ETEXI
-
-DEF("enable-hax", 0, QEMU_OPTION_enable_hax, \
-    "-enable-hax     enable HAX virtualization support\n", QEMU_ARCH_I38=
6)
-STEXI
-@item -enable-hax
-@findex -enable-hax
-Enable HAX (Hardware-based Acceleration eXecution) support. This option
-is only available if HAX support is enabled when compiling. HAX is only
-applicable to MAC and Windows platform, and thus does not conflict with
-KVM.
-ETEXI
-
-DEF("xen-domid", HAS_ARG, QEMU_OPTION_xen_domid,
-    "-xen-domid id   specify xen guest domain id\n", QEMU_ARCH_ALL)
-DEF("xen-create", 0, QEMU_OPTION_xen_create,
-    "-xen-create     create domain using xen hypercalls, bypassing xend\=
n"
-    "                warning: should not be used when xend is in use\n",
-    QEMU_ARCH_ALL)
-DEF("xen-attach", 0, QEMU_OPTION_xen_attach,
-    "-xen-attach     attach to existing xen domain\n"
-    "                xend will use this when starting QEMU\n",
-    QEMU_ARCH_ALL)
-DEF("xen-domid-restrict", 0, QEMU_OPTION_xen_domid_restrict,
-    "-xen-domid-restrict     restrict set of available xen operations\n"
-    "                        to specified domain id. (Does not affect\n"
-    "                        xenpv machine type).\n",
-    QEMU_ARCH_ALL)
-STEXI
-@item -xen-domid @var{id}
-@findex -xen-domid
-Specify xen guest domain @var{id} (XEN only).
-@item -xen-create
-@findex -xen-create
-Create domain using xen hypercalls, bypassing xend.
-Warning: should not be used when xend is in use (XEN only).
-@item -xen-attach
-@findex -xen-attach
-Attach to existing xen domain.
-xend will use this when starting QEMU (XEN only).
-@findex -xen-domid-restrict
-Restrict set of available xen operations to specified domain id (XEN onl=
y).
-ETEXI
-
-DEF("no-reboot", 0, QEMU_OPTION_no_reboot, \
-    "-no-reboot      exit instead of rebooting\n", QEMU_ARCH_ALL)
-STEXI
-@item -no-reboot
-@findex -no-reboot
-Exit instead of rebooting.
-ETEXI
-
-DEF("no-shutdown", 0, QEMU_OPTION_no_shutdown, \
-    "-no-shutdown    stop before shutdown\n", QEMU_ARCH_ALL)
-STEXI
-@item -no-shutdown
-@findex -no-shutdown
-Don't exit QEMU on guest shutdown, but instead only stop the emulation.
-This allows for instance switching to monitor to commit changes to the
-disk image.
-ETEXI
-
-DEF("loadvm", HAS_ARG, QEMU_OPTION_loadvm, \
-    "-loadvm [tag|id]\n" \
-    "                start right away with a saved state (loadvm in moni=
tor)\n",
-    QEMU_ARCH_ALL)
-STEXI
-@item -loadvm @var{file}
-@findex -loadvm
-Start right away with a saved state (@code{loadvm} in monitor)
-ETEXI
-
-#ifndef _WIN32
-DEF("daemonize", 0, QEMU_OPTION_daemonize, \
-    "-daemonize      daemonize QEMU after initializing\n", QEMU_ARCH_ALL=
)
-#endif
-STEXI
-@item -daemonize
-@findex -daemonize
-Daemonize the QEMU process after initialization.  QEMU will not detach f=
rom
-standard IO until it is ready to receive connections on any of its devic=
es.
-This option is a useful way for external programs to launch QEMU without=
 having
-to cope with initialization race conditions.
-ETEXI
-
-DEF("option-rom", HAS_ARG, QEMU_OPTION_option_rom, \
-    "-option-rom rom load a file, rom, into the option ROM space\n",
-    QEMU_ARCH_ALL)
-STEXI
-@item -option-rom @var{file}
-@findex -option-rom
-Load the contents of @var{file} as an option ROM.
-This option is useful to load things like EtherBoot.
-ETEXI
-
-HXCOMM Silently ignored for compatibility
-DEF("clock", HAS_ARG, QEMU_OPTION_clock, "", QEMU_ARCH_ALL)
-
-HXCOMM Options deprecated by -rtc
-DEF("localtime", 0, QEMU_OPTION_localtime, "", QEMU_ARCH_ALL)
-DEF("startdate", HAS_ARG, QEMU_OPTION_startdate, "", QEMU_ARCH_ALL)
-
-DEF("rtc", HAS_ARG, QEMU_OPTION_rtc, \
-    "-rtc [base=3Dutc|localtime|date][,clock=3Dhost|rt|vm][,driftfix=3Dn=
one|slew]\n" \
-    "                set the RTC base and clock, enable drift fix for cl=
ock ticks (x86 only)\n",
-    QEMU_ARCH_ALL)
-
-STEXI
-
-@item -rtc [base=3Dutc|localtime|@var{date}][,clock=3Dhost|vm][,driftfix=
=3Dnone|slew]
-@findex -rtc
-Specify @option{base} as @code{utc} or @code{localtime} to let the RTC s=
tart at the current
-UTC or local time, respectively. @code{localtime} is required for correc=
t date in
-MS-DOS or Windows. To start at a specific point in time, provide @var{da=
te} in the
-format @code{2006-06-17T16:01:21} or @code{2006-06-17}. The default base=
 is UTC.
-
-By default the RTC is driven by the host system time. This allows using =
of the
-RTC as accurate reference clock inside the guest, specifically if the ho=
st
-time is smoothly following an accurate external reference clock, e.g. vi=
a NTP.
-If you want to isolate the guest time from the host, you can set @option=
{clock}
-to @code{rt} instead.  To even prevent it from progressing during suspen=
sion,
-you can set it to @code{vm}.
-
-Enable @option{driftfix} (i386 targets only) if you experience time drif=
t problems,
-specifically with Windows' ACPI HAL. This option will try to figure out =
how
-many timer interrupts were not processed by the Windows guest and will
-re-inject them.
-ETEXI
-
-DEF("icount", HAS_ARG, QEMU_OPTION_icount, \
-    "-icount [shift=3DN|auto][,align=3Don|off][,sleep=3Don|off,rr=3Dreco=
rd|replay,rrfile=3D<filename>,rrsnapshot=3D<snapshot>]\n" \
-    "                enable virtual instruction counter with 2^N clock t=
icks per\n" \
-    "                instruction, enable aligning the host and virtual c=
locks\n" \
-    "                or disable real time cpu sleeping\n", QEMU_ARCH_ALL=
)
-STEXI
-@item -icount [shift=3D@var{N}|auto][,rr=3Drecord|replay,rrfile=3D@var{f=
ilename},rrsnapshot=3D@var{snapshot}]
-@findex -icount
-Enable virtual instruction counter.  The virtual cpu will execute one
-instruction every 2^@var{N} ns of virtual time.  If @code{auto} is speci=
fied
-then the virtual cpu speed will be automatically adjusted to keep virtua=
l
-time within a few seconds of real time.
-
-When the virtual cpu is sleeping, the virtual time will advance at defau=
lt
-speed unless @option{sleep=3Don|off} is specified.
-With @option{sleep=3Don|off}, the virtual time will jump to the next tim=
er deadline
-instantly whenever the virtual cpu goes to sleep mode and will not advan=
ce
-if no timer is enabled. This behavior give deterministic execution times=
 from
-the guest point of view.
-
-Note that while this option can give deterministic behavior, it does not
-provide cycle accurate emulation.  Modern CPUs contain superscalar out o=
f
-order cores with complex cache hierarchies.  The number of instructions
-executed often has little or no correlation with actual performance.
-
-@option{align=3Don} will activate the delay algorithm which will try
-to synchronise the host clock and the virtual clock. The goal is to
-have a guest running at the real frequency imposed by the shift option.
-Whenever the guest clock is behind the host clock and if
-@option{align=3Don} is specified then we print a message to the user
-to inform about the delay.
-Currently this option does not work when @option{shift} is @code{auto}.
-Note: The sync algorithm will work for those shift values for which
-the guest clock runs ahead of the host clock. Typically this happens
-when the shift value is high (how high depends on the host machine).
-
-When @option{rr} option is specified deterministic record/replay is enab=
led.
-Replay log is written into @var{filename} file in record mode and
-read from this file in replay mode.
-
-Option rrsnapshot is used to create new vm snapshot named @var{snapshot}
-at the start of execution recording. In replay mode this option is used
-to load the initial VM state.
-ETEXI
-
-DEF("watchdog", HAS_ARG, QEMU_OPTION_watchdog, \
-    "-watchdog model\n" \
-    "                enable virtual hardware watchdog [default=3Dnone]\n=
",
-    QEMU_ARCH_ALL)
-STEXI
-@item -watchdog @var{model}
-@findex -watchdog
-Create a virtual hardware watchdog device.  Once enabled (by a guest
-action), the watchdog must be periodically polled by an agent inside
-the guest or else the guest will be restarted. Choose a model for
-which your guest has drivers.
-
-The @var{model} is the model of hardware watchdog to emulate. Use
-@code{-watchdog help} to list available hardware models. Only one
-watchdog can be enabled for a guest.
-
-The following models may be available:
-@table @option
-@item ib700
-iBASE 700 is a very simple ISA watchdog with a single timer.
-@item i6300esb
-Intel 6300ESB I/O controller hub is a much more featureful PCI-based
-dual-timer watchdog.
-@item diag288
-A virtual watchdog for s390x backed by the diagnose 288 hypercall
-(currently KVM only).
-@end table
-ETEXI
-
-DEF("watchdog-action", HAS_ARG, QEMU_OPTION_watchdog_action, \
-    "-watchdog-action reset|shutdown|poweroff|inject-nmi|pause|debug|non=
e\n" \
-    "                action when watchdog fires [default=3Dreset]\n",
-    QEMU_ARCH_ALL)
-STEXI
-@item -watchdog-action @var{action}
-@findex -watchdog-action
-
-The @var{action} controls what QEMU will do when the watchdog timer
-expires.
-The default is
-@code{reset} (forcefully reset the guest).
-Other possible actions are:
-@code{shutdown} (attempt to gracefully shutdown the guest),
-@code{poweroff} (forcefully poweroff the guest),
-@code{inject-nmi} (inject a NMI into the guest),
-@code{pause} (pause the guest),
-@code{debug} (print a debug message and continue), or
-@code{none} (do nothing).
-
-Note that the @code{shutdown} action requires that the guest responds
-to ACPI signals, which it may not be able to do in the sort of
-situations where the watchdog would have expired, and thus
-@code{-watchdog-action shutdown} is not recommended for production use.
-
-Examples:
-
-@table @code
-@item -watchdog i6300esb -watchdog-action pause
-@itemx -watchdog ib700
-@end table
-ETEXI
-
-DEF("echr", HAS_ARG, QEMU_OPTION_echr, \
-    "-echr chr       set terminal escape character instead of ctrl-a\n",
-    QEMU_ARCH_ALL)
-STEXI
-
-@item -echr @var{numeric_ascii_value}
-@findex -echr
-Change the escape character used for switching to the monitor when using
-monitor and serial sharing.  The default is @code{0x01} when using the
-@code{-nographic} option.  @code{0x01} is equal to pressing
-@code{Control-a}.  You can select a different character from the ascii
-control keys where 1 through 26 map to Control-a through Control-z.  For
-instance you could use the either of the following to change the escape
-character to Control-t.
-@table @code
-@item -echr 0x14
-@itemx -echr 20
-@end table
-ETEXI
-
-DEF("virtioconsole", HAS_ARG, QEMU_OPTION_virtiocon, \
-    "-virtioconsole c\n" \
-    "                set virtio console\n", QEMU_ARCH_ALL)
-STEXI
-@item -virtioconsole @var{c}
-@findex -virtioconsole
-Set virtio console.
-
-This option is maintained for backward compatibility.
-
-Please use @code{-device virtconsole} for the new way of invocation.
-ETEXI
-
-DEF("show-cursor", 0, QEMU_OPTION_show_cursor, \
-    "-show-cursor    show cursor\n", QEMU_ARCH_ALL)
-STEXI
-@item -show-cursor
-@findex -show-cursor
-Show cursor.
-ETEXI
-
-DEF("tb-size", HAS_ARG, QEMU_OPTION_tb_size, \
-    "-tb-size n      set TB size\n", QEMU_ARCH_ALL)
-STEXI
-@item -tb-size @var{n}
-@findex -tb-size
-Set TB size.
-ETEXI
-
-DEF("incoming", HAS_ARG, QEMU_OPTION_incoming, \
-    "-incoming tcp:[host]:port[,to=3Dmaxport][,ipv4][,ipv6]\n" \
-    "-incoming rdma:host:port[,ipv4][,ipv6]\n" \
-    "-incoming unix:socketpath\n" \
-    "                prepare for incoming migration, listen on\n" \
-    "                specified protocol and socket address\n" \
-    "-incoming fd:fd\n" \
-    "-incoming exec:cmdline\n" \
-    "                accept incoming migration on given file descriptor\=
n" \
-    "                or from given external command\n" \
-    "-incoming defer\n" \
-    "                wait for the URI to be specified via migrate_incomi=
ng\n",
-    QEMU_ARCH_ALL)
-STEXI
-@item -incoming tcp:[@var{host}]:@var{port}[,to=3D@var{maxport}][,ipv4][=
,ipv6]
-@itemx -incoming rdma:@var{host}:@var{port}[,ipv4][,ipv6]
-@findex -incoming
-Prepare for incoming migration, listen on a given tcp port.
-
-@item -incoming unix:@var{socketpath}
-Prepare for incoming migration, listen on a given unix socket.
-
-@item -incoming fd:@var{fd}
-Accept incoming migration from a given filedescriptor.
-
-@item -incoming exec:@var{cmdline}
-Accept incoming migration as an output from specified external command.
-
-@item -incoming defer
-Wait for the URI to be specified via migrate_incoming.  The monitor can
-be used to change settings (such as migration parameters) prior to issui=
ng
-the migrate_incoming to allow the migration to begin.
-ETEXI
-
-DEF("only-migratable", 0, QEMU_OPTION_only_migratable, \
-    "-only-migratable     allow only migratable devices\n", QEMU_ARCH_AL=
L)
-STEXI
-@item -only-migratable
-@findex -only-migratable
-Only allow migratable devices. Devices will not be allowed to enter an
-unmigratable state.
-ETEXI
-
-DEF("nodefaults", 0, QEMU_OPTION_nodefaults, \
-    "-nodefaults     don't create default devices\n", QEMU_ARCH_ALL)
-STEXI
-@item -nodefaults
-@findex -nodefaults
-Don't create default devices. Normally, QEMU sets the default devices li=
ke serial
-port, parallel port, virtual console, monitor device, VGA adapter, flopp=
y and
-CD-ROM drive and others. The @code{-nodefaults} option will disable all =
those
-default devices.
-ETEXI
-
-#ifndef _WIN32
-DEF("chroot", HAS_ARG, QEMU_OPTION_chroot, \
-    "-chroot dir     chroot to dir just before starting the VM\n",
-    QEMU_ARCH_ALL)
-#endif
-STEXI
-@item -chroot @var{dir}
-@findex -chroot
-Immediately before starting guest execution, chroot to the specified
-directory.  Especially useful in combination with -runas.
-ETEXI
-
-#ifndef _WIN32
-DEF("runas", HAS_ARG, QEMU_OPTION_runas, \
-    "-runas user     change to user id user just before starting the VM\=
n",
-    QEMU_ARCH_ALL)
-#endif
-STEXI
-@item -runas @var{user}
-@findex -runas
-Immediately before starting guest execution, drop root privileges, switc=
hing
-to the specified user.
-ETEXI
-
-DEF("prom-env", HAS_ARG, QEMU_OPTION_prom_env,
-    "-prom-env variable=3Dvalue\n"
-    "                set OpenBIOS nvram variables\n",
-    QEMU_ARCH_PPC | QEMU_ARCH_SPARC)
-STEXI
-@item -prom-env @var{variable}=3D@var{value}
-@findex -prom-env
-Set OpenBIOS nvram @var{variable} to given @var{value} (PPC, SPARC only)=
.
-ETEXI
-DEF("semihosting", 0, QEMU_OPTION_semihosting,
-    "-semihosting    semihosting mode\n",
-    QEMU_ARCH_ARM | QEMU_ARCH_M68K | QEMU_ARCH_XTENSA | QEMU_ARCH_LM32 |
-    QEMU_ARCH_MIPS)
-STEXI
-@item -semihosting
-@findex -semihosting
-Enable semihosting mode (ARM, M68K, Xtensa, MIPS only).
-ETEXI
-DEF("semihosting-config", HAS_ARG, QEMU_OPTION_semihosting_config,
-    "-semihosting-config [enable=3Don|off][,target=3Dnative|gdb|auto][,a=
rg=3Dstr[,...]]\n" \
-    "                semihosting configuration\n",
-QEMU_ARCH_ARM | QEMU_ARCH_M68K | QEMU_ARCH_XTENSA | QEMU_ARCH_LM32 |
-QEMU_ARCH_MIPS)
-STEXI
-@item -semihosting-config [enable=3Don|off][,target=3Dnative|gdb|auto][,=
arg=3Dstr[,...]]
-@findex -semihosting-config
-Enable and configure semihosting (ARM, M68K, Xtensa, MIPS only).
-@table @option
-@item target=3D@code{native|gdb|auto}
-Defines where the semihosting calls will be addressed, to QEMU (@code{na=
tive})
-or to GDB (@code{gdb}). The default is @code{auto}, which means @code{gd=
b}
-during debug sessions and @code{native} otherwise.
-@item arg=3D@var{str1},arg=3D@var{str2},...
-Allows the user to pass input arguments, and can be used multiple times =
to build
-up a list. The old-style @code{-kernel}/@code{-append} method of passing=
 a
-command line is still supported for backward compatibility. If both the
-@code{--semihosting-config arg} and the @code{-kernel}/@code{-append} ar=
e
-specified, the former is passed to semihosting as it always takes preced=
ence.
-@end table
-ETEXI
-DEF("old-param", 0, QEMU_OPTION_old_param,
-    "-old-param      old param mode\n", QEMU_ARCH_ARM)
-STEXI
-@item -old-param
-@findex -old-param (ARM)
-Old param mode (ARM only).
-ETEXI
-
-DEF("sandbox", HAS_ARG, QEMU_OPTION_sandbox, \
-    "-sandbox on[,obsolete=3Dallow|deny][,elevateprivileges=3Dallow|deny=
|children]\n" \
-    "          [,spawn=3Dallow|deny][,resourcecontrol=3Dallow|deny]\n" \
-    "                Enable seccomp mode 2 system call filter (default '=
off').\n" \
-    "                use 'obsolete' to allow obsolete system calls that =
are provided\n" \
-    "                    by the kernel, but typically no longer used by =
modern\n" \
-    "                    C library implementations.\n" \
-    "                use 'elevateprivileges' to allow or deny QEMU proce=
ss to elevate\n" \
-    "                    its privileges by blacklisting all set*uid|gid =
system calls.\n" \
-    "                    The value 'children' will deny set*uid|gid syst=
em calls for\n" \
-    "                    main QEMU process but will allow forks and exec=
ves to run unprivileged\n" \
-    "                use 'spawn' to avoid QEMU to spawn new threads or p=
rocesses by\n" \
-    "                     blacklisting *fork and execve\n" \
-    "                use 'resourcecontrol' to disable process affinity a=
nd schedular priority\n",
-    QEMU_ARCH_ALL)
-STEXI
-@item -sandbox @var{arg}[,obsolete=3D@var{string}][,elevateprivileges=3D=
@var{string}][,spawn=3D@var{string}][,resourcecontrol=3D@var{string}]
-@findex -sandbox
-Enable Seccomp mode 2 system call filter. 'on' will enable syscall filte=
ring and 'off' will
-disable it.  The default is 'off'.
-@table @option
-@item obsolete=3D@var{string}
-Enable Obsolete system calls
-@item elevateprivileges=3D@var{string}
-Disable set*uid|gid system calls
-@item spawn=3D@var{string}
-Disable *fork and execve
-@item resourcecontrol=3D@var{string}
-Disable process affinity and schedular priority
-@end table
-ETEXI
-
-DEF("readconfig", HAS_ARG, QEMU_OPTION_readconfig,
-    "-readconfig <file>\n", QEMU_ARCH_ALL)
-STEXI
-@item -readconfig @var{file}
-@findex -readconfig
-Read device configuration from @var{file}. This approach is useful when =
you want to spawn
-QEMU process with many command line options but you don't want to exceed=
 the command line
-character limit.
-ETEXI
-DEF("writeconfig", HAS_ARG, QEMU_OPTION_writeconfig,
-    "-writeconfig <file>\n"
-    "                read/write config file\n", QEMU_ARCH_ALL)
-STEXI
-@item -writeconfig @var{file}
-@findex -writeconfig
-Write device configuration to @var{file}. The @var{file} can be either f=
ilename to save
-command line and device configuration into file or dash @code{-}) charac=
ter to print the
-output to stdout. This can be later used as input file for @code{-readco=
nfig} option.
-ETEXI
-DEF("nodefconfig", 0, QEMU_OPTION_nodefconfig,
-    "-nodefconfig\n"
-    "                do not load default config files at startup\n",
-    QEMU_ARCH_ALL)
-STEXI
-@item -nodefconfig
-@findex -nodefconfig
-Normally QEMU loads configuration files from @var{sysconfdir} and @var{d=
atadir} at startup.
-The @code{-nodefconfig} option will prevent QEMU from loading any of tho=
se config files.
-ETEXI
-DEF("no-user-config", 0, QEMU_OPTION_nouserconfig,
-    "-no-user-config\n"
-    "                do not load user-provided config files at startup\n=
",
-    QEMU_ARCH_ALL)
-STEXI
-@item -no-user-config
-@findex -no-user-config
-The @code{-no-user-config} option makes QEMU not load any of the user-pr=
ovided
-config files on @var{sysconfdir}, but won't make it skip the QEMU-provid=
ed config
-files from @var{datadir}.
-ETEXI
-DEF("trace", HAS_ARG, QEMU_OPTION_trace,
-    "-trace [[enable=3D]<pattern>][,events=3D<file>][,file=3D<file>]\n"
-    "                specify tracing options\n",
-    QEMU_ARCH_ALL)
-STEXI
-HXCOMM This line is not accurate, as some sub-options are backend-specif=
ic but
-HXCOMM HX does not support conditional compilation of text.
-@item -trace [[enable=3D]@var{pattern}][,events=3D@var{file}][,file=3D@v=
ar{file}]
-@findex -trace
-@include qemu-option-trace.texi
-ETEXI
-
-HXCOMM Internal use
-DEF("qtest", HAS_ARG, QEMU_OPTION_qtest, "", QEMU_ARCH_ALL)
-DEF("qtest-log", HAS_ARG, QEMU_OPTION_qtest_log, "", QEMU_ARCH_ALL)
-
-#ifdef __linux__
-DEF("enable-fips", 0, QEMU_OPTION_enablefips,
-    "-enable-fips    enable FIPS 140-2 compliance\n",
-    QEMU_ARCH_ALL)
-#endif
-STEXI
-@item -enable-fips
-@findex -enable-fips
-Enable FIPS 140-2 compliance mode.
-ETEXI
-
-HXCOMM Deprecated by -machine accel=3Dtcg property
-DEF("no-kvm", 0, QEMU_OPTION_no_kvm, "", QEMU_ARCH_I386)
-
-HXCOMM Deprecated by kvm-pit driver properties
-DEF("no-kvm-pit-reinjection", 0, QEMU_OPTION_no_kvm_pit_reinjection,
-    "", QEMU_ARCH_I386)
-
-HXCOMM Deprecated (ignored)
-DEF("no-kvm-pit", 0, QEMU_OPTION_no_kvm_pit, "", QEMU_ARCH_I386)
-
-HXCOMM Deprecated by -machine kernel_irqchip=3Don|off property
-DEF("no-kvm-irqchip", 0, QEMU_OPTION_no_kvm_irqchip, "", QEMU_ARCH_I386)
-
-HXCOMM Deprecated (ignored)
-DEF("tdf", 0, QEMU_OPTION_tdf,"", QEMU_ARCH_ALL)
-
-DEF("msg", HAS_ARG, QEMU_OPTION_msg,
-    "-msg timestamp[=3Don|off]\n"
-    "                change the format of messages\n"
-    "                on|off controls leading timestamps (default:on)\n",
-    QEMU_ARCH_ALL)
-STEXI
-@item -msg timestamp[=3Don|off]
-@findex -msg
-prepend a timestamp to each log message.(default:on)
-ETEXI
-
-DEF("dump-vmstate", HAS_ARG, QEMU_OPTION_dump_vmstate,
-    "-dump-vmstate <file>\n"
-    "                Output vmstate information in JSON format to file.\=
n"
-    "                Use the scripts/vmstate-static-checker.py file to\n=
"
-    "                check for possible regressions in migration code\n"
-    "                by comparing two such vmstate dumps.\n",
-    QEMU_ARCH_ALL)
-STEXI
-@item -dump-vmstate @var{file}
-@findex -dump-vmstate
-Dump json-encoded vmstate information for current machine type to file
-in @var{file}
-ETEXI
-
-STEXI
-@end table
-ETEXI
-DEFHEADING()
-
-DEFHEADING(Generic object creation:)
-STEXI
-@table @option
-ETEXI
-
-DEF("object", HAS_ARG, QEMU_OPTION_object,
-    "-object TYPENAME[,PROP1=3DVALUE1,...]\n"
-    "                create a new object of type TYPENAME setting proper=
ties\n"
-    "                in the order they are specified.  Note that the 'id=
'\n"
-    "                property must be set.  These objects are placed in =
the\n"
-    "                '/objects' path.\n",
-    QEMU_ARCH_ALL)
-STEXI
-@item -object @var{typename}[,@var{prop1}=3D@var{value1},...]
-@findex -object
-Create a new object of type @var{typename} setting properties
-in the order they are specified.  Note that the 'id'
-property must be set.  These objects are placed in the
-'/objects' path.
-
-@table @option
-
-@item -object memory-backend-file,id=3D@var{id},size=3D@var{size},mem-pa=
th=3D@var{dir},share=3D@var{on|off},discard-data=3D@var{on|off}
-
-Creates a memory file backend object, which can be used to back
-the guest RAM with huge pages. The @option{id} parameter is a
-unique ID that will be used to reference this memory region
-when configuring the @option{-numa} argument. The @option{size}
-option provides the size of the memory region, and accepts
-common suffixes, eg @option{500M}. The @option{mem-path} provides
-the path to either a shared memory or huge page filesystem mount.
-The @option{share} boolean option determines whether the memory
-region is marked as private to QEMU, or shared. The latter allows
-a co-operating external process to access the QEMU memory region.
-Setting the @option{discard-data} boolean option to @var{on}
-indicates that file contents can be destroyed when QEMU exits,
-to avoid unnecessarily flushing data to the backing file.  Note
-that @option{discard-data} is only an optimization, and QEMU
-might not discard file contents if it aborts unexpectedly or is
-terminated using SIGKILL.
-
-@item -object rng-random,id=3D@var{id},filename=3D@var{/dev/random}
-
-Creates a random number generator backend which obtains entropy from
-a device on the host. The @option{id} parameter is a unique ID that
-will be used to reference this entropy backend from the @option{virtio-r=
ng}
-device. The @option{filename} parameter specifies which file to obtain
-entropy from and if omitted defaults to @option{/dev/random}.
-
-@item -object rng-egd,id=3D@var{id},chardev=3D@var{chardevid}
-
-Creates a random number generator backend which obtains entropy from
-an external daemon running on the host. The @option{id} parameter is
-a unique ID that will be used to reference this entropy backend from
-the @option{virtio-rng} device. The @option{chardev} parameter is
-the unique ID of a character device backend that provides the connection
-to the RNG daemon.
-
-@item -object tls-creds-anon,id=3D@var{id},endpoint=3D@var{endpoint},dir=
=3D@var{/path/to/cred/dir},verify-peer=3D@var{on|off}
-
-Creates a TLS anonymous credentials object, which can be used to provide
-TLS support on network backends. The @option{id} parameter is a unique
-ID which network backends will use to access the credentials. The
-@option{endpoint} is either @option{server} or @option{client} depending
-on whether the QEMU network backend that uses the credentials will be
-acting as a client or as a server. If @option{verify-peer} is enabled
-(the default) then once the handshake is completed, the peer credentials
-will be verified, though this is a no-op for anonymous credentials.
-
-The @var{dir} parameter tells QEMU where to find the credential
-files. For server endpoints, this directory may contain a file
-@var{dh-params.pem} providing diffie-hellman parameters to use
-for the TLS server. If the file is missing, QEMU will generate
-a set of DH parameters at startup. This is a computationally
-expensive operation that consumes random pool entropy, so it is
-recommended that a persistent set of parameters be generated
-upfront and saved.
-
-@item -object tls-creds-x509,id=3D@var{id},endpoint=3D@var{endpoint},dir=
=3D@var{/path/to/cred/dir},verify-peer=3D@var{on|off},passwordid=3D@var{i=
d}
-
-Creates a TLS anonymous credentials object, which can be used to provide
-TLS support on network backends. The @option{id} parameter is a unique
-ID which network backends will use to access the credentials. The
-@option{endpoint} is either @option{server} or @option{client} depending
-on whether the QEMU network backend that uses the credentials will be
-acting as a client or as a server. If @option{verify-peer} is enabled
-(the default) then once the handshake is completed, the peer credentials
-will be verified. With x509 certificates, this implies that the clients
-must be provided with valid client certificates too.
-
-The @var{dir} parameter tells QEMU where to find the credential
-files. For server endpoints, this directory may contain a file
-@var{dh-params.pem} providing diffie-hellman parameters to use
-for the TLS server. If the file is missing, QEMU will generate
-a set of DH parameters at startup. This is a computationally
-expensive operation that consumes random pool entropy, so it is
-recommended that a persistent set of parameters be generated
-upfront and saved.
-
-For x509 certificate credentials the directory will contain further file=
s
-providing the x509 certificates. The certificates must be stored
-in PEM format, in filenames @var{ca-cert.pem}, @var{ca-crl.pem} (optiona=
l),
-@var{server-cert.pem} (only servers), @var{server-key.pem} (only servers=
),
-@var{client-cert.pem} (only clients), and @var{client-key.pem} (only cli=
ents).
-
-For the @var{server-key.pem} and @var{client-key.pem} files which
-contain sensitive private keys, it is possible to use an encrypted
-version by providing the @var{passwordid} parameter. This provides
-the ID of a previously created @code{secret} object containing the
-password for decryption.
-
-@item -object filter-buffer,id=3D@var{id},netdev=3D@var{netdevid},interv=
al=3D@var{t}[,queue=3D@var{all|rx|tx}][,status=3D@var{on|off}]
-
-Interval @var{t} can't be 0, this filter batches the packet delivery: al=
l
-packets arriving in a given interval on netdev @var{netdevid} are delaye=
d
-until the end of the interval. Interval is in microseconds.
-@option{status} is optional that indicate whether the netfilter is
-on (enabled) or off (disabled), the default status for netfilter will be=
 'on'.
-
-queue @var{all|rx|tx} is an option that can be applied to any netfilter.
-
-@option{all}: the filter is attached both to the receive and the transmi=
t
-              queue of the netdev (default).
-
-@option{rx}: the filter is attached to the receive queue of the netdev,
-             where it will receive packets sent to the netdev.
-
-@option{tx}: the filter is attached to the transmit queue of the netdev,
-             where it will receive packets sent by the netdev.
-
-@item -object filter-mirror,id=3D@var{id},netdev=3D@var{netdevid},outdev=
=3D@var{chardevid},queue=3D@var{all|rx|tx}[,vnet_hdr_support]
-
-filter-mirror on netdev @var{netdevid},mirror net packet to chardev@var{=
chardevid}, if it has the vnet_hdr_support flag, filter-mirror will mirro=
r packet with vnet_hdr_len.
-
-@item -object filter-redirector,id=3D@var{id},netdev=3D@var{netdevid},in=
dev=3D@var{chardevid},outdev=3D@var{chardevid},queue=3D@var{all|rx|tx}[,v=
net_hdr_support]
-
-filter-redirector on netdev @var{netdevid},redirect filter's net packet =
to chardev
-@var{chardevid},and redirect indev's packet to filter.if it has the vnet=
_hdr_support flag,
-filter-redirector will redirect packet with vnet_hdr_len.
-Create a filter-redirector we need to differ outdev id from indev id, id=
 can not
-be the same. we can just use indev or outdev, but at least one of indev =
or outdev
-need to be specified.
-
-@item -object filter-rewriter,id=3D@var{id},netdev=3D@var{netdevid},queu=
e=3D@var{all|rx|tx},[vnet_hdr_support]
-
-Filter-rewriter is a part of COLO project.It will rewrite tcp packet to
-secondary from primary to keep secondary tcp connection,and rewrite
-tcp packet to primary from secondary make tcp packet can be handled by
-client.if it has the vnet_hdr_support flag, we can parse packet with vne=
t header.
-
-usage:
-colo secondary:
--object filter-redirector,id=3Df1,netdev=3Dhn0,queue=3Dtx,indev=3Dred0
--object filter-redirector,id=3Df2,netdev=3Dhn0,queue=3Drx,outdev=3Dred1
--object filter-rewriter,id=3Drew0,netdev=3Dhn0,queue=3Dall
-
-@item -object filter-dump,id=3D@var{id},netdev=3D@var{dev}[,file=3D@var{=
filename}][,maxlen=3D@var{len}]
-
-Dump the network traffic on netdev @var{dev} to the file specified by
-@var{filename}. At most @var{len} bytes (64k by default) per packet are =
stored.
-The file format is libpcap, so it can be analyzed with tools such as tcp=
dump
-or Wireshark.
-
-@item -object colo-compare,id=3D@var{id},primary_in=3D@var{chardevid},se=
condary_in=3D@var{chardevid},outdev=3D@var{chardevid}[,vnet_hdr_support]
-
-Colo-compare gets packet from primary_in@var{chardevid} and secondary_in=
@var{chardevid}, than compare primary packet with
-secondary packet. If the packets are same, we will output primary
-packet to outdev@var{chardevid}, else we will notify colo-frame
-do checkpoint and send primary packet to outdev@var{chardevid}.
-if it has the vnet_hdr_support flag, colo compare will send/recv packet =
with vnet_hdr_len.
-
-we must use it with the help of filter-mirror and filter-redirector.
-
-@example
-
-primary:
--netdev tap,id=3Dhn0,vhost=3Doff,script=3D/etc/qemu-ifup,downscript=3D/e=
tc/qemu-ifdown
--device e1000,id=3De0,netdev=3Dhn0,mac=3D52:a4:00:12:78:66
--chardev socket,id=3Dmirror0,host=3D3.3.3.3,port=3D9003,server,nowait
--chardev socket,id=3Dcompare1,host=3D3.3.3.3,port=3D9004,server,nowait
--chardev socket,id=3Dcompare0,host=3D3.3.3.3,port=3D9001,server,nowait
--chardev socket,id=3Dcompare0-0,host=3D3.3.3.3,port=3D9001
--chardev socket,id=3Dcompare_out,host=3D3.3.3.3,port=3D9005,server,nowai=
t
--chardev socket,id=3Dcompare_out0,host=3D3.3.3.3,port=3D9005
--object filter-mirror,id=3Dm0,netdev=3Dhn0,queue=3Dtx,outdev=3Dmirror0
--object filter-redirector,netdev=3Dhn0,id=3Dredire0,queue=3Drx,indev=3Dc=
ompare_out
--object filter-redirector,netdev=3Dhn0,id=3Dredire1,queue=3Drx,outdev=3D=
compare0
--object colo-compare,id=3Dcomp0,primary_in=3Dcompare0-0,secondary_in=3Dc=
ompare1,outdev=3Dcompare_out0
-
-secondary:
--netdev tap,id=3Dhn0,vhost=3Doff,script=3D/etc/qemu-ifup,down script=3D/=
etc/qemu-ifdown
--device e1000,netdev=3Dhn0,mac=3D52:a4:00:12:78:66
--chardev socket,id=3Dred0,host=3D3.3.3.3,port=3D9003
--chardev socket,id=3Dred1,host=3D3.3.3.3,port=3D9004
--object filter-redirector,id=3Df1,netdev=3Dhn0,queue=3Dtx,indev=3Dred0
--object filter-redirector,id=3Df2,netdev=3Dhn0,queue=3Drx,outdev=3Dred1
-
-@end example
-
-If you want to know the detail of above command line, you can read
-the colo-compare git log.
-
-@item -object cryptodev-backend-builtin,id=3D@var{id}[,queues=3D@var{que=
ues}]
-
-Creates a cryptodev backend which executes crypto opreation from
-the QEMU cipher APIS. The @var{id} parameter is
-a unique ID that will be used to reference this cryptodev backend from
-the @option{virtio-crypto} device. The @var{queues} parameter is optiona=
l,
-which specify the queue number of cryptodev backend, the default of
-@var{queues} is 1.
-
-@example
-
- # qemu-system-x86_64 \
-   [...] \
-       -object cryptodev-backend-builtin,id=3Dcryptodev0 \
-       -device virtio-crypto-pci,id=3Dcrypto0,cryptodev=3Dcryptodev0 \
-   [...]
-@end example
-
-@item -object secret,id=3D@var{id},data=3D@var{string},format=3D@var{raw=
|base64}[,keyid=3D@var{secretid},iv=3D@var{string}]
-@item -object secret,id=3D@var{id},file=3D@var{filename},format=3D@var{r=
aw|base64}[,keyid=3D@var{secretid},iv=3D@var{string}]
-
-Defines a secret to store a password, encryption key, or some other sens=
itive
-data. The sensitive data can either be passed directly via the @var{data=
}
-parameter, or indirectly via the @var{file} parameter. Using the @var{da=
ta}
-parameter is insecure unless the sensitive data is encrypted.
-
-The sensitive data can be provided in raw format (the default), or base6=
4.
-When encoded as JSON, the raw format only supports valid UTF-8 character=
s,
-so base64 is recommended for sending binary data. QEMU will convert from
-which ever format is provided to the format it needs internally. eg, an
-RBD password can be provided in raw format, even though it will be base6=
4
-encoded when passed onto the RBD sever.
-
-For added protection, it is possible to encrypt the data associated with
-a secret using the AES-256-CBC cipher. Use of encryption is indicated
-by providing the @var{keyid} and @var{iv} parameters. The @var{keyid}
-parameter provides the ID of a previously defined secret that contains
-the AES-256 decryption key. This key should be 32-bytes long and be
-base64 encoded. The @var{iv} parameter provides the random initializatio=
n
-vector used for encryption of this particular secret and should be a
-base64 encrypted string of the 16-byte IV.
-
-The simplest (insecure) usage is to provide the secret inline
-
-@example
-
- # $QEMU -object secret,id=3Dsec0,data=3Dletmein,format=3Draw
-
-@end example
-
-The simplest secure usage is to provide the secret via a file
-
- # printf "letmein" > mypasswd.txt
- # $QEMU -object secret,id=3Dsec0,file=3Dmypasswd.txt,format=3Draw
-
-For greater security, AES-256-CBC should be used. To illustrate usage,
-consider the openssl command line tool which can encrypt the data. Note
-that when encrypting, the plaintext must be padded to the cipher block
-size (32 bytes) using the standard PKCS#5/6 compatible padding algorithm=
.
-
-First a master key needs to be created in base64 encoding:
-
-@example
- # openssl rand -base64 32 > key.b64
- # KEY=3D$(base64 -d key.b64 | hexdump  -v -e '/1 "%02X"')
-@end example
-
-Each secret to be encrypted needs to have a random initialization vector
-generated. These do not need to be kept secret
-
-@example
- # openssl rand -base64 16 > iv.b64
- # IV=3D$(base64 -d iv.b64 | hexdump  -v -e '/1 "%02X"')
-@end example
-
-The secret to be defined can now be encrypted, in this case we're
-telling openssl to base64 encode the result, but it could be left
-as raw bytes if desired.
-
-@example
- # SECRET=3D$(printf "letmein" |
-            openssl enc -aes-256-cbc -a -K $KEY -iv $IV)
-@end example
-
-When launching QEMU, create a master secret pointing to @code{key.b64}
-and specify that to be used to decrypt the user password. Pass the
-contents of @code{iv.b64} to the second secret
-
-@example
- # $QEMU \
-     -object secret,id=3Dsecmaster0,format=3Dbase64,file=3Dkey.b64 \
-     -object secret,id=3Dsec0,keyid=3Dsecmaster0,format=3Dbase64,\
-         data=3D$SECRET,iv=3D$(<iv.b64)
-@end example
-
-@end table
-
-ETEXI
-
-
-HXCOMM This is the last statement. Insert new options before this line!
-STEXI
-@end table
-ETEXI
diff --git a/scripts/qapi.py b/scripts/qapi.py
index 958249fbd8..62373ad792 100644
--- a/scripts/qapi.py
+++ b/scripts/qapi.py
@@ -134,6 +134,8 @@ class QAPIDoc(object):
         self.sections =3D []
         # the current section
         self._section =3D self.body
+        # in embedded texinfo?
+        self._intexi =3D False
=20
     def has_section(self, name):
         """Return True if we have a section with this name."""
@@ -153,10 +155,17 @@ class QAPIDoc(object):
             raise QAPIParseError(self._parser, "Missing space after #")
         line =3D line[1:]
=20
+        if self._intexi:
+            self._section.append(line)
+            if line =3D=3D '!end texinfo':
+                self._intexi =3D False
+        elif line =3D=3D '!texinfo':
+            self._intexi =3D True
+            self._section.append(line)
+        elif self.symbol:
+            self._append_symbol_line(line)
         # FIXME not nice: things like '#  @foo:' and '# @foo: ' aren't
         # recognized, and get silently treated as ordinary text
-        if self.symbol:
-            self._append_symbol_line(line)
         elif not self.body.text and line.startswith('@'):
             if not line.endswith(':'):
                 raise QAPIParseError(self._parser, "Line should end with=
 :")
@@ -225,7 +234,7 @@ class QAPIDoc(object):
         if (in_arg or not self._section.name
                 or not self._section.name.startswith('Example')):
             line =3D line.strip()
-        match =3D re.match(r'(@\S+:)', line)
+        match =3D re.match(r'(@\S+:)($|\s)', line)
         if match:
             raise QAPIParseError(self._parser,
                                  "'%s' not allowed in free-form document=
ation"
diff --git a/vl.c b/vl.c
index 3fed457921..b9524f7e11 100644
--- a/vl.c
+++ b/vl.c
@@ -96,11 +96,11 @@ int main(int argc, char **argv)
 #include "sysemu/hax.h"
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/qobject-input-visitor.h"
+#include "qapi-options.h"
 #include "qapi-visit.h"
 #include "qapi/qmp/qjson.h"
 #include "qemu/option.h"
 #include "qemu/config-file.h"
-#include "qemu-options.h"
 #include "qmp-commands.h"
 #include "qemu/main-loop.h"
 #ifdef CONFIG_VIRTFS
@@ -2009,20 +2009,17 @@ static void help(int exitcode)
 {
     version();
     printf("usage: %s [options] [disk_image]\n\n"
-           "'disk_image' is a raw hard disk image for IDE hard disk 0\n\=
n",
-            error_get_progname());
-
-#define QEMU_OPTIONS_GENERATE_HELP
-#include "qemu-options-wrapper.h"
-
-    printf("\nDuring emulation, the following keys are useful:\n"
+           "'disk_image' is a raw hard disk image for IDE hard disk 0\n\=
n"
+           "%s"
+           "\nDuring emulation, the following keys are useful:\n"
            "ctrl-alt-f      toggle full screen\n"
            "ctrl-alt-n      switch to virtual console 'n'\n"
            "ctrl-alt        toggle mouse and keyboard grab\n"
            "\n"
            "When using -nographic, press 'ctrl-a h' to get some help.\n"
            "\n"
-           QEMU_HELP_BOTTOM "\n");
+           QEMU_HELP_BOTTOM "\n",
+           error_get_progname(), qapi_options_help);
=20
     exit(exitcode);
 }
@@ -2036,13 +2033,6 @@ typedef struct QEMUOption {
     uint32_t arch_mask;
 } QEMUOption;
=20
-static const QEMUOption qemu_options[] =3D {
-    { "h", 0, QEMU_OPTION_h, QEMU_ARCH_ALL },
-#define QEMU_OPTIONS_GENERATE_OPTIONS
-#include "qemu-options-wrapper.h"
-    { NULL },
-};
-
 typedef struct VGAInterfaceInfo {
     const char *opt_name;    /* option name */
     const char *name;        /* human-readable name */
@@ -2800,46 +2790,6 @@ static void qemu_run_machine_init_done_notifiers(v=
oid)
     machine_init_done =3D true;
 }
=20
-static const QEMUOption *lookup_opt(int argc, char **argv,
-                                    const char **poptarg, int *poptind)
-{
-    const QEMUOption *popt;
-    int optind =3D *poptind;
-    char *r =3D argv[optind];
-    const char *optarg;
-
-    loc_set_cmdline(argv, optind, 1);
-    optind++;
-    /* Treat --foo the same as -foo.  */
-    if (r[1] =3D=3D '-')
-        r++;
-    popt =3D qemu_options;
-    for(;;) {
-        if (!popt->name) {
-            error_report("invalid option");
-            exit(1);
-        }
-        if (!strcmp(popt->name, r + 1))
-            break;
-        popt++;
-    }
-    if (popt->flags & HAS_ARG) {
-        if (optind >=3D argc) {
-            error_report("requires an argument");
-            exit(1);
-        }
-        optarg =3D argv[optind++];
-        loc_set_cmdline(argv, optind - 2, 2);
-    } else {
-        optarg =3D NULL;
-    }
-
-    *poptarg =3D optarg;
-    *poptind =3D optind;
-
-    return popt;
-}
-
 static MachineClass *select_machine(void)
 {
     MachineClass *machine_class =3D find_default_machine();
@@ -3088,6 +3038,15 @@ static void register_global_properties(MachineStat=
e *ms)
     user_register_global_props();
 }
=20
+/* TODO make options conditional in schema and drop this crap */
+static void check_option_arch(uint32_t arch_mask)
+{
+    if (!(arch_type & arch_mask)) {
+        error_report("Option not supported for this target");
+        exit(1);
+    }
+}
+
 int main(int argc, char **argv, char **envp)
 {
     int i;
@@ -3101,8 +3060,6 @@ int main(int argc, char **argv, char **envp)
     QemuOpts *opts, *machine_opts;
     QemuOpts *hda_opts =3D NULL, *icount_opts =3D NULL, *accel_opts =3D =
NULL;
     QemuOptsList *olist;
-    int optind;
-    const char *optarg;
     const char *loadvm =3D NULL;
     MachineClass *machine_class;
     const char *cpu_model;
@@ -3133,6 +3090,7 @@ int main(int argc, char **argv, char **envp)
     } BlockdevOptions_queue;
     QSIMPLEQ_HEAD(, BlockdevOptions_queue) bdo_queue
         =3D QSIMPLEQ_HEAD_INITIALIZER(bdo_queue);
+    QAPIOption *qopt;
=20
     module_call_init(MODULE_INIT_TRACE);
=20
@@ -3147,6 +3105,8 @@ int main(int argc, char **argv, char **envp)
     module_call_init(MODULE_INIT_QOM);
     monitor_init_qmp_commands();
=20
+    qopt =3D qapi_options_parse(argc, argv);
+
     qemu_add_opts(&qemu_drive_opts);
     qemu_add_drive_opts(&qemu_legacy_drive_opts);
     qemu_add_drive_opts(&qemu_common_drive_opts);
@@ -3202,58 +3162,52 @@ int main(int argc, char **argv, char **envp)
     autostart =3D 1;
=20
     /* first pass of option parsing */
-    optind =3D 1;
-    while (optind < argc) {
-        if (argv[optind][0] !=3D '-') {
-            /* disk image */
-            optind++;
-        } else {
-            const QEMUOption *popt;
-
-            popt =3D lookup_opt(argc, argv, &optarg, &optind);
-            switch (popt->index) {
-            case QEMU_OPTION_nodefconfig:
-                defconfig =3D false;
-                break;
-            case QEMU_OPTION_nouserconfig:
-                userconfig =3D false;
-                break;
-            }
+    for (i =3D 0; !qopt[i].cnt; i++) {
+        switch (qopt[i].type) {
+        case QAPI_OPTION_KIND_NODEFCONFIG:
+            defconfig =3D false;
+            break;
+        case QAPI_OPTION_KIND_NO_USER_CONFIG:
+            userconfig =3D false;
+            break;
+        case QAPI_OPTION_KIND_READCONFIG:
+            /* TODO read .json config and insert it into @qopt right her=
e */
+            break;
+        case QAPI_OPTION_KIND_WRITECONFIG:
+            /* TODO write .json config here? */
+            break;
+        case QAPI_OPTION_KIND_SET:
+            /* TODO how to port this one from QemuOpts to QAPI? */
+            break;
+        default:
+            ;
         }
     }
=20
     if (defconfig && userconfig) {
+        /* TODO read default .json config and prepend it to @qopt */
         if (qemu_read_default_config_file() < 0) {
             exit(1);
         }
     }
=20
     /* second pass of option parsing */
-    optind =3D 1;
-    for(;;) {
-        if (optind >=3D argc)
-            break;
-        if (argv[optind][0] !=3D '-') {
-            hda_opts =3D drive_add(IF_DEFAULT, 0, argv[optind++], HD_OPT=
S);
-        } else {
-            const QEMUOption *popt;
+    for (i =3D 0; qopt[i].cnt; i++) {
+            /* TODO reindent */
+            loc_set_cmdline(argv, qopt[i].idx, qopt[i].cnt);
=20
-            popt =3D lookup_opt(argc, argv, &optarg, &optind);
-            if (!(popt->arch_mask & arch_type)) {
-                error_report("Option not supported for this target");
-                exit(1);
-            }
-            switch(popt->index) {
-            case QEMU_OPTION_no_kvm_irqchip: {
+            switch (qopt[i].type) {
+            case QAPI_OPTION_KIND_NO_KVM_IRQCHIP: {
+                check_option_arch(QEMU_ARCH_I386);
                 olist =3D qemu_find_opts("machine");
                 qemu_opts_parse_noisily(olist, "kernel_irqchip=3Doff", f=
alse);
                 break;
             }
-            case QEMU_OPTION_cpu:
+            case QAPI_OPTION_KIND_CPU:
                 /* hw initialization will check this */
-                cpu_model =3D optarg;
+                cpu_model =3D qopt[i].u.cpu.data;
                 break;
-            case QEMU_OPTION_hda:
+            case QAPI_OPTION_KIND_HDA:
                 {
                     char buf[256];
                     if (cyls =3D=3D 0)
@@ -3266,21 +3220,25 @@ int main(int argc, char **argv, char **envp)
                                  ",trans=3Dlba" :
                                  translation =3D=3D BIOS_ATA_TRANSLATION=
_NONE ?
                                  ",trans=3Dnone" : "");
-                    drive_add(IF_DEFAULT, 0, optarg, buf);
+                    drive_add(IF_DEFAULT, 0, qopt[i].u.hda.data, buf);
                     break;
                 }
-            case QEMU_OPTION_hdb:
-            case QEMU_OPTION_hdc:
-            case QEMU_OPTION_hdd:
-                drive_add(IF_DEFAULT, popt->index - QEMU_OPTION_hda, opt=
arg,
-                          HD_OPTS);
+            case QAPI_OPTION_KIND_HDB:
+                drive_add(IF_DEFAULT, 1, qopt[i].u.hdb.data, HD_OPTS);
                 break;
-            case QEMU_OPTION_blockdev:
+            case QAPI_OPTION_KIND_HDC:
+                drive_add(IF_DEFAULT, 2, qopt[i].u.hdc.data, HD_OPTS);
+                break;
+            case QAPI_OPTION_KIND_HDD:
+                drive_add(IF_DEFAULT, 3, qopt[i].u.hdb.data, HD_OPTS);
+                break;
+            case QAPI_OPTION_KIND_BLOCKDEV:
                 {
                     Visitor *v;
                     BlockdevOptions_queue *bdo;
=20
-                    v =3D qobject_input_visitor_new_str(optarg, "driver"=
, &err);
+                    v =3D qobject_input_visitor_new_str(qopt[i].u.blockd=
ev.data,
+                                                      "driver", &err);
                     if (!v) {
                         error_report_err(err);
                         exit(1);
@@ -3294,35 +3252,37 @@ int main(int argc, char **argv, char **envp)
                     QSIMPLEQ_INSERT_TAIL(&bdo_queue, bdo, entry);
                     break;
                 }
-            case QEMU_OPTION_drive:
-                if (drive_def(optarg) =3D=3D NULL) {
+            case QAPI_OPTION_KIND_DRIVE:
+                if (drive_def(qopt[i].u.drive.data) =3D=3D NULL) {
                     exit(1);
                 }
                 break;
-            case QEMU_OPTION_set:
-                if (qemu_set_option(optarg) !=3D 0)
+            case QAPI_OPTION_KIND_SET:
+                if (qemu_set_option(qopt[i].u.set.data) !=3D 0) {
                     exit(1);
+                }
                 break;
-            case QEMU_OPTION_global:
-                if (qemu_global_option(optarg) !=3D 0)
+            case QAPI_OPTION_KIND_GLOBAL:
+                if (qemu_global_option(qopt[i].u.global.data) !=3D 0) {
                     exit(1);
+                }
                 break;
-            case QEMU_OPTION_mtdblock:
-                drive_add(IF_MTD, -1, optarg, MTD_OPTS);
+            case QAPI_OPTION_KIND_MTDBLOCK:
+                drive_add(IF_MTD, -1, qopt[i].u.mtdblock.data, MTD_OPTS)=
;
                 break;
-            case QEMU_OPTION_sd:
-                drive_add(IF_SD, -1, optarg, SD_OPTS);
+            case QAPI_OPTION_KIND_SD:
+                drive_add(IF_SD, -1, qopt[i].u.sd.data, SD_OPTS);
                 break;
-            case QEMU_OPTION_pflash:
-                drive_add(IF_PFLASH, -1, optarg, PFLASH_OPTS);
+            case QAPI_OPTION_KIND_PFLASH:
+                drive_add(IF_PFLASH, -1, qopt[i].u.pflash.data, PFLASH_O=
PTS);
                 break;
-            case QEMU_OPTION_snapshot:
+            case QAPI_OPTION_KIND_SNAPSHOT:
                 snapshot =3D 1;
                 break;
-            case QEMU_OPTION_hdachs:
+            case QAPI_OPTION_KIND_HDACHS:
                 {
                     const char *p;
-                    p =3D optarg;
+                    p =3D qopt[i].u.hdachs.data;
                     cyls =3D strtol(p, (char **)&p, 0);
                     if (cyls < 1 || cyls > 16383)
                         goto chs_fail;
@@ -3383,23 +3343,23 @@ int main(int argc, char **argv, char **envp)
                 error_report("'-hdachs' is deprecated, please use '-devi=
ce"
                              " ide-hd,cyls=3Dc,heads=3Dh,secs=3Ds,...' i=
nstead");
                 break;
-            case QEMU_OPTION_numa:
+            case QAPI_OPTION_KIND_NUMA:
                 opts =3D qemu_opts_parse_noisily(qemu_find_opts("numa"),
-                                               optarg, true);
+                                               qopt[i].u.numa.data, true=
);
                 if (!opts) {
                     exit(1);
                 }
                 break;
-            case QEMU_OPTION_display:
-                display_type =3D select_display(optarg);
+            case QAPI_OPTION_KIND_DISPLAY:
+                display_type =3D select_display(qopt[i].u.display.data);
                 break;
-            case QEMU_OPTION_nographic:
+            case QAPI_OPTION_KIND_NOGRAPHIC:
                 olist =3D qemu_find_opts("machine");
                 qemu_opts_parse_noisily(olist, "graphics=3Doff", false);
                 nographic =3D true;
                 display_type =3D DT_NONE;
                 break;
-            case QEMU_OPTION_curses:
+            case QAPI_OPTION_KIND_CURSES:
 #ifdef CONFIG_CURSES
                 display_type =3D DT_CURSES;
 #else
@@ -3407,174 +3367,183 @@ int main(int argc, char **argv, char **envp)
                 exit(1);
 #endif
                 break;
-            case QEMU_OPTION_portrait:
+            case QAPI_OPTION_KIND_PORTRAIT:
                 graphic_rotate =3D 90;
                 break;
-            case QEMU_OPTION_rotate:
-                graphic_rotate =3D strtol(optarg, (char **) &optarg, 10)=
;
+            case QAPI_OPTION_KIND_ROTATE:
+                graphic_rotate =3D strtol(qopt[i].u.rotate.data,
+                                        (char **)&qopt[i].u.rotate.data,=
 10);
                 if (graphic_rotate !=3D 0 && graphic_rotate !=3D 90 &&
                     graphic_rotate !=3D 180 && graphic_rotate !=3D 270) =
{
                     error_report("only 90, 180, 270 deg rotation is avai=
lable");
                     exit(1);
                 }
                 break;
-            case QEMU_OPTION_kernel:
-                qemu_opts_set(qemu_find_opts("machine"), 0, "kernel", op=
targ,
-                              &error_abort);
+            case QAPI_OPTION_KIND_KERNEL:
+                qemu_opts_set(qemu_find_opts("machine"), 0, "kernel",
+                              qopt[i].u.kernel.data, &error_abort);
                 break;
-            case QEMU_OPTION_initrd:
-                qemu_opts_set(qemu_find_opts("machine"), 0, "initrd", op=
targ,
-                              &error_abort);
+            case QAPI_OPTION_KIND_INITRD:
+                qemu_opts_set(qemu_find_opts("machine"), 0, "initrd",
+                              qopt[i].u.initrd.data, &error_abort);
                 break;
-            case QEMU_OPTION_append:
-                qemu_opts_set(qemu_find_opts("machine"), 0, "append", op=
targ,
-                              &error_abort);
+            case QAPI_OPTION_KIND_APPEND:
+                qemu_opts_set(qemu_find_opts("machine"), 0, "append",
+                              qopt[i].u.append.data, &error_abort);
                 break;
-            case QEMU_OPTION_dtb:
-                qemu_opts_set(qemu_find_opts("machine"), 0, "dtb", optar=
g,
-                              &error_abort);
+            case QAPI_OPTION_KIND_DTB:
+                qemu_opts_set(qemu_find_opts("machine"), 0, "dtb",
+                              qopt[i].u.dtb.data, &error_abort);
                 break;
-            case QEMU_OPTION_cdrom:
-                drive_add(IF_DEFAULT, 2, optarg, CDROM_OPTS);
+            case QAPI_OPTION_KIND_CDROM:
+                drive_add(IF_DEFAULT, 2, qopt[i].u.cdrom.data, CDROM_OPT=
S);
                 break;
-            case QEMU_OPTION_boot:
+            case QAPI_OPTION_KIND_BOOT:
                 opts =3D qemu_opts_parse_noisily(qemu_find_opts("boot-op=
ts"),
-                                               optarg, true);
+                                               qopt[i].u.boot.data, true=
);
                 if (!opts) {
                     exit(1);
                 }
                 break;
-            case QEMU_OPTION_fda:
-            case QEMU_OPTION_fdb:
-                drive_add(IF_FLOPPY, popt->index - QEMU_OPTION_fda,
-                          optarg, FD_OPTS);
+            case QAPI_OPTION_KIND_FDA:
+                drive_add(IF_FLOPPY, 0, qopt[i].u.fda.data, FD_OPTS);
                 break;
-            case QEMU_OPTION_no_fd_bootchk:
+            case QAPI_OPTION_KIND_FDB:
+                drive_add(IF_FLOPPY, 1, qopt[i].u.fdb.data, FD_OPTS);
+                break;
+            case QAPI_OPTION_KIND_NO_FD_BOOTCHK:
+                check_option_arch(QEMU_ARCH_I386);
                 fd_bootchk =3D 0;
                 break;
-            case QEMU_OPTION_netdev:
+            case QAPI_OPTION_KIND_NETDEV:
                 default_net =3D 0;
-                if (net_client_parse(qemu_find_opts("netdev"), optarg) =3D=
=3D -1) {
+                if (net_client_parse(qemu_find_opts("netdev"),
+                                     qopt[i].u.netdev.data) =3D=3D -1) {
                     exit(1);
                 }
                 break;
-            case QEMU_OPTION_net:
+            case QAPI_OPTION_KIND_NET:
                 default_net =3D 0;
-                if (net_client_parse(qemu_find_opts("net"), optarg) =3D=3D=
 -1) {
+                if (net_client_parse(qemu_find_opts("net"),
+                                     qopt[i].u.net.data) =3D=3D -1) {
                     exit(1);
                 }
                 break;
 #ifdef CONFIG_LIBISCSI
-            case QEMU_OPTION_iscsi:
+            case QAPI_OPTION_KIND_ISCSI:
                 opts =3D qemu_opts_parse_noisily(qemu_find_opts("iscsi")=
,
-                                               optarg, false);
+                                               qopt[i].u.iscsi.data, fal=
se);
                 if (!opts) {
                     exit(1);
                 }
                 break;
 #endif
 #ifdef CONFIG_SLIRP
-            case QEMU_OPTION_tftp:
+            case QAPI_OPTION_KIND_TFTP:
                 error_report("The -tftp option is deprecated. "
                              "Please use '-netdev user,tftp=3D...' inste=
ad.");
-                legacy_tftp_prefix =3D optarg;
+                legacy_tftp_prefix =3D qopt[i].u.tftp.data;
                 break;
-            case QEMU_OPTION_bootp:
+            case QAPI_OPTION_KIND_BOOTP:
                 error_report("The -bootp option is deprecated. "
                              "Please use '-netdev user,bootfile=3D...' i=
nstead.");
-                legacy_bootp_filename =3D optarg;
+                legacy_bootp_filename =3D qopt[i].u.bootp.data;
                 break;
-            case QEMU_OPTION_redir:
+            case QAPI_OPTION_KIND_REDIR:
                 error_report("The -redir option is deprecated. "
                              "Please use '-netdev user,hostfwd=3D...' in=
stead.");
-                if (net_slirp_redir(optarg) < 0)
+                if (net_slirp_redir(qopt[i].u.redir.data) < 0) {
                     exit(1);
+                }
                 break;
 #endif
-            case QEMU_OPTION_bt:
-                add_device_config(DEV_BT, optarg);
+            case QAPI_OPTION_KIND_BT:
+                add_device_config(DEV_BT, qopt[i].u.bt.data);
                 break;
-            case QEMU_OPTION_audio_help:
+            case QAPI_OPTION_KIND_AUDIO_HELP:
                 AUD_help ();
                 exit (0);
                 break;
-            case QEMU_OPTION_soundhw:
-                select_soundhw (optarg);
+            case QAPI_OPTION_KIND_SOUNDHW:
+                select_soundhw(qopt[i].u.soundhw.data);
                 break;
-            case QEMU_OPTION_h:
+            case QAPI_OPTION_KIND_HELP:
                 help(0);
                 break;
-            case QEMU_OPTION_version:
+            case QAPI_OPTION_KIND_VERSION:
                 version();
                 exit(0);
                 break;
-            case QEMU_OPTION_m:
+            case QAPI_OPTION_KIND_MEM:
                 opts =3D qemu_opts_parse_noisily(qemu_find_opts("memory"=
),
-                                               optarg, true);
+                                               qopt[i].u.mem.data, true)=
;
                 if (!opts) {
                     exit(EXIT_FAILURE);
                 }
                 break;
 #ifdef CONFIG_TPM
-            case QEMU_OPTION_tpmdev:
-                if (tpm_config_parse(qemu_find_opts("tpmdev"), optarg) <=
 0) {
+            case QAPI_OPTION_KIND_TPMDEV:
+                if (tpm_config_parse(qemu_find_opts("tpmdev"),
+                                     qopt[i].u.tpmdev.data) < 0) {
                     exit(1);
                 }
                 break;
 #endif
-            case QEMU_OPTION_mempath:
-                mem_path =3D optarg;
+            case QAPI_OPTION_KIND_MEM_PATH:
+                mem_path =3D qopt[i].u.mem_path.data;
                 break;
-            case QEMU_OPTION_mem_prealloc:
+            case QAPI_OPTION_KIND_MEM_PREALLOC:
                 mem_prealloc =3D 1;
                 break;
-            case QEMU_OPTION_d:
-                log_mask =3D optarg;
+            case QAPI_OPTION_KIND_DEBUG_ENABLE:
+                log_mask =3D qopt[i].u.debug_enable.data;
                 break;
-            case QEMU_OPTION_D:
-                log_file =3D optarg;
+            case QAPI_OPTION_KIND_DEBUG_LOG:
+                log_file =3D qopt[i].u.debug_log.data;
                 break;
-            case QEMU_OPTION_DFILTER:
-                qemu_set_dfilter_ranges(optarg, &error_fatal);
+            case QAPI_OPTION_KIND_DFILTER:
+                qemu_set_dfilter_ranges(qopt[i].u.dfilter.data, &error_f=
atal);
                 break;
-            case QEMU_OPTION_s:
+            case QAPI_OPTION_KIND_GDB_DEFAULT:
                 add_device_config(DEV_GDB, "tcp::" DEFAULT_GDBSTUB_PORT)=
;
                 break;
-            case QEMU_OPTION_gdb:
-                add_device_config(DEV_GDB, optarg);
+            case QAPI_OPTION_KIND_GDB:
+                add_device_config(DEV_GDB, qopt[i].u.gdb.data);
                 break;
-            case QEMU_OPTION_L:
-                if (is_help_option(optarg)) {
+            case QAPI_OPTION_KIND_LOAD_PATH:
+                if (is_help_option(qopt[i].u.load_path.data)) {
                     list_data_dirs =3D true;
                 } else {
                     qemu_add_data_dir(optarg);
                 }
                 break;
-            case QEMU_OPTION_bios:
-                qemu_opts_set(qemu_find_opts("machine"), 0, "firmware", =
optarg,
-                              &error_abort);
+            case QAPI_OPTION_KIND_BIOS:
+                qemu_opts_set(qemu_find_opts("machine"), 0, "firmware",
+                              qopt[i].u.bios.data, &error_abort);
                 break;
-            case QEMU_OPTION_singlestep:
+            case QAPI_OPTION_KIND_SINGLESTEP:
                 singlestep =3D 1;
                 break;
-            case QEMU_OPTION_S:
+            case QAPI_OPTION_KIND_STOPPED:
                 autostart =3D 0;
                 break;
-            case QEMU_OPTION_k:
-                keyboard_layout =3D optarg;
+            case QAPI_OPTION_KIND_KEYBOARD_LAYOUT:
+                keyboard_layout =3D qopt[i].u.keyboard_layout.data;
                 break;
-            case QEMU_OPTION_localtime:
+            case QAPI_OPTION_KIND_LOCALTIME:
                 rtc_utc =3D 0;
                 break;
-            case QEMU_OPTION_vga:
-                vga_model =3D optarg;
+            case QAPI_OPTION_KIND_VGA:
+                vga_model =3D qopt[i].u.vga.data;
                 default_vga =3D 0;
                 break;
-            case QEMU_OPTION_g:
+            case QAPI_OPTION_KIND_GRAPHICAL_RESOLUTION:
                 {
                     const char *p;
                     int w, h, depth;
-                    p =3D optarg;
+
+                    check_option_arch(QEMU_ARCH_PPC | QEMU_ARCH_SPARC);
+                    p =3D qopt[i].u.graphical_resolution.data;
                     w =3D strtol(p, (char **)&p, 10);
                     if (w <=3D 0) {
                     graphic_error:
@@ -3604,55 +3573,57 @@ int main(int argc, char **argv, char **envp)
                     graphic_depth =3D depth;
                 }
                 break;
-            case QEMU_OPTION_echr:
+            case QAPI_OPTION_KIND_ECHR:
                 {
                     char *r;
-                    term_escape_char =3D strtol(optarg, &r, 0);
-                    if (r =3D=3D optarg)
+                    term_escape_char =3D strtol(qopt[i].u.echr.data, &r,=
 0);
+                    if (r =3D=3D qopt[i].u.echr.data) {
                         printf("Bad argument to echr\n");
+                    }
                     break;
                 }
-            case QEMU_OPTION_monitor:
+            case QAPI_OPTION_KIND_MONITOR:
                 default_monitor =3D 0;
-                if (strncmp(optarg, "none", 4)) {
-                    monitor_parse(optarg, "readline", false);
+                if (strncmp(qopt[i].u.monitor.data, "none", 4)) {
+                    monitor_parse(qopt[i].u.monitor.data, "readline", fa=
lse);
                 }
                 break;
-            case QEMU_OPTION_qmp:
-                monitor_parse(optarg, "control", false);
+            case QAPI_OPTION_KIND_QMP:
+                monitor_parse(qopt[i].u.qmp.data, "control", false);
                 default_monitor =3D 0;
                 break;
-            case QEMU_OPTION_qmp_pretty:
-                monitor_parse(optarg, "control", true);
+            case QAPI_OPTION_KIND_QMP_PRETTY:
+                monitor_parse(qopt[i].u.qmp_pretty.data, "control", true=
);
                 default_monitor =3D 0;
                 break;
-            case QEMU_OPTION_mon:
-                opts =3D qemu_opts_parse_noisily(qemu_find_opts("mon"), =
optarg,
-                                               true);
+            case QAPI_OPTION_KIND_MON:
+                opts =3D qemu_opts_parse_noisily(qemu_find_opts("mon"),
+                                               qopt[i].u.mon.data, true)=
;
                 if (!opts) {
                     exit(1);
                 }
                 default_monitor =3D 0;
                 break;
-            case QEMU_OPTION_chardev:
+            case QAPI_OPTION_KIND_CHARDEV:
                 opts =3D qemu_opts_parse_noisily(qemu_find_opts("chardev=
"),
-                                               optarg, true);
+                                               qopt[i].u.chardev.data, t=
rue);
                 if (!opts) {
                     exit(1);
                 }
                 break;
-            case QEMU_OPTION_fsdev:
+            case QAPI_OPTION_KIND_FSDEV:
                 olist =3D qemu_find_opts("fsdev");
                 if (!olist) {
                     error_report("fsdev support is disabled");
                     exit(1);
                 }
-                opts =3D qemu_opts_parse_noisily(olist, optarg, true);
+                opts =3D qemu_opts_parse_noisily(olist, qopt[i].u.fsdev.=
data,
+                                               true);
                 if (!opts) {
                     exit(1);
                 }
                 break;
-            case QEMU_OPTION_virtfs: {
+            case QAPI_OPTION_KIND_VIRTFS: {
                 QemuOpts *fsdev;
                 QemuOpts *device;
                 const char *writeout, *sock_fd, *socket, *path, *securit=
y_model;
@@ -3662,7 +3633,8 @@ int main(int argc, char **argv, char **envp)
                     error_report("virtfs support is disabled");
                     exit(1);
                 }
-                opts =3D qemu_opts_parse_noisily(olist, optarg, true);
+                opts =3D qemu_opts_parse_noisily(olist, qopt[i].u.virtfs=
.data,
+                                               true);
                 if (!opts) {
                     exit(1);
                 }
@@ -3724,7 +3696,7 @@ int main(int argc, char **argv, char **envp)
                              qemu_opt_get(opts, "mount_tag"), &error_abo=
rt);
                 break;
             }
-            case QEMU_OPTION_virtfs_synth: {
+            case QAPI_OPTION_KIND_VIRTFS_SYNTH: {
                 QemuOpts *fsdev;
                 QemuOpts *device;
=20
@@ -3743,62 +3715,63 @@ int main(int argc, char **argv, char **envp)
                 qemu_opt_set(device, "mount_tag", "v_synth", &error_abor=
t);
                 break;
             }
-            case QEMU_OPTION_serial:
-                add_device_config(DEV_SERIAL, optarg);
+            case QAPI_OPTION_KIND_SERIAL:
+                add_device_config(DEV_SERIAL, qopt[i].u.serial.data);
                 default_serial =3D 0;
-                if (strncmp(optarg, "mon:", 4) =3D=3D 0) {
+                if (strncmp(qopt[i].u.serial.data, "mon:", 4) =3D=3D 0) =
{
                     default_monitor =3D 0;
                 }
                 break;
-            case QEMU_OPTION_watchdog:
+            case QAPI_OPTION_KIND_WATCHDOG:
                 if (watchdog) {
                     error_report("only one watchdog option may be given"=
);
                     return 1;
                 }
-                watchdog =3D optarg;
+                watchdog =3D qopt[i].u.watchdog.data;
                 break;
-            case QEMU_OPTION_watchdog_action:
-                if (select_watchdog_action(optarg) =3D=3D -1) {
+            case QAPI_OPTION_KIND_WATCHDOG_ACTION:
+                if (select_watchdog_action(qopt[i].u.watchdog_action.dat=
a)
+                    =3D=3D -1) {
                     error_report("unknown -watchdog-action parameter");
                     exit(1);
                 }
                 break;
-            case QEMU_OPTION_virtiocon:
-                add_device_config(DEV_VIRTCON, optarg);
+            case QAPI_OPTION_KIND_VIRTIOCONSOLE:
+                add_device_config(DEV_VIRTCON, qopt[i].u.virtioconsole.d=
ata);
                 default_virtcon =3D 0;
-                if (strncmp(optarg, "mon:", 4) =3D=3D 0) {
+                if (strncmp(qopt[i].u.virtioconsole.data, "mon:", 4) =3D=
=3D 0) {
                     default_monitor =3D 0;
                 }
                 break;
-            case QEMU_OPTION_parallel:
-                add_device_config(DEV_PARALLEL, optarg);
+            case QAPI_OPTION_KIND_PARALLEL:
+                add_device_config(DEV_PARALLEL, qopt[i].u.parallel.data)=
;
                 default_parallel =3D 0;
-                if (strncmp(optarg, "mon:", 4) =3D=3D 0) {
+                if (strncmp(qopt[i].u.parallel.data, "mon:", 4) =3D=3D 0=
) {
                     default_monitor =3D 0;
                 }
                 break;
-            case QEMU_OPTION_debugcon:
-                add_device_config(DEV_DEBUGCON, optarg);
+            case QAPI_OPTION_KIND_DEBUGCON:
+                add_device_config(DEV_DEBUGCON, qopt[i].u.debugcon.data)=
;
                 break;
-            case QEMU_OPTION_loadvm:
-                loadvm =3D optarg;
+            case QAPI_OPTION_KIND_LOADVM:
+                loadvm =3D qopt[i].u.loadvm.data;
                 break;
-            case QEMU_OPTION_full_screen:
+            case QAPI_OPTION_KIND_FULL_SCREEN:
                 full_screen =3D 1;
                 break;
-            case QEMU_OPTION_no_frame:
+            case QAPI_OPTION_KIND_NO_FRAME:
                 no_frame =3D 1;
                 break;
-            case QEMU_OPTION_alt_grab:
+            case QAPI_OPTION_KIND_ALT_GRAB:
                 alt_grab =3D 1;
                 break;
-            case QEMU_OPTION_ctrl_grab:
+            case QAPI_OPTION_KIND_CTRL_GRAB:
                 ctrl_grab =3D 1;
                 break;
-            case QEMU_OPTION_no_quit:
+            case QAPI_OPTION_KIND_NO_QUIT:
                 no_quit =3D 1;
                 break;
-            case QEMU_OPTION_sdl:
+            case QAPI_OPTION_KIND_SDL:
 #ifdef CONFIG_SDL
                 display_type =3D DT_SDL;
                 break;
@@ -3806,154 +3779,168 @@ int main(int argc, char **argv, char **envp)
                 error_report("SDL support is disabled");
                 exit(1);
 #endif
-            case QEMU_OPTION_pidfile:
-                pid_file =3D optarg;
+            case QAPI_OPTION_KIND_PIDFILE:
+                pid_file =3D qopt[i].u.pidfile.data;
                 break;
-            case QEMU_OPTION_win2k_hack:
+            case QAPI_OPTION_KIND_WIN2K_HACK:
+                check_option_arch(QEMU_ARCH_I386);
                 win2k_install_hack =3D 1;
                 break;
-            case QEMU_OPTION_rtc_td_hack: {
+            case QAPI_OPTION_KIND_RTC_TD_HACK: {
                 static GlobalProperty slew_lost_ticks =3D {
                     .driver   =3D "mc146818rtc",
                     .property =3D "lost_tick_policy",
                     .value    =3D "slew",
                 };
=20
+                check_option_arch(QEMU_ARCH_I386);
                 qdev_prop_register_global(&slew_lost_ticks);
                 break;
             }
-            case QEMU_OPTION_acpitable:
+            case QAPI_OPTION_KIND_ACPITABLE:
+                check_option_arch(QEMU_ARCH_I386);
                 opts =3D qemu_opts_parse_noisily(qemu_find_opts("acpi"),
-                                               optarg, true);
+                                               qopt[i].u.acpitable.data,=
 true);
                 if (!opts) {
                     exit(1);
                 }
                 acpi_table_add(opts, &error_fatal);
                 break;
-            case QEMU_OPTION_smbios:
+            case QAPI_OPTION_KIND_SMBIOS:
+                check_option_arch(QEMU_ARCH_I386 | QEMU_ARCH_ARM);
                 opts =3D qemu_opts_parse_noisily(qemu_find_opts("smbios"=
),
-                                               optarg, false);
+                                               qopt[i].u.smbios.data, fa=
lse);
                 if (!opts) {
                     exit(1);
                 }
                 smbios_entry_add(opts, &error_fatal);
                 break;
-            case QEMU_OPTION_fwcfg:
+            case QAPI_OPTION_KIND_FW_CFG:
                 opts =3D qemu_opts_parse_noisily(qemu_find_opts("fw_cfg"=
),
-                                               optarg, true);
+                                               qopt[i].u.fw_cfg.data, tr=
ue);
                 if (opts =3D=3D NULL) {
                     exit(1);
                 }
                 break;
-            case QEMU_OPTION_enable_kvm:
+            case QAPI_OPTION_KIND_ENABLE_KVM:
                 olist =3D qemu_find_opts("machine");
                 qemu_opts_parse_noisily(olist, "accel=3Dkvm", false);
                 break;
-            case QEMU_OPTION_enable_hax:
+            case QAPI_OPTION_KIND_ENABLE_HAX:
+                check_option_arch(QEMU_ARCH_I386);
                 olist =3D qemu_find_opts("machine");
                 qemu_opts_parse_noisily(olist, "accel=3Dhax", false);
                 break;
-            case QEMU_OPTION_M:
-            case QEMU_OPTION_machine:
+            case QAPI_OPTION_KIND_MACHINE:
                 olist =3D qemu_find_opts("machine");
-                opts =3D qemu_opts_parse_noisily(olist, optarg, true);
+                opts =3D qemu_opts_parse_noisily(olist, qopt[i].u.machin=
e.data,
+                                               true);
                 if (!opts) {
                     exit(1);
                 }
                 break;
-             case QEMU_OPTION_no_kvm:
+             case QAPI_OPTION_KIND_NO_KVM:
+                check_option_arch(QEMU_ARCH_I386);
                 olist =3D qemu_find_opts("machine");
                 qemu_opts_parse_noisily(olist, "accel=3Dtcg", false);
                 break;
-            case QEMU_OPTION_no_kvm_pit: {
+            case QAPI_OPTION_KIND_NO_KVM_PIT: {
+                check_option_arch(QEMU_ARCH_I386);
                 warn_report("ignoring deprecated option");
                 break;
             }
-            case QEMU_OPTION_no_kvm_pit_reinjection: {
+            case QAPI_OPTION_KIND_NO_KVM_PIT_REINJECTION: {
                 static GlobalProperty kvm_pit_lost_tick_policy =3D {
                     .driver   =3D "kvm-pit",
                     .property =3D "lost_tick_policy",
                     .value    =3D "discard",
                 };
=20
+                check_option_arch(QEMU_ARCH_I386);
                 warn_report("deprecated, replaced by "
                             "-global kvm-pit.lost_tick_policy=3Ddiscard"=
);
                 qdev_prop_register_global(&kvm_pit_lost_tick_policy);
                 break;
             }
-            case QEMU_OPTION_accel:
+            case QAPI_OPTION_KIND_ACCEL:
+            {
+                const char *accel;
                 accel_opts =3D qemu_opts_parse_noisily(qemu_find_opts("a=
ccel"),
-                                                     optarg, true);
-                optarg =3D qemu_opt_get(accel_opts, "accel");
-                if (!optarg || is_help_option(optarg)) {
+                                                     qopt[i].u.accel.dat=
a, true);
+                accel =3D qemu_opt_get(accel_opts, "accel");
+                if (!accel || is_help_option(qopt[i].u.accel.data)) {
                     error_printf("Possible accelerators: kvm, xen, hax, =
tcg\n");
                     exit(0);
                 }
                 opts =3D qemu_opts_create(qemu_find_opts("machine"), NUL=
L,
                                         false, &error_abort);
-                qemu_opt_set(opts, "accel", optarg, &error_abort);
+                qemu_opt_set(opts, "accel", qopt[i].u.accel.data, &error=
_abort);
                 break;
-            case QEMU_OPTION_usb:
+            }
+            case QAPI_OPTION_KIND_USB:
                 olist =3D qemu_find_opts("machine");
                 qemu_opts_parse_noisily(olist, "usb=3Don", false);
                 break;
-            case QEMU_OPTION_usbdevice:
+            case QAPI_OPTION_KIND_USBDEVICE:
                 error_report("'-usbdevice' is deprecated, please use "
                              "'-device usb-...' instead");
                 olist =3D qemu_find_opts("machine");
                 qemu_opts_parse_noisily(olist, "usb=3Don", false);
-                add_device_config(DEV_USB, optarg);
+                add_device_config(DEV_USB, qopt[i].u.usbdevice.data);
                 break;
-            case QEMU_OPTION_device:
+            case QAPI_OPTION_KIND_DEVICE:
                 if (!qemu_opts_parse_noisily(qemu_find_opts("device"),
-                                             optarg, true)) {
+                                             qopt[i].u.device.data, true=
)) {
                     exit(1);
                 }
                 break;
-            case QEMU_OPTION_smp:
+            case QAPI_OPTION_KIND_SMP:
                 if (!qemu_opts_parse_noisily(qemu_find_opts("smp-opts"),
-                                             optarg, true)) {
+                                             qopt[i].u.smp.data, true)) =
{
                     exit(1);
                 }
                 break;
-            case QEMU_OPTION_vnc:
-                vnc_parse(optarg, &error_fatal);
+            case QAPI_OPTION_KIND_VNC:
+                vnc_parse(qopt[i].u.vnc.data, &error_fatal);
                 break;
-            case QEMU_OPTION_no_acpi:
+            case QAPI_OPTION_KIND_NO_ACPI:
+                check_option_arch(QEMU_ARCH_I386 | QEMU_ARCH_ARM);
                 acpi_enabled =3D 0;
                 break;
-            case QEMU_OPTION_no_hpet:
+            case QAPI_OPTION_KIND_NO_HPET:
+                check_option_arch(QEMU_ARCH_I386);
                 no_hpet =3D 1;
                 break;
-            case QEMU_OPTION_balloon:
-                if (balloon_parse(optarg) < 0) {
-                    error_report("unknown -balloon argument %s", optarg)=
;
+            case QAPI_OPTION_KIND_BALLOON:
+                if (balloon_parse(qopt[i].u.balloon.data) < 0) {
+                    error_report("unknown -balloon argument %s",
+                                 qopt[i].u.balloon.data);
                     exit(1);
                 }
                 break;
-            case QEMU_OPTION_no_reboot:
+            case QAPI_OPTION_KIND_NO_REBOOT:
                 no_reboot =3D 1;
                 break;
-            case QEMU_OPTION_no_shutdown:
+            case QAPI_OPTION_KIND_NO_SHUTDOWN:
                 no_shutdown =3D 1;
                 break;
-            case QEMU_OPTION_show_cursor:
+            case QAPI_OPTION_KIND_SHOW_CURSOR:
                 cursor_hide =3D 0;
                 break;
-            case QEMU_OPTION_uuid:
-                if (qemu_uuid_parse(optarg, &qemu_uuid) < 0) {
+            case QAPI_OPTION_KIND_UUID:
+                if (qemu_uuid_parse(qopt[i].u.uuid.data, &qemu_uuid) < 0=
) {
                     error_report("failed to parse UUID string: wrong for=
mat");
                     exit(1);
                 }
                 qemu_uuid_set =3D true;
                 break;
-            case QEMU_OPTION_option_rom:
+            case QAPI_OPTION_KIND_OPTION_ROM:
                 if (nb_option_roms >=3D MAX_OPTION_ROMS) {
                     error_report("too many option ROMs");
                     exit(1);
                 }
                 opts =3D qemu_opts_parse_noisily(qemu_find_opts("option-=
rom"),
-                                               optarg, true);
+                                               qopt[i].u.option_rom.data=
, true);
                 if (!opts) {
                     exit(1);
                 }
@@ -3966,14 +3953,20 @@ int main(int argc, char **argv, char **envp)
                 }
                 nb_option_roms++;
                 break;
-            case QEMU_OPTION_semihosting:
+            case QAPI_OPTION_KIND_SEMIHOSTING:
+                check_option_arch(QEMU_ARCH_ARM | QEMU_ARCH_M68K
+                                  | QEMU_ARCH_XTENSA | QEMU_ARCH_LM32
+                                  | QEMU_ARCH_MIPS);
                 semihosting.enabled =3D true;
                 semihosting.target =3D SEMIHOSTING_TARGET_AUTO;
                 break;
-            case QEMU_OPTION_semihosting_config:
+            case QAPI_OPTION_KIND_SEMIHOSTING_CONFIG:
+                check_option_arch(QEMU_ARCH_ARM | QEMU_ARCH_M68K
+                                  | QEMU_ARCH_XTENSA | QEMU_ARCH_LM32
+                                  | QEMU_ARCH_MIPS);
                 semihosting.enabled =3D true;
                 opts =3D qemu_opts_parse_noisily(qemu_find_opts("semihos=
ting-config"),
-                                               optarg, false);
+                                               qopt[i].u.semihosting_con=
fig.data, false);
                 if (opts !=3D NULL) {
                     semihosting.enabled =3D qemu_opt_get_bool(opts, "ena=
ble",
                                                             true);
@@ -3987,7 +3980,7 @@ int main(int argc, char **argv, char **envp)
                             semihosting.target =3D SEMIHOSTING_TARGET_AU=
TO;
                         } else {
                             error_report("unsupported semihosting-config=
 %s",
-                                         optarg);
+                                         qopt[i].u.semihosting_config.da=
ta);
                             exit(1);
                         }
                     } else {
@@ -3997,71 +3990,75 @@ int main(int argc, char **argv, char **envp)
                     qemu_opt_foreach(opts, add_semihosting_arg,
                                      &semihosting, NULL);
                 } else {
-                    error_report("unsupported semihosting-config %s", op=
targ);
+                    error_report("unsupported semihosting-config %s",
+                                 qopt[i].u.semihosting_config.data);
                     exit(1);
                 }
                 break;
-            case QEMU_OPTION_tdf:
+            case QAPI_OPTION_KIND_TDF:
                 warn_report("ignoring deprecated option");
                 break;
-            case QEMU_OPTION_name:
+            case QAPI_OPTION_KIND_NAME:
                 opts =3D qemu_opts_parse_noisily(qemu_find_opts("name"),
-                                               optarg, true);
+                                               qopt[i].u.name.data, true=
);
                 if (!opts) {
                     exit(1);
                 }
                 break;
-            case QEMU_OPTION_prom_env:
+            case QAPI_OPTION_KIND_PROM_ENV:
+                check_option_arch(QEMU_ARCH_PPC | QEMU_ARCH_SPARC);
                 if (nb_prom_envs >=3D MAX_PROM_ENVS) {
                     error_report("too many prom variables");
                     exit(1);
                 }
-                prom_envs[nb_prom_envs] =3D optarg;
+                prom_envs[nb_prom_envs] =3D qopt[i].u.prom_env.data;
                 nb_prom_envs++;
                 break;
-            case QEMU_OPTION_old_param:
+            case QAPI_OPTION_KIND_OLD_PARAM:
+                check_option_arch(QEMU_ARCH_ARM);
                 old_param =3D 1;
                 break;
-            case QEMU_OPTION_clock:
+            case QAPI_OPTION_KIND_CLOCK:
                 /* Clock options no longer exist.  Keep this option for
                  * backward compatibility.
                  */
                 break;
-            case QEMU_OPTION_startdate:
-                configure_rtc_date_offset(optarg, 1);
+            case QAPI_OPTION_KIND_STARTDATE:
+                configure_rtc_date_offset(qopt[i].u.startdate.data, 1);
                 break;
-            case QEMU_OPTION_rtc:
-                opts =3D qemu_opts_parse_noisily(qemu_find_opts("rtc"), =
optarg,
-                                               false);
+            case QAPI_OPTION_KIND_RTC:
+                opts =3D qemu_opts_parse_noisily(qemu_find_opts("rtc"),
+                                               qopt[i].u.rtc.data, false=
);
                 if (!opts) {
                     exit(1);
                 }
                 configure_rtc(opts);
                 break;
-            case QEMU_OPTION_tb_size:
+            case QAPI_OPTION_KIND_TB_SIZE:
 #ifndef CONFIG_TCG
                 error_report("TCG is disabled");
                 exit(1);
 #endif
-                if (qemu_strtoul(optarg, NULL, 0, &tcg_tb_size) < 0) {
+                if (qemu_strtoul(qopt[i].u.tb_size.data, NULL, 0, &tcg_t=
b_size)
+                    < 0) {
                     error_report("Invalid argument to -tb-size");
                     exit(1);
                 }
                 break;
-            case QEMU_OPTION_icount:
+            case QAPI_OPTION_KIND_ICOUNT:
                 icount_opts =3D qemu_opts_parse_noisily(qemu_find_opts("=
icount"),
-                                                      optarg, true);
+                                                      qopt[i].u.icount.d=
ata, true);
                 if (!icount_opts) {
                     exit(1);
                 }
                 break;
-            case QEMU_OPTION_incoming:
+            case QAPI_OPTION_KIND_INCOMING:
                 if (!incoming) {
                     runstate_set(RUN_STATE_INMIGRATE);
                 }
-                incoming =3D optarg;
+                incoming =3D qopt[i].u.incoming.data;
                 break;
-            case QEMU_OPTION_only_migratable:
+            case QAPI_OPTION_KIND_ONLY_MIGRATABLE:
                 /*
                  * TODO: we can remove this option one day, and we
                  * should all use:
@@ -4070,72 +4067,73 @@ int main(int argc, char **argv, char **envp)
                  */
                 qemu_global_option("migration.only-migratable=3Dtrue");
                 break;
-            case QEMU_OPTION_nodefaults:
+            case QAPI_OPTION_KIND_NODEFAULTS:
                 has_defaults =3D 0;
                 break;
-            case QEMU_OPTION_xen_domid:
+            case QAPI_OPTION_KIND_XEN_DOMID:
                 if (!(xen_available())) {
                     error_report("Option not supported for this target")=
;
                     exit(1);
                 }
-                xen_domid =3D atoi(optarg);
+                xen_domid =3D atoi(qopt[i].u.xen_domid.data);
                 break;
-            case QEMU_OPTION_xen_create:
+            case QAPI_OPTION_KIND_XEN_CREATE:
                 if (!(xen_available())) {
                     error_report("Option not supported for this target")=
;
                     exit(1);
                 }
                 xen_mode =3D XEN_CREATE;
                 break;
-            case QEMU_OPTION_xen_attach:
+            case QAPI_OPTION_KIND_XEN_ATTACH:
                 if (!(xen_available())) {
                     error_report("Option not supported for this target")=
;
                     exit(1);
                 }
                 xen_mode =3D XEN_ATTACH;
                 break;
-            case QEMU_OPTION_xen_domid_restrict:
+            case QAPI_OPTION_KIND_XEN_DOMID_RESTRICT:
                 if (!(xen_available())) {
                     error_report("Option not supported for this target")=
;
                     exit(1);
                 }
                 xen_domid_restrict =3D true;
                 break;
-            case QEMU_OPTION_trace:
+            case QAPI_OPTION_KIND_TRACE:
                 g_free(trace_file);
-                trace_file =3D trace_opt_parse(optarg);
+                trace_file =3D trace_opt_parse(qopt[i].u.trace.data);
                 break;
-            case QEMU_OPTION_readconfig:
+            case QAPI_OPTION_KIND_READCONFIG:
                 {
-                    int ret =3D qemu_read_config_file(optarg);
+                    int ret =3D qemu_read_config_file(qopt[i].u.readconf=
ig.data);
                     if (ret < 0) {
-                        error_report("read config %s: %s", optarg,
-                                     strerror(-ret));
+                        error_report("read config %s: %s",
+                                     qopt[i].u.readconfig.data, strerror=
(-ret));
                         exit(1);
                     }
                     break;
                 }
-            case QEMU_OPTION_spice:
+            case QAPI_OPTION_KIND_SPICE:
                 olist =3D qemu_find_opts("spice");
                 if (!olist) {
                     error_report("spice support is disabled");
                     exit(1);
                 }
-                opts =3D qemu_opts_parse_noisily(olist, optarg, false);
+                opts =3D qemu_opts_parse_noisily(olist, qopt[i].u.spice.=
data, false);
                 if (!opts) {
                     exit(1);
                 }
                 display_remote++;
                 break;
-            case QEMU_OPTION_writeconfig:
+            case QAPI_OPTION_KIND_WRITECONFIG:
                 {
                     FILE *fp;
-                    if (strcmp(optarg, "-") =3D=3D 0) {
+                    if (strcmp(qopt[i].u.writeconfig.data, "-") =3D=3D 0=
) {
                         fp =3D stdout;
                     } else {
-                        fp =3D fopen(optarg, "w");
+                        fp =3D fopen(qopt[i].u.writeconfig.data, "w");
                         if (fp =3D=3D NULL) {
-                            error_report("open %s: %s", optarg,
+                            error_report("open %s: %s",
+                                         qopt[i].u.writeconfig.data,
                                          strerror(errno));
                             exit(1);
                         }
@@ -4146,23 +4144,23 @@ int main(int argc, char **argv, char **envp)
                     }
                     break;
                 }
-            case QEMU_OPTION_qtest:
-                qtest_chrdev =3D optarg;
+            case QAPI_OPTION_KIND_QTEST:
+                qtest_chrdev =3D qopt[i].u.qtest.data;
                 break;
-            case QEMU_OPTION_qtest_log:
-                qtest_log =3D optarg;
+            case QAPI_OPTION_KIND_QTEST_LOG:
+                qtest_log =3D qopt[i].u.qtest_log.data;
                 break;
-            case QEMU_OPTION_sandbox:
+            case QAPI_OPTION_KIND_SANDBOX:
                 opts =3D qemu_opts_parse_noisily(qemu_find_opts("sandbox=
"),
-                                               optarg, true);
+                                               qopt[i].u.sandbox.data, t=
rue);
                 if (!opts) {
                     exit(1);
                 }
                 break;
-            case QEMU_OPTION_add_fd:
+            case QAPI_OPTION_KIND_ADD_FD:
 #ifndef _WIN32
                 opts =3D qemu_opts_parse_noisily(qemu_find_opts("add-fd"=
),
-                                               optarg, false);
+                                               qopt[i].u.add_fd.data, fa=
lse);
                 if (!opts) {
                     exit(1);
                 }
@@ -4172,46 +4170,52 @@ int main(int argc, char **argv, char **envp)
                 exit(1);
 #endif
                 break;
-            case QEMU_OPTION_object:
+            case QAPI_OPTION_KIND_OBJECT:
                 opts =3D qemu_opts_parse_noisily(qemu_find_opts("object"=
),
-                                               optarg, true);
+                                               qopt[i].u.object.data, tr=
ue);
                 if (!opts) {
                     exit(1);
                 }
                 break;
-            case QEMU_OPTION_realtime:
+            case QAPI_OPTION_KIND_REALTIME:
                 opts =3D qemu_opts_parse_noisily(qemu_find_opts("realtim=
e"),
-                                               optarg, false);
+                                               qopt[i].u.realtime.data, =
false);
                 if (!opts) {
                     exit(1);
                 }
                 enable_mlock =3D qemu_opt_get_bool(opts, "mlock", true);
                 break;
-            case QEMU_OPTION_msg:
-                opts =3D qemu_opts_parse_noisily(qemu_find_opts("msg"), =
optarg,
-                                               false);
+            case QAPI_OPTION_KIND_MSG:
+                opts =3D qemu_opts_parse_noisily(qemu_find_opts("msg"),
+                                               qopt[i].u.msg.data, false=
);
                 if (!opts) {
                     exit(1);
                 }
                 configure_msg(opts);
                 break;
-            case QEMU_OPTION_dump_vmstate:
+            case QAPI_OPTION_KIND_DUMP_VMSTATE:
                 if (vmstate_dump_file) {
                     error_report("only one '-dump-vmstate' "
                                  "option may be given");
                     exit(1);
                 }
-                vmstate_dump_file =3D fopen(optarg, "w");
+                vmstate_dump_file =3D fopen(qopt[i].u.dump_vmstate.data,=
 "w");
                 if (vmstate_dump_file =3D=3D NULL) {
-                    error_report("open %s: %s", optarg, strerror(errno))=
;
+                    error_report("open %s: %s",
+                                 qopt[i].u.dump_vmstate.data, strerror(e=
rrno));
                     exit(1);
                 }
                 break;
             default:
-                os_parse_cmd_args(popt->index, optarg);
+                os_parse_cmd_args(&qopt[i]);
             }
-        }
     }
+
+    for (i =3D qopt[i].idx; argv[i]; i++) {
+        loc_set_cmdline(argv, i, 1);
+        hda_opts =3D drive_add(IF_DEFAULT, 0, argv[i], HD_OPTS);
+    }
+
     /*
      * Clear error location left behind by the loop.
      * Best done right after the loop.  Do not insert code here!
@@ -4826,6 +4830,8 @@ int main(int argc, char **argv, char **envp)
         break;
     }
=20
+    g_free((void *)qopt);
+
     /* must be after terminal init, SDL library changes signal handlers =
*/
     os_setup_signal_handling();
=20
--=20
2.13.6
