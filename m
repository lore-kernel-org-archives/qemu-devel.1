Received: from eggs.gnu.org ([2001:4830:134:3::10]:53098)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1esaU2-0001jh-E2
	for qemu-devel@nongnu.org; Sun, 04 Mar 2018 15:43:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1esaTz-00050Y-90
	for qemu-devel@nongnu.org; Sun, 04 Mar 2018 15:43:50 -0500
Received: from hera.aquilenet.fr ([2a0c:e300::1]:40412)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1esaTy-0004yS-SZ
	for qemu-devel@nongnu.org; Sun, 04 Mar 2018 15:43:47 -0500
Date: Sun, 4 Mar 2018 21:43:41 +0100
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20180304204341.awomx7fs6hpmtomt@var.youpi.perso.aquilenet.fr>
References: <a23480b8-c914-6274-52ec-29911cb4d2a5@amsat.org>
	<20180227160602.30220-1-benjamin.drung@profitbricks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180227160602.30220-1-benjamin.drung@profitbricks.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/2 v4] slirp: Add domainname option to
 slirp's DHCP server
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Benjamin Drung <benjamin.drung@profitbricks.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Jan Kiszka <jan.kiszka@siemens.com>, Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org

Benjamin Drung, on mar. 27 f=C3=A9vr. 2018 17:06:01 +0100, wrote:
> This patch will allow the user to include the domainname option in
> replies from the built-in DHCP server.
>=20
> Signed-off-by: Benjamin Drung <benjamin.drung@profitbricks.com>

Reviewed-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

and applied to my tree.

Samuel

> ---
>  net/slirp.c      | 12 +++++++++---
>  qapi/net.json    |  4 ++++
>  qemu-options.hx  |  7 +++++--
>  slirp/bootp.c    |  8 ++++++++
>  slirp/libslirp.h |  2 +-
>  slirp/slirp.c    |  4 +++-
>  slirp/slirp.h    |  1 +
>  7 files changed, 31 insertions(+), 7 deletions(-)
>=20
> diff --git a/net/slirp.c b/net/slirp.c
> index 8991816bbf..8c08e5644f 100644
> --- a/net/slirp.c
> +++ b/net/slirp.c
> @@ -157,7 +157,8 @@ static int net_slirp_init(NetClientState *peer, con=
st char *model,
>                            const char *bootfile, const char *vdhcp_star=
t,
>                            const char *vnameserver, const char *vnamese=
rver6,
>                            const char *smb_export, const char *vsmbserv=
er,
> -                          const char **dnssearch, Error **errp)
> +                          const char **dnssearch, const char *vdomainn=
ame,
> +                          Error **errp)
>  {
>      /* default settings according to historic slirp */
>      struct in_addr net  =3D { .s_addr =3D htonl(0x0a000200) }; /* 10.0=
.2.0 */
> @@ -359,6 +360,11 @@ static int net_slirp_init(NetClientState *peer, co=
nst char *model,
>          ip6_dns.s6_addr[15] |=3D 3;
>      }
> =20
> +    if (vdomainname && !*vdomainname) {
> +        error_setg(errp, "'domainname' parameter cannot be empty");
> +        return -1;
> +    }
> +
> =20
>      nc =3D qemu_new_net_client(&net_slirp_info, peer, model, name);
> =20
> @@ -371,7 +377,7 @@ static int net_slirp_init(NetClientState *peer, con=
st char *model,
>      s->slirp =3D slirp_init(restricted, ipv4, net, mask, host,
>                            ipv6, ip6_prefix, vprefix6_len, ip6_host,
>                            vhostname, tftp_export, bootfile, dhcp,
> -                          dns, ip6_dns, dnssearch, s);
> +                          dns, ip6_dns, dnssearch, vdomainname, s);
>      QTAILQ_INSERT_TAIL(&slirp_stacks, s, entry);
> =20
>      for (config =3D slirp_configs; config; config =3D config->next) {
> @@ -958,7 +964,7 @@ int net_init_slirp(const Netdev *netdev, const char=
 *name,
>                           user->ipv6_host, user->hostname, user->tftp,
>                           user->bootfile, user->dhcpstart,
>                           user->dns, user->ipv6_dns, user->smb,
> -                         user->smbserver, dnssearch, errp);
> +                         user->smbserver, dnssearch, user->domainname,=
 errp);
> =20
>      while (slirp_configs) {
>          config =3D slirp_configs;
> diff --git a/qapi/net.json b/qapi/net.json
> index 1238ba5de1..9dfd34cafa 100644
> --- a/qapi/net.json
> +++ b/qapi/net.json
> @@ -160,6 +160,9 @@
>  # @dnssearch: list of DNS suffixes to search, passed as DHCP option
>  #             to the guest
>  #
> +# @domainname: guest-visible domain name of the virtual nameserver
> +#              (since 2.12)
> +#
>  # @ipv6-prefix: IPv6 network prefix (default is fec0::) (since
>  #               2.6). The network prefix is given in the usual
>  #               hexadecimal IPv6 address notation.
> @@ -197,6 +200,7 @@
>      '*dhcpstart': 'str',
>      '*dns':       'str',
>      '*dnssearch': ['String'],
> +    '*domainname': 'str',
>      '*ipv6-prefix':      'str',
>      '*ipv6-prefixlen':   'int',
>      '*ipv6-host':        'str',
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 8ccd5dcaa6..c000ef454e 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -1906,8 +1906,8 @@ DEF("netdev", HAS_ARG, QEMU_OPTION_netdev,
>      "-netdev user,id=3Dstr[,ipv4[=3Don|off]][,net=3Daddr[/mask]][,host=
=3Daddr]\n"
>      "         [,ipv6[=3Don|off]][,ipv6-net=3Daddr[/int]][,ipv6-host=3D=
addr]\n"
>      "         [,restrict=3Don|off][,hostname=3Dhost][,dhcpstart=3Daddr=
]\n"
> -    "         [,dns=3Daddr][,ipv6-dns=3Daddr][,dnssearch=3Ddomain][,tf=
tp=3Ddir]\n"
> -    "         [,bootfile=3Df][,hostfwd=3Drule][,guestfwd=3Drule]"
> +    "         [,dns=3Daddr][,ipv6-dns=3Daddr][,dnssearch=3Ddomain][,do=
mainname=3Ddomain]\n"
> +    "         [,tftp=3Ddir][,bootfile=3Df][,hostfwd=3Drule][,guestfwd=3D=
rule]"
>  #ifndef _WIN32
>                                               "[,smb=3Ddir[,smbserver=3D=
addr]]\n"
>  #endif
> @@ -2116,6 +2116,9 @@ Example:
>  qemu -net user,dnssearch=3Dmgmt.example.org,dnssearch=3Dexample.org [.=
..]
>  @end example
> =20
> +@item domainname=3D@var{domain}
> +Specifies the client domain name reported by the built-in DHCP server.
> +
>  @item tftp=3D@var{dir}
>  When using the user mode network stack, activate a built-in TFTP
>  server. The files in @var{dir} will be exposed as the root of a TFTP s=
erver.
> diff --git a/slirp/bootp.c b/slirp/bootp.c
> index 5dd1a415b5..9e7b53ba94 100644
> --- a/slirp/bootp.c
> +++ b/slirp/bootp.c
> @@ -298,6 +298,14 @@ static void bootp_reply(Slirp *slirp, const struct=
 bootp_t *bp)
