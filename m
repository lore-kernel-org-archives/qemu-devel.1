Received: from eggs.gnu.org ([2001:4830:134:3::10]:37550)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fgY2x-0000P8-FR
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 12:14:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fgY2u-00073D-9R
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 12:14:23 -0400
Received: from mail-pl0-x242.google.com ([2607:f8b0:400e:c01::242]:35321)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fgY2u-00072t-1s
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 12:14:20 -0400
Received: by mail-pl0-x242.google.com with SMTP id w3-v6so5393425plq.2
	for <qemu-devel@nongnu.org>; Fri, 20 Jul 2018 09:14:20 -0700 (PDT)
References: <20180720153932.8507-1-peter.maydell@linaro.org>
	<0b589622-ffaf-8ed7-c34b-77ada1d203fb@amsat.org>
	<CAFEAcA-Mc7S775QK5dt7+eqaZD0TSZhsNLrZauSNshfbQGx9fg@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <aa869c16-9577-bf7b-a5c7-b63673644a6f@linaro.org>
Date: Fri, 20 Jul 2018 09:14:15 -0700
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-Mc7S775QK5dt7+eqaZD0TSZhsNLrZauSNshfbQGx9fg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-3.0 ?] tests/libqtest: Improve
 kill_qemu() assert
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Cc: "patches@linaro.org" <patches@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, "Michael S . Tsirkin" <mst@redhat.com>

On 07/20/2018 08:49 AM, Peter Maydell wrote:
> On 20 July 2018 at 16:48, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>> On 07/20/2018 12:39 PM, Peter Maydell wrote:
>>> In kill_qemu() we have an assert that checks that the QEMU process
>>> didn't dump core:
>>>             assert(!WCOREDUMP(wstatus));
>>>
>>> Unfortunately the WCOREDUMP macro here means the resulting message
>>> is not very easy to comprehend on at least some systems:
>>>
>>> ahci-test: tests/libqtest.c:113: kill_qemu: Assertion `!(((__extension__ (((union { __typeof(wstatus) __in; int __i; }) { .__in = (wstatus) }).__i))) & 0x80)' failed.
>>>
>>> and it doesn't identify what signal the process took.
>>>
>>> Instead of using a raw assert, print the information in an
>>> easier to understand way:
>>>
>>> /i386/ahci/sanity: libqtest.c: kill_qemu() tried to terminate QEMU process but it dumped core with signal 11
>>
>> Less cryptic, indeed.
>>
>>> ahci-test: tests/libqtest.c:118: kill_qemu: Assertion `0' failed.
>>
>> This file:line is not very relevant, ...
> 
>> ... what about directly using abort() here?
> 
> I did actually start with that, but decided I'd rather have
> the file-and-line in there to direct people more quickly
> to the immediate point where we asserted.

You already print the file, just include the line.  Perhaps

  fprintf(stderr,
          "%s:%d: kill_qemu tried to terminate QEMU "
          "process but it dumped core with signal %s\n",
          __FILE__, __LINE__, strsignal(WTERMSIG(wstatus)));
  abort();

Not that I expect the signal to ever be anything other than 11,
and that being one of the handful that are consistent across
pretty much all unix systems.  But still.


r~


PS: The bike shed should be blue.
