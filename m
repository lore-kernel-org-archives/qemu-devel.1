Received: from eggs.gnu.org ([208.118.235.92]:47404)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1geyoE-0002yM-GS
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 03:56:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1geyoB-0000pV-CZ
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 03:56:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35728)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1geyoB-0000oD-3t
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 03:56:55 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 28AA276228
	for <qemu-devel@nongnu.org>; Thu,  3 Jan 2019 08:56:54 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Thu,  3 Jan 2019 09:56:33 +0100
Message-Id: <20190103085638.17600-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v5 0/5] Fix strncpy() warnings for GCC8 new
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
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Eric Blake <eblake@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>

GCC 8 new warning prevents builds to success since quite some time.
First report on the mailing list is in July 2018:
https://lists.gnu.org/archive/html/qemu-devel/2018-07/msg03723.html

Since v4:
- fixed some checkpatch errors/warnings reported by patchew
- commented checkpatch errors/warnings false positives
- added Reviewed-by

Now this series is fully reviewed.

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

v4: https://lists.gnu.org/archive/html/qemu-devel/2018-12/msg06175.html
v3: https://lists.gnu.org/archive/html/qemu-devel/2018-12/msg04596.html
v2: https://lists.gnu.org/archive/html/qemu-devel/2018-12/msg04405.html
v1: https://lists.gnu.org/archive/html/qemu-devel/2018-11/msg03938.html

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
 migration/global_state.c    | 15 ++++++++++++++-
 5 files changed, 46 insertions(+), 11 deletions(-)

--=20
2.17.2
