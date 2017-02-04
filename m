Received: from eggs.gnu.org ([2001:4830:134:3::10]:54091)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cZvop-00051M-O0
	for qemu-devel@nongnu.org; Sat, 04 Feb 2017 03:35:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cZvok-0004mQ-KN
	for qemu-devel@nongnu.org; Sat, 04 Feb 2017 03:35:39 -0500
Received: from indium.canonical.com ([91.189.90.7]:51667)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cZvok-0004lw-F8
	for qemu-devel@nongnu.org; Sat, 04 Feb 2017 03:35:34 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cZvoj-0002Md-DK
	for <qemu-devel@nongnu.org>; Sat, 04 Feb 2017 08:35:33 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 55CBD2E80C3
	for <qemu-devel@nongnu.org>; Sat,  4 Feb 2017 08:35:33 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 04 Feb 2017 08:20:40 -0000
From: shqking <1661815@bugs.launchpad.net>
Reply-To: Bug 1661815 <1661815@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <20170204082040.20702.26524.malonedeb@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1661815] [NEW] Stack address is returned from
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

Public bug reported:

The vulnerable version is qemu-2.8.0, and the vulnerable function is in
"target-s390x/translate.c".

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

A stack address, i.e. the address of local variable "f" is returned from
current function through the output parameter "s->fields" as a side
effect.

This issue is one kind of undefined behaviors, according the C Standard,
6.2.4 [ISO/IEC 9899:2011]
(https://www.securecoding.cert.org/confluence/display/c/DCL30-C.+Declare+ob=
jects+with+appropriate+storage+durations)

This dangerous defect may lead to an exploitable vulnerability.
We suggest sanitizing "s->fields" as null before return.

Note that this issue is reported by shqking and Zhenwei Zou together.

** Affects: qemu
     Importance: Undecided
         Status: New

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
