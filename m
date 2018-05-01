Received: from eggs.gnu.org ([2001:4830:134:3::10]:47127)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1fDce4-00013E-A2
	for qemu-devel@nongnu.org; Tue, 01 May 2018 17:17:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1fDce1-00032k-Lx
	for qemu-devel@nongnu.org; Tue, 01 May 2018 17:17:08 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51510 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1fDce1-00032P-FN
	for qemu-devel@nongnu.org; Tue, 01 May 2018 17:17:05 -0400
References: <20180419164642.9536-1-f4bug@amsat.org>
	<20180419164642.9536-7-f4bug@amsat.org>
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <cc3dbc73-750b-cf8e-9df6-63ab6ab9fc44@redhat.com>
Date: Tue, 1 May 2018 17:17:04 -0400
MIME-Version: 1.0
In-Reply-To: <20180419164642.9536-7-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 6/7] avocado: Add a test parsing Linux
 kernel booting console
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>, Amador Pahim <apahim@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, Zheng Xiang <xiang.zheng@linaro.org>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, Alistair Francis <alistair23@gmail.com>, Richard Henderson <rth@twiddle.net>



On 04/19/2018 12:46 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> Booting an Alpha DP264 machine.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  tests/avocado/test_linux-boot-console.py      | 88 +++++++++++++++++++
>  .../parameters.yaml                           |  3 +
>  2 files changed, 91 insertions(+)
>  create mode 100644 tests/avocado/test_linux-boot-console.py
>  create mode 100644 tests/avocado/test_linux-boot-console.py.data/param=
eters.yaml
>=20
> diff --git a/tests/avocado/test_linux-boot-console.py b/tests/avocado/t=
est_linux-boot-console.py
> new file mode 100644
> index 0000000000..f54d10dd79
> --- /dev/null
> +++ b/tests/avocado/test_linux-boot-console.py
> @@ -0,0 +1,88 @@
> +# -*- coding: utf-8 -*-
> +#
> +# Boot a Linux kernel on the Malta board and check the serial console =
output
> +#
> +# Copyright (C) 2018 Philippe Mathieu-Daud=C3=A9
> +#
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +#
> +# Run with:
> +#
> +#   avocado run test_linux-boot-console.py \
> +#     --mux-yaml test_linux-boot-console.py.data/parameters.yaml
> +#     [--filter-by-tags arch_alpha ...]
> +
> +import os
> +import tempfile
> +import hashlib
> +import urllib2
> +import gzip
> +import shutil
> +
> +from avocado import skipUnless
> +from avocado_qemu import test
> +
> +# XXX Use a cleaner CacheStorage or avocado.utils.[archive|kernel]?
> +def cachedfile(url, cachedir=3D'/tmp/mycachedir', gzip_compressed=3DFa=
lse):
> +    if not os.path.isdir(cachedir):
> +        os.mkdir(cachedir)
> +    key =3D hashlib.md5(url).hexdigest()
> +    fbin =3D cachedir + "/" + key + ".bin"
> +    if not os.path.isfile(fbin):
> +        with open(cachedir + "/" + key + ".url", "w") as f:
> +            f.write(url + '\n')
> +        with open(fbin, "wb") as f:
> +            content =3D urllib2.urlopen(url).read()
> +            f.write(content)
> +        if gzip_compressed:
> +            fgz =3D cachedir + "/" + key + ".gz"
> +            shutil.move(fbin, fgz)
> +            with gzip.open(fgz, 'rb') as f_in, open(fbin, 'wb') as f_o=
ut:
> +                shutil.copyfileobj(f_in, f_out)
> +    return fbin
> +
> +

As pointed on my reply to PATCH 0, Avocado has a downloading/caching
system, but the "uncompress if needed" does not exist yet.  We're
tracking the implementation of such a utility function here:

https://trello.com/c/LQFOMPgV/1308-avocadoutilsarchive-add-uncompress-if-=
necessary


- Cleber.
