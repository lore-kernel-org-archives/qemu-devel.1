Received: from eggs.gnu.org ([2001:4830:134:3::10]:60080)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1cbVGJ-000628-05
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 11:38:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1cbVGE-0007Ce-TG
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 11:38:30 -0500
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:36329)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <shorne@gmail.com>) id 1cbVGE-0007CY-Ns
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 11:38:26 -0500
Received: by mail-pf0-x242.google.com with SMTP id 19so11998574pfo.3
	for <qemu-devel@nongnu.org>; Wed, 08 Feb 2017 08:38:26 -0800 (PST)
Date: Thu, 9 Feb 2017 01:38:23 +0900
From: Stafford Horne <shorne@gmail.com>
Message-ID: <20170208163823.GJ32144@lianli.shorne-pla.net>
References: <d27b7c60-a9fe-e92e-a937-d2d13b78f290@twiddle.net>
	<20170124102625.GF7836@lianli.shorne-pla.net>
	<01f7a18d-f4f5-18f3-0932-b32c06ad0b0c@twiddle.net>
	<20170125123430.GG7836@lianli.shorne-pla.net>
	<39f927aa-26fe-0e43-7c6b-efe1b70bc5fa@twiddle.net>
	<20170126131229.GB16014@lianli.shorne-pla.net>
	<ddb9c656-aa3e-5d90-c8fc-0058af5b603b@twiddle.net>
	<20170201100423.GE21641@lianli.shorne-pla.net>
	<d3dac109-ad39-8bb9-2012-f7a6824139eb@twiddle.net>
	<20170208140120.GI32144@lianli.shorne-pla.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170208140120.GI32144@lianli.shorne-pla.net>
Subject: Re: [Qemu-devel] [PATCH] target-openrisc: Fix exception handling
 status registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: Jia Liu <proljc@gmail.com>, qemu-devel@nongnu.org, openrisc@lists.librecores.org

Hello,

On Wed, Feb 08, 2017 at 11:01:20PM +0900, Stafford Horne wrote:
> On Mon, Feb 06, 2017 at 09:53:26PM -0800, Richard Henderson wrote:
> > On 02/01/2017 02:04 AM, Stafford Horne wrote:
> > > For kernel builds I have created toolchain binaries here:
> > > 
> > >   http://shorne.noip.me/crosstool/files/bin/x86_64/5.4.0/
> > > 
> > > These should work.
> > 
> > This gdb crashes on the first "stepi" that I issue.  To reproduce,
> > 
> > $ cat z.c
> > int main() { return 0; }
> > $ or1k-musl-linux-gcc -g z.c
> > $ qemu-or32 -g 10001 ./a.out
> > 
> > // another window
> > 
> > $ or1k-musl-linux-gdb ./a.out
> > (gdb) target remote localhost:10001
> > // should see that the pc is at _start
> > (gdb) stepi
> > // crash
> > 
> > I won't be able to debug this myself until I can build my own gdb.
> 
> Hello,
> 
> The gdb branch I use is the following, it is tracking very close to
> upsstream:
> 
>   git@github.com:stffrdhrn/binutils-gdb.git or1k-upstream
> 
> I have sent this for review to the gdb list and currently waiting on
> comments for version 4.  Most of the code is the same as in openrisc
> github. However, I have just rebased and cleaned up for upstreaming.
> 
> Note, I can get basic programs running fine on your qemu branch using
> linux-user i.e.
> 
>  $ cat main.c
>    #include <stdio.h>
> 
>    int main() {
>      printf("hello");
>      return 0;
>    }
>  $ or1k-linux-musl-gcc -g -static main.c
>  $ ./qemu/build/or32-linux-user/qemu-or32 ./a.out
>    hello
> 
> However, when debugging I ran into a few errors.
> 
>   1. qemu aborts the program and sends SIGILL to gdb, this is caused by
>      the openrisc loop in linux-user missing handlers for EXCP_INTERRUPT
>      and EXCP_DEBUG, I patched that see below:
>   2. After patching I got 1 step to work then gdb crashes with SIGSEGV
>      Currently looking at it, Interestingly the code that is failing is
> 
>        in gdb/or1k-tdep.c: or1k_single_step_through_delay()
>        cgen_lookup_insn() - returns NULL (shouldnt happen though)
>        then NULL is dereferenced
> 
>      Interesting because it seems you wrote cgen_lookup_insn :)
>      I am investigating more, but it seems like gdb issue.

OK, I think I fixed this cgen_lookup_insn issue.

Now I can debug qemu user:

  $ ./qemu/build/or32-linux-user/qemu-or32 -g 10001 ./a.out
  $ or1k-linux-musl-gdb ./a.out \
    --eval-command='target remote localhost:10001'
   Remote debugging using localhost:10001
   0x000020e4 in _start ()
   (gdb) si
   0x000020e8 in _start ()
   (gdb)

A bug was added there by Nick Clifton last year when he did some memory
allocation cleanups in cgen_lookup_insn(). It seems not much code uses
this so perhaps it was not noticed.

Also, it looks like you didnt write it, you just imported the original
source?

I have now pushed the fix to my repo.  At the same time pushing to
gdb-patches list.

-Stafford

> Notes on the debugger:
>   - The support for linux user processes is not implemented.  Eventually
>     I think it will crash somewhere.  But it shouldnt crash where it is.
>   - I tested the same program with the baremetal (newlib) toolchain
>      * gdb native sim - OK can debug
>      * or1ksim (via target remote) - Crashes same as QEMU
> 
