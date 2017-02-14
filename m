Received: from eggs.gnu.org ([2001:4830:134:3::10]:48209)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1cdRo9-00058r-PI
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 20:21:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1cdRo8-0001Lj-LN
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 20:21:29 -0500
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <20170211034332.12498-1-f4bug@amsat.org>
References: <CAKmqyKMYmNeOOogS4+yv14M2CWTbBNtBP0jnO0DQEuScSp8eYw@mail.gmail.com>
	<20170211034332.12498-1-f4bug@amsat.org>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Mon, 13 Feb 2017 17:20:54 -0800
Message-ID: <CAKmqyKPcfAb-ZnnLVR+z72-LY4m1XvZf_kJ_t0974KCijzZDvA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] register: fix incorrect read mask
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>, QEMU Trivial <qemu-trivial@nongnu.org>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On Fri, Feb 10, 2017 at 7:43 PM, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg> wrote:
> The register_read() function expects a bitmask argument. To avoid duplica=
ted

The register_read() and register_write() functions

> code, a new inlined function register_enabled_mask() is introduced.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>

Thanks,

Alistair

> ---
>  v2: squashed together both previous commits as suggested by Francis Alis=
tair.
>
>  hw/core/register.c | 21 +++++++++++++++------
>  1 file changed, 15 insertions(+), 6 deletions(-)
>
> diff --git a/hw/core/register.c b/hw/core/register.c
> index 4bfbc508de..482e3f827a 100644
> --- a/hw/core/register.c
> +++ b/hw/core/register.c
> @@ -59,6 +59,15 @@ static inline uint64_t register_read_val(RegisterInfo =
*reg)
>      return 0; /* unreachable */
>  }
>
> +static inline uint64_t register_enabled_mask(int data_size, unsigned siz=
e)
> +{
> +    if (data_size < size) {
> +        size =3D data_size;
> +    }
> +
> +    return MAKE_64BIT_MASK(0, size * 8);
> +}
> +
>  void register_write(RegisterInfo *reg, uint64_t val, uint64_t we,
>                      const char *prefix, bool debug)
>  {
> @@ -192,11 +201,7 @@ void register_write_memory(void *opaque, hwaddr addr=
,
>      }
>
>      /* Generate appropriate write enable mask */
> -    if (reg->data_size < size) {
> -        we =3D MAKE_64BIT_MASK(0, reg->data_size * 8);
> -    } else {
> -        we =3D MAKE_64BIT_MASK(0, size * 8);
> -    }
> +    we =3D register_enabled_mask(reg->data_size, size);
>
>      register_write(reg, value, we, reg_array->prefix,
>                     reg_array->debug);
> @@ -208,6 +213,7 @@ uint64_t register_read_memory(void *opaque, hwaddr ad=
dr,
>      RegisterInfoArray *reg_array =3D opaque;
>      RegisterInfo *reg =3D NULL;
>      uint64_t read_val;
> +    uint64_t re;
>      int i;
>
>      for (i =3D 0; i < reg_array->num_elements; i++) {
> @@ -223,7 +229,10 @@ uint64_t register_read_memory(void *opaque, hwaddr a=
ddr,
>          return 0;
>      }
>
> -    read_val =3D register_read(reg, size * 8, reg_array->prefix,
> +    /* Generate appropriate read enable mask */
> +    re =3D register_enabled_mask(reg->data_size, size);
> +
> +    read_val =3D register_read(reg, re, reg_array->prefix,
>                               reg_array->debug);
>
>      return extract64(read_val, 0, size * 8);
> --
> 2.11.0
>
>
