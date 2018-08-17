Received: from eggs.gnu.org ([2001:4830:134:3::10]:48290)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fqTef-00056h-PK
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 21:34:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fqTec-00065Z-Ck
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 21:34:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60670)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fqTeW-000628-HP
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 21:34:14 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 16 Aug 2018 22:33:53 -0300
Message-Id: <20180817013400.13353-2-ehabkost@redhat.com>
In-Reply-To: <20180817013400.13353-1-ehabkost@redhat.com>
References: <20180817013400.13353-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 1/8] docs: add guidance on configuring CPU
 models for x86
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>

From: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

With the recent set of CPU hardware vulnerabilities on x86, it is
increasingly difficult to understand which CPU configurations are
good to use and what flaws they might be vulnerable to.

This doc attempts to help management applications and administrators in
picking sensible CPU configuration on x86 hosts. It outlines which of
the named CPU models are good choices, and describes which extra CPU
flags should be enabled to allow the guest to mitigate hardware flaws.

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Message-Id: <20180627160103.13634-1-berrange@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 docs/qemu-cpu-models.texi | 484 ++++++++++++++++++++++++++++++++++++++
 Makefile                  |   7 +-
 MAINTAINERS               |   1 +
 qemu-doc.texi             |   6 +
 4 files changed, 497 insertions(+), 1 deletion(-)
 create mode 100644 docs/qemu-cpu-models.texi

