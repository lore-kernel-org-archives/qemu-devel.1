Received: from eggs.gnu.org ([2001:4830:134:3::10]:38631)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dmfL2-0008Kh-PB
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 08:09:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dmfKw-0002AW-Qj
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 08:09:48 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:36797)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dmfKw-00029x-Kr
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 08:09:42 -0400
Received: by mail-qk0-x242.google.com with SMTP id l65so2651280qkc.3
	for <qemu-devel@nongnu.org>; Tue, 29 Aug 2017 05:09:42 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170828174707.20786-1-famz@redhat.com>
	<20170828174707.20786-7-famz@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <518b29b0-654d-f438-7b18-0419987ba442@amsat.org>
Date: Tue, 29 Aug 2017 09:09:37 -0300
MIME-Version: 1.0
In-Reply-To: <20170828174707.20786-7-famz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 06/10] tests: Add NetBSD image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, pbonzini@redhat.com, stefanha@redhat.com, Cleber Rosa <crosa@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, eblake@redhat.com, Kamil Rytarowski <kamil@netbsd.org>

On 08/28/2017 02:47 PM, Fam Zheng wrote:
> The image is prepared following instructions as in:
> 
> https://wiki.qemu.org/Hosts/BSD
> 
> Signed-off-by: Fam Zheng <famz@redhat.com>
> Reviewed-by: Kamil Rytarowski <n54@gmx.com>
> ---
>   tests/vm/netbsd | 42 ++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 42 insertions(+)
>   create mode 100755 tests/vm/netbsd
> 
> diff --git a/tests/vm/netbsd b/tests/vm/netbsd
> new file mode 100755
> index 0000000000..559e89c8a6
> --- /dev/null
> +++ b/tests/vm/netbsd
> @@ -0,0 +1,42 @@
> +#!/usr/bin/env python
> +#
> +# NetBSD VM image
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
> +import subprocess
> +import basevm
> +
> +class NetBSDVM(basevm.BaseVM):
> +    name = "netbsd"
> +    BUILD_SCRIPT = """
> +        set -e;
> +        cd $(mktemp -d /var/tmp/qemu-test.XXXXXX);
> +        tar -xf /dev/rld1a;
> +        ./configure --python=python2.7 {configure_opts};
> +        gmake -j{jobs};
> +        gmake check;
> +    """
> +
> +    def build_image(self, img):
> +        cimg = self._download_with_cache("http://download.patchew.org/netbsd-7.1-amd64.img.xz",
> +                                         sha256sum='b633d565b0eac3d02015cd0c81440bd8a7a8df8512615ac1ee05d318be015732')
> +        img_tmp_xz = img + ".tmp.xz"
> +        img_tmp = img + ".tmp"
> +        subprocess.check_call(["cp", "-f", cimg, img_tmp_xz])
> +        subprocess.check_call(["xz", "-df", img_tmp_xz])
> +        if os.path.exists(img):
> +            os.remove(img)
> +        os.rename(img_tmp, img)
> +
> +if __name__ == "__main__":
> +    sys.exit(basevm.main(NetBSDVM))

This one is failing:

DEBUG:root:ssh_cmd: ssh -q -o StrictHostKeyChecking=no -o 
UserKnownHostsFile=/dev/null -o ConnectTimeout=1 -p 34091 -i 
/tmp/qemu-vm-59XYOj/id_rsa qemu@127.0.0.1
         set -e;
         cd $(mktemp -d /var/tmp/qemu-test.XXXXXX);
         tar -xf /dev/rld1a;
         ./configure --python=python2.7 ;
         gmake -j4;
         gmake check;

...
   CC      bt-host.o
   CC      bt-vhci.o
   CC      dma-helpers.o
   CC      vl.o
   CC      tpm.o
In file included from vl.c:72:0:
/var/tmp/qemu-test.ht0XHU/include/hw/loader.h:4:29: fatal error: 
hw/nvram/fw_cfg.h: No such file or directory
  #include "hw/nvram/fw_cfg.h"
                              ^
compilation terminated.
/var/tmp/qemu-test.ht0XHU/rules.mak:66: recipe for target 'vl.o' failed
gmake: *** [vl.o] Error 1
gmake: *** Waiting for unfinished jobs....
tests/vm/Makefile.include:32: recipe for target 'vm-build-netbsd' failed
make: *** [vm-build-netbsd] Error 3
