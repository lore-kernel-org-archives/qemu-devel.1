Received: from eggs.gnu.org ([2001:4830:134:3::10]:45724)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1elzgY-0007YC-TD
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 11:13:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1elzgU-0001xq-OU
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 11:13:30 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59604)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1elzgU-0001wj-F8
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 11:13:26 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w1EGCNVr113812
	for <qemu-devel@nongnu.org>; Wed, 14 Feb 2018 11:13:25 -0500
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2g4n6r9ph9-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 14 Feb 2018 11:13:24 -0500
Received: from localhost
	by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 14 Feb 2018 11:13:23 -0500
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Wed, 14 Feb 2018 10:12:13 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20180214161213.7894-1-mdroth@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [qemu-web PATCH v2] Add a blog post documenting
 Spectre/Meltdown options for QEMU 2.11.1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Suraj Jitindar Singh <sjitindarsingh@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Bruce Rogers <brogers@suse.com>, =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>, David Hildenbrand <david@redhat.com>

This blog entry is intended as a follow-up to the original entry in
January regarding Spectre/Meltdown and the proposed changes to address
them in the upcoming 2.11.1 release.

This entry is meant to accompany the 2.11.1 release (planned for
2018-02-14) and document how to make use of the new options for
various architectures.

Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Cc: David Gibson <david@gibson.dropbear.id.au>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>
Cc: Bruce Rogers <brogers@suse.com>
Cc: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Cc: David Hildenbrand <david@redhat.com>
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
v2:
 * s/by itself that/by itself for that/ (Bruce)
 * make example formats more consistent (Bruce)
 * clarify wording WRT to host-side security (Daniel, Paolo)
 * general wording/formatting fix-ups (Thomas)
 * s/options/feature bits/ (Cornelia)
 * clarify s390x CPU feature defaults (Thomas/Cornelia/Christian/David)
 * clarify s390x migration compatibility statement (Cornelia)

Thank you for the review!

 .../2018-02-14-qemu-2-11-1-and-spectre-update.md   | 190 +++++++++++++++=
++++++
 1 file changed, 190 insertions(+)
 create mode 100644 _posts/2018-02-14-qemu-2-11-1-and-spectre-update.md

