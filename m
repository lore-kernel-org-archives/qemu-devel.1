Received: from eggs.gnu.org ([2001:4830:134:3::10]:52136)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1gG2u7-0001yJ-Ei
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 10:16:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1gG2u6-00062b-DV
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 10:15:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46656)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1gG2u6-0005yw-6K
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 10:15:58 -0400
From: Fam Zheng <famz@redhat.com>
Date: Fri, 26 Oct 2018 22:15:25 +0800
Message-Id: <20181026141529.4305-6-famz@redhat.com>
In-Reply-To: <20181026141529.4305-1-famz@redhat.com>
References: <20181026141529.4305-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 5/9] tests/vm: Display remaining seconds to wait
 for a VM to start
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-Id: <20181013004034.6968-5-f4bug@amsat.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Fam Zheng <famz@redhat.com>
---
 tests/vm/basevm.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index 9415e7c33a..81a1cb05dd 100755
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -177,11 +177,14 @@ class BaseVM(object):
=20
     def wait_ssh(self, seconds=3D300):
         starttime =3D datetime.datetime.now()
+        endtime =3D starttime + datetime.timedelta(seconds=3Dseconds)
         guest_up =3D False
-        while (datetime.datetime.now() - starttime).total_seconds() < se=
conds:
+        while datetime.datetime.now() < endtime:
             if self.ssh("exit 0") =3D=3D 0:
                 guest_up =3D True
                 break
+            seconds =3D (endtime - datetime.datetime.now()).total_second=
s()
+            logging.debug("%ds before timeout", seconds)
             time.sleep(1)
         if not guest_up:
             raise Exception("Timeout while waiting for guest ssh")
--=20
2.17.1
