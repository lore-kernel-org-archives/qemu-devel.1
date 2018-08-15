Received: from eggs.gnu.org ([2001:4830:134:3::10]:34562)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1fptab-0000jE-Ax
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 07:03:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1fptaa-0005WF-0f
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 07:03:44 -0400
Received: from hera.aquilenet.fr ([2a0c:e300::1]:57994)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1fptaZ-0005RT-IB
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 07:03:43 -0400
Date: Wed, 15 Aug 2018 13:03:39 +0200
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20180815110339.5str3fmmyrnvkjqo@var.youpi.perso.aquilenet.fr>
References: <20180815023521.185705-1-aoates@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180815023521.185705-1-aoates@google.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3] slirp: fix ICMP handling on macOS hosts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Oates <aoates@google.com>
Cc: peter.maydell@linaro.org, jan.kiszka@siemens.com, qemu-devel@nongnu.org

Andrew Oates, le mar. 14 ao=C3=BBt 2018 22:35:21 -0400, a ecrit:
> On Linux, SOCK_DGRAM+IPPROTO_ICMP sockets give only the ICMP packet whe=
n
> read from.  On macOS, however, the socket acts like a SOCK_RAW socket
> and includes the IP header as well.
>=20
> This change strips the extra IP header from the received packet on macO=
S
> before sending it to the guest.  SOCK_DGRAM ICMP sockets aren't
> supported on other BSDs, but we enable this behavior for them as well t=
o
> treat the sockets the same as raw sockets.
>=20
> Signed-off-by: Andrew Oates <aoates@google.com>
> ---
> v2: check validity of inner_hlen and update len appropriately
> v3: CONFIG_DARWIN -> CONFIG_BSD; add comment explaining #ifdef
>=20
>  slirp/ip_icmp.c | 24 +++++++++++++++++++++++-
>  1 file changed, 23 insertions(+), 1 deletion(-)
>=20
> diff --git a/slirp/ip_icmp.c b/slirp/ip_icmp.c
> index 0b667a429a..0e289fd9d9 100644
> --- a/slirp/ip_icmp.c
> +++ b/slirp/ip_icmp.c
> @@ -420,7 +420,29 @@ void icmp_receive(struct socket *so)
>      icp =3D mtod(m, struct icmp *);
> =20
>      id =3D icp->icmp_id;
> -    len =3D qemu_recv(so->s, icp, m->m_len, 0);
> +    len =3D qemu_recv(so->s, icp, M_ROOM(m), 0);
> +    /*
> +     * The behavior of reading SOCK_DGRAM+IPPROTO_ICMP sockets is inco=
nsistent
> +     * between host OSes.  On Linux, only the ICMP header and payload =
is
> +     * included.  On macOS/Darwin, the socket acts like a raw socket a=
nd
> +     * includes the IP header as well.  On other BSDs, SOCK_DGRAM+IPPR=
OTO_ICMP
> +     * sockets aren't supported at all, so we treat them like raw sock=
ets.  It
> +     * isn't possible to detect this difference at runtime, so we must=
 use an
> +     * #ifdef to determine if we need to remove the IP header.
> +     */
> +#ifdef CONFIG_BSD
> +    if (len > 0) {

Looking at it again, this used to be=20

  if (len >=3D sizeof(struct ip)) {

shouldn't be it that way so that

> +        struct ip *inner_ip =3D mtod(m, struct ip *);
> +        int inner_hlen =3D inner_ip->ip_hl << 2;

Reading in the header doesn't give uninitialized values?

I guess that to be on the safe side and trigger explicit warnings, we
should reject with EINVAL packets which are smaller than an IP header?

> +        if (inner_hlen > len) {
> +            len =3D -1;
> +            errno =3D -EINVAL;
> +        } else {
> +            len -=3D inner_hlen;
> +            memmove(icp, (unsigned char *)icp + inner_hlen, len);
> +        }
> +    }
> +#endif
>      icp->icmp_id =3D id;
> =20
>      m->m_data -=3D hlen;
> --=20
> 2.18.0.865.gffc8e1a3cd6-goog
>=20

--=20
Samuel
<N> (* If you have a precise idea of the intended use of the following co=
de, please
<N>    write to Eduardo.Gimenez@inria.fr and ask for the prize :-)
<N>    -- Eduardo (11/8/97) *)
 -+- N sur #ens-mim - et c'=C3=A9tait un des d=C3=A9veloppeurs -+-
