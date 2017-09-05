Received: from eggs.gnu.org ([2001:4830:134:3::10]:56031)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dpD5S-00020P-Gk
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 08:36:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dpD5E-0004MV-Ao
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 08:36:14 -0400
Received: from mail-wm0-x22c.google.com ([2a00:1450:400c:c09::22c]:35921)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dpD5E-0004LJ-4L
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 08:36:00 -0400
Received: by mail-wm0-x22c.google.com with SMTP id i145so18721202wmf.1
	for <qemu-devel@nongnu.org>; Tue, 05 Sep 2017 05:35:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <7FD21DDFE9A3784693E393AF276FE7D21F17E49E@DGGEMA501-MBX.china.huawei.com>
References: <20170905112152.8851-1-ppandit@redhat.com>
	<CAFEAcA8B4EwXCPSBsftt=QkAuH8jCBbK23-uU7NA7G3k6ADHLw@mail.gmail.com>
	<7FD21DDFE9A3784693E393AF276FE7D21F17E49E@DGGEMA501-MBX.china.huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 Sep 2017 13:35:38 +0100
Message-ID: <CAFEAcA8JxuM-ddQVTBfgnSDD2fD+kz_RNShdNDqMqVH=zOKBfw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel]
	=?utf-8?b?562U5aSNOiBbUEFUQ0hdIGludGM6IGFybV9naWN2?=
	=?utf-8?q?3=3A_limit_GICR_ipriority_index?=
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: niuguoxiang <niuguoxiang@huawei.com>
Cc: P J P <ppandit@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Prasad J Pandit <pjp@fedoraproject.org>

On 5 September 2017 at 13:30, niuguoxiang <niuguoxiang@huawei.com> wrote:
> I think only assert is not enough, because assert() depends on NDEBUG
> preprocessing

The code cannot be reached with a non-aligned value,
because we register these functions via the gic_ops[]
MemoryRegionops in hw/intc/arm_gicv3.c, and since we
do not specify .valid.unaligned=true there, the memory.c
code will throw out attempts at unaligned accesses.

The assert is just checking at runtime that this never
becomes false accidentally (and also for the benefit of
people reading the code).

Incidentally, QEMU can never be compiled with NDEBUG not
set -- we will #error in the compilation if it is not set.
(It's not good practice to depend on the assert() actually
doing anything though, and indeed in this case we don't.)

thanks
-- PMM
