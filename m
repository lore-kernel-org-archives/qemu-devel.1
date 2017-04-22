Received: from eggs.gnu.org ([2001:4830:134:3::10]:48017)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1d1rzC-0003OW-95
	for qemu-devel@nongnu.org; Sat, 22 Apr 2017 06:09:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1d1rz9-00046S-1Y
	for qemu-devel@nongnu.org; Sat, 22 Apr 2017 06:09:50 -0400
Received: from mail-it0-x244.google.com ([2607:f8b0:4001:c0b::244]:32805)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <shorne@gmail.com>) id 1d1rz8-00046M-Pn
	for qemu-devel@nongnu.org; Sat, 22 Apr 2017 06:09:46 -0400
Received: by mail-it0-x244.google.com with SMTP id z67so3707564itb.0
	for <qemu-devel@nongnu.org>; Sat, 22 Apr 2017 03:09:46 -0700 (PDT)
Date: Sat, 22 Apr 2017 19:09:42 +0900
From: Stafford Horne <shorne@gmail.com>
Message-ID: <20170422100942.GA4797@lianli.shorne-pla.net>
References: <cover.1492384862.git.shorne@gmail.com>
	<fb69c137317a365dcb549dfef1ecd2fbff48e92c.1492384862.git.shorne@gmail.com>
	<6914f9b7-ece1-973d-2210-871b71319ae0@twiddle.net>
	<20170418142055.GB2599@lianli.shorne-pla.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170418142055.GB2599@lianli.shorne-pla.net>
Subject: Re: [Qemu-devel] [PATCH 2/7] target/openrisc: add shutdown logic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org, openrisc@lists.librecores.org, agraf@suse.de, wbx@openadk.org

On Tue, Apr 18, 2017 at 11:20:55PM +0900, Stafford Horne wrote:
> On Tue, Apr 18, 2017 at 12:52:52AM -0700, Richard Henderson wrote:
> > On 04/16/2017 04:23 PM, Stafford Horne wrote:
> > > In openrisc simulators we use hooks like 'l.nop 1' to cause the
> > > simulator to exit.  Implement that for qemu too.
> > > 
> > > Reported-by: Waldemar Brodkorb <wbx@openadk.org>
> > > Signed-off-by: Stafford Horne <shorne@gmail.com>
> > 
> > As I said the first time this was posted: This is horrible.
> > 
> > If you want to do something like this, it needs to be buried under a special
> > run mode like -semihosting.
> 
> Understood,  I will revise this.  I didnt know this was posted before.
> 
> > >          case 0x01:    /* l.nop */
> > >              LOG_DIS("l.nop %d\n", I16);
> > > +            {
> > > +                TCGv_i32 arg = tcg_const_i32(I16);
> > > +                gen_helper_nop(arg);
> > > +            }
> > 
> > You also really really must special-case l.nop 0 so that it doesn't generate
> > a function call.  Just think of all the extra calls you're adding for every
> > delay slot that couldn't be filled.
> 
> Yeah, that makes sense.  Ill add that for l.nop 0.

FYI,

I am going to drop this patch for now.  I think Waldemar can apply this
patch for the time being.

I looked through the semihosting route and I don't think poking l.nop
through there makes much sense since that looks mainly for syscalls.  I
also considered making another flag like `-or1k-hacks`, but I figured that
wouldnt be appropriate.

I discussed a bit on #qemu and Alexander Graf suggested to properly define
shutdown semantics for openrisc. Some examples were shown from ppc, s390
and arm.

  s390x
  http://git.qemu.org/?p=qemu.git;a=blob;f=target/s390x/helper.c;hb=HEAD#l265
  Detects the cpu is in WAIT state and shutsdown qemu.

  ppc - platform
  http://git.qemu.org/?p=qemu.git;a=blob;f=hw/ppc/e500.c;hb=HEAD#l936
  Registers hardware device mpc8xxx_gpio which handles shutdown via gpio

I will have a thought about this, it will require some kernel changes.

-Stafford
