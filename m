Received: from eggs.gnu.org ([209.51.188.92]:33613)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gonVX-0000ej-6h
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 05:54:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gonVW-0002f6-5p
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 05:54:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60576)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1gonVV-0002ez-U3
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 05:54:14 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3699DC7907
	for <qemu-devel@nongnu.org>; Wed, 30 Jan 2019 10:54:13 +0000 (UTC)
Date: Wed, 30 Jan 2019 10:54:04 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190130105404.GA2677@work-vm>
References: <20190130103236.18302-1-dgilbert@redhat.com>
	<20190130103236.18302-3-dgilbert@redhat.com>
	<20190130104331.GG15904@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190130104331.GG15904@redhat.com>
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
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, jasowang@redhat.com, quintela@redhat.com, mst@redhat.com, eblake@redhat.com, armbru@redhat.com, germano@redhat.com

* Daniel P. Berrang=E9 (berrange@redhat.com) wrote:
> On Wed, Jan 30, 2019 at 10:32:29AM +0000, Dr. David Alan Gilbert (git) =
wrote:
> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> >=20
> > Add migration parameters that control RARP/GARP announcement timeouts=
.
> >=20
> > Based on earlier patches by myself and
> >   Vladislav Yasevich <vyasevic@redhat.com>
> >=20
> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > ---
> >  hmp.c                    |  28 +++++++++++
> >  include/migration/misc.h |   2 +
> >  include/qemu/typedefs.h  |   1 +
> >  migration/migration.c    | 100 +++++++++++++++++++++++++++++++++++++=
++
> >  qapi/migration.json      |  54 +++++++++++++++++++--
> >  5 files changed, 182 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/qapi/migration.json b/qapi/migration.json
> > index 7a795ecc16..113bb5d925 100644
> > --- a/qapi/migration.json
> > +++ b/qapi/migration.json
> > @@ -6,6 +6,7 @@
> >  ##
> > =20
> >  { 'include': 'common.json' }
> > +{ 'include': 'net.json' }
>=20
>=20
> > @@ -572,6 +588,18 @@
> >  ##
> >  # @MigrateSetParameters:
> >  #
> > +# @announce-initial: Initial delay (in ms) before sending the first =
announce
> > +#          (Since 4.0)
> > +#
> > +# @announce-max: Maximum delay (in ms) between packets in the announ=
cment
> > +#          (Since 4.0)
> > +#
> > +# @announce-rounds: Number of self-announce packets sent after migra=
tion
> > +#          (Since 4.0)
> > +#
> > +# @announce-step: Increase in delay (in ms) between subsequent packe=
ts in
> > +#          the announcement (Since 4.0)
> > +#
> >  # @compress-level: compression level
> >  #
> >  # @compress-threads: compression thread count
> > @@ -653,7 +681,11 @@
> >  # TODO either fuse back into MigrationParameters, or make
> >  # MigrationParameters members mandatory
> >  { 'struct': 'MigrateSetParameters',
> > -  'data': { '*compress-level': 'int',
> > +  'data': { '*announce-initial': 'size',
> > +            '*announce-max': 'size',
> > +            '*announce-rounds': 'size',
> > +            '*announce-step': 'size',
> > +            '*compress-level': 'int',
> >              '*compress-threads': 'int',
> >              '*compress-wait-thread': 'bool',
> >              '*decompress-threads': 'int',
>=20
> Historically we've just had a flat list of migration parameters, but
> QAPI doesn't require this. So I wonder about just referencing the
> type you defined in the previous patch:
>=20
>    '*announce': 'AnnounceParameters
>=20
> from a QMP pov this is trivial & feels more natural. The only downside
> I see is that for HMP it would need to be flattened to what it is here.
> We generally tend to prefer QMP's natural style, even if it doesn't
> match what's nicest for HMP.

I don't trust that's true from QMP; the logic to keep the parameters
optional so that you can set a parameter individually is already pretty
hairy.

Dave

> > @@ -692,6 +724,18 @@
> >  #
> >  # The optional members aren't actually optional.
> >  #
> > +# @announce-initial: Initial delay (in ms) before sending the first =
announce
> > +#          (Since 4.0)
> > +#
> > +# @announce-max: Maximum delay (in ms) between packets in the announ=
cment
> > +#          (Since 4.0)
> > +#
> > +# @announce-rounds: Number of self-announce packets sent after migra=
tion
> > +#          (Since 4.0)
> > +#
> > +# @announce-step: Increase in delay (in ms) between subsequent packe=
ts in
> > +#          the announcement (Since 4.0)
> > +#
> >  # @compress-level: compression level
> >  #
> >  # @compress-threads: compression thread count
> > @@ -769,7 +813,11 @@
> >  # Since: 2.4
> >  ##
> >  { 'struct': 'MigrationParameters',
> > -  'data': { '*compress-level': 'uint8',
> > +  'data': { '*announce-initial': 'size',
> > +            '*announce-max': 'size',
> > +            '*announce-rounds': 'size',
> > +            '*announce-step': 'size',
>=20
> Same here about just referencing the AnnounceParameters type.
>=20
> > +            '*compress-level': 'uint8',
> >              '*compress-threads': 'uint8',
> >              '*compress-wait-thread': 'bool',
> >              '*decompress-threads': 'uint8',
>=20
> Regards,
> Daniel
> --=20
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberr=
ange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange=
.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberr=
ange :|
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
