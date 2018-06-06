Received: from eggs.gnu.org ([2001:4830:134:3::10]:59877)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <msuchanek@suse.de>) id 1fQdFt-0003jw-Dz
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 14:33:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <msuchanek@suse.de>) id 1fQdFs-0007mn-CL
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 14:33:57 -0400
Date: Wed, 6 Jun 2018 20:33:39 +0200
From: Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
Message-ID: <20180606203339.0085207d@kitsune.suse.cz>
In-Reply-To: <a1d7851c-e01f-4190-cc8f-af98531e6379@redhat.com>
References: <20180606123237.2235ae4a@kitsune.suse.cz>
	<bc97cdc3-85ba-e053-0816-b6bc431064fb@redhat.com>
	<20180606131929.44d0fd6b@kitsune.suse.cz>
	<93233bff-604b-c891-90ce-64fe1eaaaab5@redhat.com>
	<20180606113720.GA2661@work-vm>
	<2c833e2c-f0bb-ea98-a703-54fb9447bd2f@redhat.com>
	<20180606121624.GD2661@work-vm>
	<2d572c2f-8dda-87db-ec26-6f2230375424@redhat.com>
	<20180606140233.GF2660@work-vm>
	<66366ae1-1db8-7121-bfcc-f2096d0c954f@redhat.com>
	<20180606144140.GH2660@work-vm>
	<cea4f615-c768-7a2f-3849-5dd00c37b537@redhat.com>
	<20180606172523.3816a882@kitsune.suse.cz>
	<a1d7851c-e01f-4190-cc8f-af98531e6379@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/i+OcmDl9wiuYsHL3SYFlN37";
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
Cc: Kevin Wolf <kwolf@redhat.com>, ehabkost@redhat.com, qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, "Richard W.M. Jones" <rjones@redhat.com>, "Dr. David
	Alan Gilbert" <dgilbert@redhat.com>, stefanha@redhat.com

--Sig_/i+OcmDl9wiuYsHL3SYFlN37
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 6 Jun 2018 20:02:54 +0200
Max Reitz <mreitz@redhat.com> wrote:

> On 2018-06-06 17:25, Michal Such=C3=A1nek wrote:
> > On Wed, 6 Jun 2018 16:55:08 +0200
> > Max Reitz <mreitz@redhat.com> wrote:
> >  =20
> >> On 2018-06-06 16:41, Dr. David Alan Gilbert wrote: =20
> >>> * Max Reitz (mreitz@redhat.com) wrote:   =20

> >> Users using a whole VM stack plus management, but then handling two
> >> files instead of one is too much to ask? =20
> >=20
> > What you don't seem to realize is there are cases when there is an
> > 'administrator' who has set up the VM stack plus management and 'joe
> > user' who wants to run some random VM on that stack.
> >=20
> > And if you download an appliance compatible with the stack it should
> > just work. For a long time the 'appliance' for qemu based
> > virtualization was a simple qcow2 file which was sized sufficiently
> > for the VM to run but shrunk for transport. And although it is
> > technically wrong it JustWorked(tm). =20
>=20
> Hm, yes.  As I replied to Dave, I understand, but I would think this
> then requires a real appliance solution.  I think you do want such a
> solution, but Dave doesn't.

Yes, Dave wants a poor man's half-assed appliance and insists on it not
being an appliance. Duh.

In the pc world to maintain the status quo with minimum changes you
only need to know if the image uses EFI or legacy BIOS and you can
maintain the illusion that the TimeProvenSolution(tm) JustWorks(tm).

Sneaking that single piece of information somewhere seems to be the
goal here.

>=20
> My problem is that I cannot accept Dave's arguments on why to include
> this blob in qcow2 if someone else already plans on making that blob
> the basis for qcow2 appliances.
>=20
> And I still do not think that qcow2 is the right format for VM
> appliances.  To convince me, we'd first need a consensus on what the
> appliances are for (Michael seems to want them for qemu directly,

Let's put this straight: qemu as is cannot run appliances. It is not
designed for that and it would be a big feature to create enough
management inside qemu (or around qemu but part of qemu distribution) to
change that.

As it stands qemu always takes the configuration from the outside -
either from the user directly or from a separate management layer.

> apparently you want them for something higher up the stack) and thus
> what they are supposed to be capable of exactly.

Using qcow2 would be kind of cool but it has its limitations and
drawbacks as well.

You could use qcow2 as transport format and convert the VM to use
raw disks or whatever if you need the performance. And you could run
the VM directly from qcow2 without additional processing which is its
advantage.

It would fail miserably with tools not aware of the extra metadata,
however.

Lastly we are missing a developer of a management layer committed to
support such appliances.

>=20
> Like, one thing that is important to discuss is this (but please not
> in this thread...): If we agree on making an appliance format (qcow2
> or not), is it for running VMs off or do we just want it for VM
> export/import?  The former might mean we need qcow2, because there is
> no good way to offer good performance with multiple disks otherwise
> (but this would constrain us e.g. in the disk image format -- no raw
> images for you, then).  But the latter can work just fine with a
> normal archival format as long as building/decomposing it is possible
> without copying.

Indeed, using an archive should be good enough for the 1-click download
solution. It will take time to extract but it will typically take even
more time to download or publish. So optimizing the format for speed of
export/import might be misplaced.

Thanks

Michal

--Sig_/i+OcmDl9wiuYsHL3SYFlN37
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJbGCkKAAoJEFCz6i1PzvpbGk0H/RdlueWxz7jqvrlo6c9gxcaS
lvgztqNNIQK7AvQOOVh+oNleXCwAkVVvyI4wuCthLU4cB3O22/z4kUuy7UOQFIBM
WGs6t+JKbj0wsqC2PpPRXTrMx1yYibxwWhS6pU3qI+dHJ4ZZedRXlKEH3WgbSgIY
3tTb4FunMQW4l3nWtnc0L5QXyi6/4ONrCgm7LR9B9KcQVakqlJMUODNyUZ6MKrz6
ytNcCQAkVF9+uNEuL47B/2h/Q6xskkqvpXg6LEGZRJTdXF8MQjJ7Ca1zXQxunbGe
rSWDFIWDu3fdVzSB3LFT4srCJ3nFlpcGvO0sEICdhNeJJixIgUwCI+egS5UIb00=
=HgqX
-----END PGP SIGNATURE-----

--Sig_/i+OcmDl9wiuYsHL3SYFlN37--
