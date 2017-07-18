Received: from eggs.gnu.org ([2001:4830:134:3::10]:52175)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dXQGb-0005uB-TA
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 07:02:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dXQGY-00035K-R5
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 07:02:13 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50451)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1dXQGY-00034l-HV
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 07:02:10 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6IAwgDf039820
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 07:02:09 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2bsaghs0q6-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 07:02:09 -0400
Received: from localhost
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Tue, 18 Jul 2017 05:02:08 -0600
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Tue, 18 Jul 2017 06:01:41 -0500
In-Reply-To: <1500375704-28002-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1500375704-28002-1-git-send-email-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <1500375704-28002-6-git-send-email-mdroth@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 5/8] qga: report error on keyfile dump error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Cc:qemu-trivial@nongnu.org
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 qga/main.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/qga/main.c b/qga/main.c
index dcd6104..1b381d0 100644
--- a/qga/main.c
+++ b/qga/main.c
@@ -1074,7 +1074,12 @@ static void config_dump(GAConfig *config)
     g_free(tmp);
=20
     tmp =3D g_key_file_to_data(keyfile, NULL, &error);
-    printf("%s", tmp);
+    if (error) {
+        g_critical("Failed to dump keyfile: %s", error->message);
+        g_clear_error(&error);
+    } else {
+        printf("%s", tmp);
+    }
=20
     g_free(tmp);
     g_key_file_free(keyfile);
--=20
2.7.4
