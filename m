Received: from eggs.gnu.org ([209.51.188.92]:35028)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gyDXR-0002i0-5N
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 05:31:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gyDXP-00043r-Qk
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 05:31:09 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:39502)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1gyDXP-0003Tn-ES
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 05:31:07 -0500
Received: by mail-wm1-x342.google.com with SMTP id z84so7488847wmg.4
	for <qemu-devel@nongnu.org>; Mon, 25 Feb 2019 02:30:57 -0800 (PST)
MIME-Version: 1.0
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
	<20190223165523.1d674224@ncopa-desktop.copa.dup.pw>
In-Reply-To: <20190223165523.1d674224@ncopa-desktop.copa.dup.pw>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 25 Feb 2019 10:30:44 +0000
Message-ID: <CAJSP0QUndr5i5iu3tha8W4_4X763--9+V3tR_QUq5ZmtSO1-rA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Natanael Copa <ncopa@alpinelinux.org>
Cc: =?UTF-8?Q?Fernando_Casas_Sch=C3=B6ssow?= <casasfernando@outlook.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, qemu-devel <qemu-devel@nongnu.org>

On Sat, Feb 23, 2019 at 3:55 PM Natanael Copa <ncopa@alpinelinux.org> wrote=
:
> On Fri, 22 Feb 2019 14:04:20 +0000
> Stefan Hajnoczi <stefanha@gmail.com> wrote:
> > On Fri, Feb 22, 2019 at 12:57 PM Fernando Casas Sch=C3=B6ssow
> > <casasfernando@outlook.com> wrote:
> I tried to find this section. How do you get the assembly listing of
> relevant secion? I tried to do "disas virtio_pop" from
> `gdb /usr/bin/qemu-system-x86_64` from the binary in alpine edge. I
> could find 2 memcpy but none of them look like a 16 bit operation after:
>
>    0x00000000004551f1 <+353>:   mov    0x10(%rsp),%rdi
>    0x00000000004551f6 <+358>:   mov    $0x10,%edx
>    0x00000000004551fb <+363>:   callq  0x3879e0 <memcpy@plt>
>    0x0000000000455200 <+368>:   movzwl 0x5c(%rsp),%eax
>    0x0000000000455205 <+373>:   test   $0x4,%al
>    0x0000000000455207 <+375>:   je     0x4552aa <virtqueue_pop+538>
>
> ....
>
>    0x0000000000455291 <+513>:   mov    0x10(%rsp),%rdi
>    0x0000000000455296 <+518>:   mov    $0x10,%edx
>    0x000000000045529b <+523>:   callq  0x3879e0 <memcpy@plt>
>    0x00000000004552a0 <+528>:   mov    %rbp,0x20(%rsp)
>    0x00000000004552a5 <+533>:   movzwl 0x5c(%rsp),%eax
>    0x00000000004552aa <+538>:   lea    0x20e0(%rsp),%rdi
>    0x00000000004552b2 <+546>:   xor    %r11d,%r11d
>    0x00000000004552b5 <+549>:   mov    %r15,0x38(%rsp)

Here is the beginning of the function:

0000000000455090 <virtqueue_pop@@Base>:
  455090:    41 57                    push   %r15
  455092:    49 89 ff                 mov    %rdi,%r15
  455095:    b9 0e 00 00 00           mov    $0xe,%ecx
  45509a:    41 56                    push   %r14
  45509c:    41 55                    push   %r13
  45509e:    41 54                    push   %r12
  4550a0:    55                       push   %rbp
  4550a1:    53                       push   %rbx
  4550a2:    48 81 ec f8 60 00 00     sub    $0x60f8,%rsp
  4550a9:    4d 8b 67 58              mov    0x58(%r15),%r12
  4550ad:    48 89 74 24 08           mov    %rsi,0x8(%rsp)
  4550b2:    48 8d 6c 24 70           lea    0x70(%rsp),%rbp
  4550b7:    48 89 ef                 mov    %rbp,%rdi
  4550ba:    64 48 8b 04 25 28 00     mov    %fs:0x28,%rax
  4550c1:    00 00
  4550c3:    48 89 84 24 e8 60 00     mov    %rax,0x60e8(%rsp)
  4550ca:    00
  4550cb:    31 c0                    xor    %eax,%eax
  4550cd:    41 80 bc 24 6b 01 00     cmpb   $0x0,0x16b(%r12)
  4550d4:    00 00
  4550d6:    f3 48 ab                 rep stos %rax,%es:(%rdi)
  4550d9:    0f 85 c1 04 00 00        jne    4555a0 <virtqueue_pop@@Base+0x=
