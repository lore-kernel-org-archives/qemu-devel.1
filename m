Received: from eggs.gnu.org ([2001:4830:134:3::10]:39103)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1eldIc-0002bR-1a
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 11:19:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1eldIV-0006S6-LU
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 11:19:18 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36324 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1eldIV-0006Rt-Ew
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 11:19:11 -0500
Date: Tue, 13 Feb 2018 17:19:08 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180213171908.412fe2fd@redhat.com>
In-Reply-To: <325f459a-96ed-75fc-53d1-a62943237075@redhat.com>
References: <1516117900-11382-1-git-send-email-stefanb@linux.vnet.ibm.com>
	<1516117900-11382-5-git-send-email-stefanb@linux.vnet.ibm.com>
	<1e1dd3a3-7d87-38b1-cab3-5be375787896@linux.vnet.ibm.com>
	<20180212194531.GA26349@morn.lan>
	<5345fb74-02cf-9793-78d7-490e5e77ad27@linux.vnet.ibm.com>
	<20180213135739.3fd6fad6@redhat.com>
	<46a90b58-33e0-d17b-e81a-98d10f73a957@redhat.com>
	<20180213151753.7a2bb2be@redhat.com>
	<325f459a-96ed-75fc-53d1-a62943237075@redhat.com>
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
To: Laszlo Ersek <lersek@redhat.com>
Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>, Kevin O'Connor <kevin@koconnor.net>, marcandre.lureau@redhat.com, qemu-devel@nongnu.org, mst@redhat.com

On Tue, 13 Feb 2018 16:39:01 +0100
Laszlo Ersek <lersek@redhat.com> wrote:

