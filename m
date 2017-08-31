Received: from eggs.gnu.org ([2001:4830:134:3::10]:43223)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dnObG-0001GJ-73
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 08:29:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dnObD-0000HM-0C
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 08:29:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53082)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dnObC-0000E0-QA
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 08:29:30 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EEE3F81245
	for <qemu-devel@nongnu.org>; Thu, 31 Aug 2017 12:29:28 +0000 (UTC)
Received: from redhat.com (unknown [10.42.22.189])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 7A8F59D5FB
	for <qemu-devel@nongnu.org>; Thu, 31 Aug 2017 12:29:28 +0000 (UTC)
Date: Thu, 31 Aug 2017 13:29:25 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170831122925.GJ17315@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Subject: [Qemu-devel] RFC: changing ROM bundling in tar dists for releases
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

A while back now I posted an RFC patch that changes qemu-X.Y.Z.tar.bz2
archive to *not* have any ROMs or 3rd party libs bundled, and create a
new dist qemu-bundled-X.Y.Z.tar.bz2 for the fully bundled dist:

  http://lists.gnu.org/archive/html/qemu-devel/2017-04/msg03335.html

With 2.10 out of the way, and KVM Forum approaching, I figure now is
a reasonable time to revive the idea to see if it has support

The core issues I'm aiming to solve are:

 - Distro vendors don't want the bundled ROMs / libs. They want to
   fully build everything from source to ensure they are distributing
   clean soure & builds in compliance with the licenses. Currently they
   strip bundled bits from the build tree, but would prefer if the source
   dist did not have them either.

 - The qemu release dists get ever larger as we add more ROMS. Adding
   EFI ROM builds for i386, x86_64, and aarch64 will make the dists
   larger still.

There are the following options I see

  1. Keep existing dist, and add a new minimal one

       qemu-X.Y.Z.tar.bz2 - qemu source + bundled ROMS + libs
       qemu-minimal-X.Y.Z.tar.bz2 - qemu source only

     Least impact for current non-distro users, distros just switch.

  2. Change existing dist, and add a new one with everything

       qemu-X.Y.Z.tar.bz2 - qemu source only
       qemu-full-X.Y.Z.tar.bz2 - qemu source + bundled ROMS + libs

     Non-distro users need to download a different dist from what they
     have known previously, but otherwise unchanged build process.

  3. Change existing dist, and add a new one with bundled bits

       qemu-X.Y.Z.tar.bz2 - qemu source only
       qemu-addons-X.Y.Z.tar.bz2 - bundled ROMS + libs

     Non-distro users need to manually download & install an
     extra piece compared to now.

  4. Change existing dist, never distribute bundled ROMs + libs at all

       qemu-X.Y.Z.tar.bz2 - qemu source only

     Only here for completeness, not a serious suggestion

  5. Change nothing

     Continue ignoring the problem I aim to solve.


My patch did option 2, but I really open to any of 1/2/3 without a
strong preference, as long as we can get some agreement on one. I
guess option 1 might be easiest to get agreement on given its minimal
impact.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
