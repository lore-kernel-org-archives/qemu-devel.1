Received: from eggs.gnu.org ([209.51.188.92]:55772)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasha.tatashin@soleen.com>) id 1ggfp9-0000Tn-Lr
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 20:04:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasha.tatashin@soleen.com>) id 1ggfp8-0004rq-1O
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 20:04:55 -0500
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543]:36220)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pasha.tatashin@soleen.com>)
	id 1ggfp7-0004nh-Mx
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 20:04:53 -0500
Received: by mail-ed1-x543.google.com with SMTP id f23so2640461edb.3
	for <qemu-devel@nongnu.org>; Mon, 07 Jan 2019 17:04:53 -0800 (PST)
MIME-Version: 1.0
References: <20180719205545.16512-1-pasha.tatashin@oracle.com>
	<20180719205545.16512-24-pasha.tatashin@oracle.com>
	<20181106054212.GA31768@nautica>
	<95c3920e-bf80-0c7e-7854-01a1c3189c23@oracle.com>
	<20190102202032.GA1034@eldamar.local>
	<CA+CK2bC70pnL0Wimb0xt99J4nNfi8W3zuUHgAk-jsPuOP9jpHA@mail.gmail.com>
	<20190103234339.GA17457@nautica>
	<CA+CK2bDj1f=VpT+k-e8kSSaoLJ3W9-JPPq9udFdDwd6ijXi28g@mail.gmail.com>
	<20190107234839.GA15269@nautica>
In-Reply-To: <20190107234839.GA15269@nautica>
From: Pavel Tatashin <pasha.tatashin@soleen.com>
Date: Mon, 7 Jan 2019 20:04:41 -0500
Message-ID: <CA+CK2bD3kbcNvkVf2kiKQYs+srcw7BdWngqt_wM7Z-QsBJyH6w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v15 23/26] sched: early boot clock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: Salvatore Bonaccorso <carnil@debian.org>, Steven Sistare <steven.sistare@oracle.com>, Pavel Tatashin <pavel.tatashin@microsoft.com>, Daniel Jordan <daniel.m.jordan@oracle.com>, linux@armlinux.org.uk, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, John Stultz <john.stultz@linaro.org>, sboyd@codeaurora.org, x86@kernel.org, LKML <linux-kernel@vger.kernel.org>, mingo@redhat.com, Thomas Gleixner <tglx@linutronix.de>, hpa@zytor.com, douly.fnst@cn.fujitsu.com, Peter Zijlstra <peterz@infradead.org>, prarit@redhat.com, feng.tang@intel.com, Petr Mladek <pmladek@suse.com>, gnomes@lxorguk.ukuu.org.uk, linux-s390@vger.kernel.org, boris.ostrovsky@oracle.com, jgross@suse.com, pbonzini@redhat.com, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, qemu-devel@nongnu.org

I did exactly the same sequence on Kaby Lake CPU and could not
reproduce it. What is your host CPU?

Thank you,
Pasha

On Mon, Jan 7, 2019 at 6:48 PM Dominique Martinet
<asmadeus@codewreck.org> wrote:
>
> Pavel Tatashin wrote on Mon, Jan 07, 2019:
> > I could not reproduce the problem. Did you suspend to memory between
> > wake ups? Does this time jump happen every time, even if your laptop
> > sleeps for a minute?
>
> I'm not sure I understand "suspend to memory between the wake ups".
> The full sequence is:
>  - start a VM (just in case, I let it boot till the end)
>  - suspend to memory (aka systemctl suspend) the host
>  - after resuming the host, soft reboot the VM (login through
> serial/ssh/whatever and reboot or in the qemu console 'system_reset')
>
> I've just slept exactly one minute and reproduced again with the fedora
> stock kernel now (4.19.13-300.fc29.x86_64) in the VM.
>
> Interestingly I'm not getting the same offset between multiple reboots
> now despite not suspending again; but if I don't suspend I cannot seem
> to get it to give an offset at all (only tried for a few minutes; this
> might not be true) ; OTOH I pushed my luck further and even with a five
> seconds sleep I'm getting a noticeable offset on first VM reboot after
> resume:
>
> [    0.000000] Hypervisor detected: KVM
> [    0.000000] kvm-clock: Using msrs 4b564d01 and 4b564d00
> [  179.362163] kvm-clock: cpu 0, msr 13c01001, primary cpu clock
> [  179.362163] clocksource: kvm-clock: mask: 0xffffffffffffffff max_cycles: 0x1cd42e4dffb, max_idle_ns: 881590591483 ns
>
> Honestly not sure what more information I could give, I'll try on some
> other hardware than my laptop (if I can get a server to resume after
> suspend through ipmi or wake on lan); but I don't have anything I could
> install ubuntu on to try their qemu's version... although I really don't
> want to believe that's the difference...
>
> Thanks,
> --
> Dominique
