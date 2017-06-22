Received: from eggs.gnu.org ([2001:4830:134:3::10]:52138)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dO72P-0002of-Nv
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 14:41:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dO72L-0002wh-OQ
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 14:41:05 -0400
Received: from indium.canonical.com ([91.189.90.7]:40344)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dO72L-0002wT-I5
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 14:41:01 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dO72K-0006XL-By
	for <qemu-devel@nongnu.org>; Thu, 22 Jun 2017 18:41:00 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 4433B2E8199
	for <qemu-devel@nongnu.org>; Thu, 22 Jun 2017 18:41:00 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Jun 2017 18:32:07 -0000
From: Anatol Pomozov <1699867@bugs.launchpad.net>
Reply-To: Bug 1699867 <1699867@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <149815632727.3205.9408286229805240743.malonedeb@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1699867] [NEW] x86_64 qemu crashes at far call
 into long-mode
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

I am experimenting with this OS https://github.com/phil-opp/blog_os and
spotted a weird behavior with qemu.

I am looking at code that does transition from 32bit mode to 64bit mode.
Right now it does 'jmp $SELECTOR,64bitfunction'. https://github.com
/phil-
opp/blog_os/blob/557c6a58ea11e31685b9d014d307002d64df5c22/src/arch/x86_64/b=
oot.asm#L32

This code works fine with qemu/kvm/vmware.

To transition from 32 to 64 bit code it is possible to use 'call'
operation. So I am trying to replace that code with 'call
$SELECTOR,64bitfunction'. It works fine with kvm and wmware. But it
fails with Qemu emulation. See the interrup debug log attached. qemu
crashes at 10302c (far call mnemonic).


  103016:       e8 18 00 00 00          callq  103033 <set_up_page_tables>
  10301b:       e8 5c 00 00 00          callq  10307c <enable_paging>
  103020:       e8 ec 00 00 00          callq  103111 <set_up_SSE>
  103025:       0f 01 15 28 00 10 00    lgdt   0x100028(%rip)        # 2030=
54 <GCC_except_table2+0xdb5f8>
  10302c:       9a                      (bad)  =

  10302d:       40 31 10                rex xor %edx,(%rax)
  103030:       00 08                   add    %cl,(%rax)


As the code works at hardware I expect it to work with qemu. Thus current q=
emu behavior looks like a bug.

** Affects: qemu
     Importance: Undecided
         Status: New

** Attachment added: "Debug log for qemu crash at far call"
   https://bugs.launchpad.net/bugs/1699867/+attachment/4901095/+files/debug=
.log

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1699867

Title:
  x86_64 qemu crashes at far call into long-mode

Status in QEMU:
  New

Bug description:
  I am experimenting with this OS https://github.com/phil-opp/blog_os
  and spotted a weird behavior with qemu.

  I am looking at code that does transition from 32bit mode to 64bit
  mode. Right now it does 'jmp $SELECTOR,64bitfunction'.
  https://github.com/phil-
  opp/blog_os/blob/557c6a58ea11e31685b9d014d307002d64df5c22/src/arch/x86_64=
/boot.asm#L32

  This code works fine with qemu/kvm/vmware.

  To transition from 32 to 64 bit code it is possible to use 'call'
  operation. So I am trying to replace that code with 'call
  $SELECTOR,64bitfunction'. It works fine with kvm and wmware. But it
  fails with Qemu emulation. See the interrup debug log attached. qemu
  crashes at 10302c (far call mnemonic).

  =

    103016:       e8 18 00 00 00          callq  103033 <set_up_page_tables>
    10301b:       e8 5c 00 00 00          callq  10307c <enable_paging>
    103020:       e8 ec 00 00 00          callq  103111 <set_up_SSE>
    103025:       0f 01 15 28 00 10 00    lgdt   0x100028(%rip)        # 20=
3054 <GCC_except_table2+0xdb5f8>
    10302c:       9a                      (bad)  =

    10302d:       40 31 10                rex xor %edx,(%rax)
    103030:       00 08                   add    %cl,(%rax)

  =

  As the code works at hardware I expect it to work with qemu. Thus current=
 qemu behavior looks like a bug.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1699867/+subscriptions