diff --git a/docs/qemu-cpu-models.texi b/docs/qemu-cpu-models.texi
new file mode 100644
index 0000000000..1935f98c63
--- /dev/null
+++ b/docs/qemu-cpu-models.texi
@@ -0,0 +1,484 @@
+@c man begin SYNOPSIS
+QEMU / KVM CPU model configuration
+@c man end
+
+@c man begin DESCRIPTION
+
+@menu
+* recommendations_cpu_models_x86:: Recommendations for KVM CPU model con=
figuration on x86 hosts
+* cpu_model_syntax_apps::          Syntax for configuring CPU models
+@end menu
+
+QEMU / KVM virtualization supports two ways to configure CPU models
+
+@table @option
+
+@item Host passthrough
+
+This passes the host CPU model features, model, stepping, exactly to the
+guest. Note that KVM may filter out some host CPU model features if they
+cannot be supported with virtualization. Live migration is unsafe when
+this mode is used as libvirt / QEMU cannot guarantee a stable CPU is
+exposed to the guest across hosts. This is the recommended CPU to use,
+provided live migration is not required.
+
+@item Named model
+
+QEMU comes with a number of predefined named CPU models, that typically
+refer to specific generations of hardware released by Intel and AMD.
+These allow the guest VMs to have a degree of isolation from the host CP=
U,
+allowing greater flexibility in live migrating between hosts with differ=
ing
+hardware.
+@end table
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
+@node recommendations_cpu_models_x86
+@subsection Recommendations for KVM CPU model configuration on x86 hosts
+
+The information that follows provides recommendations for configuring
+CPU models on x86 hosts. The goals are to maximise performance, while
+protecting guest OS against various CPU hardware flaws, and optionally
+enabling live migration between hosts with hetergeneous CPU models.
+
+@menu
+* preferred_cpu_models_intel_x86::       Preferred CPU models for Intel =
x86 hosts
+* important_cpu_features_intel_x86::     Important CPU features for Inte=
l x86 hosts
+* preferred_cpu_models_amd_x86::         Preferred CPU models for AMD x8=
6 hosts
+* important_cpu_features_amd_x86::       Important CPU features for AMD =
x86 hosts
+* default_cpu_models_x86::               Default x86 CPU models
+* other_non_recommended_cpu_models_x86:: Other non-recommended x86 CPUs
+@end menu
+
+@node preferred_cpu_models_intel_x86
+@subsubsection Preferred CPU models for Intel x86 hosts
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
+@table @option
+@item @code{Skylake-Server}
+@item @code{Skylake-Server-IBRS}
+
+Intel Xeon Processor (Skylake, 2016)
+
+
+@item @code{Skylake-Client}
+@item @code{Skylake-Client-IBRS}
+
+Intel Core Processor (Skylake, 2015)
+
+
+@item @code{Broadwell}
+@item @code{Broadwell-IBRS}
+@item @code{Broadwell-noTSX}
+@item @code{Broadwell-noTSX-IBRS}
+
+Intel Core Processor (Broadwell, 2014)
+
+
+@item @code{Haswell}
+@item @code{Haswell-IBRS}
+@item @code{Haswell-noTSX}
+@item @code{Haswell-noTSX-IBRS}
+
+Intel Core Processor (Haswell, 2013)
+
+
+@item @code{IvyBridge}
+@item @code{IvyBridge-IBRS}
+
+Intel Xeon E3-12xx v2 (Ivy Bridge, 2012)
+
+
+@item @code{SandyBridge}
+@item @code{SandyBridge-IBRS}
+
+Intel Xeon E312xx (Sandy Bridge, 2011)
+
+
+@item @code{Westmere}
+@item @code{Westmere-IBRS}
+
+Westmere E56xx/L56xx/X56xx (Nehalem-C, 2010)
+
+
+@item @code{Nehalem}
+@item @code{Nehalem-IBRS}
+
+Intel Core i7 9xx (Nehalem Class Core i7, 2008)
+
+
+@item @code{Penryn}
+
+Intel Core 2 Duo P9xxx (Penryn Class Core 2, 2007)
+
+
+@item @code{Conroe}
+
+Intel Celeron_4x0 (Conroe/Merom Class Core 2, 2006)
+
+@end table
+
+@node important_cpu_features_intel_x86
+@subsubsection Important CPU features for Intel x86 hosts
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
+@table @option
+
+@item @code{pcid}
+
+Recommended to mitigate the cost of the Meltdown (CVE-2017-5754) fix
+
+Included by default in Haswell, Broadwell & Skylake Intel CPU models.
+
+Should be explicitly turned on for Westmere, SandyBridge, and IvyBridge
+Intel CPU models. Note that some desktop/mobile Westmere CPUs cannot
+support this feature.
+
+
+@item @code{spec-ctrl}
+
+Required to enable the Spectre (CVE-2017-5753 and CVE-2017-5715) fix,
+in cases where retpolines are not sufficient.
+
+Included by default in Intel CPU models with -IBRS suffix.
+
+Must be explicitly turned on for Intel CPU models without -IBRS suffix.
+
+Requires the host CPU microcode to support this feature before it
+can be used for guest CPUs.
+
+
+@item @code{ssbd}
+
+Required to enable the CVE-2018-3639 fix
+
+Not included by default in any Intel CPU model.
+
+Must be explicitly turned on for all Intel CPU models.
+
+Requires the host CPU microcode to support this feature before it
+can be used for guest CPUs.
+
+
+@item @code{pdpe1gb}
+
+Recommended to allow guest OS to use 1GB size pages
+
+Not included by default in any Intel CPU model.
+
+Should be explicitly turned on for all Intel CPU models.
+
+Note that not all CPU hardware will support this feature.
+@end table
+
+
+@node preferred_cpu_models_amd_x86
+@subsubsection Preferred CPU models for AMD x86 hosts
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
+@table @option
+
+@item @code{EPYC}
+@item @code{EPYC-IBPB}
+
+AMD EPYC Processor (2017)
+
+
+@item @code{Opteron_G5}
+
+AMD Opteron 63xx class CPU (2012)
+
+
+@item @code{Opteron_G4}
+
+AMD Opteron 62xx class CPU (2011)
+
+
+@item @code{Opteron_G3}
+
+AMD Opteron 23xx (Gen 3 Class Opteron, 2009)
+
+
+@item @code{Opteron_G2}
+
+AMD Opteron 22xx (Gen 2 Class Opteron, 2006)
+
+
+@item @code{Opteron_G1}
+
+AMD Opteron 240 (Gen 1 Class Opteron, 2004)
+@end table
+
+@node important_cpu_features_amd_x86
+@subsubsection Important CPU features for AMD x86 hosts
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
+@table @option
+
+@item @code{ibpb}
+
+Required to enable the Spectre (CVE-2017-5753 and CVE-2017-5715) fix,
+in cases where retpolines are not sufficient.
+
+Included by default in AMD CPU models with -IBPB suffix.
+
+Must be explicitly turned on for AMD CPU models without -IBPB suffix.
+
+Requires the host CPU microcode to support this feature before it
+can be used for guest CPUs.
+
+
+@item @code{virt-ssbd}
+
+Required to enable the CVE-2018-3639 fix
+
+Not included by default in any AMD CPU model.
+
+Must be explicitly turned on for all AMD CPU models.
+
+This should be provided to guests, even if amd-ssbd is also
+provided, for maximum guest compatibility.
+
+Note for some QEMU / libvirt versions, this must be force enabled
+when when using "Host model", because this is a virtual feature
+that doesn't exist in the physical host CPUs.
+
+
+@item @code{amd-ssbd}
+
+Required to enable the CVE-2018-3639 fix
+
+Not included by default in any AMD CPU model.
+
+Must be explicitly turned on for all AMD CPU models.
+
+This provides higher performance than virt-ssbd so should be
+exposed to guests whenever available in the host. virt-ssbd
+should none the less also be exposed for maximum guest
+compatability as some kernels only know about virt-ssbd.
+
+
+@item @code{amd-no-ssb}
+
+Recommended to indicate the host is not vulnerable CVE-2018-3639
+
+Not included by default in any AMD CPU model.
+
+Future hardware genarations of CPU will not be vulnerable to
+CVE-2018-3639, and thus the guest should be told not to enable
+its mitigations, by exposing amd-no-ssb. This is mutually
+exclusive with virt-ssbd and amd-ssbd.
+
+
+@item @code{pdpe1gb}
+
+Recommended to allow guest OS to use 1GB size pages
+
+Not included by default in any AMD CPU model.
+
+Should be explicitly turned on for all AMD CPU models.
+
+Note that not all CPU hardware will support this feature.
+@end table
+
+
+@node default_cpu_models_x86
+@subsubsection Default x86 CPU models
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
+follow the earlier guidance to setup a better CPU configuration, with ho=
st
+passthrough recommended if live migration is not needed.
+
+@table @option
+@item @code{qemu32}
+@item @code{qemu64}
+
+QEMU Virtual CPU version 2.5+ (32 & 64 bit variants)
+
+qemu64 is used for x86_64 guests and qemu32 is used for i686 guests, whe=
n no
+-cpu argument is given to QEMU, or no <cpu> is provided in libvirt XML.
+@end table
+
+
+@node other_non_recommended_cpu_models_x86
+@subsubsection Other non-recommended x86 CPUs
+
+The following CPUs models are compatible with most AMD and Intel x86 hos=
ts, but
+their usage is discouraged, as they expose a very limited featureset, wh=
ich
+prevents guests having optimal performance.
+
+@table @option
+
+@item @code{kvm32}
+@item @code{kvm64}
+
+Common KVM processor (32 & 64 bit variants)
+
+Legacy models just for historical compatibility with ancient QEMU versio=
ns.
+
+
+@item @code{486}
+@item @code{athlon}
+@item @code{phenom}
+@item @code{coreduo}
+@item @code{core2duo}
+@item @code{n270}
+@item @code{pentium}
+@item @code{pentium2}
+@item @code{pentium3}
+
+Various very old x86 CPU models, mostly predating the introduction of
+hardware assisted virtualization, that should thus not be required for
+running virtual machines.
+@end table
+
+@node cpu_model_syntax_apps
+@subsection Syntax for configuring CPU models
+
+The example below illustrate the approach to configuring the various
+CPU models / features in QEMU and libvirt
+
+@menu
+* cpu_model_syntax_qemu::    QEMU command line
+* cpu_model_syntax_libvirt:: Libvirt guest XML
+@end menu
+
+@node cpu_model_syntax_qemu
+@subsubsection QEMU command line
+
+@table @option
+
+@item Host passthrough
+
+@example
+   $ qemu-system-x86_64 -cpu host
+@end example
+
+With feature customization:
+
+@example
+   $ qemu-system-x86_64 -cpu host,-vmx,...
+@end example
+
+@item Named CPU models
+
+@example
+   $ qemu-system-x86_64 -cpu Westmere
+@end example
+
+With feature customization:
+
+@example
+   $ qemu-system-x86_64 -cpu Westmere,+pcid,...
+@end example
+
+@end table
+
+@node cpu_model_syntax_libvirt
+@subsubsection Libvirt guest XML
+
+@table @option
+
+@item Host passthrough
+
+@example
+   <cpu mode=3D'host-passthrough'/>
+@end example
+
+With feature customization:
+
+@example
+   <cpu mode=3D'host-passthrough'>
+       <feature name=3D"vmx" policy=3D"disable"/>
+       ...
+   </cpu>
+@end example
+
+@item Host model
+
+@example
+   <cpu mode=3D'host-model'/>
+@end example
+
+With feature customization:
+
+@example
+   <cpu mode=3D'host-model'>
+       <feature name=3D"vmx" policy=3D"disable"/>
+       ...
+   </cpu>
+@end example
+
+@item Named model
+
+@example
+   <cpu mode=3D'custom'>
+       <model name=3D"Westmere"/>
+   </cpu>
+@end example
+
+With feature customization:
+
+@example
+   <cpu mode=3D'custom'>
+       <model name=3D"Westmere"/>
+       <feature name=3D"pcid" policy=3D"require"/>
+       ...
+   </cpu>
+@end example
+
+@end table
+
+@c man end
+
+@ignore
+
+@setfilename qemu-cpu-models
+@settitle QEMU / KVM CPU model configuration
+
+@c man begin SEEALSO
+The HTML documentation of QEMU for more precise information and Linux
+user mode emulator invocation.
+@c man end
+
+@c man begin AUTHOR
+Daniel P. Berrange
+@c man end
+
+@end ignore
diff --git a/Makefile b/Makefile
index 2da686be33..b7c6e57de6 100644
--- a/Makefile
+++ b/Makefile
@@ -357,6 +357,7 @@ DOCS=3Dqemu-doc.html qemu-doc.txt qemu.1 qemu-img.1 q=
emu-nbd.8 qemu-ga.8
 DOCS+=3Ddocs/interop/qemu-qmp-ref.html docs/interop/qemu-qmp-ref.txt doc=