> On 02/13/18 15:17, Igor Mammedov wrote:
> > On Tue, 13 Feb 2018 14:31:41 +0100
> > Laszlo Ersek <lersek@redhat.com> wrote:
> >   
> >> On 02/13/18 13:57, Igor Mammedov wrote:  
> >>> On Mon, 12 Feb 2018 15:17:21 -0500
> >>> Stefan Berger <stefanb@linux.vnet.ibm.com> wrote:
> >>>     
> >>>> On 02/12/2018 02:45 PM, Kevin O'Connor wrote:    
> >>>>> On Fri, Feb 09, 2018 at 03:19:31PM -0500, Stefan Berger wrote:      
> >>>>>> I have played around with this patch and some modifications to EDK2. Though
> >>>>>> for EDK2 the question is whether to try to circumvent their current
> >>>>>> implementation that uses SMM or use SMM. With this patch so far I circumvent
> >>>>>> it, which is maybe not a good idea.
> >>>>>>
> >>>>>> The facts for EDK2's PPI:
> >>>>>>
> >>>>>> - from within the OS a PPI code is submitted to ACPI and ACPI enters SMM via
> >>>>>> an SMI and the PPI code is written into a UEFI variable. For this ACPI uses
> >>>>>> the memory are at 0xFFFF 0000 to pass parameters from the OS (via ACPI) to
> >>>>>> SMM. This is declared in ACPI with an OperationRegion() at that address.
> >>>>>> Once the machine is rebooted, UEFI reads the variable and finds the PPI code
> >>>>>> and reacts to it.      
> >>>>> I'm a bit confused by this.  The top 1M of the first 4G of ram is
> >>>>> generally mapped to the flash device on real machines.  Indeed, this
> >>>>> is part of the mechanism used to boot an X86 machine - it starts
> >>>>> execution from flash at 0xfffffff0.  This is true even on modern
> >>>>> machines.
> >>>>>
> >>>>> So, it seems strange that UEFI is pushing a code through a memory
> >>>>> device at 0xffff0000.  I can't see how that would be portable.  Are
> >>>>> you sure the memory write to 0xffff0000 is not just a trigger to
> >>>>> invoke the SMI?      
> >>>>
> >>>> I base this on the code here:
> >>>>
> >>>> https://github.com/tianocore/edk2/blob/master/SecurityPkg/Tcg/Tcg2Smm/Tpm.asl#L81
> >>>>
> >>>> OperationRegion (TNVS, SystemMemory, 0xFFFF0000, 0xF0)    
> >>> Is the goal to reuse EDK PPI impl. including ASL?    
> >>
> >> Right, that is one important question. Some code in edk2 is meant only
> >> as example code (so actual firmware platforms are encouraged to copy &
> >> customize the code, or use similar or dissimilar alternatives). Some
> >> modules are meant for inclusion "as-is" in the platform description
> >> files (~ makefiles). There are so many edk2 modules related to TPM
> >> (several versions of the specs even) that it's hard to say what is meant
> >> for what usage type. (By my earlier count, there are 19 modules.)
> >>  
> >>> If it's so, then perhaps we only need to write address into QEMU
> >>> and let OVMF to discard PPI SSDT from QEMU.    
> >>
> >> That's something I would not like. When running on QEMU, it's OK for
> >> some edk2 modules to install their own ACPI tables, but only if they are
> >> "software" tables, such as the IBFT for iSCSI booting, BGRT (boot
> >> graphics table) for the boot logo / splash screen, etc. For ACPI tables
> >> that describe hardware (data tables) or carry out actions related to
> >> hardware (DefinitionBlocks / AML), I much prefer QEMU to generate all
> >> the stuff.
> >>
> >> If there is a conflict between hardware-related tables that QEMU
> >> generates and similar tables that pre-exist in edk2, I prefer working
> >> with the edk2 maintainers to customize their subsystems, so that a
> >> concrete firmware platform, such as OvmfPkg and ArmVirtPkg, can
> >> conditionalize / exclude those preexistent ACPI tables, while benefiting
> >> from the rest of the code. Then the ACPI linker/loader client used in
> >> both OvmfPkg and ArmVirtPkg can remain dumb and process & expose
> >> whatever tables QEMU generates.
> >>
> >> We could control the AML payload for TPM and/or TPM PPI -- e.g. whether
> >> it should raise an SMI -- via "-device tpm2,smi=on", for example. (Just
> >> making up the syntax, but you know what I mean.)
> >>
> >> We could go one step further, "-device tpm2,acpi=[on|off]". acpi=on
> >> would make QEMU generate the TPM related tables (perhaps targeting only
> >> SeaBIOS, if that makes sense), acpi=off would leave the related tables
> >> to the firmware.
> >>
> >> This is just speculation on my part; the point is I'd like to avoid any
> >> more "intelligent filtering" regarding ACPI tables in OVMF. What we have
> >> there is terrible enough already.  
> > If we could discard EDK's generated tables, it's fine as well,
> > but we would need to model TPM device model to match EDK's one
> > (risk here is that implementation goes of sync, if it's not spec
> > dictated). Then SeaBIOS side could 're-implement' it using
> > the same set of tables from QEMU.
> > 
> > I wonder if we could somehow detect firmware flavor we are
> > running on from ASL /wrt [no]using SMI/?
> >  * I don't really like idea but we can probably detect
> >    in QEMU if firmware is OVMF or not and generate extra SMI hunk
> >    based on that.
> >  * or we could always generate SMI code and probe for some
> >    EDK specific SSDT code to see in AML to enable it.
> >    Maybe OVMF could inject such table.  
> 
> There are already several QEMU artifacts that are specific to OVMF, but
> none of them is a full match for this purpose:
> 
> * "-machine smm=on" means that SMM emulation is enabled. However, this
> is automatically done for Q35, and it happens regardless of firmware. So
> basing the decision on this is no good.
> 
> * One (or much more frequently, two) pflash devices usually indicate
> OVMF (as opposed to SeaBIOS, which is selected with -L, or with -bios,
> or by default). However, the same pflash setup is appropriate for i440fx
> machine types too, which lack SMM emulation.
> 
> * The "-global driver=cfi.pflash01,property=secure,value=on" flag means
> that QEMU should restrict pflash write access to guest code that runs in
> SMM. This is required for making the UEFI variable store actually
> secure, but a user might have any reason for *not* specifying this flag
> (while keeping SMM emulation generally enabled, with "-machine smm=on").
> This looks like the closest match, but still not a 100% match.
> 
> * OVMF generally negotiates "SMI broadcast", but the user can prevent
> that too on the QEMU command line.
> 
> ... I really think SMM is a red herring here. We've established several
> times that the PPI opcodes need no protection. SMM is an implementation
> detail in edk2, and it is used *only* because there is no other way for
> AML code to enter (invoke) the firmware. In other words, this is simply
> a "firmware calling convention" for AML code -- prepare a request buffer
> and raise an SMI.
> 
> A valid alternative would be if we provided native OS drivers for a new
> ACPI device (both for Windows and Linux), and used Notify() in the
> TPM-related AML. Then the ACPI code could call back into the native OS
> driver, and *that* driver could then use the regular interface to the
> UEFI variable services (for example), without having to care about SMM
> explicitly. (Note that I'm not actually suggesting this; I'd just like
> to show that SMM is accidental here, not inherent.)
Yep, relying on detecting SMM or pflash or ... is not really reliable.

What about my proposal for PPI enabled OVMF to inject an additional
SSDT table with a variable ex:
  firmware_ovmf = 1

then in QEMU generated tables we can probe for it in runtime
when OSPM executes method and trigger SMI if variable exists.


> 
> Thanks
> Laszlo
