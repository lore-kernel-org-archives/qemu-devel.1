Received: from eggs.gnu.org ([2001:4830:134:3::10]:52438)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1ezJdJ-0000Tm-Su
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 06:09:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1ezJdE-0003JV-8p
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 06:09:13 -0400
Date: Fri, 23 Mar 2018 11:08:43 +0100
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20180323100843.i7xrvfodcpi7rtr5@hawk.localdomain>
References: <20180315133441.24149-1-peter.maydell@linaro.org>
	<20180322142343.jvc6pxxvl5zhfjgy@hawk.localdomain>
	<CAFEAcA8Vti8NnrQK4U4kLuk=nNMC5=KiKjc6wT7cLDnCHFj-8w@mail.gmail.com>
	<48f559bd-9f54-bcdd-1f3c-f6fafccfc54e@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <48f559bd-9f54-bcdd-1f3c-f6fafccfc54e@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH for-2.12] hw/intc/arm_gicv3: Fix
 secure-GIC NS ICC_PMR and ICC_RPR accesses
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>

On Thu, Mar 22, 2018 at 05:42:02PM -0300, Philippe Mathieu-Daud=E9 wrote:
> Hi Peter,
>=20
> On 03/22/2018 03:29 PM, Peter Maydell wrote:
> > On 22 March 2018 at 14:23, Andrew Jones <drjones@redhat.com> wrote:
> >> On Thu, Mar 15, 2018 at 01:34:41PM +0000, Peter Maydell wrote:
> >>> If the GIC has the security extension support enabled, then a
> >>> non-secure access to ICC_PMR must take account of the non-secure
> >>> view of interrupt priorities, where real priorities 0..0x7f
> >>> are secure-only and not visible to the non-secure guest, and
> >>> priorities 0x80..0xff are shown to the guest as if they were
> >>> 0x00..0xff. We had the logic here wrong:
> >>
> >> 0x00..0x7f
> >=20
> > I think 0x00..0xff is correct.
>=20
> I guess Andrew only suggested to correct the hex prefix in your comment=
:
> - ... where real priorities 0..0x7f
> + ... where real priorities 0x00..0x7f

Actually I just hadn't thought that through properly. But thanks for
giving me the benefit of the doubt :-)

> >=20
> > the NS view covers the whole 0x00..0xff range, but more sparsely.
> > (OK, technically you can't ever read 0xff, only 0xfe.)
>=20

You can read 0xff, because 0xff will be written when either 0xfe or 0xff
are written. Then, when reading, priority =3D=3D 0xff will fail the !=3D =
0xff
test (which is QEMU's implementation of the pseudo code where PRIMask()
is hardcoded to 0xff). In that case it'll just return the priority value
unchanged, which is 0xff.

Thanks,
drew
