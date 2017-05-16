Received: from eggs.gnu.org ([2001:4830:134:3::10]:35427)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dAcjy-0001op-Cz
	for qemu-devel@nongnu.org; Tue, 16 May 2017 09:42:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dAcjx-0006oP-BV
	for qemu-devel@nongnu.org; Tue, 16 May 2017 09:42:18 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:41612)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dAcjx-0006nW-5H
	for qemu-devel@nongnu.org; Tue, 16 May 2017 09:42:17 -0400
Date: Tue, 16 May 2017 15:42:02 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
Message-ID: <20170516134202.boib4gasiq5itt56@aurel32.net>
References: <1494926884-10118-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1494926884-10118-1-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v1] target/s390x: Add support for the TEST
 BLOCK instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, mmarek@suse.com, mbenes@suse.cz, David Hildenbrand <david@redhat.com>

On 2017-05-16 11:28, Thomas Huth wrote:
> TEST BLOCK was likely once used to execute basic memory
> tests, but nowadays it's just a (slow) way to clear a page.
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  target/s390x/helper.h      |  1 +
>  target/s390x/insn-data.def |  2 ++
>  target/s390x/mem_helper.c  | 12 ++++++++++++
>  target/s390x/translate.c   | 10 ++++++++++
>  4 files changed, 25 insertions(+)
>=20
> diff --git a/target/s390x/helper.h b/target/s390x/helper.h
> index 9102071..a5a3705 100644
> --- a/target/s390x/helper.h
> +++ b/target/s390x/helper.h
> @@ -99,6 +99,7 @@ DEF_HELPER_FLAGS_4(lctl, TCG_CALL_NO_WG, void, env, i32=
, i64, i32)
>  DEF_HELPER_FLAGS_4(lctlg, TCG_CALL_NO_WG, void, env, i32, i64, i32)
>  DEF_HELPER_FLAGS_4(stctl, TCG_CALL_NO_WG, void, env, i32, i64, i32)
>  DEF_HELPER_FLAGS_4(stctg, TCG_CALL_NO_WG, void, env, i32, i64, i32)
> +DEF_HELPER_2(testblock, void, env, i64)
>  DEF_HELPER_FLAGS_2(tprot, TCG_CALL_NO_RWG, i32, i64, i64)
>  DEF_HELPER_FLAGS_2(iske, TCG_CALL_NO_RWG_SE, i64, env, i64)
>  DEF_HELPER_FLAGS_3(sske, TCG_CALL_NO_RWG, void, env, i64, i64)
> diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
> index 075ff59..a6aba54 100644
> --- a/target/s390x/insn-data.def
> +++ b/target/s390x/insn-data.def
> @@ -912,6 +912,8 @@
>  /* STORE USING REAL ADDRESS */
>      C(0xb246, STURA,   RRE,   Z,   r1_o, r2_o, 0, 0, stura, 0)
>      C(0xb925, STURG,   RRE,   Z,   r1_o, r2_o, 0, 0, sturg, 0)
> +/* TEST BLOCK */
> +    C(0xb22c, TB,      RRE,   Z,   0, r2_o, 0, 0, testblock, 0)
>  /* TEST PROTECTION */
>      C(0xe501, TPROT,   SSE,   Z,   la1, a2, 0, 0, tprot, 0)
> =20
> diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
> index 675aba2..0349c10 100644
> --- a/target/s390x/mem_helper.c
> +++ b/target/s390x/mem_helper.c
> @@ -933,6 +933,18 @@ void HELPER(stctl)(CPUS390XState *env, uint32_t r1, =
uint64_t a2, uint32_t r3)
>      }
>  }
> =20
> +void HELPER(testblock)(CPUS390XState *env, uint64_t addr)
> +{
> +    CPUState *cs =3D CPU(s390_env_get_cpu(env));
> +    int i;
> +
> +    addr =3D get_address(env, 0, 0, addr) & ~0xfffULL;

I guess you want to use ~TARGET_PAGE_MASK here.

> +    for (i =3D 0; i < TARGET_PAGE_SIZE; i +=3D 8) {
> +        stq_phys(cs->as, addr + i, 0);
> +    }
> +    env->cc_op =3D 0;
> +}
> +

=46rom what I understand the resulting condition code should depends if
the block is usable or not. Shouldn't there be a check to see if the
address actually targets the RAM?

--=20
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
