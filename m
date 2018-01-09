Received: from eggs.gnu.org ([2001:4830:134:3::10]:55705)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1eZ0vD-0000Bz-Lu
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 15:55:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1eZ0vC-0007Uq-RY
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 15:54:59 -0500
Received: from hera.aquilenet.fr ([2a0c:e300::1]:43368)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1eZ0vC-0007TN-JU
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 15:54:58 -0500
Date: Tue, 9 Jan 2018 21:54:54 +0100
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20180109205454.pjthr5nuowgxzgxe@var.youpi.perso.aquilenet.fr>
References: <20180108172904.8772-1-f4bug@amsat.org>
	<20180108172904.8772-2-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180108172904.8772-2-f4bug@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 01/12] slirp: remove QEMU_PACKED from
 structures with don't require it
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org

Hello,

Philippe Mathieu-Daud=C3=A9, on lun. 08 janv. 2018 14:28:53 -0300, wrote:
>  struct mbuf_ptr {
>  	struct mbuf *mptr;
>  	uint32_t dummy;
> -} QEMU_PACKED;
> +};
>  #else
>  struct mbuf_ptr {
>  	struct mbuf *mptr;
> -} QEMU_PACKED;
> +};

> @@ -199,7 +199,7 @@ struct ipovly {
>  	uint16_t	ih_len;			/* protocol length */
>  	struct	in_addr ih_src;		/* source internet address */
>  	struct	in_addr ih_dst;		/* destination internet address */
> -} QEMU_PACKED;
> +};

Did you actually try to change these structures?  The presence of the
"dummy" field should have hinted that it's not a trivial structure :)

mbuf_ptr is used in struct ipovly which is to have the same size as the
ipv4 header.  One would have to untangle that before removing the packed
attribute.

> @@ -215,7 +215,7 @@ struct ipq {
>  	uint8_t	ipq_p;			/* protocol of this fragment */
>  	uint16_t	ipq_id;			/* sequence id for reassembly */
>  	struct	in_addr ipq_src,ipq_dst;
> -} QEMU_PACKED;
> +};

This one seems safe to me. I'd still rather see an actual test with
added holes in the structure to be sure :)

> @@ -225,7 +225,7 @@ struct ipq {
>  struct	ipasfrag {
>  	struct qlink ipf_link;
>  	struct ip ipf_ip;
> -} QEMU_PACKED;
> +};

Please see iptofrag and fragtoip in ip_input.c, they assume that ipf_ip
immediately follows ipf_link.  I guess using offsetof there should avoid
the issue.  Note however that slirp assumes that in a 32bit-aligned
ethernet frame it has enough room before the IP header to stuff the
ipf_link things.  We could add a build-time check that offsetof(ipf_ip)
<=3D 2 + ETH_HLEN

> @@ -136,7 +136,7 @@ bool arp_table_search(Slirp *slirp, uint32_t ip_add=
r,
>  struct ndpentry {
>      unsigned char   eth_addr[ETH_ALEN];     /* sender hardware address=
 */
>      struct in6_addr ip_addr;                /* sender IP address      =
 */
> -} QEMU_PACKED;
> +};

This one should be safe.

Samuel
