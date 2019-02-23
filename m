Received: from eggs.gnu.org ([209.51.188.92]:45157)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ncopa@alpinelinux.org>) id 1gxZml-0002He-LV
	for qemu-devel@nongnu.org; Sat, 23 Feb 2019 11:04:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ncopa@alpinelinux.org>) id 1gxZmk-0004Vb-1E
	for qemu-devel@nongnu.org; Sat, 23 Feb 2019 11:04:19 -0500
Received: from mx1.tetrasec.net ([74.117.190.25]:53938)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ncopa@alpinelinux.org>) id 1gxZmj-0004V4-Mi
	for qemu-devel@nongnu.org; Sat, 23 Feb 2019 11:04:17 -0500
Date: Sat, 23 Feb 2019 16:55:23 +0100
From: Natanael Copa <ncopa@alpinelinux.org>
Message-ID: <20190223165523.1d674224@ncopa-desktop.copa.dup.pw>
In-Reply-To: <CAJSP0QWouR43wVi0guTuASP9gc24_CPucbBvtfE5_htkDkmsrQ@mail.gmail.com>
References: <VI1PR0602MB32452A8FD128F63FFAC0CEADA4920@VI1PR0602MB3245.eurprd06.prod.outlook.com>
	<VI1PR0602MB32453A8B5CBC0308C7D18F1DA47E0@VI1PR0602MB3245.eurprd06.prod.outlook.com>
	<CAJSP0QVxaW3tezjBN9owJHsxzE9h8_qcaeRr5zHHKxKJOeFnkQ@mail.gmail.com>
	<CAJSP0QVXoZJ9MJ0qp4RM_m2fGJ8iFSyJMAU_X7mdiQvpOK59KA@mail.gmail.com>
	<VI1PR0602MB324516419266A934FE7759C6A47E0@VI1PR0602MB3245.eurprd06.prod.outlook.com>
	<VI1PR0602MB324516419266A934FE7759C6A47E0@VI1PR0602MB3245.eurprd06.prod.outlo>
	<VI1PR0602MB32454C17192EFA863E29CC49A47E0@VI1PR0602MB3245.eurprd06.prod.outlo>
	<VI1PR0602MB324547F72DA9EDEB1613C888A47E0@VI1PR0602MB3245.eurprd06.prod.outlook.com>
	<CAJSP0QUg=cq3tCSLidQ9BR2hxAo3K6gA6LKtpx5Rjb=_6XgJ6Q@mail.gmail.com>
	<28e6b4ed-9afd-3a79-6267-86c7385c23ce@redhat.com>
	<VI1PR0602MB324578F91F1AF9390D03022FA47F0@VI1PR0602MB3245.eurprd06.prod.outlook.com>
	<CAJSP0QWouR43wVi0guTuASP9gc24_CPucbBvtfE5_htkDkmsrQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-block] Guest unresponsive after Virtqueue
 size exceeded error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Fernando Casas =?ISO-8859-1?B?U2No9nNzb3c=?= <casasfernando@outlook.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, qemu-devel <qemu-devel@nongnu.org>

On Fri, 22 Feb 2019 14:04:20 +0000
Stefan Hajnoczi <stefanha@gmail.com> wrote:

> On Fri, Feb 22, 2019 at 12:57 PM Fernando Casas Sch=F6ssow
> <casasfernando@outlook.com> wrote:
>=20
> I have CCed Natanael Copa, qemu package maintainer in Alpine Linux.
>=20
> Fernando: Can you confirm that the bug occurs with an unmodified
> Alpine Linux qemu binary?

