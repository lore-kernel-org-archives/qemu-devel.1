Received: from eggs.gnu.org ([2001:4830:134:3::10]:58752)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gDQxW-0007az-Ul
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 05:20:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gDQxS-0007zi-GB
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 05:20:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36412)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gDQxP-0007fM-W2
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 05:20:38 -0400
Date: Fri, 19 Oct 2018 10:20:21 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181019092021.GE13722@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20181009130442.26296-1-berrange@redhat.com>
	<20181009130442.26296-9-berrange@redhat.com>
	<2a296b73-f080-d081-9ddb-affbd12ee775@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2a296b73-f080-d081-9ddb-affbd12ee775@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 08/11] authz: add QAuthZList object type
 for an access control list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>

On Fri, Oct 19, 2018 at 11:18:07AM +0200, Philippe Mathieu-Daud=C3=A9 wro=
te:
> Hi Daniel, Markus.
>=20
> On 09/10/2018 15:04, Daniel P. Berrang=C3=A9 wrote:
> ...
> >  .gitignore              |   4 +
> >  MAINTAINERS             |   1 +
> >  Makefile                |   7 +-
> >  Makefile.objs           |   4 +
> >  authz/Makefile.objs     |   1 +
> >  authz/list.c            | 315 ++++++++++++++++++++++++++++++++++++++=
++
> >  authz/trace-events      |   4 +
> >  include/authz/list.h    | 106 ++++++++++++++
> >  qapi/authz.json         |  58 ++++++++
> >  qapi/qapi-schema.json   |   1 +
> >  tests/Makefile.include  |   4 +
> >  tests/test-authz-list.c | 171 ++++++++++++++++++++++
> >  12 files changed, 675 insertions(+), 1 deletion(-)
> >  create mode 100644 authz/list.c
> >  create mode 100644 include/authz/list.h
> >  create mode 100644 qapi/authz.json
> >  create mode 100644 tests/test-authz-list.c
> >=20
> > diff --git a/.gitignore b/.gitignore
> > index 64efdfd929..9b9fcad829 100644
> > --- a/.gitignore
> > +++ b/.gitignore
> > @@ -47,6 +47,7 @@
> >  /qapi/qapi-commands-trace.[ch]
> >  /qapi/qapi-commands-transaction.[ch]
> >  /qapi/qapi-commands-ui.[ch]
> > +/qapi/qapi-commands-authz.[ch]
> >  /qapi/qapi-commands.[ch]
> >  /qapi/qapi-events-block-core.[ch]
> >  /qapi/qapi-events-block.[ch]
> > @@ -65,6 +66,7 @@
> >  /qapi/qapi-events-trace.[ch]
> >  /qapi/qapi-events-transaction.[ch]
> >  /qapi/qapi-events-ui.[ch]
> > +/qapi/qapi-events-authz.[ch]
> >  /qapi/qapi-events.[ch]
> >  /qapi/qapi-introspect.[ch]
> >  /qapi/qapi-types-block-core.[ch]
> > @@ -84,6 +86,7 @@
> >  /qapi/qapi-types-trace.[ch]
> >  /qapi/qapi-types-transaction.[ch]
> >  /qapi/qapi-types-ui.[ch]
> > +/qapi/qapi-types-authz.[ch]
> >  /qapi/qapi-types.[ch]
> >  /qapi/qapi-visit-block-core.[ch]
> >  /qapi/qapi-visit-block.[ch]
> > @@ -102,6 +105,7 @@
> >  /qapi/qapi-visit-trace.[ch]
> >  /qapi/qapi-visit-transaction.[ch]
> >  /qapi/qapi-visit-ui.[ch]
> > +/qapi/qapi-visit-authz.[ch]
> >  /qapi/qapi-visit.[ch]
> >  /qapi/qapi-doc.texi
> >  /qemu-doc.html
>=20
> We already use the '.inc.c' suffix:
>=20
> $ git ls-files|fgrep  .inc.c|wc -l
> 38
>=20
> What about starting to use the '.gen.c' one with the QAPI generated fil=
es?

We don't even need that - we could just wildcard on the existing file
names

  /qapi/qapi-commands-*.[ch]
  /qapi/qapi-events-*.[ch]
  /qapi/qapi-types-*.[ch]
  /qapi/qapi-visit-*.[ch]

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
