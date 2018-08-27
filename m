Received: from eggs.gnu.org ([2001:4830:134:3::10]:39896)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fuDxg-0003AA-3K
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 05:37:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fuDxb-0001VA-0E
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 05:37:28 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58950 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fuDxa-0001Us-QY
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 05:37:22 -0400
References: <20180827083645.12548-1-famz@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <0279277b-08b9-a743-6cfe-7b04d5565e41@redhat.com>
Date: Mon, 27 Aug 2018 11:37:16 +0200
MIME-Version: 1.0
In-Reply-To: <20180827083645.12548-1-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3] slirp: Implement RFC2132 TFTP server
 name
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, berrange@redhat.com, Jason Wang <jasowang@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>, brad@comstyle.com, Prasad J Pandit <pjp@fedoraproject.org>

On 2018-08-27 10:36, Fam Zheng wrote:
> This new usernet option can be used to add data for option 66 (tftp
> server name) in the BOOTP reply, which is useful in PXE based automatic
> OS install such as OpenBSD.
>=20
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>=20
> v3: Add doc to qemu-options.hx. [Thomas]
>=20
> v2: - Adjust parameter order and field placement to be closer to other
> tftp options. [Samuel]
>     - Drop 'optional'. [Eric]
> ---
>  net/slirp.c      | 5 ++++-
>  qapi/net.json    | 5 ++++-
>  qemu-options.hx  | 7 ++++++-
>  slirp/bootp.c    | 8 ++++++++
>  slirp/bootp.h    | 1 +
>  slirp/libslirp.h | 4 +++-
>  slirp/slirp.c    | 5 ++++-
>  slirp/slirp.h    | 1 +
>  8 files changed, 31 insertions(+), 5 deletions(-)
[...]
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 5515dfaba5..6ddabd9b81 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -1885,7 +1885,7 @@ DEF("netdev", HAS_ARG, QEMU_OPTION_netdev,
>      "         [,ipv6[=3Don|off]][,ipv6-net=3Daddr[/int]][,ipv6-host=3D=
addr]\n"
>      "         [,restrict=3Don|off][,hostname=3Dhost][,dhcpstart=3Daddr=
]\n"
>      "         [,dns=3Daddr][,ipv6-dns=3Daddr][,dnssearch=3Ddomain][,do=
mainname=3Ddomain]\n"
> -    "         [,tftp=3Ddir][,bootfile=3Df][,hostfwd=3Drule][,guestfwd=3D=
rule]"
> +    "         [,tftp=3Ddir][,tftp-server-name][,bootfile=3Df][,hostfwd=
=3Drule][,guestfwd=3Drule]"

Please use [,tftp-server-name=3Dname] or [,tftp-server-name=3Dn] or
something similar.

>  #ifndef _WIN32
>                                               "[,smb=3Ddir[,smbserver=3D=
addr]]\n"
>  #endif
> @@ -2122,6 +2122,11 @@ server. The files in @var{dir} will be exposed a=
s the root of a TFTP server.
>  The TFTP client on the guest must be configured in binary mode (use th=
e command
>  @code{bin} of the Unix TFTP client).
> =20
> +@item tftp-server-name=3D@var{name}
> +In BOOTP reply, broadcast @var{name} as the "TFTP server name" (RFC213=
2 option
> +66). This can be used to advise the guest to load boot files or config=
urations
> +from a different server than the host address.
> +
>  @item bootfile=3D@var{file}
>  When using the user mode network stack, broadcast @var{file} as the BO=
OTP
>  filename. In conjunction with @option{tftp}, this can be used to netwo=
rk boot
> diff --git a/slirp/bootp.c b/slirp/bootp.c
> index 9e7b53ba94..ed2cf3b96e 100644
> --- a/slirp/bootp.c
> +++ b/slirp/bootp.c
> @@ -306,6 +306,14 @@ static void bootp_reply(Slirp *slirp, const struct=
 bootp_t *bp)
