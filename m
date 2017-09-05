Received: from eggs.gnu.org ([2001:4830:134:3::10]:52465)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dpFwA-0001sM-L7
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 11:38:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dpFw6-0000nG-1Q
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 11:38:50 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50094)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dpFw5-0000mt-Mv
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 11:38:45 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v85FcMZE066189
	for <qemu-devel@nongnu.org>; Tue, 5 Sep 2017 11:38:44 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2csvh07yej-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 05 Sep 2017 11:38:44 -0400
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Tue, 5 Sep 2017 16:38:41 +0100
From: Greg Kurz <groug@kaod.org>
Date: Tue,  5 Sep 2017 17:38:30 +0200
In-Reply-To: <20170905153833.14118-1-groug@kaod.org>
References: <20170905153833.14118-1-groug@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20170905153833.14118-2-groug@kaod.org>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 1/4] 9pfs: avoid sign conversion error
 simplifying the code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Greg Kurz <groug@kaod.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

(note this is how other functions also handle the errors).

hw/9pfs/9p.c:948:18: warning: Loss of sign in implicit conversion
        offset =3D err;
                 ^~~

Reported-by: Clang Static Analyzer
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/9pfs/9p.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index 333dbb6f8ee2..0a37c8bd1361 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -945,7 +945,6 @@ static void coroutine_fn v9fs_version(void *opaque)
     v9fs_string_init(&version);
     err =3D pdu_unmarshal(pdu, offset, "ds", &s->msize, &version);
     if (err < 0) {
-        offset =3D err;
         goto out;
     }
     trace_v9fs_version(pdu->tag, pdu->id, s->msize, version.data);
@@ -962,13 +961,12 @@ static void coroutine_fn v9fs_version(void *opaque)
=20
     err =3D pdu_marshal(pdu, offset, "ds", s->msize, &version);
     if (err < 0) {
-        offset =3D err;
         goto out;
     }
-    offset +=3D err;
+    err +=3D offset;
     trace_v9fs_version_return(pdu->tag, pdu->id, s->msize, version.data)=
;
 out:
-    pdu_complete(pdu, offset);
+    pdu_complete(pdu, err);
     v9fs_string_free(&version);
 }
=20
--=20
2.13.5
