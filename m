Received: from eggs.gnu.org ([209.51.188.92]:47861)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gtEbd-00078V-DE
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 11:38:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gtEbX-0006rx-Hp
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 11:38:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49240)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gtEbW-0006eg-PQ
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 11:38:47 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 11 Feb 2019 17:38:29 +0100
Message-Id: <20190211163829.10297-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] Kconfig: add documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, peter.maydell@linaro.org, thuth@redhat.com, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/devel/kconfig.rst | 284 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 284 insertions(+)
 create mode 100644 docs/devel/kconfig.rst

diff --git a/docs/devel/kconfig.rst b/docs/devel/kconfig.rst
new file mode 100644
index 0000000000..b653c43b12
--- /dev/null
+++ b/docs/devel/kconfig.rst
@@ -0,0 +1,284 @@
+Introduction
+------------
+
+QEMU is a very versatile emulator; it can be built for a variety of targ=
ets, where
+each target can emulate various boards and at the same time different ta=
rgets can
+share large amounts of code.  For example, a POWER and an x86 boards can=
 run the
+same code to emulate a PCI network card, even though the boards use diff=
erent PCI
+host bridges, and they can run the same code to emulate a SCSI disk whil=
e using
+different SCSI adapters.  ARM, s390 and x86 boards can both present a vi=
rtio-blk
+disk to their guests, but with three different virtio guest interfaces.
+
+Each QEMU target enables a subset of the boards, devices and buses that =
are included
+in QEMU's source code.  As a result, each QEMU executable only links a s=
mall subset
+of the files that form QEMU's source code; anything that is not needed t=
o support
+a particular target is culled.
+
+QEMU uses a simple domain-specific language to describe the dependencies=
 between
