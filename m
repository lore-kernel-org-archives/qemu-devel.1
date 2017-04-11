Received: from eggs.gnu.org ([2001:4830:134:3::10]:53932)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <benh@kernel.crashing.org>) id 1cxvob-0008Oh-1o
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 09:26:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <benh@kernel.crashing.org>) id 1cxvoX-0002Tk-U8
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 09:26:37 -0400
Message-ID: <1491917167.7236.1.camel@kernel.crashing.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Tue, 11 Apr 2017 23:26:07 +1000
In-Reply-To: <04c9f03f-7f04-ebce-15f1-988db1fb2c1d@kaod.org>
References: <20170406102249.20383-1-nikunj@linux.vnet.ibm.com>
	<6029cef4-0a41-cde0-b3c9-6b6ad9bde572@kaod.org>
	<87vaqgrds2.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<a74b9ee8-1b9d-244b-8046-b116fedb55f1@kaod.org>
	<25dcb89b-35be-ea27-8719-7b446f464694@kaod.org>
	<87lgr8ji2f.fsf@linaro.org>
	<04c9f03f-7f04-ebce-15f1-988db1fb2c1d@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH RFC v1 0/3] Enable MTTCG on PPC64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, Alex =?ISO-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, rth@twiddle.net, programmingkidx@gmail.com, qemu-devel@nongnu.org, bharata@linux.vnet.ibm.com

On Tue, 2017-04-11 at 14:28 +0200, C=C3=A9dric Le Goater wrote:
> I really don't know.=C2=A0
>=20
> Ben, now that we have mttcg activated by default on ppc, it takes=C2=A0
> a while for the linux kernel to do the early setup. I think we are
> in the code section where we spin loop the secondaries. Most of the
> time is spent in skiboot under cpu_idle/relax.
>=20
> Any idea where that could come from ?=C2=A0
>=20
> > See c22edfebff29f63d793032e4fbd42a035bb73e27 for an example.
>=20
> Thanks for the hint.

They are spinning, but they have smt_low instructions in the loop,
maybe that causes us to do some kind of synchronization as we exit
the emulation loop on these ? I added that to force relinguish time
to other threads on the pre-MT TCG...

There isn't really such a "pause" instruction. At least not yet.... P9
has a wait that is meant to wait for special AS_Notify cycles but will
also wait for interrupts. We don't have an mwait at this point.

Ben.
=20
