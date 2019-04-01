Received: from eggs.gnu.org ([209.51.188.92]:41790)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB45Z-0002JL-PZ
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:03:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB45Y-00043f-Mc
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:03:29 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40914
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1hB45Y-0003xZ-GW
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:03:28 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x31L1pMw095673
	for <qemu-devel@nongnu.org>; Mon, 1 Apr 2019 17:03:18 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2rksweh0me-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 01 Apr 2019 17:03:17 -0400
Received: from localhost
	by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 1 Apr 2019 22:03:17 +0100
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon,  1 Apr 2019 16:00:10 -0500
In-Reply-To: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
References: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20190401210011.16009-97-mdroth@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 96/97] usb-mtp: outlaw slashes in filenames
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>

From: Gerd Hoffmann <kraxel@redhat.com>

Slash is unix directory separator, so they are not allowed in filenames.
Note this also stops the classic escape via "../".

Fixes: CVE-2018-16867
Reported-by: Michael Hanselmann <public@hansmi.ch>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-id: 20181203101045.27976-3-kraxel@redhat.com
(cherry picked from commit c52d46e041b42bb1ee6f692e00a0abe37a9659f6)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/usb/dev-mtp.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
index 1ded7ac9a3..899c8a36ab 100644
--- a/hw/usb/dev-mtp.c
+++ b/hw/usb/dev-mtp.c
@@ -1667,6 +1667,12 @@ static void usb_mtp_write_metadata(MTPState *s)
=20
     utf16_to_str(dataset->length, dataset->filename, filename);
=20
+    if (strchr(filename, '/')) {
+        usb_mtp_queue_result(s, RES_PARAMETER_NOT_SUPPORTED, d->trans,
+                             0, 0, 0, 0);
+        return;
+    }
+
     o =3D usb_mtp_object_lookup_name(p, filename, dataset->length);
     if (o !=3D NULL) {
         next_handle =3D o->handle;
--=20
2.17.1
