Received: from eggs.gnu.org ([2001:4830:134:3::10]:55086)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cizBt-0004LM-In
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 03:00:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cizBq-000873-FI
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 03:00:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38506)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1cizBq-00086s-7H
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 03:00:50 -0500
References: <41cc9d11-2e28-5b5e-4772-81a118d79111@redhat.com>
	<20170227101817.11748-1-mmarek@suse.com>
	<41e6edc0-204b-62b7-93b8-b376a40542d6@twiddle.net>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <bf246870-6e7c-f540-7cd4-3a20d5912162@redhat.com>
Date: Wed, 1 Mar 2017 09:00:46 +0100
MIME-Version: 1.0
In-Reply-To: <41e6edc0-204b-62b7-93b8-b376a40542d6@twiddle.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4] target-s390x: Implement stfl and stfle
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>, Michal Marek <mmarek@suse.com>, Alexander Graf <agraf@suse.de>
Cc: qemu-devel@nongnu.org, Miroslav Benes <mbenes@suse.cz>, Eric Bischoff <ebischoff@suse.com>

On 28.02.2017 23:11, Richard Henderson wrote:
> On 02/27/2017 09:18 PM, Michal Marek wrote:
>> Indicate the actual features in the STFL implementation and implement
>> STFLE.
>>
>> Signed-off-by: Michal Marek <mmarek@suse.com>
>> ---
>> v4:
>>  - Remove redundant buffer clearing in do_stfle()
>>  - Always store whole doublewords in STFLE
>>  - Use s390_cpu_virt_mem_write() to store the result
>>  - Raise a specification exception if the STFLE address is not aligned
>>  - Use the LowCore offset instead of hardcoding the STFL store address
>> v3:
>>  - Initialize the buffer in do_stfle()
>> v2:
>>  - STFLE is not a privileged instruction, go through the MMU to store =
the
>>    result
>>  - annotate the stfl helper with TCG_CALL_NO_RWG
>>  - Use a large enough buffer to hold the feature bitmap
>>  - Fix coding style of the stfle helper
>> ---
>>  target/s390x/cpu_features.c |  6 ++++--
>>  target/s390x/cpu_features.h |  2 +-
>>  target/s390x/helper.h       |  2 ++
>>  target/s390x/insn-data.def  |  2 ++
>>  target/s390x/misc_helper.c  | 38 ++++++++++++++++++++++++++++++++++++=
++
>>  target/s390x/translate.c    | 18 ++++++++++--------
>>  6 files changed, 57 insertions(+), 11 deletions(-)
>>
>> diff --git a/target/s390x/cpu_features.c b/target/s390x/cpu_features.c
>> index 42fd9d792bc8..d77c560380c4 100644
>> --- a/target/s390x/cpu_features.c
>> +++ b/target/s390x/cpu_features.c
>> @@ -286,11 +286,11 @@ void s390_init_feat_bitmap(const S390FeatInit
>> init, S390FeatBitmap bitmap)
>>      }
>>  }
>>
>> -void s390_fill_feat_block(const S390FeatBitmap features, S390FeatType
>> type,
>> +int s390_fill_feat_block(const S390FeatBitmap features, S390FeatType
>> type,
>>                            uint8_t *data)
>>  {
>>      S390Feat feat;
>> -    int bit_nr;
>> +    int bit_nr, res =3D 0;
>>
>>      if (type =3D=3D S390_FEAT_TYPE_STFL && test_bit(S390_FEAT_ZARCH,
>> features)) {
>>          /* z/Architecture is always active if around */
>> @@ -303,9 +303,11 @@ void s390_fill_feat_block(const S390FeatBitmap
>> features, S390FeatType type,
>>              bit_nr =3D s390_features[feat].bit;
>>              /* big endian on uint8_t array */
>>              data[bit_nr / 8] |=3D 0x80 >> (bit_nr % 8);
>> +            res =3D MAX(res, bit_nr / 8 + 1);
>>          }
>>          feat =3D find_next_bit(features, S390_FEAT_MAX, feat + 1);
>>      }
>> +    return res;
>>  }
>>
>>  void s390_add_from_feat_block(S390FeatBitmap features, S390FeatType
>> type,
>> diff --git a/target/s390x/cpu_features.h b/target/s390x/cpu_features.h
>> index d66912178680..e3c41be08060 100644
>> --- a/target/s390x/cpu_features.h
>> +++ b/target/s390x/cpu_features.h
>> @@ -56,7 +56,7 @@ typedef uint64_t S390FeatInit[S390_FEAT_MAX / 64 + 1=
];
>>  const S390FeatDef *s390_feat_def(S390Feat feat);
>>  S390Feat s390_feat_by_type_and_bit(S390FeatType type, int bit);
>>  void s390_init_feat_bitmap(const S390FeatInit init, S390FeatBitmap
>> bitmap);
>> -void s390_fill_feat_block(const S390FeatBitmap features, S390FeatType
>> type,
>> +int s390_fill_feat_block(const S390FeatBitmap features, S390FeatType
>> type,
>>                            uint8_t *data);
>>  void s390_add_from_feat_block(S390FeatBitmap features, S390FeatType
>> type,
>>                            uint8_t *data);
>> diff --git a/target/s390x/helper.h b/target/s390x/helper.h
>> index 9102071d0aa4..f24b50ea48ab 100644
>> --- a/target/s390x/helper.h
>> +++ b/target/s390x/helper.h
>> @@ -95,6 +95,8 @@ DEF_HELPER_FLAGS_1(stckc, TCG_CALL_NO_RWG, i64, env)
>>  DEF_HELPER_FLAGS_2(spt, TCG_CALL_NO_RWG, void, env, i64)
>>  DEF_HELPER_FLAGS_1(stpt, TCG_CALL_NO_RWG, i64, env)
>>  DEF_HELPER_4(stsi, i32, env, i64, i64, i64)
>> +DEF_HELPER_FLAGS_1(stfl, TCG_CALL_NO_RWG, void, env)
>> +DEF_HELPER_4(stfle, i64, env, i64, i32, i64)
>>  DEF_HELPER_FLAGS_4(lctl, TCG_CALL_NO_WG, void, env, i32, i64, i32)
>>  DEF_HELPER_FLAGS_4(lctlg, TCG_CALL_NO_WG, void, env, i32, i64, i32)
>>  DEF_HELPER_FLAGS_4(stctl, TCG_CALL_NO_WG, void, env, i32, i64, i32)
>> diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
>> index 075ff597c3de..be830a42ed8d 100644
>> --- a/target/s390x/insn-data.def
>> +++ b/target/s390x/insn-data.def
>> @@ -899,6 +899,8 @@
>>      C(0xb202, STIDP,   S,     Z,   la2, 0, new, m1_64, stidp, 0)
>>  /* STORE CPU TIMER */
>>      C(0xb209, STPT,    S,     Z,   la2, 0, new, m1_64, stpt, 0)
>> +/* STORE FACILITY LIST EXTENDED */
>> +    C(0xb2b0, STFLE,   S,  SFLE,   0, a2, 0, 0, stfle, 0)
>>  /* STORE FACILITY LIST */
>>      C(0xb2b1, STFL,    S,     Z,   0, 0, 0, 0, stfl, 0)
>>  /* STORE PREFIX */
>> diff --git a/target/s390x/misc_helper.c b/target/s390x/misc_helper.c
>> index c9604ea9c728..2645ff8b1840 100644
>> --- a/target/s390x/misc_helper.c
>> +++ b/target/s390x/misc_helper.c
>> @@ -500,6 +500,44 @@ uint32_t HELPER(stsi)(CPUS390XState *env,
>> uint64_t a0,
>>      return cc;
>>  }
>>
>> +static int do_stfle(CPUS390XState *env, uint64_t addr, uint32_t ar,
>> int len)
>> +{
>> +    S390CPU *cpu =3D s390_env_get_cpu(env);
>> +    /* 256 doublewords as per STFLE documentation */
>> +    uint8_t data[256 * 8] =3D { 0 };
>> +    int res;
>> +
>> +    res =3D s390_fill_feat_block(cpu->model->features,
>> S390_FEAT_TYPE_STFL, data);
>> +    res =3D ROUND_UP(res, 8);
>> +    s390_cpu_virt_mem_write(cpu, addr, ar, data, MIN(res, len));
>=20
> This does not do what you think it does.  Or indeed, I suspect what the
> original author thinks it does.  I suspect it works for KVM only, and n=
o
> one has actually tried the non-KVM code path.

It should work fine TCG, too. At least it used to work fine with TCG
when I put that stuff together two years ago. The function only uses the
KVM_S390_MEM_OP if KVM is enabled, and uses mmu_translate() internally
to walk the MMU pages otherwise.

> Primarily, it does not raise an exception for error.

Protection and page faults should be generated properly via
trigger_access_exception() there ... or did I miss something?

> Secondarily, I
> have no idea what the "AR" argument is supposed to be, or how that's
> supposed to interact with the rest of the virtual memory system.

AR =3D Access Register ... they are needed when the CPU runs in access
register mode (i.e. the AS PSW bits are 01). AFAIK we don't emulate this
in QEMU yet, but the KVM_S390_MEM_OP ioctl already supports it.

> Your writes need to look a lot more like fast_memmove in mem_helper.c,
> except that of course only the destination needs translation.

I still think that s390_cpu_virt_mem_write() should be fine here, too.

> Of course, in practice we could reduce this to just one cpu_stl_data fo=
r
> STFL and one or two cpu_stq_data for STFLE.

I think STFLE can store more than two 64-bit words, can't it?

 Thomas
