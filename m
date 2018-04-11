Received: from eggs.gnu.org ([2001:4830:134:3::10]:33925)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1f6FNp-0006LK-MS
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 09:02:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1f6FNg-0006Pm-5y
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 09:01:53 -0400
Received: from indium.canonical.com ([91.189.90.7]:40446)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1f6FNf-0006PL-W6
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 09:01:44 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1f6FNe-0007fD-9N
	for <qemu-devel@nongnu.org>; Wed, 11 Apr 2018 13:01:42 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 0EA402E80CD
	for <qemu-devel@nongnu.org>; Wed, 11 Apr 2018 13:01:42 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Apr 2018 12:46:50 -0000
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Reply-To: Bug 1759264 <1759264@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <152215564388.18893.1601223531883570946.malonedeb@chaenomeles.canonical.com>
	<152339082825.12513.17266713653673903879.malone@wampee.canonical.com>
	<924dbc89-fb1c-720d-9091-a5f5c16df4b9@mail.uni-paderborn.de>
	<87woxe3t2t.fsf@linaro.org>
Message-Id: <a8872e48-4dea-9394-3974-eb067df252d7@mail.uni-paderborn.de>
Errors-To: bounces@canonical.com
Subject: Re: [Qemu-devel] [Bug 1759264] Re: fpu/softfloat:
 round_to_int_and_pack refactor broke TriCore ftoi insns
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

On 04/11/2018 01:01 PM, Alex Benn=C3=A9e wrote:
> Bastian Koppelmann <kbastian@mail.uni-paderborn.de> writes:
> =

>> On 04/10/2018 10:07 PM, Alex Benn=C3=A9e wrote:
>>> Yeah it looks like it was missed, the round_to_uint code does it.
>>>
>>> Do you have a test case I can verify?
>>>
>>
>> For the NaN input 0xffffffff the expected result for the flags is that
>> flag_invalid is raised.
>>
>> I can provide you with some TriCore asm, but it is a bit of pain to get
>> the gnu assembler to build, since the public version is a decade old.
> =

> I'll trust you if you send me a static binary for this particular
> verification ;-)

I set up a github repo with working binutils and the corresponding
testcase:

https://github.com/bkoppelmann/tricore-fpu

The one caveat is, that we cannot produce any binaries with the TriCore
ISA > 1.3.

In this testcase the last ftoi instruction is supposed to raise the
invalid flag and return 0 since the input was NaN. We did that by only
checking for NaN if any flag was raised after ftoi, then do the NaN
check, and if positive, return 0.

Cheers,
Bastian

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1759264

Title:
  fpu/softfloat: round_to_int_and_pack refactor broke TriCore ftoi insns

Status in QEMU:
  New

Bug description:
  After the refactor from ab52f973a504f8de0c5df64631ba4caea70a7d9e the
  bahaviour of int32_to_float32() was altered.

  helper_ftoi() in target/tricore/fpu_helper.c relied on
  int32_to_float32 to raise the invalid flag if the input was NaN to
  properly return 0. Likewise if the input is infinity.

  The obvious fix for softfloat would be to raise this flag in round_to_int=
_and_pack(). However,
  I'm not sure if this breaks other targets and I have no easy way to test =
it.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1759264/+subscriptions
