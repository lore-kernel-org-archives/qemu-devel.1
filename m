Received: from eggs.gnu.org ([2001:4830:134:3::10]:57484)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fTpWT-000273-H2
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 10:16:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fTpWO-0000gl-46
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 10:16:17 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54234 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fTpWN-0000gF-V6
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 10:16:12 -0400
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Fri, 15 Jun 2018 15:16:09 +0100
Message-Id: <20180615141609.20749-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] docs: add guidance on configuring CPU models
 for x86
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>

With the recent set of CPU hardware vulnerabilities on x86, it is
increasingly difficult to understand which CPU configurations are
good to use and what flaws they might be vulnerable to.

This doc attempts to help management applications and administrators in
picking sensible CPU configuration on x86 hosts. It outlines which of
the named CPU models are good choices, and describes which extra CPU
flags should be enabled to allow the guest to mitigate hardware flaws.

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 MAINTAINERS             |   1 +
 docs/cpu-models-x86.txt | 400 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 401 insertions(+)
 create mode 100644 docs/cpu-models-x86.txt

diff --git a/MAINTAINERS b/MAINTAINERS
index 8a94517e9e..4dc1d60fef 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -285,6 +285,7 @@ S: Maintained
 F: target/i386/
 F: hw/i386/
 F: disas/i386.c
+F: docs/cpu-models-x86.txt
 T: git git://github.com/ehabkost/qemu.git x86-next
=20
 Xtensa
diff --git a/docs/cpu-models-x86.txt b/docs/cpu-models-x86.txt
new file mode 100644
index 0000000000..719e5a4226
--- /dev/null
+++ b/docs/cpu-models-x86.txt
@@ -0,0 +1,400 @@
+         Recommendations for KVM CPU model configuration on x86 hosts
+	 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Available KVM CPU models and features
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+KVM/QEMU virtualization supports two ways to configure CPU models
+
+ 1. Host passthrough
+
+    This passes the host CPU model features, model, stepping, exactly to=
 the
+    guest. Note that KVM may filter out some host CPU model features if =
they
+    cannot be supported with virtualization. Live migration is unsafe wh=
en
+    this mode is used as libvirt / QEMU cannot guarantee a stable CPU is
+    exposed to the guest across hosts. This is the recommended CPU to us=
e,
+    provided live migration is not required.
+
+ 2. Named model
+
+    QEMU comes with a number of predefined named CPU models, that typica=
lly
+    refer to specific generations of hardware released by Intel and AMD.
+    These allow the guest VMs to have a degree of isolation from the hos=
t CPU,
+    allowing greater flexibility in live migrating between hosts with di=
ffering
+    hardware.
+
+In both cases, it is possible to optionally add or remove individual CPU
+features, to alter what is presented to the guest by default.
+
+Libvirt supports a third way to configure CPU models known as "Host mode=
l".
+This uses the QEMU "Named model" feature, automatically picking a CPU mo=
del
+that is similar the host CPU, and then adding extra features to approxim=
ate
+the host model as closely as possible. This does not guarantee the CPU f=
amily,
+stepping, etc will precisely match the host CPU, as they would with "Hos=
t
+passthrough", but gives much of the benefit of passthrough, while making
+live migration safe.
+
+
+Preferred CPU models for Intel x86 hosts
+----------------------------------------
+
+The following CPU models are preferred for use on Intel hosts. Administr=
ators /
+applications are recommended to use the CPU model that matches the gener=
ation
+of the host CPUs in use. In a deployment with a mixture of host CPU mode=
ls
+between machines, if live migration compatibility is required, use the n=
ewest
+CPU model that is compatible across all desired hosts.
+
+- Skylake-Server
+- Skylake-Server-IBRS
+
+  Intel Xeon Processor (Skylake, 2016)
+
+
+- Skylake-Client
+- Skylake-Client-IBRS
+
+  Intel Core Processor (Skylake, 2015)
+
+
+- Broadwell
+- Broadwell-IBRS
+- Broadwell-noTSX
+- Broadwell-noTSX-IBRS
+
+  Intel Core Processor (Broadwell, 2014)
+
+
+- Haswell
+- Haswell-IBRS
+- Haswell-noTSX
+- Haswell-noTSX-IBRS
+
+  Intel Core Processor (Haswell, 2013)
+
+
+- IvyBridge
+- IvyBridge-IBRS
+
+  Intel Xeon E3-12xx v2 (Ivy Bridge, 2012)
+
+
+- SandyBridge
+- SandyBridge-IBRS
+
+  Intel Xeon E312xx (Sandy Bridge, 2011)
+
+
+- Westmere
+- Westmere-IBRS
+
+  Westmere E56xx/L56xx/X56xx (Nehalem-C, 2010)
+
+
+- Nehalem
+- Nehalem-IBRS
+
+  Intel Core i7 9xx (Nehalem Class Core i7, 2008)
+
+
+- Penryn
+
+  Intel Core 2 Duo P9xxx (Penryn Class Core 2, 2007)
+
+
+- Conroe
+
+  Intel Celeron_4x0 (Conroe/Merom Class Core 2, 2006)
+
+
+Important CPU features for Intel x86 hosts
+------------------------------------------
+
+The following are important CPU features that should be used on Intel x8=
6
+hosts, when available in the host CPU. Some of them require explicit
+configuration to enable, as they are not included by default in some, or=
 all,
