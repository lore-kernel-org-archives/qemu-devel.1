Received: from eggs.gnu.org ([2001:4830:134:3::10]:59501)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dVBQ9-0001jw-U6
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 02:46:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dVBQ6-0005SC-Qp
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 02:46:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44712)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dVBQ6-0005RG-Hi
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 02:46:46 -0400
References: <fc0ca76b-ecee-1f38-166b-4dcd8d7dcd00@redhat.com>
	<20170711182351.22956-1-rth@twiddle.net>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <9fbef29b-9a42-91a9-eda5-47e2a397963f@redhat.com>
Date: Wed, 12 Jul 2017 08:46:41 +0200
MIME-Version: 1.0
In-Reply-To: <20170711182351.22956-1-rth@twiddle.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3.5 2/8] target/s390x: Implement CONVERT
 UNICODE insns
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org

On 11.07.2017 20:23, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <rth@twiddle.net>
> ---
> v3.5: Added even register checks in the translator [thuth].
> ---
>  target/s390x/helper.h      |   6 +
>  target/s390x/mem_helper.c  | 310 +++++++++++++++++++++++++++++++++++++=
++++++++
>  target/s390x/translate.c   |  51 ++++++++
>  target/s390x/insn-data.def |  13 ++
>  4 files changed, 380 insertions(+)
>=20
> diff --git a/target/s390x/helper.h b/target/s390x/helper.h
> index 23e8d1d..2793cf3 100644
> --- a/target/s390x/helper.h
> +++ b/target/s390x/helper.h
> @@ -107,6 +107,12 @@ DEF_HELPER_2(stfle, i32, env, i64)
>  DEF_HELPER_FLAGS_2(lpq, TCG_CALL_NO_WG, i64, env, i64)
>  DEF_HELPER_FLAGS_4(stpq, TCG_CALL_NO_WG, void, env, i64, i64, i64)
>  DEF_HELPER_4(mvcos, i32, env, i64, i64, i64)
> +DEF_HELPER_4(cu12, i32, env, i32, i32, i32)
> +DEF_HELPER_4(cu14, i32, env, i32, i32, i32)
> +DEF_HELPER_4(cu21, i32, env, i32, i32, i32)
> +DEF_HELPER_4(cu24, i32, env, i32, i32, i32)
> +DEF_HELPER_4(cu41, i32, env, i32, i32, i32)
> +DEF_HELPER_4(cu42, i32, env, i32, i32, i32)
> =20
>  #ifndef CONFIG_USER_ONLY
>  DEF_HELPER_3(servc, i32, env, i64, i64)
> diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
> index 513b402..0b18560 100644
> --- a/target/s390x/mem_helper.c
> +++ b/target/s390x/mem_helper.c
> @@ -2196,3 +2196,313 @@ uint32_t HELPER(mvcos)(CPUS390XState *env, uint=
64_t dest, uint64_t src,
> =20
>      return cc;
>  }
> +
> +/* Decode a Unicode character.  A return value < 0 indicates success, =
storing
> +   the UTF-32 result into OCHAR and the input length into OLEN.  A ret=
urn
> +   value >=3D 0 indicates failure, and the CC value to be returned.  *=
/
> +typedef int (*decode_unicode_fn)(CPUS390XState *env, uint64_t addr,
> +                                 uint64_t ilen, bool enh_check, uintpt=
r_t ra,
> +                                 uint32_t *ochar, uint32_t *olen);
> +
> +/* Encode a Unicode character.  A return value < 0 indicates success, =
storing
> +   the bytes into ADDR and the output length into OLEN.  A return valu=
e >=3D 0
> +   indicates failure, and the CC value to be returned.  */
> +typedef int (*encode_unicode_fn)(CPUS390XState *env, uint64_t addr,
> +                                 uint64_t ilen, uintptr_t ra, uint32_t=
 c,
> +                                 uint32_t *olen);
> +
> +static int decode_utf8(CPUS390XState *env, uint64_t addr, uint64_t ile=
n,
> +                       bool enh_check, uintptr_t ra,
> +                       uint32_t *ochar, uint32_t *olen)
> +{
> +    uint8_t s0, s1, s2, s3;
> +    uint32_t c, l;
> +
> +    if (ilen < 1) {
> +        return 0;
> +    }
> +    s0 =3D cpu_ldub_data_ra(env, addr, ra);
> +    if (s0 <=3D 0x7f) {
> +        /* one byte character */
> +        l =3D 1;
> +        c =3D s0;
> +    } else if (s0 <=3D (enh_check ? 0xc1 : 0xbf)) {
> +        /* invalid character */
> +        return 2;
> +    } else if (s0 <=3D 0xdf) {
> +        /* two byte character */
> +        l =3D 2;
> +        if (ilen < 2) {
> +            return 0;
> +        }
> +        s1 =3D cpu_ldub_data_ra(env, addr + 1, ra);
> +        c =3D s0 & 0x1f;
> +        c =3D (c << 6) | (s1 & 0x3f);
> +        if (enh_check && (s1 & 0xc0) !=3D 0x80) {
> +            return 2;
> +        }
> +    } else if (s0 <=3D 0xef) {
> +        /* three byte character */
> +        l =3D 3;
> +        if (ilen < 3) {
> +            return 0;
> +        }
> +        s1 =3D cpu_ldub_data_ra(env, addr + 1, ra);
> +        s2 =3D cpu_ldub_data_ra(env, addr + 2, ra);
> +        c =3D s0 & 0x0f;
> +        c =3D (c << 6) | (s1 & 0x3f);
> +        c =3D (c << 6) | (s2 & 0x3f);
> +        /* Fold the byte-by-byte range descriptions in the PoO into
> +           tests against the complete value.  It disallows encodings
> +           that could be smaller, and the UTF-16 surrogates.  */
> +        if (enh_check
> +            && ((s1 & 0xc0) !=3D 0x80
> +                || (s2 & 0xc0) !=3D 0x80
> +                || c < 0x1000
> +                || (c >=3D 0xd800 && c <=3D 0xdfff))) {
> +            return 2;
> +        }
> +    } else if (s0 <=3D (enh_check ? 0xf4 : 0xf7)) {
> +        /* four byte character */
> +        l =3D 4;
> +        if (ilen < 4) {
> +            return 0;
> +        }
> +        s1 =3D cpu_ldub_data_ra(env, addr + 1, ra);
> +        s2 =3D cpu_ldub_data_ra(env, addr + 2, ra);
> +        s3 =3D cpu_ldub_data_ra(env, addr + 3, ra);
> +        c =3D s0 & 0x0f;

I think you could also use 0x07 instead of 0x0f here. Shouldn't matter
much due to the s0 <=3D 0xf7 check above, though.

> +        c =3D (c << 6) | (s1 & 0x3f);
> +        c =3D (c << 6) | (s2 & 0x3f);
> +        c =3D (c << 6) | (s3 & 0x3f);
> +        /* See above.  */
> +        if (enh_check
> +            && ((s1 & 0xc0) !=3D 0x80
> +                || (s2 & 0xc0) !=3D 0x80
> +                || (s3 & 0xc0) !=3D 0x80
> +                || c < 0x010000
> +                || c > 0x10ffff)) {
> +            return 2;
> +        }
> +    } else {
> +        /* invalid character */
> +        return 2;
> +    }
> +
> +    *ochar =3D c;
> +    *olen =3D l;
> +    return -1;
> +}
[...]

Patch looks fine to me now!

Reviewed-by: Thomas Huth <thuth@redhat.com>
