Received: from eggs.gnu.org ([2001:4830:134:3::10]:44558)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1emSbj-0008O0-Eq
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 18:06:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1emSbi-0003fO-IR
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 18:06:27 -0500
Received: from mail-lf0-x242.google.com ([2a00:1450:4010:c07::242]:35002)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1emSbi-0003f8-Ai
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 18:06:26 -0500
Received: by mail-lf0-x242.google.com with SMTP id a204so1792784lfa.2
	for <qemu-devel@nongnu.org>; Thu, 15 Feb 2018 15:06:26 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <d131e24b911653a945e46ca2d8f90f572469e1dd.1517856214.git.alistair.francis@xilinx.com>
References: <d131e24b911653a945e46ca2d8f90f572469e1dd.1517856214.git.alistair.francis@xilinx.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 15 Feb 2018 15:05:54 -0800
Message-ID: <CAKmqyKOw-bced1cbcvJmJE_WM1_W5cEScOf8U+CaD3o9uyuXaw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/1] hw: register: Run post_write hook
 on reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>

On Mon, Feb 5, 2018 at 10:44 AM, Alistair Francis
<alistair.francis@xilinx.com> wrote:
> Ensure that the post write hook is called during reset. This allows us
> to rely on the post write functions instead of having to call them from
> the reset() function.
>
> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Ping!

> ---
>
> V2:
>  - Update the header documentation
>
>  include/hw/register.h | 6 +++---
>  hw/core/register.c    | 8 ++++++++
>  2 files changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/include/hw/register.h b/include/hw/register.h
> index de2414e6b4..5796584588 100644
> --- a/include/hw/register.h
> +++ b/include/hw/register.h
> @@ -34,7 +34,7 @@ typedef struct RegisterInfoArray RegisterInfoArray;
>   * immediately before the actual write. The returned value is what is wr=
itten,
>   * giving the handler a chance to modify the written value.
>   * @post_write: Post write callback. Passed the written value. Most writ=
e side
> - * effects should be implemented here.
> + * effects should be implemented here. This is called during device rese=
t.
>   *
>   * @post_read: Post read callback. Passes the value that is about to be =
returned
>   * for a read. The return value from this function is what is ultimately=
 read,
> @@ -135,8 +135,8 @@ uint64_t register_read(RegisterInfo *reg, uint64_t re=
, const char* prefix,
>                         bool debug);
>
>  /**
> - * reset a register
> - * @reg: register to reset
> + * Resets a register. This will also call the post_write hook if it exis=
ts.
> + * @reg: The register to reset.
>   */
>
>  void register_reset(RegisterInfo *reg);
> diff --git a/hw/core/register.c b/hw/core/register.c
> index 900294b9c4..0741a1af32 100644
> --- a/hw/core/register.c
> +++ b/hw/core/register.c
> @@ -159,13 +159,21 @@ uint64_t register_read(RegisterInfo *reg, uint64_t =
re, const char* prefix,
>
>  void register_reset(RegisterInfo *reg)
>  {
> +    const RegisterAccessInfo *ac;
> +
>      g_assert(reg);
>
>      if (!reg->data || !reg->access) {
>          return;
>      }
>
> +    ac =3D reg->access;
> +
>      register_write_val(reg, reg->access->reset);
> +
> +    if (ac->post_write) {
> +        ac->post_write(reg, reg->access->reset);
> +    }
>  }
>
>  void register_init(RegisterInfo *reg)
> --
> 2.14.1
>
