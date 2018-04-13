Received: from eggs.gnu.org ([2001:4830:134:3::10]:39859)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1f6yVc-0003uL-2D
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 09:12:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1f6yVY-0001NF-Lf
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 09:12:56 -0400
Received: from mail.ispras.ru ([83.149.199.45]:57440)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1f6yVY-0001MC-DZ
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 09:12:52 -0400
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
References: <20180413111245.28627.3415.stgit@pasha-VirtualBox>
	<8d351a47-11fb-330e-b389-3dd430559226@vivier.eu>
In-Reply-To: <8d351a47-11fb-330e-b389-3dd430559226@vivier.eu>
Date: Fri, 13 Apr 2018 16:12:46 +0300
Message-ID: <002201d3d329$1d6fea70$584fbf50$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Content-Language: ru
Subject: Re: [Qemu-devel] [PATCH] m68: fix exception stack frame for 68000
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: 'Laurent Vivier' <laurent@vivier.eu>, 'Pavel Dovgalyuk' <Pavel.Dovgaluk@ispras.ru>, qemu-devel@nongnu.org
Cc: maria.klimushenkova@ispras.ru

> From: Laurent Vivier [mailto:laurent@vivier.eu]
> Le 13/04/2018 =C3=A0 13:12, Pavel Dovgalyuk a =C3=A9crit :
> > 68000 CPUs do not save format in the exception stack frame.
> > This patch adds feature checking to prevent format saving for 68000.
> > m68k_ret() already includes this modification, this patch fixes
> > the exception processing function too.
> >
> > Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
> > ---
> >  target/m68k/op_helper.c |    7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> >
> > diff --git a/target/m68k/op_helper.c b/target/m68k/op_helper.c
> > index 3a7f7f2..e367133 100644
> > --- a/target/m68k/op_helper.c
> > +++ b/target/m68k/op_helper.c
> > @@ -301,8 +301,11 @@ static inline void do_stack_frame(CPUM68KState =
*env, uint32_t *sp,
> >          cpu_stl_kernel(env, *sp, addr);
> >          break;
> >      }
> > -    *sp -=3D 2;
> > -    cpu_stw_kernel(env, *sp, (format << 12) + (cs->exception_index =
<< 2));
> > +    if (m68k_feature(env, M68K_FEATURE_QUAD_MULDIV)) {
> > +        /*  all except 68000 */
> > +        *sp -=3D 2;
> > +        cpu_stw_kernel(env, *sp, (format << 12) + =
(cs->exception_index << 2));
> > +    }
> >      *sp -=3D 4;
> >      cpu_stl_kernel(env, *sp, retaddr);
> >      *sp -=3D 2;
> >
>=20
> To be the exact counterpart of m68k_rte(), I think you should include
> the "switch () { }" into the "if () { }".

That's right, thank you.


Pavel Dovgalyuk
