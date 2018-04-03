Received: from eggs.gnu.org ([2001:4830:134:3::10]:55563)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1f3Ike-00064K-8o
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 06:01:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1f3IkW-0000jW-5C
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 06:01:16 -0400
Received: from indium.canonical.com ([91.189.90.7]:34988)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1f3IkV-0000i7-VF
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 06:01:08 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1f3IkT-0007SL-Bw
	for <qemu-devel@nongnu.org>; Tue, 03 Apr 2018 10:01:05 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 585AE2E80CC
	for <qemu-devel@nongnu.org>; Tue,  3 Apr 2018 10:01:05 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Apr 2018 09:49:14 -0000
From: ChristianEhrhardt <1740219@bugs.launchpad.net>
Reply-To: Bug 1740219 <1740219@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <151435405424.26166.7757673860586517511.malonedeb@gac.canonical.com>
Message-Id: <152274895440.9792.4138389733097521534.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1740219] Re: static linux-user ARM emulation has
 several-second startup time
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Back again,
my question was more about if we are able to JUST take 2a53535af471f4bee9d6=
cb5b363746b8d5ed21dd without the rest.

We are already in Feature Freeze for Ubuntu 18.04, so we can either

a) wait for the next release and pick it up in full by the new qemu
version (well we will do that anyway)

b) identify a fix only (not all the cleanup and reworks) patch that will
be good for the 2.11.1 in Bionic

Especially being "just slow" but not broken makes it harder to consider the=
 closer we get to release (I hate that as well being a performance engineer=
, but minimizing regressions is a target as well :-) ).
Essentially to some extend being in feature freeze is as if we are under [1=
] already.

So will 2a53535af471f4bee9d6cb5b363746b8d5ed21dd alone be good in your opin=
ion?
Or will it need more and if so what would be the minimal set of your change=
s.


[1]: https://wiki.ubuntu.com/StableReleaseUpdates

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1740219

Title:
  static linux-user ARM emulation has several-second startup time

Status in QEMU:
  New
Status in qemu package in Ubuntu:
  Triaged

Bug description:
  static linux-user emulation has several-second startup time

  My problem: I'm a Parabola packager, and I'm updating our
  qemu-user-static package from 2.8 to 2.11.  With my new
  statically-linked 2.11, running `qemu-arm /my/arm-chroot/bin/true`
  went from taking 0.006s to 3s!  This does not happen with the normal
  dynamically linked 2.11, or the old static 2.8.

  What happens is it gets stuck in
  `linux-user/elfload.c:init_guest_space()`.  What `init_guest_space`
  does is map 2 parts of the address space: `[base, base+guest_size]`
  and `[base+0xffff0000, base+0xffff0000+page_size]`; where it must find
  an acceptable `base`.  Its strategy is to `mmap(NULL, guest_size,
  ...)` decide where the first range is, and then check if that
  +0xffff0000 is also available.  If it isn't, then it starts trying
  `mmap(base, ...)` for the entire address space from low-address to
  high-address.

  "Normally," it finds an accaptable `base` within the first 2 tries.
  With a static 2.11, it's taking thousands of tries.

  ----

  Now, from my understanding, there are 2 factors working together to
  cause that in static 2.11 but not the other builds:

   - 2.11 increased the default `guest_size` from 0xf7000000 to 0xffff0000
   - PIE (and thus ASLR) is disabled for static builds

  For some reason that I don't understand, with the smaller
  `guest_size` the initial `mmap(NULL, guest_size, ...)` usually
  returns an acceptable address range; but larger `guest_size` makes it
  consistently return a block of memory that butts right up against
  another already mapped chunk of memory.  This isn't just true on the
  older builds, it's true with the 2.11 builds if I use the `-R` flag to
  shrink the `guest_size` back down to 0xf7000000.  That is with
  linux-hardened 4.13.13 on x86-64.

  So then, it it falls back to crawling the entire address space; so it
  tries base=3D0x00001000.  With ASLR, that probably succeeds.  But with
  ASLR being disabled on static builds, the text segment is at
  0x60000000; which is does not leave room for the needed
  0xffff1000-size block before it.  So then it tries base=3D0x00002000.
  And so on, more than 6000 times until it finally gets to and passes
  the text segment; calling mmap more than 12000 times.

  ----

  I'm not sure what the fix is.  Perhaps try to mmap a continuous chunk
  of size 0xffff1000, then munmap it and then mmap the 2 chunks that we
  actually need.  The disadvantage to that is that it does not support
  the sparse address space that the current algorithm supports for
  `guest_size < 0xffff0000`.  If `guest_size < 0xffff0000` *and* the big
  mmap fails, then it could fall back to a sparse search; though I'm not
  sure the current algorithm is a good choice for it, as we see in this
  bug.  Perhaps it should inspect /proc/self/maps to try to find a
  suitable range before ever calling mmap?

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1740219/+subscriptions
