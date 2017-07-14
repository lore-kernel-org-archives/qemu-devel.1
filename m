Received: from eggs.gnu.org ([2001:4830:134:3::10]:57565)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pjones@redhat.com>) id 1dW7En-0005nq-PW
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 16:30:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pjones@redhat.com>) id 1dW7Ek-0000xq-Ii
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 16:30:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38228)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pjones@redhat.com>) id 1dW7Ek-0000uU-9J
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 16:30:54 -0400
Date: Fri, 14 Jul 2017 16:30:44 -0400
From: Peter Jones <pjones@redhat.com>
Message-ID: <20170714203044.lplfddes2wvn2oco@redhat.com>
References: <eef9a031-36e9-0443-1d73-30a49df02e9a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <eef9a031-36e9-0443-1d73-30a49df02e9a@redhat.com>
Subject: Re: [Qemu-devel] investigating TPM for OVMF-on-QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: Jiewen Yao <jiewen.yao@intel.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>, Javier Martinez Canillas <javierm@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Amarnath Valluri <amarnath.valluri@intel.com>, edk2-devel-01 <edk2-devel@lists.01.org>, qemu devel list <qemu-devel@nongnu.org>

On Fri, Jul 14, 2017 at 08:04:14PM +0200, Laszlo Ersek wrote:

>     - TPM2 is basically the standardized version of TrEE, the most
>       recent set of specs, and what we should focus on.

100% agreed.

> (2) Drivers (and features) in edk2/SecurityPkg/Tcg.
> 
>     There are 19 modules under SecurityPkg/Tcg/. Let me categorize them.
>     In each category, I'll try to list modules in loosely increasing
>     dependency (or PI/UEFI phase) order.
> 
> (2a) Modules that are obsolete because they are tied to TPM1:
> 
>        TcgPei/TcgPei.inf
>        PhysicalPresencePei/PhysicalPresencePei.inf
>        TcgDxe/TcgDxe.inf
>        TcgConfigDxe/TcgConfigDxe.inf
>        TcgSmm/TcgSmm.inf
> 
>      The TPM enablement instructions at
> 
>        https://github.com/tianocore/tianocore.github.io/wiki/How-to-Enable-Security#Enabling_Trusted_Compute_Module_TPM
> 
>      are written up in terms of these modules, but that doesn't obsolete
>      the article too much.
> 
> (2b) Modules that are obsolete due to being tied to TrEE:
> 
>        TrEEConfig/TrEEConfigPei.inf
>        TrEEPei/TrEEPei.inf
>        TrEEDxe/TrEEDxe.inf
>        TrEEConfig/TrEEConfigDxe.inf
>        TrEESmm/TrEESmm.inf
> 
>      There is a great Intel whitepaper called
> 
>        A Tour Beyond BIOS with the UEFI TPM2 Support in EDKII
> 
>      which is written in terms of TrEE and these modules, explaining how
>      they supersede TPM1 and the modules under (2a).
> 
>      This whitepaper seems to apply to the most recent TPM2 stack as
>      well (mostly just replace TrEE references with TPM2 references), so
>      it is very useful.
> 
> (2c) Modules that call themselves obsolete or deprecated (without being
>      obviously tied to TPM1 or TrEE):
> 
>        MemoryOverwriteRequestControlLock/TcgMorLockSmm.inf

Definitely do not care.

> (2d) Modules that we won't need due to no hardware support in QEMU:
> 
>        Opal/OpalPasswordDxe/OpalPasswordDxe.inf
>        Opal/OpalPasswordSmm/OpalPasswordSmm.inf
> 
>      TCG's "Opal" seems to be about self-encrypting drives, see
> 
>        https://en.wikipedia.org/wiki/Opal_Storage_Specification
> 
>      so these modules are not relevant for us.

