Received: from eggs.gnu.org ([2001:4830:134:3::10]:41812)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ew51t-0003Gd-4u
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 07:57:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ew51s-0004k1-EM
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 07:57:13 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40904 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ew51s-0004js-AC
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 07:57:12 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CE2E08182D16
	for <qemu-devel@nongnu.org>; Wed, 14 Mar 2018 11:57:11 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Wed, 14 Mar 2018 11:56:02 +0000
Message-Id: <20180314115618.28831-14-dgilbert@redhat.com>
In-Reply-To: <20180314115618.28831-1-dgilbert@redhat.com>
References: <20180314115618.28831-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v6 13/29] migration/ram:
 ramblock_recv_bitmap_test_byte_offset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, mst@redhat.com, maxime.coquelin@redhat.com, marcandre.lureau@redhat.com, peterx@redhat.com, quintela@redhat.com
Cc: aarcange@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Utility for testing the map when you already know the offset
in the RAMBlock.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 migration/ram.c | 5 +++++
 migration/ram.h | 1 +
 2 files changed, 6 insertions(+)

diff --git a/migration/ram.c b/migration/ram.c
index 7266351fd0..6ce7770b8c 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -169,6 +169,11 @@ int ramblock_recv_bitmap_test(RAMBlock *rb, void *ho=
st_addr)
                     rb->receivedmap);
 }
=20
+bool ramblock_recv_bitmap_test_byte_offset(RAMBlock *rb, uint64_t byte_o=
ffset)
+{
+    return test_bit(byte_offset >> TARGET_PAGE_BITS, rb->receivedmap);
+}
+
 void ramblock_recv_bitmap_set(RAMBlock *rb, void *host_addr)
 {
     set_bit_atomic(ramblock_recv_bitmap_offset(host_addr, rb), rb->recei=
vedmap);
diff --git a/migration/ram.h b/migration/ram.h
index 53f0021c51..5030be110a 100644
--- a/migration/ram.h
+++ b/migration/ram.h
@@ -60,6 +60,7 @@ int ram_postcopy_incoming_init(MigrationIncomingState *=
mis);
 void ram_handle_compressed(void *host, uint8_t ch, uint64_t size);
=20
 int ramblock_recv_bitmap_test(RAMBlock *rb, void *host_addr);
+bool ramblock_recv_bitmap_test_byte_offset(RAMBlock *rb, uint64_t byte_o=
ffset);
 void ramblock_recv_bitmap_set(RAMBlock *rb, void *host_addr);
 void ramblock_recv_bitmap_set_range(RAMBlock *rb, void *host_addr, size_=
t nr);
=20
--=20
2.14.3
