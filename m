Received: from eggs.gnu.org ([2001:4830:134:3::10]:44341)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cZmIY-0001gN-4p
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 17:25:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cZmIU-00089O-Lz
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 17:25:42 -0500
Received: from indium.canonical.com ([91.189.90.7]:43513)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cZmIU-00088o-DS
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 17:25:38 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cZmIS-0004yA-4q
	for <qemu-devel@nongnu.org>; Fri, 03 Feb 2017 22:25:36 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 1F6262E80C8
	for <qemu-devel@nongnu.org>; Fri,  3 Feb 2017 22:25:36 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Feb 2017 22:20:29 -0000
From: Jean-Paul Larocque <1661758@bugs.launchpad.net>
Reply-To: Bug 1661758 <1661758@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <20170203222029.20222.70658.malonedeb@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1661758] [NEW] qemu-nbd causes data corruption in
 VDI-format disk images
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

This is a duplicate of #1422307.  I can't figure out a way to re-open
it--the status of "Fix Released" is changeable only by a project
maintainer or bug supervisor--so I'm opening a new bug to make sure
this gets looked at again.

qemu-nbd will sometimes corrupt VDI disk images.  The bug was thought
to be fixed in commit f0ab6f109630940146cbaf47d0cd99993ddba824, but
I'm able to reproduce it in both that commit and in the latest commit
(a951316b8a5c3c63254f20a826afeed940dd4cba).  I just needed to run more
iterations of the test.  It's possible that it was partially fixed, or
that the added serialization made it harder to catch this
non-deterministic bug, but the same symptoms persist: data corruption
of VDI-format disk images.

This affects at least qemu-nbd.  I haven't tried reproducing the issue
with qemu proper or qemu-img, but the original bug report suggests
that the bug in the common VDI backend may corrupt data written by
those programs.

Please let me know if I can provide any further information or help
with testing.  Thank you very much for looking into this!

Test procedure
**************

The procedure used is the one given by Max Reitz (xanclic) in the
original bug report, comment 3
(https://bugs.launchpad.net/qemu/+bug/1422307/comments/3), in the
section "VDI and NBD over /dev/nbd0", but with up to 1000 iterations
instead of 10:

  $ cd ~/qemu-origfix-f0ab6f1/bin
  $ dd if=3D/dev/urandom of=3Dblob.raw bs=3D1M count=3D64
  64+0 records in
  64+0 records out
  67108864 bytes (67 MB) copied, 4.36475 s, 15.4 MB/s
  $ sudo sh -c 'for i in $(seq 0 999); do ./qemu-img create -f vdi test.vdi=
 64M > /dev/null; ./qemu-nbd -c /dev/nbd0 test.vdi; sleep 1; ./qemu-img con=
vert -n blob.raw /dev/nbd0; ./qemu-img convert /dev/nbd0 test1.raw; sync; e=
cho 1 > /proc/sys/vm/drop_caches; ./qemu-img convert /dev/nbd0 test2.raw; .=
/qemu-nbd -d /dev/nbd0 > /dev/null; if ! ./qemu-img compare -q test1.raw te=
st2.raw; then md5sum test1.raw test2.raw; echo "$i failed"; break; fi; done=
; echo "done"'
27a66c3a8ac2cf06f2c925968ea9e964  test1.raw
2da9bf169041a7c2bd144c4ab3a29aea  test2.raw
64 failed
done

I've run this process a handful of times, and I've seen it take as
little as 10 iterations and as many as 161 (taking 32 minutes in the
latter case).  Please be patient.  Putting the images on tmpfs will
probably help it go faster, and I have successfully reproduced the
issue on tmpfs in addition to ext4.

Nothing different was needed to reproduce the issue in a directory
containing a build of the latest commit.  It still takes somewhere
around 1-200 iterations to find, in my testing.

Build procedure
***************

  $ git clone git://git.qemu-project.org/qemu.git
  [omitted]
  $ git clone qemu qemu-origfix-f0ab6f1
  Cloning into 'qemu-origfix-f0ab6f1'...
  done.
  $ cd qemu-origfix-f0ab6f1
  $ git checkout f0ab6f109630940146cbaf47d0cd99993ddba824
  Note: checking out 'f0ab6f109630940146cbaf47d0cd99993ddba824'.
  =

  You are in 'detached HEAD' state. You can look around, make experimental
  changes and commit them, and you can discard any commits you make in this
  state without impacting any branches by performing another checkout.
  =

  If you want to create a new branch to retain commits you create, you may
  do so (now or later) by using -b with the checkout command again. Example:
  =

    git checkout -b new_branch_name
  =

  HEAD is now at f0ab6f1... block/vdi: Add locking for parallel requests
  $ mkdir bin
  $ cd bin
  $ script -c'time (../configure --enable-debug --target-list=3Dx86_64-soft=
mmu && make -j6; echo "result: $?")'
  Script started, file is typescript
  [omitted; the build typescript is attached separately]
    LINK  x86_64-softmmu/qemu-system-x86_64
  result: 0
  =

  real    1m5.733s
  user    2m3.904s
  sys     0m13.828s
  Script done, file is typescript

