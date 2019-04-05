Received: from eggs.gnu.org ([209.51.188.92]:48871)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hCY0r-0003Xl-4b
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 19:12:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hCY0q-0003dB-1l
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 19:12:45 -0400
Received: from mail-qt1-f170.google.com ([209.85.160.170]:45207)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hCY0p-0003bD-NW
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 19:12:43 -0400
Received: by mail-qt1-f170.google.com with SMTP id v20so9301315qtv.12
	for <qemu-devel@nongnu.org>; Fri, 05 Apr 2019 16:12:43 -0700 (PDT)
Date: Fri, 5 Apr 2019 19:12:40 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <155364147432.16467.15898335025013220939.stgit@gimli.home>
References: <20190405231225.30165-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190405231225.30165-1-mst@redhat.com>
Subject: [Qemu-devel] [PULL 2/5] intel_iommu: Correct caching-mode error
 message
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Alex Williamson <alex.williamson@redhat.com>, Peter Xu <peterx@redhat.com>, Laurent Vivier <laurent@vivier.eu>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Alex@redhat.com, Williamson@redhat.com, &lt@redhat.com, Eric Auger <eric.auger@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>

From: Alex Williamson <alex.williamson@redhat.com>

If we try to use the intel-iommu device with vfio-pci devices without
caching mode enabled, we're told:

  qemu-system-x86_64: We need to set caching-mode=1 for intel-iommu to enable
  device assignment with IOMMU protection.

But to enable caching mode, the option is actually "caching-mode=on".

Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
Message-Id: <155364147432.16467.15898335025013220939.stgit@gimli.home>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Alex Williamson &lt;<a href="mailto:alex.williamson@redhat.com" target="_blank" rel="noreferrer">alex.williamson@redhat.com</a>&gt;<br>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/intel_iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 055a1e865d..146cd16dd2 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -2919,7 +2919,7 @@ static void vtd_iommu_notify_flag_changed(IOMMUMemoryRegion *iommu,
     IntelIOMMUState *s = vtd_as->iommu_state;
 
     if (!s->caching_mode && new & IOMMU_NOTIFIER_MAP) {
-        error_report("We need to set caching-mode=1 for intel-iommu to enable "
+        error_report("We need to set caching-mode=on for intel-iommu to enable "
                      "device assignment with IOMMU protection.");
         exit(1);
     }
-- 
MST
