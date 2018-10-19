Received: from eggs.gnu.org ([2001:4830:134:3::10]:42012)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gDTxE-0002Go-Gk
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 08:32:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gDTxA-0008RK-9U
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 08:32:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42104)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gDTxA-0008OD-0I
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 08:32:32 -0400
Date: Fri, 19 Oct 2018 13:32:23 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181019123223.GP13722@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20181009130442.26296-1-berrange@redhat.com>
	<20181009130442.26296-8-berrange@redhat.com>
	<CAP+75-Wkd8m+s-C_eA2uGQLreVh9MXqfuOeK4f8q48DjbBg92g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAP+75-Wkd8m+s-C_eA2uGQLreVh9MXqfuOeK4f8q48DjbBg92g@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 07/11] authz: add QAuthZSimple object
 type for easy whitelist auth checks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>

On Fri, Oct 19, 2018 at 11:56:00AM +0200, Philippe Mathieu-Daud=C3=A9 wro=
te:
> On 09/10/2018 15:04, Daniel P. Berrang=C3=A9 wrote:
> > In many cases a single VM will just need to whilelist a single identi=
ty
> > as the allowed user of network services. This is especially the case =
for
> > TLS live migration (optionally with NBD storage) where we just need t=
o
> > whitelist the x509 certificate distinguished name of the source QEMU
> > host.
> >
> > Via QMP this can be configured with:
> >
> >   {
> >     "execute": "object-add",
> >     "arguments": {
> >       "qom-type": "authz-simple",
> >       "id": "authz0",
> >       "parameters": {
> >         "identity": "fred"
> >       }
> >     }
> >   }
> >
> > Or via the command line
> >
> >   -object authz-simple,id=3Dauthz0,identity=3Dfred
> >
> > Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> > ---
> >  authz/Makefile.objs    |   1 +
> >  authz/simple.c         | 122 +++++++++++++++++++++++++++++++++++++++=
++
> >  authz/trace-events     |   3 +
> >  include/authz/simple.h |  84 ++++++++++++++++++++++++++++
> >  qemu-options.hx        |  21 +++++++
> >  5 files changed, 231 insertions(+)
> >  create mode 100644 authz/simple.c
> >  create mode 100644 include/authz/simple.h

> > +static void
> > +qauthz_simple_prop_set_identity(Object *obj,
> > +                                const char *value,
> > +                                Error **errp G_GNUC_UNUSED)
> > +{
> > +    QAuthZSimple *authz =3D QAUTHZ_SIMPLE(obj);
> > +
>=20
> Hmm don't this miss:
>=20
>          g_free(authz->identity);
>=20
> > +    authz->identity =3D g_strdup(value);
> > +}

Yes, will squash that in


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
