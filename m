Received: from eggs.gnu.org ([2001:4830:134:3::10]:41356)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gZDEl-0001Ac-G0
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 06:08:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gZDAe-0008O2-Ri
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 06:04:17 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Tue, 18 Dec 2018 12:03:30 +0100
Message-Id: <20181218110333.22558-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 0/3] Fix strncpy() warnings for GCC8 new
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
Cc: Ben Pye <ben@curlybracket.co.uk>, Stefan Weil <sw@weilnetz.de>, Howard Spoelstra <hsp.cat7@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jeff Cody <jcody@redhat.com>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Thomas Huth <thuth@redhat.com>, Liu Yuan <namei.unix@gmail.com>, Igor Mammedov <imammedo@redhat.com>, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, David Hildenbrand <david@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, 1803872@bugs.launchpad.net, Juan Quintela <quintela@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

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

This series replace the strncpy() calls by strpadcpy() which seemed
to me the saniest option.

Regards,

Phil.

Marc-Andr=C3=A9 Lureau (1):
  hw/acpi: Replace strncpy() by strpadcpy(pad=3D'\0')

Philippe Mathieu-Daud=C3=A9 (2):
  block/sheepdog: Replace strncpy() by strpadcpy(pad=3D'\0')
  migration: Replace strncpy() by strpadcpy(pad=3D'\0')

 block/sheepdog.c         |  6 +++---
 hw/acpi/aml-build.c      |  6 ++++--
 hw/acpi/core.c           | 13 +++++++------
 migration/global_state.c |  4 ++--
 4 files changed, 16 insertions(+), 13 deletions(-)

--=20
2.17.2
