Received: from eggs.gnu.org ([2001:4830:134:3::10]:60180)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1gSk4k-0005LX-RD
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 09:47:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1gSk4g-0003zi-JC
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 09:47:26 -0500
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Date: Fri, 30 Nov 2018 14:47:20 +0000
Message-ID: <20181130144705.77454-4-anton.nefedov@virtuozzo.com>
References: <20181130144705.77454-1-anton.nefedov@virtuozzo.com>
In-Reply-To: <20181130144705.77454-1-anton.nefedov@virtuozzo.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH v6 3/9] block: add empty account cookie type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "kwolf@redhat.com" <kwolf@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "famz@redhat.com" <famz@redhat.com>, "eblake@redhat.com" <eblake@redhat.com>, Denis Lunev <den@virtuozzo.com>, "berto@igalia.com" <berto@igalia.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>

This adds some protection from accounting uninitialized cookie.
That is, block_acct_failed/done without previous block_acct_start;
in that case, cookie probably holds values from previous operation.

(Note: it might also be uninitialized holding garbage value and there is
 still "< BLOCK_MAX_IOTYPE" assertion for that.
 So block_acct_failed/done without previous block_acct_start should be used
 with caution.)

Currently this is particularly useful in ide code where it's hard to
keep track whether the request started accounting or not. For example,
trim requests do the accounting separately.

Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
---
 include/block/accounting.h | 1 +
 block/accounting.c         | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/include/block/accounting.h b/include/block/accounting.h
index ba8b04d572..878b4c3581 100644
--- a/include/block/accounting.h
+++ b/include/block/accounting.h
@@ -33,6 +33,7 @@ typedef struct BlockAcctTimedStats BlockAcctTimedStats;
 typedef struct BlockAcctStats BlockAcctStats;
=20
 enum BlockAcctType {
+    BLOCK_ACCT_NONE =3D 0,
     BLOCK_ACCT_READ,
     BLOCK_ACCT_WRITE,
     BLOCK_ACCT_FLUSH,
diff --git a/block/accounting.c b/block/accounting.c
index 70a3d9a426..8d41c8a83a 100644
--- a/block/accounting.c
+++ b/block/accounting.c
@@ -195,6 +195,10 @@ static void block_account_one_io(BlockAcctStats *stats=
, BlockAcctCookie *cookie,
=20
     assert(cookie->type < BLOCK_MAX_IOTYPE);
=20
+    if (cookie->type =3D=3D BLOCK_ACCT_NONE) {
+        return;
+    }
+
     qemu_mutex_lock(&stats->lock);
=20
     if (failed) {
@@ -217,6 +221,8 @@ static void block_account_one_io(BlockAcctStats *stats,=
 BlockAcctCookie *cookie,
     }
=20
     qemu_mutex_unlock(&stats->lock);
+
+    cookie->type =3D BLOCK_ACCT_NONE;
 }
=20
 void block_acct_done(BlockAcctStats *stats, BlockAcctCookie *cookie)
--=20
2.17.1
