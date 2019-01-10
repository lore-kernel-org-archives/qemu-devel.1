Received: from eggs.gnu.org ([209.51.188.92]:34980)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ghPga-0006G2-1y
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 21:03:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ghPgZ-0003EP-4f
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 21:03:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46412)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1ghPgY-0003Dp-VY
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 21:03:07 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 10 Jan 2019 00:02:56 -0200
Message-Id: <20190110020259.8492-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/3] Fix virtio-*(-non)-transitional crash
 on 2.6 machine-types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Cornelia Huck <cohuck@redhat.com>

This is a second attempt to fix the crash reported by Thomas[1].

This keeps the compat property array simple, different from my
first attempt[2].

This also avoids extra complexity on the device code: we don't
need interface name, inheritance tricks, or devices overriding a
compat property after the fact.  The simple absence of the QOM
properties on some device types is enough to make the compat code
skip them.

While working on the fix, I stumbled upon another minor bug in
object_apply_global_props(), which I fixed in patch 1/3.

This series is based on my machine-next branch, because of
conflicts with compat property array cleanups that are already
queued.

[1] http://mid.mail-archive.com/a28d196a-e2fe-a013-a6e2-99ac260f6279@redhat.com
[2] http://mid.mail-archive.com/20190104032226.21428-1-ehabkost@redhat.com

Eduardo Habkost (3):
  qom: Don't keep error value between object_property_parse() calls
  globals: Allow global properties to be optional
  virtio: Make disable-legacy/disable-modern compat properties optional

 include/hw/qdev-core.h | 3 +++
 hw/core/machine.c      | 5 +++--
 qom/object.c           | 6 ++++--
 3 files changed, 10 insertions(+), 4 deletions(-)

-- 
2.18.0.rc1.1.g3f1ff2140
