Received: from eggs.gnu.org ([2001:4830:134:3::10]:58295)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ePsKn-0001rY-Pm
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 10:55:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ePsKj-000641-TQ
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 10:55:37 -0500
Received: from indium.canonical.com ([91.189.90.7]:45362)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1ePsKj-00062x-NL
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 10:55:33 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1ePsKi-0007sz-J7
	for <qemu-devel@nongnu.org>; Fri, 15 Dec 2017 15:55:32 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 8AE732E80C3
	for <qemu-devel@nongnu.org>; Fri, 15 Dec 2017 15:55:32 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 15 Dec 2017 15:47:22 -0000
From: Oleg Boyarchuk <1738434@bugs.launchpad.net>
Reply-To: Bug 1738434 <1738434@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <151335284270.18775.11956593413249795656.malonedeb@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1738434] [NEW] CALL FWORD PTR [ESP] handled
 incorrectly
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

To keep the story short, this 32-bit code crashes on 64-bit Windows
whereas it works fine on real system and VMware:

    push 33h
    push offset _far_call
    call fword ptr[esp]
    jmp _ret
_far_call:
    retf
_ret:

32-bit code running under WoW64 on 64-bit Windows has the ability to
switch to the 64-bit mode via so called "Heaven's gate". In order to do
that you have to make a far call/jmp by 0x33 selector how the code
snippet above shows. QEMU throws an access violation exception whereas
the code snippet runs with no problems on real CPU and VMware. By the
way, this code works fine under QEMU, I hope it gives you a hint where
to look:

    push 23h
    push offset _far_call
    call fword ptr[esp]
    jmp _ret
_far_call:
    retf
_ret:

0x23 is a default 32-bit selector for 32-bit processes running under
WoW64.

Environment:
QEMU: 2.10.93, command line: qemu-system-x86_64.exe -m 2G -snapshot -cdrom =
full_path_to_iso fullP_path_to_img
Guest OS: Windows 7 x64 SP1 build 7601 or Windows 10 version 1709 build 162=
99.19
Host OS: Windows 10 x64 version 1703 build 15063.786

** Affects: qemu
     Importance: Undecided
         Status: New

** Attachment added: "OllyDbg screenshot explains the problem"
   https://bugs.launchpad.net/bugs/1738434/+attachment/5023064/+files/call_=
fword_ptr_bug.png

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1738434

Title:
  CALL FWORD PTR [ESP] handled incorrectly

Status in QEMU:
  New

Bug description:
  To keep the story short, this 32-bit code crashes on 64-bit Windows
  whereas it works fine on real system and VMware:

      push 33h
      push offset _far_call
      call fword ptr[esp]
      jmp _ret
  _far_call:
      retf
  _ret:

  32-bit code running under WoW64 on 64-bit Windows has the ability to
  switch to the 64-bit mode via so called "Heaven's gate". In order to
  do that you have to make a far call/jmp by 0x33 selector how the code
  snippet above shows. QEMU throws an access violation exception whereas
  the code snippet runs with no problems on real CPU and VMware. By the
  way, this code works fine under QEMU, I hope it gives you a hint where
  to look:

      push 23h
      push offset _far_call
      call fword ptr[esp]
      jmp _ret
  _far_call:
      retf
  _ret:

  0x23 is a default 32-bit selector for 32-bit processes running under
  WoW64.

  Environment:
  QEMU: 2.10.93, command line: qemu-system-x86_64.exe -m 2G -snapshot -cdro=
m full_path_to_iso fullP_path_to_img
  Guest OS: Windows 7 x64 SP1 build 7601 or Windows 10 version 1709 build 1=
6299.19
  Host OS: Windows 10 x64 version 1703 build 15063.786

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1738434/+subscriptions
