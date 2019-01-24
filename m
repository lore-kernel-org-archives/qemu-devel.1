Received: from eggs.gnu.org ([209.51.188.92]:39011)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gmhIs-0001HA-9Q
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 10:52:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gmhIq-0001Jp-3N
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 10:52:30 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42652)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gmhIo-0001C3-2P
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 10:52:27 -0500
Received: by mail-wr1-f66.google.com with SMTP id q18so6993882wrx.9
	for <qemu-devel@nongnu.org>; Thu, 24 Jan 2019 07:52:16 -0800 (PST)
References: <20170816072104.24420-1-famz@redhat.com>
	<20170816072104.24420-9-famz@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <ed7262b4-f84e-1405-dbe6-1ea5f11e73f1@redhat.com>
Date: Thu, 24 Jan 2019 16:52:14 +0100
MIME-Version: 1.0
In-Reply-To: <20170816072104.24420-9-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC 8/9] tests: Add OpenBSD image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <fam@euphon.net>, qemu-devel@nongnu.org, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Brad Smith <brad@comstyle.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: berrange@redhat.com, stefanha@redhat.com, pbonzini@redhat.com, Kamil Rytarowski <kamil@netbsd.org>

On 8/16/17 9:21 AM, Fam Zheng wrote:
> The image is prepared following instructions as in:
> 
> https://wiki.qemu.org/Hosts/BSD
> 
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  tests/vm/openbsd | 45 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
>  create mode 100755 tests/vm/openbsd
> 
> diff --git a/tests/vm/openbsd b/tests/vm/openbsd
> new file mode 100755
> index 0000000000..d37ff83a59
> --- /dev/null
> +++ b/tests/vm/openbsd
> @@ -0,0 +1,45 @@
> +#!/usr/bin/env python
> +#
> +# OpenBSD VM image
> +#
> +# Copyright (C) 2017 Red Hat Inc.
> +#
> +# Authors:
> +#  Fam Zheng <famz@redhat.com>
> +#
> +# This work is licensed under the terms of the GNU GPL, version 2.  See
> +# the COPYING file in the top-level directory.
> +#
> +
> +import os
> +import sys
> +import logging
> +import subprocess
> +import tempfile
> +import time
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

OK, Now it makes more sense...

After spending various hours trying to fix various issues on OpenBSD, I
notice that we never ran tests on this OS.
The only binary I can run is qemu-img, the rest seems useless.
I'll summarize in a different thread.

> +    """
> +
> +    def build_image(self, img, rebuild=False):
> +        if os.path.exists(img) and not rebuild:
> +            return
> +        cimg = self._download_with_cache("http://download.patchew.org/openbsd.img.xz")
> +        img_tmp_xz = img + ".tmp.xz"
> +        img_tmp = img + ".tmp"
> +        subprocess.check_call(["cp", "-f", cimg, img_tmp_xz])
> +        subprocess.check_call(["xz", "-df", img_tmp_xz])
> +        subprocess.check_call(["mv", img_tmp, img])
> +
> +if __name__ == "__main__":
> +    sys.exit(basevm.main(OpenBSDVM))
> 
