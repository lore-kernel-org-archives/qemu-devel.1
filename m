Received: from eggs.gnu.org ([2001:4830:134:3::10]:55907)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cgBEB-00012d-DZ
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 09:15:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cgBEA-00041L-2z
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 09:15:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44898)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cgBE9-00040p-TJ
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 09:15:38 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1E31813A5E
	for <qemu-devel@nongnu.org>; Tue, 21 Feb 2017 14:15:38 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 21 Feb 2017 18:14:29 +0400
Message-Id: <20170221141451.28305-9-marcandre.lureau@redhat.com>
In-Reply-To: <20170221141451.28305-1-marcandre.lureau@redhat.com>
References: <20170221141451.28305-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 08/30] tests: fix q35-test leaks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Spotted by ASAN.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 tests/q35-test.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tests/q35-test.c b/tests/q35-test.c
index 763fe3d6ae..e010d781e7 100644
--- a/tests/q35-test.c
+++ b/tests/q35-test.c
@@ -71,6 +71,9 @@ static void test_smram_lock(void)
     g_assert(smram_test_bit(pcidev, MCH_HOST_BRIDGE_SMRAM_D_OPEN) =3D=3D=
 false);
     smram_set_bit(pcidev, MCH_HOST_BRIDGE_SMRAM_D_OPEN, true);
     g_assert(smram_test_bit(pcidev, MCH_HOST_BRIDGE_SMRAM_D_OPEN) =3D=3D=
 true);
+
+    qpci_free_pc(pcibus);
+    g_free(pcidev);
 }
=20
 int main(int argc, char **argv)
--=20
2.11.0.295.gd7dffce1c.dirty
