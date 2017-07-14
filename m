Received: from eggs.gnu.org ([2001:4830:134:3::10]:55290)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dW4x4-0005Ku-Bx
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 14:04:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dW4x1-0003DN-4S
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 14:04:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43532)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1dW4x0-0003BF-Rh
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 14:04:27 -0400
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <eef9a031-36e9-0443-1d73-30a49df02e9a@redhat.com>
Date: Fri, 14 Jul 2017 20:04:14 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] investigating TPM for OVMF-on-QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jiewen Yao <jiewen.yao@intel.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>, Javier Martinez Canillas <javierm@redhat.com>, Peter Jones <pjones@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Amarnath Valluri <amarnath.valluri@intel.com>
Cc: edk2-devel-01 <edk2-devel@lists.01.org>, qemu devel list <qemu-devel@nongnu.org>

Hi,

I spent most of today reading TPM related material (specs, guides and
source code), and below I'd like to describe what I think should be our
initial attack on enabling TPM on QEMU/OVMF.

(1) Versions of UEFI abstractions regarding TPM (very roughly speaking):

    There have been three sets of specs for this, and accordingly,
    edk2's SecurityPkg/Tcg/ directory supports each set. We can call
    these TPM1, TrEE, and TPM2.

    - TPM1 was the initial TPM thing, supporting only SHA-1, and is now
      obsolete.

    - TrEE was Microsoft's own update to the TPM1 software interfaces,
      supporting TPM2 hardware with more hash algorithms, and is now
      obsolete. Because,

    - TPM2 is basically the standardized version of TrEE, the most
      recent set of specs, and what we should focus on.

(2) Drivers (and features) in edk2/SecurityPkg/Tcg.

    There are 19 modules under SecurityPkg/Tcg/. Let me categorize them.
    In each category, I'll try to list modules in loosely increasing
    dependency (or PI/UEFI phase) order.

(2a) Modules that are obsolete because they are tied to TPM1:

       TcgPei/TcgPei.inf
       PhysicalPresencePei/PhysicalPresencePei.inf
       TcgDxe/TcgDxe.inf
       TcgConfigDxe/TcgConfigDxe.inf
       TcgSmm/TcgSmm.inf

     The TPM enablement instructions at

       https://github.com/tianocore/tianocore.github.io/wiki/How-to-Enable-Security#Enabling_Trusted_Compute_Module_TPM

     are written up in terms of these modules, but that doesn't obsolete
     the article too much.

(2b) Modules that are obsolete due to being tied to TrEE:

       TrEEConfig/TrEEConfigPei.inf
       TrEEPei/TrEEPei.inf
       TrEEDxe/TrEEDxe.inf
       TrEEConfig/TrEEConfigDxe.inf
       TrEESmm/TrEESmm.inf

     There is a great Intel whitepaper called

       A Tour Beyond BIOS with the UEFI TPM2 Support in EDKII

     which is written in terms of TrEE and these modules, explaining how
     they supersede TPM1 and the modules under (2a).

     This whitepaper seems to apply to the most recent TPM2 stack as
     well (mostly just replace TrEE references with TPM2 references), so
     it is very useful.

(2c) Modules that call themselves obsolete or deprecated (without being
     obviously tied to TPM1 or TrEE):

       MemoryOverwriteRequestControlLock/TcgMorLockSmm.inf

(2d) Modules that we won't need due to no hardware support in QEMU:

       Opal/OpalPasswordDxe/OpalPasswordDxe.inf
       Opal/OpalPasswordSmm/OpalPasswordSmm.inf

     TCG's "Opal" seems to be about self-encrypting drives, see

       https://en.wikipedia.org/wiki/Opal_Storage_Specification

     so these modules are not relevant for us.

