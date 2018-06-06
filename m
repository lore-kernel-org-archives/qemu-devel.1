Received: from eggs.gnu.org ([2001:4830:134:3::10]:41973)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <msuchanek@suse.de>) id 1fQXKW-0000qS-OC
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 08:14:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <msuchanek@suse.de>) id 1fQXKV-0007TJ-8b
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 08:14:20 -0400
Date: Wed, 6 Jun 2018 14:13:56 +0200
From: Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
Message-ID: <20180606141356.0b86d6b4@kitsune.suse.cz>
In-Reply-To: <94cea1d9-d934-85d1-66d4-dbfc82b8dd53@redhat.com>
References: <20180518180440-mutt-send-email-mst@kernel.org>
	<20180524113251.GB4660@redhat.com>
	<d9bb2cb9-d9dc-8fe0-a767-10d9cbbab803@redhat.com>
	<20180528183058.GG2209@redhat.com>
	<20180528183833.GJ4580@localhost.localdomain>
	<20180528212054.GH2209@redhat.com>
	<20180528212510.GC4660@redhat.com>
	<20180529064415.GA4756@localhost.localdomain>
	<2b3eef00-f326-c1e6-0e4b-b7602646eec4@redhat.com>
	<20180606123237.2235ae4a@kitsune.suse.cz>
	<bc97cdc3-85ba-e053-0816-b6bc431064fb@redhat.com>
	<20180606131929.44d0fd6b@kitsune.suse.cz>
	<93233bff-604b-c891-90ce-64fe1eaaaab5@redhat.com>
	<20180606134327.05de9616@kitsune.suse.cz>
	<94cea1d9-d934-85d1-66d4-dbfc82b8dd53@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/t5R.HDN4=8lcAvrEWhc=i9w";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] storing machine data in qcow images?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, "Richard W.M. Jones" <rjones@redhat.com>, qemu-devel@nongnu.org, stefanha@redhat.com, ehabkost@redhat.com, qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>

--Sig_/t5R.HDN4=8lcAvrEWhc=i9w
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 6 Jun 2018 13:52:35 +0200
Max Reitz <mreitz@redhat.com> wrote:

> On 2018-06-06 13:43, Michal Such=C3=A1nek wrote:
> > On Wed, 6 Jun 2018 13:32:47 +0200
> > Max Reitz <mreitz@redhat.com> wrote:
> >  =20
> >> On 2018-06-06 13:19, Michal Such=C3=A1nek wrote: =20
> >>> On Wed, 6 Jun 2018 13:02:53 +0200
> >>> Max Reitz <mreitz@redhat.com> wrote:
> >>>    =20
> >>>> On 2018-06-06 12:32, Michal Such=C3=A1nek wrote:   =20
> >>>>> On Tue, 29 May 2018 12:14:15 +0200
> >>>>> Max Reitz <mreitz@redhat.com> wrote: =20
>=20
> [...]
>=20
> >>>>>> I hate the idea of making qcow2 a random archive format.     =20
> >>>>>
> >>>>> What's wrong with that?     =20
> >>>>
> >>>> The fact that qcow2 isn't.
> >>>>
> >>>> From my perspective it would increase the format's complexity to
> >>>> a point where you could just create a new format altogether.
> >>>> Well, actually, all you do is design a filesystem (or reuse an
> >>>> existing one).
> >>>>   =20
> >>>>>> We have tar for that.     =20
> >>>>>
> >>>>> It does not support expanding the stored files.     =20
> >>>>
> >>>> Nor does qcow2, because it does not support storing files at
> >>>> all.   =20
> >>>
> >>> AFAICT from the previous discussion it already does allow storing
> >>> multiple data streams that can be changed independently so it
> >>> basically is an archive format or filesystem except the streams
> >>> are not named nor easily accessible separately outside of
> >>> qemu.   =20
> >>
> >> I don't quite understand what you are referring to.  We have
> >> snapshots, we have bitmaps, yes, but all of that are related
> >> directly to the stored guest disk data.
> >>
> >> The only thing we currently have in qcow2 that is opaque is the VM
> >> state that can be stored in snapshots (and don't hold me
> >> responsible for that). =20
> >=20
> > But it has to be related to the stored disk data only because of
> > your dislike for stuff not related to the disk data. Not for a
> > technical reason. The format can sustain storing unrelated data. =20
>=20
> Yes.  Technically, you can even store data without qcow2 knowing,
> except that qemu-img check -r leaks will delete it, but yeah.
>=20
> >>>> Secondly, that completely depends on how you use it.  You can
> >>>> freely expand the last file in the archive, for instance.  Also
> >>>> I've seen people store files in chunks so they can indeed resize
> >>>> it.
> >>>>
> >>>> (I'm wondering if we could write a block driver that could
> >>>> provide such a chunk allocation transparently to qcow2...  Note
> >>>> that a qcow2 file does not need to be continuous, so you could
> >>>> in theory indeed store the qcow2 file and its data in completely
> >>>> separate places in a tar file.)   =20
> >>>
> >>> Which basically invents another new filesystem on top of tar for
> >>> no good reason. Especially when we have already support for
> >>> storage format that is capable enough.   =20
> >>
> >> No different from inventing a filesystem on top of qcow2.
> >>
> >> I don't think qcow2 is any more capable than tar. =20
> >=20
> > It can natively resize the objects it stores. =20
>=20
> It does not store arbitrary objects.  It stores a guest disk (and
> snapshots), and bitmaps.  These are stored in directory structures so
> new chunks can be dynamically added.  Note that both use slightly
> different structures.
>=20
> Yes, it is technically possible to use a similar structure to store
> arbitrary objects.  But currently it does not have that capability.
>=20
> >                                                tar cannot do that
> > so you will have to store random nonsense in the tar archive that
> > only makes sense for your fs/tar driver. =20
>=20
> Right.  But what's the difference to storing random nonsense in a
> qcow2 file that not even makes sense to qemu?
>=20
> >>>> What I'm trying to get at is that qcow2 was not designed to be a
> >>>> container format for arbitrary files.  If you want to make it
> >>>> such, I'm sure there are existing formats that work better.   =20
> >>>
> >>> Such as?   =20
> >>
> >> ext2? =20
> >=20
> > So you want an ext2 driver in qemu instead of expanding qcow2 to
> > work not only for a single disk but also for an appliance? =20
>=20
> Yes, because ext2 was designed to be a proper filesystem.  I'm not an
> FS designer.  Well, not a good one anyway.  So I don't trust myself on
> extending qcow2 to be a good FS -- and why would I, when there are
> already numerous FS around.