+of the named CPU models listed above. In general all of these features a=
re
+included if using "Host passthrough" or "Host model".
+
+
+ - pcid
+
+   Recommended to mitigate the cost of the Meltdown (CVE-2017-5754) fix
+
+   Included by default in Haswell, Broadwell & Skylake Intel CPU models.
+
+   Should be explicitly turned on for Westmere, SandyBridge, and IvyBrid=
ge
+   Intel CPU models. Note that some desktop/mobile Westmere CPUs cannot
+   support this feature.
+
+
+ - spec-ctrl
+
+   Required to enable the Spectre (CVE-2017-5753 and CVE-2017-5715) fix,
+   in cases where retpolines are not sufficient.
+
+   Included by default in Intel CPU models with -IBRS suffix.
+
+   Must be explicitly turned on for Intel CPU models without -IBRS suffi=
x.
+
+   Requires the host CPU microcode to support this feature before it
+   can be used for guest CPUs.
+
+
+ - ssbd
+
+   Required to enable the CVE-2018-3639 fix
+
+   Not included by default in any Intel CPU model.
+
+   Must be explicitly turned on for all Intel CPU models.
+
+   Requires the host CPU microcode to support this feature before it
+   can be used for guest CPUs.
+
+
+ - pdpe1gb
+
+   Recommended to allow guest OS to use 1GB size pages
+
+   Not included by default in any Intel CPU model.
+
+   Should be explicitly turned on for all Intel CPU models.
+
+   Note that not all CPU hardware will support this feature.
+
+
+
+Preferred CPU models for AMD x86 hosts
+--------------------------------------
+
+The following CPU models are preferred for use on Intel hosts. Administr=
ators /
+applications are recommended to use the CPU model that matches the gener=
ation
+of the host CPUs in use. In a deployment with a mixture of host CPU mode=
ls
+between machines, if live migration compatibility is required, use the n=
ewest
+CPU model that is compatible across all desired hosts.
+
+- EPYC
+- EPYC-IBPB
+
+  AMD EPYC Processor (2017)
+
+
+- Opteron_G5
+
+  AMD Opteron 63xx class CPU (2012)
+
+
+- Opteron_G4
+
+  AMD Opteron 62xx class CPU (2011)
+
+
+- Opteron_G3
+
+  AMD Opteron 23xx (Gen 3 Class Opteron, 2009)
+
+
+- Opteron_G2
+
+  AMD Opteron 22xx (Gen 2 Class Opteron, 2006)
+
+
+- Opteron_G1
+
+  AMD Opteron 240 (Gen 1 Class Opteron, 2004)
+
+
+Important CPU features for AMD x86 hosts
+----------------------------------------
+
+The following are important CPU features that should be used on AMD x86
+hosts, when available in the host CPU. Some of them require explicit
+configuration to enable, as they are not included by default in some, or=
 all,
