Received: from eggs.gnu.org ([208.118.235.92]:39214)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <salvatore.bonaccorso@gmail.com>) id 1gen0N-00066t-Ue
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 15:20:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <salvatore.bonaccorso@gmail.com>) id 1gen0I-0004JK-SZ
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 15:20:43 -0500
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543]:34028)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <salvatore.bonaccorso@gmail.com>)
	id 1gen0I-0004GY-JW
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 15:20:38 -0500
Received: by mail-ed1-x543.google.com with SMTP id b3so27301517ede.1
	for <qemu-devel@nongnu.org>; Wed, 02 Jan 2019 12:20:36 -0800 (PST)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Date: Wed, 2 Jan 2019 21:20:32 +0100
From: Salvatore Bonaccorso <carnil@debian.org>
Message-ID: <20190102202032.GA1034@eldamar.local>
References: <20180719205545.16512-1-pasha.tatashin@oracle.com>
	<20180719205545.16512-24-pasha.tatashin@oracle.com>
	<20181106054212.GA31768@nautica>
	<95c3920e-bf80-0c7e-7854-01a1c3189c23@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95c3920e-bf80-0c7e-7854-01a1c3189c23@oracle.com>
Subject: Re: [Qemu-devel] [PATCH v15 23/26] sched: early boot clock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: Dominique Martinet <asmadeus@codewreck.org>, Pavel Tatashin <pavel.tatashin@microsoft.com>, daniel.m.jordan@oracle.com, linux@armlinux.org.uk, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, john.stultz@linaro.org, sboyd@codeaurora.org, x86@kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com, douly.fnst@cn.fujitsu.com, peterz@infradead.org, prarit@redhat.com, feng.tang@intel.com, pmladek@suse.com, gnomes@lxorguk.ukuu.org.uk, linux-s390@vger.kernel.org, boris.ostrovsky@oracle.com, jgross@suse.com, pbonzini@redhat.com, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, qemu-devel@nongnu.org

Hi,

On Tue, Nov 06, 2018 at 06:35:36AM -0500, Steven Sistare wrote:
> Pavel has a new email address, cc'd - steve
> 
> On 11/6/2018 12:42 AM, Dominique Martinet wrote:
> > (added various kvm/virtualization lists in Cc as well as qemu as I don't
> > know who's "wrong" here)
> > 
> > Pavel Tatashin wrote on Thu, Jul 19, 2018:
> >> Allow sched_clock() to be used before schec_clock_init() is called.
> >> This provides with a way to get early boot timestamps on machines with
> >> unstable clocks.
> > 
> > This isn't something I understand, but bisect tells me this patch
> > (landed as 857baa87b64 ("sched/clock: Enable sched clock early")) makes
> > a VM running with kvmclock take a step in uptime/printk timer early in
> > boot sequence as illustrated below. The step seems to be related to the
> > amount of time the host was suspended while qemu was running before the
> > reboot.
> > 
> > $ dmesg
> > ...
> > [    0.000000] SMBIOS 2.8 present.
> > [    0.000000] DMI: QEMU Standard PC (i440FX + PIIX, 1996), BIOS ?-20180724_192412-buildhw-07.phx2.fedoraproject.org-1.fc29 04/01/2014
> > [    0.000000] Hypervisor detected: KVM
> > [    0.000000] kvm-clock: Using msrs 4b564d01 and 4b564d00
> > [283120.529821] kvm-clock: cpu 0, msr 321a8001, primary cpu clock
> > [283120.529822] clocksource: kvm-clock: mask: 0xffffffffffffffff max_cycles: 0x1cd42e4dffb, max_idle_ns: 881590591483 ns
> > [283120.529824] tsc: Detected 2592.000 MHz processor
> > ...
> > 
> > (The VM is x86_64 on x86_64, I can provide my .config on request but
> > don't think it's related)
> > 
> > 
> > It's rather annoying for me as I often reboot VMs and rely on the
> > 'uptime' command to check if I did just reboot or not as I have the
> > attention span of a goldfish; I'd rather not have to find something else
> > to check if I did just reboot or not.
> > 
> > Note that if the qemu process is restarted, there is no offset anymore.
> > 
> > I unfortunately just did that so cannot say with confidence (putting my
> > laptop to sleep for 30s only led to a 2s offset and I do not want to
> > wait longer right now), but it looks like the clock is still mostly
> > correct after reboot after disabling my VM's ntp client. Will infirm
> > that tomorrow if I was wrong.
> > 
> > 
> > Happy to try to help fixing this in any way, as written above the quote
> > I'm not even actually sure who is wrong here.

A user in Debian reported the same/similar issue (with 4.19.13):

https://bugs.debian.org/918036

Regards,
Salvatore
