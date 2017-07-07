Received: from eggs.gnu.org ([2001:4830:134:3::10]:44006)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dTaq5-0007u6-Ou
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 17:31:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dTaq2-0000cM-Jr
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 17:31:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42660)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dTaq2-0000bz-Dp
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 17:30:58 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri,  7 Jul 2017 18:30:50 -0300
Message-Id: <20170707213052.13087-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH 0/2] qom: Fix ambiguous path detection when
 ambiguous=NULL
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, Igor Mammedov <imammedo@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

object_resolve_path*() ambiguous path detection breaks when
ambiguous==NULL and the object tree have 3 objects of the same type and
only 2 of them are under the same parent.  e.g.:

 /container/obj1 (TYPE_FOO)
 /container/obj2 (TYPE_FOO)
 /obj2 (TYPE_FOO)

With the above tree, object_resolve_path_type("", TYPE_FOO, NULL) will
incorrectly return /obj2, because the search inside "/container" will
return NULL, and the match at "/obj2" won't be detected as ambiguous.

Fix that by always calling object_resolve_partial_path() with a non-NULL
ambiguous parameter.

Test case included.

Reported-by: Igor Mammedov <imammedo@redhat.com>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Eduardo Habkost (2):
  tests: Test case for object_resolve_path*()
  qom: Fix ambiguous path detection when ambiguous=NULL

 qom/object.c               | 17 ++++++++---------
 tests/check-qom-proplist.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+), 9 deletions(-)

-- 
2.9.4
