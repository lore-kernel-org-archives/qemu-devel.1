Received: from eggs.gnu.org ([2001:4830:134:3::10]:55724)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1esapl-0007sH-5g
	for qemu-devel@nongnu.org; Sun, 04 Mar 2018 16:06:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1esapg-0008Fx-8C
	for qemu-devel@nongnu.org; Sun, 04 Mar 2018 16:06:17 -0500
Received: from hera.aquilenet.fr ([185.233.100.1]:55760)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1esapg-0008DU-0y
	for qemu-devel@nongnu.org; Sun, 04 Mar 2018 16:06:12 -0500
Date: Sun, 4 Mar 2018 22:06:08 +0100
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20180304210608.vn33p6pn7t2nsxv4@var.youpi.perso.aquilenet.fr>
References: <a23480b8-c914-6274-52ec-29911cb4d2a5@amsat.org>
	<20180227160602.30220-1-benjamin.drung@profitbricks.com>
	<20180227160602.30220-2-benjamin.drung@profitbricks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180227160602.30220-2-benjamin.drung@profitbricks.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/2] slirp: Add classless static routes
 support to DHCP server
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

Benjamin Drung, on mar. 27 f=C3=A9vr. 2018 17:06:02 +0100, wrote:
> +    int i =3D 0;

Rather unsigned?
>      char *end;
> +    unsigned int route_count =3D 0;
>      struct slirp_config_str *config;
> +    struct StaticRoute *routes =3D NULL;
> +    const StringList *iter;
> =20
>      if (!ipv4 && (vnetwork || vhost || vnameserver)) {
>          error_setg(errp, "IPv4 disabled but netmask/host/dns provided"=
);
> @@ -365,6 +369,58 @@ static int net_slirp_init(NetClientState *peer, co=
nst char *model,
>          return -1;
>      }
> =20
> +    iter =3D vroutes;

Rather initialize route_count to 0 here.
> +    while (iter) {
> +        route_count++;
> +        iter =3D iter->next;
> +    }



> +    iter =3D vroutes;

Rather initialize i to 0 here.

> +    while(iter !=3D NULL) {

> +        // Split "subnet/mask:gateway" into its components
> +        if (get_str_sep(buf2, sizeof(buf2), &gateway, ':') < 0) {
[etc.]

You should make the gateway host.s_addr by default, so the gateway or
even :gateway part can be optional.

> -    "         [,tftp=3Ddir][,bootfile=3Df][,hostfwd=3Drule][,guestfwd=3D=
rule]"
> +    "         [,route=3Daddr/mask:gateway][,tftp=3Ddir][,bootfile=3Df]=
[,hostfwd=3Drule][,guestfwd=3Drule]"

And document optionality in the help, of course.

> +        if (slirp->route_count > 0) {
> +            uint8_t option_length =3D 0;
> +            uint8_t significant_octets;
> +
> +            for (int i =3D 0; i < slirp->route_count; i++) {
> +                significant_octets =3D slirp->routes[i].mask_width / 8
> +                                     + (slirp->routes[i].mask_width % =
8 > 0);

Rather use (slirp->routes[i].mask_width + 7) / 8 (and ditto below)

> +                option_length +=3D significant_octets + 5;
> +            }
> +
> +            *q++ =3D RFC3442_CLASSLESS_STATIC_ROUTE;

I'd say instead of computing the option_length twice, create a variable
uint8_t *size which you make point at the size byte here, and you can
fill it after the loop.

Apart from that it looks good.

Samuel
