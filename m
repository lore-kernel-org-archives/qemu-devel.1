Received: from eggs.gnu.org ([2001:4830:134:3::10]:53494)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameeh@daynix.com>) id 1ff1tU-0006wT-Cd
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 07:42:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameeh@daynix.com>) id 1ff1tR-0006yS-66
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 07:42:20 -0400
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543]:46230)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sameeh@daynix.com>) id 1ff1tQ-0006xj-Jg
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 07:42:17 -0400
Received: by mail-ed1-x543.google.com with SMTP id o8-v6so2195749edt.13
	for <qemu-devel@nongnu.org>; Mon, 16 Jul 2018 04:42:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <153117712510.13022.10479965239208861799@sif>
References: <20180626151038.24771-1-sameeh@daynix.com>
	<20180626151038.24771-2-sameeh@daynix.com>
	<5e9b9ca6-b493-d10b-be98-9b9eb480c685@redhat.com>
	<CAKPgXcGQGqfwAw132jKq5UaFhaPR8PnfGf4NiXgYGoo7FwR5Cw@mail.gmail.com>
	<153117712510.13022.10479965239208861799@sif>
From: Sameeh Jubran <sameeh@daynix.com>
Date: Mon, 16 Jul 2018 14:42:14 +0300
Message-ID: <CAKPgXcF3j3h=rFVuDyvn-56Z1z01OkH3c_rS2F=gGa3imD5kdw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 1/2] qga-win: prevent crash when executing
 fsinfo command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: Eric Blake <eblake@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Yan Vugenfirer <yan@daynix.com>, Markus Armbruster <armbru@redhat.com>

I've found another bug which is related to this one, where pci_controller
might also be null:
in the function "build_guest_disk_info" in "qga/commands-win32.c"

if (bus == BusTypeScsi || bus == BusTypeAta || bus == BusTypeRAID

#if (_WIN32_WINNT >= 0x0600)

/* This bus type is not supported before Windows Server 2003 SP1 */

|| bus == BusTypeSas

#endif

) {

/* We are able to use the same ioctls for different bus types

* according to Microsoft docs

* https://technet.microsoft.com/en-us/library/ee851589(v=ws.10).aspx */

if (DeviceIoControl(vol_h, IOCTL_SCSI_GET_ADDRESS, NULL, 0, scsi_ad,

sizeof(SCSI_ADDRESS), &len, NULL)) {

disk->unit = addr.Lun;

disk->target = addr.TargetId;

disk->bus = addr.PathId;

disk->pci_controller = get_pci_info(name, errp);

}

/* We do not set error in this case, because we still have enough

* information about volume. */

} else {

disk->pci_controller = NULL;

}

This can be easily prevented by always calling "get_pci_info(name, errp);",
is this a separate patch, or should be combined with this one? what do you
think?

On Tue, Jul 10, 2018 at 1:58 AM, Michael Roth <mdroth@linux.vnet.ibm.com>
wrote:

