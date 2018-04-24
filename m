Received: from eggs.gnu.org ([2001:4830:134:3::10]:47221)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fAzoV-0007Fi-Mc
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 11:25:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fAzoS-0006up-EC
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 11:25:03 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50642 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1fAzoS-0006u0-8O
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 11:25:00 -0400
Date: Tue, 24 Apr 2018 17:24:48 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180424172448.7bac4f71.cohuck@redhat.com>
In-Reply-To: <23067740-ed72-25f0-42e3-21b56019525e@redhat.com>
References: <152406338081.5947.5696498314762417499@sif>
	<6bb9731f-013d-018d-0b6e-c6dc55570f1f@redhat.com>
	<72d4dd49-19a2-2e24-48f0-7b81dc42e728@redhat.com>
	<23067740-ed72-25f0-42e3-21b56019525e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [ANNOUNCE] QEMU 2.12.0-rc4 is now available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, peter.maydell@linaro.org, Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>, Michael Clark <mjc@sifive.com>, Richard Henderson <richard.henderson@linaro.org>

On Tue, 24 Apr 2018 15:56:14 +0200
Laszlo Ersek <lersek@redhat.com> wrote:

> On 04/24/18 15:39, Eric Blake wrote:
> > On 04/24/2018 07:46 AM, Laszlo Ersek wrote:
> >   
> >> I just noticed two QAPI bugs introduced in 2.12, in the following two
> >> commits:
> >>
> >> (1) ca230ff33f89 ("qmp: add architecture specific cpu data for
> >> query-cpus-fast", 2018-02-26)
> >>
> >> This commit added @arch to @CpuInfoFast, but it failed to set the new
> >> field to CPU_INFO_ARCH_OTHER in qmp_query_cpus_fast(), when TARGET_S390X
> >> is not defined.  
> > 
> > We zero-initialize info->value, and info->value->arch == 0 happens to be
> > CPU_INFO_ARCH_X86 which is associated with the empty type CpuInfoOther,
> > which is no different than what we would have had with
> > CPU_INFO_ARCH_OTHER.  So the drawback is that on x86 architectures,
> > things look correct; while on sparc, ppc, mips, and tricore (which have
> > a specific type) and on all other platforms (which should use "other"),
> > the output wrongly reports "arch":"x86" but does not crash.  
> 
> I agree.

As an exercise for the reader: Figure out on which architectures I
tried this out... (Hint: one starts with s and ends with x, while the
other one starts with x.)

> 
> >   
> >>
> >> (2) 25fa194b7b11 ("RISC-V Build Infrastructure", 2018-03-07)
> >>
> >> This commit added the @riscv enum constant to @CpuInfoArch (used in both
> >> @CpuInfo and @CpuInfoFast -- the return types of the @query-cpus and
> >> @query-cpus-fast commands, respectively), and assigned, in both return
> >> structures, the @CpuInfoRISCV sub-structure to the new enum value.  
> > 
> > Ouch - we SHOULD have used 'CpuInfoOther' rather than 'CpuInfoRISCV' for
> > @CpuInfoFast.  We do NOT want to report the 'pc' field in the fast query.  
> 
> Right.
> 
> >>
> >> However, qmp_query_cpus_fast() does not populate the sub-structure, when
> >> TARGET_RISCV is defined; only qmp_query_cpus() does.  
> > 
> > Indeed, the output wrongly reports "arch":"x86" instead of
> > "arch":"riscv" - but at least things do not crash.
> >   
> >>
> >> The fixes don't look complicated. Do you want to hold the release while
> >> I post the fixes?
> >>
> >> I don't think these bugs are "show stoppers". On the other hand, QAPI is
> >> an external interface.  
> > 
> > It's too late for the 2.12 release.  We'll definitely fix things in
> > 2.12.1 (so cc the patches to qemu-stable),  
> 
> OK, will do.
> 
> > and should document in the
> > release notes that query-cpus-fast is known to report bogus "arch" data
> > for all architectures except x86 and s390, so applications should be
> > careful to not rely on the bogus information.  
> 
> <https://wiki.qemu.org/ChangeLog/2.12#Known_issues> refers to
> <https://wiki.qemu.org/Planning/2.12>, so I've added the above sentence
> to <https://wiki.qemu.org/Planning/2.12#Issues_that_will_not_be_fixed>.

The wiki updates look good to me.
