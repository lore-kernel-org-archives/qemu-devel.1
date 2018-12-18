Received: from eggs.gnu.org ([2001:4830:134:3::10]:33195)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gZJXH-0004iO-Dm
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 12:52:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gZJXD-0001zp-Go
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 12:52:01 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Tue, 18 Dec 2018 18:51:17 +0100
Message-Id: <20181218175122.3229-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 0/5] Fix strncpy() warnings for GCC8 new
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Juan Quintela <quintela@redhat.com>, qemu-block@nongnu.org, 1803872@bugs.launchpad.net, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Howard Spoelstra <hsp.cat7@gmail.com>, Jeff Cody <jcody@redhat.com>, David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Weil <sw@weilnetz.de>, Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, Ben Pye <ben@curlybracket.co.uk>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Thomas Huth <thuth@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Liu Yuan <namei.unix@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Max Reitz <mreitz@redhat.com>

GCC 8 new warning prevents builds to success since quite some time.
First report on the mailing list is in July 2018:
https://lists.gnu.org/archive/html/qemu-devel/2018-07/msg03723.html

Various intents has been sent to fix this:
- Incorrectly using g_strlcpy()
  https://lists.gnu.org/archive/html/qemu-devel/2018-08/msg03705.html
  https://lists.gnu.org/archive/html/qemu-devel/2018-08/msg03706.html
- Using assert() and strpadcpy()
  https://lists.gnu.org/archive/html/qemu-devel/2018-11/msg03938.html
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

Philippe Mathieu-Daud=C3=A9 (5):
  qemu/compiler: Define QEMU_NONSTRING
  block/sheepdog: Use QEMU_NONSTRING for non NUL-terminated arrays
  hw/acpi: Use QEMU_NONSTRING for non NUL-terminated arrays
  migration: Use QEMU_NONSTRING for non NUL-terminated arrays
  migration: Use strnlen() for fixed-size string

 block/sheepdog.c            |  2 +-
 hw/acpi/core.c              |  8 ++++----
 include/hw/acpi/acpi-defs.h |  8 ++++----
 include/qemu/compiler.h     | 15 +++++++++++++++
 migration/global_state.c    |  4 ++--
 5 files changed, 26 insertions(+), 11 deletions(-)

--=20
2.17.2
