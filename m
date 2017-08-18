Received: from eggs.gnu.org ([2001:4830:134:3::10]:39116)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dieb8-0003Es-MH
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 06:33:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dieb7-0006cC-Ql
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 06:33:50 -0400
Received: from mail-wr0-x233.google.com ([2a00:1450:400c:c0c::233]:37869)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dieb7-0006bk-Jv
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 06:33:49 -0400
Received: by mail-wr0-x233.google.com with SMTP id z91so58346192wrc.4
	for <qemu-devel@nongnu.org>; Fri, 18 Aug 2017 03:33:49 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87r2w9i38i.fsf@linaro.org>
References: <150097502966.6397.351311629210845503.malonedeb@gac.canonical.com>
	<150240857521.18943.1371547756430353016.malone@chaenomeles.canonical.com>
	<87shgpi800.fsf@linaro.org>
	<CAFEAcA8S6S_T9d=QhncSb4or09HqRoZQNtxWDo3vj8OA9+pb-w@mail.gmail.com>
	<87r2w9i38i.fsf@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 18 Aug 2017 11:33:27 +0100
Message-ID: <CAFEAcA-WZbG=vCxyVJava1T8yUT1PGiRhNTX092cD1C869StQg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Bug 1706296] Re: Booting NT 4 disk causes
 /home/rjones/d/qemu/cpus.c:1580:qemu_mutex_lock_iothread: assertion failed:
 (!qemu_mutex_iothread_locked())
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Bug 1706296 <1706296@bugs.launchpad.net>, QEMU Developers <qemu-devel@nongnu.org>

On 18 August 2017 at 11:23, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote=
:
> Peter Maydell <peter.maydell@linaro.org> writes:
>> On 18 August 2017 at 09:40, Alex Benn=C3=A9e <alex.bennee@linaro.org> wr=
ote:
>>> It might be related. The assertion error is caused by the fact an
>>> exception has occurred and processor is trying to dump a stack frame th=
at
>>> overlaps from RAM into device memory. As the IRQ/exception handling is
>>> already under the BQL (as it changes machine state) we get the assertio=
n
>>> when it tries to take the BQL a second time when accessing device
>>> memory.
>>
>> This sounds worrying -- lots and lots of target backend code
>> does writes to memory. Is it all going to cause assertions if
>> it happens to be pointing at a device?
>
> Currently yes.
>
> That said from John's update it sounds very much like a symptom of not
> emulating the right processor type rather than behaviour we are
> incorrectly modelling. If we invert the lock before writing the stack
> page is it just going to crash in a more esoteric way?
>
> I'm not sure how you correctly emulate writing random stack pages to a
> random device. Unless there is some sort of weird [un]documented behaviou=
r
> we should be doing?

The desired behaviour is straightforward -- if the code calls
a function for "do a 4 byte write" then we do a 4 byte write
to the device. The only place where writing to a device has
to be special cased is when we're trying to execute code
from it (which is itself arguably a defect of our emulation).

It looks like we only get this double locking when the
target/ code does a write-by-virtual-address (which ends
up going via io_writex() which takes the lock again) --
write-by-physical-address, eg stl_phys and friends presumably
don't take the lock. That's a rather confusing mismatch of
semantics.

thanks
-- PMM
