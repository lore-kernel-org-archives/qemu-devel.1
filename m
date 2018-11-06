Received: from eggs.gnu.org ([2001:4830:134:3::10]:46645)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gK28l-0001ls-Ob
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 09:15:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gK277-0003cz-5G
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 09:13:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41896)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gK276-0003Zq-Tb
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 09:13:53 -0500
Date: Tue, 6 Nov 2018 09:13:43 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181106091147-mutt-send-email-mst@kernel.org>
References: <20181105181353.39804-1-mst@redhat.com>
	<20181105181353.39804-3-mst@redhat.com>
	<a21e8e21-d056-1e9a-3726-54f8ce24a162@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <a21e8e21-d056-1e9a-3726-54f8ce24a162@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 02/33] tests: Move
 tests/hex-loader-check-data/ to tests/data/hex-loader/
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Su Hang <suhang16@mails.ucas.ac.cn>, Paolo Bonzini <pbonzini@redhat.com>

On Tue, Nov 06, 2018 at 02:27:18PM +0100, Philippe Mathieu-Daud=E9 wrote:
> On 5/11/18 19:14, Michael S. Tsirkin wrote:
> > From: Peter Maydell <peter.maydell@linaro.org>
> >=20
> > Currently tests/hex-loader-check-data contains data files used
> > by the hexloader-test, and configure individually symlinks those
> > data files into the build directory using a wildcard.
> >=20
> > Using a wildcard like this is a bad idea, because if a new
> > data file is added, nothing causes configure to be rerun,
> > and so no symlink is added for the new file. This can cause
> > tests to spuriously fail when they can't find their data.
> > Instead, it's better to symlink an entire directory of
> > data files. We already have such a directory: tests/data.
> >=20
> > Move the data files from tests/hex-loader-check-data/ to
> > tests/data/hex-loader/, and remove the unnecessary symlinking.
> >=20
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>=20
> I reviewed/tested this patch too.


Thanks a lot Philippe!
It is unfortunately too late to update this patch info in git
commit history, however your help is still greatly appreciated!


> > ---
> >   configure                                                 | 4 ----
> >   tests/hexloader-test.c                                    | 2 +-
> >   MAINTAINERS                                               | 2 +-
> >   tests/{hex-loader-check-data =3D> data/hex-loader}/test.hex | 0
> >   4 files changed, 2 insertions(+), 6 deletions(-)
> >   rename tests/{hex-loader-check-data =3D> data/hex-loader}/test.hex =
(100%)
> >=20
> > diff --git a/configure b/configure
> > index 895b7483b8..bfdca8b814 100755
> > --- a/configure
> > +++ b/configure
> > @@ -7421,10 +7421,6 @@ for bios_file in \
> >   do
> >       FILES=3D"$FILES pc-bios/$(basename $bios_file)"
> >   done
> > -for test_file in $(find $source_path/tests/hex-loader-check-data -ty=
pe f)
> > -do
> > -    FILES=3D"$FILES tests/hex-loader-check-data$(echo $test_file | s=
ed -e 's/.*hex-loader-check-data//')"
> > -done
> >   mkdir -p $DIRS
> >   for f in $FILES ; do
> >       if [ -e "$source_path/$f" ] && [ "$pwd_is_source_path" !=3D "y"=
 ]; then
> > diff --git a/tests/hexloader-test.c b/tests/hexloader-test.c
> > index b653d44ba1..834ed52c22 100644
> > --- a/tests/hexloader-test.c
> > +++ b/tests/hexloader-test.c
> > @@ -23,7 +23,7 @@ static void hex_loader_test(void)
> >       const unsigned int base_addr =3D 0x00010000;
> >       QTestState *s =3D qtest_initf(
> > -        "-M vexpress-a9 -nographic -device loader,file=3Dtests/hex-l=
oader-check-data/test.hex");
> > +        "-M vexpress-a9 -nographic -device loader,file=3Dtests/data/=
hex-loader/test.hex");
> >       for (i =3D 0; i < 256; ++i) {
> >           uint8_t val =3D qtest_readb(s, base_addr + i);
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 98a1856afc..cfabc14b59 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -1370,7 +1370,7 @@ Intel Hexadecimal Object File Loader
> >   M: Su Hang <suhang16@mails.ucas.ac.cn>
> >   S: Maintained
> >   F: tests/hexloader-test.c
> > -F: tests/hex-loader-check-data/test.hex
> > +F: tests/data/hex-loader/test.hex
> >   CHRP NVRAM
> >   M: Thomas Huth <thuth@redhat.com>
> > diff --git a/tests/hex-loader-check-data/test.hex b/tests/data/hex-lo=
ader/test.hex
> > similarity index 100%
> > rename from tests/hex-loader-check-data/test.hex
> > rename to tests/data/hex-loader/test.hex
> >=20
