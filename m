Received: from eggs.gnu.org ([209.51.188.92]:44420)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <benh@kernel.crashing.org>) id 1gti4w-00024w-U9
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 19:07:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <benh@kernel.crashing.org>) id 1gti1q-0006K4-F4
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 19:03:55 -0500
Message-ID: <56a5772ae88c5b5f65c969e2191a02d62cca5055.camel@kernel.crashing.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 13 Feb 2019 11:03:12 +1100
In-Reply-To: <20190212055900.GN1884@umbus.fritz.box>
References: <20190128094625.4428-1-clg@kaod.org>
	<20190128094625.4428-8-clg@kaod.org>
	<20190212055900.GN1884@umbus.fritz.box>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 07/19] target/ppc: Make special ORs match
 x86 pause and don't generate on mttcg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On Tue, 2019-02-12 at 16:59 +1100, David Gibson wrote:
> On Mon, Jan 28, 2019 at 10:46:13AM +0100, C=C3=A9dric Le Goater wrote:
> > From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> >=20
> > There's no point in going out of translation on an SMT OR with
> > mttcg since the backend won't do anything useful such as pausing,
> > it's only useful on traditional TCG to give time to other
> > processors.
>=20
> Is it actively harmful in the MTTCG case, or just pointless?

I think it can hurt performance, I don't remember for sure :)

> > Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> > ---
> >  target/ppc/translate.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> > index e169c43643a1..7d40a1fbe6bd 100644
> > --- a/target/ppc/translate.c
> > +++ b/target/ppc/translate.c
> > @@ -1580,7 +1580,7 @@ static void gen_pause(DisasContext *ctx)
> >      tcg_temp_free_i32(t0);
> > =20
> >      /* Stop translation, this gives other CPUs a chance to run */
> > -    gen_exception_nip(ctx, EXCP_HLT, ctx->base.pc_next);
> > +    gen_exception_nip(ctx, EXCP_INTERRUPT, ctx->base.pc_next);
>=20
> I don't see how this change relates to the rest.

Yeah not sure anymore :-)

> >  }
> >  #endif /* defined(TARGET_PPC64) */
> > =20
> > @@ -1662,7 +1662,9 @@ static void gen_or(DisasContext *ctx)
> >           * than no-op, e.g., miso(rs=3D26), yield(27), mdoio(29), md=
oom(30),
> >           * and all currently undefined.
> >           */
> > -        gen_pause(ctx);
> > +        if (!mttcg_enabled) {
> > +            gen_pause(ctx);
> > +        }
> >  #endif
> >  #endif
> >      }
