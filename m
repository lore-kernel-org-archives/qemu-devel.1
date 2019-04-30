Received: from eggs.gnu.org ([209.51.188.92]:34744)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hLPpo-0001PR-N8
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 06:18:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hLPiG-0006GE-K8
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 06:10:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38462)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hLPiG-0006FX-Bf
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 06:10:12 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 861563084032
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 10:10:11 +0000 (UTC)
Date: Tue, 30 Apr 2019 11:10:06 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190430101006.GA6818@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190423212246.3542-1-ehabkost@redhat.com>
	<20190423212246.3542-2-ehabkost@redhat.com>
	<20190424082652.GC28615@redhat.com>
	<20190424182036.GH18406@habkost.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190424182036.GH18406@habkost.net>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/3] qapi: SupportStatusInfo struct
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, mprivozn@redhat.com, Markus Armbruster <armbru@redhat.com>

On Wed, Apr 24, 2019 at 03:20:36PM -0300, Eduardo Habkost wrote:
> On Wed, Apr 24, 2019 at 09:26:52AM +0100, Daniel P. Berrang=C3=A9 wrote=
:
> > On Tue, Apr 23, 2019 at 06:22:44PM -0300, Eduardo Habkost wrote:
> > > This struct will be used to represent support and deprecation
> > > status of QEMU features.
> > >=20
> > > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> > > ---
> > >  qapi/common.json | 24 ++++++++++++++++++++++++
> > >  1 file changed, 24 insertions(+)
> > >=20
> > > diff --git a/qapi/common.json b/qapi/common.json
> > > index 99d313ef3b..b59d0dc66b 100644
> > > --- a/qapi/common.json
> > > +++ b/qapi/common.json
> > > @@ -193,3 +193,27 @@
> > >               'ppc64', 'riscv32', 'riscv64', 's390x', 'sh4',
> > >               'sh4eb', 'sparc', 'sparc64', 'tricore', 'unicore32',
> > >               'x86_64', 'xtensa', 'xtensaeb' ] }
> > > +
> > > +##
> > > +# @SupportStatusInfo:
> > > +#
> > > +# Information on support status of a given feature
> > > +# (e.g. machine type)
> > > +#
> > > +# @deprecated: if true, the given feature is deprecated and may be=
 removed
> > > +#              in future versions of QEMU according to the QEMU de=
precation
> > > +#              policy.
> > > +#
> > > +# @status-message: Human readable message describing support statu=
s
> > > +#                  of the feature.
> > > +#
> > > +# @suggested-alternative: Optional.  Suggested alternative for a d=
eprecated
> > > +#                         feature.  For machine types, this should=
 be the name
> > > +#                         of an available machine-type.
> > > +#
> > > +# Since: 4.1
> > > +##
> > > +{ 'struct': 'SupportStatusInfo',
> > > +  'data': { 'deprecated': 'bool',
> > > +            '*status-message': 'str',
> > > +            '*suggested-alternative': 'str' } }
> >=20
> > I see status-message has to be optional, since you're embedding the
> > struct into another struct and want deprecated=3D=3Dfalse by default.
> >=20
> > I'd be inclined to change it to embed a pointer to the struct and
> > drop the deprecated field, and make both status-message and
> > suggested-alternative be mandatory. ie a struct  "DeprecationInfo"=20
> > the pointer to which is NULL if not deprecated.
>=20
> That could be a simple solution if we were sure we would only
> track deprecation info.  But I would like us to track additional
> support status on that struct eventually.

I've no objection to expanding it to capture other info - we'll
want to change the 'deprecated' field to an enum though. Also,
in some cases there won't be any real alternative so lets just
call it 'hint' instead. How about

    { 'enum':  "SupportStatus",
      'data': { 'production',  # Secure for use in hostile production env
                'development', # No security guarentee, friendly dev only
		'deprecated',  # To be removed in the future
    } }

    { 'struct': "SupportStatusInfo",
       'data': { 'status': 'SupportStatus',
                 '*info': 'str',
		 '*hint': 'str' } }

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