s/interop/qemu-qmp-ref.7
 DOCS+=3Ddocs/interop/qemu-ga-ref.html docs/interop/qemu-ga-ref.txt docs/=
interop/qemu-ga-ref.7
 DOCS+=3Ddocs/qemu-block-drivers.7
+DOCS+=3Ddocs/qemu-cpu-models.7
 ifdef CONFIG_VIRTFS
 DOCS+=3Dfsdev/virtfs-proxy-helper.1
 endif
@@ -778,6 +779,7 @@ distclean: clean
 	rm -f docs/interop/qemu-qmp-ref.pdf docs/interop/qemu-ga-ref.pdf
 	rm -f docs/interop/qemu-qmp-ref.html docs/interop/qemu-ga-ref.html
 	rm -f docs/qemu-block-drivers.7
+	rm -f docs/qemu-cpu-models.7
 	for d in $(TARGET_DIRS); do \
 	rm -rf $$d || exit 1 ; \
         done
@@ -823,6 +825,7 @@ ifdef CONFIG_POSIX
 	$(INSTALL_DIR) "$(DESTDIR)$(mandir)/man7"
 	$(INSTALL_DATA) docs/interop/qemu-qmp-ref.7 "$(DESTDIR)$(mandir)/man7"
 	$(INSTALL_DATA) docs/qemu-block-drivers.7 "$(DESTDIR)$(mandir)/man7"
