Received: from eggs.gnu.org ([209.51.188.92]:57951)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <remi@remlab.net>) id 1gnHZf-0001MO-5y
	for qemu-devel@nongnu.org; Sat, 26 Jan 2019 01:36:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <remi@remlab.net>) id 1gnHZd-0003a0-Fg
	for qemu-devel@nongnu.org; Sat, 26 Jan 2019 01:36:14 -0500
From: =?ISO-8859-1?Q?R=E9mi?= Denis-Courmont <remi@remlab.net>
Date: Sat, 26 Jan 2019 08:36:00 +0200
Message-ID: <1738864.GFcTaivyIR@basile.remlab.net>
In-Reply-To: <02a680e1-c20c-2ecb-2926-6250fddf9e76@linaro.org>
References: <1648289.tQCHxfjYn9@basile.remlab.net>
	<20190125214926.3204-1-remi@remlab.net>
	<02a680e1-c20c-2ecb-2926-6250fddf9e76@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 1/3] target/arm: fix AArch64
 virtual address space size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org

	Hi,

Le lauantaina 26. tammikuuta 2019, 1.29.27 EET Richard Henderson a =C3=A9cr=
it :
> On 1/25/19 1:49 PM, R=C3=A9mi Denis-Courmont wrote:
> > From: Remi Denis-Courmont <remi.denis.courmont@huawei.com>
> >=20
> > Since QEMU does not support the ARMv8.2-LVA, Large Virtual Address,
> > extension (yet), the VA address space is signed 48-bits. User mode can
> > only handle the positive half of the address space, so that makes a
> > limit of 47 bits.
> >=20
> > (With LVA, it would be 52 and 51 bits respectively.)
> >=20
> > The incorrectly large address space conflicts with PAuth instructions,
> > which bits 48-54 and 56-63 for the pointer authentication code. This
> > also conflicts with (as yet unsupported by QEMU) data tagging and with
> > the ARMv8.5-MTE extension.
> >=20
> > Signed-off-by: Remi Denis-Courmont <remi.denis.courmont@huawei.com>
> > ---
> >=20
> >  target/arm/cpu.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> > index ff81db420d..2ccd04b8f7 100644
> > --- a/target/arm/cpu.h
> > +++ b/target/arm/cpu.h
> > @@ -2503,7 +2503,7 @@ bool write_cpustate_to_list(ARMCPU *cpu);
> >=20
> >  #if defined(TARGET_AARCH64)
> >  #  define TARGET_PHYS_ADDR_SPACE_BITS 48
> >=20
> > -#  define TARGET_VIRT_ADDR_SPACE_BITS 64
> > +#  define TARGET_VIRT_ADDR_SPACE_BITS 47
> >=20
> >  #else
> >  #  define TARGET_PHYS_ADDR_SPACE_BITS 40
> >  #  define TARGET_VIRT_ADDR_SPACE_BITS 32
>=20
> This doesn't really conflict, as this doesn't affect much besides the siz=
ing
> of the PageDesc for page_find.

Uh, that value controls the range of target virtual addresses user mode map=
s=20
to host virtual addresses. Without this patch, AFAICT, there are no=20
guarantees, only chance, that emulated system calls such as mmap() will not=
=20
allocate architecturally invalid addresses.

> It's true adjusting this is worthwhile.  The current setting requires 7
> levels (6 * 10 bits + 1 * 4 bits), whereas a 48-bit address space only
> requires 5 levels (4 * 10 bits + 8 bits).  Even for LVA it will be (4 * 10
> + 1 * 12 bits).

LVA only works with 64 KiB page size and user mode forces 4 KiB page size a=
t=20
the moment. And I somewhat doubt that somebody would ever need LVA in QEMU=
=20
user mode. So that's highly hypothetical.

> This will both save memory and reduce the time required for TranlationBlo=
ck
> maintenance.
>=20
> Your choice of 47 is wrong.  This value is also used for system mode,

No, it is not. System mode uses the other value, TARGET_PHYS_ADDR_SPACE_BIT=
S,=20
which this patch leaves untouched.

> and
> the kernel does use the negative half of the address space, so we need to
> have all 48 bits here.

I believe that TARGET_PHYS_ADDR_SPACE_BITS could be reduced to 56 bits.=20
Anything less would presumably break handling of the address "sign" bit 55.

However, that would merely constitute an optimization, as there are no risk=
 of=20
generating architecturally invalid addresses at run-time in system mode.

=2D-=20
R=C3=A9mi Denis-Courmont
http://www.remlab.net/
