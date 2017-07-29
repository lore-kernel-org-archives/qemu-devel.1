Received: from eggs.gnu.org ([2001:4830:134:3::10]:34425)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kevin@koconnor.net>) id 1dbHcf-0005oQ-3o
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 22:36:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kevin@koconnor.net>) id 1dbHca-0003Dp-VV
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 22:36:57 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:38291)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <kevin@koconnor.net>) id 1dbHca-0003BC-My
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 22:36:52 -0400
Received: by mail-qk0-x241.google.com with SMTP id v76so10985031qka.5
	for <qemu-devel@nongnu.org>; Fri, 28 Jul 2017 19:36:50 -0700 (PDT)
Date: Fri, 28 Jul 2017 22:36:48 -0400
From: Kevin O'Connor <kevin@koconnor.net>
Message-ID: <20170729023648.GA4257@morn.lan>
References: <20170726093136.13627-1-pbonzini@redhat.com>
	<20170727204050.GA10211@morn.lan>
	<ea5e634b-19bb-8767-aeba-cf58d8598f84@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea5e634b-19bb-8767-aeba-cf58d8598f84@redhat.com>
Subject: Re: [Qemu-devel] [qemu PATCH for 2.10] i386: acpi: provide an XSDT
 instead of an RSDT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, seabios@seabios.org, lists@philjordan.eu, imammedo@redhat.com, mst@redhat.com, phil@philjordan.eu, programmingkidx@gmail.com, kraxel@redhat.com

On Fri, Jul 28, 2017 at 04:20:10PM +0200, Laszlo Ersek wrote:
> On 07/27/17 22:40, Kevin O'Connor wrote:
> > On Wed, Jul 26, 2017 at 11:31:36AM +0200, Paolo Bonzini wrote:
> >> The tables that QEMU provides are not ACPI 1.0 compatible since commit
> >> 77af8a2b95 ("hw/i386: Use Rev3 FADT (ACPI 2.0) instead of Rev1 to improve
> >> guest OS support.", 2017-05-03).  This is visible with Windows 2000,
> >> which refuses to parse the rev3 FADT and fails to boot.
> >>
> >> The recommended solution in this case is to build two FADTs, v1 being
> >> pointed to by the RSDT and v3 by the XSDT.  However, we leave this task
> >> to the firmware.  This patch simply switches the RSDT to the XSDT, which
> >> is valid for all ACPI 2.0-friendly operating systems and also leaves
> >> SeaBIOS the freedom to build an RSDT that points to the compatibility
> >> FADT.
> > 
> > Another possible solution to this issue would be for QEMU to instruct
> > the firmware to build both rev1 and rev3 FADTs, but be clear which
> > links are for legacy purposes only.  This could be done with a new
> > ADD_LEGACY_POINTER linker loader command.  Existing firmwares should
> > ignore the new ADD_LEGACY_POINTER command and new versions of SeaBIOS
> > could be extended to honor it.
> 
> I confirm OVMF ignores (skips) unknown commands.
> 
> But, so I can understand better, can you please explain what the effect
> of these patches would be? IIUC, some pointer updates would not be
> performed in OVMF (and old SeaBIOS) that would take place in new
> SeaBIOS. What pointers are these exactly (where do they live and what do
> they point at)?
> 
> - RSDT[0] would point to FADTv1, RSDT[n] (n>=1) would point to the rest
> of the tables, and OVMF wouldn't set (or follow) any of these pointers,
> - XSDT[0] would point to FADTv3, XSDT[n] (n>=1) would point to the rest
> of the tables, and both SeaBIOS and OVMF would see these pointers,
> - RSDP.RSDT would point to the RSDT, and OVMF would not see (or follow)
> this pointer,
> - RSDP.XSDT would point to the XSDT, and both SeaBIOS and OVMF would see
> this pointer.
> 
> Is this a correct interpretation?

Yes - exactly.

[...]
> Fourth, what about the links within the FADTv1 (to the FACS and DSDT)?
> AFAICS in build_fadt1(), those pointers continue to be patched with the
> non-legacy ADD_POINTER command. This is not necessarily a problem if
> FADTv1.FACS and FADTv3.FACS point to the exact same address (similarly
> if FADTv1.DSDT and FADTv3.DSDT point to the exact same address), because
> OVMF already has a kind of memoization against installing the exact same
> pointed-to table twice (e.g., when FADTv3.DSDT and FADTv3.X_DSDT refer
> to the same address). Still, for completeness, maybe the FADTv1.FACS and
> FADTv1.DSDT pointers should also be patched with the new legacy
> ADD_POINTER command, in build_fadt1().

Agreed.  That was an oversight on my part.

Also, I agree with others that this is probably something to think
about for post QEMU v2.10.  The suggestion to use FACSv1 on piix and
FACSv3 on q35 for v2.10 makes sense to me.

-Kevin
