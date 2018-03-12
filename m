Received: from eggs.gnu.org ([2001:4830:134:3::10]:53290)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1evR9L-000093-UG
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 13:22:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1evR9I-0007ud-Po
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 13:22:15 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57636 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1evR9I-0007uP-LJ
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 13:22:12 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 47D34401DE6B
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 17:22:12 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Mon, 12 Mar 2018 17:21:22 +0000
Message-Id: <20180312172124.56461-28-dgilbert@redhat.com>
In-Reply-To: <20180312172124.56461-1-dgilbert@redhat.com>
References: <20180312172124.56461-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v5 27/29] postcopy: Allow shared memory
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

Now that we have the mechanisms in here, allow shared memory in a
postcopy.

Note that QEMU can't tell who all the users of shared regions are
and thus can't tell whether all the users of the shared regions
have appropriate support for postcopy.  Those devices that explicitly
support shared memory (e.g. vhost-user) must check, but it doesn't
stop weirder configurations causing problems.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 migration/postcopy-ram.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 1379923cfc..964eb1c555 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -215,12 +215,6 @@ static int test_ramblock_postcopiable(const char *bl=
ock_name, void *host_addr,
     RAMBlock *rb =3D qemu_ram_block_by_name(block_name);
     size_t pagesize =3D qemu_ram_pagesize(rb);
=20
-    if (qemu_ram_is_shared(rb)) {
-        error_report("Postcopy on shared RAM (%s) is not yet supported",
-                     block_name);
-        return 1;
-    }
-
     if (length % pagesize) {
         error_report("Postcopy requires RAM blocks to be a page size mul=
tiple,"
                      " block %s is 0x" RAM_ADDR_FMT " bytes with a "
--=20
2.14.3
