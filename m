Received: from eggs.gnu.org ([2001:4830:134:3::10]:34113)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gZ1dN-0007sy-GZ
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 17:45:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gZ1dM-0006d7-LO
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 17:45:09 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Mon, 17 Dec 2018 23:43:47 +0100
Message-Id: <20181217224348.14922-31-mreitz@redhat.com>
In-Reply-To: <20181217224348.14922-1-mreitz@redhat.com>
References: <20181217224348.14922-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v12 30/31] block: BDS options may lack the
 "driver" option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>, Eric Blake <eblake@redhat.com>

When BDSs are created by qemu itself (e.g. as filters in block jobs),
they may not have a "driver" option in their options QDict.  When
generating a json:{} filename, however, it must always be present.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
---
 block.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/block.c b/block.c
index 44bebfc80c..b75276183b 100644
--- a/block.c
+++ b/block.c
@@ -5400,6 +5400,12 @@ static bool append_strong_runtime_options(QDict *d=
, BlockDriverState *bs)
         }
     }
=20
+    if (!qdict_haskey(d, "driver")) {
+        /* Drivers created with bdrv_new_open_driver() may not have a
+         * @driver option.  Add it here. */
+        qdict_put_str(d, "driver", bs->drv->format_name);
+    }
+
     return found_any;
 }
=20
--=20
2.19.2
