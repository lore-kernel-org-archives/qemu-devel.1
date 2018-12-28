Received: from eggs.gnu.org ([208.118.235.92]:46458)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gcwi9-0006zF-4w
	for qemu-devel@nongnu.org; Fri, 28 Dec 2018 13:18:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gcwU9-0005VJ-26
	for qemu-devel@nongnu.org; Fri, 28 Dec 2018 13:03:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58106)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gcw1Z-0001W7-1k
	for qemu-devel@nongnu.org; Fri, 28 Dec 2018 12:34:20 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Fri, 28 Dec 2018 18:33:51 +0100
Message-Id: <20181228173356.15359-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 0/5] Fix strncpy() warnings for GCC8 new
 -Wstringop-truncation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, Eric Blake <eblake@redhat.com>, Juan Quintela <quintela@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Igor Mammedov <imammedo@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Thomas Huth <thuth@redhat.com>

GCC 8 new warning prevents builds to success since quite some time.
First report on the mailing list is in July 2018:
https://lists.gnu.org/archive/html/qemu-devel/2018-07/msg03723.html

Since v3:
- patch 1: make sens of description (eblake)
- patch 2: append QEMU_NONSTRING instead of prepending it (mst)
- patch 3: rebased (imammedo), intented
- patch 4: replaced by Marc-Andr=C3=A9 first attempt, improved doc
- patch 5: add assert() and NUL-terminate the buffer (mst)

Various intents has been sent to fix this:
- Incorrectly using g_strlcpy()
  https://lists.gnu.org/archive/html/qemu-devel/2018-08/msg03705.html
  https://lists.gnu.org/archive/html/qemu-devel/2018-08/msg03706.html
- Using assert() and strpadcpy()
  https://lists.gnu.org/archive/html/qemu-devel/2018-11/msg03938.html
  This was the approch taken by the previous v2:
  https://lists.gnu.org/archive/html/qemu-devel/2018-12/msg04405.html
- Use #pragma GCC diagnostic ignored "-Wstringop-truncation"
  https://lists.gnu.org/archive/html/qemu-devel/2018-12/msg04261.html
- adding an inline wrapper with said pragma in there
  https://lists.gnu.org/archive/html/qemu-devel/2018-12/msg04261.html
- -Wno-stringop-truncation is the makefile
  https://lists.gnu.org/archive/html/qemu-devel/2018-12/msg04261.html
- Use the 'nonstring' attribute
  https://lists.gnu.org/archive/html/qemu-devel/2018-12/msg04493.html

This series add the QEMU_NONSTRING definition and use it.

Regards,

Phil.

Marc-Andr=C3=A9 Lureau (1):
  migration: Fix stringop-truncation warning

Philippe Mathieu-Daud=C3=A9 (4):
  qemu/compiler: Define QEMU_NONSTRING
  block/sheepdog: Use QEMU_NONSTRING for non NUL-terminated arrays
  hw/acpi: Use QEMU_NONSTRING for non NUL-terminated arrays
  migration: Use strnlen() for fixed-size string

 block/sheepdog.c            |  2 +-
 hw/acpi/core.c              | 12 ++++++++----
 include/hw/acpi/acpi-defs.h | 13 ++++++++-----
 include/qemu/compiler.h     | 15 +++++++++++++++
 migration/global_state.c    | 14 +++++++++++++-
 5 files changed, 45 insertions(+), 11 deletions(-)

--=20
2.17.2
