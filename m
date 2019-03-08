Received: from eggs.gnu.org ([209.51.188.92]:41712)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h29rb-0002Bq-19
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 02:24:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h29ra-00053H-7o
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 02:24:15 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20190307130323.9353-1-armbru@redhat.com>
	<20190307130323.9353-8-armbru@redhat.com>
	<20190308001032.GF7722@umbus.fritz.box>
Date: Fri, 08 Mar 2019 08:24:04 +0100
In-Reply-To: <20190308001032.GF7722@umbus.fritz.box> (David Gibson's message
	of "Fri, 8 Mar 2019 11:10:32 +1100")
Message-ID: <874l8dj0bv.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 07/14] ppc405_boards: Don't size flash
 memory to match backing image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Markus Armbruster <armbru@redhat.com>, kwolf@redhat.com, qemu-block@nongnu.org, alex.bennee@linaro.org, philmd@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com, qemu-ppc@nongnu.org, lersek@redhat.com

David Gibson <david@gibson.dropbear.id.au> writes:

> On Thu, Mar 07, 2019 at 02:03:16PM +0100, Markus Armbruster wrote:
>> Machine "ref405ep" maps its flash memory at address 2^32 - image size.
>> Image size is rounded up to the next multiple of 64KiB.  Useless,
>> because pflash_cfi02_realize() fails with "failed to read the initial
>> flash content" unless the rounding is a no-op.
>>=20
>> If the image size exceeds 0x80000 Bytes, we overlap first SRAM, then
>> other stuff.  No idea how that would play out, but useful outcomes
>> seem unlikely.
>>=20
>> Map the flash memory at fixed address 0xFFF80000 with size 512KiB,
>> regardless of image size, to match the physical hardware.
>>=20
>> Machine "taihu" maps its boot flash memory similarly.  The code even
>> has a comment /* XXX: should check that size is 2MB */, followed by
>> disabled code to adjust the size to 2MiB regardless of image size.
>>=20
>> Its code to map its application flash memory looks the same, except
>> there the XXX comment asks for 32MiB, and the code to adjust the size
>> isn't disabled.  Note that pflash_cfi02_realize() fails with "failed
>> to read the initial flash content" for images smaller than 32MiB.
>>=20
>> Map the boot flash memory at fixed address 0xFFE00000 with size 2MiB,
>> to match the physical hardware.  Delete dead code from application
>> flash mapping, and simplify some.
>>=20
>> Cc: David Gibson <david@gibson.dropbear.id.au>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> Acked-by: David Gibson <david@gibson.dropbear.id.au>
>> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
> I'm assuming because this is in a series I'm not otherwise CCed on
> that this is going in through someone else's tree.  Let me know if you
> want me take it through mine.

I intend to take the complete series through my tree unless a maintainer
objects.