Well, at some point somebody's going to want us to implement this,
but... they can do that when they do that.  Personally I'm never going
to trust on-drive encryption not to have an escrow key I don't know
about and can't remove, so it's a bit of a non-starter, but that's
neither here nor there.

> (2e) Modules that we should use. Again, in increasing order of
>      dependence. And here I'll comment as well on what these do:
> 
>        Tcg2Config/Tcg2ConfigPei.inf -- Informs the firmware globally
>                                        about the TPM device type. This
>                                        module can perform device
>                                        detection or read a cached value
>                                        from a non-volatile UEFI
>                                        variable.
> 
>        Tcg2Pei/Tcg2Pei.inf          -- Initializes the TPM device and
>                                        measures the firmware volumes in
>                                        the PEI phase into the TPM's
>                                        platform config registers.
> 
>        Tcg2Dxe/Tcg2Dxe.inf          -- Measures DXE phase (and later)
>                                        modules into the TPM's PCRs, and
>                                        also lets the OS boot loader
>                                        measure things, by exposing the
>                                        EFI_TCG2_PROTOCOL.
> 
>        Tcg2Config/Tcg2ConfigDxe.inf -- Provides a Setup TUI interface to
>                                        configure the TPM. IIUC, it can
>                                        also save the configured TPM type
>                                        for subsequent boots (see
>                                        Tcg2ConfigPei.inf above).
> 
>      This driver stack supports the TIS (MMIO) hardware interface, which
>      is advertized to the OS in the TPM2 ACPI Table's "start method"
>      field with value 6. (The according macro is TPM2_START_METHOD_MMIO
>      in the QEMU source code, and EFI_TPM2_ACPI_TABLE_START_METHOD_TIS
>      in the edk2 source code.)
> 
>      Including these drivers should result in a functional
>      EFI_TCG2_PROTOCOL, which is what OS boot loaders primarily care
>      about, as I understand.
> 
>      Importantly, the driver stack above requires PEI-phase variable
>      access, therefore
>      <https://bugzilla.tianocore.org/show_bug.cgi?id=386> must be solved
>      first.
> 
>      (I have had patches for said BZ ready for a while. I've failed to
>      upstream them thus far because a pflash-based varstore is a hard
>      requirement for them. I think that's a natural requirement, but
>      thus far my arguments haven't proved compelling enough.)

It does seem pretty natural... what's the counter argument?

>      Here I should mention some ACPI and hardware aspects. Under TPM1
>      (whose ACPI table was called "TCPA"), the TPM events (measurements
>      I think) were logged in a reserved memory area described by the
>      TCPA table. Under TPM2, the "TPM2" ACPI table does no such thing,
>      it only helps identify the communication characteristics of the
>      device, and the event log itself is accessible to the OS boot
>      loader via the EFI_TCG2_PROTOCOL.

Sadly EFI_TCG2_PROTOCOL and/or the TPM2 Configuration Table, with a not
completely clear merge method, but yeah.  I've got a linux kernel
implementation for this in progress here:
https://github.com/vathpela/linux/commits/efi-tpm2
and mjg59 told me on Tuesday that he was going to do some more with this
on Wednesday, but I haven't heard back from him yet.

>      (If you are curious how a legacy BIOS boot loader is supposed to
>      read the event log from a TPM2-only device (no "TCPA" table): I
>      don't have the slightest clue.)

Don't worry, we're not - based on the history of turning on TPM1
features in grub2 in Fedora betas, I've got exactly no interest in
making this work on BIOS.

>      I'm not sure about the exact characteristics of the virtual TPM
>      that Stefan's swtpm project:
> 
>        https://github.com/stefanberger/swtpm
> 
>      combined with Amarnath's pending QEMU patches:
> 
>        http://mid.mail-archive.com/1496666711-14630-1-git-send-email-amarnath.valluri@intel.com
> 
>      will expose to the guest.

It looks to me (reading both source trees quickly with grep) like
there's enough done in hw/tpm/tpm_tis.c:tpm_tis_realizefn() there that
it should be pretty straightforward to set PcdTpmBaseAddress and have
SecurityPkg/Library/Tpm2DeviceLibDTpm/Tpm2Ptp.c support it.

>      What I do know is that the current QEMU
>      solution, which mostly forwards a physical (host) TPM to the guest,
>      produces a "TPM2" ACPI table if said host TPM device is TPM2. The
>      "TPM2" table is exposed to the guest OS with OVMF's help, and has
>      the following fields:
> 
>      - address of control area: zero
>      - start method: 6 (TIS plus Cancel)
>      - platform specific params: none.
> 
>      This implies that neither ACPI activation (method 2) nor Command
>      Response Buffer activation (method 7) nor a combination of these
>      two (method 8) is available in QEMU.
> 
>      And that should be just fine, because both Linux and the above
>      Tcg2* modules appear to support this (from reading, not from
>      testing).

Yeah, that matches my reading so far, except the part where the kernel
just fails to give any of the useful info to us if we're not on
OpenFirmware on Power (and thus my github link above).

> (2f) Modules that we *could* use, but *should not*, at this point:
> 
>        MemoryOverwriteControl/TcgMor.inf
> 
>      MOR is "Memory Overwrite Request". It is a feature specified
>      separately, in another TCG specification ("Platform Reset Attack
>      Mitigation"), and it is optional for a firmware platform to
>      support. (For example, as far as I can see, Linux doesn't even try
>      to detect or use it.) If you care about the threat model and how
>      MOR mitigates that threat, please read the spec on the TCG website.

Yeah, that looks like we've already lost the whole ball game if we need
that.

<snip on lots of the detailed analysis here>

>      In brief, by not including these two modules, we avoid a "TPM2"
>      ACPI table duplication. We also turn off the Memory Overwrite
>      Request and Physical Presence Interface features -- which are both
>      optional, as far as I can see, and very messy for OVMF's platform
>      code.

Yeah, we don't need or want this.

> (3) Drivers (and features) that are *not in edk2/SecurityPkg/Tcg:
> 
>     The Intel whitepaper discusses (and Peter also mentioned earlier)
>     "dTPM" versus "fTPM".
> 
>     "dTPM" is basically TPM provided in publicly specified hardware,
>     where the firmware can offer support, such as EFI_TCG2_PROTOCOL, but
>     the OS can also directly drive the hardware. This is what QEMU
>     offers with the TIS+Cancel start method (value 6). (The "Command
>     Response Buffer" start method (value 7) would also qualify as
>     "dTPM"). When the platform provides "dTPM", the _DSM method
>     described above *may* be offered, but it is not required.

Right - this is the same thing I noted above.

> 
>     "fTPM" is where the hardware is completely hidden from the OS, and
>     is implemented fully in firmware. The corresponding start method
>     values are 2 ("ACPI") and 8 ("ACPI with CRB"). In this case, the
>     _DSM method is *required*.
> 
>     To my understanding, edk2 contains no "fTPM" implementation. The
>     in-tree drivers recognize hardware that describes itself as
>     TIS+Cancel (6) or CRB (7). Pure ACPI variants are neither recognized
>     nor offered.

MSFT keeps claiming they're going to release an edk2-licensed fTPM
implementation; I keep on not seeing it.

>     I think TIS+Cancel / dTPM is the best match: the emulated TPM has to
>     be implemented in virtual hardware (not just faked within the guest,
>     in RAM), so that QEMU can secure the sensitive stuff from guest
>     kernel level access.

This sounds right to me.

> I'm going to link this post from
> <https://bugzilla.tianocore.org/show_bug.cgi?id=594>; please consider
> registering in the TianoCore BZ and subscribing to that bug. Discussion
> should occur on the list(s), but it's nice to capture separate threads
> and distilled ideas in the BZ.

Okay.

-- 
  Peter
