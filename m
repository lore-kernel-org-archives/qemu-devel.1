Received: from eggs.gnu.org ([209.51.188.92]:43594)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gyefs-0004Qj-Os
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 10:29:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gyefr-0007E4-Il
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 10:29:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48196)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gyefr-0007Cl-At
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 10:29:39 -0500
Date: Tue, 26 Feb 2019 15:29:21 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190226152921.GL23014@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190225123111.30363-1-berrange@redhat.com>
	<20190225123111.30363-9-berrange@redhat.com>
	<d7c93cff-7973-5248-2194-c386cf145505@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d7c93cff-7973-5248-2194-c386cf145505@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 08/11] authz: add QAuthZList object type for
 an access control list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

On Mon, Feb 25, 2019 at 08:36:33AM -0600, Eric Blake wrote:
> I missed reviewing this before the pull request, so comments here are
> best for a followup patch:
>=20
> On 2/25/19 6:31 AM, Daniel P. Berrang=C3=A9 wrote:
> > From: "Daniel P. Berrange" <berrange@redhat.com>
> >=20
> > Add a QAuthZList object type that implements the QAuthZ interface. Th=
is
> > built-in implementation maintains a trivial access control list with =
a
> > sequence of match rules and a final default policy. This replicates t=
he
> > functionality currently provided by the qemu_acl module.
> >=20
>=20
> > Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> > Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> > Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> > ---
>=20
> > +++ b/qapi/Makefile.objs
> > @@ -7,7 +7,7 @@ util-obj-y +=3D qapi-util.o
> > =20
> >  QAPI_COMMON_MODULES =3D block-core block char common crypto introspe=
ct
> >  QAPI_COMMON_MODULES +=3D job migration misc net rdma rocker run-stat=
e
> > -QAPI_COMMON_MODULES +=3D sockets tpm trace transaction ui
> > +QAPI_COMMON_MODULES +=3D sockets tpm trace transaction ui authz
>=20
> Let's keep this list alphabetically sorted (authz before block-core).
>=20
> > +++ b/qapi/authz.json
> > @@ -0,0 +1,58 @@
> > +# -*- Mode: Python -*-
> > +#
> > +# QAPI authz definitions
> > +
> > +##
> > +# @QAuthZListPolicy:
> > +#
> > +# The authorization policy result
> > +#
> > +# @deny: deny access
> > +# @allow: allow access
> > +#
> > +# Since: 4.0
> > +##
> > +{ 'enum': 'QAuthZListPolicy',
> > +  'prefix': 'QAUTHZ_LIST_POLICY',
> > +  'data': ['deny', 'allow']}
> > +
> > +##
> > +# @QAuthZListFormat:
> > +#
> > +# The authorization policy result
> > +#
> > +# @exact: an exact string match
> > +# @glob: string with ? and * shell wildcard support
>=20
> Does it actually use glob() (in which case it also has [] glob support?=
)

No, it uses g_pattern_match as glob() isn't cross-platform, and
this only supports ? and *

https://developer.gnome.org/glib/stable/glib-Glob-style-pattern-matching.=
html

  "The g_pattern_match* functions match a string against a=20
   pattern containing '*' and '?' wildcards with similar=20
   semantics as the standard glob() function: '*' matches=20
   an arbitrary, possibly empty, string, '?' matches an=20
   arbitrary character.

   Note that in contrast to glob(), the '/' character can=20
   be matched by the wildcards, there are no '[...]'=20
   character ranges and '*' and '?' can not be escaped to
   include them literally in a pattern."

> > +##
> > +# @QAuthZListRule:
> > +#
> > +# A single authorization rule.
> > +#
> > +# @match: a glob to match against a user identity
>=20
> Should this read 'a string or glob to match...' since...
>=20
> > +# @policy: the result to return if @match evaluates to true
> > +# @format: (optional) the format of the @match rule (default 'exact'=
)
>=20
> ...format controls which of the two styles it is interpreted as?  The
> use of '(optional)' is not required in the current QAPI doc generator,
> and in fact results in redundant output.

This shows how long this pach series has been waiting to merge....

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
