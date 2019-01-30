Received: from eggs.gnu.org ([209.51.188.92]:34957)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gogOo-00052E-8R
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 22:18:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gogOn-0006gS-F2
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 22:18:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40230)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1gogOn-0006g9-9g
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 22:18:49 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Wed, 30 Jan 2019 11:18:13 +0800
Message-Id: <20190130031817.27780-3-stefanha@redhat.com>
In-Reply-To: <20190130031817.27780-1-stefanha@redhat.com>
References: <20190130031817.27780-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 2/6] trace: enforce that every trace-events file
 has a final newline
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, Eric Blake <eblake@redhat.com>

From: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

When generating the trace-events-all file, the build system simply
concatenates all the individual trace-events files. If any one of those
files does not have a final newline, the printf format string will have
the contents of the first line of the next file appended to it, which is
usually a '#' comment.

Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Message-id: 20190123120016.4538-3-berrange@redhat.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
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
