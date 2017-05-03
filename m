Received: from eggs.gnu.org ([2001:4830:134:3::10]:43849)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1d5yx1-0001Yb-07
	for qemu-devel@nongnu.org; Wed, 03 May 2017 14:24:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1d5ywx-00061u-05
	for qemu-devel@nongnu.org; Wed, 03 May 2017 14:24:34 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:49007)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1d5yww-00061b-P6
	for qemu-devel@nongnu.org; Wed, 03 May 2017 14:24:30 -0400
Date: Wed, 3 May 2017 14:24:29 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20170503182429.GA26661@flamenco>
References: <20170502192300.2124-1-rth@twiddle.net>
	<6d583a19-0134-3332-e116-dba4ed2e758e@twiddle.net>
	<20170503155107.GA13895@flamenco>
	<5218784b-4657-85fe-9ea2-a898d4609ced@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5218784b-4657-85fe-9ea2-a898d4609ced@twiddle.net>
Subject: Re: [Qemu-devel] [PATCH v6 00/25] tcg cross-tb optimizations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org

On Wed, May 03, 2017 at 09:27:54 -0700, Richard Henderson wrote:
> On 05/03/2017 08:51 AM, Emilio G. Cota wrote:
> >On Tue, May 02, 2017 at 20:36:52 -0700, Richard Henderson wrote:
> >>On 05/02/2017 12:22 PM, Richard Henderson wrote:
> >>>Changes since v5:
> >>...
> >>>   * Alpha frontend patch rewritten; the former patch appears to
> >>>     drop clock interrupts, not exiting the kernel's idle loop.
> >>>     I never *really* figured out why, since both patches seem
> >>>     to annotate the same TBs in the same way.
> >>
> >>There's definitely something odd going on.
> >>
> >>With a rebuild from scratch, the same symptoms have re-appeared for Alpha.
> >>So it really had nothing to do with the original patch.  I'm at a bit of a
> >>loss...
> >
> >I can reliably reproduce a freeze upon booting.
> 
> Oh good.  Sort of.  The oddly non-reproducible nature of this for me has
> been disconcerting.

I'm booting this image:
  https://gmplib.org/~tege/qemu/images/alpha/disk.img.xz
with this kernel:
  https://gmplib.org/~tege/qemu/images/alpha/vmlinux
invoking with:
  $ qemu-system-alpha -m 512 -drive file=disk.img,media=disk,format=raw,index=0 \
	-kernel vmlinux -append "root=/dev/sda2" [-accel accel=tcg,thread=multi]
I got the above from https://gmplib.org/~tege/qemu.html

I can reproduce reliably with either thread=single or =multi. When booting,
it stops for a few seconds  at "Key type dns_resolver registered"; then it
prints a few more lines to then stop for a while at
"sd 0:0:0:0: [sda] Attached SCSI disk". If I wait long enough, it
does boot. However, without the chaining patch it boots in a few seconds.

> >Interestingly, if I leave the lookup_and_goto_ptr above (s/#if 0/#if 1/), but
> >change the lookup_ptr helper to bypass tb_jmp_cache and directly check the
> >htable, it boots OK.
> 
> Now that *is* odd.  However ...
> 
> >Could it be that we're forgetting to clear (or set) tb_jmp_cache somewhere?
> 
> ... even that should not affect the setting (or clearing) of
> cpu->icount_decr.u16.high.  Which should have been set by
> tcg_handle_interrupt.  We should have exited the chain of TBs at some point.
> 
> Which to me means there's some deeper issue.  I.e. the only reason it's been
> working to date so far is that previously we never put together chains of
> any great length.

Yes, this is my hypothesis as well.

		E.
