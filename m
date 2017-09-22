Received: from eggs.gnu.org ([2001:4830:134:3::10]:53696)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dvETV-0000X8-K3
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 23:18:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dvETR-0001jy-5e
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 23:17:57 -0400
Received: from mail-qk0-x22f.google.com ([2607:f8b0:400d:c09::22f]:47239)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dvETR-0001hL-0t
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 23:17:53 -0400
Received: by mail-qk0-x22f.google.com with SMTP id b82so7644712qkc.4
	for <qemu-devel@nongnu.org>; Thu, 21 Sep 2017 20:17:51 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170921150755.19914-1-famz@redhat.com>
	<20170921150755.19914-8-famz@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <2ea507f1-3ff3-54e9-2fbf-d69c727de5c6@amsat.org>
Date: Fri, 22 Sep 2017 00:17:40 -0300
MIME-Version: 1.0
In-Reply-To: <20170921150755.19914-8-famz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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

Hi Fam,

On 09/21/2017 12:07 PM, Fam Zheng wrote:
> The image is prepared following instructions as in:
> 
> https://wiki.qemu.org/Hosts/BSD
> 
> Signed-off-by: Fam Zheng <famz@redhat.com>
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

I'd rather see this part common to 3 images refactored as @static 
BaseVM.download_and_extract_image() and some logging:

         logging.debug("Extracting %s...", fname)

> +        subprocess.check_call(["xz", "-df", img_tmp_xz])

else one wonder what's happening here.

(for another patch on top on this series)

> +        if os.path.exists(img):
> +            os.remove(img)
> +        os.rename(img_tmp, img)
> +
> +if __name__ == "__main__":
> +    sys.exit(basevm.main(FreeBSDVM))
> 
