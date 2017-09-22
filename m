Received: from eggs.gnu.org ([2001:4830:134:3::10]:48901)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dvH9c-0004nI-C7
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 02:09:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dvH9Y-0007Q1-5g
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 02:09:36 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:33586)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dvH9Y-0007Pv-0Z
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 02:09:32 -0400
Received: by mail-qt0-x243.google.com with SMTP id b1so97291qtc.0
	for <qemu-devel@nongnu.org>; Thu, 21 Sep 2017 23:09:32 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170921150755.19914-1-famz@redhat.com>
	<20170921150755.19914-8-famz@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <49d5d158-9103-d14d-8ce6-35196754aafb@amsat.org>
Date: Fri, 22 Sep 2017 03:09:26 -0300
MIME-Version: 1.0
In-Reply-To: <20170921150755.19914-8-famz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v11 07/13] tests: Add FreeBSD image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>, stefanha@redhat.com, Cleber Rosa <crosa@redhat.com>, pbonzini@redhat.com, eblake@redhat.com, Kamil Rytarowski <kamil@netbsd.org>

On 09/21/2017 12:07 PM, Fam Zheng wrote:
> The image is prepared following instructions as in:
> 
> https://wiki.qemu.org/Hosts/BSD
> 
> Signed-off-by: Fam Zheng <famz@redhat.com>

$ QEMU=`pwd`/x86_64-softmmu/qemu-system-x86_64 make vm-build-freebsd V=1
[...]
   CC      tests/test-io-channel-socket.o
   CC      tests/io-channel-helpers.o
   LINK    tests/test-io-channel-socket

the build hang here, stopping to use the cpu, keeping 2GB of resident 
physical memory until I hit ^C ... not enough ram for the guest? guest 
tmpfs full?

useful enough for:
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>   tests/vm/freebsd | 42 ++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 42 insertions(+)
>   create mode 100755 tests/vm/freebsd
> 
> diff --git a/tests/vm/freebsd b/tests/vm/freebsd
> new file mode 100755
> index 0000000000..039dad8f69
> --- /dev/null
> +++ b/tests/vm/freebsd
> @@ -0,0 +1,42 @@
> +#!/usr/bin/env python
> +#
> +# FreeBSD VM image
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
> +class FreeBSDVM(basevm.BaseVM):
> +    name = "freebsd"
> +    BUILD_SCRIPT = """
> +        set -e;
> +        cd $(mktemp -d /var/tmp/qemu-test.XXXXXX);
> +        tar -xf /dev/vtbd1;
> +        ./configure {configure_opts};
> +        gmake -j{jobs};
> +        gmake check;
> +    """
> +
> +    def build_image(self, img):
> +        cimg = self._download_with_cache("http://download.patchew.org/freebsd-11.1-amd64.img.xz",
> +                sha256sum='adcb771549b37bc63826c501f05121a206ed3d9f55f49145908f7e1432d65891')
> +        img_tmp_xz = img + ".tmp.xz"
> +        img_tmp = img + ".tmp"
> +        subprocess.check_call(["cp", "-f", cimg, img_tmp_xz])
> +        subprocess.check_call(["xz", "-df", img_tmp_xz])
> +        if os.path.exists(img):
> +            os.remove(img)
> +        os.rename(img_tmp, img)
> +
> +if __name__ == "__main__":
> +    sys.exit(basevm.main(FreeBSDVM))
> 