Nothing different was done when building the latest commit (besides
cloning to a different directory, and not running `git checkout`).

Environment
***********

  * Machine: x86_64
  =

  * Hypervisor: Xen 4.4 (Debian package xen-hypervisor-4.4-amd64,
    version 4.4.1-9+deb8u8)
  =

  * A Xen domU (guest) for building QEMU and reproducing the issue.
    All testing was done within the virtual machine for convenience
    and access to better hardware than what I have for my development
    machine (I expected the build to take much longer than it really
    does).
  =

      - x86_64 architecture with six VCPUs and 1.2 GiB RAM allocated,
        operating in HVM (fully virtualized) mode.
      =

      - Distribution: Debian 8.7 Jessie amd64
      =

      - Kernel: Linux 3.16.0 x86_64 (Debian package
        linux-image-3.16.0-4-amd64, version 3.16.39-1)
      =

      - Compiler: GCC 4.9.2 (Debian package gcc-4.9, version 4.9.2-10)

** Affects: qemu
     Importance: Undecided
         Status: New

** Attachment added: "Output of configure script and make"
   https://bugs.launchpad.net/bugs/1661758/+attachment/4812784/+files/build=
-typescript.txt

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1661758

Title:
  qemu-nbd causes data corruption in VDI-format disk images

Status in QEMU:
  New

