Received: from eggs.gnu.org ([2001:4830:134:3::10]:59990)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dJ7eQ-0001cq-AF
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 20:19:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dJ7eN-0004ZY-3D
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 20:19:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51746)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dJ7eM-0004ZL-QE
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 20:19:39 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4E06023E6C5
	for <qemu-devel@nongnu.org>; Fri,  9 Jun 2017 00:19:37 +0000 (UTC)
Date: Fri, 9 Jun 2017 03:19:34 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170609031436-mutt-send-email-mst@kernel.org>
References: <20170608161013.17920-1-lersek@redhat.com>
	<20170608204026-mutt-send-email-mst@kernel.org>
	<1496951333.29761.5.camel@redhat.com>
	<20170608224942-mutt-send-email-mst@kernel.org>
	<d7cb6756-6d1f-60ee-c7b6-ef6a8b08bb08@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7cb6756-6d1f-60ee-c7b6-ef6a8b08bb08@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] q35/mch: implement extended TSEG sizes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu devel list <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>

On Fri, Jun 09, 2017 at 01:01:54AM +0200, Laszlo Ersek wrote:
> On 06/08/17 21:55, Michael S. Tsirkin wrote:
> > On Thu, Jun 08, 2017 at 09:48:53PM +0200, Gerd Hoffmann wrote:
> >>   Hi,
> >>
> >>> I really dislike negotiation being re-invented for each device.  Do
> >>> we
> >>> need these tricks?  Can we just do fw cfg with standard discovery?
> >>> This ties in with my proposal to generalize smi features to
> >>> generic ones.
> >>
> >> Device properties should be part of the device.
> >> We should have done this with the smi too.
> > 
> > What is part of the device and what isn't? It's all part
> > of QEMU in the end.  Adding probing for multiple devices
> > will just add to number of exits and slow down guest boot.
> > 
> > We do want to stick to emulating real devices if we can, no argument
> > here - but this stuff is PV anyway - what do we gain by spreading it
> > out?
> > 
> >> A more standard way to handle this would be to add a vendor-specific
> >> pci capability and place the register there.  Not sure we have room for
> >> that in the pci config space though.
> >>
> >> cheers,
> >>   Gerd
> > 
> > We don't have room anywhere in PCI config space. Laszlo makes argument
> > why it's safe for this device based on spec but it's anyone's guess
> > whether current and future software will follow spec.  In short, going
> > anywhere near the emulated device has a potential to break some drivers.
> 
> I'm fine using any QEMU facility that lets independent firmware modules
> perform their feature detections / negotiations / lockdowns in arbitrary
> order between each other. (Hopefully without extreme parsing requirements.)

How about adding etc/mch/features etc copying the smi stuff? Is this
simple enough? We can worry about removing code duplication later.

> What I can not sign up for is to develop a general QEMU infrastructure
> for this (regardless of whether it is the fw_cfg bitmap stuff prevails,
> or the PCI config space register / capability list). Either is complex
> work, needing documentation too, the design has to be future proof. I'm
> not experienced enough in QEMU to get it right reasonably soon
> (everything is surprisingly complex and difficult in QEMU -- this has
> been my experience over the years, and I still struggle with QOM every
> single time), and I definitely do not have the capacity to take on a
> QEMU feature of the suggested size.
> 
> It's not lack of interest on my part, but lack of capacity. (Case in
> point: it's ~1AM local time, and my laptop's uptime, which quite closely
> approximates the hours I've actually spent working today, is ~15:30.)
> The reason I keep submitting these little patches to qemu-devel is that
> I figure everyone else is overloaded too, so I might as well try what
> I'm capable of. But, we should be clear that that is not much, load-wise
> and sophistication-wise.
> 
> The alternative could have been that I'd clone
> <https://bugzilla.redhat.com/show_bug.cgi?id=1447027> to qemu-kvm-rhev
> (from OVMF), set up the cross-BZ dependencies correctly, wait until the
> clone gets assigned to a seasoned QEMU developer, and once he or she
> gets to work on it, we figure out the design together, and once he/she
> writes the code for QEMU, I write the code for the firmware.
> 
> I figured that sending a patch like the present one (having discussed it
> preliminarily with Gerd and Paolo in the "[edk2] SMRAM sizes on large
> hosts" thread) would be more efficient than waiting for a seasoned QEMU
> developer. I didn't expect that my patch would be better than theirs. :)
> The above kind of collaboration has certainly proved functional in the
> past, it just takes a lot of time and coordination.
> 
> Anyway, "Laszlo embarking on a QEMU infrastructure project that's liable
> to take fifteen patch set iterations" is not an alternative,
> unfortunately. I definitely don't intend to throw QEMU patches over the
> fence; I know what drag that creates for maintainers. I intend to be
> responsible for my QEMU patches. However -- or perhaps, "exactly because
> of that"? -- I simply can't take on QEMU work that's larger than this
> caliber.
> 
> Sorry about the wall of text.
> 
> Thanks,
> Laszlo
