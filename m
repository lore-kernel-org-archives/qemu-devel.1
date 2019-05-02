Received: from eggs.gnu.org ([209.51.188.92]:48087)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hM9Fi-0004zH-NT
	for qemu-devel@nongnu.org; Thu, 02 May 2019 06:47:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hM9Fh-0007Z1-PM
	for qemu-devel@nongnu.org; Thu, 02 May 2019 06:47:46 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:36894)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hM9Fh-0007YR-IB
	for qemu-devel@nongnu.org; Thu, 02 May 2019 06:47:45 -0400
Received: by mail-wm1-x343.google.com with SMTP id y5so1999203wma.2
	for <qemu-devel@nongnu.org>; Thu, 02 May 2019 03:47:45 -0700 (PDT)
References: <20190501223819.8584-1-richard.henderson@linaro.org>
	<20190502040459.GE13618@umbus.fritz.box>
	<5aca63b1-72e9-9402-8828-d2dd054b3313@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <5aca63b1-72e9-9402-8828-d2dd054b3313@linaro.org>
Date: Thu, 02 May 2019 11:47:42 +0100
Message-ID: <87h8ad5e0h.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/2] configure: Fix make check-tcg for
 ppc64le
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-devel@nongnu.org, mark.cave-ayland@ilande.co.uk, qemu-ppc@nongnu.org


Richard Henderson <richard.henderson@linaro.org> writes:

> On 5/1/19 9:04 PM, David Gibson wrote:
>> I've staged this tentatively in ppc-for-4.1.  However while it removes
>> the "Invalid ELF image" message I still get:
>>
>>   TEST    test-mmap (4096 byte pages) on ppc64le
>> test-mmap: Invalid argument
>> make[2]: *** [/home/dwg/qemu/tests/tcg/multiarch/Makefile.target:35: run=
-test-mmap-4096] Error 255
>> make[2]: Target 'run' not remade because of errors.
>> make[1]: *** [/home/dwg/qemu/tests/tcg/Makefile.include:71: run-guest-te=
sts] Error 2
>> make: *** [/home/dwg/qemu/tests/Makefile.include:1079: run-tcg-tests-ppc=
64le-linux-user] Error 2
>>
>> Running on a POWER9 host.  Do you see that as well?
>
> Yes.
>
> It's a semi-bogus test, really.  We can't run test-mmap
> with a page size smaller than that of the host, and of
> course ppc64le uses 64k pages.

The default run-test-mmap should just run against the host page size
(which may be bogus for the emulated architecture). The additional runs
are all added with EXTRA_RUNS:

  EXTRA_RUNS+=3Drun-test-mmap-4096 #run-test-mmap-65536

Currently the 64k pages are disabled because it crashes so somebody
should probably look into that.

Looking at -p setting the confusing named qemu_host_page_size doesn't
seem to reflect this in:

  #ifdef TARGET_NR_getpagesize
      case TARGET_NR_getpagesize:
          return TARGET_PAGE_SIZE;
  #endif

> This needs a different set of cleanups.  ;-)

I guess this is another use case for softmmu support in linux-user where
HOST_PAGE !=3D TARGET_PAGE?

--
Alex Benn=C3=A9e
