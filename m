Received: from eggs.gnu.org ([2001:4830:134:3::10]:43300)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <benjamin.drung@profitbricks.com>) id 1emlk5-00078W-0p
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 14:32:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <benjamin.drung@profitbricks.com>) id 1emljz-0003SK-Vi
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 14:32:19 -0500
Received: from mail-wm0-x232.google.com ([2a00:1450:400c:c09::232]:39831)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <benjamin.drung@profitbricks.com>)
	id 1emljz-0003Re-Ib
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 14:32:15 -0500
Received: by mail-wm0-x232.google.com with SMTP id b21so4943905wme.4
	for <qemu-devel@nongnu.org>; Fri, 16 Feb 2018 11:32:15 -0800 (PST)
Message-ID: <1518809532.4749.87.camel@profitbricks.com>
From: Benjamin Drung <benjamin.drung@profitbricks.com>
Date: Fri, 16 Feb 2018 20:32:12 +0100
In-Reply-To: <a23480b8-c914-6274-52ec-29911cb4d2a5@amsat.org>
References: <ff0868d2-98c0-a0ee-8139-0367c29a03b1@redhat.com>
	<20180216175507.17052-1-benjamin.drung@profitbricks.com>
	<a23480b8-c914-6274-52ec-29911cb4d2a5@amsat.org>
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-gehc3r9DLW0C6ZlsBTFh"
Mime-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v2] slirp: Add domainname option to slirp's
 DHCP server
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Jan Kiszka <jan.kiszka@siemens.com>, Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org


--=-gehc3r9DLW0C6ZlsBTFh
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

