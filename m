Received: from eggs.gnu.org ([2001:4830:134:3::10]:52110)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dvMxv-0000ZZ-I6
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 08:21:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dvMxs-0007S0-Cc
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 08:21:55 -0400
Received: from mail-qk0-x233.google.com ([2607:f8b0:400d:c09::233]:50854)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dvMxs-0007Rs-8C
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 08:21:52 -0400
Received: by mail-qk0-x233.google.com with SMTP id s132so815308qke.7
	for <qemu-devel@nongnu.org>; Fri, 22 Sep 2017 05:21:52 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170921150755.19914-1-famz@redhat.com>
	<20170921150755.19914-10-famz@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <115f9317-ac34-03f9-fb86-8af85124cabc@amsat.org>
Date: Fri, 22 Sep 2017 09:21:47 -0300
MIME-Version: 1.0
In-Reply-To: <20170921150755.19914-10-famz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v11 09/13] tests: Add OpenBSD image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>
Cc: berrange@redhat.com, stefanha@redhat.com, Cleber Rosa <crosa@redhat.com>, pbonzini@redhat.com, eblake@redhat.com, Kamil Rytarowski <kamil@netbsd.org>

Alex, Peter,

JTLYK I just finished to test this one too (which was merged in the 
meaning time).

On 09/21/2017 12:07 PM, Fam Zheng wrote:
> The image is prepared following instructions as in:
> 
> https://wiki.qemu.org/Hosts/BSD
> 
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>   tests/vm/openbsd | 43 +++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 43 insertions(+)
>   create mode 100755 tests/vm/openbsd
> 
> diff --git a/tests/vm/openbsd b/tests/vm/openbsd
> new file mode 100755
> index 0000000000..6ae16d97fd
> --- /dev/null
> +++ b/tests/vm/openbsd
> @@ -0,0 +1,43 @@
> +#!/usr/bin/env python
> +#
> +# OpenBSD VM image
> +#
> +# Copyright 2017 Red Hat Inc.
> +#
> +# Authors:
> +#  Fam Zheng <famz@redhat.com>
> +#
> +# This code is licensed under the GPL version 2 or later.  See
> +# the COPYING file in the top-level directory.
> +#
> +
> +import os
> +import sys
> +import subprocess
> +import basevm
> +
> +class OpenBSDVM(basevm.BaseVM):
> +    name = "openbsd"
> +    BUILD_SCRIPT = """
> +        set -e;
> +        cd $(mktemp -d /var/tmp/qemu-test.XXXXXX);
> +        tar -xf /dev/rsd1c;
> +        ./configure --cc=x86_64-unknown-openbsd6.1-gcc-4.9.4 --python=python2.7 {configure_opts};
> +        gmake -j{jobs};
> +        # XXX: "gmake check" seems to always hang or fail
> +        #gmake check;
> +    """
> +
> +    def build_image(self, img):
> +        cimg = self._download_with_cache("http://download.patchew.org/openbsd-6.1-amd64.img.xz",
> +                sha256sum='8c6cedc483e602cfee5e04f0406c64eb99138495e8ca580bc0293bcf0640c1bf')
> +        img_tmp_xz = img + ".tmp.xz"
> +        img_tmp = img + ".tmp"
> +        subprocess.check_call(["cp", "-f", cimg, img_tmp_xz])
> +        subprocess.check_call(["xz", "-df", img_tmp_xz])
> +        if os.path.exists(img):
> +            os.remove(img)
> +        os.rename(img_tmp, img)
> +
> +if __name__ == "__main__":
> +    sys.exit(basevm.main(OpenBSDVM))
> 
