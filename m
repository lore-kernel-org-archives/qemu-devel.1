Received: from eggs.gnu.org ([2001:4830:134:3::10]:41452)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1d7rGl-0006Sa-DG
	for qemu-devel@nongnu.org; Mon, 08 May 2017 18:36:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1d7rGk-00059C-CJ
	for qemu-devel@nongnu.org; Mon, 08 May 2017 18:36:43 -0400
In-Reply-To: <20170508221304.y36owezwla7sc6ss@aurel32.net>
References: <0F376E9C-2D4B-4D79-B3D4-24F73FD61446@gmail.com>
	<20170508221304.y36owezwla7sc6ss@aurel32.net>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=WINDOWS-1252; delsp=yes; format=flowed
Message-Id: <BB3E29F1-8BBB-407B-AAC8-795E9718CF5E@gmail.com>
Content-Transfer-Encoding: quoted-printable
From: G 3 <programmingkidx@gmail.com>
Date: Mon, 8 May 2017 18:36:32 -0400
Subject: Re: [Qemu-devel] Floating point unit bugs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aurelien Jarno <aurelien@aurel32.net>
Cc: "qemu-ppc@nongnu.org list:PowerPC" <qemu-ppc@nongnu.org>, "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>


On May 8, 2017, at 6:13 PM, Aurelien Jarno wrote:

> On 2017-05-07 17:48, G 3 wrote:
>> I made a diagnostic program for the floating point unit. It will test
>> various PowerPC floating point instructions for compatibility with =20=

>> the
>> PowerPC G3 processor. It was tested on a PowerPC G3 and G5 system. =20=

>> The
>> results of the program in qemu-system-ppc were pretty bad. About =20
>> every
>> instruction tested is not implemented correctly.
>>
>> Here is the download link to the program: http://www.mediafire.com/=20=

>> file/6j9tqubvk73lkw1/floating_point_test_program.zip
>
> Some comments on the code.
>>
>>     /* Check if everything is alright */
>>     uint32_t fpscr;
>>     asm volatile("mffs f0");
>>     asm volatile("stfd f0, 40(r1)");
>>     asm volatile("lwz %0, 44(r1)" : "=3Dr"(fpscr));
>>     if (fpscr !=3D 0) {
>>         printf("Warning: fpscr not equal to zero: 0x%x\n", fpscr);
>>     }
>
> This is overly complicated and just doesn't compile with recent GCC
> versions.

Which version of GCC had the problem? GCC 5.2 and GCC 3.3 seems to =20
work fine. GCC 4.0 did not work. Could you send me the error message?

> What about something like:
>
>     Converter c;
>     asm volatile("mffs %0" : "=3Df"(c.d));
>     fpscr =3D (uint32_t)c.i;

This way does work also.

>
>
>> /*
>>  * The action to take if a test fails
>>  * Input one: message string
>>  * Input two: actual fpscr value
>>  * Input three: expected fpscr value
>>  * Input four: actual answer
>>  * Input five: expected answer
>>  */
>>  void test_failed(const char *message, uint32_t actual_fpscr, =20
>> uint32_t
>> expected_fpscr,
>>                   uint64_t actual_answer, uint64_t expected_answer)
>>  {
>>     printf("%s\n", message);
>>     printf("expected answer: 0x%" PRIx64 "\n", expected_answer);
>>     printf("  actual answer: 0x%" PRIx64 "\n", actual_fpscr);
>
> This is wrong. It should be actual_answer instead of actual_fpscr. =20
> That
> is why all the instructions seems totally wrongly implemented.

Thanks for catching this error. Actually this would only effect the =20
"actual answer:" output field. The comparison between expected_answer =20=

and actual_answer in each individual test is still valid.

> Note that
> compiling with -Wall would give you a warning:
>
> | main.c: In function =91test_failed=92:
> | main.c:146:5: warning: format =91%llx=92 expects argument of type =20=

> =91long long unsigned int=92, but argument 2 has type =91uint32_t=92 =
[-=20
> Wformat=3D]
> |      printf("  actual answer: 0x%" PRIx64 "\n", actual_fpscr);
> |      ^
>

Replacing actual_fpscr with actual_answer should solve this problem.
