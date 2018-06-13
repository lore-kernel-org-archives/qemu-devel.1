Received: from eggs.gnu.org ([2001:4830:134:3::10]:32889)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fT97Q-0008Dl-EJ
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 12:59:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fT97M-00064g-Hb
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 12:59:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33712)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fT97M-00062p-8s
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 12:59:32 -0400
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com
	[10.5.11.25])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 54D8E30015CA
	for <qemu-devel@nongnu.org>; Wed, 13 Jun 2018 16:59:31 +0000 (UTC)
Date: Wed, 13 Jun 2018 13:59:28 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180613165928.GZ7451@localhost.localdomain>
References: <20180608130846.22234-1-dgilbert@redhat.com>
	<20180608130846.22234-6-dgilbert@redhat.com>
	<87y3flilan.fsf@dusky.pond.sub.org> <20180611174958.GP2661@work-vm>
	<877en4y07a.fsf@dusky.pond.sub.org> <20180612084914.GA2512@work-vm>
	<20180613134745.GQ7451@localhost.localdomain>
	<20180613135337.GV19901@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180613135337.GV19901@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 5/7] hmp: Add info commands for preconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, imammedo@redhat.com, Gerd Hoffmann <kraxel@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org

On Wed, Jun 13, 2018 at 02:53:37PM +0100, Daniel P. Berrang=E9 wrote:
> On Wed, Jun 13, 2018 at 10:47:45AM -0300, Eduardo Habkost wrote:
> > On Tue, Jun 12, 2018 at 09:49:14AM +0100, Dr. David Alan Gilbert wrot=
e:
> > [...]
> > > > > People have been trying to add qom-get etc for quite a while (I=
 tried a
> > > > > couple of years ago); it gets stuck in type display issues.  I'=
ve not
> > > > > directly seen a need for those other variants, but qom-get is s=
omething
> > > > > I'd love to have, still that's a job for another patch.
> > > >=20
> > > > Yes.
> > > >=20
> > > > > 'info qom-tree' is very very useful when debugging qemu to see =
what the
> > > > > basic state we're building is; it's primarily for debugging.
> > > >=20
> > > > I'm not at all opposed to enabling qom-tree, but I want its QMP b=
uilding
> > > > blocks enabled as well then.  I think enabling their HMP buddies =
as well
> > > > would only make sense.
> > >=20
> > > Hmm; OK, enabling qom-list, qom-get, qom-set, qom-list-types,
> > > qom-list-properties for qmp.
> > > qom-list and qom-set enabled in HMP.
> >=20
> > I would prefer to avoid enabling qom-set in preconfig mode unless
> > we have a good reason for that.  I don't trust all existing
> > property setters to not crash or break if the machine is not
> > initialized yet.
>=20
> If we're in early startup, the impact of a crash is pretty minor - QEMU
> will simply exit, which is not significantly differnt from if a setter
> handled it "correctly" by setting an Error **errp. A mgmt app that uses
> this and finds a setter which crashes will detect the problem pretty
> quickly & report bugs.
>=20
> QEMU is complex enough that we're unlikely to ever find broken setters
> by code inspection. So if we don't allow it in preconfig mode, then
> I doubt we'll ever find & fix the problems.
>=20
> So, IMHO, we should allow qom-set and just fix problems as they come
> to light, as we would for any other part of QEMU which has plenty of
> scope for crashers in rarely tested codepaths.

Good points.

I'm still worried about making qom-set confused with a supported
configuration API, and have applications starting to rely on it.

But I guess this problem could be solved by properly documenting
qom-set as a debugging aid, not a supported API.

--=20
Eduardo
