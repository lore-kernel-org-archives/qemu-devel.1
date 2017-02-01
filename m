Received: from eggs.gnu.org ([2001:4830:134:3::10]:39419)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cYweK-0000oo-CZ
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 10:16:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cYweH-00027N-6b
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 10:16:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43654)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1cYweG-00027G-UG
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 10:16:41 -0500
Date: Wed, 1 Feb 2017 16:16:36 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170201161636.28f1e2dc@nial.brq.redhat.com>
In-Reply-To: <e158344b-b3e7-253b-f919-e48f6490c7b0@redhat.com>
References: <1484739954-86833-1-git-send-email-phil@philjordan.eu>
	<20170118175335-mutt-send-email-mst@kernel.org>
	<20170118181918.783cb7bd@nial.brq.redhat.com>
	<CAAibmn0OEBsZUyxuKcssk-4V-=fA94QWFCk04Lt9rbFN66OgEg@mail.gmail.com>
	<20170131165802-mutt-send-email-mst@kernel.org>
	<fe787fcc-0c92-5842-1a67-b50466b6f38f@redhat.com>
	<20170131201333-mutt-send-email-mst@kernel.org>
	<20170201123739.387de47b@nial.brq.redhat.com>
	<6e912456-9d9c-7084-c4b4-91596216d3dd@redhat.com>
	<e158344b-b3e7-253b-f919-e48f6490c7b0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC] acpi: add reset register to fadt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Phil Dennis-Jordan <phil@philjordan.eu>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org

On Wed, 1 Feb 2017 14:03:52 +0100
Laszlo Ersek <lersek@redhat.com> wrote:

> On 02/01/17 13:52, Laszlo Ersek wrote:
> > On 02/01/17 12:37, Igor Mammedov wrote:  
> >> On Tue, 31 Jan 2017 20:17:02 +0200
> >> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> >>  
> >>> On Tue, Jan 31, 2017 at 05:28:57PM +0100, Laszlo Ersek wrote:  
> >>>> The ACPI 6.1 spec says,
> >>>>
> >>>> - DSDT: [...] If the X_DSDT field contains a non-zero value then this
> >>>>   field must be zero.
> >>>> - X_DSDT: [...] If the DSDT field contains a non-zero value then this
> >>>>   field must be zero.    
> >>>
> >>> But that's only 6.1. 6.0 and earlier did not say this.
> >>> The errata they wanted to address was:
> >>> 1393 In FADT: if X_DSDT field is non-zero, DSDT
> >>> field should be ignored or deprecated
> >>>
> >>> I would class this as a spec bug.
> >>>  
> >>
> >> The same applies to X_PM1a_EVT_BLK and co,
> >> for example 5.1 spec "This is a required
> >> field."
> >>
> >> And looks like Windows implemented it as mandatory
> >> to boot perhaps to be compatible with 5.1 and earlier
> >> specs.
> >>
> >> It appears fw would be forced to fill fields depending
> >> on table revision.  
> > 
> > Sounds like a valid point.
> > 
> > I compared the FADT defintion between ACPI 5.1 and ACPI 6.1. Indeed, the
> > former says:
> > 
> > - FADT Major Version: 5; Major Version of this FADT structure, [...]
> > - DSDT: Physical memory address (0-4 GB) of the DSDT.
> > - X_DSDT: 64bit physical address of the DSDT.
> > 
> > the latter says:
> > 
> > - FADT Major Version: 6; Major Version of this FADT structure, [...]
> > 
> > - DSDT: Physical memory address of the DSDT. If the X_DSDT field
> >   contains a non-zero value then this field must be zero.
> > 
> > - X_DSDT: Extended physical address of the DSDT. If the DSDT field
> >   contains a non-zero value then this field must be zero.
> > 
> > I will ask on edk2-devel whether the
> > "MdeModulePkg/Universal/Acpi/AcpiTableDxe" maintainers can think of a
> > way to accommodate this.  
> 
> Sigh, this looks nasty.
> 
> Considering specifically the DSDT <-> X_DSDT question, Mantis ticket
> #1393 (which requires the mutual exclusion) went into 5.1B. In version
> 5.1A, the mutual exclusion is not required.
> 
> Unfortuantely, the FADT Major.Minor version, as reported through the
> bytes at offsets 8 and 131 decimal in the table, is "5.1" for *both*
> 5.1A and 5.1B. In other words, looking at just Major.Minor, it cannot be
> determined with full precision whether the DSDT and X_DSDT fields should
> be exclusive or not. :/
The same applies to 6.0 vs 6.0A 

> 
> Laszlo
> 
> 
