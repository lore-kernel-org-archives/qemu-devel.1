Received: from eggsout.gnu.org ([209.51.188.92]:56545 helo=eggs.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gfmVs-0003qY-4i
	for qemu-devel@nongnu.org; Sat, 05 Jan 2019 09:01:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gfmVn-0007iw-Qo
	for qemu-devel@nongnu.org; Sat, 05 Jan 2019 09:01:19 -0500
From: Eric Blake <eblake@redhat.com>
Date: Sat,  5 Jan 2019 08:00:57 -0600
Message-Id: <20190105140100.26913-6-eblake@redhat.com>
In-Reply-To: <20190105140100.26913-1-eblake@redhat.com>
References: <20190105140100.26913-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 5/8] nbd: Document timeline of various features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "Richard W . M . Jones" <rjones@redhat.com>, "open list:Network Block Dev..." <qemu-block@nongnu.org>

It can be useful to figure out which NBD protocol features are
exposed by a server, as well as what features a client will
take advantage of if available, for a given qemu release.  It's
not always precise to base features on version numbers (thanks
to downstream backports), but any documentation is better than
making users search through git logs themselves.

This patch originally stemmed from a request to document that
pristine 3.0 has a known bug where NBD_OPT_LIST_META_CONTEXT
with 0 queries forgot to advertise an available
"qemu:dirty-bitmap" context, but documenting bugs like this (or
the fact that 3.0 also botched NBD_CMD_CACHE) gets to be too
much details, especially since buggy releases will be less
likely connection targets over time.  Instead, I chose to just
remind users to check stable release branches.

Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
Message-Id: <20181215135324.152629-3-eblake@redhat.com>
Reviewed-by: Richard W.M. Jones <rjones@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 docs/interop/nbd.txt | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/docs/interop/nbd.txt b/docs/interop/nbd.txt
index 77b5f459111..fc64473e02b 100644
--- a/docs/interop/nbd.txt
+++ b/docs/interop/nbd.txt
@@ -15,7 +15,6 @@ Qemu supports the "base:allocation" metadata context as=
 defined in the
 NBD protocol specification, and also defines an additional metadata
 namespace "qemu".

-
 =3D=3D "qemu" namespace =3D=3D

 The "qemu" namespace currently contains only one type of context,
@@ -36,3 +35,21 @@ in addition to "qemu:dirty-bitmap:<dirty-bitmap-export=
-name>":
             namespace.
 * "qemu:dirty-bitmap:" - returns list of all available dirty-bitmap
                          metadata contexts.
+
+=3D Features by version =3D
+
+The following list documents which qemu version first implemented
+various features (both as a server exposing the feature, and as a
+client taking advantage of the feature when present), to make it
+easier to plan for cross-version interoperability.  Note that in
+several cases, the initial release containing a feature may require
+additional patches from the corresponding stable branch to fix bugs in
+the operation of that feature.
+
+* 2.6: NBD_OPT_STARTTLS with TLS X.509 Certificates
+* 2.8: NBD_CMD_WRITE_ZEROES
+* 2.10: NBD_OPT_GO, NBD_INFO_BLOCK
+* 2.11: NBD_OPT_STRUCTURED_REPLY
+* 2.12: NBD_CMD_BLOCK_STATUS for "base:allocation"
+* 3.0: NBD_OPT_STARTTLS with TLS Pre-Shared Keys (PSK),
+NBD_CMD_BLOCK_STATUS for "qemu:dirty-bitmap:", NBD_CMD_CACHE
--=20
2.20.1
