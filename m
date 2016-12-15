Received: from eggs.gnu.org ([2001:4830:134:3::10]:57099)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cHaan-0007HS-SU
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 13:17:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cHaam-0008Pp-LO
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 13:17:21 -0500
Received: from indium.canonical.com ([91.189.90.7]:53255)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cHaam-0008PG-Ga
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 13:17:20 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cHaal-0002GE-Bg
	for <qemu-devel@nongnu.org>; Thu, 15 Dec 2016 18:17:19 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 256312E8278
	for <qemu-devel@nongnu.org>; Thu, 15 Dec 2016 18:17:09 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Dec 2016 18:00:58 -0000
From: Thomas Huth <907063@bugs.launchpad.net>
Reply-To: Bug 907063 <907063@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20111220205348.3164.18912.malonedeb@chaenomeles.canonical.com>
Message-Id: <20161215180058.20294.62674.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 907063] Re: Error reading VMDK4 with footer
 instead of header
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Looks like something similar has been commited here:
http://git.qemu.org/?p=3Dqemu.git;a=3Dcommitdiff;h=3D65bd155c7356d448ffee7
So is this problem fixed nowadays?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/907063

Title:
  Error reading VMDK4 with footer instead of header

Status in QEMU:
  Incomplete

Bug description:
  VMDK4 files can have a footer in the last block, which is the same datast=
ructure as the header but must be used instead if present. In this case, th=
e gd_offset in the usual header at the beginning of the file is the special=
 flag -1 (VMDK 1.1 spec, page 17, "GD_AT_END
  "). qemu-img doesn't know about this flag so it goes on to try to read ex=
tents with a bogus l1_table from the wrong location in the file.

  I have regression-tested this with various OVAs exported from
  VSphere/ESXi 3 and 4. Current master and all previous QEMU versions
  were unable to import any compressed VMDKs with a footer. It now works
  on all the ones I have.

  bb45ded93115ad4303471c9a492579dc36716547 changed the order of
  gd_offset and rgd_offset in the VMDK4Header struct. Page 8 of the VMDK
  1.1 spec from VMWare shows the structure as rgd_ then gd_, while QEMU
  now has gd_ *before* rgd_offset. I was only able to get VMDK
  conversion to work by switching the order back to that specified by
  VMWare and previously used by QEMU. I don't know what VMDK this commit
  is referring to, so I can't test to see if I've broken it. :(

  I will submit this patch to the mailing list if I get a chance, but
  I'm also uploading it here so I don't lose it.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/907063/+subscriptions
