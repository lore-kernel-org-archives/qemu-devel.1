Received: from eggs.gnu.org ([2001:4830:134:3::10]:41405)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cT2xA-0006pM-Er
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 03:47:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cT2x5-0004WC-32
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 03:47:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58908)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1cT2x4-0004Uh-Ql
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 03:47:43 -0500
Date: Mon, 16 Jan 2017 09:47:36 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170116094736.7fcefdcd@nial.brq.redhat.com>
In-Reply-To: <FBD67273-74C4-4183-8FCF-8260D13B04D4@skyportsystems.com>
References: <CAO_EM_kuP9kk55bzxWqNOeuL8yW7gKNnacd1-UVGnJPyx2ZNYw@mail.gmail.com>
	<20160916033402-mutt-send-email-mst@kernel.org>
	<CAO_EM_mHyC7cywV4KUqH_MWwt2vVkK6GEOuaUX0FHpffdfaAuQ@mail.gmail.com>
	<20161006041949-mutt-send-email-mst@kernel.org>
	<D5FCB73B-435E-4423-B21C-BEEF1C1EA2FD@skyportsystems.com>
	<20161211052355-mutt-send-email-mst@kernel.org>
	<FBD67273-74C4-4183-8FCF-8260D13B04D4@skyportsystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Virtual Machine Generation ID
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ben Warren <ben@skyportsystems.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Ed Swierk <eswierk@skyportsystems.com>, Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org

On Sat, 14 Jan 2017 22:17:53 -0800
Ben Warren <ben@skyportsystems.com> wrote:

> Hi Michael,
>=20
> > On Dec 10, 2016, at 7:28 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> >=20
> > On Tue, Dec 06, 2016 at 06:15:34PM -0800, Ben Warren wrote: =20
> >> Hi Michael,
> >>=20
> >> I=E2=80=99m well on my way to implementing this, but I am really new t=
o the QEMU code base and am struggling with some concepts.  Please see belo=
w: =20
> >>> On Oct 5, 2016, at 6:29 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> >>>=20
> >>> On Tue, Oct 04, 2016 at 03:51:40PM -0700, Ed Swierk wrote: =20
> >>>> On Thu, Sep 15, 2016 at 5:36 PM, Michael S. Tsirkin <mst@redhat.com>=
 wrote: =20
> >>>>> On Thu, Sep 15, 2016 at 05:23:28PM -0700, Ed Swierk wrote: =20
> >>>>>> I'm wondering what it will take to finish up work on vmgenid.
> >>>>>>=20
> >>>>>> https://lists.gnu.org/archive/html/qemu-devel/2016-01/msg05599.htm=
l =20
> >>>>>=20
> >>>>> We have ACPI_BUILD_TPMLOG_FILE in tree now and I think it could be
> >>>>> allocated in a similar way.
> >>>>> Integrate patch "fw-cfg: support writeable blobs" to communicate the
> >>>>> allocated address back to QEMU. =20
> >>>>=20
> >>>> Starting with Igor's last version at
> >>>> https://github.com/imammedo/qemu/commits/vmgen_wip , it's not clear =
to
> >>>> me which changes need to be ported, which changes are obsoleted by
> >>>> your new fw-cfg stuff and/or upstream churn in ACPI, device
> >>>> properties, etc. In particular ACPI is still a total mystery to me,
> >>>> though passing a single address from guest to host can't be that har=
d,
> >>>> can it?
> >>>>=20
> >>>> Any clues would be appreciated.
> >>>>=20
> >>>> --Ed =20
> >>>=20
> >>> It might be best to just re-start from the beginning.
> >>> So the idea is that ACPI should be about supplying the address
> >>> to guest. To supply address to host we'll use fw cfg.
> >>> This would be new I think:
> >>>=20
> >>> - add support for writeable fw cfg blobs =20
> >> patch applied =20
> >>> - add linker/loader command to write address of a blob into
> >>> such a fw cfg file
> >>> - add a new file used for vm gen id, use loader command above
> >>> to pass the address of a blob allocated for it to host =20
> >> I don=E2=80=99t really understand the meaning of =E2=80=9Cfile=E2=80=
=9D in this context.  It seems to be a way of specifying individual fw_cfg =
entries without explicitly giving an index, but is not something that is vi=
sible in either the host or guest file system.  Is this about right?  In my=
 code I=E2=80=99m using =E2=80=9C/etc/vmgenid=E2=80=9D =20
> >=20
> > yes
> >  =20
> >> As for the blob, I=E2=80=99m thinking this is where my main problem is=
.  The =E2=80=98fw_cfg_add_*()=E2=80=99 functions take a data pointer but d=
oesn=E2=80=99t seem to copy the data anywhere.  We pass essentially a point=
er via ACPI to the guest, so what it points to needs to be in an accessible=
 region.  I don=E2=80=99t get how to define the blob contents.  There are c=
ommand-line =E2=80=98fw-cfg=E2=80=99 options where you can specify a file, =
but it=E2=80=99s not clear to me how to use them.  Maybe I reserve some IO =
memory or something? =20
> >=20
> > Not sure I understand the question. fw cfg device will make
> > memory accessible to guest. Put the guest physical address there.
> > the address needs to be calculated by linker.
> >  =20
> I=E2=80=99m almost ready to submit a V2 of the patch set, but there=E2=80=
=99s still one issue that I can=E2=80=99t figure out.  From the guest, I ca=
n read the contents of the blob.  If I make a change to the contents of the=
 blob (via QMP) the guest does not see the changes.  Is there something I n=
eed to do on the QEMU side to =E2=80=9Cpush=E2=80=9D the updated fw_cfg con=
tents to the guest?  I=E2=80=99ve noticed this both when writing a qtest fo=
r the feature, and also in a Linux kernel module I wrote that reads the ACP=
I contents in a guest.
post here a link to your current repo so I could check it

>=20
> thanks,
> Ben
