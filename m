Received: from eggs.gnu.org ([2001:4830:134:3::10]:35214)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gGKAx-0001I7-DK
	for qemu-devel@nongnu.org; Sat, 27 Oct 2018 04:42:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gGKAw-0000hb-FW
	for qemu-devel@nongnu.org; Sat, 27 Oct 2018 04:42:31 -0400
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144]:34285)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1gGKAw-0000gt-83
	for qemu-devel@nongnu.org; Sat, 27 Oct 2018 04:42:30 -0400
Received: by mail-lf1-x144.google.com with SMTP id n26-v6so2632772lfl.1
	for <qemu-devel@nongnu.org>; Sat, 27 Oct 2018 01:42:29 -0700 (PDT)
MIME-Version: 1.0
References: <1540577067-8235-1-git-send-email-dayeol@berkeley.edu>
	<CACjxMEvNDOyvyLPBG9CyuHOojHkNuCg_n-WWDwmi6xH6Fi4agQ@mail.gmail.com>
In-Reply-To: <CACjxMEvNDOyvyLPBG9CyuHOojHkNuCg_n-WWDwmi6xH6Fi4agQ@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Sat, 27 Oct 2018 09:42:02 +0100
Message-ID: <CAKmqyKPthXEC6fGf5cut_GqrJ6f76tzeqGo6A=Bj=3f+dKW9zw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] target/riscv/pmp.c: pmpcfg_csr_read
 returns bogus value on RV64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: dayeol@berkeley.edu
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Michael Clark <mjc@sifive.com>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>

On Fri, Oct 26, 2018 at 7:14 PM Dayeol Lee <dayeol@berkeley.edu> wrote:
>
> Hi,
>
> I submitted the patch, but just found this has been already fixed by
> Michael Clark
> and pushed to riscv/riscv-qemu https://github.com/riscv/riscv-qemu/pull/166
> but not in the upstream.
>
> Do we still need this patch?

Yeah, this patch is still needed as it fixes the problem in mainline.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

>
> Thanks,
>
> Dayeol
>
> On Fri, Oct 26, 2018 at 11:04 AM Dayeol Lee <dayeol@berkeley.edu> wrote:
>
> > pmp_read_cfg() returns 8-bit value, which is combined together to form a
> > single pmpcfg CSR.
> > The default promotion rules will result in an integer here ("i*8" is
> > integer, which
> > flows through) resulting in a 32-bit signed value on most hosts.
> > That's bogus on RV64I, with the high bits of the CSR being wrong.
> >
> > Signed-off-by: Dayeol Lee <dayeol@berkeley.edu>
> > Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
> > ---
> >  target/riscv/pmp.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
> > index c828950..3d3906a 100644
> > --- a/target/riscv/pmp.c
> > +++ b/target/riscv/pmp.c
> > @@ -330,7 +330,7 @@ target_ulong pmpcfg_csr_read(CPURISCVState *env,
> > uint32_t reg_index)
> >  {
> >      int i;
> >      target_ulong cfg_val = 0;
> > -    uint8_t val = 0;
> > +    target_ulong val = 0;
> >
> >      if(sizeof(target_ulong) == 8)
> >          reg_index /= 2;
> > --
> > 2.7.4
> >
> >
