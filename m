Received: from eggs.gnu.org ([2001:4830:134:3::10]:44342)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1e41Cw-00076P-G8
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 04:57:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1e41Ct-0003vf-Ty
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 04:57:10 -0400
Received: from mga01.intel.com ([192.55.52.88]:51760)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1e41Ct-0003tI-LR
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 04:57:07 -0400
From: Yang Zhong <yang.zhong@intel.com>
Date: Mon, 16 Oct 2017 16:56:23 +0800
Message-Id: <1508144183-30844-3-git-send-email-yang.zhong@intel.com>
In-Reply-To: <1508144183-30844-1-git-send-email-yang.zhong@intel.com>
References: <1508144183-30844-1-git-send-email-yang.zhong@intel.com>
Subject: [Qemu-devel] [PATCH 2/2] nvdimm: Add "nopin" for related documents
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: xiaoguangrong.eric@gmail.com, ehabkost@redhat.com, alex.williamson@redhat.com, pbonzini@redhat.com, anthony.xu@intel.com, yang.zhong@intel.com

Added the "nopin" related changes in nvdimm.txt and
qemu-options.hx.

Signed-off-by: Yang Zhong <yang.zhong@intel.com>
---
 docs/nvdimm.txt | 10 ++++++++--
 qemu-options.hx |  6 +++++-
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/docs/nvdimm.txt b/docs/nvdimm.txt
index 2d9f8c0..41ac1c2 100644
--- a/docs/nvdimm.txt
+++ b/docs/nvdimm.txt
@@ -17,7 +17,7 @@ following command line options:
 
  -machine pc,nvdimm
  -m $RAM_SIZE,slots=$N,maxmem=$MAX_SIZE
- -object memory-backend-file,id=mem1,share=on,mem-path=$PATH,size=$NVDIMM_SIZE
+ -object memory-backend-file,id=mem1,share=on,nopin=on,mem-path=$PATH,size=$NVDIMM_SIZE
  -device nvdimm,id=nvdimm1,memdev=mem1
 
 Where,
@@ -31,7 +31,7 @@ Where,
    of normal RAM devices and vNVDIMM devices, e.g. $MAX_SIZE should be
    >= $RAM_SIZE + $NVDIMM_SIZE here.
 
- - "object memory-backend-file,id=mem1,share=on,mem-path=$PATH,size=$NVDIMM_SIZE"
+ - "object memory-backend-file,id=mem1,share=on,nopin=on,mem-path=$PATH,size=$NVDIMM_SIZE"
    creates a backend storage of size $NVDIMM_SIZE on a file $PATH. All
    accesses to the virtual NVDIMM device go to the file $PATH.
 
@@ -42,6 +42,12 @@ Where,
    "share=off", then guest writes won't be applied to the backend
    file and thus will be invisible to other guests.
 
+   "nopin=on/off" controls the memory pining of memory backend file
+    during the VFIO device hotplug. If "nopin=on", then VFIO device
+    hotplug can skip the NVDIMM memory pining because qemu does not
+    need pining NVDIMM memory for devices. If "nopin=off", the VFIO
+    device hotplug need NVDIMM memory pining.
+
  - "device nvdimm,id=nvdimm1,memdev=mem1" creates a virtual NVDIMM
    device whose storage is provided by above memory backend device.
 
diff --git a/qemu-options.hx b/qemu-options.hx
index 981742d..d21ce2e 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4173,7 +4173,7 @@ property must be set.  These objects are placed in the
 
 @table @option
 
-@item -object memory-backend-file,id=@var{id},size=@var{size},mem-path=@var{dir},share=@var{on|off},discard-data=@var{on|off}
+@item -object memory-backend-file,id=@var{id},size=@var{size},mem-path=@var{dir},share=@var{on|off},discard-data=@var{on|off},nopin=@var{on|off}
 
 Creates a memory file backend object, which can be used to back
 the guest RAM with huge pages. The @option{id} parameter is a
@@ -4191,6 +4191,10 @@ to avoid unnecessarily flushing data to the backing file.  Note
 that @option{discard-data} is only an optimization, and QEMU
 might not discard file contents if it aborts unexpectedly or is
 terminated using SIGKILL.
+Setting the @option{nopin} boolean option to @var{on} indicates
+that if the memory-backend-file is nvdimm or else, the memory
+pining can be disable during VFIO device hotplug. The default
+nopin is still off, which is same with previous value.
 
 @item -object rng-random,id=@var{id},filename=@var{/dev/random}
 
-- 
1.9.1
