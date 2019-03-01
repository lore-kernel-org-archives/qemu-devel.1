Received: from eggs.gnu.org ([209.51.188.92]:40506)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gzenT-00023n-P5
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 04:49:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gzenT-0001az-20
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 04:49:39 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:38501)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gzenS-0001aQ-Sp
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 04:49:38 -0500
Received: by mail-ot1-x342.google.com with SMTP id m1so20459887otf.5
	for <qemu-devel@nongnu.org>; Fri, 01 Mar 2019 01:49:38 -0800 (PST)
MIME-Version: 1.0
References: <155143315831.102868.17515265400523392682.stgit@bahia.lan>
In-Reply-To: <155143315831.102868.17515265400523392682.stgit@bahia.lan>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 1 Mar 2019 09:49:26 +0000
Message-ID: <CAFEAcA-8XTSCOp_6kbx_7zo_JK1BC9gpkFF4LqSxTjfhC8iCXA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] slirp: Fix build with gcc 9
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

On Fri, 1 Mar 2019 at 09:39, Greg Kurz <groug@kaod.org> wrote:
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
> The ndpentry structure isn't used to model on-the-wire data or anything
> else that would care for the struct layout. It doesn't need to be packed
> actually. Just drop SLIRP_PACKED.
>
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
> v2: - don't check the struct size at compile time
> ---
>  slirp/slirp.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/slirp/slirp.h b/slirp/slirp.h
> index 752a4cd8c81c..8068ba1d1e9e 100644
> --- a/slirp/slirp.h
> +++ b/slirp/slirp.h
> @@ -106,7 +106,7 @@ bool arp_table_search(Slirp *slirp, uint32_t ip_addr,
>  struct ndpentry {
>      unsigned char   eth_addr[ETH_ALEN];     /* sender hardware address *=
/
>      struct in6_addr ip_addr;                /* sender IP address       *=
/
> -} SLIRP_PACKED;
> +};
>
>  #define NDP_TABLE_SIZE 16

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
