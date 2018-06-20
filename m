Received: from eggs.gnu.org ([2001:4830:134:3::10]:38708)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fVdmK-0006SU-9F
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 10:08:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fVdmI-0004rc-UH
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 10:08:08 -0400
Date: Wed, 20 Jun 2018 15:07:54 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180620140754.GP3441@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180620121423.16979-1-berrange@redhat.com>
	<20180620121423.16979-3-berrange@redhat.com>
	<205e17cb-30f6-ace2-d8eb-e6a60d84731d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <205e17cb-30f6-ace2-d8eb-e6a60d84731d@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 2/6] nbd: allow authorization with
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
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Juan Quintela <quintela@redhat.com>

On Wed, Jun 20, 2018 at 09:05:32AM -0500, Eric Blake wrote:
> On 06/20/2018 07:14 AM, Daniel P. Berrang=C3=A9 wrote:
> > From: "Daniel P. Berrange" <berrange@redhat.com>
>=20
> I thought you preferred the UTF-8 accent in your Author lines these day=
s?
> Or is this because this patch has been sitting around in your local rep=
o
> prior to the point where you switched your git config author spelling? =
(Also
> applies to S-o-b in the series)

Yeah its "only" been sitting in my tree since late 2016 :-)

>=20
> >=20
> > As with the previous patch to qemu-nbd, the nbd-server-start QMP comm=
and
> > also needs to be able to specify authorization when enabling TLS encr=
yption.
> >=20
> > First the client must create a QAuthZ object instance using the
> > 'object-add' command:
> >=20
>=20
> > They can then reference this in the new 'tls-authz' parameter when
> > executing the 'nbd-server-start' command:
> >=20
>=20
> > @@ -132,11 +137,12 @@ void nbd_server_start(SocketAddress *addr, cons=
t char *tls_creds,
> >   void qmp_nbd_server_start(SocketAddressLegacy *addr,
> >                             bool has_tls_creds, const char *tls_creds=
,
> > +                          bool has_tls_authz, const char *tls_authz,
> >                             Error **errp)
> >   {
> >       SocketAddress *addr_flat =3D socket_address_flatten(addr);
> > -    nbd_server_start(addr_flat, tls_creds, errp);
> > +    nbd_server_start(addr_flat, tls_creds, tls_authz, errp);
>=20
> Relies on QMP generated code setting tls_authz =3D NULL if has_tls_auth=
z is
> false (but no different than the fact that we already relied on it for
> tls_creds).  Someday it would be nice to get rid of the has_FOO for opt=
ional
> strings, but that's not your problem.
>=20
> > +++ b/qapi/block.json
> > @@ -197,6 +197,11 @@
> >   #
> >   # @addr: Address on which to listen.
> >   # @tls-creds: (optional) ID of the TLS credentials object. Since 2.=
6
> > +# @tls-authz: ID of the QAuthZ authorization object used to validate
> > +#             the client's x509 distinguished name. This object is
> > +#             is only resolved at time of use, so can be deleted and
> > +#             recreated on the fly while the NBD server is active.
> > +#             If missing, it will default to denying access. Since 3=
.0
> >   #
> >   # Returns: error if the server is already running.
> >   #
> > @@ -204,7 +209,8 @@
> >   ##
> >   { 'command': 'nbd-server-start',
> >     'data': { 'addr': 'SocketAddressLegacy',
> > -            '*tls-creds': 'str'} }
> > +            '*tls-creds': 'str',
> > +            '*tls-authz': 'str'} }
>=20
> Reviewed-by: Eric Blake <eblake@redhat.com>
>=20
> Although patch 1 and 2 touch NBD, I'm happy for Dan to be the one that
> merges it as part of the larger series.
>=20
> --=20
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3266
> Virtualization:  qemu.org | libvirt.org

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
