Received: from eggs.gnu.org ([2001:4830:134:3::10]:36081)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dV1Za-0005AT-E0
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 16:15:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dV1ZZ-0004vs-1R
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 16:15:54 -0400
Received: from indium.canonical.com ([91.189.90.7]:52017)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dV1ZY-0004vd-Ra
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 16:15:52 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dV1ZX-0001Xn-PG
	for <qemu-devel@nongnu.org>; Tue, 11 Jul 2017 20:15:51 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id BBAF52E8193
	for <qemu-devel@nongnu.org>; Tue, 11 Jul 2017 20:15:51 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 11 Jul 2017 19:59:02 -0000
From: Thomas Huth <1095531@bugs.launchpad.net>
Reply-To: Bug 1095531 <1095531@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20130103052033.32036.58749.malonedeb@wampee.canonical.com>
Message-Id: <149980314207.15111.12147255722868105515.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1095531] Re: sparc32plus (and others?) has x86
 code generation errors on 64bit hosts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Can you still reproduce this problem wit the latest release of QEMU
(currently version 2.9.0), or could we close this bug nowadays?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1095531

Title:
  sparc32plus (and others?) has x86 code generation errors on 64bit
  hosts

Status in QEMU:
  Incomplete

Bug description:
  On 64bit hosts, the load and store functions compile improperly. The
  issue is the call to gen_address_mask() under the ld and st functions
  in target-sparc/translate.c. Below are some snips from the log file.
  Doing a gdb debug, this results in constant access violation errors
  which I do not see when debugging qemu in powerpc mode.

  --------------
  IN: =

  0x0000000040804aa8:  st  %i0, [ %fp + 0x44 ]

  OP:
   ---- 0x40804aa8
   ld_i64 tmp1,regwptr,$0xb0
   mov_i64 tmp0,tmp1
   movi_i64 tmp2,$0x44
   add_i64 tmp0,tmp0,tmp2
   ld_i64 tmp2,regwptr,$0x80
   ext32u_i64 tmp0,tmp0
   qemu_st32 tmp2,tmp0,$0x0

  OUT: [size=3D345]
  0x6032d7f0:  mov    0x40(%r14),%rbp
  0x6032d7f4:  mov    0xb0(%rbp),%rbx
  0x6032d7fb:  add    $0x44,%rbx
  0x6032d7ff:  mov    0x80(%rbp),%rbp
  0x6032d806:  mov    %ebx,%ebx                 <- bug
  0x6032d808:  mov    %ebp,%edi
  0x6032d80a:  bswap  %edi
  0x6032d80c:  mov    %edi,(%rbx)

  --------------
  IN: =

  0x0000000040804aec:  add  %l7, %o7, %l7
  0x0000000040804af0:  ld  [ %l7 ], %g2

  OP:
   ---- 0x40804aec
   ld_i64 tmp1,regwptr,$0x78
   ld_i64 tmp2,regwptr,$0x38
   add_i64 tmp0,tmp1,tmp2
   st_i64 tmp0,regwptr,$0x78

   ---- 0x40804af0
   ld_i64 tmp1,regwptr,$0x78
   mov_i64 tmp0,tmp1
   ext32u_i64 tmp0,tmp0
   qemu_ld32u g2,tmp0,$0x0

  OUT: [size=3D395]
  0x6032da80:  mov    0x40(%r14),%rbp
  0x6032da84:  mov    0x78(%rbp),%rbx
  0x6032da88:  mov    0x38(%rbp),%r12
  0x6032da8c:  add    %r12,%rbx
  0x6032da8f:  mov    %rbx,0x78(%rbp)
  0x6032da93:  mov    0x78(%rbp),%rbx
  0x6032da97:  mov    %ebx,%ebx                <- bug
  0x6032da99:  mov    (%rbx),%ebx

  In 64bit mode, doing a 32bit operation will result in the top 32bit's
  being zero'd. I attempted to simply disable the call to
  gen_address_mask() but that did not fix the issue and actually caused
  the sparc32plus I was testing to become unusable.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1095531/+subscriptions
