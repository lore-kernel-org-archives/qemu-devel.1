Received: from eggs.gnu.org ([2001:4830:134:3::10]:59733)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cenlQ-0006Sh-Nx
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 14:00:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cenlN-0001YH-MK
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 14:00:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46368)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1cenlN-0001X5-De
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 14:00:13 -0500
Date: Fri, 17 Feb 2017 21:00:10 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170217204602-mutt-send-email-mst@kernel.org>
References: <cover.1487286467.git.ben@skyportsystems.com>
	<88232638f9ff3b17b54987624468678ea14a3037.1487286467.git.ben@skyportsystems.com>
	<20170217114321.6c8577e1@nial.brq.redhat.com>
	<4F60B53E-1A5D-4D4C-954F-F1C3ED5B487C@skyportsystems.com>
	<de706a53-137c-a49d-5765-4afecc5ce3d8@redhat.com>
	<9B914CBD-40ED-46CF-9420-E7BB13EB6D1B@skyportsystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9B914CBD-40ED-46CF-9420-E7BB13EB6D1B@skyportsystems.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v8 4/8] ACPI: Add Virtual Machine
 Generation ID support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ben Warren <ben@skyportsystems.com>
Cc: Laszlo Ersek <lersek@redhat.com>, Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org

On Fri, Feb 17, 2017 at 10:34:29AM -0800, Ben Warren wrote:
>=20
>     On Feb 17, 2017, at 8:03 AM, Laszlo Ersek <lersek@redhat.com> wrote=
:
>=20
>     On 02/17/17 16:33, Ben Warren wrote:
>=20
>=20
>=20
>             On Feb 17, 2017, at 2:43 AM, Igor Mammedov <imammedo@redhat=
.com
>             <mailto:imammedo@redhat.com>> wrote:
>=20
>             On Thu, 16 Feb 2017 15:15:36 -0800
>             ben@skyportsystems.com <mailto:ben@skyportsystems.com> wrot=
e:
>=20
>=20
>                 From: Ben Warren <ben@skyportsystems.com <
>                 mailto:ben@skyportsystems.com>>
>=20
>                 This implements the VM Generation ID feature by passing=
 a
>                 128-bit
>                 GUID to the guest via a fw_cfg blob.
>                 Any time the GUID changes, an ACPI notify event is sent=
 to the
>                 guest
>=20
>                 The user interface is a simple device with one paramete=
r:
>                 - guid (string, must be "auto" or in UUID format
>                  xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx)
>=20
>             I've given it some testing with WS2012R2 and v4 patches for
>             Seabios,
>=20
>             Windows is able to read initial GUID allocation and writeba=
ck
>             seems to work somehow:
>=20
>             (qemu) info vm-generation-id
>             c109c09b-0e8b-42d5-9b33-8409c9dcd16c
>=20
>             vmgenid client in Windows reads it as 2 following 64bit int=
egers:
>             42d50e8bc109c09b:6cd1dcc90984339b
>=20
>             However update path/restore from snapshot doesn't
>             here is as I've tested it:
>=20
>             qemu-system-x86_64 -device vmgenid,id=3Dtestvgid,guid=3Daut=
o -monitor
>             stdio
>             (qemu) info vm-generation-id
>             c109c09b-0e8b-42d5-9b33-8409c9dcd16c
>             (qemu) stop
>             (qemu) migrate "exec:gzip -c > STATEFILE.gz"
>             (qemu) quit
>=20
>             qemu-system-x86_64 -device vmgenid,id=3Dtestvgid,guid=3Daut=
o -monitor
>             stdio
>             -incoming "exec: gzip -c -d STATEFILE.gz"
>             (qemu) info vm-generation-id
>             28b587fa-991b-4267-80d7-9cf28b746fe9
>=20
>             guest
>             1. doesn't get GPE notification that it must receive
>             2. vmgenid client in Windows reads the same value
>                 42d50e8bc109c09b:6cd1dcc90984339b
>=20
>=20
>         Strange, this was working for me, but with a slightly different=
 test
>         method:
>=20
>          * I use virsh save/restore
>=20
>=20
>     Awesome, this actually what I should try. All my guests are managed=
 by
>     libvirt (with the occasional <qemu:arg>, for development), and dire=
ct
>     QEMU monitor commands such as
>=20
>      virsh qemu-monitor-command ovmf.rhel7 --hmp 'info vm-generation-id=
'
>=20
>     only work for me if they are reasonably non-intrusive.
>=20
>=20
>          * While I do later testing with Windows, during development I =
use a
>            Linux kernel module I wrote that keeps track of GUID and
>            notifications.  I=E2=80=99m happy to share this with you if =
interested.
>=20
>=20
>     Please do. If you have a public git repo somewhere, that would be
>     awesome. (Bonus points if the module builds out-of-tree, if the
>     kernel-devel package is installed.)
>=20
>=20
> Here you go:
> https://github.com/ben-skyportsystems/vmgenid-test
>=20
> I don=E2=80=99t know if something like this would ever be accepted into=
 the Linux
> kernel, but it has been invaluable to me, and I=E2=80=99d like to see i=
t somewhere
> better.

I think the main issue here is that there's no blocking
interface to wait for change events.



Also ioremap_nocache is definitely the wrong thing to do
since the spec says
	It must not be in the same 4-kilobyte page as any memory that is
	expected to be mapped by a page table entry with caching disabled.

Finally, I think it makes sense to add an mmap call to this driver.
Basically add some kind of interface telling guest that gen id does not
share a 4K page with any other structure. Maybe just a special HID
value?  Or a special method we can test for.  Then it's safe for guest
to map this page read-only into userspace memory. It should have an
interface to report the offset to userspace. Userspace can then get the
ID without a system call by doing

ptr =3D mmap(...)
offset =3D ioctl(... GET_OFFSET ...)
guid =3D *(ptr + offset)

Windows does not seem to have this ability but it might be
a significant performance enhancement IMHO.

>=20
>     NB: while the set-id monitor command was part of the series, I did =
test
>     it to the extent that I checked the SCI ("ACPI interrupt") count in=
 the
>     guest, in /proc/interrupts. I did see it increase, so minimally the=
 SCI
>     injection was fine.
>=20
>     Thanks!
>     Laszlo
>=20
>=20
>         I=E2=80=99ll dig into this morning.
>=20
>         =E2=80=94Ben
>         <snip>
>=20
>=20
