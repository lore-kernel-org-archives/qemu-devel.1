Received: from eggs.gnu.org ([2001:4830:134:3::10]:38936)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fSg50-00048K-Kw
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 05:59:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fSg4v-0004n9-OZ
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 05:59:10 -0400
Date: Tue, 12 Jun 2018 11:59:00 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180612115900.4aa319d1.cohuck@redhat.com>
In-Reply-To: <99ca65a2-ee33-6353-b6b7-aa4c07a34e2a@linux.ibm.com>
References: <20180509154822.23510-1-cohuck@redhat.com>
	<20180509154822.23510-3-cohuck@redhat.com>
	<c18f9b9f-da00-1a0b-8ef0-7ac223c73d1a@linux.ibm.com>
	<20180515181006.0cb1dfc2.cohuck@redhat.com>
	<a5d08fb7-d9c1-b230-fe0c-acebbda2ba65@linux.ibm.com>
	<20180522145208.310143ea.cohuck@redhat.com>
	<4e4001cc-540e-0f2b-bbd1-1f82ca594bb3@linux.ibm.com>
	<20180605151449.22aafbfc.cohuck@redhat.com>
	<e73038ff-fb2d-5865-8b84-e775990f3983@linux.ibm.com>
	<20180606142131.74ea2eb7.cohuck@redhat.com>
	<5b77ec9c-41b8-2e32-ce79-d9005b93fdd0@linux.ibm.com>
	<20180607115442.6a779ed9.cohuck@redhat.com>
	<86d57698-3ea7-a390-2217-07c6d41ca9ed@linux.ibm.com>
	<20180608142022.7dd6a658.cohuck@redhat.com>
	<d68340a2-bb1b-cef9-e394-f0d55983c0bb@linux.ibm.com>
	<20180608164514.2e8248f4.cohuck@redhat.com>
	<99ca65a2-ee33-6353-b6b7-aa4c07a34e2a@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH RFC 2/2] vfio-ccw: support for halt/clear
 subchannel
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pierre Morel <pmorel@linux.ibm.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, Dong Jia Shi <bjsdjshi@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, qemu-s390x@nongnu.org, qemu-devel@nongnu.org

On Fri, 8 Jun 2018 17:51:27 +0200
Pierre Morel <pmorel@linux.ibm.com> wrote:

> On 08/06/2018 16:45, Cornelia Huck wrote:
> > On Fri, 8 Jun 2018 15:13:28 +0200
> > Halil Pasic <pasic@linux.ibm.com> wrote:
> > =20
> >> On 06/08/2018 02:20 PM, Cornelia Huck wrote: =20
> >>>>> My proposal is to do the same
> >>>>> copying to scsw(r) again, which would mean we get a request with bo=
th
> >>>>> the halt and the start bit set. The vfio code now needs to do a hsch
> >>>>> (instead of a ssch). The real channel subsystem should figure this =
out,
> >>>>> as we can't reliably check whether the start function has concluded
> >>>>> already (there's always a race window). =20
> >>>> This I do not agree scsw(r) is part of the driver.
> >>>> The interface here is not a device interface anymore but a driver
> >>>> interface.
> >>>> SCSW is a status, it is at its place in QEMU device interface with t=
he
> >>>> guest
> >>>> but here pwrite() sends a command. =20
> >>> Hm, I rather consider that "we write a status, and the backend figures
> >>> out what to do based on that status".
> >>>     =20
> >> The status of what? Kind of a target status?
> >>
> >> I think this approach is the source of lots of complications. For inst=
ance
> >> take xsch. How are we supposed to react to a guest xsch (in QEMU and
> >> in the kernel module)? My guess is that the right thing to do is to is=
sue
> >> an xsch in the vfio-ccw kernel module on the passed through subchannel.
> >> But there is no bit in fctl for cancel.
> >>
> >> Bottom line is: I'm not happy with the current design but I'm not sure
> >> if it's practical to do something about it (i.e. change it radically).=
 =20
> > It might make sense to keep this for ssch, maybe reuse it for hsch/csch=
, =20
>=20
> I do not think we need to change the interface radically but
> I also do not thing we should extend it by using multiple commands
> in a single syscall.
>=20
> Currently:
>  =C2=A0 - only SSCH bit is used
>  =C2=A0 - only the SSCH instruction is implemented
>  =C2=A0 - all other bits, CSCH,HSCH produce an error when used alone
>  =C2=A0=C2=A0=C2=A0 or are ignored in conjonction with SSCH
>  =C2=A0=C2=A0 - there is no implementation using the other bits
>  =C2=A0=C2=A0 - It is not specified in the documentation that multiple co=
mmands
>  =C2=A0=C2=A0=C2=A0=C2=A0 can be used.

Looking at Documentation/s390/vfio-ccw.txt, it states that "scsw_area
should be filled with the SCSW of the Virtual Subchannel". This seems
to indicate that this is really intended to be a scsw... but I agree,
it does lack details.

>=20
> Looking at these, I think there is no trouble to modify the way
> the Kernel interface is implemented without impact on current QEMU.
>=20
> But if we begin to allow ssch/hsch/csch in a single command
> in a new implementation we will be stuck with it.

Yes, we're currently still free to go in different directions; adding
support for hsch/csch to the interface in the way I did would fix it.
In any case, we need better documentation :/

>=20
> > and think about something else for other things we want to handle =20
>=20
> Yes we will need to have another interface, ioctl, or new region,
> all possible, but really more complex.
>=20
> > (xsch, channel monitoring, the path handling stuff for which we already=
 =20
>=20
> We can use another region for getting up information on path handling
> or monitoring, as does the patch IIRC.
> This is not a problem.

Not a problem, I agree (and yes, the patch did that).

For xsch, I like Halil's suggestion of simply always setting cc 2.

Channel monitoring is a difficult beast (need to pass through msch, mix
of virtual and passthrough devices on the machine which have different
semantics etc.) I put some of my concerns into
https://wiki.qemu.org/ToDo/Channel_I/O_Passthrough; please add to that
if you have further thoughts.

We should keep those requirements in mind, even if we won't implement
support for it right now.

>=20
> > had a prototype etc.) It's probably not practical to do radical surgery
> > on the existing code. =20
>=20
> There is no need for radical surgery, no change is required to older or
> current QEMU code.
> My concern is to avoid a future implementation merging multiple commands
> in a single syscall.
> It is not only a problem of beauty of the interface,
> using a status is for the up-stream, from device to program.
> Using the same construct, same name and same location, to produce commands
> for the down stream is misleading and source of incoherence.

OK, I think I see your concern now.

What happens on the real hardware is that we do a ssch etc. and this
triggers a change that is visible in the scsw when we do a stsch.

What happens here is that the guest doing a ssch triggers a change in
our virtual scsw in QEMU (so far, so good); then we send this scsw to
the vfio module, which looks at the scsw to figure out that it should
do a ssch on the host. This works fine to figure out that a ssch needs
to be done, and would also work for hsch and csch, but it is really a
bit of reverse engineering, and it would probably fail for rsch
(haven't thought about that yet). To parse the intention of doing a
halt or clear out of the scsw_area, we need to rely (a) on user space
doing the right thing, and (b) on us implementing the rules for which
function can be initiated when correctly. If we treat fctl as a simple
command field, we'll just do what user space asks of us directly.

So, what are you proposing? Being more specific and stating that the
scsw is not necessarily a real scsw, but merely a vehicle for sending a
command? Or keeping it as it is now for ssch, and adding a second
interface for hsch/csch (and maybe rsch, msch, ...)?
