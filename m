Received: from eggs.gnu.org ([2001:4830:134:3::10]:40747)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fIYrp-0008J0-1G
	for qemu-devel@nongnu.org; Tue, 15 May 2018 08:15:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fIYrk-00016z-3R
	for qemu-devel@nongnu.org; Tue, 15 May 2018 08:15:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:22623)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1fIYrj-00016H-Ti
	for qemu-devel@nongnu.org; Tue, 15 May 2018 08:15:40 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 15 May 2018 14:14:33 +0200
Message-Id: <20180515121433.6112-5-marcandre.lureau@redhat.com>
In-Reply-To: <20180515121433.6112-1-marcandre.lureau@redhat.com>
References: <20180515121433.6112-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 4/4] tpm: add a fake ACPI memory clear
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, stefanb@linux.vnet.ibm.com, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Richard Henderson <rth@twiddle.net>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

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
index 95be4f0710..392a1e50bd 100644
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
2.17.0.253.g3dd125b46d
