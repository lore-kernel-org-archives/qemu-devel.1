Received: from eggs.gnu.org ([2001:4830:134:3::10]:32861)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1gRd6m-0006MS-68
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 08:09:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1gRd6c-0001I6-Gh
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 08:08:52 -0500
Received: from mail.ispras.ru ([83.149.199.45]:35808)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1gRd6V-0001CQ-NE
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 08:08:42 -0500
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
References: <20181025172057.20414-1-cota@braap.org>
	<20181025172057.20414-24-cota@braap.org>
	<87lg5f51sz.fsf@linaro.org>
	<e1160c9a-454d-5c55-1295-fb1ab977b2a5@linaro.org>
	<20181126190733.GC6688@flamenco>
In-Reply-To: <20181126190733.GC6688@flamenco>
Date: Tue, 27 Nov 2018 16:08:34 +0300
Message-ID: <000f01d48652$4e1a6560$ea4f3020$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Language: ru
Subject: Re: [Qemu-devel] [RFC 23/48] translator: add plugin_insn argument
 to translate_insn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "'Emilio G. Cota'" <cota@braap.org>, 'Richard Henderson' <richard.henderson@linaro.org>
Cc: =?iso-8859-1?Q?'Alex_Benn=E9e'?= <alex.bennee@linaro.org>, 'Stefan Hajnoczi' <stefanha@gmail.com>, 'Peter Maydell' <peter.maydell@linaro.org>, qemu-devel@nongnu.org, =?iso-8859-1?Q?'Llu=EDs_Vilanova'?= <vilanova@ac.upc.edu>

> From: Emilio G. Cota [mailto:cota@braap.org]
> On Mon, Nov 26, 2018 at 10:27:12 -0800, Richard Henderson wrote:
> > On 11/26/18 6:52 AM, Alex Benn=E9e wrote:
> > > I'm not convinced this is the best way to go about it. We end up =
having
> > > to sprinkle the plugin calls into each decoder rather than keeping =
all
> > > the infrastructure in the common main loop. However the common =
loop will
> > > need to know the total number of bytes decoded so we could change =
the
> > > declaration to:
> > >
> > >   int (*translate_insn)(DisasContextBase *db, CPUState *cpu);
> > >
> > > and return the number of bytes decoded.
> >
> > Returning the number of bytes is more difficult than simply just
> >
> >     old_pc =3D db->pc_next;
> >     opc->translate_insn(db, cpu);
> >     bytes =3D db->pc_next - old_pc;
> >
> > requiring no target changes at all.
>=20
> The main reason why I added the qemu_plugin_insn_append calls
> was to avoid reading the instructions twice from guest memory,
> because I was worried that doing so might somehow alter the
> guest's execution, e.g. what if we read a cross-page instruction,
> and both pages mapped to the same TLB entry? We'd end up having
> more TLB misses because instrumentation was enabled.

In our plugins we use cpu_debug_rw function.
But I think that your example with mapping of the page and simultaneous
unmapping of the previous is impossible, because both pages should
be available to the translator for creating the TB.
The translation immediately interrupted with TLB miss and repeated
again after mapping. It means that the cross-page instruction
should not be unmapped until it completely executes.

Pavel Dovgalyuk