Do you expect that performance of qemu using qcow2 driver over ext2
driver will be better than using qcow driver directly with some part
semi-permanently occupied by a configuration blob? My bet is not.

The ext* drivers are designed to work with kernel VM infrastructure
which must be tuned for different usage scenarios and you would have to
duplicate that tuning in qemu to get competitive performance. Also you
get qcow2 and ext2 metadata which must be allocated, managed, etc. You
get more storage and performance overhead for no good reason.

On the other hand, qcow is designed for storing VM disk data and
hopefully was tuned to do that decently over the years. The primary use
case remains storing VM disk data. Adding a configuration blob does not
change that.


> >>>>>> Unless I have got something terribly wrong (which is indeed a
> >>>>>> possibility!), to me this proposal means basically to turn
> >>>>>> qcow2 into (1) a VM description format for qemu, and (2) to
> >>>>>> turn it into an archive format on the way.     =20
> >>>>>
> >>>>> And if you go all the way you can store multiple disks along
> >>>>> with the VM definition so you can have the whole appliance in
> >>>>> one file. It conveniently solves the problem of synchronizing
> >>>>> snapshots across multiple disk images and the question where to
> >>>>> store the machine state if you want to suspend it.      =20
> >>>>
> >>>> Yeah, but why make qcow2 that format?  That's what I completely
> >>>> fail to understand.
> >>>>
> >>>> If you want to have a single VM description file that contains
> >>>> the VM configuration and some qcow2/raw/whatever files along
> >>>> with it for the guest disk data, sure, go ahead.  But why does
> >>>> the format of the whole thing need to be qcow2?   =20
> >>>
> >>> Because then qemu can access the disk data from the image directly
> >>> without any need for extraction, copying to different file,
> >>> etc.   =20
> >>
> >> This does not explain why it needs to be qcow2.  There is
> >> absolutely no reason why you couldn't use qcow2 files in-place
> >> inside of another file. =20
> >=20
> > qemu cannot read the disk data from the file in-place. =20
>=20
> Hu?  Why not?

Well, it can possibly read the image if it happens to be continuous. It
will not be able to update it without a fs driver, however.

Thanks

Michal

--Sig_/t5R.HDN4=8lcAvrEWhc=i9w
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJbF9ARAAoJEFCz6i1Pzvpbb40H/26xCUwz3e94EwtMlGl50370
rxiI+Fhxn3QeikProw0rx+Y+ndwr9JGJ0wEosWj8yPbIQaz0bqlFlcZAv1uw0Df6
u4W2OyLIAxCZPF+XWYs1JzMA5CZpFQ+vdbYokYUiRuxLVQi8mkMThwHc/KvG5nZq
7EfiU2hGdX+HZEnY0Me+3x/6Njzg5VcpET68Qfei7dMDApy3FXKC1B677AYHfhzJ
jtCIxiHgWyqkU1d1kf0ZrNpASbjR7CMsjdudiqfwv/J9el9H2Qe0X0kqDWa27sKI
6m10hPitltQdTo1N7eLnWAWvk6eboznr3ZNNwUd9GCCktt+f8SOWi0pU9231l8s=
=nKSV
-----END PGP SIGNATURE-----

--Sig_/t5R.HDN4=8lcAvrEWhc=i9w--