>              q +=3D val;
>          }
> =20
> +        if (slirp->vdomainname) {
> +            val =3D strlen(slirp->vdomainname);
> +            *q++ =3D RFC1533_DOMAINNAME;
> +            *q++ =3D val;
> +            memcpy(q, slirp->vdomainname, val);
> +            q +=3D val;
> +        }
> +
>          if (slirp->vdnssearch) {
>              size_t spaceleft =3D sizeof(rbp->bp_vend) - (q - rbp->bp_v=
end);
>              val =3D slirp->vdnssearch_len;
> diff --git a/slirp/libslirp.h b/slirp/libslirp.h
> index 540b3e5903..740408a96e 100644
> --- a/slirp/libslirp.h
> +++ b/slirp/libslirp.h
> @@ -16,7 +16,7 @@ Slirp *slirp_init(int restricted, bool in_enabled, st=
ruct in_addr vnetwork,
>                    const char *tftp_path, const char *bootfile,
>                    struct in_addr vdhcp_start, struct in_addr vnameserv=
er,
>                    struct in6_addr vnameserver6, const char **vdnssearc=
h,
> -                  void *opaque);
> +                  const char *vdomainname, void *opaque);
>  void slirp_cleanup(Slirp *slirp);
> =20
>  void slirp_pollfds_fill(GArray *pollfds, uint32_t *timeout);
> diff --git a/slirp/slirp.c b/slirp/slirp.c
> index 1cb6b07004..4f29753444 100644
> --- a/slirp/slirp.c
> +++ b/slirp/slirp.c
> @@ -286,7 +286,7 @@ Slirp *slirp_init(int restricted, bool in_enabled, =
struct in_addr vnetwork,
>                    const char *tftp_path, const char *bootfile,
>                    struct in_addr vdhcp_start, struct in_addr vnameserv=
er,
>                    struct in6_addr vnameserver6, const char **vdnssearc=
h,
> -                  void *opaque)
> +                  const char *vdomainname, void *opaque)
>  {
>      Slirp *slirp =3D g_malloc0(sizeof(Slirp));
> =20
> @@ -317,6 +317,7 @@ Slirp *slirp_init(int restricted, bool in_enabled, =
struct in_addr vnetwork,
>      }
>      slirp->tftp_prefix =3D g_strdup(tftp_path);
>      slirp->bootp_filename =3D g_strdup(bootfile);
> +    slirp->vdomainname =3D g_strdup(vdomainname);
>      slirp->vdhcp_startaddr =3D vdhcp_start;
>      slirp->vnameserver_addr =3D vnameserver;
>      slirp->vnameserver_addr6 =3D vnameserver6;
> @@ -349,6 +350,7 @@ void slirp_cleanup(Slirp *slirp)
>      g_free(slirp->vdnssearch);
>      g_free(slirp->tftp_prefix);
>      g_free(slirp->bootp_filename);
> +    g_free(slirp->vdomainname);
>      g_free(slirp);
>  }
> =20
> diff --git a/slirp/slirp.h b/slirp/slirp.h
> index 06febfc78b..10b410898a 100644
> --- a/slirp/slirp.h
> +++ b/slirp/slirp.h
> @@ -193,6 +193,7 @@ struct Slirp {
>      char *bootp_filename;
>      size_t vdnssearch_len;
>      uint8_t *vdnssearch;
> +    char *vdomainname;
> =20
>      /* tcp states */
>      struct socket tcb;
> --=20
> 2.14.1
>=20

--=20
Samuel
<b> il faut combien de chevaux pour tirer une dolor=C3=A9an =C3=A0 88 mor=
ph ?
***b vient de remarque que 88 mph c'est 142 km/h
<y> aaaaah
<y> c'est pour =C3=A7a qu'ils limitent =C3=A0 130 km/h sur les autoroutes
<y> c'est pour =C3=A9viter que les gens voyagent dans le temps
<b> probablement
