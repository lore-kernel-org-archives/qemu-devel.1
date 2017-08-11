Received: from eggs.gnu.org ([2001:4830:134:3::10]:35068)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dgAsg-0001iC-5G
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 10:25:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dgAse-0002wm-VD
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 10:25:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50296)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dgAse-0002vs-DR
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 10:25:40 -0400
References: <20170811140628.31935-1-f4bug@amsat.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <bd1e9b06-56fd-fed0-e19b-c8a0c036c58c@redhat.com>
Date: Fri, 11 Aug 2017 16:25:36 +0200
MIME-Version: 1.0
In-Reply-To: <20170811140628.31935-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH] memory: fix
 access_with_adjusted_size() on big-endian
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>, KONRAD Frederic <frederic.konrad@adacore.com>, Peter Crosthwaite <crosthwaitepeter@gmail.com>
Cc: qemu-devel@nongnu.org

On 11/08/2017 16:06, Philippe Mathieu-Daud=C3=A9 wrote:
> remove unnecessary memory_region_big_endian()

Can you explain why it's unnecessary?...

Paolo

> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
> This is part of a branch with many cross-endianness tests for 2.11
>=20
> Frederic does it helps your issues on armeb?
>=20
>  memory.c | 28 ++++++++++------------------
>  1 file changed, 10 insertions(+), 18 deletions(-)
>=20
> diff --git a/memory.c b/memory.c
> index c0adc35410..600f5d5b1a 100644
> --- a/memory.c
> +++ b/memory.c
> @@ -338,15 +338,6 @@ static void flatview_simplify(FlatView *view)
>      }
>  }
> =20
> -static bool memory_region_big_endian(MemoryRegion *mr)
> -{
> -#ifdef TARGET_WORDS_BIGENDIAN
> -    return mr->ops->endianness !=3D DEVICE_LITTLE_ENDIAN;
> -#else
> -    return mr->ops->endianness =3D=3D DEVICE_BIG_ENDIAN;
> -#endif
> -}
> -
>  static bool memory_region_wrong_endianness(MemoryRegion *mr)
>  {
>  #ifdef TARGET_WORDS_BIGENDIAN
> @@ -572,7 +563,8 @@ static MemTxResult access_with_adjusted_size(hwaddr=
 addr,
>  {
>      uint64_t access_mask;
>      unsigned access_size;
> -    unsigned i;
> +    hwaddr access_addr;
> +    unsigned offset;
>      MemTxResult r =3D MEMTX_OK;
> =20
>      if (!access_size_min) {
> @@ -585,17 +577,17 @@ static MemTxResult access_with_adjusted_size(hwad=
dr addr,
>      /* FIXME: support unaligned access? */
>      access_size =3D MAX(MIN(size, access_size_max), access_size_min);
>      access_mask =3D -1ULL >> (64 - access_size * 8);
> -    if (memory_region_big_endian(mr)) {
> -        for (i =3D 0; i < size; i +=3D access_size) {
> -            r |=3D access(mr, addr + i, value, access_size,
> -                        (size - access_size - i) * 8, access_mask, att=
rs);
> +    access_addr =3D addr & ~(access_size - 1);
> +    if (access_size < size) {
> +        for (offset =3D 0; offset < size; offset +=3D access_size) {
> +            r |=3D access(mr, access_addr + offset, value, access_size=
,
> +                        offset * 8, access_mask, attrs);
>          }
>      } else {
> -        for (i =3D 0; i < size; i +=3D access_size) {
> -            r |=3D access(mr, addr + i, value, access_size, i * 8,
> -                        access_mask, attrs);
> -        }
> +        r =3D access(mr, access_addr, value, access_size,
> +                    0, access_mask, attrs);
>      }
> +
>      return r;
>  }
> =20
>=20
