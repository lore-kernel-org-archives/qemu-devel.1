Received: from eggs.gnu.org ([2001:4830:134:3::10]:37286)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pkrempa@redhat.com>) id 1f3JNy-0004Bo-CS
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 06:41:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pkrempa@redhat.com>) id 1f3JNt-0005LB-FK
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 06:41:54 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39118 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pkrempa@redhat.com>) id 1f3JNt-0005Kg-A7
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 06:41:49 -0400
Date: Tue, 3 Apr 2018 12:41:39 +0200
From: Peter Krempa <pkrempa@redhat.com>
Message-ID: <20180403104113.GI38016@angien.pipo.sk>
References: <1520860275-101576-1-git-send-email-imammedo@redhat.com>
	<1520860275-101576-4-git-send-email-imammedo@redhat.com>
	<20180323212508.GF28161@localhost.localdomain>
	<20180327170541.295fc29a@redhat.com>
	<20180328191732.GQ5046@localhost.localdomain>
	<20180329150112.2e1d3030@redhat.com>
	<20180329165754.GZ5046@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/qIPZgKzMPM+y5U5"
Content-Disposition: inline
In-Reply-To: <20180329165754.GZ5046@localhost.localdomain>
Subject: Re: [Qemu-devel] [PATCH v4 3/9] cli: add -preconfig option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org, peter.maydell@linaro.org, cohuck@redhat.com, armbru@redhat.com, pbonzini@redhat.com


--/qIPZgKzMPM+y5U5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 29, 2018 at 13:57:54 -0300, Eduardo Habkost wrote:
> On Thu, Mar 29, 2018 at 03:01:12PM +0200, Igor Mammedov wrote:
> > On Wed, 28 Mar 2018 16:17:32 -0300
> > Eduardo Habkost <ehabkost@redhat.com> wrote:
> > > On Tue, Mar 27, 2018 at 05:05:41PM +0200, Igor Mammedov wrote:
> > > > On Fri, 23 Mar 2018 18:25:08 -0300
> > > > Eduardo Habkost <ehabkost@redhat.com> wrote:
> > > > > On Mon, Mar 12, 2018 at 02:11:09PM +0100, Igor Mammedov wrote: =
=20

[...]

> > > > > Why exactly it's not possible to use -incoming with -preconfig? =
=20
> > > > there are 2 reasons why I made options mutually exclusive
> > > > 1. (excuse ) '-incoming' is an option with non explicit side effects
> > > >    on other parts of code. It's hard to predict behavior
> > > >    of preconfig commands in combination with inmigrate.
> > > >    I wouldn't try to touch/change anything related to it
> > > >    in this series.
> > > >    If we need to change how option is handled, it should
> > > >    be separate series that focuses on it.
> > > > 2. (main reason) is to expose as minimal interface
> > > >    as possible. It's easier to extend/modify it future if
> > > >    necessary than cut it down after it was introduced.
> > > >=20
> > > >    Not counting [1], I don't see a reason to permit
> > > >    'preconfig' while migration is in progress.
> > > >    Configuration commands that where used during 'preconfig'
> > > >    stage on source side, should use corresponding CLI options
> > > >    on target side. (it's the same behavior as with hotplugged
> > > >    devices, keeping migration work-flow the same)
> > > >=20
> > > > In short I'd prefer to keep restriction until there will be
> > > > a real usecase for combo to work together. =20
> > >=20
> > > I understand the reasons, but I think we already have an
> > > important use case: live-migrating a VM with non-trivial NUMA
> > > config (that needs -preconfig).  Don't we?
> > Not really,
> > whatever we have configured on source side using -preconfig
> > (discovering valid topology in process), we should be able
> > to replicate using only CLI options on target since we
> > already have all necessary values for it from source (it's
> > certainly the case with this series set-numa-node command).
> >=20
> > As for the future, I agree it would be much more flexible
> > to allow both -preconfig and -incoming at the same time,
> > so we could start target with empty CLI, and then feed it
> > options from source. It would require audit/refactoring of
> > INMIGRATE state and making 'all' current CLI options
> > available via QMP interface.
> >=20
> > But for now I'd prefer to keep using old way to start target.
>=20
> Well, if management software developers tell us that -preconfig
> will be already useful without -incoming support, I won't object.


Hmm, that depends on what we will be configured using the new interface.
We usually prefer to use the same approach to set up things when
starting a new VM and when starting a VM for migration.

Since we do have options to setup the vCPU topology stuff on the
command line once we are going to migrate, we certainly can use
-preconfig even when it will collide with -incoming

Ideally -preconfig should replace -incoming, so that we can swithc to
incomming migration operation after we configure everything.

> But it would be very nice for management software if they can
> simply assume that -preconfig and -incoming will work together
> since the first version.  Can we have this as a goal for 2.13?

It usually helps in reducing code clutter.

--/qIPZgKzMPM+y5U5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEUn7DGLvflazX+2GwHGwCByjY1GoFAlrDWmMACgkQHGwCByjY
1GpmPBAAomp+itlJ0PcADO+omZZG65t4xvoFSH79e3EZpFg/oNCeciABPqNd1J6I
WEPh9IlE6qXoqpUvtH6KdNs0Dnhf1VW3+tDsBykdmRdhBOgbpLCYuCYAjg9yukVM
xVHYT9xHcZLlXkjptO2d2hsrqAjsGrY0FK2dxcesr1/3gWgzEsR1WX0vDMbS4Wwv
2Esng9uH7VH11WCrWZsKhi1JTju7OliXrUN5nhvV1voCBbE5OG/spaz7VN+ulxF+
iNSHfEuWhnhNppOAkbOWgFbN8mwJhBeasS7+dxaItkl8A1ORL1me3MwCjT6OrBTF
5xDvuh9swct6nUAG/tf5W3GerWsNB4tl9bss1ltn2DNbS6dIN/dR+t+D6KZGKbj9
9Tibiazkuil4Xsa2vYn4HaAs7ZMkj/oEe9lPexuNxWvaL4B+PO+KXSd9SuYyVirG
2448VIZ4pgvpSc1+Ss2gLYSDjQOhzHMlQb3VP7BybYg069ni2d94W82Ru/bejxsQ
xUyoEafvXB4HpeAjhh8lzN9YXtCFO8HNc2vXOHLPHLahK8lF1+rNYAmBdHPn+8tL
icfBfPXK/ZFYZD9WsW2s0UhxwhrA0L73wqJ51vJHjEV+XqhIR3krxNJ90GIo44cz
BcpPaJ7c90uh9Vo6jZVN/sNeRzeEVowaHgxU7AcGvyt5JLArw8g=
=nGt0
-----END PGP SIGNATURE-----

--/qIPZgKzMPM+y5U5--
