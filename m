Received: from eggs.gnu.org ([2001:4830:134:3::10]:40889)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cfPFi-00014D-3f
	for qemu-devel@nongnu.org; Sun, 19 Feb 2017 06:02:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cfPFe-00064T-7S
	for qemu-devel@nongnu.org; Sun, 19 Feb 2017 06:02:02 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:57732)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1cfPFd-00064C-T2
	for qemu-devel@nongnu.org; Sun, 19 Feb 2017 06:01:58 -0500
References: <20170207183356.17840-1-laurent@vivier.eu>
	<20170207183356.17840-3-laurent@vivier.eu>
	<CAFEAcA8i8r4to8XmQwpd3h_7=tSUsu1qP9UHYcEd0vJSCo950w@mail.gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <f526e945-6957-1906-47fd-60bcbb9875ba@vivier.eu>
Date: Sun, 19 Feb 2017 12:01:54 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8i8r4to8XmQwpd3h_7=tSUsu1qP9UHYcEd0vJSCo950w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 2/5] m68k: implement server and client side
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

Le 18/02/2017 à 23:37, Peter Maydell a écrit :
> On 7 February 2017 at 18:33, Laurent Vivier <laurent@vivier.eu> wrote:
>> This also adds the basic test file and the configuration update.
>>
>> This implementation can only test instructions with values in register and
>> no memory access.
>>
>> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> 
> Hi; I got round to setting up my machine with an m68k cross
> compiler so I can at least compile-test the other target
> architectures, and I noticed this code generates compiler
> warnings:
> 
>> +/* reginfo_dump: print state to a stream, returns nonzero on success */
>> +void reginfo_dump(struct reginfo *ri, int is_master)
>> +{
>> +    int i;
>> +    if (is_master) {
>> +        fprintf(stderr, "  pc            \e[1;101;37m0x%08x\e[0m\n",
>> +                ri->pc);
>> +    }
>> +    fprintf(stderr, "\tPC: %08x\n", ri->gregs[R_PC]);
>> +    fprintf(stderr, "\tPS: %04x\n", ri->gregs[R_PS]);
>> +
>> +    for (i = 0; i < 8; i++) {
>> +        fprintf(stderr, "\tD%d: %8x\tA%d: %8x\n", i, ri->gregs[i],
>> +                i, ri->gregs[i + 8]);
>> +    }
>> +
>> +
>> +    for (i = 0; i < 8; i++) {
>> +        fprintf(stderr, "\tFP%d: %08x %08x %08x\n", i,
>> +                ri->fpregs.f_fpregs[i * 3], ri->fpregs.f_fpregs[i * 3 + 1],
>> +                ri->fpregs.f_fpregs[i * 3 + 2]);
> 
> /home/pm215/risu/risu_reginfo_m68k.c:95:37: warning: format ‘%x’
> expects argument of type ‘unsigned int’, but argument 4 has type ‘int
> *’ [-Wformat=]
>          fprintf(stderr, "\tFP%d: %08x %08x %08x\n", i,
>                                      ^
> 
> and similarly for the other 3 f_fpregs[] arguments here
> and in the fprintf calls in reginfo_dump_mismatch().
> 
> Looking at the m68k sys/ucontext.h its definition of
> struct fpregset is
> #ifdef __mcoldfire__
>   int f_fpregs[8][2];
> #else
>   int f_fpregs[8][3];
> #endif
> 
> so it's a 2d array, not a 1d array.

In fact, in etch-m68k, there are two definitions of fpregset:

/usr/include/sys/ucontext.h

typedef struct fpregset
{
  int f_fpregs[8][3];
  int f_pcr;
  int f_psr;
  int f_fpiaddr;
} fpregset_t;

/usr/include/asm/ucontext.h

typedef struct fpregset {
        int f_fpcntl[3];
        int f_fpregs[8*3];
} fpregset_t;

This is the one used by the kernel:

arch/m68k/include/asm/ucontext.h

typedef struct fpregset {
        int f_fpcntl[3];
        int f_fpregs[8*3];
} fpregset_t;

In the past, as the one from sys/ucontext.h was not compatible with the
one from the kernel, I have updated my system to use the one from the
kernel.

But in debian unstable, we have now:

typedef struct fpregset
{
  int f_pcr;
  int f_psr;
  int f_fpiaddr;
#ifdef __mcoldfire__
  int f_fpregs[8][2];
#else
  int f_fpregs[8][3];
#endif
} fpregset_t;

And this is compatible with the kernel one.

So I'm going to update the RISU code to use the 2d array.

Thanks,
Laurent
