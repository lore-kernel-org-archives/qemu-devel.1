Received: from eggs.gnu.org ([2001:4830:134:3::10]:53512)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e8cRI-0003EZ-3M
	for qemu-devel@nongnu.org; Sat, 28 Oct 2017 21:31:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e8cRE-0000mM-Vh
	for qemu-devel@nongnu.org; Sat, 28 Oct 2017 21:31:00 -0400
Received: from indium.canonical.com ([91.189.90.7]:52084)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1e8cRE-0000iw-PE
	for qemu-devel@nongnu.org; Sat, 28 Oct 2017 21:30:56 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1e8cRB-0005d0-0e
	for <qemu-devel@nongnu.org>; Sun, 29 Oct 2017 01:30:53 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id F23C22E80C3
	for <qemu-devel@nongnu.org>; Sun, 29 Oct 2017 01:30:52 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 29 Oct 2017 01:15:46 -0000
From: Iain Buclaw <1728325@bugs.launchpad.net>
Reply-To: Bug 1728325 <1728325@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <150923941073.9276.8418169350776607737.malonedeb@wampee.canonical.com>
Message-Id: <150923974700.4047.10887289978108509564.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1728325] Re: POWER8: Wrong behaviour with
 float-to-int punning
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

I am running:

qemu-ppc64le-static -L /usr/powerpc64le-linux-gnu ./a.out

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1728325

Title:
  POWER8: Wrong behaviour with float-to-int punning

Status in QEMU:
  New

Bug description:
  Building a reduced test program with 'gcc -O2 -fno-inline
  -mcpu=3Dpower8' produces wrong results at runtime. I don't think gcc is
  at fault here.

  ---
  #include <stdio.h>

  int getWord(const float x)
  {
    return *(int*)&x;
  }

  void main()
  {
      int foo =3D getWord(+123.456f);
      int bar =3D getWord(-123.456f);

      printf("%d\n", foo);
      printf("%d\n", bar);
      return;
  }
  ---

  This prints:
  ---
  0
  0
  ---

  Compiling with 'gcc -O2 -fno-inline -mcpu=3Dpower7' and you instead get t=
he expected result:
  ---
  1123477881
  -1024005767
  ---

  =

  The different between the two programs is:

  --- power7.s
  +++ power8.s
  @@ -6,9 +6,9 @@
   	.globl getWord
   	.type	getWord, @function
   getWord:
  -	stfs 1,-16(1)
  -	ori 2,2,0
  -	lwa 3,-16(1)
  +	xscvdpspn 0,1
  +	mfvsrwz 3,0
  +	extsw 3,3
   	blr
   	.long 0
   	.byte 0,0,0,0,0,0,0,0
          .size   getWord,.-getWord

  =

  Seems like qemu doesn't handle xscvdpspn/mfvsrwz correctly.

  https://github.com/qemu/qemu/commit/7ee19fb9d682689d36c849576c808cf92e3ba=
e40
  https://github.com/qemu/qemu/commit/f5c0f7f981333da59cc35c3210d05ec1775c9=
7c1

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1728325/+subscriptions
