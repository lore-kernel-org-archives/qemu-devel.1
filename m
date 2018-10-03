Received: from eggs.gnu.org ([2001:4830:134:3::10]:52497)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1g7fb1-00056R-5k
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 07:45:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1g7fb0-00082n-Ev
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 07:45:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41218)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1g7fb0-00082O-6n
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 07:45:38 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed,  3 Oct 2018 15:44:54 +0400
Message-Id: <20181003114454.5662-4-marcandre.lureau@redhat.com>
In-Reply-To: <20181003114454.5662-1-marcandre.lureau@redhat.com>
References: <20181003114454.5662-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 3/3] memory-mapping: skip non-volatile memory
 regions in GuestPhysBlockList
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Juan Quintela <quintela@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, lersek@redhat.com

GuestPhysBlockList is currently used to produce dumps. Given the size
and the typical usage of NVDIMM for storage, they are not a good idea
to have in the dumps. We may want to have an extra dump option to
include them. For now, skip non-volatile regions.

The TCG memory clear function is going to use the GuestPhysBlockList
as well, and will thus skip NVDIMM for similar reasons.

Cc: lersek@redhat.com
Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 memory_mapping.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/memory_mapping.c b/memory_mapping.c
index 775466f3a8..724dd0b417 100644
--- a/memory_mapping.c
+++ b/memory_mapping.c
@@ -206,7 +206,8 @@ static void guest_phys_blocks_region_add(MemoryListen=
er *listener,
=20
     /* we only care about RAM */
     if (!memory_region_is_ram(section->mr) ||
-        memory_region_is_ram_device(section->mr)) {
+        memory_region_is_ram_device(section->mr) ||
+        memory_region_is_nonvolatile(section->mr)) {
         return;
     }
=20
--=20
2.19.0.271.gfe8321ec05
