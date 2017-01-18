Received: from eggs.gnu.org ([2001:4830:134:3::10]:52255)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cTs0K-0001WA-DV
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 10:18:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cTs0G-0000sa-8I
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 10:18:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50922)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1cTs0F-0000rC-Vy
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 10:18:24 -0500
Date: Wed, 18 Jan 2017 16:18:19 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170118161819.7f5526af@nial.brq.redhat.com>
In-Reply-To: <CAFEAcA-Cdyq-dQ0U79TSsjJWQ2TO0R11RCWzAemSRS_1M65meg@mail.gmail.com>
References: <1484328738-21149-1-git-send-email-ard.biesheuvel@linaro.org>
	<CAFEAcA-s4To6BCgFzUG6Bs_rpeVupatXpHm45b=26QmLJAwy8A@mail.gmail.com>
	<CAKv+Gu-hAzng0ff4=r2JZF5p=nEhhv12-kwg7wz+m7Uj4w42DA@mail.gmail.com>
	<CAFEAcA8n5grNz+z1ZcNcX9Er9s=uXRPgV-b1-3tkrzWEv-=1Uw@mail.gmail.com>
	<CAKv+Gu_+O-_x-CwQdiTf4efWAMue6LdXK3Afo9YW8Xz+6BFyzw@mail.gmail.com>
	<20170117094950.5dqdpbk6u7p4yhms@kamzik.brq.redhat.com>
	<CAFEAcA-Cdyq-dQ0U79TSsjJWQ2TO0R11RCWzAemSRS_1M65meg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] hw/arm/virt-acpi - reserve ECAM space
 as PNP0C02 device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Andrew Jones <drjones@redhat.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Leif Lindholm <leif.lindholm@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Graeme Gregory <graeme.gregory@linaro.org>, Al Stone <al.stone@linaro.org>, "Michael S.
	Tsirkin" <mst@redhat.com>

On Tue, 17 Jan 2017 10:56:53 +0000
Peter Maydell <peter.maydell@linaro.org> wrote:

> On 17 January 2017 at 09:49, Andrew Jones <drjones@redhat.com> wrote:
> > In some cases the problem we're solving with the compat guards is
> > a bit hypothetical, but, IMHO, nonetheless a good practice. While
> > we may be sure that AAVMF and Linux will be fine with this table
> > changing under their feet, we can't be sure there aren't other
> > mach-virt users that have more sensitive firmwares/OSes. An ACPI-
> > sensitive OS may notice the change on its next reboot after a
> > migration, and then simply refuse to continue.  
> 
> There's also the case where you do a VM migration midway through
> UEFI booting up, I think, which might cause things to go wrong
> if you catch it just at the wrong moment.
acpi blobs are migrated from source so above won't happen.
The time guest will see new table is fresh boot or reboot.

> 
> > Now, that said, I just spoke with Igor in order to learn the x86
> > practice. He says that the policy has been more lax than what I
> > suggest above. Hypothetical, low-risk issues are left unguarded,
> > and only when a bug is found during testing is it then managed.
> > The idea is to try and reduce the amount of compat variables and
> > conditions needed in the ACPI generation code, but, of course, at
> > some level of risk to users expecting their versioned machine type
> > to always appear the same.
> >
> > So far we've been strict with mach-virt, guarding all hypothetical
> > issues. Perhaps this patch is a good example to get a discussion
> > started on whether or not we should be so strict though.  
> 
> That said, I don't have a very strong opinion here, beyond that
> we should be consistent at least with x86 practice.
another reason why we are trying not to use strict approach with ACPI
tables is that it's part of firmware and we didn't version firmwares
so far. (i.e. dst host with newer QEMU will typically have newer
firmware and guest with old machine-type migrated to host with newer
QEMU will run new firmware on (re)boot)

> 
> thanks
> -- PMM
