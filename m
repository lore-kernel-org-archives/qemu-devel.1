Received: from eggs.gnu.org ([2001:4830:134:3::10]:59611)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fSKbr-0002d6-Hj
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 07:03:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fSKbn-0001Ak-FL
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 07:03:39 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49172 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fSKbn-00019g-8k
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 07:03:35 -0400
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Mon, 11 Jun 2018 12:03:27 +0100
Message-Id: <20180611110327.21218-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] DO NOT APPLY - demo broken unnest-vars with
 clashing .o filenames
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Fam Zheng <famz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>

In a sub-directory source files may be conditionally built using a
Makefile.objs line such as

    crypto-obj-$(CONFIG_CTHULHU) =3D foo.o

It is also possible to add custom linker flags for when this
foo.o is later linked into a binary

    foo.o-libs =3D -lcthulhu

When the unqualfied 'foo.o' filename matches the name of an object in
another directory, however, it appears the linker flags leak out and
affect the linking of the foo.o from the other directory.

This patch demos the bug by adding a crypto/piix.o file. It should have
no effect because CONFIG_CTHULHU is not defined, however, the existence
of hw/pci-host/piix.o and hw/ide/piix.o in fact causes '-lcthulhu' to be
added to the link line twice, causing build failure:

$ make
  LINK    x86_64-softmmu/qemu-system-x86_64
/usr/bin/ld: cannot find -lcthuhlu
/usr/bin/ld: cannot find -lcthuhlu
collect2: error: ld returned 1 exit status
make[1]: *** [Makefile:193: qemu-system-x86_64] Error 1
make: *** [Makefile:482: subdir-x86_64-softmmu] Error 2

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 crypto/Makefile.objs | 4 ++++
 crypto/piix.c        | 2 ++
 2 files changed, 6 insertions(+)
 create mode 100644 crypto/piix.c

diff --git a/crypto/Makefile.objs b/crypto/Makefile.objs
index 2b99e08062..73b4548f12 100644
--- a/crypto/Makefile.objs
+++ b/crypto/Makefile.objs
@@ -38,3 +38,7 @@ crypto-obj-y +=3D block-luks.o
 crypto-aes-obj-y =3D aes.o
=20
 stub-obj-y +=3D pbkdf-stub.o
+
+
+crypto-obj-$(CONFIG_CTHUHLU) +=3D piix.o
+piix.o-libs =3D -lcthuhlu
diff --git a/crypto/piix.c b/crypto/piix.c
new file mode 100644
index 0000000000..367683f7bb
--- /dev/null
+++ b/crypto/piix.c
@@ -0,0 +1,2 @@
+
+random garbage as this ".c" file will never be built
--=20
2.17.0
