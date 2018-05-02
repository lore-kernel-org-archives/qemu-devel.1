Received: from eggs.gnu.org ([2001:4830:134:3::10]:43548)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1fDo2b-0004lx-10
	for qemu-devel@nongnu.org; Wed, 02 May 2018 05:27:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1fDo2X-0007GX-SF
	for qemu-devel@nongnu.org; Wed, 02 May 2018 05:27:12 -0400
Received: from mail.uni-paderborn.de ([131.234.142.9]:59488)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kbastian@mail.uni-paderborn.de>)
	id 1fDo2X-0007Et-DY
	for qemu-devel@nongnu.org; Wed, 02 May 2018 05:27:09 -0400
References: <20180501142222.19154-1-kbastian@mail.uni-paderborn.de>
	<20180501142222.19154-3-kbastian@mail.uni-paderborn.de>
	<04b2ae36-e7ec-3b78-5443-09fe25d2ebb3@amsat.org>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Message-ID: <d620b0e6-36d4-722d-d049-46957f02c797@mail.uni-paderborn.de>
Date: Wed, 2 May 2018 11:26:55 +0200
MIME-Version: 1.0
In-Reply-To: <04b2ae36-e7ec-3b78-5443-09fe25d2ebb3@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH 02/12] tests/tcg/tricore: Add build
 infrastructure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, David Brenken <david.brenken@efs-auto.de>, Florian Artmeier <florian.artmeier@efs-auto.de>, Georg Hofstetter <georg.hofstetter@efs-auto.de>

Hi Phil,

On 05/02/2018 02:41 AM, Philippe Mathieu-Daudé wrote:
> Hi Bastian,
> 
> On 05/01/2018 11:22 AM, Bastian Koppelmann wrote:
>> this includes the Makefile and linker script to build all the tests.
>>
>> Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
>> ---
>>  tests/tcg/tricore/Makefile | 30 +++++++++++++++++++++++
>>  tests/tcg/tricore/link.ld  | 60 ++++++++++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 90 insertions(+)
>>  create mode 100644 tests/tcg/tricore/Makefile
>>  create mode 100644 tests/tcg/tricore/link.ld
>>
>> diff --git a/tests/tcg/tricore/Makefile b/tests/tcg/tricore/Makefile
>> new file mode 100644
>> index 0000000000..8c168d1062
>> --- /dev/null
>> +++ b/tests/tcg/tricore/Makefile
>> @@ -0,0 +1,30 @@
>> +AS := tricore-as
>> +LD := tricore-ld
>> +HOST_CC = gcc
>> +
>> +LDFLAGS = -Tlink.ld
>> +ASFLAGS =
>> +
>> +SIM = ../../../tricore-softmmu/qemu-system-tricore
>> +SIMFLAGS = -M tricore_testboard -nographic -kernel
> 
> I applied this on upstream QEMU (26bd8d98c4b32).
> 
> I suppose you are doing in-tree build, since this doesn't work with> out-of-tree builds (see the $SIM relative path).

Ooops, this is mostly copied from tests/tcg/xtensa :)

> 
> I then get:
> 
> tricore-softmmu/qemu-system-tricore -M tricore_testboard -nographic
> -kests/tcg/tricore/test_muls.tst -d in_asm
> QEMU 2.12.50 monitor - type 'help' for more information
> (qemu) QEMU 2.12.50 monitor - type 'help' for more information
> (qemu) IN:
> 0x80000000:  qemu-system-tricore: function cpu_get_phys_page_attrs_debug
> not implemented, aborting

This is odd. I'll try to reproduce it.

[...]
> http://lists.nongnu.org/archive/html/qemu-devel/2018-05/msg00151.html
> (which you can build with 'make docker-image-debian-tricore-cross', I
> didn't try to merge your series over Alex's tcg-testing one)

Thanks for creating this docker image, you helped me a great deal :)

[...]
>> +
>> +all: build
>> +
>> +%.pS: %.S
>> +	$(HOST_CC) -E -o $@ $<
>> +
>> +%.o: %.pS
>> +	$(AS) $(ASFLAGS) -o $@ $<
>> +
>> +%.tst: %.o link.ld
>> +	$(LD) $(LDFLAGS) $< -o $@
> 
> Those rules did not work for me:

I assume make uses the built-in rules. Can you try $ make --no-builtin-rules?

Cheers,
Bastian