+components.  This is useful for two reasons:
+
+* new targets and boards can be added without knowing in detail the arch=
itecture of
+  the hardware emulation subsystems.  Boards only have to list the compo=
nents they
+  need, and the compiled executable will include all the required depend=
encies and
+  all the devices that the user can add to that board.
+
+* users can easily build reduced versions of QEMU that support only a su=
bset of
+  boards or devices.  For example, by default most targets will include =
all emulated
+  PCI devices that QEMU supports, but the build process is configurable =
and it is easy
+  to drop unnecessary (or otherwise unwanted) code to make a leaner bina=
ry;
+
+This domain-specific language is based on the Kconfig language that orig=
inated in the
+Linux kernel, though it was heavily simplified and the handling of depen=
dencies is
+stricter in QEMU.
+
+Unlike Linux, there is no user interface to edit the configuration, whic=
h is instead
+specified in per-target files under the ``default-configs/`` directory o=
f the
+QEMU source tree.  This is because, unlike Linux, configuration and depe=
ndencies can be
+treated as a black box when building QEMU; the default configuration tha=
t QEMU
+ships with should be okay in almost all cases.
+
+The Kconfig language
+--------------------
+
+Kconfig defines configurable components in files named ``hw/*/Kconfig``.
+Note that configurable components are _not_ visible in C code as preproc=
essor symbols;
+they are only visible in the Makefile.  Each configurable components
+defines a Makefile variable whose name starts with ``CONFIG_``.
+
+All elements have boolean (true/false) type.  They are defined in a Kcon=
fig
+stanza like the following::
+
+      config ARM_VIRT
+         bool
+         imply PCI_DEVICES
+         imply VFIO_AMD_XGBE
+         imply VFIO_XGMAC
+         select A15MPCORE
+         select ACPI
+         select ARM_SMMUV3
+
+The ``config`` keyword introduces a new configuration element.  In the e=
xample above,
+Makefiles will have access to a variable named ``CONFIG_ARM_VIRT``, with=
 value ``y`` or
+``n`` (respectively for boolean true and false).
+
+The ``bool`` data type declaration is optional, but it is suggested to i=
nclude it for
+clarity and future-proofing.  After ``bool`` the following directives ca=
n be included:
+
+**dependencies**: ``depends on <expr>``
+
+  This defines a dependency for this configurable element. Dependencies
+  evaluate an expression and force the value of the variable to false
+  if the expression is false.
+
+  ``<expr>`` can be an arbitrary Boolean expression.  The ``&&``, ``||``=
 and ``!``
+  operators are supported, respectively for conjunction (AND), disjuncti=
on
+  (OR) and negation (NOT).
+
+**reverse dependencies**: ``select <symbol> [if <expr>]``
+
+  While ``depends on`` forces a symbol to false, reverse dependencies ca=
n be
+  used to force another symbol to true.  In the following example,
+  ``CONFIG_BAZ`` will be true whenever ``CONFIG_FOO`` is true::
+
+    config FOO
+      select BAZ
+
+  The optional expression will prevent ``select`` from having any effect
+  unless it is true.
+
+  Note that unlike Linux, QEMU will detect contradictions between ``depe=
nds on`` and
+  ``select`` statements and prevent you from building such a configurati=
on.
+
+**default value**: ``default <value> [if <expr>]``
+
+  Default values are assigned to the config symbol if no other
+  value was set by the user via ``default-configs/*.mak`` files, and onl=
y if
+  ``select`` or ``depends on`` directives do not force the value to true=
 or
+  false respectively.
+
+  Optionally, a condition for applying the default value can be added wi=
th
+  ``if``.  A config option can have any number of default values (usuall=
y, if more than
+  one default is present, they will have different conditions). If multi=
ple
+  default values satisfy their condition, only the first defined one is =
active.
+
+**reverse default** (weak reverse dependency): ``imply <symbol> [if <exp=
r>]``
+
+  This is similar to ``select`` as it applies a lower limit of ``y`` to =
another
+  symbol.  However, the lower limit is only a default and the "implied" =
symbol's
+  value may still be set to ``n`` from a ``default-configs/*.mak`` files=
.  The
+  following two examples are equivalent::
+
+    config FOO
+      bool
+      imply BAZ
+
+    config BAZ
+      bool
+      default y if FOO
+
+  The next section explains where to use ``imply`` or ``default y``.
+
+Guidelines for writing Kconfig files
+------------------------------------
+
+Configurable elements in QEMU fall under five broad groups which declare
+their dependencies in different ways:
+
+**subsystems**, of which **buses** are a special case:
+
+  Example::
+
+    config SCSI
+      bool
+
+  Subsystems always default to false (they have no ``default`` directive=
)
+  and are never visible in ``default-configs/*.mak`` files.  It's
+  up to other symbols to ``select`` whatever subsystems they require.
+
+  They sometimes have ``select`` directives to bring in other required
+  subsystems or buses.  For example, ``AUX`` (the DisplayPort auxiliary
+  channel "bus") selects ``I2C`` because it can act as an I2C master too=
.
+
+**devices**, for example SERIAL
+
+  Example::
+
+    config MEGASAS_SCSI_PCI
+      bool
+      default y if PCI_DEVICES
+      depends on PCI
+      select SCSI
+
+  Devices are the most complex of the five.  They can have a variety of =
directives
+  that cooperate so that a default configuration includes all the device=
s that can
+  be accessed from QEMU.
+
+  Devices *depend on* the bus that they lie on, for example a PCI device=
 would specify
+  ``depends on PCI``.  An MMIO device will likely have no ``depends on``=
 directive.
+  Devices also *select* the buses that the device provides, for example =
a SCSI
+  adapter would specify ``select SCSI``.  Finally, devices are usually `=
`default y`` if
+  and only if they have at least one ``depends on``; the default could b=
e conditional
+  on a device group.
+
+  Devices also select any optional subsystem that they use; for example =
a video card
+  might specify ``select EDID`` if it needs to build EDID information an=
d publish it
+  to the guest.
+
+**device groups**
+
+  Example::
+
+    config PCI_DEVICES
+      bool
+
+  Device groups provide a convenient mechanism to enable/disable many de=
vices in one
+  go, if several targets want to do so.  Device groups usually need no d=
irective
+  and are not used in the Makefile either; they only appear as condition=
s for
+  ``default y`` directives.
+
+  QEMU currently has two device groups, ``PCI_DEVICES`` and ``TEST_DEVIC=
ES``.  PCI
+  devices usually have a ``default y if PCI_DEVICES`` directive rather t=
han just
+  ``default y``, so that some boards (notably s390) can easily support o=
nly VFIO
+  (passthrough) and virtio-pci devices.  ``TEST_DEVICES`` instead is use=
d for devices
+  that are rarely used on production virtual machines, but provide usefu=
l hooks to
+  test QEMU or KVM.
+
+**boards**
+
+  Example::
+
+    config SUN4M
+      bool
+      imply TCX
+      imply CG3
+      select CS4231
+      select ECCMEMCTL
+      select EMPTY_SLOT
+      select ESCC
+      select ESP
+      select FDC
+      select SLAVIO
+      select LANCE
+      select M48T59
+      select STP2000
+
+  Boards specify their constituent devices using ``imply`` and ``select`=
` directives.
+  A device should be listed under ``select`` if the board cannot be star=
ted at all without
+  it.  It should be listed under ``imply`` if (depending on the QEMU com=
mand line) the board
+  may or may not be started without it.  Boards also default to false; t=
hey are enabled
+  by the ``default-configs/*.mak`` for the target they apply to.
+
+**internal elements**
+
+  Example::
+
+    config ECCMEMCTL
+      bool
+      select ECC
+
+  Internal elements group code that is useful in several other boards or=
 devices.
+  They are usually enabled with ``select`` and in turn select other elem=
ents; they
+  are never visible in ``default-configs/*.mak`` files.
+
+Writing and modifying default configurations
+--------------------------------------------
+
+In addition to the Kconfig files under hw/, each target also includes a =
file
+called `default-configs/TARGETNAME-softmmu.mak`.  These files initialize=
 some
+Kconfig variables to non-default values and provide the starting point t=
o turn on
+devices and subsystems.
+
+A file in ``default-configs/`` looks like the following example::
+
+    # Default configuration for alpha-softmmu
+
+    # Uncomment the following lines to disable these optional devices:
+    #
+    #CONFIG_PCI_DEVICES=3Dn
+    #CONFIG_TEST_DEVICES=3Dn
+
+    # Boards:
+    #
+    CONFIG_DP264=3Dy
+
+The first part, consisting of commented-out ``=3Dn`` assignments, tells =
the user which
+devices or device groups are implied by the boards.  The second part, co=
nsisting of
+``=3Dy`` assignments, tells the user which boards are supported by the t=
arget.  The user
+will typically modify default the configuration by uncommenting lines in=
 the first
+group, or commenting out lines in the second group.
+
+It is also possible to run QEMU's configure script with the ``--with-def=
ault-devices``
+option.  Doing so disables all the ``default`` and ``imply`` directives.=
  In this
+case, the user will probably want to change some lines in the first grou=
p, for example
+like this::
+
+   CONFIG_PCI_DEVICES=3Dy
+   #CONFIG_TEST_DEVICES=3Dn
+
+and/or pick a subset of the devices in those device groups.  Right now t=
here is
+no single place that lists all the optional devices for ``CONFIG_PCI_DEV=
ICES`` and
+``CONFIG_TEST_DEVICES``.  In the future, we expect that ``.mak`` files w=
ill be automatically
+generated, so that they will include all these symbols and some help tex=
t on what they
+do.
+
+``Kconfig.host``
+----------------
+
+In some special cases, a configurable element depends on host features t=
hat are
+detected by QEMU's configure script; for example some devices depend on =
the availability
+of KVM or on the presence of a library on the host.
+
+These symbols should be listed in ``Kconfig.host`` like this::
+
+    config KVM
+      bool
+
+and also listed as follows in the top-level Makefile's ``MINIKCONF_ARGS`=
` variable::
+
+    MINIKCONF_ARGS =3D \
+      $@ $*-config.devices.mak.d $< $(MINIKCONF_INPUTS) \
+      CONFIG_KVM=3D$(CONFIG_KVM) \
+      CONFIG_SPICE=3D$(CONFIG_SPICE) \
+      CONFIG_TPM=3D$(CONFIG_TPM) \
+      ...
+
--=20
2.20.1
