Received: from eggs.gnu.org ([2001:4830:134:3::10]:44267)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dicpa-0005yF-6i
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 04:40:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dicpW-0003YH-Pp
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 04:40:38 -0400
Received: from mail-wr0-x22d.google.com ([2a00:1450:400c:c0c::22d]:35799)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dicpW-0003Xw-IY
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 04:40:34 -0400
Received: by mail-wr0-x22d.google.com with SMTP id 49so55392943wrw.2
	for <qemu-devel@nongnu.org>; Fri, 18 Aug 2017 01:40:34 -0700 (PDT)
References: <150097502966.6397.351311629210845503.malonedeb@gac.canonical.com>
	<150240857521.18943.1371547756430353016.malone@chaenomeles.canonical.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <150240857521.18943.1371547756430353016.malone@chaenomeles.canonical.com>
Date: Fri, 18 Aug 2017 09:40:31 +0100
Message-ID: <87shgpi800.fsf@linaro.org>
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
To: Bug 1706296 <1706296@bugs.launchpad.net>
Cc: qemu-devel@nongnu.org


John Arbuckle <programmingkidx@gmail.com> writes:

> Using '-cpu 486' gets past the assertion error. I guess Windows NT 4.0
> is not compatible with newer Intel processors.

It might be related. The assertion error is caused by the fact an
exception has occurred and processor is trying to dump a stack frame that
overlaps from RAM into device memory. As the IRQ/exception handling is
already under the BQL (as it changes machine state) we get the assertion
when it tries to take the BQL a second time when accessing device
memory.

We can drop the lock in the stack frame writing code but I don't know
what effect that would have as the guest still might crash having tried
to write a stack frame to device memory....

>
> Currently I can install Windows NT 4.0, but booting from the
> installation has its problems. It won't boot unless you use the NTFS
> file system. Even with this file system I still see a BSOD that states
> INACCESSIBLE_BOOT_DEVICE. Not sure what is wrong. Switching to a SCSI
> controller didn't help.


--
Alex Bennée
