Received: from eggs.gnu.org ([2001:4830:134:3::10]:52451)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1g7fau-00052f-LL
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 07:45:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1g7fas-0007yu-Oz
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 07:45:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36802)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1g7faq-0007xT-5E
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 07:45:30 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed,  3 Oct 2018 15:44:53 +0400
Message-Id: <20181003114454.5662-3-marcandre.lureau@redhat.com>
In-Reply-To: <20181003114454.5662-1-marcandre.lureau@redhat.com>
References: <20181003114454.5662-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 2/3] nvdimm: set non-volatile on the memory
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Juan Quintela <quintela@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

qemu-system-x86_64 -machine pc,nvdimm -m 2G,slots=3D4,maxmem=3D16G -enabl=
e-kvm -monitor stdio -object memory-backend-file,id=3Dmem1,share=3Don,mem=
-path=3D/tmp/foo,size=3D1G -device nvdimm,id=3Dnvdimm1,memdev=3Dmem1

HMP info mtree command reflects the flag with "nv-" prefix on memory type=
:

(qemu) info mtree
0000000100000000-000000013fffffff (prio 0, nv-i/o): alias nvdimm-memory @=
/objects/mem1 0000000000000000-000000003fffffff

(qemu) info mtree -f
0000000100000000-000000013fffffff (prio 0, nv-ram): /objects/mem1

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/mem/nvdimm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/mem/nvdimm.c b/hw/mem/nvdimm.c
index 1c6674c4ed..0b1eeb677b 100644
--- a/hw/mem/nvdimm.c
+++ b/hw/mem/nvdimm.c
@@ -115,6 +115,7 @@ static void nvdimm_prepare_memory_region(NVDIMMDevice=
 *nvdimm, Error **errp)
     nvdimm->nvdimm_mr =3D g_new(MemoryRegion, 1);
     memory_region_init_alias(nvdimm->nvdimm_mr, OBJECT(dimm),
                              "nvdimm-memory", mr, 0, pmem_size);
+    memory_region_set_nonvolatile(nvdimm->nvdimm_mr, true);
     nvdimm->nvdimm_mr->align =3D align;
 }
=20
--=20
2.19.0.271.gfe8321ec05
