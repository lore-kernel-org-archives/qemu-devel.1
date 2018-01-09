Received: from eggs.gnu.org ([2001:4830:134:3::10]:46906)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1eYtq1-0002Xq-PW
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 08:21:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1eYtpy-0007Df-LM
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 08:21:09 -0500
Received: from mail.ispras.ru ([83.149.199.45]:42548)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1eYtpy-0007D8-CP
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 08:21:06 -0500
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
References: <20171116115926.16627-1-pbonzini@redhat.com>
	<20171116115926.16627-8-pbonzini@redhat.com>
	<CAFEAcA-06-VmH7Pvymo-o-HmiQ-uQ67Hs0KhWZfxswBxsfD2-g@mail.gmail.com>
	<bf4bedd9-0ef8-cff3-6153-531fba597237@redhat.com>
	<CAFEAcA9Rnd3gtrHb389e6fOEAae4aLhJnQWU-vKyzTM4o-riOQ@mail.gmail.com>
	<001b01d361e9$d46ace40$7d406ac0$@ru>
	<CAFEAcA8NGnmG_8SipvPN5_dPhokH2zZAXykN2KiW10XhB-9xXQ@mail.gmail.com>
	<CAFEAcA9PUOyK_vEnMKJkZV5s7o4zHDRedUY7z0ZH0i5ULEGzwg@mail.gmail.com>
In-Reply-To: <CAFEAcA9PUOyK_vEnMKJkZV5s7o4zHDRedUY7z0ZH0i5ULEGzwg@mail.gmail.com>
Date: Tue, 9 Jan 2018 16:21:05 +0300
Message-ID: <004401d3894c$b3fc90f0$1bf5b2d0$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-Language: ru
Subject: Re: [Qemu-devel] [PULL 07/11] cpu-exec: don't overwrite
 exception_index
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: 'Peter Maydell' <peter.maydell@linaro.org>
Cc: 'Paolo Bonzini' <pbonzini@redhat.com>, 'QEMU Developers' <qemu-devel@nongnu.org>, 'Pavel Dovgalyuk' <pavel.dovgaluk@ispras.ru>

> From: Peter Maydell [mailto:peter.maydell@linaro.org]
> On 20 November 2017 at 11:06, Peter Maydell <peter.maydell@linaro.org> wrote:
> > On 20 November 2017 at 10:25, Pavel Dovgalyuk <dovgaluk@ispras.ru> wrote:
> >>> From: Peter Maydell [mailto:peter.maydell@linaro.org]
> >>> On 17 November 2017 at 20:26, Paolo Bonzini <pbonzini@redhat.com> wrote:
> >>> > On 17/11/2017 21:07, Peter Maydell wrote:
> >>> >> Hi. This commit breaks booting of Debian on aarch64 virt board.
> >>> >> (repro instructions for creating the image available at:
> >>> >> https://translatedcode.wordpress.com/2017/07/24/installing-debian-on-qemus-64-bit-arm-
> virt-
> >>> board/)
> >>> >> The guest kernel never prints anything to the serial port.
> >>> >>
> >>> >> Reverting this commit fixes master for me, so I plan to do
> >>> >> that on Monday.
> >>> >
> >>> > Maybe you can also test moving the atomic_set inside the "if".  It does
> >>> > seem to be a genuine bugfix.
> >>>
> >>> No, that doesn't help: guest still sits there like a lemon.
> >>
> >> Maybe this is a more complex problem?
> >> I tried removing this if and aarch64 still does not work.
> >
> > Reverting the commit fixes it for me; I have that going through
> > build tests and will push the revert later today.
> 
> Revert pushed to git master.
> 
> More generally, this commit seems to assume that QEMU always
> does:
>  * set exception_index to something
>  * handle that
>  * clear exception_index to -1
> 
> but it's not clear to me that it's actually always the case
> that it gets cleared back to -1.

I tried to get some logs with the following code.
It prints that there was an exception 5 and it was overwritten by the standard code.
Fixed code prevents this overwrite.

I guess that one of the following is true:
 - unfixed version misses some exceptions
 - fixed version processes some exceptions twice (e.g., when there is no clear exception)

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 280200f..fa810f7 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -605,6 +605,8 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
     /* Finally, check if we need to exit to the main loop.  */
     if (unlikely(atomic_read(&cpu->exit_request)
         || (use_icount && cpu->icount_decr.u16.low + cpu->icount_extra == 0))) 
+        if (cpu->exception_index != -1 && cpu->exception_index != EXCP_INTERRUP
+            qemu_log("overwriting excp_index %x\n", cpu->exception_index);
         atomic_set(&cpu->exit_request, 0);
         cpu->exception_index = EXCP_INTERRUPT;
         return true;

Pavel Dovgalyuk
