Received: from eggs.gnu.org ([209.51.188.92]:37459)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gk9au-0007hU-5l
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 10:28:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gk9ao-0003GT-Ek
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 10:28:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49814)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1gk9ak-0002nj-0g
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 10:28:28 -0500
Date: Thu, 17 Jan 2019 16:28:17 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190117162817.46b14b4c@redhat.com>
In-Reply-To: <5f191a7d-74fd-db22-2e71-c8de1cc1c312@redhat.com>
References: <1547566866-129386-1-git-send-email-imammedo@redhat.com>
	<1547566866-129386-15-git-send-email-imammedo@redhat.com>
	<5f191a7d-74fd-db22-2e71-c8de1cc1c312@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 14/14] tests: acpi: refactor
 rebuild-expected-aml.sh to dump ACPI tables for a specified list of targets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Cc: qemu-devel@nongnu.org, Gonglei <arei.gonglei@huawei.com>, Laszlo Ersek <lersek@redhat.com>, Shannon Zhao <shannon.zhaosl@gmail.com>, "Michael S.
	Tsirkin" <mst@redhat.com>, Samuel Ortiz <sameo@linux.intel.com>, Andrew Jones <drjones@redhat.com>

On Wed, 16 Jan 2019 18:08:17 +0100
Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:

> On 1/15/19 4:41 PM, Igor Mammedov wrote:
> > Make initial list contain aarch64 and x86_64 targets. =20
>=20
> Maybe worth adding a line "remove i386"?
I've dropped i386 as it's redundant, since x86_64 target re-builds the same=
 tables.
And maintainer is likely to build all targets when preparing update/pull re=
q.

> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > ---
> >  tests/data/acpi/rebuild-expected-aml.sh | 23 +++++++++++------------
> >  1 file changed, 11 insertions(+), 12 deletions(-)
> >=20
> > diff --git a/tests/data/acpi/rebuild-expected-aml.sh b/tests/data/acpi/=
rebuild-expected-aml.sh
> > index bf9ba24..6287aa6 100755
> > --- a/tests/data/acpi/rebuild-expected-aml.sh
> > +++ b/tests/data/acpi/rebuild-expected-aml.sh
> > @@ -7,21 +7,12 @@
> >  #
> >  # Authors:
> >  #  Marcel Apfelbaum <marcel.a@redhat.com>
> > +#  Igor Mammedov <imammedo@redhat.com>
> >  #
> >  # This work is licensed under the terms of the GNU GPLv2.
> >  # See the COPYING.LIB file in the top-level directory.
> > =20
> > -qemu=3D
> > -
> > -if [ -e x86_64-softmmu/qemu-system-x86_64 ]; then
> > -    qemu=3D"x86_64-softmmu/qemu-system-x86_64"
> > -elif [ -e i386-softmmu/qemu-system-i386 ]; then
> > -    qemu=3D"i386-softmmu/qemu-system-i386"
> > -else
> > -    echo "Run 'make' to build the qemu exectutable!"
> > -    echo "Run this script from the build directory."
> > -    exit 1;
> > -fi
> > +qemu_bins=3D"aarch64-softmmu/qemu-system-aarch64 x86_64-softmmu/qemu-s=
ystem-x86_64"
> > =20
> >  if [ ! -e "tests/bios-tables-test" ]; then
> >      echo "Test: bios-tables-test is required! Run make check before th=
is script."
> > @@ -29,6 +20,14 @@ if [ ! -e "tests/bios-tables-test" ]; then
> >      exit 1;
> >  fi
> > =20
> > -TEST_ACPI_REBUILD_AML=3Dy QTEST_QEMU_BINARY=3D$qemu tests/bios-tables-=
test
> > +for qemu in $qemu_bins; do
> > +    if [ ! -e $qemu ]; then
> > +        echo "Run 'make' to build following the qemu exectutables: $qe=
mu_bins" =20
>=20
> "to build the following QEMU executables: ..."
>=20
> > +        echo "Run this script from the build directory." =20
>=20
> Maybe "Also, run ..."
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Thanks,
I'll add the corrections on respin.

>=20
> > +        exit 1;
> > +    fi
> > +    TEST_ACPI_REBUILD_AML=3Dy QTEST_QEMU_BINARY=3D$qemu tests/bios-tab=
les-test
> > +done
> > +
> > =20
> >  echo "The files were rebuilt and can be added to git."
> >  =20