> Quoting Sameeh Jubran (2018-06-28 18:33:58)
> >
> >
> > On Fri, Jun 29, 2018 at 12:44 AM, Eric Blake <eblake@redhat.com> wrote:
> >
> >     On 06/26/2018 10:10 AM, Sameeh Jubran wrote:
> >
> >         From: Sameeh Jubran <sjubran@redhat.com>
> >
> >         The fsinfo command is currently implemented for Windows only and
> it's
> >         disk
> >         parameter can be enabled by adding the define
> "CONFIG_QGA_NTDDSCSI" to
> >         the qga
> >         code. When enabled and executed the qemu-ga crashed with the
> following
> >         message:
> >
> >         ------------------------------------------------
> >         File qapi/qapi-visit-core.c, Line 49
> >
> >         Expression: !(v->type & VISITOR_OUTPUT) || *obj)
> >         ------------------------------------------------
> >
> >         After some digging, turns out that the GuestPCIAddress is null
> and the
> >         qapi visitor doesn't like that, so we can always allocate it
> instead
> >         and
> >         initiate all it's members to -1.
> >
> >
> >     Adding Markus for a qapi back-compat question.
> >
> >     Is faking an invalid address better than making the output optional
> >     instead?
> >
> >
> >         +++ b/qga/commands-win32.c
> >         @@ -485,6 +485,11 @@ static GuestPCIAddress *get_pci_info(char
> *guid,
> >         Error **errp)
> >               char *buffer = NULL;
> >               GuestPCIAddress *pci = NULL;
> >               char *name = g_strdup(&guid[4]);
> >         +    pci = g_malloc0(sizeof(*pci));
> >         +    pci->domain = -1;
> >         +    pci->slot = -1;
> >         +    pci->function = -1;
> >         +    pci->bus = -1;
> >
> >
> >     Right now, we have:
> >
> >     ##
> >     # @GuestDiskAddress:
> >     #
> >     # @pci-controller: controller's PCI address
> >     # @bus-type: bus type
> >     # @bus: bus id
> >     # @target: target id
> >     # @unit: unit id
> >     #
> >     # Since: 2.2
> >     ##
> >     { 'struct': 'GuestDiskAddress',
> >       'data': {'pci-controller': 'GuestPCIAddress',
> >                'bus-type': 'GuestDiskBusType',
> >                'bus': 'int', 'target': 'int', 'unit': 'int'} }
> >
> >     and the problem you ran into is that under certain conditions, we
> have no
> >     idea what to populate in GuestPCIAddress.  Your patch populates
> garbage
> >     instead; but I'm wondering if it would be better to instead mark
> >     pci-controller as optional, where code that CAN populate it would set
> >     has_pci_controller=true, and the code that crashed will now work by
> leaving
> >     the struct NULL (and has_pci_controller=false).  But that removes
> output
> >     that the client may expect to be present, hence, this is a
> back-compat
> >     question of the best way to approach this.
> >
> > Since all of the fields are ints, I believe that "-1" is very
> informative even
> > though I don't like this approach but it does preserve backward
> compatibility
> > as you've already clarified.
> >
> > I don't want to assume anything but this bug has been laying around for
> quite a
> > while and no one complained, moreover,  the disk option is not enabled by
> > default in upstream code so I don't think that backward compatibility is
> > actually disturbed but then again this is just an assumption.
> >
> > One more thing to consider is the second patch of this series which
> actually
> > was the root cause of why we didn't allocate the " GuestDiskAddress"
> struct
> > which is some registry keys being absent for the specific device which
> would
> > leave us with two options:
> > 1. Don not return anything for all of the fields (leave it null)
> > 2. Return partial information
> > I think that the second option is preferable for obvious reasons.
> >
> > I am not that familiar with schema files, but it is possible to make int
> fields
> > optional too?
> >
> > I can live with either approaches, maintainers, it's your call :)
>
> IMO both approaches potentially break clients, but making the field
> optional in this case would be likely to trigger a segfault for any code
> that relies on GuestPCIAddress being populated, whereas -1 would likely
> just propagate through the stack as a signed integer as the schema calls
> for. Lack of -1/undefined handling further up the stack could still
> cause breakage but the severity seems lesser. I'm inclined to go this
> route for 2.13. If there are no objections I plan to include this in a
> pull for 2.13-rc1.
>
> >
> > Thanks for the review!
> >
> >
> >     --
> >     Eric Blake, Principal Software Engineer
> >     Red Hat, Inc.           +1-919-301-3266
> >     Virtualization:  qemu.org | libvirt.org
> >
> >
> >
> >
> > --
> > Respectfully,
> > Sameeh Jubran
> > Linkedin
> > Software Engineer @ Daynix.
>
>


-- 
Respectfully,
*Sameeh Jubran*
*Linkedin <https://il.linkedin.com/pub/sameeh-jubran/87/747/a8a>*
*Software Engineer @ Daynix <http://www.daynix.com>.*
