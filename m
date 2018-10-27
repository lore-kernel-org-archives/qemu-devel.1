Received: from eggs.gnu.org ([2001:4830:134:3::10]:39833)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gGMVO-0004S8-FX
	for qemu-devel@nongnu.org; Sat, 27 Oct 2018 07:11:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gGMVN-0001zI-Il
	for qemu-devel@nongnu.org; Sat, 27 Oct 2018 07:11:46 -0400
Received: from hera.aquilenet.fr ([2a0c:e300::1]:37372)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1gGMVN-0001yQ-Am
	for qemu-devel@nongnu.org; Sat, 27 Oct 2018 07:11:45 -0400
Date: Sat, 27 Oct 2018 13:11:41 +0200
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20181027111141.tpzhv6xcrhxet6li@function>
References: <1540512223-21199-1-git-send-email-max7255@yandex-team.ru>
	<1540512223-21199-2-git-send-email-max7255@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1540512223-21199-2-git-send-email-max7255@yandex-team.ru>
Subject: Re: [Qemu-devel] [PATCH RFC 1/4] slirp: add helper for tcp6 socket
 creation
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

Thanks for working on this!

There is a lot of overlap with tcp_listen. It'd be much better to
refactor it this way:

struct socket *
tcpx_listen(Slirp *slirp, struct sockaddr *addr, socklen_t *addrlen, int flags)
{
	... The current content of tcp_listen, with all heading and
	trailing addr manipulations removed...
	
	... so->so_lfamily = addr->sa_family;...
	... s = qemu_socket(addr->sa_family, SOCK_STREAM, 0);...
        ... (bind(s, addr, *addrlen) < 0) ||...
	... getsockname(s, addr, addrlen);
}

struct socket *
tcp_listen(Slirp *slirp, uint32_t haddr, u_int hport, uint32_t laddr,
           u_int lport, int flags)
{
	struct sockaddr_in addr;
	struct socket *so;
	socklen_t addrsize = sizeof(addr);

	addr.sin_family = AF_INET;
	addr.sin_addr.s_addr = haddr;
	addr.sin_port = hport;

	so = tcpx_listen(slirp, (struct sockaddr *) &addr, &addrsize, flags);

	so->so_lport = lport; /* Kept in network format */
	so->so_laddr.s_addr = laddr; /* Ditto */

	so->so_ffamily = AF_INET;
	so->so_fport = addr.sin_port;
	if (addr.sin_addr.s_addr == 0 || addr.sin_addr.s_addr == loopback_addr.s_addr)
	   so->so_faddr = slirp->vhost_addr;
	else
	   so->so_faddr = addr.sin_addr;
}

The v6 version then boils down to

struct socket *
tcp6_listen(Slirp *slirp, struct in6_addr haddr, u_int hport, struct
	    in6_addr laddr, u_int lport, int flags)
{
	struct sockaddr_in6 addr;
	struct socket *so;
	socklen_t addrsize = sizeof(addr);

	addr.sin6_family = AF_INET6;
	addr.sin6_addr = haddr;
	addr.sin6_port = hport;

	so = tcpx_listen(slirp, (struct sockaddr *) &addr, &addrsize, flags);

	so->so_lport6 = lport; /* Kept in network format */
	so->so_laddr6 = laddr; /* Ditto */

	so->fhost.sin6 = addr;
	    
	if (!memcmp(&addr.sin6_addr, &in6addr_any, sizeof(in6addr_any)) ||
	    !memcmp(&addr.sin6_addr, &in6addr_loopback,
	            sizeof(in6addr_loopback))) {
	
	    memcpy(&so->so_faddr6, &slirp->vhost_addr6, sizeof(slirp->vhost_addr6));
	}
}

modulo all typos etc. I may have done.

Maxim Samoylov, le ven. 26 oct. 2018 03:03:40 +0300, a ecrit:
> +    qemu_setsockopt(s, SOL_SOCKET, SO_OOBINLINE, &opt, sizeof(int));

Is there a reason why you set SO_OOBINLINE, but not TCP_NODELAY? That's
the kind of discrepancy we don't want to let unseen, thus the reason for
a shared implementation :)

Samuel
