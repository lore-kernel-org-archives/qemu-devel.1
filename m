Received: from eggs.gnu.org ([2001:4830:134:3::10]:49912)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gMyId-0007Z4-UM
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 11:45:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gMyIZ-0006AU-6C
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 11:45:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34820)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gMyIY-00063o-UB
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 11:45:51 -0500
Date: Wed, 14 Nov 2018 16:45:37 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181114164537.GR19298@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20181019133835.16494-1-berrange@redhat.com>
	<20181019133835.16494-12-berrange@redhat.com>
	<CAJ+F1CLUOjdBO+5cTWUfNdLtCeFB_BUSHL5FOF2+6S_+gE_U4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJ+F1CLUOjdBO+5cTWUfNdLtCeFB_BUSHL5FOF2+6S_+gE_U4g@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 11/11] authz: delete existing ACL
 implementation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: QEMU <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, philmd@redhat.com

On Thu, Nov 08, 2018 at 12:15:54PM +0400, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>=20
> On Fri, Oct 19, 2018 at 5:51 PM Daniel P. Berrang=C3=A9 <berrange@redha=
t.com> wrote:
> >
> > From: "Daniel P. Berrange" <berrange@redhat.com>
> >
> > The 'qemu_acl' type was a previous non-QOM based attempt to provide a=
n
> > authorization facility in QEMU. Because it is non-QOM based it cannot=
 be
> > created via the command line and requires special monitor commands to
> > manipulate it.
> >
> > The new QAuthZ subclasses provide a superset of the functionality in
> > qemu_acl, so the latter can now be deleted. The HMP 'acl_*' monitor
> > commands are converted to use the new QAuthZSimple data type instead
> > in order to provide temporary backwards compatibility.
> >
> > Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> > +    monitor_printf(mon, "policy: %s\n",
> > +                   QAuthZListPolicy_lookup.array[auth->policy]);
>=20
> please use QAuthZListPolicy_str()
>=20
> > +
> > +    rules =3D auth->rules;
> > +    while (rules) {
> > +        QAuthZListRule *rule =3D rules->value;
> > +        i++;
> > +        monitor_printf(mon, "%zu: %s %s\n", i,
> > +                       QAuthZListPolicy_lookup.array[rule->policy],
>=20
> QAuthZListPolicy_str

Yes.


> > @@ -163,12 +165,19 @@ static int vnc_auth_sasl_check_access(VncState =
*vs)
> >      vs->sasl.username =3D g_strdup((const char*)val);
> >      trace_vnc_auth_sasl_username(vs, vs->sasl.username);
> >
> > -    if (vs->vd->sasl.acl =3D=3D NULL) {
> > +    if (vs->vd->sasl.authzid =3D=3D NULL) {
> >          trace_vnc_auth_sasl_acl(vs, 1);
> >          return 0;
> >      }
> >
> > -    allow =3D qemu_acl_party_is_allowed(vs->vd->sasl.acl, vs->sasl.u=
sername);
> > +    allow =3D qauthz_is_allowed_by_id(vs->vd->sasl.authzid,
> > +                                    vs->sasl.username, &err);
>=20
> Why not use qauthz_is_allowed() with .authz ?

The .authz object is only non-NULL when using the legacy "-vnc ..,acl"
flag syntax. When using the modern syntax (introduced by the followup
series mentioned in the cover letter) we want to resolve "authzid"
every time. This allows the user to safely delete & recreate the
authorization objects on the fly.


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
