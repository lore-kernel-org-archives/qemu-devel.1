Received: from eggs.gnu.org ([2001:4830:134:3::10]:58177)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ela9l-0002D2-Dl
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 07:58:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ela9h-0002CB-2K
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 07:57:57 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41282 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1ela9g-0002Bo-TS
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 07:57:52 -0500
Date: Tue, 13 Feb 2018 13:57:39 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180213135739.3fd6fad6@redhat.com>
In-Reply-To: <5345fb74-02cf-9793-78d7-490e5e77ad27@linux.vnet.ibm.com>
References: <1516117900-11382-1-git-send-email-stefanb@linux.vnet.ibm.com>
	<1516117900-11382-5-git-send-email-stefanb@linux.vnet.ibm.com>
	<1e1dd3a3-7d87-38b1-cab3-5be375787896@linux.vnet.ibm.com>
	<20180212194531.GA26349@morn.lan>
	<5345fb74-02cf-9793-78d7-490e5e77ad27@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 4/4] acpi: build TPM Physical Presence
 interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: Kevin O'Connor <kevin@koconnor.net>, marcandre.lureau@redhat.com, lersek@redhat.com, qemu-devel@nongnu.org, mst@redhat.com

On Mon, 12 Feb 2018 15:17:21 -0500
Stefan Berger <stefanb@linux.vnet.ibm.com> wrote:

> On 02/12/2018 02:45 PM, Kevin O'Connor wrote:
> > On Fri, Feb 09, 2018 at 03:19:31PM -0500, Stefan Berger wrote:  
> >> I have played around with this patch and some modifications to EDK2. Though
> >> for EDK2 the question is whether to try to circumvent their current
> >> implementation that uses SMM or use SMM. With this patch so far I circumvent
> >> it, which is maybe not a good idea.
> >>
> >> The facts for EDK2's PPI:
> >>
> >> - from within the OS a PPI code is submitted to ACPI and ACPI enters SMM via
> >> an SMI and the PPI code is written into a UEFI variable. For this ACPI uses
> >> the memory are at 0xFFFF 0000 to pass parameters from the OS (via ACPI) to
> >> SMM. This is declared in ACPI with an OperationRegion() at that address.
> >> Once the machine is rebooted, UEFI reads the variable and finds the PPI code
> >> and reacts to it.  
> > I'm a bit confused by this.  The top 1M of the first 4G of ram is
> > generally mapped to the flash device on real machines.  Indeed, this
> > is part of the mechanism used to boot an X86 machine - it starts
> > execution from flash at 0xfffffff0.  This is true even on modern
> > machines.
> >
> > So, it seems strange that UEFI is pushing a code through a memory
> > device at 0xffff0000.  I can't see how that would be portable.  Are
> > you sure the memory write to 0xffff0000 is not just a trigger to
> > invoke the SMI?  
> 
> I base this on the code here:
> 
> https://github.com/tianocore/edk2/blob/master/SecurityPkg/Tcg/Tcg2Smm/Tpm.asl#L81
> 
> OperationRegion (TNVS, SystemMemory, 0xFFFF0000, 0xF0)
Is the goal to reuse EDK PPI impl. including ASL?

If it's so, then perhaps we only need to write address into QEMU
and let OVMF to discard PPI SSDT from QEMU.

>     Stefan
> 
> >
> > -Kevin
> >  
> 
> 
