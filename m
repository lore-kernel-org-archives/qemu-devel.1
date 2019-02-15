Received: from eggs.gnu.org ([209.51.188.92]:42662)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gufXY-0004Zm-Sw
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 10:36:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gufXU-0007Zr-Mi
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 10:36:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33218)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gufXN-0007L0-1A
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 10:36:27 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C5B5EC7964
	for <qemu-devel@nongnu.org>; Fri, 15 Feb 2019 15:36:18 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Fri, 15 Feb 2019 15:36:00 +0000
Message-Id: <20190215153600.1770727-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] hw/smbios: fix offset of type 3 sku field
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>

The type 3 SMBIOS structure[1] ends with fields

  ...
  0x14  - contained element count
  0x15  - contained element record length
  0x16  - sku number

The smbios_type_3 struct missed the contained element record
length field, causing sku number to be reported at the wrong
offset.

[1] https://www.dmtf.org/sites/default/files/standards/documents/DSP0134_=
3.1.1.pdf

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 hw/smbios/smbios.c           | 1 +
 include/hw/firmware/smbios.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
index 818be8a838..47be9071fa 100644
--- a/hw/smbios/smbios.c
+++ b/hw/smbios/smbios.c
@@ -563,6 +563,7 @@ static void smbios_build_type_3_table(void)
     t->height =3D 0;
     t->number_of_power_cords =3D 0;
     t->contained_element_count =3D 0;
+    t->contained_element_record_length =3D 0;
     SMBIOS_TABLE_SET_STR(3, sku_number_str, type3.sku);
=20
     SMBIOS_BUILD_TABLE_POST;
diff --git a/include/hw/firmware/smbios.h b/include/hw/firmware/smbios.h
index eeb5a4d7b6..6fef32a3c9 100644
--- a/include/hw/firmware/smbios.h
+++ b/include/hw/firmware/smbios.h
@@ -162,6 +162,7 @@ struct smbios_type_3 {
     uint8_t height;
     uint8_t number_of_power_cords;
     uint8_t contained_element_count;
+    uint8_t contained_element_record_length;
     uint8_t sku_number_str;
     /* contained elements follow */
 } QEMU_PACKED;
--=20
2.19.2
