Received: from eggs.gnu.org ([2001:4830:134:3::10]:41462)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gTlLr-0006vk-Dl
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 05:21:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gTlLn-00023C-F0
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 05:21:19 -0500
References: <20181130192216.26987-1-richard.henderson@linaro.org>
	<20181130192216.26987-3-richard.henderson@linaro.org>
From: David Hildenbrand <david@redhat.com>
Message-ID: <cf30fb27-a5a3-6614-1053-351ffc8555c3@redhat.com>
Date: Mon, 3 Dec 2018 11:21:11 +0100
MIME-Version: 1.0
In-Reply-To: <20181130192216.26987-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-4.0 2/2] target/s390x: Implement STCK
 et al for CONFIG_USER_ONLY
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: cohuck@redhat.com, qemu-s390x@nongnu.org

On 30.11.18 20:22, Richard Henderson wrote:
> This is a non-privileged instruction that was only implemented
> for system mode.  However, the stck instruction is used by glibc,
> so this was causing SIGILL for programs run under debian stretch.
>=20
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/s390x/helper.h      |  2 +-
>  target/s390x/misc_helper.c | 13 ++++++++++++-
>  target/s390x/translate.c   |  2 ++
>  target/s390x/insn-data.def | 11 ++++++-----
>  4 files changed, 21 insertions(+), 7 deletions(-)
>=20
> diff --git a/target/s390x/helper.h b/target/s390x/helper.h
> index 018e9dd414..6260b50496 100644
> --- a/target/s390x/helper.h
> +++ b/target/s390x/helper.h
> @@ -121,13 +121,13 @@ DEF_HELPER_4(cu41, i32, env, i32, i32, i32)
>  DEF_HELPER_4(cu42, i32, env, i32, i32, i32)
>  DEF_HELPER_5(msa, i32, env, i32, i32, i32, i32)
>  DEF_HELPER_FLAGS_1(stpt, TCG_CALL_NO_RWG, i64, env)
> +DEF_HELPER_FLAGS_1(stck, TCG_CALL_NO_RWG_SE, i64, env)
> =20
>  #ifndef CONFIG_USER_ONLY
>  DEF_HELPER_3(servc, i32, env, i64, i64)
>  DEF_HELPER_4(diag, void, env, i32, i32, i32)
>  DEF_HELPER_3(load_psw, noreturn, env, i64, i64)
>  DEF_HELPER_FLAGS_2(spx, TCG_CALL_NO_RWG, void, env, i64)
> -DEF_HELPER_FLAGS_1(stck, TCG_CALL_NO_RWG_SE, i64, env)
>  DEF_HELPER_FLAGS_2(sck, TCG_CALL_NO_RWG, i32, env, i64)
>  DEF_HELPER_FLAGS_2(sckc, TCG_CALL_NO_RWG, void, env, i64)
>  DEF_HELPER_FLAGS_2(sckpf, TCG_CALL_NO_RWG, void, env, i64)
> diff --git a/target/s390x/misc_helper.c b/target/s390x/misc_helper.c
> index 3f91579570..c2940afecb 100644
> --- a/target/s390x/misc_helper.c
> +++ b/target/s390x/misc_helper.c
> @@ -76,8 +76,19 @@ uint64_t HELPER(stpt)(CPUS390XState *env)
>  #endif
>  }
> =20
> -#ifndef CONFIG_USER_ONLY
> +#ifdef CONFIG_USER_ONLY
> +/* Store Clock */
> +uint64_t HELPER(stck)(CPUS390XState *env)
> +{
> +    struct timespec ts;
> +    uint64_t ms;
> =20
> +    clock_gettime(CLOCK_REALTIME, &ts);
> +    ms =3D (ts.tv_nsec / 1000) + (ts.tv_sec * 100000ull);
> +
> +    return TOD_UNIX_EPOCH + ms;

In theory, the TOD can be completely controlled by the operating system
(e.g. set the TOD to X). So for user space, there isn't really any
guarantee about the values returned via stck.

E.g. in the PoP 4-51:

"4. A program using the clock value as a time-of-day
and calendar indication must be consistent with
the programming support under which the pro-
gram is to be executed. [...]"

Of course, in an ideal world, the system TOD value really corresponds to
the reference TOD. So I assume, in theory, we can simply indicate any
monotonic values here. E.g. not using TOD_UNIX_EPOCH and only forwarding
the result from CLOCK_REALTIME converted to appropriate TOD values.

If I am not wrong, under Linux, user space will only use stck for
measurement, and use the vdso for getting the real time.


--=20

Thanks,

David / dhildenb
