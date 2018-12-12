Received: from eggs.gnu.org ([2001:4830:134:3::10]:34352)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gWsHA-0000wG-Ad
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 19:21:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gWsH9-00088k-Fx
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 19:21:20 -0500
MIME-Version: 1.0
References: <cover.1544229872.git.alistair.francis@wdc.com>
	<d6c491ecb5c0224c113ddfb2c06552ec89b68227.1544229872.git.alistair.francis@wdc.com>
	<b4a5e3e9-5e62-c0a3-67e3-891725db89d5@linaro.org>
In-Reply-To: <b4a5e3e9-5e62-c0a3-67e3-891725db89d5@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 11 Dec 2018 16:20:50 -0800
Message-ID: <CAKmqyKMzgagUvJ-Zy-qMaMXk_2-3iLjuMyZwkOiu_ffb7mhH-A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [RFC v3 04/24] linux-user: riscv: Fix compile
 failure on riscv32 hosts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Alistair Francis <Alistair.Francis@wdc.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>

On Mon, Dec 10, 2018 at 9:04 AM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 12/7/18 6:46 PM, Alistair Francis wrote:
> > When cross compilling for riscv32 hosts using GCC 8.2 this error is seen:
> >     error: '__NR__llseek' undeclared (first use in this function); did you mean '_llseek'?
> >
> > To avoid the error let's ensure that __NR__llseek is defined.
> >
> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > ---
> >  linux-user/riscv/target_syscall.h | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/linux-user/riscv/target_syscall.h b/linux-user/riscv/target_syscall.h
> > index ee81d8bc88..af73f71839 100644
> > --- a/linux-user/riscv/target_syscall.h
> > +++ b/linux-user/riscv/target_syscall.h
> > @@ -47,6 +47,11 @@ struct target_pt_regs {
> >  #endif
> >  #define UNAME_MINIMUM_RELEASE "4.15.0"
> >
> > +/* This is sometimes needed to compile riscv32 Linux user mode */
> > +#if !defined(__NR__llseek) && !defined(__NR_lseek)
> > +#define __NR__llseek __NR3264_lseek
> > +#endif
>
> I'm not quite sure how this could be.  Upstream I see
>
> #if __BITS_PER_LONG == 64 && !defined(__SYSCALL_COMPAT)
> ...
> #define __NR_lseek __NR3264_lseek
> ...
> #else
> ...
> #define __NR_llseek __NR3264_lseek
>
> so this define should already exist.
>
> Do you have the wrong headers installed for the cross-build?

I'm using Yocto for the cross build, so I don't see how I can get the
wrong headers. I agree though that I probably shouldn't need this
patch. Maybe it's something to do with the glibc fork I'm using. I'll
drop this patch and see if I can figure out what's going on.

Alistair

>
>
> r~
