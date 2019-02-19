Received: from eggs.gnu.org ([209.51.188.92]:47512)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aaron@os.amperecomputing.com>) id 1gw6Ja-0005vM-An
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 09:24:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aaron@os.amperecomputing.com>) id 1gw6JY-00063g-Ne
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 09:24:06 -0500
Received: from mail-eopbgr690110.outbound.protection.outlook.com
	([40.107.69.110]:6328
	helo=NAM04-CO1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aaron@os.amperecomputing.com>)
	id 1gw6JY-0005vh-7C
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 09:24:04 -0500
From: Aaron Lindsay OS <aaron@os.amperecomputing.com>
Date: Tue, 19 Feb 2019 14:23:47 +0000
Message-ID: <20190219142345.GA22806@quinoa.localdomain>
References: <20190128181047.20781-1-peter.maydell@linaro.org>
	<20190128181047.20781-10-peter.maydell@linaro.org>
	<CAFEAcA8tinUgkBxmUe0-WNcaYStu0=6HsXwejQdOZ=L8ZSygXA@mail.gmail.com>
In-Reply-To: <CAFEAcA8tinUgkBxmUe0-WNcaYStu0=6HsXwejQdOZ=L8ZSygXA@mail.gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6D7F5DFC587E7C4BB960278FFB389F09@prod.exchangelabs.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PULL 09/26] target/arm: Don't clear supported PMU
 events when initializing PMCEID1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Feb 14 17:55, Peter Maydell wrote:
> On Mon, 28 Jan 2019 at 18:11, Peter Maydell <peter.maydell@linaro.org> wr=
ote:
> >
> > From: Aaron Lindsay OS <aaron@os.amperecomputing.com>
> >
> > A bug was introduced during a respin of:
> >
> >         commit 57a4a11b2b281bb548b419ca81bfafb214e4c77a
> >         target/arm: Add array for supported PMU events, generate PMCEID=
[01]_EL0
>=20
>=20
>=20
> > @@ -1113,13 +1115,16 @@ uint64_t get_pmceid(CPUARMState *env, unsigned =
which)
> >          /* We do not currently support events in the 0x40xx range */
> >          assert(cnt->number <=3D 0x3f);
> >
> > -        if ((cnt->number & 0x20) =3D=3D (which << 6) &&
> > -                cnt->supported(env)) {
> > -            pmceid |=3D (1 << (cnt->number & 0x1f));
> > +        if (cnt->supported(&cpu->env)) {
> >              supported_event_map[cnt->number] =3D i;
> > +            uint64_t event_mask =3D 1 << (cnt->number & 0x1f);
>=20
> Coverity complains about this line (CID 1398645). The
> RHS is evaluated using 32-bit signed arithmetic (because
> cnt->number is uint16_t and so integer promotion means it
> ends up working with the 'int' type. If cnt->number is
> 31 then this means that the assignment will do an
> unintended sign-extension that sets the top 32 bits
> of event_mask.
>=20
> Fix is probably just to use "1ULL" instead of "1" on the LHS of <<.

I registered for a Coverity account and am awaiting approval for adding
me to the QEMU project so I can test this myself (let me know if this
isn't the right way to go about this).

Would you prefer I wait until I'm able to test that this is resolved
myself, or just submit a patch and have you test it?

-Aaron
