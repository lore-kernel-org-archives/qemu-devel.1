Received: from eggs.gnu.org ([2001:4830:134:3::10]:42103)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ew52X-0003pM-Fh
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 07:57:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ew52U-0004zD-Sv
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 07:57:53 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40926 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ew52U-0004z2-O8
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 07:57:50 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 46FA08182D16
	for <qemu-devel@nongnu.org>; Wed, 14 Mar 2018 11:57:50 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Wed, 14 Mar 2018 11:56:16 +0000
Message-Id: <20180314115618.28831-28-dgilbert@redhat.com>
In-Reply-To: <20180314115618.28831-1-dgilbert@redhat.com>
References: <20180314115618.28831-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v6 27/29] postcopy: Allow shared memory
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
index 9cdee0fed7..188c2ca5c1 100644
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