+of the named CPU models listed above. In general all of these features a=
re
+included if using "Host passthrough" or "Host model".
+
+
+ - ibpb
+
+   Required to enable the Spectre (CVE-2017-5753 and CVE-2017-5715) fix,
+   in cases where retpolines are not sufficient.
+
+   Included by default in AMD CPU models with -IBPB suffix.
+
+   Must be explicitly turned on for AMD CPU models without -IBPB suffix.
+
+   Requires the host CPU microcode to support this feature before it
+   can be used for guest CPUs.
+
+
+ - virt-ssbd
+
+   Required to enable the CVE-2018-3639 fix
+
+   Not included by default in any AMD CPU model.
+
+   Must be explicitly turned on for all AMD CPU models.
+
+   This should be provided to guests, even if amd-ssbd is also
+   provided, for maximum guest compatibility.
+
+   Note for some QEMU / libvirt versions, this must be force enabled
+   when when using "Host model", because this is a virtual feature
+   that doesn't exist in the physical host CPUs.
+
+
+ - amd-ssbd
+
+   Required to enable the CVE-2018-3639 fix
+
+   Not included by default in any AMD CPU model.
+
+   Must be explicitly turned on for all AMD CPU models.
+
+   This provides higher performance than virt-ssbd so should be
+   exposed to guests whenever available in the host. virt-ssbd
+   should none the less also be exposed for maximum guest
+   compatability as some kernels only know about virt-ssbd.
+
+
+ - amd-no-ssb
+
+   Recommended to indicate the host is not vulnerable CVE-2018-3639
+
+   Not included by default in any AMD CPU model.
+
+   Future hardware genarations of CPU will not be vulnerable to
+   CVE-2018-3639, and thus the guest should be told not to enable
+   its mitigations, by exposing amd-no-ssb. This is mutually
+   exclusive with virt-ssbd and amd-ssbd.
+
+
+ - pdpe1gb
+
+   Recommended to allow guest OS to use 1GB size pages
+
+   Not included by default in any AMD CPU model.
+
+   Should be explicitly turned on for all AMD CPU models.
+
+   Note that not all CPU hardware will support this feature.
+
+
+Default x86 CPU models
+----------------------
+
+The default QEMU CPU models are designed such that they can run on all h=
osts.
+If an application does not wish to do perform any host compatibility che=
cks
+before launching guests, the default is guaranteed to work.
+
+The default CPU models will, however, leave the guest OS vulnerable to v=
arious
+CPU hardware flaws, so their use is strongly discouraged. Applications s=
hould
+follow the guidance earlier to setup a better CPU configuration, with ho=
st
+passthrough recommended if live migration is not needed.
+
+- qemu32
+- qemu64
+
+  QEMU Virtual CPU version 2.5+ (32 & 64 bit variants)
+
+  qemu64 is used for x86_64 guests and qemu32 is used for i686 guests, w=
hen no
+  -cpu argument is given to QEMU, or no <cpu> is provided in libvirt XML=
.
+
+
+Other non-recommended x86 CPUs
+------------------------------
+
+The following CPUs models are compatible with most AMD and Intel x86 hos=
ts, but
+their usage is discouraged, as they expose a very limited featureset, wh=
ich
+prevents guests having optimal performance.
+
+- kvm32
+- kvm64
+
+  Common KVM processor (32 & 64 bit variants)
+
+  Legacy models just for historical compatibility with ancient QEMU vers=
ions.
+
+
+- 486
+- athlon
+- phenom
+- coreduo
+- core2duo
+- n270
+- pentium
+- pentium2
+- pentium3
+
+  Various very old x86 CPU models, mostly predating the introduction of
+  hardware assisted virtualization, that should thus not be required for
+  running virtual machines.
+
+
+Syntax for configuring CPU models in various applications
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
+
+The example below illustrate the approach to configuring the various
+CPU models / features in different applications.
+
+QEMU command line
+------------------
+
+* Host passthrough:
+
+   $ qemu-system-x86_64 -cpu host
+
+   With feature customization:
+
+   $ qemu-system-x86_64 -cpu host,-vmx,...
+
+
+* Named CPU models:
+
+   $ qemu-system-x86_64 -cpu Westmere
+
+   With feature customization:
+
+   $ qemu-system-x86_64 -cpu Westmere,+pcid,...
+
+
+Libvirt guest XML
+-----------------
+
+* Host passthrough
+
+   <cpu mode=3D'host-passthrough'/>
+
+   With feature customization:
+
+   <cpu mode=3D'host-passthrough'>
+       <feature name=3D"vmx" policy=3D"disable"/>
+       ...
+   </cpu>
+
+
+* Host model
+
+   <cpu mode=3D'host-model'/>
+
+   With feature customization:
+
+   <cpu mode=3D'host-model'>
+       <feature name=3D"vmx" policy=3D"disable"/>
+       ...
+   </cpu>
+
+
+* Named model
+
+   <cpu mode=3D'custom'>
+       <model name=3D"Westmere"/>
+   </cpu>
+
+   With feature customization:
+
+   <cpu mode=3D'custom'>
+       <model name=3D"Westmere"/>
+       <feature name=3D"pcid" policy=3D"require"/>
+       ...
+   </cpu>
--=20
2.17.0
