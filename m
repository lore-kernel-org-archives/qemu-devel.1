Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DDF6C43461
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 15:09:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFD3A208FE
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 15:09:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AtkhC9i5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFD3A208FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGkfu-00039T-Qk
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 11:09:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38364)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kGkdA-0007yh-Jq
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 11:06:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23647
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kGkd7-0002Lx-BC
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 11:06:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599836775;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MkmRYv5STaUvf2Pcx9fC4E3r38YPH1vlJwvLn0/AzWM=;
 b=AtkhC9i5pICUdsAbyc4FwPgDXhHHugLE+yesrhTKYvRZ3k0vIGzCH5HtNK+oFcKPRS9urD
 o9nT0eoUTZURDhVxSSZaUbTNlpigWT8rnCgYY0Odu8GGNkAx+siSUEv0J2eevWqyt7pPsS
 LCWQoWF8mdcfuyms2TUFNNluIA5t0aA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-538-VEVCos2uPWmKnqUpKN_AnQ-1; Fri, 11 Sep 2020 11:06:12 -0400
X-MC-Unique: VEVCos2uPWmKnqUpKN_AnQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E0E41425D1;
 Fri, 11 Sep 2020 15:06:10 +0000 (UTC)
Received: from work-vm (ovpn-113-52.ams2.redhat.com [10.36.113.52])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 093F55D9E8;
 Fri, 11 Sep 2020 15:06:05 +0000 (UTC)
Date: Fri, 11 Sep 2020 16:06:02 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Laszlo Ersek <lersek@redhat.com>
Subject: Re: PATCH: Increase System Firmware Max Size
Message-ID: <20200911150602.GH3310@work-vm>
References: <CS1PR8401MB0327EF9D532330BA44257AFCF3240@CS1PR8401MB0327.NAMPRD84.PROD.OUTLOOK.COM>
 <20c5210f-8199-a9e7-9297-0bea06c4d9ae@redhat.com>
 <20200911083408.GA3310@work-vm>
 <ae2d820e-78c6-da92-2fa6-73c1a7d10333@redhat.com>
MIME-Version: 1.0
In-Reply-To: <ae2d820e-78c6-da92-2fa6-73c1a7d10333@redhat.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0.004
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/11 03:28:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "mst@redhat.com" <mst@redhat.com>,
 "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "McMillan,
 Erich" <erich.mcmillan@hp.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Laszlo Ersek (lersek@redhat.com) wrote:
> On 09/11/20 10:34, Dr. David Alan Gilbert wrote:
> > * Laszlo Ersek (lersek@redhat.com) wrote:
> >> +Markus, Dave, Phil
> >>
> >> On 09/11/20 03:45, McMillan, Erich wrote:
> >>> Hi all,
> >>>
> >>> (this is my first Qemu patch submission, please let me know if my formatting/content needs to be fixed).
> >>> We have a need for increased firmware size, currently we are building Qemu with the following change to test our Uefi Firmware and it works well for us. Hope that this change can be made to open source. Thank you.
> >>> -------
> >>> Increase allowed system firmware size to 16M per comment suggesting up to 18M is permissible.
> >>>
> >>>  Signed-off-by: Erich McMillan <erich.mcmillan@hp.com>
> >>>
> >>> diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
> >>> index b8d8ef59eb17c6ace8194fc69c3d27809becfbc0..f6f7cd744d0690cee0355fbd19ffdcdb71ea75ca 100644
> >>> --- a/hw/i386/pc_sysfw.c
> >>> +++ b/hw/i386/pc_sysfw.c
> >>> @@ -46,7 +46,7 @@
> >>>   * only 18MB-4KB below 4G. For now, restrict the cumulative mapping to 8MB in
> >>>   * size.
> >>>   */
> >>> -#define FLASH_SIZE_LIMIT (8 * MiB)
> >>> +#define FLASH_SIZE_LIMIT (16 * MiB)
> >>>
> >>>  #define FLASH_SECTOR_SIZE 4096
> >>> -------
> >>>
> >>>
> >>
> >> (1) This is not a trivial change, so qemu-trivial: please ignore.
> >>
> >> (2) The comment has not been updated.
> >>
> >> (3) I'm almost certain that *if* we want to change this, it needs to be
> >> turned into a machine type (or some device model) property, for
> >> migration compatibility.
> > 
> > I'm missing what this constant exists for - why is the
> > check there at all  Is there something else that lives below this
> > address that we have to protect?
> 
> Yes, some MMIOs that I'm at least aware of are IO_APIC_DEFAULT_ADDRESS
> (0xfec00000), TPM_PPI_ADDR_BASE (0xFED45000), APIC_DEFAULT_ADDRESS
> (0xfee00000).
> 
> They are not directly adjacent with pflash; nor should they be.