+	$(INSTALL_DATA) docs/qemu-cpu-models.7 "$(DESTDIR)$(mandir)/man7"
 ifneq ($(TOOLS),)
 	$(INSTALL_DATA) qemu-img.1 "$(DESTDIR)$(mandir)/man1"
 	$(INSTALL_DIR) "$(DESTDIR)$(mandir)/man8"
@@ -965,6 +968,7 @@ fsdev/virtfs-proxy-helper.1: fsdev/virtfs-proxy-helpe=
r.texi
 qemu-nbd.8: qemu-nbd.texi qemu-option-trace.texi
 qemu-ga.8: qemu-ga.texi
 docs/qemu-block-drivers.7: docs/qemu-block-drivers.texi
+docs/qemu-cpu-models.7: docs/qemu-cpu-models.texi
=20
 html: qemu-doc.html docs/interop/qemu-qmp-ref.html docs/interop/qemu-ga-=
ref.html
 info: qemu-doc.info docs/interop/qemu-qmp-ref.info docs/interop/qemu-ga-=
ref.info
@@ -974,7 +978,8 @@ txt: qemu-doc.txt docs/interop/qemu-qmp-ref.txt docs/=
interop/qemu-ga-ref.txt
 qemu-doc.html qemu-doc.info qemu-doc.pdf qemu-doc.txt: \
 	qemu-img.texi qemu-nbd.texi qemu-options.texi qemu-option-trace.texi \
 	qemu-monitor.texi qemu-img-cmds.texi qemu-ga.texi \
