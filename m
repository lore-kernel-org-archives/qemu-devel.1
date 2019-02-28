Received: from eggs.gnu.org ([209.51.188.92]:46109)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gzQD6-00080o-57
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 13:15:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gzQD5-00017m-51
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 13:15:08 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:44254)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gzQD3-0000vw-3C
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 13:15:05 -0500
Received: by mail-ot1-x344.google.com with SMTP id g1so18488691otj.11
	for <qemu-devel@nongnu.org>; Thu, 28 Feb 2019 10:14:53 -0800 (PST)
MIME-Version: 1.0
References: <155137655081.44146.7139636183950580495.stgit@bahia.lan>
In-Reply-To: <155137655081.44146.7139636183950580495.stgit@bahia.lan>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 Feb 2019 18:14:40 +0000
Message-ID: <CAFEAcA_p1fFQWKnDXfTw=7UY_pM3RfZ5pJbBATBzDK_6DN7HmQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] slirp: Fix build with gcc 9
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Jan Kiszka <jan.kiszka@siemens.com>

On Thu, 28 Feb 2019 at 17:55, Greg Kurz <groug@kaod.org> wrote:
>
> Build fails with gcc 9:
>
>   CC      slirp/ndp_table.o
> slirp/ndp_table.c: In function =E2=80=98ndp_table_add=E2=80=99:
> slirp/ndp_table.c:31:23: error: taking address of packed member of =E2=80=
=98struct ndpentry=E2=80=99 may result in an unaligned pointer value [-Werr=
or=3Daddress-of-packed-member]
>    31 |         if (in6_equal(&ndp_table->table[i].ip_addr, &ip_addr)) {
>       |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> slirp/ndp_table.c: In function =E2=80=98ndp_table_search=E2=80=99:
> slirp/ndp_table.c:75:23: error: taking address of packed member of =E2=80=
=98struct ndpentry=E2=80=99 may result in an unaligned pointer value [-Werr=
or=3Daddress-of-packed-member]
>    75 |         if (in6_equal(&ndp_table->table[i].ip_addr, &ip_addr)) {
>       |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
>
> All members of struct ndpentry are naturally aligned. Drop the QEMU_PACKE=
D
> attribute and check there isn't unwanted padding at build time.

> diff --git a/slirp/slirp.h b/slirp/slirp.h
> index 752a4cd8c81c..97552962697a 100644
> --- a/slirp/slirp.h
> +++ b/slirp/slirp.h
> @@ -106,7 +106,9 @@ bool arp_table_search(Slirp *slirp, uint32_t ip_addr,
>  struct ndpentry {
>      unsigned char   eth_addr[ETH_ALEN];     /* sender hardware address *=
/
>      struct in6_addr ip_addr;                /* sender IP address       *=
/
> -} SLIRP_PACKED;
> +};
> +
> +G_STATIC_ASSERT(sizeof(struct ndpentry) =3D=3D 22);

This relies on "struct in6_addr" being only byte-aligned,
since ETH_ALEN is 6. Otherwise the ip_addr field will not
be naturally aligned.

in6_addr seems to just be a byte array in Linux at least in
some configurations, but on NetBSD
https://ftp.netbsd.org/pub/NetBSD/NetBSD-current/src/sys/netinet6/in6.h
it's defined as a union some of whose members are going to want
more alignment than that, so I suspect that this will fail
to compile there (though I haven't checked).

My question is: why is this struct marked packed at all?
As far as I can see, the only use of the ntpentry type is in
the NdpTable and the code in ndp_table.c that uses it. But
that code does not use the struct to model on-the-wire data
or anything else that would care about the struct layout:
it only ever works with the struct by simple operations on
its member fields. So I think the correct answer here is that
we can drop SLIRP_PACKED entirely and do not need to try to
assert that the struct has a particular size.

My guess is that this got a packed attribute mistakenly
by analogy with the struct slirp_arphdr which is used in
the ArpTable struct -- but that struct really is used to
match on-the-wire data, and this one is not.

thanks
-- PMM
