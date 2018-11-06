Received: from eggs.gnu.org ([2001:4830:134:3::10]:40126)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gK9DG-0002l5-KG
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 16:48:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gK93S-0001Ad-Le
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 16:38:36 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:53654)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gK93S-0000Fw-2f
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 16:38:34 -0500
Received: by mail-wm1-x343.google.com with SMTP id f10-v6so85575wme.3
	for <qemu-devel@nongnu.org>; Tue, 06 Nov 2018 13:38:16 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue,  6 Nov 2018 22:37:54 +0100
Message-Id: <1541540283-45699-9-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1541540283-45699-1-git-send-email-pbonzini@redhat.com>
References: <1541540283-45699-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 08/17] nvdimm: set non-volatile on the memory
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