I wonder exactly which binary it is. What arcitecture (x86 or x86_64)
and what binary. Is it ddynamic or statically linked qemu-system-x86_64?
=20
> Richard: Commit 7db2145a6826b14efceb8dd64bfe6ad8647072eb ("bswap: Add
> host endian unaligned access functions") introduced the unaligned
> memory access functions in question here.  Please see below for
> details on the bug - basically QEMU code assumes they are atomic, but
> that is not guaranteed :(.  Any ideas for how to fix this?
>=20
> Natanael: It seems likely that the qemu package in Alpine Linux
> suffers from a compilation issue resulting in a broken QEMU.  It may
> be necessary to leave the compiler optimization flag alone in APKBUILD
> to work around this problem.
>=20
> Here are the details.  QEMU relies on the compiler turning
> memcpy(&dst, &src, 2) turning into a load instruction in
> include/qemu/bswap.h:lduw_he_p() (explanation below):
>=20
> /* Any compiler worth its salt will turn these memcpy into native unalign=
ed
>    operations.  Thus we don't need to play games with packed attributes, =
or
>    inline byte-by-byte stores.  */
>=20
> static inline int lduw_he_p(const void *ptr)
> {
>     uint16_t r;
>     memcpy(&r, ptr, sizeof(r));
>     return r;
> }
>=20
> Here is the disassembly snippet of virtqueue_pop() from Fedora 29 that
> shows the load instruction:
>=20
>   398166:       0f b7 42 02             movzwl 0x2(%rdx),%eax
>   39816a:       66 89 43 32             mov    %ax,0x32(%rbx)
>=20
> Here is the instruction sequence in the Alpine Linux binary:
>=20
>   455562:    ba 02 00 00 00           mov    $0x2,%edx
>   455567:    e8 74 24 f3 ff           callq  3879e0 <memcpy@plt>
>   45556c:    0f b7 44 24 42           movzwl 0x42(%rsp),%eax
>   455571:    66 41 89 47 32           mov    %ax,0x32(%r15)
>=20
> It's calling memcpy instead of using a load instruction.

I tried to find this section. How do you get the assembly listing of
relevant secion? I tried to do "disas virtio_pop" from
`gdb /usr/bin/qemu-system-x86_64` from the binary in alpine edge. I
could find 2 memcpy but none of them look like a 16 bit operation after:

   0x00000000004551f1 <+353>:   mov    0x10(%rsp),%rdi
   0x00000000004551f6 <+358>:   mov    $0x10,%edx
   0x00000000004551fb <+363>:   callq  0x3879e0 <memcpy@plt>
   0x0000000000455200 <+368>:   movzwl 0x5c(%rsp),%eax
   0x0000000000455205 <+373>:   test   $0x4,%al
   0x0000000000455207 <+375>:   je     0x4552aa <virtqueue_pop+538>

....

   0x0000000000455291 <+513>:   mov    0x10(%rsp),%rdi
   0x0000000000455296 <+518>:   mov    $0x10,%edx
   0x000000000045529b <+523>:   callq  0x3879e0 <memcpy@plt>
   0x00000000004552a0 <+528>:   mov    %rbp,0x20(%rsp)
   0x00000000004552a5 <+533>:   movzwl 0x5c(%rsp),%eax
   0x00000000004552aa <+538>:   lea    0x20e0(%rsp),%rdi
   0x00000000004552b2 <+546>:   xor    %r11d,%r11d
   0x00000000004552b5 <+549>:   mov    %r15,0x38(%rsp)



>=20
> Fernando found that QEMU's virtqueue_pop() function sees bogus values
> when loading a 16-bit guest RAM location.  Paolo figured out that the
> bogus value can be produced by memcpy() when another thread is
> updating the 16-bit memory location simultaneously.  This is a race
> condition between one thread loading the 16-bit value and another
> thread storing it (in this case a guest vcpu thread).  Sometimes
> memcpy() may load one old byte and one new byte, resulting in a bogus
> value.
>=20
> The symptom that Fernando experienced is a "Virtqueue size exceeded"
> error message from QEMU and then the virtio-blk or virtio-scsi device
> stops working.  This issue potentially affects other device emulation
> code in QEMU as well, not just virtio devices.
>=20
> For the time being, I suggest tweaking the APKBUILD so the memcpy() is
> not generated.  Hopefully QEMU can make the code more portable in the
> future so the compiler always does the expected thing, but this may
> not be easily possible.

I was thinking of something in the lines of:

typedef volatile uint16_t __attribute__((__may_alias__)) volatile_uint16_t;
static inline int lduw_he_p(const void *ptr)
{
     volatile_uint16_t r =3D *(volatile_uint16_t*)ptr;
     return r;
}

I can test different CFLAGS with and without the _FORTIFY_SOURCE and
with different variants of memcpy (like __builtint_memcpy etc) but i
need find a way to get the correct assembly output so I know if/when I
have found something that works.

Thanks!

-nc


>=20
> Stefan
