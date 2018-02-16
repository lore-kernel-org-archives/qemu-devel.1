Received: from eggs.gnu.org ([2001:4830:134:3::10]:52009)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1emft0-0001jj-Np
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 08:17:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1emfsz-0006Eq-O2
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 08:17:10 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34862 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1emfsz-0006EQ-J6
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 08:17:09 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4391140FB647
	for <qemu-devel@nongnu.org>; Fri, 16 Feb 2018 13:17:09 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Fri, 16 Feb 2018 13:16:23 +0000
Message-Id: <20180216131625.9639-28-dgilbert@redhat.com>
In-Reply-To: <20180216131625.9639-1-dgilbert@redhat.com>
References: <20180216131625.9639-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 27/29] postcopy: Allow shared memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, maxime.coquelin@redhat.com, marcandre.lureau@redhat.com, peterx@redhat.com, imammedo@redhat.com, mst@redhat.com
Cc: quintela@redhat.com, aarcange@redhat.com

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
index 14196d0654..b683e24d0e 100644
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
