Received: from eggs.gnu.org ([209.51.188.92]:38610)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ggYd1-0003li-Ug
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 12:23:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ggYd0-00005i-Tk
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 12:23:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57938)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1ggYd0-0008WV-KF
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 12:23:54 -0500
Date: Mon, 7 Jan 2019 15:23:47 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20190107172347.GT4157@habkost.net>
References: <20181211192527.13254-1-ehabkost@redhat.com>
	<20181212090839.iuc5pebm7luitdsk@linux.intel.com>
	<20181212141233.GS7141@habkost.net>
	<20181213005231.753cnlhxnibmc5d2@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181213005231.753cnlhxnibmc5d2@linux.intel.com>
Subject: Re: [Qemu-devel] [PATCH] x86: host-phys-bits-limit option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yu Zhang <yu.c.zhang@linux.intel.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>, paul.c.lai@intel.com, qemu-devel@nongnu.org, Bandan Das <bsd@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>

On Thu, Dec 13, 2018 at 08:52:31AM +0800, Yu Zhang wrote:
> On Wed, Dec 12, 2018 at 12:12:33PM -0200, Eduardo Habkost wrote:
> > On Wed, Dec 12, 2018 at 05:08:39PM +0800, Yu Zhang wrote:
> > > On Tue, Dec 11, 2018 at 05:25:27PM -0200, Eduardo Habkost wrote:
> > > > Some downstream distributions of QEMU set host-phys-bits=on by
> > > > default.  This worked very well for most use cases, because
> > > > phys-bits really didn't have huge consequences. The only
> > > > difference was on the CPUID data seen by guests, and on the
> > > > handling of reserved bits.
> > > > 
> > > > This changed in KVM commit 855feb673640 ("KVM: MMU: Add 5 level
> > > > EPT & Shadow page table support").  Now choosing a large
> > > > phys-bits value for a VM has bigger impact: it will make KVM use
> > > > 5-level EPT even when it's not really necessary.  This means
> > > > using the host phys-bits value may not be the best choice.
> > > > 
> > > > Management software could address this problem by manually
> > > > configuring phys-bits depending on the size of the VM and the
> > > > amount of MMIO address space required for hotplug.  But this is
> > > > not trivial to implement.
> > > > 
> > > > However, there's another workaround that would work for most
> > > > cases: keep using the host phys-bits value, but only if it's
> > > > smaller than 48.  This patch makes this possible by introducing a
> > > > new "-cpu" option: "host-phys-bits-limit".  Management software
> > > > or users can make sure they will always use 4-level EPT using:
> > > > "host-phys-bits=on,host-phys-bits-limit=48".
> > > > 
> > > > This behavior is still not enabled by default because QEMU
> > > > doesn't enable host-phys-bits=on by default.  But users,
> > > > management software, or downstream distributions may choose to
> > > > change their defaults using the new option.
> > > > 
> > > > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> > > 
> > > Thanks, Eduardo. One question is, should we check host-phys-bits-limit
> > > against 48? If not, how about we just say in the commit message, that
> > > the suggested value of host-phys-bits-limit is no bigger than 48 to
> > > ensure a 4-level EPT? :-)
> > 
> > I'm not sure I understood the question.  I tried to document this
> > at:
> > 
> > |                                      [...]  Management software
> > | or users can make sure they will always use 4-level EPT using:
> > | "host-phys-bits=on,host-phys-bits-limit=48".
> > 
> 
> Oh, I was just saying that host-phys-bits-limit can be of any
> value less than 48, instead of just 48, to ensure a 4-level EPT.
> Not a big deal. I guess readers can get the point in your commit
> message.  
> 
> Another question is, should we check the value of host-phys-bits?
> Shall we accept values greater than 48(may be a useless configuration,
> but still acceptible), or less than 32? 

I'm not sure.  We can do that, but we can't just choose arbitrary
limits: we need to be able to and point to the specific
requirements/specifications behind them.

Setting host-phys-bits-limit > 48, for example, seems reasonable.
It would be useful to guarantee a VM is migratable to smaller
hosts.

Making sure phys-bits it is big enough to fit all RAM + MMIO
regions would be a good idea, though.  We would need the machine
code to ensure the address limits make sense.

-- 
Eduardo
