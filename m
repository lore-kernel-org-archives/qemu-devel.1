Received: from eggs.gnu.org ([209.51.188.92]:52935)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h1D9d-00070D-Ez
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 11:42:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h1D9c-0000WG-MG
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 11:42:57 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20190226193408.23862-1-armbru@redhat.com>
	<20190226193408.23862-12-armbru@redhat.com>
	<a20fe845-4f14-4f23-7feb-bb7ca899c2d5@redhat.com>
Date: Tue, 05 Mar 2019 17:42:42 +0100
In-Reply-To: <a20fe845-4f14-4f23-7feb-bb7ca899c2d5@redhat.com> ("Philippe
	=?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Tue, 5 Mar 2019 14:55:57
	+0100")
Message-ID: <878sxt5l31.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 11/11] pflash: Clean up after commit
 368a354f02b part 2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Cc: qemu-devel@nongnu.org, alex.bennee@linaro.org, lersek@redhat.com, kwolf@redhat.com, qemu-ppc@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> Hi Markus,
>
> On 2/26/19 8:34 PM, Markus Armbruster wrote:
>> QOMification left parameter @size unused in pflash_cfi01_register()
>> and pflash_cfi02_register().  Obviously, @size should match
>> @sector_len and @nb_blocs, i.e. size =3D=3D sector_len * nb_blocs.  All
>> callers satisfy this.
>>=20
>> Remove @nb_blocs and compute it from @size and @sector_len.
>
> The pflash devices are simplistically modelled has having a single
> sector size. This is not true for real hw (pflash have different sector
> sizes). It is however true for the unofficial VirtPFlash device, which
> doesn't have any spec.
>
> The only valid parameter is @size. The @sector_len and @nb_blocs don't
> match the hardwares. QEMU @sector_len is currently "The biggest
> sector_size the device has" and QEMU @nb_blocs is really "@size /
> @sector_len", although it doesn't match the nb_blocs the hardware has.
>
> I don't disagree with the patch content, but the description is not
> accurate. We can indeed drop the @nb_blocs argument because we model an
> unique sector size, thus we can calculate "@nb_blocs =3D @size /
> @sector_len" in the model.
>
> With the patch description fixed:
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Let me try to fix it.

    Our pflash devices are simplistically modelled has having
    "num-blocks" sectors of equal size "sector-length".  Real hardware
    commonly has sectors of different sizes.  How our "sector-length"
    property is related to the physical device's multiple sector sizes
    is unclear.

    Helper functions pflash_cfi01_register() and pflash_cfi02_register()
    create a pflash device, set properties including "sector-length" and
    "num-blocks", and realize.  They take parameters @size, @sector_len
    and @nb_blocs.

    QOMification left parameter @size unused.  Obviously, @size should
    match @sector_len and @nb_blocs, i.e. size =3D=3D sector_len * nb_blocs.
    All callers satisfy this.

    Remove @nb_blocs and compute it from @size and @sector_len.

D'accord?
