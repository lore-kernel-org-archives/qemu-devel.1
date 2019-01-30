Received: from eggs.gnu.org ([209.51.188.92]:59792)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gorAZ-0002R3-1e
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 09:48:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gorAX-0004bJ-RG
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 09:48:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34220)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gorAX-0004aW-Is
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 09:48:49 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 64C11A429D
	for <qemu-devel@nongnu.org>; Wed, 30 Jan 2019 14:48:48 +0000 (UTC)
Date: Wed, 30 Jan 2019 14:48:31 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190130144831.GR15904@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190130103236.18302-1-dgilbert@redhat.com>
	<20190130103236.18302-3-dgilbert@redhat.com>
	<20190130104331.GG15904@redhat.com> <20190130105404.GA2677@work-vm>
	<20190130105910.GI15904@redhat.com> <20190130120145.GC2677@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190130120145.GC2677@work-vm>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 2/9] migration: Add announce parameters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, jasowang@redhat.com, quintela@redhat.com, mst@redhat.com, eblake@redhat.com, armbru@redhat.com, germano@redhat.com

On Wed, Jan 30, 2019 at 12:01:46PM +0000, Dr. David Alan Gilbert wrote:
> * Daniel P. Berrang=C3=A9 (berrange@redhat.com) wrote:
> > On Wed, Jan 30, 2019 at 10:54:04AM +0000, Dr. David Alan Gilbert wrot=
e:
> > > * Daniel P. Berrang=C3=A9 (berrange@redhat.com) wrote:
> > > > On Wed, Jan 30, 2019 at 10:32:29AM +0000, Dr. David Alan Gilbert =
(git) wrote:
> > > > > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> > > > >=20
> > > > > Add migration parameters that control RARP/GARP announcement ti=
meouts.
> > > > >=20
> > > > > Based on earlier patches by myself and
> > > > >   Vladislav Yasevich <vyasevic@redhat.com>
> > > > >=20
> > > > > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > > > > ---
> > > > >  hmp.c                    |  28 +++++++++++
> > > > >  include/migration/misc.h |   2 +
> > > > >  include/qemu/typedefs.h  |   1 +
> > > > >  migration/migration.c    | 100 +++++++++++++++++++++++++++++++=
++++++++
> > > > >  qapi/migration.json      |  54 +++++++++++++++++++--
> > > > >  5 files changed, 182 insertions(+), 3 deletions(-)
> > > > >=20
> > > > > diff --git a/qapi/migration.json b/qapi/migration.json
> > > > > index 7a795ecc16..113bb5d925 100644
> > > > > --- a/qapi/migration.json
> > > > > +++ b/qapi/migration.json
> > > > > @@ -6,6 +6,7 @@
> > > > >  ##
> > > > > =20
> > > > >  { 'include': 'common.json' }
> > > > > +{ 'include': 'net.json' }
> > > >=20
> > > >=20
> > > > > @@ -572,6 +588,18 @@
> > > > >  ##
> > > > >  # @MigrateSetParameters:
> > > > >  #
> > > > > +# @announce-initial: Initial delay (in ms) before sending the =
first announce
> > > > > +#          (Since 4.0)
> > > > > +#
> > > > > +# @announce-max: Maximum delay (in ms) between packets in the =
announcment
> > > > > +#          (Since 4.0)
> > > > > +#
> > > > > +# @announce-rounds: Number of self-announce packets sent after=
 migration
> > > > > +#          (Since 4.0)
> > > > > +#
> > > > > +# @announce-step: Increase in delay (in ms) between subsequent=
 packets in
> > > > > +#          the announcement (Since 4.0)
> > > > > +#
> > > > >  # @compress-level: compression level
> > > > >  #
> > > > >  # @compress-threads: compression thread count
> > > > > @@ -653,7 +681,11 @@
> > > > >  # TODO either fuse back into MigrationParameters, or make
> > > > >  # MigrationParameters members mandatory
> > > > >  { 'struct': 'MigrateSetParameters',
> > > > > -  'data': { '*compress-level': 'int',
> > > > > +  'data': { '*announce-initial': 'size',
> > > > > +            '*announce-max': 'size',
> > > > > +            '*announce-rounds': 'size',
> > > > > +            '*announce-step': 'size',
> > > > > +            '*compress-level': 'int',
> > > > >              '*compress-threads': 'int',
> > > > >              '*compress-wait-thread': 'bool',
> > > > >              '*decompress-threads': 'int',
> > > >=20
> > > > Historically we've just had a flat list of migration parameters, =
but
> > > > QAPI doesn't require this. So I wonder about just referencing the
> > > > type you defined in the previous patch:
> > > >=20
> > > >    '*announce': 'AnnounceParameters
> > > >=20
> > > > from a QMP pov this is trivial & feels more natural. The only dow=
nside
> > > > I see is that for HMP it would need to be flattened to what it is=
 here.
> > > > We generally tend to prefer QMP's natural style, even if it doesn=
't
> > > > match what's nicest for HMP.
> > >=20
> > > I don't trust that's true from QMP; the logic to keep the parameter=
s
> > > optional so that you can set a parameter individually is already pr=
etty
> > > hairy.
> >=20
> > Yes, this different design would mean that the overall 'announce' par=
maeter
> > was optional. If you did provide one of the parameters though, you wo=
uld
> > need to provide all 4 of them. I don't think that's a bad thing thoug=
h, as
> > the values really only make sense when considered as a whole. So sett=
ing
> > one announce parameter without knowing what the other values are is s=
omewhat
> > unreliable.=20
>=20
> Actually, some of them make a lot of sense; for example just setting
> 'rounds' to 0 to stop any announce works really well, or doubling it if
> you want to keep it shouting longer;  my suspicion is that very few
> people would fiddle with anything except 'rounds'.

Ok, well don't consider my suggestion a blocker if you think it is not
desirable.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
