Received: from eggs.gnu.org ([2001:4830:134:3::10]:41874)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gGMgq-0002BA-KK
	for qemu-devel@nongnu.org; Sat, 27 Oct 2018 07:23:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gGMgp-0001en-SV
	for qemu-devel@nongnu.org; Sat, 27 Oct 2018 07:23:36 -0400
Received: from hera.aquilenet.fr ([2a0c:e300::1]:37434)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1gGMgo-0001bQ-SU
	for qemu-devel@nongnu.org; Sat, 27 Oct 2018 07:23:35 -0400
Date: Sat, 27 Oct 2018 13:23:26 +0200
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20181027112326.zcf4jj3teydsidyu@function>
References: <1540512223-21199-1-git-send-email-max7255@yandex-team.ru>
	<1540512223-21199-4-git-send-email-max7255@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1540512223-21199-4-git-send-email-max7255@yandex-team.ru>
Subject: Re: [Qemu-devel] [PATCH RFC 3/4] slirp: add helpers for ipv6
 hostfwd manipulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Maxim Samoylov <max7255@yandex-team.ru>
Cc: qemu-devel@nongnu.org

Hello,

Maxim Samoylov, le ven. 26 oct. 2018 03:03:42 +0300, a ecrit:
> +int slirp_remove_ipv6_hostfwd(Slirp *slirp, int is_udp,
> +                              struct in6_addr host_addr, int host_port)

Similarly, we'd rather share the code than duplicate it :)

Better put the existing slirp_remove_hostfwd code into a

slirp_remove_x_hostfwd(Slirp *slirp, int is_udp, struct sockaddr *addr)

by replacing the explicit ipv4 comparison with a call to a helper
which compares two struct sockaddr (starting with the so_family field,
then testing fields depending the family, and you can put it in
slirp/socket.h)

and then slirp_remove_hostfwd can be rewritten as putting its
parameters into a sockaddr_in and colling slirp_remove_x_hostfwd, and
slirp_remove_ipv6_hostfwd implemented similarly for ipv6.

> +int slirp_add_ipv6_hostfwd(Slirp *slirp, int is_udp,
> +                          struct in6_addr host_addr, int host_port,
> +                          struct in6_addr guest_addr, int guest_port)
> +{
> +    if (is_udp) {
> +        if (!udp6_listen(slirp, host_addr, htons(host_port),
> +                         guest_addr, htons(guest_port), SS_HOSTFWD))
> +            return -1;
> +    } else {
> +        if (!tcp6_listen(slirp, host_addr, htons(host_port),
> +                         guest_addr, htons(guest_port), SS_HOSTFWD))
> +            return -1;
> +    }
> +
> +    return 0;
> +}

That one can remains so :)

Samuel
