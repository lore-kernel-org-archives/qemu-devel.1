Received: from eggs.gnu.org ([2001:4830:134:3::10]:34656)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1drSGj-0000Dn-5Z
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 13:13:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1drSGe-0003mD-LI
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 13:13:09 -0400
Received: from 5.mo2.mail-out.ovh.net ([87.98.181.248]:52012)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1drSGe-0003ll-F4
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 13:13:04 -0400
Received: from player770.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id 2C8CDAACCD
	for <qemu-devel@nongnu.org>; Mon, 11 Sep 2017 19:13:03 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Mon, 11 Sep 2017 19:12:16 +0200
Message-Id: <20170911171235.29331-3-clg@kaod.org>
In-Reply-To: <20170911171235.29331-1-clg@kaod.org>
References: <20170911171235.29331-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC PATCH v2 02/21] migration: add
 VMSTATE_STRUCT_VARRAY_UINT32_ALLOC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Alexey Kardashevskiy <aik@ozlabs.ru>, Alexander Graf <agraf@suse.de>
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

This is needed to migrate the state of the internal tables of the XIVE
object.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/migration/vmstate.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index 85e43da56868..4dfb1bf84b5e 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -560,6 +560,16 @@ extern const VMStateInfo vmstate_info_qtailq;
     .offset     =3D vmstate_offset_pointer(_state, _field, _type),     \
 }
=20
+#define VMSTATE_STRUCT_VARRAY_UINT32_ALLOC(_field, _state, _field_num, _=
version, _vmsd, _type) {\
+    .name       =3D (stringify(_field)),                               \
+    .version_id =3D (_version),                                        \
+    .vmsd       =3D &(_vmsd),                                          \
+    .num_offset =3D vmstate_offset_value(_state, _field_num, uint32_t), =
\
+    .size       =3D sizeof(_type),                                     \
+    .flags      =3D VMS_STRUCT|VMS_VARRAY_UINT32|VMS_ALLOC|VMS_POINTER, =
\
+    .offset     =3D vmstate_offset_pointer(_state, _field, _type),     \
+}
+
 #define VMSTATE_STATIC_BUFFER(_field, _state, _version, _test, _start, _=
size) { \
     .name         =3D (stringify(_field)),                             \
     .version_id   =3D (_version),                                      \
--=20
2.13.5
