Received: from eggs.gnu.org ([2001:4830:134:3::10]:42227)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gOkLV-0002Ex-El
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 09:16:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gOkLT-0005qa-Oa
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 09:16:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45642)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1gOkLT-0005q6-JC
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 09:16:11 -0500
Date: Mon, 19 Nov 2018 14:16:07 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20181119141606.GC2365@work-vm>
References: <20181119104330.GA2367@work-vm>
	<16966.1542632079@dschgrazlin2.units.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16966.1542632079@dschgrazlin2.units.it>
Subject: Re: [Qemu-devel] 3.1.0-rc{0,1} doesn't start
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: balducci@units.it
Cc: qemu-devel@nongnu.org

* balducci@units.it (balducci@units.it) wrote:
> hi
> 
> thanks for taking the time to reply
> 
> Dr. David Alan Gilbert writes:
> > > I suspect that this might be some problem on my side, as I couldn't
> > > find any similar report (apart some old (qemu-2.8.50) threads, that
> > > didn't help)
> >
> > Not necessarily; can you tell me:
> >   a) At what point does it fail - immediately when booting the guest?
> >      Some time during the boot? Later?
> >   b) What guest does it happen on?
> 
> a) the error happens almost immediately; I mean: when I run qemu from an
>    xterm, it doesn't even popup its window: it just dumps the error
>    message to the terminal and stops
> b) the guest is an old windows XP OS; but, as I say above, all goes as
>    if qemu doesn't even load the OS image (at least this is my
>    impression)

Thanks.

> Meantime, I have tried to (quick&dirty) disable the error
> catching/asserting in i386/kvm.c:
> 
> install:41> diff ./qemu-3.1.0-rc1/target/i386/kvm.c.MSR_HACK ./qemu-3.1.0-rc1/target/i386/kvm.c
> 2205c2205
> <     if (ret < cpu->kvm_msr_buf->nmsrs) {
> ---
> >     if (1==0) {
> 2211c2211
> <     assert(ret == cpu->kvm_msr_buf->nmsrs);
> ---
> >     assert(1==1);
> 2524c2524
> <     if (ret < cpu->kvm_msr_buf->nmsrs) {
> ---
> >     if (1==0) {
> 2530c2530
> <     assert(ret == cpu->kvm_msr_buf->nmsrs);
> ---
> >     assert(1==1);
> 
> and that makes qemu start and work without apparent problems.
> Of course, that is a crude and risky (I guess) workaround...

Yes, the gotcha is that the call writes a whole bunch of MSRs
and when one fails all the ones after it don't get written either;
so you get lots of weird problems due to whichever other MSRs
are wrong.

Dave

> thanks again
> 
> ciao
> -gabriele
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