510>
  4550df:    48 8b 1d f2 4e 99 00     mov    0x994ef2(%rip),%rbx
 # de9fd8 <rcu_reader@@Base+0xde9f20>
  4550e6:    64 8b 43 0c              mov    %fs:0xc(%rbx),%eax
  4550ea:    8d 50 01                 lea    0x1(%rax),%edx
  4550ed:    64 89 53 0c              mov    %edx,%fs:0xc(%rbx)
  4550f1:    85 c0                    test   %eax,%eax
  4550f3:    0f 84 d7 03 00 00        je     4554d0 <virtqueue_pop@@Base+0x=
440>
  4550f9:    49 83 7f 18 00           cmpq   $0x0,0x18(%r15)
  4550fe:    0f 84 7d 03 00 00        je     455481 <virtqueue_pop@@Base+0x=
3f1>
  455104:    41 0f b7 47 30           movzwl 0x30(%r15),%eax
  455109:    66 41 39 47 32           cmp    %ax,0x32(%r15)
  45510e:    0f 84 0c 04 00 00        je     455520 <virtqueue_pop@@Base+0x=
490>

This last branch leads to:

  455520:    4c 89 ff                 mov    %r15,%rdi
  455523:    e8 78 b4 ff ff           callq  4509a0
<virtio_queue_host_notifier_read@@Base+0x6d0>
  455528:    48 83 b8 90 00 00 00     cmpq   $0x3,0x90(%rax)
  45552f:    03
  455530:    0f 86 98 03 00 00        jbe    4558ce <virtqueue_pop@@Base+0x=
83e>
  455536:    48 8b 90 80 00 00 00     mov    0x80(%rax),%rdx
  45553d:    48 85 d2                 test   %rdx,%rdx
  455540:    0f 84 c2 02 00 00        je     455808 <virtqueue_pop@@Base+0x=
778>
  455546:    48 8d 72 02              lea    0x2(%rdx),%rsi
  45554a:    48 8d 7c 24 42           lea    0x42(%rsp),%rdi
  45554f:    48 39 fe                 cmp    %rdi,%rsi
  455552:    76 09                    jbe    45555d <virtqueue_pop@@Base+0x=
4cd>
  455554:    48 8d 47 02              lea    0x2(%rdi),%rax
  455558:    48 39 c6                 cmp    %rax,%rsi
  45555b:    72 3c                    jb     455599 <virtqueue_pop@@Base+0x=
509>
  45555d:    48 39 fe                 cmp    %rdi,%rsi
  455560:    72 2e                    jb     455590 <virtqueue_pop@@Base+0x=
500>
  455562:    ba 02 00 00 00           mov    $0x2,%edx
  455567:    e8 74 24 f3 ff           callq  3879e0 <memcpy@plt>

> I can test different CFLAGS with and without the _FORTIFY_SOURCE and
> with different variants of memcpy (like __builtint_memcpy etc) but i
> need find a way to get the correct assembly output so I know if/when I
> have found something that works.

Good.  I think tweaking the compilation flags is the quickest
workaround to produce a working QEMU binary for Alpine.  Other distros
don't seem to hit this problem.

In the longer term QEMU will need to fix these memory accessor
functions in the way that Peter described, but doing that properly
requires auditing all the code so each instance that relies on
atomicity can be converted properly (and the other ones will stay
non-atomic because they must support misaligned addresses).

Stefan