Bug description:
  Hi,

  This is a duplicate of #1422307.  I can't figure out a way to re-open
  it--the status of "Fix Released" is changeable only by a project
  maintainer or bug supervisor--so I'm opening a new bug to make sure
  this gets looked at again.

  qemu-nbd will sometimes corrupt VDI disk images.  The bug was thought
  to be fixed in commit f0ab6f109630940146cbaf47d0cd99993ddba824, but
  I'm able to reproduce it in both that commit and in the latest commit
  (a951316b8a5c3c63254f20a826afeed940dd4cba).  I just needed to run more
  iterations of the test.  It's possible that it was partially fixed, or
  that the added serialization made it harder to catch this
  non-deterministic bug, but the same symptoms persist: data corruption
  of VDI-format disk images.

  This affects at least qemu-nbd.  I haven't tried reproducing the issue
  with qemu proper or qemu-img, but the original bug report suggests
  that the bug in the common VDI backend may corrupt data written by
  those programs.

  Please let me know if I can provide any further information or help
  with testing.  Thank you very much for looking into this!

  Test procedure
  **************

  The procedure used is the one given by Max Reitz (xanclic) in the
  original bug report, comment 3
  (https://bugs.launchpad.net/qemu/+bug/1422307/comments/3), in the
  section "VDI and NBD over /dev/nbd0", but with up to 1000 iterations
  instead of 10:

    $ cd ~/qemu-origfix-f0ab6f1/bin
    $ dd if=3D/dev/urandom of=3Dblob.raw bs=3D1M count=3D64
    64+0 records in
    64+0 records out
    67108864 bytes (67 MB) copied, 4.36475 s, 15.4 MB/s
    $ sudo sh -c 'for i in $(seq 0 999); do ./qemu-img create -f vdi test.v=
di 64M > /dev/null; ./qemu-nbd -c /dev/nbd0 test.vdi; sleep 1; ./qemu-img c=
onvert -n blob.raw /dev/nbd0; ./qemu-img convert /dev/nbd0 test1.raw; sync;=
 echo 1 > /proc/sys/vm/drop_caches; ./qemu-img convert /dev/nbd0 test2.raw;=
 ./qemu-nbd -d /dev/nbd0 > /dev/null; if ! ./qemu-img compare -q test1.raw =
test2.raw; then md5sum test1.raw test2.raw; echo "$i failed"; break; fi; do=
ne; echo "done"'
  27a66c3a8ac2cf06f2c925968ea9e964  test1.raw
  2da9bf169041a7c2bd144c4ab3a29aea  test2.raw
  64 failed
  done

  I've run this process a handful of times, and I've seen it take as
  little as 10 iterations and as many as 161 (taking 32 minutes in the
  latter case).  Please be patient.  Putting the images on tmpfs will
  probably help it go faster, and I have successfully reproduced the
  issue on tmpfs in addition to ext4.

  Nothing different was needed to reproduce the issue in a directory
  containing a build of the latest commit.  It still takes somewhere
  around 1-200 iterations to find, in my testing.

  Build procedure
  ***************

    $ git clone git://git.qemu-project.org/qemu.git
    [omitted]
    $ git clone qemu qemu-origfix-f0ab6f1
    Cloning into 'qemu-origfix-f0ab6f1'...
    done.
    $ cd qemu-origfix-f0ab6f1
    $ git checkout f0ab6f109630940146cbaf47d0cd99993ddba824
    Note: checking out 'f0ab6f109630940146cbaf47d0cd99993ddba824'.
    =

    You are in 'detached HEAD' state. You can look around, make experimental
    changes and commit them, and you can discard any commits you make in th=
is
    state without impacting any branches by performing another checkout.
    =

    If you want to create a new branch to retain commits you create, you may
    do so (now or later) by using -b with the checkout command again. Examp=
le:
    =

      git checkout -b new_branch_name
    =

    HEAD is now at f0ab6f1... block/vdi: Add locking for parallel requests
    $ mkdir bin
    $ cd bin
    $ script -c'time (../configure --enable-debug --target-list=3Dx86_64-so=
ftmmu && make -j6; echo "result: $?")'
    Script started, file is typescript
    [omitted; the build typescript is attached separately]
      LINK  x86_64-softmmu/qemu-system-x86_64
    result: 0
    =

    real    1m5.733s
    user    2m3.904s
    sys     0m13.828s
    Script done, file is typescript

  Nothing different was done when building the latest commit (besides
  cloning to a different directory, and not running `git checkout`).

  Environment
  ***********

    * Machine: x86_64
    =

    * Hypervisor: Xen 4.4 (Debian package xen-hypervisor-4.4-amd64,
      version 4.4.1-9+deb8u8)
    =

    * A Xen domU (guest) for building QEMU and reproducing the issue.
      All testing was done within the virtual machine for convenience
      and access to better hardware than what I have for my development
      machine (I expected the build to take much longer than it really
      does).
    =

        - x86_64 architecture with six VCPUs and 1.2 GiB RAM allocated,
          operating in HVM (fully virtualized) mode.
        =

        - Distribution: Debian 8.7 Jessie amd64
        =

        - Kernel: Linux 3.16.0 x86_64 (Debian package
          linux-image-3.16.0-4-amd64, version 3.16.39-1)
        =

        - Compiler: GCC 4.9.2 (Debian package gcc-4.9, version 4.9.2-10)

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1661758/+subscriptions
