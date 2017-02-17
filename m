Received: from eggs.gnu.org ([2001:4830:134:3::10]:44078)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <SRS0=y3pv=Z6=redhat.com=mst@kernel.org>)
	id 1ceobd-0003sw-EX
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 14:54:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <SRS0=y3pv=Z6=redhat.com=mst@kernel.org>)
	id 1ceobZ-0005L4-1X
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 14:54:13 -0500
Received: from mail.kernel.org ([198.145.29.136]:34200)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <SRS0=y3pv=Z6=redhat.com=mst@kernel.org>)
	id 1ceobY-0005K1-Np
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 14:54:08 -0500
Date: Fri, 17 Feb 2017 21:54:03 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1487361200-29966-4-git-send-email-mst@redhat.com>
References: <1487361200-29966-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1487361200-29966-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 03/23] docs: add document to explain the usage
 of vNVDIMM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Haozhong Zhang <haozhong.zhang@intel.com>, Xiao Guangrong <guangrong.xiao@linux.intel.com>, Stefan Hajnoczi <stefanha@redhat.com>

From: Haozhong Zhang <haozhong.zhang@intel.com>

Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
Reviewed-by: Xiao Guangrong <guangrong.xiao@linux.intel.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 docs/nvdimm.txt | 124 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 124 insertions(+)
 create mode 100644 docs/nvdimm.txt

diff --git a/docs/nvdimm.txt b/docs/nvdimm.txt
new file mode 100644
index 0000000..2d9f8c0
--- /dev/null
+++ b/docs/nvdimm.txt
@@ -0,0 +1,124 @@
+QEMU Virtual NVDIMM
+===================
+
+This document explains the usage of virtual NVDIMM (vNVDIMM) feature
+which is available since QEMU v2.6.0.
+
+The current QEMU only implements the persistent memory mode of vNVDIMM
+device and not the block window mode.
+
+Basic Usage
+-----------
+
+The storage of a vNVDIMM device in QEMU is provided by the memory
+backend (i.e. memory-backend-file and memory-backend-ram). A simple
+way to create a vNVDIMM device at startup time is done via the
+following command line options:
+
+ -machine pc,nvdimm
+ -m $RAM_SIZE,slots=$N,maxmem=$MAX_SIZE
+ -object memory-backend-file,id=mem1,share=on,mem-path=$PATH,size=$NVDIMM_SIZE
+ -device nvdimm,id=nvdimm1,memdev=mem1
+
+Where,
+
+ - the "nvdimm" machine option enables vNVDIMM feature.
+
+ - "slots=$N" should be equal to or larger than the total amount of
+   normal RAM devices and vNVDIMM devices, e.g. $N should be >= 2 here.
+
+ - "maxmem=$MAX_SIZE" should be equal to or larger than the total size
+   of normal RAM devices and vNVDIMM devices, e.g. $MAX_SIZE should be
+   >= $RAM_SIZE + $NVDIMM_SIZE here.
+
+ - "object memory-backend-file,id=mem1,share=on,mem-path=$PATH,size=$NVDIMM_SIZE"
+   creates a backend storage of size $NVDIMM_SIZE on a file $PATH. All
+   accesses to the virtual NVDIMM device go to the file $PATH.
+
+   "share=on/off" controls the visibility of guest writes. If
+   "share=on", then guest writes will be applied to the backend
+   file. If another guest uses the same backend file with option
+   "share=on", then above writes will be visible to it as well. If
+   "share=off", then guest writes won't be applied to the backend
+   file and thus will be invisible to other guests.
+
+ - "device nvdimm,id=nvdimm1,memdev=mem1" creates a virtual NVDIMM
+   device whose storage is provided by above memory backend device.
+
+Multiple vNVDIMM devices can be created if multiple pairs of "-object"
+and "-device" are provided.
+
+For above command line options, if the guest OS has the proper NVDIMM
+driver, it should be able to detect a NVDIMM device which is in the
+persistent memory mode and whose size is $NVDIMM_SIZE.
+
+Note:
+
+1. Prior to QEMU v2.8.0, if memory-backend-file is used and the actual
+   backend file size is not equal to the size given by "size" option,
+   QEMU will truncate the backend file by ftruncate(2), which will
+   corrupt the existing data in the backend file, especially for the
+   shrink case.
+
+   QEMU v2.8.0 and later check the backend file size and the "size"
+   option. If they do not match, QEMU will report errors and abort in
+   order to avoid the data corruption.
+
+2. QEMU v2.6.0 only puts a basic alignment requirement on the "size"
+   option of memory-backend-file, e.g. 4KB alignment on x86.  However,
+   QEMU v.2.7.0 puts an additional alignment requirement, which may
+   require a larger value than the basic one, e.g. 2MB on x86. This
+   change breaks the usage of memory-backend-file that only satisfies
+   the basic alignment.
+
+   QEMU v2.8.0 and later remove the additional alignment on non-s390x
+   architectures, so the broken memory-backend-file can work again.
+
+Label
+-----
+
+QEMU v2.7.0 and later implement the label support for vNVDIMM devices.
+To enable label on vNVDIMM devices, users can simply add
+"label-size=$SZ" option to "-device nvdimm", e.g.
+
+ -device nvdimm,id=nvdimm1,memdev=mem1,label-size=128K
+
+Note:
+
+1. The minimal label size is 128KB.
+
+2. QEMU v2.7.0 and later store labels at the end of backend storage.
+   If a memory backend file, which was previously used as the backend
+   of a vNVDIMM device without labels, is now used for a vNVDIMM
+   device with label, the data in the label area at the end of file
+   will be inaccessible to the guest. If any useful data (e.g. the
+   meta-data of the file system) was stored there, the latter usage
+   may result guest data corruption (e.g. breakage of guest file
+   system).
+
+Hotplug
+-------
+
+QEMU v2.8.0 and later implement the hotplug support for vNVDIMM
+devices. Similarly to the RAM hotplug, the vNVDIMM hotplug is
+accomplished by two monitor commands "object_add" and "device_add".
+
+For example, the following commands add another 4GB vNVDIMM device to
+the guest:
+
+ (qemu) object_add memory-backend-file,id=mem2,share=on,mem-path=new_nvdimm.img,size=4G
+ (qemu) device_add nvdimm,id=nvdimm2,memdev=mem2
+
+Note:
+
+1. Each hotplugged vNVDIMM device consumes one memory slot. Users
+   should always ensure the memory option "-m ...,slots=N" specifies
+   enough number of slots, i.e.
+     N >= number of RAM devices +
+          number of statically plugged vNVDIMM devices +
+          number of hotplugged vNVDIMM devices
+
+2. The similar is required for the memory option "-m ...,maxmem=M", i.e.
+     M >= size of RAM devices +
+          size of statically plugged vNVDIMM devices +
+          size of hotplugged vNVDIMM devices
-- 
MST
