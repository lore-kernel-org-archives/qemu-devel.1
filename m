Received: from eggs.gnu.org ([209.51.188.92]:51497)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gztYB-0006fg-AQ
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 20:34:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gztY7-0004Fd-JO
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 20:34:50 -0500
Received: from hera.aquilenet.fr ([2a0c:e300::1]:46392)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1gztY3-0003of-9G
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 20:34:44 -0500
Date: Fri, 1 Mar 2019 17:33:40 -0800
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20190302013340.xf5saersxutpgvmk@function>
References: <155143315831.102868.17515265400523392682.stgit@bahia.lan>
	<CAFEAcA-8XTSCOp_6kbx_7zo_JK1BC9gpkFF4LqSxTjfhC8iCXA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA-8XTSCOp_6kbx_7zo_JK1BC9gpkFF4LqSxTjfhC8iCXA@mail.gmail.com>
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Greg Kurz <groug@kaod.org>, QEMU Developers <qemu-devel@nongnu.org>, Jan Kiszka <jan.kiszka@siemens.com>

Peter Maydell, le ven. 01 mars 2019 09:49:26 +0000, a ecrit:
> On Fri, 1 Mar 2019 at 09:39, Greg Kurz <groug@kaod.org> wrote:
> >
> > Build fails with gcc 9:
> >
> >   CC      slirp/ndp_table.o
> > slirp/ndp_table.c: In function =E2=80=98ndp_table_add=E2=80=99:
> > slirp/ndp_table.c:31:23: error: taking address of packed member of =E2=
=80=98struct ndpentry=E2=80=99 may result in an unaligned pointer value [=
-Werror=3Daddress-of-packed-member]
> >    31 |         if (in6_equal(&ndp_table->table[i].ip_addr, &ip_addr)=
) {
> >       |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > slirp/ndp_table.c: In function =E2=80=98ndp_table_search=E2=80=99:
> > slirp/ndp_table.c:75:23: error: taking address of packed member of =E2=
=80=98struct ndpentry=E2=80=99 may result in an unaligned pointer value [=
-Werror=3Daddress-of-packed-member]
> >    75 |         if (in6_equal(&ndp_table->table[i].ip_addr, &ip_addr)=
) {
> >       |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > cc1: all warnings being treated as errors
> >
> > The ndpentry structure isn't used to model on-the-wire data or anythi=
ng
> > else that would care for the struct layout. It doesn't need to be pac=
ked
> > actually. Just drop SLIRP_PACKED.
> >
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> > ---
> > v2: - don't check the struct size at compile time
> > ---
> >  slirp/slirp.h |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/slirp/slirp.h b/slirp/slirp.h
> > index 752a4cd8c81c..8068ba1d1e9e 100644
> > --- a/slirp/slirp.h
> > +++ b/slirp/slirp.h
> > @@ -106,7 +106,7 @@ bool arp_table_search(Slirp *slirp, uint32_t ip_a=
ddr,
> >  struct ndpentry {
> >      unsigned char   eth_addr[ETH_ALEN];     /* sender hardware addre=
ss */
> >      struct in6_addr ip_addr;                /* sender IP address    =
   */
> > -} SLIRP_PACKED;
> > +};
> >
> >  #define NDP_TABLE_SIZE 16
>=20
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

Applied to my tree, thanks!

Samuel
