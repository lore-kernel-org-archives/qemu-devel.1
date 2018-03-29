Received: from eggs.gnu.org ([2001:4830:134:3::10]:56066)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1f1TAQ-0006cj-8W
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 04:44:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1f1TAN-0004nr-5T
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 04:44:18 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35586 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1f1TAN-0004nj-0A
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 04:44:15 -0400
Date: Thu, 29 Mar 2018 09:44:01 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180329084400.GB2982@work-vm>
References: <20180328163630.48576-1-dgilbert@redhat.com>
	<20180328163630.48576-6-dgilbert@redhat.com>
	<780d6d45-84a6-34db-e65f-3d38a6d0ea66@redhat.com>
	<20180329080846.GA2982@work-vm>
	<50fe8034-d0c1-94ea-40fc-b97b10ff5d8f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <50fe8034-d0c1-94ea-40fc-b97b10ff5d8f@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 5/6] e1000: Choose which set of props to
 migrate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: pbonzini@redhat.com, eswierk@skyportsystems.com, qemu-devel@nongnu.org, peterx@redhat.com, quintela@redhat.com

* Jason Wang (jasowang@redhat.com) wrote:
>=20
>=20
> On 2018=E5=B9=B403=E6=9C=8829=E6=97=A5 16:08, Dr. David Alan Gilbert wr=
ote:
> > * Jason Wang (jasowang@redhat.com) wrote:
> > >=20
> > > On 2018=E5=B9=B403=E6=9C=8829=E6=97=A5 00:36, Dr. David Alan Gilber=
t (git) wrote:
> > > > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> > > >=20
> > > > When we're using the subsection we migrate both
> > > > the 'props' and 'tso_props' data; when we're not using
> > > > the subsection (to migrate to 2.11 or old machine types) we've
> > > > got to choose what to migrate in the main structure.
> > > >=20
> > > > If we're using the subsection migrate 'props' in the main structu=
re.
> > > > If we're not using the subsection then migrate the last one
> > > > that changed, which gives behaviour similar to the old behaviour.
> > > >=20
> > > >=20
> > > But only after migration. Why not simply switch back to the old beh=
avior if
> > > migrate_tso_props if false?
> > Because:
> >    1) We know it's a broken behaviour so it's better not to unfix it
> >    2) The fix doesn't change guest visible behaviour other than actua=
lly
> >       sending the right packets; so there's no reason to make the fix
> >       itself dependent on the machine type.
> >    3) Gating the fix itself on the flag is actually more complex and
> >       would need checking the flag in lots of places that are already
> >       pretty complex, rather than what this does which is just check =
it
> >       in one place at migration.
>=20
> It looks to me it was just something like:
>=20
> =C2=A0=C2=A0=C2=A0 struct e1000x_txd_props *props =3D tp->cptse && chkf=
lag(TSO) ?
> &tp->tso_props : &tp->props;

is that the only thing that would change?

> Btw, did this patch work when:
>=20
> migrate A to B
> migrate B to C
>=20
> But there's no tx during B?

Hmm, good question; I only tried it keeping the stream alive during
migration.
Lets see what happens.

For this code to be used we have to be running with an old machine
type/property.
That means A->B will have either come from 2.11 or a 2.12 with this same
patch.
But given patch 2 that duplicates on loading; that means A->B should
end up with B having the same data in both sets of props, and
thus it doesn't matter which set this patch picks.

Dave

> Thanks
>=20
> >=20
> > Dave
> > > Thanks
> > >=20
> > --
> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> >=20
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
