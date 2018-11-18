Received: from eggs.gnu.org ([2001:4830:134:3::10]:36419)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gOTl1-0005Qw-TR
	for qemu-devel@nongnu.org; Sun, 18 Nov 2018 15:33:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gOTky-0000eu-PL
	for qemu-devel@nongnu.org; Sun, 18 Nov 2018 15:33:27 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:34457)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gOTky-0000eD-HM
	for qemu-devel@nongnu.org; Sun, 18 Nov 2018 15:33:24 -0500
Received: by mail-wr1-x441.google.com with SMTP id j2so1498774wrw.1
	for <qemu-devel@nongnu.org>; Sun, 18 Nov 2018 12:33:24 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Sun, 18 Nov 2018 21:33:10 +0100
Message-Id: <20181118203312.5376-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 0/2] docker: Add gentoo-mipsr5900el-cross
 image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fredrik Noring <noring@nocrew.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Mike Frysinger <vapier@gentoo.org>

Hi,

The first patch adds a cross toolchain for the R5900 MIPS.
It is working correctly but the patches provided by Fredrik in [1] don't
have proper S-o-b, thus it is tagged RFC.
Fredrik: any update on the status of those patches upstream?
I setup this image to try Fredrik's TCG tests in [2].

The second patch intents to have Shippable CI build the image and run the
TCG tests.
Since current idea of the Shippable tests is to cross-build QEMU for the
target, it does not work (and makes sense) here. I don't think there is
interest in running cross-compiled QEMU on a PS2... But we never know ;)
The failure I have is pkg-config using an incorrect path. I suppose I
am not using the CROSSDEV_OVERLAY path correctly.
Help from Gentoo developers would be appreciated!

I run the tests using:

$ docker-image-gentoo-mipsr5900el-cross
$ docker run --rm -it -v $PWD:$PWD \
    -w $PWD/tests/tcg/mips/mipsr5900 qemu:gentoo-mipsr5900el-cross \
    make all
$ make -C $PWD/tests/tcg/mips/mipsr5900 \
    check \
    SIM=$PWD/build/mipsel-softmmu/qemu-system-mipsel

With this minor modification:
-- >8 --
diff --git a/tests/tcg/mips/mipsr5900/Makefile b/tests/tcg/mips/mipsr5900/Makefile
@@ -5 +5 @@ CROSS=mipsr5900el-unknown-linux-gnu-
-SIM=qemu-mipsel
+SIM?=qemu-mipsel
---

Regards,

Phil.

[1]  https://lists.gnu.org/archive/html/qemu-devel/2018-09/msg03944.html
[2] https://lists.gnu.org/archive/html/qemu-devel/2018-11/msg01284.html

Philippe Mathieu-Daudé (2):
  docker: Add gentoo-mipsr5900el-cross image
  shippable: Add the mipsr5900el linux-user target

 .shippable.yml                                |   2 +
 tests/docker/Makefile.include                 |   6 +
 .../gentoo-mipsr5900el-cross.docker           |  42 ++++
 .../binutils-v2.30-ps2-llsc.patch             |  36 +++
 .../crossdev.conf                             |   5 +
 .../gcc-v7.2.0-ps2-llsc.patch                 |  23 ++
 .../gcc-v7.2.0-ps2.patch                      | 219 ++++++++++++++++++
 7 files changed, 333 insertions(+)
 create mode 100644 tests/docker/dockerfiles/gentoo-mipsr5900el-cross.docker
 create mode 100644 tests/docker/dockerfiles/gentoo-mipsr5900el-cross.docker.d/binutils-v2.30-ps2-llsc.patch
 create mode 100644 tests/docker/dockerfiles/gentoo-mipsr5900el-cross.docker.d/crossdev.conf
 create mode 100644 tests/docker/dockerfiles/gentoo-mipsr5900el-cross.docker.d/gcc-v7.2.0-ps2-llsc.patch
 create mode 100644 tests/docker/dockerfiles/gentoo-mipsr5900el-cross.docker.d/gcc-v7.2.0-ps2.patch

-- 
2.17.2
