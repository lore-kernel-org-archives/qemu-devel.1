Received: from eggs.gnu.org ([2001:4830:134:3::10]:38389)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1douyv-0000ux-F7
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 13:16:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1douyq-0005zs-MS
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 13:16:17 -0400
Received: from mail-io0-x241.google.com ([2607:f8b0:4001:c06::241]:37281)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1douyq-0005zS-Fk
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 13:16:12 -0400
Received: by mail-io0-x241.google.com with SMTP id i200so537013ioa.4
	for <qemu-devel@nongnu.org>; Mon, 04 Sep 2017 10:16:12 -0700 (PDT)
MIME-Version: 1.0
Sender: philippe.mathieu.daude@gmail.com
In-Reply-To: <20170904164659.26915-1-n54@gmx.com>
References: <20170903163130.14288-1-n54@gmx.com>
	<20170904164659.26915-1-n54@gmx.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 4 Sep 2017 14:16:10 -0300
Message-ID: <CAAdtpL7zpZr1XMZwc0f9MKGKYgkm3w3S0L94KnsGjgD7YyUjqA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] target/m68k: Switch fpu_rom from
 make_floatx80() to make_floatx80_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kamil Rytarowski <n54@gmx.com>
Cc: Laurent Vivier <laurent@vivier.eu>, Peter Maydell <peter.maydell@linaro.org>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On Mon, Sep 4, 2017 at 1:46 PM, Kamil Rytarowski <n54@gmx.com> wrote:
> GCC 4.7.2 on SunOS reports that the values assigned to array members are =
not
> real constants:
>
> target/m68k/fpu_helper.c:32:5: error: initializer element is not constant
> target/m68k/fpu_helper.c:32:5: error: (near initialization for 'fpu_rom[0=
]')
> rules.mak:66: recipe for target 'target/m68k/fpu_helper.o' failed
>
> Convert the array to make_floatx80_init() to fix it.
> Replace floatx80_pi-like constants with make_floatx80_init() as they are
> defined as make_floatx80().
>
> This fixes build on SmartOS (Joyent).
>
> Signed-off-by: Kamil Rytarowski <n54@gmx.com>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

