Received: from eggs.gnu.org ([209.51.188.92]:34616)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hJccl-0000LQ-Qb
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 07:33:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hJccj-00050P-RW
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 07:33:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42316)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1hJcch-0004wl-QX
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 07:33:05 -0400
Date: Thu, 25 Apr 2019 13:32:50 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190425133250.69ec66dc@redhat.com>
In-Reply-To: <20190425082050.GF24829@richard>
References: <1556170489-131927-1-git-send-email-imammedo@redhat.com>
	<1556170489-131927-13-git-send-email-imammedo@redhat.com>
	<20190425082050.GF24829@richard>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 12/13] tests: acpi: refactor
 rebuild-expected-aml.sh to dump ACPI tables for a specified list of targets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Yang <richardw.yang@linux.intel.com>
Cc: qemu-devel@nongnu.org, Laszlo Ersek <lersek@redhat.com>, "Michael S.
	Tsirkin" <mst@redhat.com>, Gonglei <arei.gonglei@huawei.com>, Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>, Shannon Zhao <shannon.zhaosl@gmail.com>, Andrew Jones <drjones@redhat.com>, Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>, Ben Warren <ben@skyportsystems.com>

On Thu, 25 Apr 2019 16:20:50 +0800
Wei Yang <richardw.yang@linux.intel.com> wrote:

> On Thu, Apr 25, 2019 at 07:34:48AM +0200, Igor Mammedov wrote:
> >Make initial list contain aarch64 and x86_64 targets. =20
>=20
> so i386 is taken out?
>=20
> >
> >Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> >Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> >---
> >v2:
> > * fix up error message (Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>)
> >---
> > tests/data/acpi/rebuild-expected-aml.sh | 23 +++++++++++------------
> > 1 file changed, 11 insertions(+), 12 deletions(-)
> >
> >diff --git a/tests/data/acpi/rebuild-expected-aml.sh b/tests/data/acpi/r=
ebuild-expected-aml.sh
> >index abdff70..52793f3 100755
> >--- a/tests/data/acpi/rebuild-expected-aml.sh
> >+++ b/tests/data/acpi/rebuild-expected-aml.sh
> >@@ -7,21 +7,12 @@
> > #
> > # Authors:
> > #  Marcel Apfelbaum <marcel.a@redhat.com>
> >+#  Igor Mammedov <imammedo@redhat.com>
> > #
> > # This work is licensed under the terms of the GNU GPLv2.
> > # See the COPYING.LIB file in the top-level directory.
> >=20
> >-qemu=3D
> >-
> >-if [ -e x86_64-softmmu/qemu-system-x86_64 ]; then
> >-    qemu=3D"x86_64-softmmu/qemu-system-x86_64"
> >-elif [ -e i386-softmmu/qemu-system-i386 ]; then
> >-    qemu=3D"i386-softmmu/qemu-system-i386"
> >-else
> >-    echo "Run 'make' to build the qemu exectutable!"
> >-    echo "Run this script from the build directory."
> >-    exit 1;
> >-fi
> >+qemu_bins=3D"aarch64-softmmu/qemu-system-aarch64 x86_64-softmmu/qemu-sy=
stem-x86_64"
> >=20
> > if [ ! -e "tests/bios-tables-test" ]; then
> >     echo "Test: bios-tables-test is required! Run make check before thi=
s script."
> >@@ -29,6 +20,14 @@ if [ ! -e "tests/bios-tables-test" ]; then
> >     exit 1;
> > fi
> >=20
> >-TEST_ACPI_REBUILD_AML=3Dy QTEST_QEMU_BINARY=3D$qemu tests/bios-tables-t=
est
> >+for qemu in $qemu_bins; do
> >+    if [ ! -e $qemu ]; then
> >+        echo "Run 'make' to build the following QEMU exectutables: $qem=
u_bins" =20
>=20
> s/exectutables/executables

fixed
=20
> >+        echo "Also, run this script from the build directory."
> >+        exit 1;
> >+    fi
> >+    TEST_ACPI_REBUILD_AML=3Dy QTEST_QEMU_BINARY=3D$qemu tests/bios-tabl=
es-test
> >+done
> >+ =20
>=20
> The original behavior is either one executable exist will pass.
>=20
> But now, either of one doesn't exist will fail. Is this what we expect?

It's mainly maintainers tool to update reference blobs.
And I intentionally made it fail to force maintainer/developer
building all targets that depend on ACPI to make sure
that mistakes won't silently creep in due to non build target.

> > echo "The files were rebuilt and can be added to git."
> >--=20
> >2.7.4 =20
>=20
