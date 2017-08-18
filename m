Received: from eggs.gnu.org ([2001:4830:134:3::10]:36546)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dieRB-0001LB-HQ
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 06:23:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dieR6-0000Mw-JE
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 06:23:33 -0400
Received: from mail-wr0-x232.google.com ([2a00:1450:400c:c0c::232]:35936)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dieR6-0000MW-DC
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 06:23:28 -0400
Received: by mail-wr0-x232.google.com with SMTP id f8so22800158wrf.3
	for <qemu-devel@nongnu.org>; Fri, 18 Aug 2017 03:23:28 -0700 (PDT)
References: <150097502966.6397.351311629210845503.malonedeb@gac.canonical.com>
	<150240857521.18943.1371547756430353016.malone@chaenomeles.canonical.com>
	<87shgpi800.fsf@linaro.org>
	<CAFEAcA8S6S_T9d=QhncSb4or09HqRoZQNtxWDo3vj8OA9+pb-w@mail.gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <CAFEAcA8S6S_T9d=QhncSb4or09HqRoZQNtxWDo3vj8OA9+pb-w@mail.gmail.com>
Date: Fri, 18 Aug 2017 11:23:25 +0100
Message-ID: <87r2w9i38i.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Bug 1706296 <1706296@bugs.launchpad.net>, QEMU Developers <qemu-devel@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> On 18 August 2017 at 09:40, Alex Bennée <alex.bennee@linaro.org> wrote:
>>
>> John Arbuckle <programmingkidx@gmail.com> writes:
>>
>>> Using '-cpu 486' gets past the assertion error. I guess Windows NT 4.0
>>> is not compatible with newer Intel processors.
>>
>> It might be related. The assertion error is caused by the fact an
>> exception has occurred and processor is trying to dump a stack frame that
>> overlaps from RAM into device memory. As the IRQ/exception handling is
>> already under the BQL (as it changes machine state) we get the assertion
>> when it tries to take the BQL a second time when accessing device
>> memory.
>
> This sounds worrying -- lots and lots of target backend code
> does writes to memory. Is it all going to cause assertions if
> it happens to be pointing at a device?

Currently yes.

That said from John's update it sounds very much like a symptom of not
emulating the right processor type rather than behaviour we are
incorrectly modelling. If we invert the lock before writing the stack
page is it just going to crash in a more esoteric way?

I'm not sure how you correctly emulate writing random stack pages to a
random device. Unless there is some sort of weird [un]documented behaviour
we should be doing?

--
Alex Bennée
