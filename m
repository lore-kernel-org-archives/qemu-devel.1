Received: from eggs.gnu.org ([209.51.188.92]:50844)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gxDnr-000321-CL
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 11:36:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gxDnq-0002eV-3u
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 11:35:59 -0500
Received: from indium.canonical.com ([91.189.90.7]:46034)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gxDnp-00024d-Qz
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 11:35:58 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gxDnQ-0008Fn-Bk
	for <qemu-devel@nongnu.org>; Fri, 22 Feb 2019 16:35:32 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 576ED2E80C7
	for <qemu-devel@nongnu.org>; Fri, 22 Feb 2019 16:35:32 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 22 Feb 2019 16:26:24 -0000
From: Antonio Ospite <1817345@bugs.launchpad.net>
Reply-To: Bug 1817345 <1817345@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <155085278488.30597.14551761138419562879.malonedeb@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1817345] [NEW] configure script breaks when
 $source_path contains white spaces
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Public bug reported:

Hi,

I noticed that the configure script breaks when the qemu source
directory is in a path containing white spaces, in particular the list
of targets is not correctly generated when calling "./configure --help".

Steps to reproduce the problem:

$ mkdir "dir with spaces"
$ cd dir\ with\ spaces/
$ git clone https://git.qemu.org/git/qemu.git
$ cd qemu/
$ ./configure --help | grep -A3 target-list


Actual result:

  --target-list=3DLIST       set target list (default: build everything)
                           Available targets: dir with *-softmmu dir with =

                           *-linux-user


Expected result:

  --target-list=3DLIST       set target list (default: build everything)
                           Available targets: aarch64-softmmu alpha-softmmu =

                           arm-softmmu cris-softmmu hppa-softmmu i386-softm=
mu =

                           lm32-softmmu m68k-softmmu microblaze-softmmu =



This happens because the $mak_wilds variable uses spaces to separate differ=
ent paths, maybe newlines may be used, which are less likely to be in direc=
tory names.

BTW "shellcheck" may help finding some other problems.

Qemu version:

$ git describe =

v3.1.0-1960-ga05838cb2a

Thanks,
   Antonio

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1817345

Title:
  configure script breaks when $source_path contains white spaces

Status in QEMU:
  New

Bug description:
  Hi,

  I noticed that the configure script breaks when the qemu source
  directory is in a path containing white spaces, in particular the list
  of targets is not correctly generated when calling "./configure
  --help".

  Steps to reproduce the problem:

  $ mkdir "dir with spaces"
  $ cd dir\ with\ spaces/
  $ git clone https://git.qemu.org/git/qemu.git
  $ cd qemu/
  $ ./configure --help | grep -A3 target-list

  =

  Actual result:

    --target-list=3DLIST       set target list (default: build everything)
                             Available targets: dir with *-softmmu dir with =

                             *-linux-user

  =

  Expected result:

    --target-list=3DLIST       set target list (default: build everything)
                             Available targets: aarch64-softmmu alpha-softm=
mu =

                             arm-softmmu cris-softmmu hppa-softmmu i386-sof=
tmmu =

                             lm32-softmmu m68k-softmmu microblaze-softmmu =


  =

  This happens because the $mak_wilds variable uses spaces to separate diff=
erent paths, maybe newlines may be used, which are less likely to be in dir=
ectory names.

  BTW "shellcheck" may help finding some other problems.

  Qemu version:

  $ git describe =

  v3.1.0-1960-ga05838cb2a

  Thanks,
     Antonio

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1817345/+subscriptions
