Received: from eggs.gnu.org ([2001:4830:134:3::10]:48049)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dmUCT-0001HZ-Ap
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:16:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dmUCQ-0005Sd-6C
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:16:13 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53228
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1dmUCQ-0005S2-1O
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:16:10 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7T0EAXM081588
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 20:16:09 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2cmurncrm7-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 20:16:09 -0400
Received: from localhost
	by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 28 Aug 2017 20:16:08 -0400
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 28 Aug 2017 19:13:38 -0500
In-Reply-To: <1503965694-10794-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1503965694-10794-1-git-send-email-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <1503965694-10794-4-git-send-email-mdroth@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 03/79] qemu-img/convert: Always set ret < 0 on
 error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Max Reitz <mreitz@redhat.com>

From: Max Reitz <mreitz@redhat.com>

Otherwise the qemu-img process will exit with EXIT_SUCCESS instead of
EXIT_FAILURE.

Cc: qemu-stable <qemu-stable@nongnu.org>
Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
* applied directly to stable, upstream code has issue fixed via a
  refactoring introduced by 9fd77f9, which isn't targetted for stable
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 qemu-img.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/qemu-img.c b/qemu-img.c
index b220cf7..9aa7823 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -2069,6 +2069,7 @@ static int img_convert(int argc, char **argv)
             opts =3D qemu_opts_parse_noisily(&qemu_object_opts,
                                            optarg, true);
             if (!opts) {
+                ret =3D -1;
                 goto fail_getopt;
             }
             break;
@@ -2081,6 +2082,7 @@ static int img_convert(int argc, char **argv)
     if (qemu_opts_foreach(&qemu_object_opts,
                           user_creatable_add_opts_foreach,
                           NULL, NULL)) {
+        ret =3D -1;
         goto fail_getopt;
     }
=20
--=20
2.7.4
