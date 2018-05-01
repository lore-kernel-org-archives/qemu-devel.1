Received: from eggs.gnu.org ([2001:4830:134:3::10]:48487)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1fDY6W-0004bF-PS
	for qemu-devel@nongnu.org; Tue, 01 May 2018 12:26:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1fDY6R-0008D4-TN
	for qemu-devel@nongnu.org; Tue, 01 May 2018 12:26:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35076)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1fDY6R-0008Cl-LU
	for qemu-devel@nongnu.org; Tue, 01 May 2018 12:26:07 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 676B6C057F4E
	for <qemu-devel@nongnu.org>; Tue,  1 May 2018 16:26:06 +0000 (UTC)
From: Alex Williamson <alex.williamson@redhat.com>
Date: Tue, 01 May 2018 10:25:59 -0600
Message-ID: <20180501162559.28517.6261.stgit@gimli.home>
In-Reply-To: <20180501161509.28517.344.stgit@gimli.home>
References: <20180501161509.28517.344.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH 2/3] scripts/update-linux-headers: Update
 handling of __aligned_u64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com

We'll currently replace any 'u64' with a 'uint64_t' including when
it's embedded in an '__aligned_u64', creating a '__aligned_uint64_t'
which doesn't exist.  Add another sed entry to find these and convert
them back to their original form.

Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 scripts/update-linux-headers.sh |    1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/update-linux-headers.sh b/scripts/update-linux-headers.sh
index a017b53d8765..dd74cc8d5223 100755
--- a/scripts/update-linux-headers.sh
+++ b/scripts/update-linux-headers.sh
@@ -56,6 +56,7 @@ cp_portable() {
         -e 's/__s\([0-9][0-9]*\)/int\1_t/g' \
         -e 's/__le\([0-9][0-9]*\)/uint\1_t/g' \
         -e 's/__be\([0-9][0-9]*\)/uint\1_t/g' \
+        -e 's/__aligned_uint\([0-9][0-9]*\)_t/__aligned_u\1/g' \
         -e 's/"\(input-event-codes\.h\)"/"standard-headers\/linux\/\1"/' \
         -e 's/<linux\/\([^>]*\)>/"standard-headers\/linux\/\1"/' \
         -e 's/__bitwise//' \
