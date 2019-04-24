Received: from eggs.gnu.org ([209.51.188.92]:40516)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hJMfl-0003Rw-ID
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 14:31:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hJMVj-0003et-JP
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 14:20:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59636)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hJMVb-0003Qx-Mu
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 14:20:40 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2E134C0B2A4C
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 18:20:38 +0000 (UTC)
Date: Wed, 24 Apr 2019 15:20:36 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20190424182036.GH18406@habkost.net>
References: <20190423212246.3542-1-ehabkost@redhat.com>
	<20190423212246.3542-2-ehabkost@redhat.com>
	<20190424082652.GC28615@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190424082652.GC28615@redhat.com>
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
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, mprivozn@redhat.com, Markus Armbruster <armbru@redhat.com>

On Wed, Apr 24, 2019 at 09:26:52AM +0100, Daniel P. Berrang=E9 wrote:
> On Tue, Apr 23, 2019 at 06:22:44PM -0300, Eduardo Habkost wrote:
> > This struct will be used to represent support and deprecation
> > status of QEMU features.
> >=20
> > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> > ---
> >  qapi/common.json | 24 ++++++++++++++++++++++++
> >  1 file changed, 24 insertions(+)
> >=20
> > diff --git a/qapi/common.json b/qapi/common.json
> > index 99d313ef3b..b59d0dc66b 100644
> > --- a/qapi/common.json
> > +++ b/qapi/common.json
> > @@ -193,3 +193,27 @@
> >               'ppc64', 'riscv32', 'riscv64', 's390x', 'sh4',
> >               'sh4eb', 'sparc', 'sparc64', 'tricore', 'unicore32',
> >               'x86_64', 'xtensa', 'xtensaeb' ] }
> > +
> > +##
> > +# @SupportStatusInfo:
> > +#
> > +# Information on support status of a given feature
> > +# (e.g. machine type)
> > +#
> > +# @deprecated: if true, the given feature is deprecated and may be r=
emoved
> > +#              in future versions of QEMU according to the QEMU depr=
ecation
> > +#              policy.
> > +#
> > +# @status-message: Human readable message describing support status
> > +#                  of the feature.
> > +#
> > +# @suggested-alternative: Optional.  Suggested alternative for a dep=
recated
> > +#                         feature.  For machine types, this should b=
e the name
> > +#                         of an available machine-type.
> > +#
> > +# Since: 4.1
> > +##
> > +{ 'struct': 'SupportStatusInfo',
> > +  'data': { 'deprecated': 'bool',
> > +            '*status-message': 'str',
> > +            '*suggested-alternative': 'str' } }
>=20
> I see status-message has to be optional, since you're embedding the
> struct into another struct and want deprecated=3D=3Dfalse by default.
>=20
> I'd be inclined to change it to embed a pointer to the struct and
> drop the deprecated field, and make both status-message and
> suggested-alternative be mandatory. ie a struct  "DeprecationInfo"=20
> the pointer to which is NULL if not deprecated.

That could be a simple solution if we were sure we would only
track deprecation info.  But I would like us to track additional
support status on that struct eventually.

Also, I'd like to explicitly differentiate "information is not
available because QEMU is old" from "information is available and
machine type is not deprecated".

--=20
Eduardo
