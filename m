Received: from eggs.gnu.org ([2001:4830:134:3::10]:55789)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cipzy-0006gk-Cm
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 17:11:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cipzv-0003AU-7Z
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 17:11:58 -0500
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:33176)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cipzu-0003AL-W1
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 17:11:55 -0500
Received: by mail-pg0-x241.google.com with SMTP id x17so3174652pgi.0
	for <qemu-devel@nongnu.org>; Tue, 28 Feb 2017 14:11:54 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
References: <41cc9d11-2e28-5b5e-4772-81a118d79111@redhat.com>
	<20170227101817.11748-1-mmarek@suse.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <41e6edc0-204b-62b7-93b8-b376a40542d6@twiddle.net>
Date: Wed, 1 Mar 2017 09:11:47 +1100
MIME-Version: 1.0
In-Reply-To: <20170227101817.11748-1-mmarek@suse.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4] target-s390x: Implement stfl and stfle
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michal Marek <mmarek@suse.com>, Alexander Graf <agraf@suse.de>, Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Miroslav Benes <mbenes@suse.cz>, Eric Bischoff <ebischoff@suse.com>

On 02/27/2017 09:18 PM, Michal Marek wrote:
> Indicate the actual features in the STFL implementation and implement
> STFLE.
>
> Signed-off-by: Michal Marek <mmarek@suse.com>
> ---
> v4:
>  - Remove redundant buffer clearing in do_stfle()
>  - Always store whole doublewords in STFLE
>  - Use s390_cpu_virt_mem_write() to store the result
>  - Raise a specification exception if the STFLE address is not aligned
>  - Use the LowCore offset instead of hardcoding the STFL store address
> v3:
>  - Initialize the buffer in do_stfle()
> v2:
>  - STFLE is not a privileged instruction, go through the MMU to store the
>    result
>  - annotate the stfl helper with TCG_CALL_NO_RWG
>  - Use a large enough buffer to hold the feature bitmap
>  - Fix coding style of the stfle helper
> ---
>  target/s390x/cpu_features.c |  6 ++++--
>  target/s390x/cpu_features.h |  2 +-
>  target/s390x/helper.h       |  2 ++
>  target/s390x/insn-data.def  |  2 ++
>  target/s390x/misc_helper.c  | 38 ++++++++++++++++++++++++++++++++++++++
>  target/s390x/translate.c    | 18 ++++++++++--------
>  6 files changed, 57 insertions(+), 11 deletions(-)
>
> diff --git a/target/s390x/cpu_features.c b/target/s390x/cpu_features.c
> index 42fd9d792bc8..d77c560380c4 100644
> --- a/target/s390x/cpu_features.c
> +++ b/target/s390x/cpu_features.c
> @@ -286,11 +286,11 @@ void s390_init_feat_bitmap(const S390FeatInit init, S390FeatBitmap bitmap)
>      }
>  }
>
> -void s390_fill_feat_block(const S390FeatBitmap features, S390FeatType type,
> +int s390_fill_feat_block(const S390FeatBitmap features, S390FeatType type,
>                            uint8_t *data)
>  {
>      S390Feat feat;
> -    int bit_nr;
> +    int bit_nr, res = 0;
>
>      if (type == S390_FEAT_TYPE_STFL && test_bit(S390_FEAT_ZARCH, features)) {
>          /* z/Architecture is always active if around */
> @@ -303,9 +303,11 @@ void s390_fill_feat_block(const S390FeatBitmap features, S390FeatType type,
>              bit_nr = s390_features[feat].bit;
>              /* big endian on uint8_t array */
>              data[bit_nr / 8] |= 0x80 >> (bit_nr % 8);
> +            res = MAX(res, bit_nr / 8 + 1);
>          }
>          feat = find_next_bit(features, S390_FEAT_MAX, feat + 1);
>      }
> +    return res;
>  }
>
>  void s390_add_from_feat_block(S390FeatBitmap features, S390FeatType type,
> diff --git a/target/s390x/cpu_features.h b/target/s390x/cpu_features.h
> index d66912178680..e3c41be08060 100644
> --- a/target/s390x/cpu_features.h
> +++ b/target/s390x/cpu_features.h
> @@ -56,7 +56,7 @@ typedef uint64_t S390FeatInit[S390_FEAT_MAX / 64 + 1];
>  const S390FeatDef *s390_feat_def(S390Feat feat);
>  S390Feat s390_feat_by_type_and_bit(S390FeatType type, int bit);
>  void s390_init_feat_bitmap(const S390FeatInit init, S390FeatBitmap bitmap);
> -void s390_fill_feat_block(const S390FeatBitmap features, S390FeatType type,
> +int s390_fill_feat_block(const S390FeatBitmap features, S390FeatType type,
>                            uint8_t *data);
>  void s390_add_from_feat_block(S390FeatBitmap features, S390FeatType type,
>                            uint8_t *data);
> diff --git a/target/s390x/helper.h b/target/s390x/helper.h
> index 9102071d0aa4..f24b50ea48ab 100644
> --- a/target/s390x/helper.h
> +++ b/target/s390x/helper.h
> @@ -95,6 +95,8 @@ DEF_HELPER_FLAGS_1(stckc, TCG_CALL_NO_RWG, i64, env)
>  DEF_HELPER_FLAGS_2(spt, TCG_CALL_NO_RWG, void, env, i64)
>  DEF_HELPER_FLAGS_1(stpt, TCG_CALL_NO_RWG, i64, env)
>  DEF_HELPER_4(stsi, i32, env, i64, i64, i64)
> +DEF_HELPER_FLAGS_1(stfl, TCG_CALL_NO_RWG, void, env)
> +DEF_HELPER_4(stfle, i64, env, i64, i32, i64)
>  DEF_HELPER_FLAGS_4(lctl, TCG_CALL_NO_WG, void, env, i32, i64, i32)
>  DEF_HELPER_FLAGS_4(lctlg, TCG_CALL_NO_WG, void, env, i32, i64, i32)
>  DEF_HELPER_FLAGS_4(stctl, TCG_CALL_NO_WG, void, env, i32, i64, i32)
> diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
> index 075ff597c3de..be830a42ed8d 100644
> --- a/target/s390x/insn-data.def
> +++ b/target/s390x/insn-data.def
> @@ -899,6 +899,8 @@
>      C(0xb202, STIDP,   S,     Z,   la2, 0, new, m1_64, stidp, 0)
>  /* STORE CPU TIMER */
>      C(0xb209, STPT,    S,     Z,   la2, 0, new, m1_64, stpt, 0)
> +/* STORE FACILITY LIST EXTENDED */
> +    C(0xb2b0, STFLE,   S,  SFLE,   0, a2, 0, 0, stfle, 0)
>  /* STORE FACILITY LIST */
>      C(0xb2b1, STFL,    S,     Z,   0, 0, 0, 0, stfl, 0)
>  /* STORE PREFIX */
> diff --git a/target/s390x/misc_helper.c b/target/s390x/misc_helper.c
> index c9604ea9c728..2645ff8b1840 100644
> --- a/target/s390x/misc_helper.c
> +++ b/target/s390x/misc_helper.c
> @@ -500,6 +500,44 @@ uint32_t HELPER(stsi)(CPUS390XState *env, uint64_t a0,
>      return cc;
>  }
>
> +static int do_stfle(CPUS390XState *env, uint64_t addr, uint32_t ar, int len)
> +{
> +    S390CPU *cpu = s390_env_get_cpu(env);
> +    /* 256 doublewords as per STFLE documentation */
> +    uint8_t data[256 * 8] = { 0 };
> +    int res;
> +
> +    res = s390_fill_feat_block(cpu->model->features, S390_FEAT_TYPE_STFL, data);
> +    res = ROUND_UP(res, 8);
> +    s390_cpu_virt_mem_write(cpu, addr, ar, data, MIN(res, len));

This does not do what you think it does.  Or indeed, I suspect what the 
original author thinks it does.  I suspect it works for KVM only, and no one 
has actually tried the non-KVM code path.

Primarily, it does not raise an exception for error.  Secondarily, I have no 
idea what the "AR" argument is supposed to be, or how that's supposed to 
interact with the rest of the virtual memory system.

Your writes need to look a lot more like fast_memmove in mem_helper.c, except 
that of course only the destination needs translation.

Of course, in practice we could reduce this to just one cpu_stl_data for STFL 
and one or two cpu_stq_data for STFLE.  So a full fast_memmove loop is overkill.

As it happens, this reminds me that I wrote a version of this several years ago 
but never submitted it upstream.  I'll dig it out.

> +    need = do_stfle(env, addr, ar, len * 8) / 8;

I'm not keen on the scattered divide by 8.  Can we not standardize on bit 
number please, and divide by 64 or 32 when we need?

> +    if (need <= len) {
> +        env->cc_op = 0;
> +    } else {
> +        env->cc_op = 3;
> +    }

Better as env->cc_op = (need <= len ? 0 : 3);


r~
