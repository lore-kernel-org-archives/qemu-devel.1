Received: from eggs.gnu.org ([209.51.188.92]:45028)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gm1oD-0007fO-Aq
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 14:34:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gm1Yf-0000M3-U3
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 14:18:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47582)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gm1Yf-0000HY-Ny
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 14:18:01 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BC3C088E4A
	for <qemu-devel@nongnu.org>; Tue, 22 Jan 2019 16:49:50 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Tue, 22 Jan 2019 16:49:38 +0000
Message-Id: <20190122164940.29244-3-berrange@redhat.com>
In-Reply-To: <20190122164940.29244-1-berrange@redhat.com>
References: <20190122164940.29244-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 2/4] trace: enforce that every trace-events
 file has a final newline
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Eric Blake <eblake@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>

When generating the trace-events-all file, the build system simply
concatenates all the individual trace-events files. If any one of those
files does not have a final newline, the printf format string will have
the contents of the first line of the next file appended to it, which is
usually a '#' comment.

Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 hw/gpio/trace-events          | 2 +-
 scripts/tracetool/__init__.py | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/gpio/trace-events b/hw/gpio/trace-events
index cb41a89756..5d4dd200c2 100644
--- a/hw/gpio/trace-events
+++ b/hw/gpio/trace-events
@@ -4,4 +4,4 @@
 nrf51_gpio_read(uint64_t offset, uint64_t r) "offset 0x%" PRIx64 " value=
 0x%" PRIx64
 nrf51_gpio_write(uint64_t offset, uint64_t value) "offset 0x%" PRIx64 " =
value 0x%" PRIx64
 nrf51_gpio_set(int64_t line, int64_t value) "line %" PRIi64 " value %" P=
RIi64
-nrf51_gpio_update_output_irq(int64_t line, int64_t value) "line %" PRIi6=
4 " value %" PRIi64
\ No newline at end of file
+nrf51_gpio_update_output_irq(int64_t line, int64_t value) "line %" PRIi6=
4 " value %" PRIi64
diff --git a/scripts/tracetool/__init__.py b/scripts/tracetool/__init__.p=
y
index 0e3c9e146c..3478ac93ab 100644
--- a/scripts/tracetool/__init__.py
+++ b/scripts/tracetool/__init__.py
@@ -350,6 +350,8 @@ def read_events(fobj, fname):
=20
     events =3D []
     for lineno, line in enumerate(fobj, 1):
+        if line[-1] !=3D '\n':
+            raise ValueError("%s does not end with a new line" % fname)
         if not line.strip():
             continue
         if line.lstrip().startswith('#'):
--=20
2.20.1
