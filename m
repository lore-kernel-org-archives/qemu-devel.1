Received: from eggs.gnu.org ([2001:4830:134:3::10]:57034)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fYHRn-0004HV-22
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 16:53:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fYHRj-0003dU-PG
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 16:53:51 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:57436)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fYHRj-0003aW-FZ
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 16:53:47 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Wed, 27 Jun 2018 22:53:14 +0200
Message-Id: <20180627205317.10343-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH 0/3] linux-user: manage binfmt F flag
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>

The binfmt F flag ("Fix binaries") allows to
load the interpreter binary at configuration time
and all future users are cloned from this memory copy.

This avoids to have to copy the interpreter to
the filesystem of the target we want to use.

This series introduces this new flag in qemu-binfmt-conf.sh
and another new parameter to provide a suffix to the default
qemu-CPU name to be able to use static version of qemu linux-user
provided by distros:

  qemu-binfmt-conf.sh --qemu-path /usr/bin --qemu-suffix -static \
                      --systemd m68k --credential yes --persistent yes

configures binfmt to use /usr/bin/qemu-m68k-static from the root filesystem
to interpret m68k binaries in unmodified chroots or containers/dockers.

With systemd, the interpreter is loaded when you restart the systemd-binfmt
service:

  systemctl restart systemd-binfmt.service

With that, you can execute directly a debootstrap without the --foreign
parameter.

  debootstrap --arch=m68k --variant=minbase \
              --no-check-gpg etch-m68k chroot-m68k \
              http://archive.debian.org/debian
  chroot chroot-m68k
  localhost:/# ls
  bin   dev  home    lib    mnt  proc  sbin  sys   usr
  boot  etc  initrd  media  opt  root  srv   tmp   var

Laurent Vivier (3):
  qemu-binfmt-conf.sh: cleanup --credential
  qemu-binfmt-conf.sh: add persistent (F) flags
  qemu-binfmt-conf.sh: allow to provide a suffix to the interpreter name

 scripts/qemu-binfmt-conf.sh | 64 +++++++++++++++++++++++++++++----------------
 1 file changed, 41 insertions(+), 23 deletions(-)

-- 
2.14.4
