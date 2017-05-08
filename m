Received: from eggs.gnu.org ([2001:4830:134:3::10]:43619)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1d7rTs-0002by-Bg
	for qemu-devel@nongnu.org; Mon, 08 May 2017 18:50:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1d7rTr-000151-5F
	for qemu-devel@nongnu.org; Mon, 08 May 2017 18:50:16 -0400
Date: Tue, 9 May 2017 00:50:07 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
Message-ID: <20170508225007.2duqxlo5ab2aenpl@aurel32.net>
References: <0F376E9C-2D4B-4D79-B3D4-24F73FD61446@gmail.com>
	<20170508221304.y36owezwla7sc6ss@aurel32.net>
	<BB3E29F1-8BBB-407B-AAC8-795E9718CF5E@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BB3E29F1-8BBB-407B-AAC8-795E9718CF5E@gmail.com>
Subject: Re: [Qemu-devel] Floating point unit bugs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: G 3 <programmingkidx@gmail.com>
Cc: "qemu-ppc@nongnu.org list:PowerPC" <qemu-ppc@nongnu.org>, "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>

On 2017-05-08 18:36, G 3 wrote:
> 
> On May 8, 2017, at 6:13 PM, Aurelien Jarno wrote:
> 
> > On 2017-05-07 17:48, G 3 wrote:
> > > I made a diagnostic program for the floating point unit. It will test
> > > various PowerPC floating point instructions for compatibility with
> > > the
> > > PowerPC G3 processor. It was tested on a PowerPC G3 and G5 system.
> > > The
> > > results of the program in qemu-system-ppc were pretty bad. About
> > > every
> > > instruction tested is not implemented correctly.
> > > 
> > > Here is the download link to the program: http://www.mediafire.com/file/6j9tqubvk73lkw1/floating_point_test_program.zip
> > 
> > Some comments on the code.
> > > 
> > >     /* Check if everything is alright */
> > >     uint32_t fpscr;
> > >     asm volatile("mffs f0");
> > >     asm volatile("stfd f0, 40(r1)");
> > >     asm volatile("lwz %0, 44(r1)" : "=r"(fpscr));
> > >     if (fpscr != 0) {
> > >         printf("Warning: fpscr not equal to zero: 0x%x\n", fpscr);
> > >     }
> > 
> > This is overly complicated and just doesn't compile with recent GCC
> > versions.
> 
> Which version of GCC had the problem? GCC 5.2 and GCC 3.3 seems to work
> fine. GCC 4.0 did not work. Could you send me the error message?

I tried with GCC 4.9. Actually the error message is coming from
binutils:

| main.c:34:5: warning: missing braces around initializer [-Wmissing-braces]
|      "FX", "Floating-point exception summary",
|      ^
| main.c:34:5: warning: (near initialization for 'finfo[0]') [-Wmissing-braces]
| main.c: In function 'print_fpscr_settings':
| main.c:73:26: warning: suggest parentheses around comparison in operand of '&' [-Wparentheses]
|          if ((fpscr >> i) & 0x1 == 1) {
|                           ^
| main.c: In function 'test_failed':
| main.c:146:5: warning: format '%llx' expects argument of type 'long long unsigned int', but argument 2 has type 'uint32_t' [-Wformat=]
|      printf("  actual answer: 0x%" PRIx64 "\n", actual_fpscr);
|      ^
| /tmp/cctHPRx4.s: Assembler messages:
| /tmp/cctHPRx4.s:315: Error: unsupported relocation against f0
| /tmp/cctHPRx4.s:318: Error: unsupported relocation against f0
| /tmp/cctHPRx4.s:318: Error: unsupported relocation against r1
| /tmp/cctHPRx4.s:321: Error: unsupported relocation against r1
| /tmp/cctHPRx4.s:438: Error: unsupported relocation against f0
| /tmp/cctHPRx4.s:441: Error: unsupported relocation against f0
| /tmp/cctHPRx4.s:441: Error: unsupported relocation against r1
| /tmp/cctHPRx4.s:444: Error: unsupported relocation against r1

> > What about something like:
> > 
> >     Converter c;
> >     asm volatile("mffs %0" : "=f"(c.d));
> >     fpscr = (uint32_t)c.i;
> 
> This way does work also.
> 
> > 
> > 
> > > /*
> > >  * The action to take if a test fails
> > >  * Input one: message string
> > >  * Input two: actual fpscr value
> > >  * Input three: expected fpscr value
> > >  * Input four: actual answer
> > >  * Input five: expected answer
> > >  */
> > >  void test_failed(const char *message, uint32_t actual_fpscr,
> > > uint32_t
> > > expected_fpscr,
> > >                   uint64_t actual_answer, uint64_t expected_answer)
> > >  {
> > >     printf("%s\n", message);
> > >     printf("expected answer: 0x%" PRIx64 "\n", expected_answer);
> > >     printf("  actual answer: 0x%" PRIx64 "\n", actual_fpscr);
> > 
> > This is wrong. It should be actual_answer instead of actual_fpscr. That
> > is why all the instructions seems totally wrongly implemented.
> 
> Thanks for catching this error. Actually this would only effect the "actual
> answer:" output field. The comparison between expected_answer and
> actual_answer in each individual test is still valid.

Indeed, but I guess it gives "better" results than what it looks when
looking at your mail where the values are totally wrong.

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
