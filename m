Received: from eggs.gnu.org ([2001:4830:134:3::10]:49303)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dlB7x-000544-6T
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 05:42:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dlB7w-0005N9-35
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 05:42:09 -0400
Received: from mail-wr0-x236.google.com ([2a00:1450:400c:c0c::236]:36216)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dlB7v-0005MM-TW
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 05:42:08 -0400
Received: by mail-wr0-x236.google.com with SMTP id p14so5704985wrg.3
	for <qemu-devel@nongnu.org>; Fri, 25 Aug 2017 02:42:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170825093358.GJ11465@lemon.lan>
References: <mailman.3749.1503600836.21955.qemu-devel@nongnu.org>
	<74846968-830E-4239-9DC7-B1252A5AC946@gmail.com>
	<60e13112-931d-a517-ddb1-20c2f2de736e@redhat.com>
	<9CE89958-B59C-4D3C-91C5-ECB4B153C43D@gmail.com>
	<89d8b7b1-fb0f-a967-927e-8795c7d2b324@redhat.com>
	<1adde8d7-762f-8e89-7192-32d370b72af6@redhat.com>
	<CAFEAcA-OiC_BxpK3_aBrkqie9B2AuefQRupJrnnfSq_asfQLNw@mail.gmail.com>
	<20170825093358.GJ11465@lemon.lan>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 25 Aug 2017 10:41:46 +0100
Message-ID: <CAFEAcA8684ChqsbV4x7Ey-2Ai56sAtLhLNfjX5jJnopHaM4Y1g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Make test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, Programmingkid <programmingkidx@gmail.com>, Richard Henderson <rth@twiddle.net>, QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Cleber Rosa <crosa@redhat.com>

On 25 August 2017 at 10:33, Fam Zheng <famz@redhat.com> wrote:
> On Fri, 08/25 10:10, Peter Maydell wrote:
>> The problem is that we don't have a good framework for building
>> guest binaries to run under TCG. We should sort out one of those
>> so that it's easy for a new test to say "this is the .c file,
>> build it with an ARM gcc [eg using our docker stuff], then
>> run it with this QEMU command". When we have that it should
>> be straightforward to convert the 'make test' tests to use
>> that, and they can be run under 'make check'.
>
> This seems straigtforward to do with docker. Could you elaborate a concrete
> example of one of the "this is the .c file, ..." test so I can try translate it
> to a Makefile rule using our docker images?

tests/tcg/hello-i386.c is probably a good place to start.
It wants to be built with an i386 compiler like so:
i386-linux-gcc -nostdlib -Wall -O2 -g -fno-strict-aliasing -static  -o
hello-i386 hello-i386.c
and then run with
qemu-i386 ./hello-i386
which should print "Hello World".

There's also a hello-arm which you can build with
arm-linux-gnueabihf-gcc -Wall -g -O2 -marm -c -o hello-arm.o hello-arm.c
arm-linux-gnueabihf-ld -o hello-arm hello-arm.o
and run with
qemu-arm ./hello-arm
to print "Hello World". (You can probably compile and link in one
step, but for some reason tests/tcg/Makefile is doing it with
two steps.)

thanks
-- PMM