-	qemu-monitor-info.texi docs/qemu-block-drivers.texi
+	qemu-monitor-info.texi docs/qemu-block-drivers.texi \
+	docs/qemu-cpu-models.texi
=20
 docs/interop/qemu-ga-ref.dvi docs/interop/qemu-ga-ref.html \
     docs/interop/qemu-ga-ref.info docs/interop/qemu-ga-ref.pdf \
diff --git a/MAINTAINERS b/MAINTAINERS
index c48d9271cf..a0342ba7d9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -289,6 +289,7 @@ F: tests/tcg/i386/
 F: tests/tcg/x86_64/
 F: hw/i386/
 F: disas/i386.c
+F: docs/qemu-cpu-models.texi
 T: git git://github.com/ehabkost/qemu.git x86-next
=20
 Xtensa
diff --git a/qemu-doc.texi b/qemu-doc.texi
index abfd2db546..fd64f9fcf5 100644
--- a/qemu-doc.texi
+++ b/qemu-doc.texi
@@ -135,6 +135,7 @@ accelerator is required to use more than one host CPU=
 for emulation.
 * pcsys_keys::         Keys in the graphical frontends
 * mux_keys::           Keys in the character backend multiplexer
 * pcsys_monitor::      QEMU Monitor
+* cpu_models::         CPU models
 * disk_images::        Disk Images
 * pcsys_network::      Network emulation
 * pcsys_other_devs::   Other Devices
@@ -602,6 +603,11 @@ The monitor understands integers expressions for eve=
ry integer
 argument. You can use register names to get the value of specifics
 CPU registers by prefixing them with @emph{$}.
=20
+@node cpu_models
+@section CPU models
+
+@include docs/qemu-cpu-models.texi
+
 @node disk_images
 @section Disk Images
=20
--=20
2.18.0.rc1.1.g3f1ff2140
