Received: from eggs.gnu.org ([2001:4830:134:3::10]:48219)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gHa28-00082M-VK
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 15:50:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gHa26-0002Hy-37
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 15:50:36 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333]:51866)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gHa25-0002Ga-Od
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 15:50:33 -0400
Received: by mail-wm1-x333.google.com with SMTP id w7-v6so1953841wmc.1
	for <qemu-devel@nongnu.org>; Tue, 30 Oct 2018 12:50:31 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 30 Oct 2018 20:50:08 +0100
Message-Id: <1540929011-19894-8-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1540929011-19894-1-git-send-email-pbonzini@redhat.com>
References: <1540929011-19894-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 07/10] nvdimm: set non-volatile on the memory
 region
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

qemu-system-x86_64 -machine pc,nvdimm -m 2G,slots=4,maxmem=16G -enable-kvm -monitor stdio -object memory-backend-file,id=mem1,share=on,mem-path=/tmp/foo,size=1G -device nvdimm,id=nvdimm1,memdev=mem1

HMP info mtree command reflects the flag with "nv-" prefix on memory type:

(qemu) info mtree
0000000100000000-000000013fffffff (prio 0, nv-i/o): alias nvdimm-memory @/objects/mem1 0000000000000000-000000003fffffff

(qemu) info mtree -f
0000000100000000-000000013fffffff (prio 0, nv-ram): /objects/mem1

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20181003114454.5662-3-marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/mem/nvdimm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/mem/nvdimm.c b/hw/mem/nvdimm.c
index 49324f3..bf2adf5 100644
--- a/hw/mem/nvdimm.c
+++ b/hw/mem/nvdimm.c
@@ -116,6 +116,7 @@ static void nvdimm_prepare_memory_region(NVDIMMDevice *nvdimm, Error **errp)
     nvdimm->nvdimm_mr = g_new(MemoryRegion, 1);
     memory_region_init_alias(nvdimm->nvdimm_mr, OBJECT(dimm),
                              "nvdimm-memory", mr, 0, pmem_size);
+    memory_region_set_nonvolatile(nvdimm->nvdimm_mr, true);
     nvdimm->nvdimm_mr->align = align;
 }
 
-- 
1.8.3.1
