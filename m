Received: from eggs.gnu.org ([2001:4830:134:3::10]:55258)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cwBMU-0004WJ-4N
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 13:38:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cwBMT-0007O5-6Y
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 13:38:22 -0400
Received: from mail-wr0-x22f.google.com ([2a00:1450:400c:c0c::22f]:35815)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cwBMS-0007Nl-US
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 13:38:21 -0400
Received: by mail-wr0-x22f.google.com with SMTP id o21so45349618wrb.2
	for <qemu-devel@nongnu.org>; Thu, 06 Apr 2017 10:38:20 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <a710ff5405c04e8b97f5d4ed6739fb7b@XCGC3021.northgrum.com>
References: <7a623fb8d2284ee28ddbd6e1ccf277e0@XCGC3021.northgrum.com>
	<CAFEAcA8C17TnnBKim9T9k32Re9C-pWUokF-UeVAd=itcpROvRg@mail.gmail.com>
	<a710ff5405c04e8b97f5d4ed6739fb7b@XCGC3021.northgrum.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 6 Apr 2017 18:37:59 +0100
Message-ID: <CAFEAcA9VFFXk0U7prWV1KCzBTxDv6ABBLZhRmKZ=nd5b+GynqQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] EXT :Re: Emulating external registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Wu, Michael Y [US] (MS)" <Michael.Wu@ngc.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

On 6 April 2017 at 18:23, Wu, Michael Y [US] (MS) <Michael.Wu@ngc.com> wrot=
e:
> I changed my code to the following and added the appropriate read,write f=
unctions and a MemoryRegionOps.
>     memory_region_init_io(reg_memory, NULL, &reg_ops, reg,
>                           "reg_mem", 0x00000040); //set to 64 bytes
>     memory_region_add_subregion(sysmem, 0xFC000000, reg_memory);
>
> For the read function I just returned a zero. So if I were to read from t=
he address 0xFC000000 it should return a value of 0? The current issue I am=
 having is that gdb hangs when the pointer is accessed. I am starting to th=
ink my bare-metal program is incorrect. I also added log messages in my rea=
d and write functions. The read function was not accessed.

You'll probably find that what has happened is that your program
has taken an exception which you don't have an exception handler
installed for, and has then jumped off into nowhere or gone into
an infinite loop of taking exceptions. (Probably hitting ^c in
gdb will break into wherever it is.) It's a good idea in bare
metal test code to write at least a minimal set of exception handlers
that can print a message when an unexpected exception occurs and
stop, so you don't get too confused.

You might also want to investigate QEMU's tracing:
-d in_asm,exec,cpu,int,nochain -D debug.log will write tracing to
the debug.log file (a lot of it, and this set of trace flags
slow down execution a lot, but if you're doing very small bare
metal flags that should be ok). This can help in figuring out
what your test program is doing. (Watch out that the in_asm
shows when we first encounter a block of code, but if we
execute the same bit of code a second time we'll only print
the exec and cpu parts of the logging.)

thanks
-- PMM
