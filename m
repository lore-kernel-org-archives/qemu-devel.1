Received: from eggs.gnu.org ([209.51.188.92]:45089)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1gkFbE-0001Rp-E8
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 16:53:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1gkFbD-0000ZB-Ie
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 16:53:20 -0500
Received: from mail-eopbgr740047.outbound.protection.outlook.com
	([40.107.74.47]:8750
	helo=NAM01-BN3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1gkFbD-0000WF-Do
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 16:53:19 -0500
From: "Singh, Brijesh" <brijesh.singh@amd.com>
Date: Thu, 17 Jan 2019 21:53:16 +0000
Message-ID: <20190117215300.29694-2-brijesh.singh@amd.com>
References: <20190117215300.29694-1-brijesh.singh@amd.com>
In-Reply-To: <20190117215300.29694-1-brijesh.singh@amd.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH 1/2] memory: Fix the memory region type
 assignment order
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "Singh,
	Brijesh" <brijesh.singh@amd.com>, Paolo Bonzini <pbonzini@redhat.com>

Currently, a callback registered through the RAMBlock notifier
is not able to get the memory region type (i.e callback is not
able to use memory_region_is_ram_device function). This is
because mr->ram assignment happens _after_ the memory is allocated
whereas the callback is executed during allocation.

Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=3D1667249
Sugegsted-by: Alex Williamson <alex.williamson@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 memory.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/memory.c b/memory.c
index 61d66e4441..9ec15349dd 100644
--- a/memory.c
+++ b/memory.c
@@ -1652,10 +1652,17 @@ void memory_region_init_ram_device_ptr(MemoryRegion=
 *mr,
                                        uint64_t size,
                                        void *ptr)
 {
-    memory_region_init_ram_ptr(mr, owner, name, size, ptr);
+    memory_region_init(mr, owner, name, size);
+    mr->ram =3D true;
+    mr->terminates =3D true;
     mr->ram_device =3D true;
     mr->ops =3D &ram_device_mem_ops;
     mr->opaque =3D mr;
+    mr->destructor =3D memory_region_destructor_ram;
+    mr->dirty_log_mask =3D tcg_enabled() ? (1 << DIRTY_MEMORY_CODE) : 0;
+    /* qemu_ram_alloc_from_ptr cannot fail with ptr !=3D NULL.  */
+    assert(ptr !=3D NULL);
+    mr->ram_block =3D qemu_ram_alloc_from_ptr(size, ptr, mr, &error_fatal)=
;
 }
=20
 void memory_region_init_alias(MemoryRegion *mr,
--=20
2.17.1
