Received: from eggs.gnu.org ([2001:4830:134:3::10]:34509)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fk5ZX-0006p8-Bm
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 06:38:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fk5ZW-0005LQ-E0
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 06:38:39 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:39409)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fk5ZW-0005L7-7T
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 06:38:38 -0400
Received: by mail-oi0-x243.google.com with SMTP id d189-v6so20289268oib.6
	for <qemu-devel@nongnu.org>; Mon, 30 Jul 2018 03:38:37 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180729143545.6978-2-samuel.thibault@ens-lyon.org>
References: <20180729143545.6978-1-samuel.thibault@ens-lyon.org>
	<20180729143545.6978-2-samuel.thibault@ens-lyon.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 30 Jul 2018 11:38:16 +0100
Message-ID: <CAFEAcA8tX0_MNg99oorgOWarJa8Oy+gFFwoRys-fU7ZX3_Ufng@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 1/1] slirp: fix ICMP handling on macOS hosts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Thibault <samuel.thibault@ens-lyon.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, Andrew Oates <aoates@google.com>, Stefan Hajnoczi <stefanha@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>

On 29 July 2018 at 15:35, Samuel Thibault <samuel.thibault@ens-lyon.org> wrote:
> From: Andrew Oates <aoates@google.com>
>
> On Linux, SOCK_DGRAM+IPPROTO_ICMP sockets give only the ICMP packet when
> read from.  On macOS, however, the socket acts like a SOCK_RAW socket
> and includes the IP header as well.
>
> This change strips the extra IP header from the received packet on macOS
> before sending it to the guest.
>
> Signed-off-by: Andrew Oates <aoates@google.com>
> Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
> ---
>  slirp/ip_icmp.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
>
> diff --git a/slirp/ip_icmp.c b/slirp/ip_icmp.c
> index 0b667a429a..6316427ed3 100644
> --- a/slirp/ip_icmp.c
> +++ b/slirp/ip_icmp.c
> @@ -420,7 +420,21 @@ void icmp_receive(struct socket *so)
>      icp = mtod(m, struct icmp *);
>
>      id = icp->icmp_id;
> -    len = qemu_recv(so->s, icp, m->m_len, 0);
> +    len = qemu_recv(so->s, icp, M_ROOM(m), 0);
> +#ifdef CONFIG_DARWIN
> +    if (len >= sizeof(struct ip)) {
> +        /* Skip the IP header that OS X (unlike Linux) includes. */
> +        struct ip *inner_ip = mtod(m, struct ip *);
> +        int inner_hlen = inner_ip->ip_hl << 2;
> +        if (inner_hlen > len) {
> +            len = -1;
> +            errno = -EINVAL;
> +        } else {
> +            len -= inner_hlen;
> +            memmove(icp, (unsigned char *)icp + inner_hlen, len);
> +        }
> +    }
> +#endif

I think it's generally preferable to avoid per-OS ifdefs -- is
this really OSX specific and not (for instance) also applicable
to the other BSDs? Is there some other (configure or runtime) check
we could do to identify whether this is required?

For instance the FreeBSD manpage for icmp(4)
https://www.freebsd.org/cgi/man.cgi?query=icmp&apropos=0&sektion=0&manpath=FreeBSD+11.2-RELEASE&arch=default&format=html

says "incoming packets are received with the IP header and
options intact" and I would be unsurprised to find that
all the BSDs behave the same way here.

thanks
-- PMM
