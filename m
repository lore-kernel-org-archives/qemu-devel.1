Received: from eggs.gnu.org ([209.51.188.92]:38210)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1grTIg-0008SX-Fb
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 14:56:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1grTIf-0007up-Im
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 14:56:02 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Wed,  6 Feb 2019 20:55:45 +0100
Message-Id: <20190206195551.28893-3-mreitz@redhat.com>
In-Reply-To: <20190206195551.28893-1-mreitz@redhat.com>
References: <20190206195551.28893-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 2/8] docs/qapi: Document optional
 discriminators
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Kevin Wolf <kwolf@redhat.com>

Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 docs/devel/qapi-code-gen.txt | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.txt
index 87183d3a09..32c576f30b 100644
--- a/docs/devel/qapi-code-gen.txt
+++ b/docs/devel/qapi-code-gen.txt
@@ -472,8 +472,8 @@ All branches of the union must be complex types, and =
the top-level
 members of the union dictionary on the wire will be combination of
 members from both the base type and the appropriate branch type (when
 merging two dictionaries, there must be no keys in common).  The
-'discriminator' member must be the name of a non-optional enum-typed
-member of the base struct.
+'discriminator' member must be the name of an enum-typed member of the
+base struct.
=20
 The following example enhances the above simple union example by
 adding an optional common member 'read-only', renaming the
@@ -504,6 +504,23 @@ In the resulting generated C data types, a flat unio=
n is
 represented as a struct with the base members included directly, and
 then a union of structures for each branch of the struct.
=20
+If the discriminator points to an optional member of the base struct,
+its default value must be specified as a 'default-variant'.  In the
+following example, the above BlockDriver struct is changed so it
+defaults to the 'file' driver if that field is omitted on the wire:
+
+ { 'union': 'BlockdevOptions',
+   'base': { '*driver': 'BlockdevDriver', '*read-only': 'bool' },
+   'discriminator': 'driver',
+   'default-variant': 'file',
+   'data': { 'file': 'BlockdevOptionsFile',
+             'qcow2': 'BlockdevOptionsQcow2' } }
+
+Now the 'file' JSON object can be abbreviated to:
+
+ { "read-only": "true",
+   "filename": "/some/place/my-image" }
+
 A simple union can always be re-written as a flat union where the base
 class has a single member named 'type', and where each branch of the
 union has a struct with a single member named 'data'.  That is,
--=20
2.20.1
