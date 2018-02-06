Received: from eggs.gnu.org ([2001:4830:134:3::10]:36097)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1ej3K7-0007cB-Pm
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 08:30:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1ej3K4-0008GG-Lf
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 08:30:11 -0500
Received: from mail.ispras.ru ([83.149.199.45]:35466)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1ej3K4-0008E8-EK
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 08:30:08 -0500
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
References: <20180206124431.31433.91946.stgit@pasha-VirtualBox>
	<0dfe3d4e-fc7e-8fdf-214c-f1c7a0b6f027@vivier.eu>
In-Reply-To: <0dfe3d4e-fc7e-8fdf-214c-f1c7a0b6f027@vivier.eu>
Date: Tue, 6 Feb 2018 16:30:07 +0300
Message-ID: <000c01d39f4e$9af80f90$d0e82eb0$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Language: ru
Subject: Re: [Qemu-devel] [PATCH v4] m68k: implement movep instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: 'Laurent Vivier' <laurent@vivier.eu>, 'Pavel Dovgalyuk' <Pavel.Dovgaluk@ispras.ru>, qemu-devel@nongnu.org
Cc: huth@tuxfamily.org

> From: Laurent Vivier [mailto:laurent@vivier.eu]
> Le 06/02/2018 =C3=A0 13:44, Pavel Dovgalyuk a =C3=A9crit :
> > This patch implements movep instruction. It moves data between a =
data register
> > and alternate bytes within the address space starting at the =
location
> > specified and incrementing by two.
> >
> > It was designed for the original 68000 and used in firmwares for
> > interfacing the 8-bit peripherals through the 16-bit data bus.
>=20
> Did you test this change with some kind of firmware?

Yes, we implemented this instruction when tried to emulate =
Macintosh-128k on Qemu.

> > Without this patch opcode for this instruction is recognized as some =
bitop.
> >
> > Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
> > Signed-off-by: Mihail Abakumov <mikhail.abakumov@ispras.ru>
> >
> > --
> >
> > v4: - fixed offset calculation misprint
> >
> > v3: - simplified movep function code
> >     - joined movep masks
> >
> > v2: - disabled movep for Coldfire
> >     - fixed gen_store/load usage
> > ---
> >  target/m68k/cpu.c       |    2 ++
> >  target/m68k/cpu.h       |    1 +
> >  target/m68k/translate.c |   46 =
++++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 49 insertions(+)
>=20
> Tested-by: Laurent Vivier <laurent@vivier.eu>
>=20
> I've checked we have the same result on a real 68040
>=20
> Reviewed-by: Laurent Vivier <laurent@vivier.eu>

Thanks!

By the way, we also handled reset interrupt, but it is not compatible =
with other m68k platforms:

@@ -66,8 +66,9 @@ static void m68k_cpu_reset(CPUState *s)
     cpu_m68k_set_fpcr(env, 0);
     env->fpsr =3D 0;
=20
-    /* TODO: We should set PC from the interrupt vector.  */
-    env->pc =3D 0;
+    env->vbr =3D 0;
+    /* PC and SP (for m68k) will be initialized by the reset handler */
+    s->exception_index =3D EXCP_RESET;
 }

@@ -378,6 +380,8 @@ static void m68k_interrupt_all(CPUM68KState *env, =
int is_hw)
         cpu_m68k_set_sr(env, sr &=3D ~SR_M);
         sp =3D env->aregs[7] & ~1;
         do_stack_frame(env, &sp, 1, oldsr, 0, retaddr);
+    } else if (cs->exception_index =3D=3D EXCP_RESET) {
+        sp =3D cpu_ldl_kernel(env, env->vbr + vector - 4);
     } else {
         do_stack_frame(env, &sp, 0, oldsr, 0, retaddr);
     }

Pavel Dovgalyuk
