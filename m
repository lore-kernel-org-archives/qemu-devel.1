Received: from eggs.gnu.org ([2001:4830:134:3::10]:34773)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1caiRn-0000YC-IW
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 07:31:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1caiRj-0001CH-LB
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 07:31:07 -0500
Received: from indium.canonical.com ([91.189.90.7]:56114)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1caiRj-0001C5-GC
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 07:31:03 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1caiRf-0006c8-7h
	for <qemu-devel@nongnu.org>; Mon, 06 Feb 2017 12:30:59 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id B41532E80D5
	for <qemu-devel@nongnu.org>; Mon,  6 Feb 2017 12:30:52 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Feb 2017 12:17:08 -0000
From: shqking <1661815@bugs.launchpad.net>
Reply-To: Bug 1661815 <1661815@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20170204082040.20702.26524.malonedeb@gac.canonical.com>
Message-Id: <20170206121708.23918.87313.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1661815] Re: Stack address is returned from
 function translate_one
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Thanks for your reply.

Inspired by this issue in apache httpd (https://bz.apache.org/bugzilla/show=
_bug.cgi?id=3D59844#c0),
we customized a checker based on the Clang Static Analyzer to detect such u=
ndefined behavior.

Yes. =

After examining the code carefully, we didn't find any place where the "->f=
ields" is accessed, either. However, we think this kind of defect seems lik=
e a 'time bomb' and we'd better fix it just to be on the safe side.

** Bug watch added: bz.apache.org/bugzilla/ #59844
   https://bz.apache.org/bugzilla/show_bug.cgi?id=3D59844

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1661815

Title:
  Stack address is returned from function translate_one

Status in QEMU:
  New

Bug description:
  The vulnerable version is qemu-2.8.0, and the vulnerable function is
  in "target-s390x/translate.c".

  The code snippet is as following.

  static ExitStatus translate_one(CPUS390XState *env, DisasContext *s)
  {
      const DisasInsn *insn;
      ExitStatus ret =3D NO_EXIT;
      DisasFields f;
      ...
      s->fields =3D &f;
      ...
      s->pc =3D s->next_pc;
      return ret;
  }

  A stack address, i.e. the address of local variable "f" is returned
  from current function through the output parameter "s->fields" as a
  side effect.

  This issue is one kind of undefined behaviors, according the C
  Standard, 6.2.4 [ISO/IEC 9899:2011]
  (https://www.securecoding.cert.org/confluence/display/c/DCL30-C.+Declare+=
objects+with+appropriate+storage+durations)

  This dangerous defect may lead to an exploitable vulnerability.
  We suggest sanitizing "s->fields" as null before return.

  Note that this issue is reported by shqking and Zhenwei Zou together.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1661815/+subscriptions
