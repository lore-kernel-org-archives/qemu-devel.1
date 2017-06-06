Received: from eggs.gnu.org ([2001:4830:134:3::10]:42956)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dIHEr-0004EJ-QN
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 12:21:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dIHEq-0008Jo-E6
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 12:21:49 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:59368)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dIHEq-0008C0-7U
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 12:21:48 -0400
Date: Tue, 6 Jun 2017 18:21:01 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
Message-ID: <20170606162101.fa6gu2usiwgujllt@aurel32.net>
References: <f0c4de76-77a7-90c4-6a99-10ddda953b19@landley.net>
	<20170518190052.qxzzcpurulnghlog@aurel32.net>
	<53613c44-1785-28f1-ae60-22adac96c8ad@landley.net>
	<20170518230141.75xhr7mul6lci3sj@aurel32.net>
	<766ffd59-4913-9bb8-6760-4de66af92ade@landley.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <766ffd59-4913-9bb8-6760-4de66af92ade@landley.net>
Subject: Re: [Qemu-devel] qemu-system-sh4 -M r2d serial is broken.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Rob Landley <rob@landley.net>
Cc: qemu-devel@nongnu.org, Rich Felker <dalias@libc.org>

On 2017-06-05 17:29, Rob Landley wrote:
> On 05/18/2017 06:01 PM, Aurelien Jarno wrote:
> > On 2017-05-18 17:37, Rob Landley wrote:
> >> On 05/18/2017 02:00 PM, Aurelien Jarno wrote:
> >>> On 2017-05-18 11:08, Rob Landley wrote:
> >>>> Serial input hangs after the first character in the 4.11 kernel:
> >>>>
> >>>>   http://www.spinics.net/lists/linux-sh/msg51183.html
> >>>>
> >>>> Because they enabled support for a buffer size thing QEMU doesn't
> >>>> emulate right:
> >>>>
> >>>>   http://www.spinics.net/lists/linux-sh/msg51189.html
> >>>
> >>> Indeed the SCIF emulation in QEMU is quite limited. The problem is that
> >>> it exposes many internal states to the software (and that's the same for
> >>> the SH4 CPU in general), and that's not really compatible with quick
> >>> emulation. In that case the timer should depend on the baud rate which
> >>> we don't really emulate.
> >>>
> >>> I'll try to have a look, that said my test environment is stuck with
> >>> kernel 4.8 due to the broken futex support on UP in kernel 4.9 (and
> >>> that's not QEMU specific). I'll try to build a more recent kernel with
> >>> additional patches.
> >>
> >> I thought Rich fixed that. Rich?
> > 
> > I have sent a patch already, but TTBOMK it hasn't been applied yet.
> > 
> > Aurelien
> 
> I poked Rich about the futex patch again today, he's been buried up to
> his neck in work but has to flush his bugfix queue before -rc5 so that
> should get sorted this week.

Thanks!

> Also, how do I tell the kernel to read the persistent clock on r2d? Both
> CONFIG_RTC_DRV_R9701 (from r2d defconfig) and CONFIG_RTC_DRV_SH give
> error messages and fail to read anything at boot time.

The R2D has such a RTC chip, but it is not emulated in QEMU. Someone has
to write it.

> If you need a new test environment (simple one that doesn't use futexes
> that I'm aware of) https://github.com/landley/mkroot is nearing its
> first release. You'll need to follow the README instructions to build
> musl-cross-make toolchains and set up the mcm symlink, but then:
> 
>   ./cross.sh sh4 ./mkroot.sh kernel
>   cd output/sh4
>   ./qemu-sh4.sh
>
> Should boot you to a shell prompt. And given that the root filesystem
> builder (mkroot.sh) is ~300 lines of bash and module/kernel is another
> 300 lines (mostly a big target-specific if/else staircase), it shouldn't
> be too hard to pull apart. :)

Ok, thanks.

> Right now sh4 is the only target in the release list that hasn't got the
> full "boots to a shell prompt and exits when you type exit, clock is set
> to correct time, block device works, network card works" functionality
> list. (That's all working on arm64 armv5l armv7l i486 i686 mips mipsel
> powerpc s390x x86-64.)

Patches to fix that are welcome.

Aurelien

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
