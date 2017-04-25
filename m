Received: from eggs.gnu.org ([2001:4830:134:3::10]:56568)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1d31Ib-0003Ip-9Y
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 10:18:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1d31IV-0008RJ-Ji
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 10:18:37 -0400
Received: from mail-pf0-x22c.google.com ([2607:f8b0:400e:c00::22c]:35008)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <shorne@gmail.com>) id 1d31IV-0008R2-Ds
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 10:18:31 -0400
Received: by mail-pf0-x22c.google.com with SMTP id v14so24060824pfd.2
	for <qemu-devel@nongnu.org>; Tue, 25 Apr 2017 07:18:31 -0700 (PDT)
Date: Tue, 25 Apr 2017 23:18:27 +0900
From: Stafford Horne <shorne@gmail.com>
Message-ID: <20170425141827.GA2724@lianli.shorne-pla.net>
References: <ab4f029c-8264-7d35-b0e0-9b35a8e80d9d@twiddle.net>
	<20170423215420.27098-1-shorne@gmail.com>
	<f6a7d386-80a9-0cc3-e1ec-1b2058aa5bf9@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6a7d386-80a9-0cc3-e1ec-1b2058aa5bf9@twiddle.net>
Subject: Re: [Qemu-devel] [PATCH RFC] target/openrisc: Support non-busy idle
 state using PMR SPR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: QEMU Development <qemu-devel@nongnu.org>, Openrisc <openrisc@lists.librecores.org>

On Tue, Apr 25, 2017 at 12:11:00PM +0200, Richard Henderson wrote:
> On 04/23/2017 11:54 PM, Stafford Horne wrote:
> > The OpenRISC architecture has the Power Management Register (PMR)
> > special purpose register to manage cpu power states.  The interesting
> > modes are:
> > 
> >   * Doze Mode (DME) - Stop cpu except timer & pic - wake on interrupt
> >   * Sleep Mode (SME) - Stop cpu and all units - wake on interrupt
> >   * Suspend Model (SUME) - Stop cpu and all units - wake on reset
> > 
> > The linux kernel will set DME when idle.
> 
> And SUME would be, essentially, poweroff?  Perhaps at least for the purposes
> of QEMU; on real hardware one could press a button to assert reset and
> reboot.

Yes, that is what I am thinking, but I could add this later, after some
reviews with other OpenRISC folks.

> > Also, I don't know if its due to this patch of an issue with the timer
> > interrupts.  After applying this patch the timer interrupts do not trigger
> > until a keypress is make.  i.e. something like this...
> > 
> >    $ sleep 5
> >    <hangs forever until a key is pressed>
> ...
> > +            cpu_restore_state(cs, GETPC() + 4);
> 
> This isn't correct.  You want
> 
> 	cpu_restore_state(cs, GETPC());
> 	cs->env.pc += 4;
> 
> So what's happening is that you're re-executing the MTSPR and going back to
> sleep again.  Which probably explains the hang.

I have changed to the above, but I think its essentially the same.  It
resumes after the MTSPR in both cases.

I fixed this now though, you should see another patch.  The issue is the
timer events get ignored once the cpu is in halt state, I added a
qemu_cpu_kick() call in the timer hardware to wake up the cpu on timer
interrupts.  Not sure if thats the best way to do it, but it works 100%
now.

-Stafford
