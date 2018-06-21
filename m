Received: from eggs.gnu.org ([2001:4830:134:3::10]:43978)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fVyBk-000271-7s
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 07:55:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fVyBj-0003Dd-08
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 07:55:44 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37766 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1fVyBi-0003DT-SB
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 07:55:42 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 21 Jun 2018 13:55:30 +0200
Message-Id: <20180621115530.11069-6-marcandre.lureau@redhat.com>
In-Reply-To: <20180621115530.11069-1-marcandre.lureau@redhat.com>
References: <20180621115530.11069-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 5/5] tpm: add a fake ACPI memory clear
 interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, stefanb@linux.vnet.ibm.com, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

This allows to pass the last failing test from the Windows HLK TPM 2.0
TCG PPI 1.3 tests.

The interface is described in the "TCG Platform Reset Attack
Mitigation Specification", chapter 6 "ACPI _DSM Function". Whether or
not we should have a real implementation remains an open question to me.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/i386/acpi-build.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 4cb3ac9000..fafc61c9dd 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -2072,6 +2072,15 @@ build_tpm_ppi(Aml *dev)
             aml_append(ifctx, aml_return(aml_buffer(1, zerobyte)));
         }
         aml_append(method, ifctx);
+
+       /* dummy MOR Memory Clear for the sake of WLK PPI test */
+        ifctx =3D aml_if(
+            aml_equal(aml_arg(0),
+                      aml_touuid("376054ED-CC13-4675-901C-4756D7F2D45D")=
));
+        {
+            aml_append(ifctx, aml_return(aml_int(0)));
+        }
+        aml_append(method, ifctx);
     }
     aml_append(dev, method);
 }
--=20
2.18.0.rc1
