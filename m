Received: from eggs.gnu.org ([2001:4830:134:3::10]:47507)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fgbKd-0007IN-J0
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 15:44:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fgbKc-0005Af-5T
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 15:44:51 -0400
Date: Fri, 20 Jul 2018 16:28:40 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180720192840.GA22694@dhcppc11>
References: <20180718223628.5062-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180718223628.5062-1-f4bug@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-3.1 v2] python: Use io.StringIO
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, "Daniel P . Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>

On Wed, Jul 18, 2018 at 07:36:28PM -0300, Philippe Mathieu-Daud=E9 wrote:
> Both Python 2.7 and 3 support the same io.StringIO to
> handle unicode strings.
>=20
> Python 2.6 requires special care, but since 7f2b55443a his
> support was removed. Stop caring, drop the ImportError check.
>=20
> Use the common form to use indistinctly Python 2.7 or 3.
>=20
> http://python-future.org/compatible_idioms.html#stringio
>=20
> This fixes running tests on the Fedora Docker image,
> which uses Python3 since 356dc290f:
>=20
>   $ make docker-test-block@fedora
>   [...]
>   045         [failed, exit status 1] - output mismatch (see 045.out.ba=
d)
>   --- /tmp/qemu-test/src/tests/qemu-iotests/045.out       2018-07-17 16=
:56:18.000000000 +0000
>   +++ /tmp/qemu-test/build/tests/qemu-iotests/045.out.bad 2018-07-17 17=
:19:22.448409007 +0000
>   @@ -1,5 +1,6 @@
>   -...........
>   ---------------------------------------------------------------------=
--
>   -Ran 11 tests
>   -
>   -OK
>   +Traceback (most recent call last):
>   +  File "045", line 178, in <module>
>   +    iotests.main(supported_fmts=3D['raw'])
>   +  File "/tmp/qemu-test/src/tests/qemu-iotests/iotests.py", line 682,=
 in main
>   +    import StringIO
>   +ModuleNotFoundError: No module named 'StringIO'
>   132         [failed, exit status 1] - output mismatch (see 132.out.ba=
d)
>   152         [failed, exit status 1] - output mismatch (see 152.out.ba=
d)
>=20
>   Failures: 045 132 152
>=20
> Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> ---
>  tests/docker/docker.py        | 5 +----
>  tests/image-fuzzer/runner.py  | 6 +++---
>  tests/qemu-iotests/iotests.py | 5 +++--
>  3 files changed, 7 insertions(+), 9 deletions(-)
>=20
> diff --git a/tests/docker/docker.py b/tests/docker/docker.py
> index 69e7130db7..9d53b868db 100755
> --- a/tests/docker/docker.py
> +++ b/tests/docker/docker.py
> @@ -26,10 +26,7 @@ import tempfile
>  import re
>  import signal
>  from tarfile import TarFile, TarInfo
> -try:
> -    from StringIO import StringIO
> -except ImportError:
> -    from io import StringIO
> +from io import StringIO

This one should be BytesIO, see:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg545627.html


>  from shutil import copy, rmtree
>  from pwd import getpwuid
>  from datetime import datetime,timedelta
> diff --git a/tests/image-fuzzer/runner.py b/tests/image-fuzzer/runner.p=
y
> index 95d84f38f3..4462d84f45 100755
> --- a/tests/image-fuzzer/runner.py
> +++ b/tests/image-fuzzer/runner.py
> @@ -28,7 +28,7 @@ import shutil
>  from itertools import count
>  import time
>  import getopt
> -import StringIO
> +from io import StringIO
>  import resource
> =20
>  try:
> @@ -183,7 +183,7 @@ class TestEnv(object):
>                                             MAX_BACKING_FILE_SIZE) * (1=
 << 20)
>          cmd =3D self.qemu_img + ['create', '-f', backing_file_fmt,
>                                 backing_file_name, str(backing_file_siz=
e)]
> -        temp_log =3D StringIO.StringIO()
> +        temp_log =3D StringIO()
>          retcode =3D run_app(temp_log, cmd)

I wouldn't touch this until we're sure if temp_log needs to be a
binary file or a text file.


>          if retcode =3D=3D 0:
>              temp_log.close()
> @@ -240,7 +240,7 @@ class TestEnv(object):
>                             "Backing file: %s\n" \
>                             % (self.seed, " ".join(current_cmd),
>                                self.current_dir, backing_file_name)
> -            temp_log =3D StringIO.StringIO()
> +            temp_log =3D StringIO()
>              try:
>                  retcode =3D run_app(temp_log, current_cmd)
>              except OSError as e:
> diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests=
.py
> index 4e67fbbe96..c95dd17190 100644
> --- a/tests/qemu-iotests/iotests.py
> +++ b/tests/qemu-iotests/iotests.py
> @@ -679,13 +679,14 @@ def main(supported_fmts=3D[], supported_oses=3D['=
linux'], supported_cache_modes=3D[],
> =20
>      # We need to filter out the time taken from the output so that qem=
u-iotest
>      # can reliably diff the results against master output.
> -    import StringIO
> +    from io import StringIO
> +

This one looks correct.


>      if debug:
>          output =3D sys.stdout
>          verbosity =3D 2
>          sys.argv.remove('-d')
>      else:
> -        output =3D StringIO.StringIO()
> +        output =3D StringIO()
> =20
>      logging.basicConfig(level=3D(logging.DEBUG if debug else logging.W=
ARN))
> =20
> --=20
> 2.18.0
>=20

--=20
Eduardo