(2e) Modules that we should use. Again, in increasing order of
     dependence. And here I'll comment as well on what these do:

       Tcg2Config/Tcg2ConfigPei.inf -- Informs the firmware globally
                                       about the TPM device type. This
                                       module can perform device
                                       detection or read a cached value
                                       from a non-volatile UEFI
                                       variable.

       Tcg2Pei/Tcg2Pei.inf          -- Initializes the TPM device and
                                       measures the firmware volumes in
                                       the PEI phase into the TPM's
                                       platform config registers.

       Tcg2Dxe/Tcg2Dxe.inf          -- Measures DXE phase (and later)
                                       modules into the TPM's PCRs, and
                                       also lets the OS boot loader
                                       measure things, by exposing the
                                       EFI_TCG2_PROTOCOL.

       Tcg2Config/Tcg2ConfigDxe.inf -- Provides a Setup TUI interface to
                                       configure the TPM. IIUC, it can
                                       also save the configured TPM type
                                       for subsequent boots (see
                                       Tcg2ConfigPei.inf above).

     This driver stack supports the TIS (MMIO) hardware interface, which
     is advertized to the OS in the TPM2 ACPI Table's "start method"
     field with value 6. (The according macro is TPM2_START_METHOD_MMIO
     in the QEMU source code, and EFI_TPM2_ACPI_TABLE_START_METHOD_TIS
     in the edk2 source code.)

     Including these drivers should result in a functional
     EFI_TCG2_PROTOCOL, which is what OS boot loaders primarily care
     about, as I understand.

     Importantly, the driver stack above requires PEI-phase variable
     access, therefore
     <https://bugzilla.tianocore.org/show_bug.cgi?id=386> must be solved
     first.

     (I have had patches for said BZ ready for a while. I've failed to
     upstream them thus far because a pflash-based varstore is a hard
     requirement for them. I think that's a natural requirement, but
     thus far my arguments haven't proved compelling enough.)

     Here I should mention some ACPI and hardware aspects. Under TPM1
     (whose ACPI table was called "TCPA"), the TPM events (measurements
     I think) were logged in a reserved memory area described by the
     TCPA table. Under TPM2, the "TPM2" ACPI table does no such thing,
     it only helps identify the communication characteristics of the
     device, and the event log itself is accessible to the OS boot
     loader via the EFI_TCG2_PROTOCOL.

     (If you are curious how a legacy BIOS boot loader is supposed to
     read the event log from a TPM2-only device (no "TCPA" table): I
     don't have the slightest clue.)

     I'm not sure about the exact characteristics of the virtual TPM
     that Stefan's swtpm project:

       https://github.com/stefanberger/swtpm

     combined with Amarnath's pending QEMU patches:

       http://mid.mail-archive.com/1496666711-14630-1-git-send-email-amarnath.valluri@intel.com

     will expose to the guest. What I do know is that the current QEMU
     solution, which mostly forwards a physical (host) TPM to the guest,
     produces a "TPM2" ACPI table if said host TPM device is TPM2. The
     "TPM2" table is exposed to the guest OS with OVMF's help, and has
     the following fields:

     - address of control area: zero
     - start method: 6 (TIS plus Cancel)
     - platform specific params: none.

     This implies that neither ACPI activation (method 2) nor Command
     Response Buffer activation (method 7) nor a combination of these
     two (method 8) is available in QEMU.

     And that should be just fine, because both Linux and the above
     Tcg2* modules appear to support this (from reading, not from
     testing).

(2f) Modules that we *could* use, but *should not*, at this point:

       MemoryOverwriteControl/TcgMor.inf

     MOR is "Memory Overwrite Request". It is a feature specified
     separately, in another TCG specification ("Platform Reset Attack
     Mitigation"), and it is optional for a firmware platform to
     support. (For example, as far as I can see, Linux doesn't even try
     to detect or use it.) If you care about the threat model and how
     MOR mitigates that threat, please read the spec on the TCG website.

     For initial TPM enablement in OVMF, we should avoid MOR support.
     The module above initializes the "MemoryOverwriteRequestControl"
     variable, which is one third of the MOR implementation.

       Tcg2Smm/Tcg2Smm.inf

     This is a complex driver that we *should not* use at this point:

     (2f1) It installs two ACPI tables. One of those is a "TPM2" ACPI
           table, according to the detected / configured TPM device (see
           under (2e). This "TPM2" table would conflict with -- or more
           precisely, duplicate -- the "TPM2" table already generated by
           QEMU, and installed by OVMF.

     (2f2) The other ACPI table is an SSDT which provides a _DSM (Device
           Specific Method) to the guest OS. Whenever the _DSM is
           called, the firmware is entered (via SMI/SMM), and the OS
           request is handled. Three sets of functions are provided:

           (2f2a) TCG Hardware Information. Not needed by the guest
                  OS(es), the TIS+Cancel start method is sufficient.

           (2f2b) TCG Memory Clear Interface. This is the second third
                  of the MOR feature I mentioned above. It saves the OS
                  request in the "MemoryOverwriteRequestControl"
                  variable (only writeable in SMM).

                  Upon next boot, OVMF's PlatformPei would have to clear
                  all memory -- this would be the last third of the MOR
                  feature; see under:

                    https://github.com/tianocore/tianocore.github.io/wiki/How-to-Enable-Security#Enabling_Trusted_Compute_Module_TPM

                  However, clearing all memory in OVMF's PlatformPei
                  would be a *real* pain, as we are limited to the
                  32-bit address space there (yes, even if OVMF's PEI
                  phase is built in 64-bit mode). In physical firmware,
                  where DRAM takes actual hardware initialization, the
                  clearing can likely occur without entering long mode
                  and setting up large page tables (e.g., the memory
                  controller itself could be programmed with IO
                  accesses), so in this case physical firmware has it
                  easier.

                  Again, Linux doesn't care about MOR.

           (2f2c) TCG Physical Presence Interface. The OS can queue TPM
                  operations (?) that require Physical Presence, and at
                  next boot, OVMF's PlatformBootManagerLib (in the BDS
                  phase) would have to dispatch those pending
                  operations. (The queueing again happens in protected
                  non-volatile UEFI variables -- writeable only in SMM.)

                  This is of dubious usefulness, and presents extra
                  complication for OVMF. Said dispatching is supposed to
                  occur *before* signaling the end-of-DXE event group
                  (according to the Intel whitepaper mentioned above),
                  but *after* the console is ready (according to the
                  wiki article linked above). However, OVMF *already*
                  signals the end-of-DXE event group in
                  PlatformBootManagerBeforeConsole(), that is, *before*
                  the console is ready. Many things are orchestrated
                  around end-of-DXE, so moving around its signaling
                  looks difficult.

                  Also, while Linux appears to be capable of using
                  Physical Presence, it is again optional, and I suggest
                  to ignore it at first.

     In brief, by not including these two modules, we avoid a "TPM2"
     ACPI table duplication. We also turn off the Memory Overwrite
     Request and Physical Presence Interface features -- which are both
     optional, as far as I can see, and very messy for OVMF's platform
     code.

(3) Drivers (and features) that are *not in edk2/SecurityPkg/Tcg:

    The Intel whitepaper discusses (and Peter also mentioned earlier)
    "dTPM" versus "fTPM".

    "dTPM" is basically TPM provided in publicly specified hardware,
    where the firmware can offer support, such as EFI_TCG2_PROTOCOL, but
    the OS can also directly drive the hardware. This is what QEMU
    offers with the TIS+Cancel start method (value 6). (The "Command
    Response Buffer" start method (value 7) would also qualify as
    "dTPM"). When the platform provides "dTPM", the _DSM method
    described above *may* be offered, but it is not required.

    "fTPM" is where the hardware is completely hidden from the OS, and
    is implemented fully in firmware. The corresponding start method
    values are 2 ("ACPI") and 8 ("ACPI with CRB"). In this case, the
    _DSM method is *required*.

    To my understanding, edk2 contains no "fTPM" implementation. The
    in-tree drivers recognize hardware that describes itself as
    TIS+Cancel (6) or CRB (7). Pure ACPI variants are neither recognized
    nor offered.

    I think TIS+Cancel / dTPM is the best match: the emulated TPM has to
    be implemented in virtual hardware (not just faked within the guest,
    in RAM), so that QEMU can secure the sensitive stuff from guest
    kernel level access.

I'm going to link this post from
<https://bugzilla.tianocore.org/show_bug.cgi?id=594>; please consider
registering in the TianoCore BZ and subscribing to that bug. Discussion
should occur on the list(s), but it's nice to capture separate threads
and distilled ideas in the BZ.

Thanks
Laszlo
