Received: from eggs.gnu.org ([2001:4830:134:3::10]:40268)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yu.c.zhang@linux.intel.com>) id 1gXFHr-0007gK-Mx
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 19:55:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yu.c.zhang@linux.intel.com>) id 1gXFHk-00038S-CE
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 19:55:33 -0500
Received: from mga05.intel.com ([192.55.52.43]:19852)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yu.c.zhang@linux.intel.com>)
	id 1gXFHj-00034y-T1
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 19:55:28 -0500
Date: Thu, 13 Dec 2018 08:52:31 +0800
From: Yu Zhang <yu.c.zhang@linux.intel.com>
Message-ID: <20181213005231.753cnlhxnibmc5d2@linux.intel.com>
References: <20181211192527.13254-1-ehabkost@redhat.com>
	<20181212090839.iuc5pebm7luitdsk@linux.intel.com>
	<20181212141233.GS7141@habkost.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181212141233.GS7141@habkost.net>
Subject: Re: [Qemu-devel] [PATCH] x86: host-phys-bits-limit option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>, paul.c.lai@intel.com, qemu-devel@nongnu.org, Bandan Das <bsd@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>

On Wed, Dec 12, 2018 at 12:12:33PM -0200, Eduardo Habkost wrote:
> On Wed, Dec 12, 2018 at 05:08:39PM +0800, Yu Zhang wrote:
> > On Tue, Dec 11, 2018 at 05:25:27PM -0200, Eduardo Habkost wrote:
> > > Some downstream distributions of QEMU set host-phys-bits=on by
> > > default.  This worked very well for most use cases, because
> > > phys-bits really didn't have huge consequences. The only
> > > difference was on the CPUID data seen by guests, and on the
> > > handling of reserved bits.
> > > 
> > > This changed in KVM commit 855feb673640 ("KVM: MMU: Add 5 level
> > > EPT & Shadow page table support").  Now choosing a large
> > > phys-bits value for a VM has bigger impact: it will make KVM use
> > > 5-level EPT even when it's not really necessary.  This means
> > > using the host phys-bits value may not be the best choice.
> > > 
> > > Management software could address this problem by manually
> > > configuring phys-bits depending on the size of the VM and the
> > > amount of MMIO address space required for hotplug.  But this is
> > > not trivial to implement.
> > > 
> > > However, there's another workaround that would work for most
> > > cases: keep using the host phys-bits value, but only if it's
> > > smaller than 48.  This patch makes this possible by introducing a
> > > new "-cpu" option: "host-phys-bits-limit".  Management software
> > > or users can make sure they will always use 4-level EPT using:
> > > "host-phys-bits=on,host-phys-bits-limit=48".
> > > 
> > > This behavior is still not enabled by default because QEMU
> > > doesn't enable host-phys-bits=on by default.  But users,
> > > management software, or downstream distributions may choose to
> > > change their defaults using the new option.
> > > 
> > > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> > 
> > Thanks, Eduardo. One question is, should we check host-phys-bits-limit
> > against 48? If not, how about we just say in the commit message, that
> > the suggested value of host-phys-bits-limit is no bigger than 48 to
> > ensure a 4-level EPT? :-)
> 
> I'm not sure I understood the question.  I tried to document this
> at:
> 
> |                                      [...]  Management software
> | or users can make sure they will always use 4-level EPT using:
> | "host-phys-bits=on,host-phys-bits-limit=48".
> 

Oh, I was just saying that host-phys-bits-limit can be of any
value less than 48, instead of just 48, to ensure a 4-level EPT.
Not a big deal. I guess readers can get the point in your commit
message.  

Another question is, should we check the value of host-phys-bits?
Shall we accept values greater than 48(may be a useless configuration,
but still acceptible), or less than 32? 

Thanks
Yu

> -- 
> Eduardo
> 