diff --git a/_posts/2018-02-14-qemu-2-11-1-and-spectre-update.md b/_posts=
/2018-02-14-qemu-2-11-1-and-spectre-update.md
new file mode 100644
index 0000000..9ddf74f
--- /dev/null
+++ b/_posts/2018-02-14-qemu-2-11-1-and-spectre-update.md
@@ -0,0 +1,190 @@
+---
+layout: post
+title:  "QEMU 2.11.1 and making use of Spectre/Meltdown mitigation for K=
VM guests"
+date: 2018-02-14 10:35:44 -0600
+author: Michael Roth
+categories: [meltdown, spectre, security, x86, ppc, s390, releases, 'qem=
u 2.11']
+---
+
+A [previous post](https://www.qemu.org/2018/01/04/spectre/) detailed how
+QEMU/KVM might be affected by Spectre/Meltdown attacks, and what the pla=
n
+was to mitigate them in QEMU 2.11.1 (and eventually QEMU 2.12).
+
+QEMU 2.11.1 is now available, and contains the aforementioned mitigation
+functionality for x86 guests, along with additional mitigation functiona=
lity
+for pseries and s390x guests (ARM guests do not currently require additi=
onal
+QEMU patches).  However, enabling this functionality requires additional
+configuration beyond just updating QEMU, which we want to address with t=
his
+post.
+
+Please note that QEMU/KVM has at least the same requirements as other
+unprivileged processes running on the host with regard to Spectre/Meltdo=
wn
+mitigation. What is being addressed here is enabling a guest operating s=
ystem
+to enable the same (or similar) mitigations to protect itself from
+unprivileged guest processes running under the guest operating system. T=
hus,
+the patches/requirements listed here are specific to that goal and shoul=
d not
+be regarded as the full set of requirements to enable mitigations on the=
 host
+side (though in some cases there is some overlap between the two with re=
gard
+to required patches/etc).
+
+Also please note that this is a best-effort from the QEMU/KVM community,=
 and
+these mitigations rely on a mix of additional kernel/firmware/microcode
+updates that are in some cases not yet available publicly, or may not ye=
t be
+implemented in some distros, so users are highly encouraged to consult w=
ith
+their respective vendors/distros to confirm whether all the required
+components are in place. We do our best to highlight the requirements he=
re,
+but this may not be an exhaustive list.
+
+
+## Enabling mitigation features for x86 KVM guests
+
+For x86 guests there are 2 additional CPU flags associated with
+Spectre/Meltdown mitigation: **spec-ctrl**, and **ibpb**:
+
+* spec-ctrl: exposes Indirect Branch Restricted Speculation (IBRS)
+* ibpb: exposes Indirect Branch Prediction Barriers
+
+These flags expose additional functionality made available through new
+microcode updates for certain Intel/AMD processors that can be used to
+mitigate various attack vectors related to Spectre. (Meltdown mitigation
+via KPTI does not require additional CPU functionality or microcode, and
+does not require an updated QEMU, only the related guest/host kernel
+patches).
+
+Utilizing this functionality requires guest/host kernel updates, as well
+as microcode updates for Intel and recent AMD processors. The status of
+these kernel patches upstream is still in flux, but most supported
+distros have some form of the patches that is sufficient to make use
+of the functionality. The current status/availability of microcode updat=
es
+depends on your CPU architecture/model. Please check with your
+vendor/distro to confirm these prerequisites are available/installed.
+
+Generally, for Intel CPUs with updated microcode, **spec-ctrl** will
+enable both IBRS and IBPB functionality. For AMD EPYC processors,
+**ibpb** can be used to enable IBPB specifically, and is thought to
+be sufficient by itself for that particular architecture.
+
+These flags can be set in a similar manner as other CPU flags, i.e.:
+
+    qemu-system-x86_64 -cpu qemu64,+spec-ctrl,... ...
+    qemu-system-x86_64 -cpu IvyBridge,+spec-ctrl,... ...
+    qemu-system-x86_64 -cpu EPYC,+ibpb,... ...
+    etc...
+
+Additionally, for management stacks that lack support for setting
+specific CPU flags, a set of new CPU types have been added which
+enable the appropriate CPU flags automatically:
+
+    qemu-system-x86_64 -cpu Nehalem-IBRS ...
+    qemu-system-x86_64 -cpu Westmere-IBRS ...
+    qemu-system-x86_64 -cpu SandyBridge-IBRS ...
+    qemu-system-x86_64 -cpu IvyBridge-IBRS ...
+    qemu-system-x86_64 -cpu Haswell-IBRS ...
+    qemu-system-x86_64 -cpu Haswell-noTSX-IBRS ...
+    qemu-system-x86_64 -cpu Broadwell-IBRS ...
+    qemu-system-x86_64 -cpu Broadwell-noTSX-IBRS ...
+    qemu-system-x86_64 -cpu Skylake-Client-IBRS ...
+    qemu-system-x86_64 -cpu Skylake-Server-IBRS ...
+    qemu-system-x86_64 -cpu EPYC-IBPB ...
+
+With these settings enabled, guests may still require additional
+configuration to enable IBRS/IBPB, which may vary somewhat from one
+distro to another. For RHEL guests, the following resource may be
+useful:
+
+* https://access.redhat.com/articles/3311301
+
+With regard to migration compatibility, **spec-ctrl**/**ibrs** (or the
+corresponding CPU type) should be set the same on both source/target to
+maintain compatibility. Thus, guests will need to be rebooted to make
+use of the new features.
+
+
+## Enabling mitigation features for pseries KVM guests
+
+For pseries guests there are 3 tri-state -machine options/capabilities
+relating to Spectre/Meltdown mitigation: **cap-cfpc**, **cap-sbbc**,
+**cap-ibs**, which each correspond to a set of host machine capabilities
+advertised by the KVM kernel module in new/patched host kernels that can
+be used to mitigate various aspects of Spectre/Meltdown:
+
+* cap-cfpc: Cache Flush on Privilege Change
+* cap-sbbc: Speculation Barrier Bounds Checking
+* cap-ibs: Indirect Branch Serialisation
+
+Each option can be set to one of "broken", "workaround", or "fixed", whi=
ch
+correspond, respectively, to instructing the guest whether the host is
+vulnerable, has OS-level workarounds available, or has hardware/firmware
+that does not require OS-level workarounds. Based on these options, QEMU
+will perform checks to validate whether the specified settings are avail=
able
+on the current host and pass these settings on to the guest kernel. At a
+minimum, any setting other than "broken" will require a host kernel that=
 has
+some form of the following patches:
+
+    commit 3214d01f139b7544e870fc0b7fcce8da13c1cb51
+    KVM: PPC: Book3S: Provide information about hardware/firmware CVE wo=
rkarounds
+ =20
+    commit 191eccb1580939fb0d47deb405b82a85b0379070
+    powerpc/pseries: Add H_GET_CPU_CHARACTERISTICS flags & wrapper
+
+and whether a host will support "workaround" and "fixed" settings for ea=
ch
+option will depend on the hardware/firmware level of the host system.
+
+In turn, to make use of "workaround" or "fixed" settings for each option=
,
+the guest kernel will require at least the following set of patches:
+
+* https://lists.ozlabs.org/pipermail/linuxppc-dev/2018-January/167455.ht=
ml
+
+These are available upstream and have been backported to a number of sta=
ble
+kernels. Please check with your vendor/distro to confirm the required
+hardware/firmware and guest kernel patches are available/installed.
+
+All three options, **cap-cfpc**, **cap-sbbc**, and **cap-ibs** default
+to "broken" to maintain compatibility with previous versions of QEMU
+and unpatched host kernels. To enable them you must start QEMU with the
+desired mitigation strategy specified explicitly. For example:
+
+    qemu-system-ppc64 ... \
+      -machine pseries-2.11,cap-cfpc=3Dworkaround,cap-sbbc=3Dworkaround,=
cap-ibs=3Dfixed
+
+With regard to migration compatibility, setting any of these features to=
 a
+value other than "broken" will require an identical setting for that opt=
ion on
+the source/destination guest. To enable these settings your guests will =
need to
+be rebooted at some point.
+
+
+## Enabling mitigation features for s390x KVM guests
+
+For s390x guests there are 2 CPU feature bits relating to Spectre/Meltdo=
wn:
+
+* bpb: Branch prediction blocking
+* ppa15: PPA15 is installed
+
+**bpb** requires a host kernel patched with:
+
+    commit 35b3fde6203b932b2b1a5b53b3d8808abc9c4f60
+    KVM: s390: wire up bpb feature
+
+and both **bpb** and **ppa15** require a firmware with the appropriate s=
upport
+level as well as guest kernel patches to enable the functionality within
+guests. Please check with your distro/vendor to confirm.
+
+Both **bpb** and **ppa15** are enabled by default with newer/patched hos=
t
+kernels, and can also be set manually. For example:
+
+    qemu-system-s390x -M s390-ccw-virtio-2.11 ... \
+      -cpu zEC12,bpb=3Don,ppa15=3Don=20
+
+Both **bpb** and **ppa15** are enabled by default when using "-cpu host"
+and when the host kernels supports these facilities. For other CPU
+models, the flags have to be set manually. For example:
+
+    qemu-system-s390x -M s390-ccw-virtio-2.11 ... \
+      -cpu zEC12,bpb=3Don,ppa15=3Don
+
+With regard to migration, enabling **bpb** or **ppa15** feature flags re=
quires
+that the source/target also those flags enabled. Since this is enabled b=
y
+default for '-cpu host' (when available on the host), you must ensure th=
at
+**bpb**=3Doff,**ppa15**=3Doff is used if you wish to maintain migration
+compatibility with existing guests when using '-cpu host', or take steps=
 to
+reboot guests with **bpb**/**ppa15** enabled prior to migration.
--=20
2.11.0
