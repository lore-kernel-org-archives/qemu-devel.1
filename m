Received: from eggs.gnu.org ([2001:4830:134:3::10]:57362)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1duxho-0004Zq-5X
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 05:23:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1duxhn-0003FO-3s
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 05:23:36 -0400
Received: from mail-wr0-x233.google.com ([2a00:1450:400c:c0c::233]:53147)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1duxhm-0003FF-RS
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 05:23:35 -0400
Received: by mail-wr0-x233.google.com with SMTP id c23so4043328wrg.9
	for <qemu-devel@nongnu.org>; Thu, 21 Sep 2017 02:23:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-WZbG=vCxyVJava1T8yUT1PGiRhNTX092cD1C869StQg@mail.gmail.com>
References: <150097502966.6397.351311629210845503.malonedeb@gac.canonical.com>
	<150240857521.18943.1371547756430353016.malone@chaenomeles.canonical.com>
	<87shgpi800.fsf@linaro.org>
	<CAFEAcA8S6S_T9d=QhncSb4or09HqRoZQNtxWDo3vj8OA9+pb-w@mail.gmail.com>
	<87r2w9i38i.fsf@linaro.org>
	<CAFEAcA-WZbG=vCxyVJava1T8yUT1PGiRhNTX092cD1C869StQg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 21 Sep 2017 10:23:12 +0100
Message-ID: <CAFEAcA--V6PhntAt4=_fHkwn0dw=k+g+Om5b6RbKCnKODgUiDg@mail.gmail.com>
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
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 18 August 2017 at 11:33, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 18 August 2017 at 11:23, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>> Peter Maydell <peter.maydell@linaro.org> writes:
>>> On 18 August 2017 at 09:40, Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>>>> It might be related. The assertion error is caused by the fact an
>>>> exception has occurred and processor is trying to dump a stack frame t=
hat
>>>> overlaps from RAM into device memory. As the IRQ/exception handling is
>>>> already under the BQL (as it changes machine state) we get the asserti=
on
>>>> when it tries to take the BQL a second time when accessing device
>>>> memory.
>>>
>>> This sounds worrying -- lots and lots of target backend code
>>> does writes to memory. Is it all going to cause assertions if
>>> it happens to be pointing at a device?
>>
>> Currently yes.
>>
>> That said from John's update it sounds very much like a symptom of not
>> emulating the right processor type rather than behaviour we are
>> incorrectly modelling. If we invert the lock before writing the stack
>> page is it just going to crash in a more esoteric way?
>>
>> I'm not sure how you correctly emulate writing random stack pages to a
>> random device. Unless there is some sort of weird [un]documented behavio=
ur
>> we should be doing?
>
> The desired behaviour is straightforward -- if the code calls
> a function for "do a 4 byte write" then we do a 4 byte write
> to the device. The only place where writing to a device has
> to be special cased is when we're trying to execute code
> from it (which is itself arguably a defect of our emulation).
>
> It looks like we only get this double locking when the
> target/ code does a write-by-virtual-address (which ends
> up going via io_writex() which takes the lock again) --
> write-by-physical-address, eg stl_phys and friends presumably
> don't take the lock. That's a rather confusing mismatch of
> semantics.

Hi Alex -- do we have a fix for this assertion now, or is it still
on your todo list?

thanks
-- PMM
