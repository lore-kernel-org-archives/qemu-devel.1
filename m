Received: from eggs.gnu.org ([209.51.188.92]:49771)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1h1Ebx-0000wR-Hl
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 13:16:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1h1Ebw-0001fn-C1
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 13:16:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48273)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1h1Ebv-0001em-W8
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 13:16:16 -0500
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Tue,  5 Mar 2019 18:15:44 +0000
Message-Id: <20190305181602.9051-4-dgilbert@redhat.com>
In-Reply-To: <20190305181602.9051-1-dgilbert@redhat.com>
References: <20190305181602.9051-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 03/21] migration/rdma: clang compilation fix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, quintela@redhat.com, peterx@redhat.com, marcel.apfelbaum@gmail.com, wei.w.wang@intel.com, yury-kotov@yandex-team.ru, chen.zhang@intel.com

From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>

Configuring QEMU with:
        ../configure --cc=3Dclang --enable-rdma

Leads to compilation error:

  CC      migration/rdma.o
  CC      migration/block.o
  qemu/migration/rdma.c:3615:58: error: taking address of packed member '=
rkey' of class or structure
      'RDMARegisterResult' may result in an unaligned pointer value [-Wer=
ror,-Waddress-of-packed-member]
                            (uintptr_t)host_addr, NULL, &reg_result->rkey=
,
                                                         ^~~~~~~~~~~~~~~~
Fix it by using a temp local variable.

Signed-off-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-Id: <20190304184923.24215-1-marcel.apfelbaum@gmail.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 migration/rdma.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index 9fa3b176eb..d5251cd820 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -3613,13 +3613,16 @@ static int qemu_rdma_registration_handle(QEMUFile=
 *f, void *opaque)
                 }
                 chunk_start =3D ram_chunk_start(block, chunk);
                 chunk_end =3D ram_chunk_end(block, chunk + reg->chunks);
+                /* avoid "-Waddress-of-packed-member" warning */
+                uint32_t tmp_rkey =3D 0;
                 if (qemu_rdma_register_and_get_keys(rdma, block,
-                            (uintptr_t)host_addr, NULL, &reg_result->rke=
y,
+                            (uintptr_t)host_addr, NULL, &tmp_rkey,
                             chunk, chunk_start, chunk_end)) {
                     error_report("cannot get rkey");
                     ret =3D -EINVAL;
                     goto out;
                 }
+                reg_result->rkey =3D tmp_rkey;
=20
                 reg_result->host_addr =3D (uintptr_t)block->local_host_a=
ddr;
=20
--=20
2.20.1