> ---
>  target/m68k/fpu_helper.c | 44 ++++++++++++++++++++++--------------------=
--
>  1 file changed, 22 insertions(+), 22 deletions(-)
>
> diff --git a/target/m68k/fpu_helper.c b/target/m68k/fpu_helper.c
> index bdfc537c68..8afd319ede 100644
> --- a/target/m68k/fpu_helper.c
> +++ b/target/m68k/fpu_helper.c
> @@ -29,28 +29,28 @@
>   */
>
>  static const floatx80 fpu_rom[128] =3D {
> -    [0x00] =3D floatx80_pi,                                   /* Pi */
> -    [0x0b] =3D make_floatx80(0x3ffd, 0x9a209a84fbcff798ULL),  /* Log10(2=
) */
> -    [0x0c] =3D make_floatx80(0x4000, 0xadf85458a2bb4a9aULL),  /* e      =
  */
> -    [0x0d] =3D make_floatx80(0x3fff, 0xb8aa3b295c17f0bcULL),  /* Log2(e)=
  */
> -    [0x0e] =3D make_floatx80(0x3ffd, 0xde5bd8a937287195ULL),  /* Log10(e=
) */
> -    [0x0f] =3D floatx80_zero,                                 /* Zero   =
  */
> -    [0x30] =3D floatx80_ln2,                                  /* ln(2)  =
  */
> -    [0x31] =3D make_floatx80(0x4000, 0x935d8dddaaa8ac17ULL),  /* ln(10) =
  */
> -    [0x32] =3D floatx80_one,                                  /* 10^0   =
  */
> -    [0x33] =3D make_floatx80(0x4002, 0xa000000000000000ULL),  /* 10^1   =
  */
> -    [0x34] =3D make_floatx80(0x4005, 0xc800000000000000ULL),  /* 10^2   =
  */
> -    [0x35] =3D make_floatx80(0x400c, 0x9c40000000000000ULL),  /* 10^4   =
  */
> -    [0x36] =3D make_floatx80(0x4019, 0xbebc200000000000ULL),  /* 10^8   =
  */
> -    [0x37] =3D make_floatx80(0x4034, 0x8e1bc9bf04000000ULL),  /* 10^16  =
  */
> -    [0x38] =3D make_floatx80(0x4069, 0x9dc5ada82b70b59eULL),  /* 10^32  =
  */
> -    [0x39] =3D make_floatx80(0x40d3, 0xc2781f49ffcfa6d5ULL),  /* 10^64  =
  */
> -    [0x3a] =3D make_floatx80(0x41a8, 0x93ba47c980e98ce0ULL),  /* 10^128 =
  */
> -    [0x3b] =3D make_floatx80(0x4351, 0xaa7eebfb9df9de8eULL),  /* 10^256 =
  */
> -    [0x3c] =3D make_floatx80(0x46a3, 0xe319a0aea60e91c7ULL),  /* 10^512 =
  */
> -    [0x3d] =3D make_floatx80(0x4d48, 0xc976758681750c17ULL),  /* 10^1024=
  */
> -    [0x3e] =3D make_floatx80(0x5a92, 0x9e8b3b5dc53d5de5ULL),  /* 10^2048=
  */
> -    [0x3f] =3D make_floatx80(0x7525, 0xc46052028a20979bULL),  /* 10^4096=
  */
> +    [0x00] =3D make_floatx80_init(0x4000, 0x0c90fdaa22168c235LL),  /* Pi=
       */
> +    [0x0b] =3D make_floatx80_init(0x3ffd, 0x9a209a84fbcff798ULL),  /* Lo=
g10(2) */
> +    [0x0c] =3D make_floatx80_init(0x4000, 0xadf85458a2bb4a9aULL),  /* e =
       */
> +    [0x0d] =3D make_floatx80_init(0x3fff, 0xb8aa3b295c17f0bcULL),  /* Lo=
g2(e)  */
> +    [0x0e] =3D make_floatx80_init(0x3ffd, 0xde5bd8a937287195ULL),  /* Lo=
g10(e) */
> +    [0x0f] =3D make_floatx80_init(0x0000, 0x00000000000000000LL),  /* Ze=
ro     */
> +    [0x30] =3D make_floatx80_init(0x3ffe, 0x0b17217f7d1cf79acLL),  /* ln=
(2)    */
> +    [0x31] =3D make_floatx80_init(0x4000, 0x935d8dddaaa8ac17ULL),  /* ln=
(10)   */
> +    [0x32] =3D make_floatx80_init(0x3fff, 0x08000000000000000LL),  /* 10=
^0     */
> +    [0x33] =3D make_floatx80_init(0x4002, 0xa000000000000000ULL),  /* 10=
^1     */
> +    [0x34] =3D make_floatx80_init(0x4005, 0xc800000000000000ULL),  /* 10=
^2     */
> +    [0x35] =3D make_floatx80_init(0x400c, 0x9c40000000000000ULL),  /* 10=
^4     */
> +    [0x36] =3D make_floatx80_init(0x4019, 0xbebc200000000000ULL),  /* 10=
^8     */
> +    [0x37] =3D make_floatx80_init(0x4034, 0x8e1bc9bf04000000ULL),  /* 10=
^16    */
> +    [0x38] =3D make_floatx80_init(0x4069, 0x9dc5ada82b70b59eULL),  /* 10=
^32    */
> +    [0x39] =3D make_floatx80_init(0x40d3, 0xc2781f49ffcfa6d5ULL),  /* 10=
^64    */
> +    [0x3a] =3D make_floatx80_init(0x41a8, 0x93ba47c980e98ce0ULL),  /* 10=
^128   */
> +    [0x3b] =3D make_floatx80_init(0x4351, 0xaa7eebfb9df9de8eULL),  /* 10=
^256   */
> +    [0x3c] =3D make_floatx80_init(0x46a3, 0xe319a0aea60e91c7ULL),  /* 10=
^512   */
> +    [0x3d] =3D make_floatx80_init(0x4d48, 0xc976758681750c17ULL),  /* 10=
^1024  */
> +    [0x3e] =3D make_floatx80_init(0x5a92, 0x9e8b3b5dc53d5de5ULL),  /* 10=
^2048  */
> +    [0x3f] =3D make_floatx80_init(0x7525, 0xc46052028a20979bULL),  /* 10=
^4096  */
>  };
>
>  int32_t HELPER(reds32)(CPUM68KState *env, FPReg *val)
> --
> 2.14.1
>
>
