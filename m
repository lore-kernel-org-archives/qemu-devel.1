Received: from eggs.gnu.org ([2001:4830:134:3::10]:39001)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dqM2k-0006Zc-1S
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 12:22:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dqM2g-0004O3-UM
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 12:22:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48548)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dqM2g-0004NZ-L3
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 12:22:06 -0400
Date: Fri, 8 Sep 2017 17:22:02 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170908162201.GC2836@work-vm>
References: <20170908155359.27952-1-dgilbert@redhat.com>
	<26a00723-027c-4445-0590-d50739dec557@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <26a00723-027c-4445-0590-d50739dec557@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] slirp: Add explanation for hostfwd parsing
 failure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org, samuel.thibault@ens-lyon.org, jan.kiszka@siemens.com

* Philippe Mathieu-Daud=E9 (f4bug@amsat.org) wrote:
> Hi David,
>=20
> On 09/08/2017 12:53 PM, Dr. David Alan Gilbert (git) wrote:
> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> >=20
> > e.g.
> > ./x86_64-softmmu/qemu-system-x86_64 -nographic -netdev 'user,id=3Dvne=
t,hostfwd=3D:555.0.0.0:0-:22'
> > qemu-system-x86_64: -netdev user,id=3Dvnet,hostfwd=3D:555.0.0.0:0-:22=
: Invalid host forwarding rule ':555.0.0.0:0-:22' (Bad host address)
> >=20
> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > ---
> >   net/slirp.c | 13 ++++++++++++-
> >   1 file changed, 12 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/net/slirp.c b/net/slirp.c
> > index 01ed21c006..d87664d42e 100644
> > --- a/net/slirp.c
> > +++ b/net/slirp.c
> > @@ -496,9 +496,11 @@ static int slirp_hostfwd(SlirpState *s, const ch=
ar *redir_str,
> >       char buf[256];
> >       int is_udp;
> >       char *end;
> > +    const char *fail_reason =3D "";
>=20
> Isn't it better not initialize this? So if one add a new failed syntax =
case
> the build with abort with -Werror=3Duninitialized

I never quite trust compilers to spot it or not-moan even though
every route to failure will have set it.

> Anyway:
> Reviewed-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>

Thanks.

Dave

>=20
> >       p =3D redir_str;
> >       if (!p || get_str_sep(buf, sizeof(buf), &p, ':') < 0) {
> > +        fail_reason =3D "No : separators";
> >           goto fail_syntax;
> >       }
> >       if (!strcmp(buf, "tcp") || buf[0] =3D=3D '\0') {
> > @@ -506,35 +508,43 @@ static int slirp_hostfwd(SlirpState *s, const c=
har *redir_str,
> >       } else if (!strcmp(buf, "udp")) {
> >           is_udp =3D 1;
> >       } else {
> > +        fail_reason =3D "Bad protocol name";
> >           goto fail_syntax;
> >       }
> >       if (!legacy_format) {
> >           if (get_str_sep(buf, sizeof(buf), &p, ':') < 0) {
> > +            fail_reason =3D "Missing : separator";
> >               goto fail_syntax;
> >           }
> >           if (buf[0] !=3D '\0' && !inet_aton(buf, &host_addr)) {
> > +            fail_reason =3D "Bad host address";
> >               goto fail_syntax;
> >           }
> >       }
> >       if (get_str_sep(buf, sizeof(buf), &p, legacy_format ? ':' : '-'=
) < 0) {
> > +        fail_reason =3D "Bad host port separator";
> >           goto fail_syntax;
> >       }
> >       host_port =3D strtol(buf, &end, 0);
> >       if (*end !=3D '\0' || host_port < 0 || host_port > 65535) {
> > +        fail_reason =3D "Bad host port";
> >           goto fail_syntax;
> >       }
> >       if (get_str_sep(buf, sizeof(buf), &p, ':') < 0) {
> > +        fail_reason =3D "Missing guest address";
> >           goto fail_syntax;
> >       }
> >       if (buf[0] !=3D '\0' && !inet_aton(buf, &guest_addr)) {
> > +        fail_reason =3D "Bad guest address";
> >           goto fail_syntax;
> >       }
> >       guest_port =3D strtol(p, &end, 0);
> >       if (*end !=3D '\0' || guest_port < 1 || guest_port > 65535) {
> > +        fail_reason =3D "Bad guest port";
> >           goto fail_syntax;
> >       }
> > @@ -547,7 +557,8 @@ static int slirp_hostfwd(SlirpState *s, const cha=
r *redir_str,
> >       return 0;
> >    fail_syntax:
> > -    error_setg(errp, "Invalid host forwarding rule '%s'", redir_str)=
;
> > +    error_setg(errp, "Invalid host forwarding rule '%s' (%s)", redir=
_str,
> > +               fail_reason);
> >       return -1;
> >   }
> >=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