Am Freitag, den 16.02.2018, 16:23 -0300 schrieb Philippe Mathieu-Daud=C3=A9=
:
> Hi Benjamin,
>=20
> On 02/16/2018 02:55 PM, Benjamin Drung wrote:
> > This patch will allow the user to include the domainname option in
> > replies from the built-in DHCP server.
> >=20
> > Signed-off-by: Benjamin Drung <benjamin.drung@profitbricks.com>
> > ---
> >  net/slirp.c      | 7 ++++---
> >  qapi/net.json    | 4 ++++
> >  qemu-options.hx  | 7 +++++--
> >  slirp/bootp.c    | 8 ++++++++
> >  slirp/libslirp.h | 2 +-
> >  slirp/slirp.c    | 4 +++-
> >  slirp/slirp.h    | 1 +
> >  7 files changed, 26 insertions(+), 7 deletions(-)
> >=20
> > diff --git a/net/slirp.c b/net/slirp.c
> > index 8991816bbf..9511ff3bb7 100644
> > --- a/net/slirp.c
> > +++ b/net/slirp.c
> > @@ -157,7 +157,8 @@ static int net_slirp_init(NetClientState *peer,
> > const char *model,
> >                            const char *bootfile, const char
> > *vdhcp_start,
> >                            const char *vnameserver, const char
> > *vnameserver6,
> >                            const char *smb_export, const char
> > *vsmbserver,
> > -                          const char **dnssearch, Error **errp)
> > +                          const char **dnssearch, const char
> > *vdomainname,
> > +                          Error **errp)
> >  {
> >      /* default settings according to historic slirp */
> >      struct in_addr net  =3D { .s_addr =3D htonl(0x0a000200) }; /*
> > 10.0.2.0 */
> > @@ -371,7 +372,7 @@ static int net_slirp_init(NetClientState *peer,
> > const char *model,
> >      s->slirp =3D slirp_init(restricted, ipv4, net, mask, host,
> >                            ipv6, ip6_prefix, vprefix6_len,
> > ip6_host,
> >                            vhostname, tftp_export, bootfile, dhcp,
> > -                          dns, ip6_dns, dnssearch, s);
> > +                          dns, ip6_dns, dnssearch, vdomainname,
> > s);
> >      QTAILQ_INSERT_TAIL(&slirp_stacks, s, entry);
> > =20
> >      for (config =3D slirp_configs; config; config =3D config->next) {
> > @@ -958,7 +959,7 @@ int net_init_slirp(const Netdev *netdev, const
> > char *name,
> >                           user->ipv6_host, user->hostname, user-
> > >tftp,
> >                           user->bootfile, user->dhcpstart,
> >                           user->dns, user->ipv6_dns, user->smb,
> > -                         user->smbserver, dnssearch, errp);
> > +                         user->smbserver, dnssearch, user-
> > >domainname, errp);
> > =20
> >      while (slirp_configs) {
> >          config =3D slirp_configs;
> > diff --git a/qapi/net.json b/qapi/net.json
> > index 1238ba5de1..9dfd34cafa 100644
> > --- a/qapi/net.json
> > +++ b/qapi/net.json
> > @@ -160,6 +160,9 @@
> >  # @dnssearch: list of DNS suffixes to search, passed as DHCP
> > option
> >  #             to the guest
> >  #
> > +# @domainname: guest-visible domain name of the virtual nameserver
> > +#              (since 2.12)
> > +#
> >  # @ipv6-prefix: IPv6 network prefix (default is fec0::) (since
> >  #               2.6). The network prefix is given in the usual
> >  #               hexadecimal IPv6 address notation.
> > @@ -197,6 +200,7 @@
> >      '*dhcpstart': 'str',
> >      '*dns':       'str',
> >      '*dnssearch': ['String'],
> > +    '*domainname': 'str',
> >      '*ipv6-prefix':      'str',
> >      '*ipv6-prefixlen':   'int',
> >      '*ipv6-host':        'str',
> > diff --git a/qemu-options.hx b/qemu-options.hx
> > index 5050a49a5e..06983db7be 100644
> > --- a/qemu-options.hx
> > +++ b/qemu-options.hx
> > @@ -1906,8 +1906,8 @@ DEF("netdev", HAS_ARG, QEMU_OPTION_netdev,
> >      "-netdev
> > user,id=3Dstr[,ipv4[=3Don|off]][,net=3Daddr[/mask]][,host=3Daddr]\n"
> >      "         [,ipv6[=3Don|off]][,ipv6-net=3Daddr[/int]][,ipv6-
> > host=3Daddr]\n"
> >      "         [,restrict=3Don|off][,hostname=3Dhost][,dhcpstart=3Daddr=
]\
> > n"
> > -    "         [,dns=3Daddr][,ipv6-
> > dns=3Daddr][,dnssearch=3Ddomain][,tftp=3Ddir]\n"
> > -    "         [,bootfile=3Df][,hostfwd=3Drule][,guestfwd=3Drule]"
> > +    "         [,dns=3Daddr][,ipv6-
> > dns=3Daddr][,dnssearch=3Ddomain][,domainname=3Ddomain]\n"
> > +    "         [,tftp=3Ddir][,bootfile=3Df][,hostfwd=3Drule][,guestfwd=
=3Dru
> > le]"
> >  #ifndef _WIN32
> >                                               "[,smb=3Ddir[,smbserver
> > =3Daddr]]\n"
> >  #endif
> > @@ -2116,6 +2116,9 @@ Example:
> >  qemu -net user,dnssearch=3Dmgmt.example.org,dnssearch=3Dexample.org
> > [...]
> >  @end example
> > =20
> > +@item domainname=3D@var{domain}
> > +Specifies the client domain name reported by the built-in DHCP
> > server.
> > +
> >  @item tftp=3D@var{dir}
> >  When using the user mode network stack, activate a built-in TFTP
> >  server. The files in @var{dir} will be exposed as the root of a
> > TFTP server.
> > diff --git a/slirp/bootp.c b/slirp/bootp.c
> > index 5dd1a415b5..91896f7400 100644
> > --- a/slirp/bootp.c
> > +++ b/slirp/bootp.c
> > @@ -298,6 +298,14 @@ static void bootp_reply(Slirp *slirp, const
> > struct bootp_t *bp)
> >              q +=3D val;
> >          }
> > =20
> > +        if (*slirp->vdomainname) {
>=20
> This is safe but harder to read/review...

I borrowed that logic from client_hostname.

> > +            val =3D strlen(slirp->vdomainname);
> > +            *q++ =3D RFC1533_DOMAINNAME;
> > +            *q++ =3D val;
> > +            memcpy(q, slirp->vdomainname, val);
> > +            q +=3D val;
> > +        }
> > +
> >          if (slirp->vdnssearch) {
> >              size_t spaceleft =3D sizeof(rbp->bp_vend) - (q - rbp-
> > >bp_vend);
> >              val =3D slirp->vdnssearch_len;
> > diff --git a/slirp/libslirp.h b/slirp/libslirp.h
> > index 540b3e5903..740408a96e 100644
> > --- a/slirp/libslirp.h
> > +++ b/slirp/libslirp.h
> > @@ -16,7 +16,7 @@ Slirp *slirp_init(int restricted, bool
> > in_enabled, struct in_addr vnetwork,
> >                    const char *tftp_path, const char *bootfile,
> >                    struct in_addr vdhcp_start, struct in_addr
> > vnameserver,
> >                    struct in6_addr vnameserver6, const char
> > **vdnssearch,
> > -                  void *opaque);
> > +                  const char *vdomainname, void *opaque);
> >  void slirp_cleanup(Slirp *slirp);
> > =20
> >  void slirp_pollfds_fill(GArray *pollfds, uint32_t *timeout);
> > diff --git a/slirp/slirp.c b/slirp/slirp.c
> > index 1cb6b07004..4f29753444 100644
> > --- a/slirp/slirp.c
> > +++ b/slirp/slirp.c
> > @@ -286,7 +286,7 @@ Slirp *slirp_init(int restricted, bool
> > in_enabled, struct in_addr vnetwork,
> >                    const char *tftp_path, const char *bootfile,
> >                    struct in_addr vdhcp_start, struct in_addr
> > vnameserver,
> >                    struct in6_addr vnameserver6, const char
> > **vdnssearch,
> > -                  void *opaque)
> > +                  const char *vdomainname, void *opaque)
> >  {
> >      Slirp *slirp =3D g_malloc0(sizeof(Slirp));
> > =20
> > @@ -317,6 +317,7 @@ Slirp *slirp_init(int restricted, bool
> > in_enabled, struct in_addr vnetwork,
> >      }
> >      slirp->tftp_prefix =3D g_strdup(tftp_path);
> >      slirp->bootp_filename =3D g_strdup(bootfile);
>=20
> I'd use this check:
>=20
>    if (vdomainname) {
>        if (!*vdomainname) {
>            error_report("'domainname' parameter cannot be empty");
>            exit(EXIT_FAILURE);
>        }

Do we want to bail out if domainname is set to empty instead of just
ignoring an empty domainname?

> > +    slirp->vdomainname =3D g_strdup(vdomainname);
>=20
>    }
>=20
> and simply check "if (slirp->vdomainname) { ..." in bootp_reply().
>=20
> Regards,
>=20
> Phil.
>=20
> >      slirp->vdhcp_startaddr =3D vdhcp_start;
> >      slirp->vnameserver_addr =3D vnameserver;
> >      slirp->vnameserver_addr6 =3D vnameserver6;
> > @@ -349,6 +350,7 @@ void slirp_cleanup(Slirp *slirp)
> >      g_free(slirp->vdnssearch);
> >      g_free(slirp->tftp_prefix);
> >      g_free(slirp->bootp_filename);
> > +    g_free(slirp->vdomainname);
> >      g_free(slirp);
> >  }
> > =20
> > diff --git a/slirp/slirp.h b/slirp/slirp.h
> > index 06febfc78b..10b410898a 100644
> > --- a/slirp/slirp.h
> > +++ b/slirp/slirp.h
> > @@ -193,6 +193,7 @@ struct Slirp {
> >      char *bootp_filename;
> >      size_t vdnssearch_len;
> >      uint8_t *vdnssearch;
> > +    char *vdomainname;
> > =20
> >      /* tcp states */
> >      struct socket tcb;
> >=20
>=20
>=20
--=20
Benjamin Drung
System Developer
Debian & Ubuntu Developer

ProfitBricks GmbH
Greifswalder Str. 207
D - 10405 Berlin

Email: benjamin.drung@profitbricks.com
URL: https://www.profitbricks.de

Sitz der Gesellschaft: Berlin
Registergericht: Amtsgericht Charlottenburg, HRB 125506 B
Gesch=C3=A4ftsf=C3=BChrer: Achim Weiss, Matthias Steinberg
--=-gehc3r9DLW0C6ZlsBTFh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCAAGBQJahzG8AAoJEN2M1aXejH56BwIP/2+sc8aBvF/JlOnn3zJO9SAC
DwMy2kg2nWzgTo+GP56CdLvG+Z2ElRTCbuzPCyfdwBWIrEbEe5zBWyWauU/OyW31
Vjx/cvcc8MsesFaS5aH2seY6gdei1uYe4fu33dyK2tY/NGETz5F1cHiLD7wVCKuz
4B1dl4JKtFHKhLeQSSBH58o/xj09TPzPlT+HrahMB9nRynKLKKGvUFsZn2uOUAhr
6zfPm6fv8Oh2KiPMLo8vQhpc4MXaChUMJjkQgWEeMB/LSaa06bjI9l0dcYETRR5L
iv5MGTTFflI2z8KAEh1N9ZiXsQpv2ZSd4CcevPeEFdSnOl/R4euUeaAvdykuKAJP
/1fsmzP/nPfC72Gy8pLwWIDJp00ekofqR3Ms7CR8z5h6A/JnSEXxVvHYUofsccpD
14FzxAQlos9aJb5XIgiDHBWzxQilU2lyQYxmII3Jhp462Um8+rnl3Cz55ZVqhOKU
Md4OB+/ntIXAO826Ot3RBZ73gILU4kUr1OIYX/0IbEUYq8aMEVpSp7hBnyDaV/c2
0OnQx2oZhQSEhhIiX7kU9DVRa2HQSWVYy1slCCzQMF/5E9FViNS2mCjdgn1jV+wQ
jMUVNlRSwpOJguX+l/0wnpnp5yz0TyFxSZ4BpudbthsMKTqiGfmHXoLkhuBQYyL0
T6guWHOmC7H2lyP+42cb
=BzPY
-----END PGP SIGNATURE-----

--=-gehc3r9DLW0C6ZlsBTFh--
