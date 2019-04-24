Received: from eggs.gnu.org ([209.51.188.92]:33917)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1hJILr-0008Qs-9z
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 09:54:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1hJIKY-0006Oh-3n
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 09:52:59 -0400
Received: from mail-eopbgr700136.outbound.protection.outlook.com
	([40.107.70.136]:35553
	helo=NAM04-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1hJIKX-0006NA-R4
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 09:52:58 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Wed, 24 Apr 2019 13:52:53 +0000
Message-ID: <BN6PR2201MB125182A9057BB508EDD06DFDC63C0@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <1556110623-655-1-git-send-email-aleksandar.markovic@rt-rk.com>,
	<1556110623-655-5-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1556110623-655-5-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v2 4/5] linux-user: setsockopt(): Add
 support for the option IPV6_ADD_MEMBERSHIP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "aurelien@aurel32.net" <aurelien@aurel32.net>, Aleksandar Rikalo <arikalo@wavecomp.com>, "daniel.santos@pobox.com" <daniel.santos@pobox.com>, "jcmvbkbc@gmail.com" <jcmvbkbc@gmail.com>, "lvivier@redhat.com" <lvivier@redhat.com>, "thuth@redhat.com" <thuth@redhat.com>, "philmd@redhat.com" <philmd@redhat.com>, Neng Chen <nchen@wavecomp.com>

>=20
> ________________________________________
> From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
> Sent: Wednesday, April 24, 2019 2:57 PM
> To: qemu-devel@nongnu.org
> Cc: aurelien@aurel32.net; Aleksandar Markovic; Aleksandar Rikalo; daniel.=
santos@pobox.com; jcmvbkbc@gmail.com; lvivier@redhat.com; thuth@redhat.com;=
 philmd@redhat.com; Neng Chen
> Subject: [PATCH v2 4/5] linux-user: setsockopt(): Add support for the opt=
ion IPV6_ADD_MEMBERSHIP
>=20


Hello, Loraine,


I am just a submitter for this patch (the author is my colegue
Neng Chen), and I see that this patch really fills in some missing
functionality in linux-user, however I would like to ask you for
your opinion on the following:

1) Should the field ipv6mr_multiaddr also be subject to some
big/little endian conversion, or the current solution is sufficient?

2) Should we complete setsockopt() functionality with other remaining
not implemented options at this moment, while we are already on
implementing IPV6_ADD_MEMBERSHIP support?

Thanks,
Aleksandar


> From: Neng Chen <nchen@wavecomp.com>
>=20
> Add support for the option IPV6_ADD_MEMBERSHIP of the syscall
> setsockopt(). This option controls membership in multicast groups.
> Argument is a pointer to a struct ipv6_mreq, which is in turn defined
> in a platform-inedependant manner in the Linux kernel file
> include/uapi/linux/in6.h as:
>=20
> The <netinet/in.h> header defines the ipv6_mreq structure, which
> includes the following members:
>=20
> struct in6_addr ipv6mr_multiaddr  /* IPv6 multicast address   */
> unsigned int    ipv6mr_interface  /* local interface index    */
>=20
> struct ipv6_mreq {
>     /* IPv6 multicast address of group */
>     struct in6_addr  ipv6mr_multiaddr;
>=20
>     /* local IPv6 address of interface */
>     int              ipv6mr_ifindex;
> };
>=20
> The <netinet/in.h> header also defines the in6_addr structure,
> which a union of the following structure:
>=20
> struct in6_addr {
>     union {
>         __u8    u6_addr8[16];
>         __be16  u6_addr16[8];
>         __be32  u6_addr32[4];
>     } in6_u;
>=20
> The emulation behavior of IPV6_ADD_MEMBERSHIP is devised based on
> the definitions above.
>=20
> Signed-off-by: Neng Chen <nchen@wavecomp.com>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> ---
>  linux-user/syscall.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>=20
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 96cd4bf..b47a45d 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -1892,6 +1892,24 @@ static abi_long do_setsockopt(int sockfd, int leve=
l, int optname,
>                                         &pki, sizeof(pki)));
>              break;
>          }
> +        case IPV6_ADD_MEMBERSHIP:
> +        {
> +            struct ipv6_mreq ipv6mreq;
> +
> +            if (optlen < sizeof(ipv6mreq)) {
> +                return -TARGET_EINVAL;
> +            }
> +
> +            if (copy_from_user(&ipv6mreq, optval_addr, sizeof(ipv6mreq))=
) {
> +                return -TARGET_EFAULT;
> +            }
> +
> +            ipv6mreq.ipv6mr_interface =3D tswap32(ipv6mreq.ipv6mr_interf=
ace);
> +
> +            ret =3D get_errno(setsockopt(sockfd, level, optname,
> +                                       &ipv6mreq, sizeof(ipv6mreq)));
> +            break;
> +        }
>          default:
>              goto unimplemented;
>          }
> --
> 2.7.4
>=20
> =
