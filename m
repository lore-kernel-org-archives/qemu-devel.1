Received: from eggs.gnu.org ([2001:4830:134:3::10]:42065)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1daU2b-0004oi-57
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 17:40:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1daU2W-0006YF-6M
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 17:40:25 -0400
Received: from mail-ua0-x229.google.com ([2607:f8b0:400c:c08::229]:38883)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1daU2W-0006Xx-0j
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 17:40:20 -0400
Received: by mail-ua0-x229.google.com with SMTP id w45so127043666uac.5
	for <qemu-devel@nongnu.org>; Wed, 26 Jul 2017 14:40:19 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed, 26 Jul 2017 18:40:06 -0300
Message-Id: <20170726214010.420-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH for 2.10 0/4] check dtc submodule is outdated
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Arbuckle <programmingkidx@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Yongbok Kim <yongbok.kim@imgtec.com>, James Hogan <james.hogan@imgtec.com>, Aurelien Jarno <aurelien@aurel32.net>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org

On http://lists.nongnu.org/archive/html/qemu-devel/2017-07/msg07987.html John
hit the following error:

hw/core/loader-fit.c:105:41: error: expected expression
        *addr = fdt32_to_cpu(*(fdt32_t *)prop);
                                        ^
having his ./configure --target-list=mips64el-softmmu on OSX returning:
fdt support       yes

It seems his dtc submodule was out of date but the ./configure did not emit
warning. I could reproduce checking out dtc tag v1.4.1.

patch 1: if you are out of the source directory "git submodule" fails, try to
improve the warning remembering the user to run this command in source/.

patch 2: a check exists to warn --disable-fdt --target-list=mips64el-softmmu
is invalid. move the warning to also warn AFTER checking if libfdt is
available and sane.

patch 3: fdt_first_subnode() is available since v1.4.0 while we are requiring
v1.4.2, better check a v1.4.2 function such as:
fdt_setprop_inplace_namelen_partial()

patch 4: if no system libdtc and submodule present, compile the dtc submodule
and verify it is at least v1.4.2. Prefixed RFC because I'm not sure about
these 3 lines:

+    make -C dtc 1>/dev/null

yes, we need to build the libdtc to be able to run the compile_prog link step

+    fdt_cflags="-I${source_path}/dtc/libfdt"

$source_path seems ok...

+    fdt_libs="-L$(pwd)/dtc/libfdt $fdt_libs"

maybe there is a better option than `pwd`

how to reproduce:

((v2.10.0-rc0))$ (cd dtc && git checkout v1.3.0)
((v2.10.0-rc0))$ ./configure --target-list=mips64el-softmmu --extra-cflags=-fmax-errors=1 | fgrep fdt
fdt support       yes
((v2.10.0-rc0))$ make hw/core/loader-fit.o
hw/core/loader-fit.c: In function ‘fit_image_addr’:
hw/core/loader-fit.c:105:32: error: ‘fdt32_t’ undeclared (first use in this function)
         *addr = fdt32_to_cpu(*(fdt32_t *)prop);
                                ^~~~~~~
compilation terminated due to -fmax-errors=1.
rules.mak:66: recipe for target 'hw/core/loader-fit.o' failed

(dtc-fix)$ mkdir test && cd test
(dtc-fix)$ ../configure --target-list=mips64el-softmmu --extra-cflags=-fmax-errors=1
ERROR: Your DTC submodule is outdated. Your options:
         (1) Preferred: Install the DTC (libfdt) devel package
         (2) Update the DTC submodule, using: (in /home/phil/source/qemu)
             git submodule update --init dtc

Regards,

Phil.

Philippe Mathieu-Daudé (4):
  configure: remember the user to run 'git submodule' command in source dir
  fdt: check fdt_required condition can be satisfied _after_ testing libfdt
  fdt: probe for v1.4.2 using fdt_setprop_inplace_namelen_partial()
  fdt: compile dtc submodule to check it is up-to-date

 configure | 52 +++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 35 insertions(+), 17 deletions(-)

-- 
2.13.3
