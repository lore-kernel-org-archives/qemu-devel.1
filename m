Received: from eggs.gnu.org ([209.51.188.92]:49781)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hMD4w-0005kY-Ps
	for qemu-devel@nongnu.org; Thu, 02 May 2019 10:52:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hMD4v-0003BC-Np
	for qemu-devel@nongnu.org; Thu, 02 May 2019 10:52:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:3202)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1hMD4v-0003AD-IX
	for qemu-devel@nongnu.org; Thu, 02 May 2019 10:52:53 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Thu,  2 May 2019 16:52:03 +0200
Message-Id: <1556808723-226478-16-git-send-email-imammedo@redhat.com>
In-Reply-To: <1556808723-226478-1-git-send-email-imammedo@redhat.com>
References: <1556808723-226478-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 15/15] tests: acpi: print error unable to
 dump ACPI table during rebuild
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laszlo Ersek <lersek@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Gonglei <arei.gonglei@huawei.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Shannon Zhao <shannon.zhaosl@gmail.com>, Wei Yang <richardw.yang@linux.intel.com>, Andrew Jones <drjones@redhat.com>, Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>, Ben Warren <ben@skyportsystems.com>, xuwei5@hisilicon.com, xuwei5@huawei.com, linuxarm@huawei.com

Instead of just asserting print the error that lead to assert first.
While at it move assert into rebuild branch, which removes redundant
check done in case of !rebuild branch is taken (the later is taken
care of by g_assert_no_error).

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Wei Yang <richardw.yang@linux.intel.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
v4:
  * fix typo in commit message (Reviewed-by: Philippe Mathieu-Daud=C3=A9 =
<philmd@redhat.com>)
---
 tests/bios-tables-test.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
index eaa1b0c..6cb8b16 100644
--- a/tests/bios-tables-test.c
+++ b/tests/bios-tables-test.c
@@ -195,11 +195,14 @@ static void dump_aml_files(test_data *data, bool re=
build)
                                        sdt->aml, ext);
             fd =3D g_open(aml_file, O_WRONLY|O_TRUNC|O_CREAT,
                         S_IRUSR|S_IWUSR|S_IRGRP|S_IWGRP|S_IROTH);
+            if (fd < 0) {
+                perror(aml_file);
+            }
+            g_assert(fd >=3D 0);
         } else {
             fd =3D g_file_open_tmp("aml-XXXXXX", &sdt->aml_file, &error)=
;
             g_assert_no_error(error);
         }
-        g_assert(fd >=3D 0);
=20
         ret =3D qemu_write_full(fd, sdt->aml, sdt->aml_len);
         g_assert(ret =3D=3D sdt->aml_len);
--=20
2.7.4
