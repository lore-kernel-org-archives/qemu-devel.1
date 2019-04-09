Received: from eggs.gnu.org ([209.51.188.92]:41290)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1hDu9K-0000IV-6A
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 13:03:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1hDu9J-0003lx-9b
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 13:03:06 -0400
References: <20190409060435.22801-1-sw@weilnetz.de>
	<4a16a810-9806-3a76-7d17-1b6282296502@linaro.org>
From: Stefan Weil <sw@weilnetz.de>
Message-ID: <69be6fec-e9b5-d72b-d626-cf3d4b9f3720@weilnetz.de>
Date: Tue, 9 Apr 2019 18:53:15 +0200
MIME-Version: 1.0
In-Reply-To: <4a16a810-9806-3a76-7d17-1b6282296502@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] tci: Fix some unaligned memory accesses
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>

On 09.04.19 08:58, Richard Henderson wrote:
> On 4/8/19 8:04 PM, Stefan Weil wrote:
>>  static tcg_target_ulong tci_read_i(uint8_t **tb_ptr)
>>  {
>> -    tcg_target_ulong value =3D *(tcg_target_ulong *)(*tb_ptr);
>> +    tcg_target_ulong value;
>=20
> Ideally these would use the helpers from "qemu/bswap.h", ldl_he_p(), et=
c.
>=20
> r~



That would require adding a helper for tcg_target_ulong to qemu/bswap.h.
Or tci.c would need conditional code for reading a tcg_target_ulong.

Those helpers in qemu/bswap.h are also a little bit strange:

- Why does lduw_he_p return an int instead of an uint16_t?
- Why does ldsw_he_p return an int instead of an int16_t?
- Why does ldl_he_p return an int instead of an int32_t?
- Should ldl_he_p be renamed into ldsl_he_p?
  And why is ldul_he_p missing?
- Should ldq_he_p be renamed into lduq_he_p?
  And why is ldsq_he_p missing?

Using the helpers might require nasty type casts to avoid compiler
warnings because of signed / unsigned and size mismatches.

Aren't the few memcpy statements in the TCI helpers much more direct and
understandable?

Regards
Stefan
