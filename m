Received: from eggs.gnu.org ([2001:4830:134:3::10]:49102)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fVOnG-00016Q-Qv
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 18:08:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fVOnD-00019R-R6
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 18:08:06 -0400
Date: Tue, 19 Jun 2018 23:07:52 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180619220752.GB19712@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180615155103.11924-1-berrange@redhat.com>
	<20180615155103.11924-3-berrange@redhat.com>
	<d10a7833-5e37-52cb-cb5d-25018313469a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d10a7833-5e37-52cb-cb5d-25018313469a@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/6] nbd: allow authorization with
 nbd-server-start QMP command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, qemu-block@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>

On Tue, Jun 19, 2018 at 03:10:12PM -0500, Eric Blake wrote:
> On 06/15/2018 10:50 AM, Daniel P. Berrang=C3=A9 wrote:
> > From: "Daniel P. Berrange" <berrange@redhat.com>
> >=20
> > As with the previous patch to qemu-nbd, the nbd-server-start QMP comm=
and
> > also needs to be able to specify authorization when enabling TLS encr=
yption.
> >=20
> > First the client must create a QAuthZ object instance using the
> > 'object-add' command:
> >=20
> >     {
> >       'execute': 'object-add',
> >       'arguments': {
> >         'qom-type': 'authz-simple',
> >         'id': 'authz0',
> >         'parameters': {
> >           'policy': 'deny',
> >           'rules': [
> >             {
> >               'match': '*CN=3Dfred',
> >               'policy': 'allow'
> >             }
> >           ]
> >         }
> >       }
> >     }
> >=20
> > They can then reference this in the new 'tls-authz' parameter when
> > executing the 'nbd-server-start' command:
> >=20
> >     {
> >       'execute': 'nbd-server-start',
> >       'arguments': {
> >         'addr': {
> >             'type': 'inet',
> >             'host': '127.0.0.1',
> >             'port': '9000'
> >         },
> >         'tls-creds': 'tls0',
> >         'tls-authz': 'authz0'
> >       }
> >     }
>=20
> Is it worth using a discriminated union (string vs. QAuthZ) so that one
> could specify the authz policy inline rather than as a separate object,=
 for
> convenience?  But that would be fine as a followup patch, if we even wa=
nt
> it.

QAuthZ isn't a QAPI type - its a QOM object interface, so you'd have to
allow the entire object_add arg set inline, and then validate the QOM typ=
e
you received after the fact actually implemented the interface.  Also for
migration at least it is likely the single authz impl will be shared for
both migration + nbd services. So I think its cleaner just to keep it
separate to avoid having 2 distinct codepaths for handling the same thing


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
