Received: from eggs.gnu.org ([209.51.188.92]:48187)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gsD1D-0004mJ-Q3
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 15:45:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gsD1B-0006kA-TO
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 15:45:03 -0500
MIME-Version: 1.0
References: <CAFyWVaZ5tQq4eGaZiPBq7172PB_x3JCqV6c2xo=wSJdgbJakKQ@mail.gmail.com>
	<20190130025708.12811-1-jimw@sifive.com>
	<CAKmqyKMrCVqudmyJUPta9q6TJtDkeLV=FseAqQ7YhYMu3ak_NQ@mail.gmail.com>
	<CAFyWVaaS_4RY9YKXcgJ1F4Ep1TDWkExtBTEigJedZQCcXG+44Q@mail.gmail.com>
In-Reply-To: <CAFyWVaaS_4RY9YKXcgJ1F4Ep1TDWkExtBTEigJedZQCcXG+44Q@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 8 Feb 2019 10:16:56 -0800
Message-ID: <CAKmqyKOgnM0+6EByX-AWry-pkry_VQOa3SN5PWU75E0Q3_rbSw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 5/5 v3] RISC-V: Add hooks to use the gdb
 xml files.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jim Wilson <jimw@sifive.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, "open list:RISC-V" <qemu-riscv@nongnu.org>

On Wed, Feb 6, 2019 at 6:05 PM Jim Wilson <jimw@sifive.com> wrote:
>
> On Wed, Feb 6, 2019 at 4:04 PM Alistair Francis <alistair23@gmail.com> wrote:
> > Would it not be easier to add an extra argument to the functions
> > intstead of setting and unsetting this?
> >
> > That's what you had in the earlier version of this set.
>
> The csr support was rewritten, and is now a table of functions.  If I
> change the type signature for one function in a table column I have to
> change them all.  This means I have to change the type signature of
> about 50 functions, the vast majority of which will never use the new
> argument.  I was hoping to avoid that, so I added a variable into the
> cpu state instead.  In the old patch, before the csr rewrite, I only
> had to change the type signature of a couple of functions, most of
> which did use the new argument, so that was reasonable at the time.

Ah good point.

Can we just write a wrapper function then that sets and unsets the variable?

Something like this:

riscv_csrrw_debug(...) {
    #if !defined(CONFIG_USER_ONLY)
            env->debugger = true;
    #endif
            result = riscv_csrrw(env, ...);
    #if !defined(CONFIG_USER_ONLY)
            env->debugger = false;
    #endif
}

Alistair

>
> If I do need to change a lot of type signatures, what about attribute
> ((unused))?  I see that there is a ATTRIBUTE_UNUSED in the disas dir
> but it is apparently not used outside there, and only defined in
> include/disas/bfd.h.  I see a few scattered uses of
> attribute((unused)) but that seems unwise for portability reasons.
> Maybe qemu doesn't care about unused arguments/parameters?
>
> Jim
