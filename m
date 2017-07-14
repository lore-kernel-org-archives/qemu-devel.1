Received: from eggs.gnu.org ([2001:4830:134:3::10]:53668)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dVwV8-0003rQ-5h
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 05:03:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dVwV7-0005yJ-9M
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 05:03:06 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37570)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1dVwV6-0005xZ-UY
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 05:03:05 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 14 Jul 2017 09:33:44 +0100
Message-Id: <1500021225-4118-3-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1500021225-4118-1-git-send-email-peter.maydell@linaro.org>
References: <1500021225-4118-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 2/3] configure: Use an explicit CONFIG_IVSHMEM
 rather than CONFIG_EVENTFD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, Kamil Rytarowski <n54@gmx.com>, Markus Armbruster <armbru@redhat.com>

From: Kamil Rytarowski <n54@gmx.com>

Rather than relying on everywhere that cares about whether the host
supports ivshmem using CONFIG_EVENTFD, make configure set an explicit
CONFIG_IVSHMEM.

Signed-off-by: Kamil Rytarowski <n54@gmx.com>
[PMM: split out from another patch, add commit message]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 configure               | 9 +++++++++
 tests/Makefile.include  | 4 ++--
 default-configs/pci.mak | 2 +-
 3 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/configure b/configure
index 5096cbc..dea46c5 100755
--- a/configure
+++ b/configure
@@ -4969,6 +4969,11 @@ qemu_moddir=$libdir$confsuffix
 qemu_datadir=$datadir$confsuffix
 qemu_localedir="$datadir/locale"
 
+# We can only support ivshmem if we have eventfd
+if [ "$eventfd" = "yes" ]; then
+  ivshmem=yes
+fi
+
 tools=""
 if test "$want_tools" = "yes" ; then
   tools="qemu-img\$(EXESUF) qemu-io\$(EXESUF) $tools"
@@ -5955,6 +5960,10 @@ if test "$have_static_assert" = "yes" ; then
   echo "CONFIG_STATIC_ASSERT=y" >> $config_host_mak
 fi
 
+if test "$ivshmem" = "yes" ; then
+  echo "CONFIG_IVSHMEM=y" >> $config_host_mak
+fi
+
 # Hold two types of flag:
 #   CONFIG_THREAD_SETNAME_BYTHREAD  - we've got a way of setting the name on
 #                                     a thread we have a handle to
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 42e17e2..6d6cb74 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -201,7 +201,7 @@ gcov-files-pci-y += hw/display/virtio-gpu-pci.c
 gcov-files-pci-$(CONFIG_VIRTIO_VGA) += hw/display/virtio-vga.c
 check-qtest-pci-y += tests/intel-hda-test$(EXESUF)
 gcov-files-pci-y += hw/audio/intel-hda.c hw/audio/hda-codec.c
-check-qtest-pci-$(CONFIG_EVENTFD) += tests/ivshmem-test$(EXESUF)
+check-qtest-pci-$(CONFIG_IVSHMEM) += tests/ivshmem-test$(EXESUF)
 gcov-files-pci-y += hw/misc/ivshmem.c
 check-qtest-pci-y += tests/megasas-test$(EXESUF)
 gcov-files-pci-y += hw/scsi/megasas.c
@@ -303,7 +303,7 @@ check-qtest-ppc64-y += tests/test-filter-mirror$(EXESUF)
 check-qtest-ppc64-y += tests/test-filter-redirector$(EXESUF)
 check-qtest-ppc64-y += tests/display-vga-test$(EXESUF)
 check-qtest-ppc64-y += tests/numa-test$(EXESUF)
-check-qtest-ppc64-$(CONFIG_EVENTFD) += tests/ivshmem-test$(EXESUF)
+check-qtest-ppc64-$(CONFIG_IVSHMEM) += tests/ivshmem-test$(EXESUF)
 
 check-qtest-sh4-y = tests/endianness-test$(EXESUF)
 
diff --git a/default-configs/pci.mak b/default-configs/pci.mak
index 2451eb2..acaa703 100644
--- a/default-configs/pci.mak
+++ b/default-configs/pci.mak
@@ -41,6 +41,6 @@ CONFIG_SDHCI=y
 CONFIG_EDU=y
 CONFIG_VGA=y
 CONFIG_VGA_PCI=y
-CONFIG_IVSHMEM_DEVICE=$(CONFIG_EVENTFD)
+CONFIG_IVSHMEM_DEVICE=$(CONFIG_IVSHMEM)
 CONFIG_ROCKER=y
 CONFIG_VHOST_USER_SCSI=$(CONFIG_LINUX)
-- 
2.7.4