Hmm those need explicitly checks adding somewhere against
FLASH_SIZE_LIMIT!

> On one hand, the current FLASH_SIZE_LIMIT is meant to be  sufficient for
> a long time ("should be enough for anyone").
> 
> On the other hand, if we have a really strong reason to increase the
> size limit, the current value is supposed to give us a safety margin, so
> that we can satisfy the immediate need at that point *first*, and start
> looking into (likely more intrusive) physical address map changes, to
> restore the safety margin.
> 
> > My reading of the code is that increasing that constant doesn't change
> > the guests view at all, as long as the guest was given the same flash
> > files - so if the guests view doesn't change, then why would we tie
> > it to the machine type?
> 
> If you increase the size limit (without tieing it to a machine type),
> then, with an upgraded QEMU and the same (old) machine type, you can
> start a guest with a larger-than-earlier (cumulative) flash size. Then,
> when you try to migrate this to an old QEMU (but same machine type),
> it's a bad surprise. I understand that backwards migration is not
> universally supported (or expected), but I don't want this problem to
> land on my desk *ever*.

I support backwards migration; but that migration wouldn't work anyway -
wouldn't that fail nicely with a mismatched RAMBlock size?

> Furthermore, un-enumerable / platform-MMIO devices tend to pop up time
> after time. TPM_PPI_ADDR_BASE (0xFED45000) is a somewhat recent
> addition, for example. It's not like we're never going to need more
> address space up there.
> 
> > 
> >> (4) I feel we need much more justification for this change than just
> >> "our firmware is larger than upstream OVMF".
> >>
> >> In the upstream 4MB unified OVMF build, there's *plenty* of free room.
> >> Of course that's not to say that we're willing to *squander* that space
> >> -- whenever we include anything new in the upstream OVMF platform(s),
> >> there must be a very good reason for it --, just that, given the
> >> upstream OVMF status, the proposed pflash increase in QEMU is staggering.
> >>
> >> Considering upstream OVMF and QEMU, it should take *years* to even get
> >> close to filling the 4MB unified flash image of OVMF (hint: link-time
> >> optimization, LZMA compression), let alone to exhaust the twice as large
> >> (8MB) QEMU allowance.
> >>
> >> Unless you are committed to open source your guest firmware too (maybe
> >> as part of upstream edk2, maybe elsewhere), I seriously doubt we should
> >> accommodate this use case in *upstream* QEMU. It complicates things
> >> (minimally with regard to migration), and currently I don't see the
> >> benefit to the upstream community.
> >>
> >> Clearly, for building your firmware image, you must have minimally
> >> modified the DSC and FDF files in OVMF too, or created an entirely
> >> separate firmware platform -- DSC and FDF both.
> >>
> >> If you are using your downstream OVMF build as a testbed for your
> >> proprietary physical platform firmware, that's generally a use case that
> >> we're mildly interested in not breaking in upstream OvmfPkg. But in
> >> order to make me care for real (as an OvmfPkg co-maintainer), you'd need
> >> to upstream your OVMF platform to edk2 (we already have Xen and --
> >> recently added -- bhyve firmware platforms under OvmfPkg, not just
> >> QEMU). You'd also have to offer long-term reviewership and testing for
> >> that platform in edk2 (like the Xen and bhyve stake-holders do). Then we
> >> could consider additional complexity in QEMU for booting that firmware
> >> platform.
> > 
> > Our UEFI firmware is pretty sparse;
> 
> Yes, in part because I strive to keep it that way.

