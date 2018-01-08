Received: from eggs.gnu.org ([2001:4830:134:3::10]:58842)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eYdlB-0005pG-4e
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 15:11:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eYdl6-00011b-Vd
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 15:11:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47370)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1eYdl6-00010x-Gk
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 15:11:00 -0500
References: <20180108172904.8772-1-f4bug@amsat.org>
	<20180108172904.8772-5-f4bug@amsat.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <35587023-41e5-d5bd-bad5-69023b8b8843@redhat.com>
Date: Mon, 8 Jan 2018 21:10:52 +0100
MIME-Version: 1.0
In-Reply-To: <20180108172904.8772-5-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 04/12] slirp: add in6_multicast() and use
 it instead of IN6_IS_ADDR_MULTICAST()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Jan Kiszka <jan.kiszka@siemens.com>, "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org

On 08.01.2018 18:28, Philippe Mathieu-Daud=C3=A9 wrote:
> Host: Mac OS 10.12.5
> Compiler: Apple LLVM version 8.1.0 (clang-802.0.42)
>=20
>   slirp/ip6_icmp.c:79:32: warning: taking address of packed member 'ip_=
src' of class or
>         structure 'ip6' may result in an unaligned pointer value
>         [-Waddress-of-packed-member]
>       if (IN6_IS_ADDR_MULTICAST(&ip->ip_src) ||
>                                  ^~~~~~~~~~
>   /usr/include/netinet6/in6.h:299:36: note: expanded from macro 'IN6_IS=
_ADDR_MULTICAST'
>   #define IN6_IS_ADDR_MULTICAST(a)        ((a)->s6_addr[0] =3D=3D 0xff)
>                                             ^
>=20
> Reported-by: John Arbuckle <programmingkidx@gmail.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  slirp/ip6.h       |  5 +++++
>  slirp/ip6_icmp.c  | 10 +++++-----
>  slirp/ndp_table.c |  4 ++--
>  3 files changed, 12 insertions(+), 7 deletions(-)
>=20
> diff --git a/slirp/ip6.h b/slirp/ip6.h
> index b1bea43b3c..6c5d4eeaa3 100644
> --- a/slirp/ip6.h
> +++ b/slirp/ip6.h
> @@ -93,6 +93,11 @@ static inline bool in6_equal_mach(const struct in6_a=
ddr *a,
>  #define in6_zero(a)\
>      (in6_equal(a, &(struct in6_addr)ZERO_ADDR))

I think you should put a comment here to say why we need our own
function and can not use the IN6_IS_ADDR_MULTICAST macro instead -
otherwise people might be confused when looking at this code in a year
or two. (and now I've also understood why you're poisining the macros in
the next patch ... a comment in the code there would certainly not hurt
either).

> +static inline bool in6_multicast(const struct in6_addr *a)
> +{
> +    return a->s6_addr[0] =3D=3D 0xff;
> +}
> +
>  /* Compute emulated host MAC address from its ipv6 address */
>  static inline void in6_compute_ethaddr(struct in6_addr ip,
>                                         uint8_t eth[ETH_ALEN])

 Thomas
