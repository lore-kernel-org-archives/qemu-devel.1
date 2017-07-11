Received: from eggs.gnu.org ([2001:4830:134:3::10]:56750)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dUwwE-0007e6-Ey
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 11:18:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dUww9-0006ts-Fm
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 11:18:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54846)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dUww9-0006tc-6r
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 11:18:53 -0400
References: <20170710204521.2058-1-rth@twiddle.net>
	<20170710204521.2058-3-rth@twiddle.net>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <fc0ca76b-ecee-1f38-166b-4dcd8d7dcd00@redhat.com>
Date: Tue, 11 Jul 2017 17:18:47 +0200
MIME-Version: 1.0
In-Reply-To: <20170710204521.2058-3-rth@twiddle.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 2/8] target/s390x: Implement CONVERT
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
Cc: aurelien@aurel32.net, david@redhat.com

On 10.07.2017 22:45, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <rth@twiddle.net>
> ---
>  target/s390x/helper.h      |   6 +
>  target/s390x/mem_helper.c  | 310 +++++++++++++++++++++++++++++++++++++=
++++++++
>  target/s390x/translate.c   |  43 +++++++
>  target/s390x/insn-data.def |  13 ++
>  4 files changed, 372 insertions(+)
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
[...]
> +static inline uint32_t convert_unicode(CPUS390XState *env, uint32_t r1=
,
> +                                       uint32_t r2, uint32_t m3, uintp=
tr_t ra,
> +                                       decode_unicode_fn decode,
> +                                       encode_unicode_fn encode)
> +{
> +    uint64_t dst =3D get_address(env, r1);
> +    uint64_t dlen =3D get_length(env, r1 + 1);
> +    uint64_t src =3D get_address(env, r2);
> +    uint64_t slen =3D get_length(env, r2 + 1);
> +    bool enh_check =3D m3 & 1;
> +    int cc, i;

According to the PoP:

"The R1 and R2 fields [...] must designate an even-
 numbered register; otherwise, a specification excep-
 tion is recognized."

I think you should add such a check for even-numbered registers here.

> +    /* Lest we fail to service interrupts in a timely manner, limit th=
e
> +       amount of work we're willing to do.  For now, let's cap at 256.=
  */
> +    for (i =3D 0; i < 256; ++i) {
> +        uint32_t c, ilen, olen;
> +
> +        cc =3D decode(env, src, slen, enh_check, ra, &c, &ilen);
> +        if (unlikely(cc >=3D 0)) {
> +            break;
> +        }
> +        cc =3D encode(env, dst, dlen, ra, c, &olen);
> +        if (unlikely(cc >=3D 0)) {
> +            break;
> +        }
> +
> +        src +=3D ilen;
> +        slen -=3D ilen;
> +        dst +=3D olen;
> +        dlen -=3D olen;
> +        cc =3D 3;
> +    }
> +
> +    set_address(env, r1, dst);
> +    set_length(env, r1 + 1, dlen);
> +    set_address(env, r2, src);
> +    set_length(env, r2 + 1, slen);
> +
> +    return cc;
> +}

 Thomas