But that's your choice, on our firmware implementation; that's not a
requirement of QEMU or q35.

> I fight to keep out
> all cruft that I can (at least by conditionalizing it) so that there is
> room for the stuff that I cannot keep out. (And I always strive to set
> expectations that flipping all possible build knobs in OVMF to "on" may
> very well cause an "out of space" error.)
> 
> - I've made sure that PVSCSI_ENABLE and MPT_SCSI_ENABLE be stand-alone
> config knobs. The use case behind them is valid, the drivers are open
> source, but the use case is still niche, so they must be easy to keep out.
> 
> - I've made sure LSI_SCSI_ENABLE is a stand-alone config knob too (and
> it even defaults to FALSE). The QEMU device that the driver drives is
> obsolete / deprecated.
> 
> - If VMBus drivers are ever going to be contributed, they'll need a
> config knob.
> 
> - Current Xen code in OVMF is supposed to be separated completely to the
> new, dedicated XenPVH platform
> <https://bugzilla.tianocore.org/show_bug.cgi?id=2122>.
> 
> - Bhyve support is a separate platform build.
> 
> - Capsule updates are not supported by OVMF, and if they will ever be,
> they're going to have to be a separate firmware platform. Datacenter
> virtualization has no use for capsule updates.
> 
> - The next big thing I expect to have to keep out of OVMF is Redfish
> <https://en.wikipedia.org/wiki/Redfish_(specification)>. Libvirt,
> OpenStack, Cockpit, Kubernetes already handle that area *underneath* the
> guest, I believe. (It's OK to use OVMF for developing / testing Redfish;
> it's not OK to expect that the current OVMF firmware platform contain
> everything that it contains now *plus* Redfish.)
> 
> Sparse is *good*.
> 
> > it doesn't have any pretty graphics
> > or snazzy stuff,
> 
> Which is arguably completely superfluous on every possible platform one
> can imagine. On the other hand, if you want a real serial port on
> workstation class hardware, you may have to order a separate part (if
> you are lucky and you *can* order one). Serial-over-LAN is a complete
> non-replacement.
> 
> The reason (should I say: excuse) for the firmware to exist is to (a)
> boot operating systems, (b) abstract away some ugly platform-specific
> hardware for OS runtime (by providing ACPI and SMBIOS descriptions, and
> a *small* set of runtime services). We can maybe add (c) "root of trust".
> 
> In practice, physical firmware is becoming the hw vendor's OS before
> (and under) your OS, one you cannot replace, and one whose updates can
> brick your hardware. Permitting the same feature creep on virtual
> platforms is wrong.

On the firmware you develop that choice is fine; but there's no reason
to force that restriction onto others.

> > or have to survive configuring lots of hardware; also
> > I'm aware of other companies who are looking at putting big blobs
> > of stuff in firmware for open uses;
> 
> Key term being "open uses". Let us see them.

Well yes, I think we know who we're speaking about here and we're
working on it.

> > so I don't see a problem with
> > changing this limit from the QEMU side of things.
> 
> I do. Software and data always expand to consume all available space,
> and it's going to cause a conflict between UEFI features and platform
> MMIO sooner or later. Then I'll get the privilege of shuffling around
> the crap in OVMF (all of which is "indispensable" or course).
> 
> If we ever go down this route, it needs to benefit open source directly
> and significantly.

Being able to use QEMU to let vendors debug their platform firmware is a
perfectly reasonable use of QEMU; maybe not of your OVMF build - we
need to keep the restrictions on the two separate.

Dave

> Laszlo
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