>              q +=3D val;
>          }
> =20
> +        if (slirp->tftp_server_name) {
> +            val =3D strlen(slirp->tftp_server_name);

I think we should check somewhere that val < 256, otherwise you could
confuse the guest and maybe also crash QEMU by specifying a string that
is too big.

Same applies for the hostname and domainname parameter, though, so the
problem is already pre-existing, e.g.:

$ qemu-system-x86_64 -nic user,hostname=3D`for ((x=3D0;x<6000;x++)); do \
    echo -n y ; done`,domainname=3D`for ((x=3D0;x<6000;x++)); do \
    echo -n z ; done`
*** Error in `qemu-system-x86_64': malloc(): memory corruption:
0x00007f6c101a50e0 ***

There already seems to be a sanity check in net_slirp_init() that the
domainname is not empty, so I guess that would be a good place to check
that the hostname, domainname and tftp_server_name lengths are smaller
than 256? Anyway, could also be a patch on top, but we really should not
forget about this.

> +            *q++ =3D RFC2132_TFTP_SERVER_NAME;
> +            *q++ =3D val;
> +            memcpy(q, slirp->tftp_server_name, val);
> +            q +=3D val;
> +        }
> +
>          if (slirp->vdnssearch) {
>              size_t spaceleft =3D sizeof(rbp->bp_vend) - (q - rbp->bp_v=
end);
>              val =3D slirp->vdnssearch_len;
> diff --git a/slirp/bootp.h b/slirp/bootp.h
> index 394525733e..4043489835 100644
> --- a/slirp/bootp.h
> +++ b/slirp/bootp.h
> @@ -70,6 +70,7 @@
>  #define RFC2132_MAX_SIZE	57
>  #define RFC2132_RENEWAL_TIME    58
>  #define RFC2132_REBIND_TIME     59
> +#define RFC2132_TFTP_SERVER_NAME 66
> =20
>  #define DHCPDISCOVER		1
>  #define DHCPOFFER		2
> diff --git a/slirp/libslirp.h b/slirp/libslirp.h
> index 740408a96e..0e84ab9b52 100644
> --- a/slirp/libslirp.h
> +++ b/slirp/libslirp.h
> @@ -13,10 +13,12 @@ Slirp *slirp_init(int restricted, bool in_enabled, =
struct in_addr vnetwork,
>                    bool in6_enabled,
>                    struct in6_addr vprefix_addr6, uint8_t vprefix_len,
>                    struct in6_addr vhost6, const char *vhostname,
> +                  const char *tftp_server_name,
>                    const char *tftp_path, const char *bootfile,
>                    struct in_addr vdhcp_start, struct in_addr vnameserv=
er,
>                    struct in6_addr vnameserver6, const char **vdnssearc=
h,
> -                  const char *vdomainname, void *opaque);
> +                  const char *vdomainname,
> +                  void *opaque);

No need to move opaque to a separate line here?

>  void slirp_cleanup(Slirp *slirp);
> =20
>  void slirp_pollfds_fill(GArray *pollfds, uint32_t *timeout);
> diff --git a/slirp/slirp.c b/slirp/slirp.c
> index 5c3bd6163f..4073b0174f 100644
> --- a/slirp/slirp.c
> +++ b/slirp/slirp.c
> @@ -283,10 +283,12 @@ Slirp *slirp_init(int restricted, bool in_enabled=
, struct in_addr vnetwork,
>                    bool in6_enabled,
>                    struct in6_addr vprefix_addr6, uint8_t vprefix_len,
>                    struct in6_addr vhost6, const char *vhostname,
> +                  const char *tftp_server_name,
>                    const char *tftp_path, const char *bootfile,
>                    struct in_addr vdhcp_start, struct in_addr vnameserv=
er,
>                    struct in6_addr vnameserver6, const char **vdnssearc=
h,
> -                  const char *vdomainname, void *opaque)
> +                  const char *vdomainname,
> +                  void *opaque)

dito

>  {
>      Slirp *slirp =3D g_malloc0(sizeof(Slirp));
> =20
> @@ -321,6 +323,7 @@ Slirp *slirp_init(int restricted, bool in_enabled, =
struct in_addr vnetwork,
>      slirp->vdhcp_startaddr =3D vdhcp_start;
>      slirp->vnameserver_addr =3D vnameserver;
>      slirp->vnameserver_addr6 =3D vnameserver6;
> +    slirp->tftp_server_name =3D g_strdup(tftp_server_name);
> =20
>      if (vdnssearch) {
>          translate_dnssearch(slirp, vdnssearch);
> diff --git a/slirp/slirp.h b/slirp/slirp.h
> index 10b410898a..b80725a0d6 100644
> --- a/slirp/slirp.h
> +++ b/slirp/slirp.h
> @@ -212,6 +212,7 @@ struct Slirp {
>      /* tftp states */
>      char *tftp_prefix;
>      struct tftp_session tftp_sessions[TFTP_SESSIONS_MAX];
> +    char *tftp_server_name;
> =20
>      ArpTable arp_table;
>      NdpTable ndp_table;
>=20

 Thomas
